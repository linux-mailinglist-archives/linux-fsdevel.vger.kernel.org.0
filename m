Return-Path: <linux-fsdevel+bounces-3596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0387F6B72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7AFB20CA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B8B671;
	Fri, 24 Nov 2023 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67CD10DB;
	Thu, 23 Nov 2023 20:33:19 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD4681FCE1;
	Thu, 23 Nov 2023 14:48:12 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A2B513AB6;
	Thu, 23 Nov 2023 12:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id I9YGCglEX2VMaAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 12:22:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B31FA07E2; Thu, 23 Nov 2023 10:53:03 +0100 (CET)
Date: Thu, 23 Nov 2023 10:53:03 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] kill lock_two_inodes()
Message-ID: <20231123095303.klmdrsi2yw3mv7zc@quack3>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
 <20231122193652.419091-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122193652.419091-8-viro@zeniv.linux.org.uk>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DD4681FCE1

On Wed 22-11-23 19:36:51, Al Viro wrote:
> There's only one caller left (lock_two_nondirectories()), and it
> needs less complexity.  Fold lock_two_inodes() in there and
> simplify.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c    | 49 ++++++-------------------------------------------
>  fs/internal.h |  2 --
>  2 files changed, 6 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index edcd8a61975f..453d5be1a014 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1087,48 +1087,6 @@ void discard_new_inode(struct inode *inode)
>  }
>  EXPORT_SYMBOL(discard_new_inode);
>  
> -/**
> - * lock_two_inodes - lock two inodes (may be regular files but also dirs)
> - *
> - * Lock any non-NULL argument. The caller must make sure that if he is passing
> - * in two directories, one is not ancestor of the other.  Zero, one or two
> - * objects may be locked by this function.
> - *
> - * @inode1: first inode to lock
> - * @inode2: second inode to lock
> - * @subclass1: inode lock subclass for the first lock obtained
> - * @subclass2: inode lock subclass for the second lock obtained
> - */
> -void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> -		     unsigned subclass1, unsigned subclass2)
> -{
> -	if (!inode1 || !inode2) {
> -		/*
> -		 * Make sure @subclass1 will be used for the acquired lock.
> -		 * This is not strictly necessary (no current caller cares) but
> -		 * let's keep things consistent.
> -		 */
> -		if (!inode1)
> -			swap(inode1, inode2);
> -		goto lock;
> -	}
> -
> -	/*
> -	 * If one object is directory and the other is not, we must make sure
> -	 * to lock directory first as the other object may be its child.
> -	 */
> -	if (S_ISDIR(inode2->i_mode) == S_ISDIR(inode1->i_mode)) {
> -		if (inode1 > inode2)
> -			swap(inode1, inode2);
> -	} else if (!S_ISDIR(inode1->i_mode))
> -		swap(inode1, inode2);
> -lock:
> -	if (inode1)
> -		inode_lock_nested(inode1, subclass1);
> -	if (inode2 && inode2 != inode1)
> -		inode_lock_nested(inode2, subclass2);
> -}
> -
>  /**
>   * lock_two_nondirectories - take two i_mutexes on non-directory objects
>   *
> @@ -1144,7 +1102,12 @@ void lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
>  		WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
>  	if (inode2)
>  		WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
> -	lock_two_inodes(inode1, inode2, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
> +	if (inode1 > inode2)
> +		swap(inode1, inode2);
> +	if (inode1)
> +		inode_lock(inode1);
> +	if (inode2 && inode2 != inode1)
> +		inode_lock_nested(inode2, I_MUTEX_NONDIR2);
>  }
>  EXPORT_SYMBOL(lock_two_nondirectories);
>  
> diff --git a/fs/internal.h b/fs/internal.h
> index 58e43341aebf..de67b02226e5 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -196,8 +196,6 @@ extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
>  int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
>  bool in_group_or_capable(struct mnt_idmap *idmap,
>  			 const struct inode *inode, vfsgid_t vfsgid);
> -void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> -		     unsigned subclass1, unsigned subclass2);
>  
>  /*
>   * fs-writeback.c
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

