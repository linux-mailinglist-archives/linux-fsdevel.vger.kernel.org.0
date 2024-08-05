Return-Path: <linux-fsdevel+bounces-25024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1D947E16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722862814DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06391552E1;
	Mon,  5 Aug 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SaA6MSXk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1sk61Lg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xUdLg+Jp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hT8TBwNl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62C2AEF5;
	Mon,  5 Aug 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871825; cv=none; b=YlaiqWMUSqxiLdtgsjMuThQxCDsE9M9N6q025gogpm44uAOwx+Kdz1v2qshHm8gyz3M1djHxCsv1lW82t+RKPtNamDSJzr+SBdBouY3xvXaIYfv6j6nngdDJk9BzYRununPfNpVV1n7WXItdxxHOM7/LKdol7Zh9LzrZrt9FGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871825; c=relaxed/simple;
	bh=P53FcLV3aV/rW8X++Tj7e/Jskpkx55+c2TY91HdrKIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN7rkf7lFfU+xHiEXTJSV4V206RkKXcoLhkW/5+qiEqsmlxhfDs/glsf3Dhv47yW1sCSTddf/QrQdM81mj7LUV9RHkJ6lYM/f4MFU+8D7s8jqAUTFfB3aHxM+Irtyo1H8VNRdJ99Jgizhc10kActVstUNjrP8/M9b5Xd1rR1n+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SaA6MSXk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1sk61Lg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xUdLg+Jp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hT8TBwNl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9001E1F7E8;
	Mon,  5 Aug 2024 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722871821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63tHi1ufrCqU6aXrDGsdg5HEdJeV4Q3bSuuCaUhptM=;
	b=SaA6MSXkxaypD9iSpEteM6aCNQEMBiFRM0X7q0LF9cMscQY4uKpaljLTAnWQ+Du4m8n818
	iw6NrDhQxumz905Yob69dd/Z96u0jx1R/NAj8Xz/PmiWIBZWxTbQbQIRvp3xpmjOu7t7bl
	oPw07hUecOoMg+iFFr/funBrgcBHgHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722871821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63tHi1ufrCqU6aXrDGsdg5HEdJeV4Q3bSuuCaUhptM=;
	b=S1sk61Lgj5/WxaLe9T8U5AD9XZGdnbR8UgpsmyrWTBjVdap6t5x1HWSuTsUYv7/pcFzkB5
	JhY8q+n4QlYUk1Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722871819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63tHi1ufrCqU6aXrDGsdg5HEdJeV4Q3bSuuCaUhptM=;
	b=xUdLg+JpggbGIlIrTfoeMMSJc70x8RmGtNvxW5Bd4y0G9Jnz3qdKXdTIOQ5rW5wlgY4B7y
	uwtWxXTNp+ni9Fn5Km79EV7rXpJ2lPFJeLjZDwtKjyAkKxsHrieYUrhKl23eYo32q4aWy2
	nacoscMNhLPPE5uOjG3j10VlP5dbtkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722871819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63tHi1ufrCqU6aXrDGsdg5HEdJeV4Q3bSuuCaUhptM=;
	b=hT8TBwNlkAXgd9sPNM9I/YQq/pAa1VuCwACGONEK8P4qdqcw5vTDcDQkNj0/diFMHKvaEo
	d+xwevl1t4gODVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EC9313ACF;
	Mon,  5 Aug 2024 15:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LwnwHgvwsGZTYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 15:30:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D395BA0897; Mon,  5 Aug 2024 17:30:18 +0200 (CEST)
Date: Mon, 5 Aug 2024 17:30:18 +0200
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tahsin@google.com,
	mjguzik@gmail.com, error27@gmail.com, tytso@mit.edu,
	rydercoding@hotmail.com, jack@suse.cz, hch@infradead.org,
	andreas.dilger@intel.com, richard@nod.at,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	wangzhaolong1@huawei.com
Subject: Re: [PATCH] vfs: Don't evict inode under the inode lru traversing
 context
