Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2168E7123ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjEZJpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEZJpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB115B3;
        Fri, 26 May 2023 02:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B6F64E93;
        Fri, 26 May 2023 09:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F78CC433EF;
        Fri, 26 May 2023 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685094321;
        bh=6757u1vv3qshvT3KML6a5/JeJbMP77tgbtC+voZYxM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xit6rovGa1EEW81ZgpfaqNZHoUIw5HguySJ17Cp/3hX/NBNlh7jaa1cllWG2iirET
         8v8OyP2+bIXqFTB3fsUEY1VBIgMGeEu2nqemQIOXTQ8Kx9tdMUs1oXJaYc9dr8T9nL
         so0FIOgiJK+d3KseP1t373HUh0NxXheGkUqLb68U7mM4JIAby9t9oS6pI8438c/DSa
         7WLuGXVk5VzdxgQC/ybMoa8F8JOUh8+IjbcF5sA1Rx1sNATtns9Khfau7r0SRc4ahp
         ZydAbOSB4xf7KBz2DMlBM4Hw1+RI+zWuwQxMj0kAqXo82MAEOA/VoQRJnmuFr7KRET
         g9JugSYtsWCyg==
Date:   Fri, 26 May 2023 11:45:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4/6] fs: Establish locking order for unrelated directories
Message-ID: <20230526-polarstern-herrichten-32fc46c63bfc@brauner>
References: <20230525100654.15069-1-jack@suse.cz>
 <20230525101624.15814-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525101624.15814-4-jack@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 12:16:10PM +0200, Jan Kara wrote:
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
>  fs/inode.c    | 34 ++++++++++++++++++++++++++++++++++
>  fs/internal.h |  2 ++
>  fs/namei.c    |  4 ++--
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 577799b7855f..2015fa50d34a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1103,6 +1103,40 @@ void discard_new_inode(struct inode *inode)
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
> +		goto lock;

Before this change in

lock_two_nondirectories(struct inode *inode1, struct inode *inode2)

the swap() would cause the non-NULL inode to always be locked with
I_MUTEX_NONDIR2. Now it can be either I_MUTEX_NORMAL or I_MUTEX_NONDIR2.
Is that change intentional?
