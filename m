Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A60C72F9D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbjFNJyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 05:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjFNJyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:54:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2752A1;
        Wed, 14 Jun 2023 02:54:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27D441FDDF;
        Wed, 14 Jun 2023 09:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686736446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nh8YqqVlBf+FDF91saTLLR9MR+nYMo3Ypt2F6lReKwY=;
        b=14RTRupxayqjdgHjGVT2uHnKYkFX/E2gmugS6gBp3FOxAQJb3fLWrcpgxxpuXAuT1RyzBh
        tqPFUo9fyQQSI4hr67pnoPUVaS8tvK2fgVAQDo3YTf5/Y/gksoYK8q0xYogJpd9f4EAPup
        izVD52mKecOZn3jp7T2cNfAKGiqTcWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686736446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nh8YqqVlBf+FDF91saTLLR9MR+nYMo3Ypt2F6lReKwY=;
        b=cdvN2qUeznVq613WvPv8T68zL+y/57cwQ19GkflCRoU0umROtqVTXoyIohcxErx6W3Hqme
        +g3frd2NmRz3FnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18E2B1391E;
        Wed, 14 Jun 2023 09:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RoMJBj6OiWQpaAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Jun 2023 09:54:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B9C8A0755; Wed, 14 Jun 2023 11:54:05 +0200 (CEST)
Date:   Wed, 14 Jun 2023 11:54:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ovl: enable fsnotify events on underlying real
 files
Message-ID: <20230614095405.e22qzktue4igcula@quack3>
References: <20230614074907.1943007-1-amir73il@gmail.com>
 <20230614074907.1943007-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614074907.1943007-3-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-06-23 10:49:07, Amir Goldstein wrote:
> Overlayfs creates the real underlying files with fake f_path, whose
> f_inode is on the underlying fs and f_path on overlayfs.
> 
> Those real files were open with FMODE_NONOTIFY, because fsnotify code was
> not prapared to handle fsnotify hooks on files with fake path correctly
> and fanotify would report unexpected event->fd with fake overlayfs path,
> when the underlying fs was being watched.
> 
> Teach fsnotify to handle events on the real files, and do not set real
> files to FMODE_NONOTIFY to allow operations on real file (e.g. open,
> access, modify, close) to generate async and permission events.
> 
> Because fsnotify does not have notifications on address space
> operations, we do not need to worry about ->vm_file not reporting
> events to a watched overlayfs when users are accessing a mapped
> overlayfs file.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/overlayfs/file.c      | 4 ++--
>  include/linux/fsnotify.h | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 8cf099aa97de..1fdfc53f1207 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -34,8 +34,8 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
>  		return 'm';
>  }
>  
> -/* No atime modification nor notify on underlying */
> -#define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
> +/* No atime modification on underlying */
> +#define OVL_OPEN_FLAGS (O_NOATIME)
>  
>  static struct file *ovl_open_realfile(const struct file *file,
>  				      const struct path *realpath)
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index bb8467cd11ae..6f6cbc2dc49b 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -91,7 +91,8 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
>  
>  static inline int fsnotify_file(struct file *file, __u32 mask)
>  {
> -	const struct path *path = &file->f_path;
> +	/* Overlayfs internal files have fake f_path */
> +	const struct path *path = f_real_path(file);
>  
>  	if (file->f_mode & FMODE_NONOTIFY)
>  		return 0;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
