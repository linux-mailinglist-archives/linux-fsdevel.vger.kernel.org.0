Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B37719EF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjFAN7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 09:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFAN7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F523FC;
        Thu,  1 Jun 2023 06:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B53A617EA;
        Thu,  1 Jun 2023 13:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA843C433D2;
        Thu,  1 Jun 2023 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685627944;
        bh=hrvO0WffTuYX0l8xl6Ve6qY34By3qmMdYk7DH/2LqV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSKNSdL1EwbgZ3EVAsPXSCUcGmPXrtGiZ7K/mcXuispwQXsqu4hHi1HU0/cfChTLi
         FQHMIEttwLeBHGVThYBwKqodAMzYKLybFe/dsKnlmr8pUS8XikF8TzqxZ4WLw/4vd2
         Bu7Ra/G6Fr0QhIZ+J7sOiFYzuSObtGZ+4gKtaCoW1oyIaUGmHuR7vvQeb3pqdyxNuL
         WOG2hgBVDtBfNi2JCBHf8fNlyZmgqz4zF1H/e+Dw9ghxjjnWNs7roFT4qRlFRoQXGy
         SC+pdwA/NUF6kJm0TcyB2A6vZJnbbT+waoLD1pNjxbIIIkcg7KXeRvZguOFip43Qhq
         Usx4NRM/X1d6Q==
Date:   Thu, 1 Jun 2023 15:58:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Message-ID: <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601105830.13168-4-jack@suse.cz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 12:58:24PM +0200, Jan Kara wrote:
> Currently the locking order of inode locks for directories that are not
> in ancestor relationship is not defined because all operations that
> needed to lock two directories like this were serialized by
> sb->s_vfs_rename_mutex. However some filesystems need to lock two
> subdirectories for RENAME_EXCHANGE operations and for this we need the
> locking order established even for two tree-unrelated directories.
> Provide a helper function lock_two_inodes() that establishes lock
> ordering for any two inodes and use it in lock_two_directories().
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/inode.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
>  fs/internal.h |  2 ++
>  fs/namei.c    |  4 ++--
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 577799b7855f..4000ab08bbc0 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1103,6 +1103,48 @@ void discard_new_inode(struct inode *inode)
>  }
>  EXPORT_SYMBOL(discard_new_inode);
>  
> +/**
> + * lock_two_inodes - lock two inodes (may be regular files but also dirs)
> + *
> + * Lock any non-NULL argument. The caller must make sure that if he is passing
> + * in two directories, one is not ancestor of the other.  Zero, one or two
> + * objects may be locked by this function.
> + *
> + * @inode1: first inode to lock
> + * @inode2: second inode to lock
> + * @subclass1: inode lock subclass for the first lock obtained
> + * @subclass2: inode lock subclass for the second lock obtained
> + */
> +void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> +		     unsigned subclass1, unsigned subclass2)
> +{
> +	if (!inode1 || !inode2)

I think you forgot the opening bracket...
I can just fix this up for you though.

> +		/*
> +		 * Make sure @subclass1 will be used for the acquired lock.
> +		 * This is not strictly necessary (no current caller cares) but
> +		 * let's keep things consistent.
> +		 */
> +		if (!inode1)
> +			swap(inode1, inode2);
> +		goto lock;
> +	}
