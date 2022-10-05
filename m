Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13005F5BB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJEV3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJEV3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:29:07 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A69128284D
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 14:29:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1D2371101E00;
        Thu,  6 Oct 2022 08:28:53 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ogBwh-00G4n3-TV; Thu, 06 Oct 2022 08:28:51 +1100
Date:   Thu, 6 Oct 2022 08:28:51 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] attr: use consistent sgid stripping checks
Message-ID: <20221005212851.GB2703033@dread.disaster.area>
References: <20221005151433.898175-1-brauner@kernel.org>
 <20221005151433.898175-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005151433.898175-2-brauner@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=633df718
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=Qawa6l4ZSaYA:10 a=7-415B0cAAAA:8
        a=2WsWvY6D06ulCoi5GQoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 05:14:31PM +0200, Christian Brauner wrote:
> diff --git a/fs/inode.c b/fs/inode.c
> index ba1de23c13c1..4f3257f5ed7a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1949,26 +1949,44 @@ void touch_atime(const struct path *path)
>  }
>  EXPORT_SYMBOL(touch_atime);
>  
> -/*
> - * The logic we want is
> +/**
> + * should_remove_sgid - determine whether the setgid bit needs to be removed
> + * @mnt_userns:	User namespace of the mount the inode was created from
> + * @inode: inode to check
> + *
> + * This function determines whether the setgid bit needs to be removed.
> + * We retain backwards compatibility where we require the setgid bit to be
> + * removed unconditionally if S_IXGRP is set. Otherwise we have the exact same
> + * requirements as setattr_prepare() and setattr_copy().
>   *
> - *	if suid or (sgid and xgrp)
> - *		remove privs
> + * Return: true if setgit bit needs to be removed, false otherwise.
>   */
> -int should_remove_suid(struct dentry *dentry)
> +static bool should_remove_sgid(struct user_namespace *mnt_userns,
> +			       struct inode *inode)
> +{
> +	umode_t mode = inode->i_mode;
> +
> +	if (unlikely(mode & S_ISGID)) {
> +		if ((mode & S_IXGRP) ||
> +		    (!vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)) &&
> +		     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID)))
> +			return true;
> +	}
> +
> +	return false;

I find this sort of convoluted logic much easier to follow when it's
written as a stacked set of single comparisons like so:

	if (!(mode & S_ISGID))
		return false;
	if (mode & S_IXGRP)
		return true;
	if (vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode))
		return false;
	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID)
		return false;
	return true;

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