Message-ID: <20240805153018.3sju3nowiqggykvf@quack3>
References: <20240805013446.814357-1-chengzhihao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805013446.814357-1-chengzhihao@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,google.com,gmail.com,mit.edu,hotmail.com,suse.cz,infradead.org,intel.com,nod.at,vger.kernel.org,lists.infradead.org,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Mon 05-08-24 09:34:46, Zhihao Cheng wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> The inode reclaiming process(See function prune_icache_sb) collects all
> reclaimable inodes and mark them with I_FREEING flag at first, at that
> time, other processes will be stuck if they try getting these inodes
> (See function find_inode_fast), then the reclaiming process destroy the
> inodes by function dispose_list(). Some filesystems(eg. ext4 with
> ea_inode feature, ubifs with xattr) may do inode lookup in the inode
> evicting callback function, if the inode lookup is operated under the
> inode lru traversing context, deadlock problems may happen.
> 
> Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
>         if ea_inode feature is enabled, the lookup process will be stuck
> 	under the evicting context like this:
> 
>  1. File A has inode i_reg and an ea inode i_ea
>  2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
>  3. Then, following three processes running like this:
> 
>     PA                              PB
>  echo 2 > /proc/sys/vm/drop_caches
>   shrink_slab
>    prune_dcache_sb
>    // i_reg is added into lru, lru->i_ea->i_reg
>    prune_icache_sb
>     list_lru_walk_one
>      inode_lru_isolate
>       i_ea->i_state |= I_FREEING // set inode state
>      inode_lru_isolate
>       __iget(i_reg)
>       spin_unlock(&i_reg->i_lock)
>       spin_unlock(lru_lock)
>                                      rm file A
>                                       i_reg->nlink = 0
>       iput(i_reg) // i_reg->nlink is 0, do evict
>        ext4_evict_inode
>         ext4_xattr_delete_inode
>          ext4_xattr_inode_dec_ref_all
>           ext4_xattr_inode_iget
>            ext4_iget(i_ea->i_ino)
>             iget_locked
>              find_inode_fast
>               __wait_on_freeing_inode(i_ea) ----→ AA deadlock
>     dispose_list // cannot be executed by prune_icache_sb
>      wake_up_bit(&i_ea->i_state)
> 
> Case 2: In deleted inode writing function ubifs_jnl_write_inode(), file
>         deleting process holds BASEHD's wbuf->io_mutex while getting the
> 	xattr inode, which could race with inode reclaiming process(The
>         reclaiming process could try locking BASEHD's wbuf->io_mutex in
> 	inode evicting function), then an ABBA deadlock problem would
> 	happen as following:
> 
>  1. File A has inode ia and a xattr(with inode ixa), regular file B has
>     inode ib and a xattr.
>  2. getfattr(A, xattr_buf) // ixa is added into lru // lru->ixa
>  3. Then, following three processes running like this:
> 
>         PA                PB                        PC
>                 echo 2 > /proc/sys/vm/drop_caches
>                  shrink_slab
>                   prune_dcache_sb
>                   // ib and ia are added into lru, lru->ixa->ib->ia
>                   prune_icache_sb
>                    list_lru_walk_one
>                     inode_lru_isolate
>                      ixa->i_state |= I_FREEING // set inode state
>                     inode_lru_isolate
>                      __iget(ib)
>                      spin_unlock(&ib->i_lock)
>                      spin_unlock(lru_lock)
>                                                    rm file B
>                                                     ib->nlink = 0
>  rm file A
>   iput(ia)
>    ubifs_evict_inode(ia)
>     ubifs_jnl_delete_inode(ia)
>      ubifs_jnl_write_inode(ia)
>       make_reservation(BASEHD) // Lock wbuf->io_mutex
>       ubifs_iget(ixa->i_ino)
>        iget_locked
>         find_inode_fast
>          __wait_on_freeing_inode(ixa)
>           |          iput(ib) // ib->nlink is 0, do evict
>           |           ubifs_evict_inode
>           |            ubifs_jnl_delete_inode(ib)
>           ↓             ubifs_jnl_write_inode
>      ABBA deadlock ←-----make_reservation(BASEHD)
>                    dispose_list // cannot be executed by prune_icache_sb
>                     wake_up_bit(&ixa->i_state)
> 
> Fix it by forbidding inode evicting under the inode lru traversing
> context. In details, we import a new inode state flag 'I_LRU_ISOLATING'
> to pin inode without holding i_count under the inode lru traversing
> context, the inode evicting process will wait until this flag is
> cleared from i_state.

Thanks for the patch and sorry for not getting to this myself!  Let me
rephrase the above paragraph a bit for better readability:

Fix the possible deadlock by using new inode state flag I_LRU_ISOLATING to
pin the inode in memory while inode_lru_isolate() reclaims its pages
instead of using ordinary inode reference. This way inode deletion cannot
be triggered from inode_lru_isolate() thus avoiding the deadlock. evict()
is made to wait for I_LRU_ISOLATING to be cleared before proceeding with
inode cleanup.

> @@ -488,6 +488,36 @@ static void inode_lru_list_del(struct inode *inode)
>  		this_cpu_dec(nr_unused);
>  }
>  
> +static void inode_lru_isolating(struct inode *inode)

Perhaps call this inode_pin_lru_isolating()

> +{
> +	BUG_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
> +	inode->i_state |= I_LRU_ISOLATING;
> +}
> +
> +static void inode_lru_finish_isolating(struct inode *inode)

And call this inode_unpin_lru_isolating()?

Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

