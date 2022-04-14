Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB6500CB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 14:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiDNMEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiDNMEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4FB1DF;
        Thu, 14 Apr 2022 05:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7BF761C41;
        Thu, 14 Apr 2022 12:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53906C385A1;
        Thu, 14 Apr 2022 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649937742;
        bh=qXt7WvSa23a3YeOZ9+ww8g01bRmkBlm1Ss5n2duByN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAog4BNMoH1vMP41Cot6uxE2DcprJtZa/J4JtOrb9Ssa/KeJMhnP+irLqwwnZEzN9
         Yg5th0iSlgLS0EtVCw5i26+IRWPnW6SNMMuS/eIHY5sDzq0aZYiRaaGaInnozitSyZ
         xPPLzgtj5OyGQIdz6hu8g0WRZ3gnm0vOfCpMzn9+ViUkwrfsoFgiuHRf29mVkYYr/E
         BfEe2N+7FkzqzxWUy3WFGWPjuq31sKEgC7WrZ/taBZbd+DIW0Y05qg8gkOCh3C/Tr8
         T2ihpqIALXzjcXAxbXPpL6zGaAu4tcUrdnyrnrz8Ti1l/fLDWf9KiFaKAprFuK8ZOI
         Z4vlm22CNHvgg==
Date:   Thu, 14 Apr 2022 14:02:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, viro@zeniv.linux.org.uk,
        david@fromorbit.com, djwong@kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v2 1/3] vfs: Add inode_sgid_strip() api
Message-ID: <20220414120217.fbsljr7alpvy5nmy@wittgenstein>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:57:17PM +0800, Yang Xu wrote:
> inode_sgid_strip() function is used to strip S_ISGID mode
> when creat/open/mknod file.
> 
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/inode.c         | 18 ++++++++++++++++++
>  include/linux/fs.h |  3 ++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..d63264998855 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2405,3 +2405,21 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +
> +void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
> +		      umode_t *mode)
> +{
> +	if (!dir || !(dir->i_mode & S_ISGID))
> +		return;
> +	if ((*mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
> +		return;
> +	if (S_ISDIR(*mode))
> +		return;
> +	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
> +		return;
> +	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> +		return;
> +
> +	*mode &= ~S_ISGID;
> +}
> +EXPORT_SYMBOL(inode_sgid_strip);


I still think this should return umode_t with the setgid bit stripped
instead of modifying the mode directly. I may have misunderstood Dave,
but I thought he preferred to return umode_t too?

umode_t inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir, umode_t mode)
{
	if (S_ISDIR(mode))
		return mode;

	if (!dir || !(dir->i_mode & S_ISGID))
		return;

	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
		return;

	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
		return;

	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
		return;

	return mode & ~S_ISGID;
}
