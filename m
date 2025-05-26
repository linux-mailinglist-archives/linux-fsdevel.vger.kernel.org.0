Return-Path: <linux-fsdevel+bounces-49858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE696AC42E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2801899CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F523D2BD;
	Mon, 26 May 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aUn/qKDg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CsXavt/H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aUn/qKDg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CsXavt/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF2226CF6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276416; cv=none; b=F2t7ojSHFrSQWc/1uh9kuYKIyxAqbOleG0OvyjKJY6mSJKGRqAkcPnfS7ckOYoXjOE/iGl119oo4EuVouc46+vXJ6oplt26IwwluP6kgpRwb+N0gsjZyq4SDAmZuZnlVDxzmU4pK8iTYNEzgQ2PsQLitAsHFY2GwOZcRRhXJn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276416; c=relaxed/simple;
	bh=y4CBjWuKKN8L9SNiDECKLF61mSLD4R7ZHdrASlShWHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC4D647b4AJDeAEiBwt20/1aV3koCPGQhrJxtLuUc9Tkj8ATQ/TpOiC4SJOAEH3SuHqeAWEUbPzY/OKryEniYTU5fxI/eUmK9l6N/Ltlk3xh/RqR0DO2vtmmD8by0j/ws8DedenNCVAY/FdWjgEOHFL/uxXPmX0pXoHlwqpr9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aUn/qKDg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CsXavt/H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aUn/qKDg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CsXavt/H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CCE41F793;
	Mon, 26 May 2025 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748276411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOBZoZzUHONLoLLpsI1CHtBErIDxMTl1jzUF4RYHAYo=;
	b=aUn/qKDgg+y3FtQF37V6MyQVVrBxVCfA0/Rbe9z+P3xXh40B2bhzvQN7QFeMyJ12YnirXR
	/9tjAQ6WsaiLQXbM1HaMzqPPguokFhI9N+BFJRQBMeuqWmGxSeE78H9mdlI/XtEjYV/pFS
	WDBa9TyAA1hvCky3hCU/rQK43A32HzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748276411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOBZoZzUHONLoLLpsI1CHtBErIDxMTl1jzUF4RYHAYo=;
	b=CsXavt/HdsMZtvjnL93SN6j8O9kxB5P3HO4XnpHyYwPw2kgW70n+KrYQUkz7xjOYzpEdJZ
	KvtIIH9/SQ5cyfCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748276411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOBZoZzUHONLoLLpsI1CHtBErIDxMTl1jzUF4RYHAYo=;
	b=aUn/qKDgg+y3FtQF37V6MyQVVrBxVCfA0/Rbe9z+P3xXh40B2bhzvQN7QFeMyJ12YnirXR
	/9tjAQ6WsaiLQXbM1HaMzqPPguokFhI9N+BFJRQBMeuqWmGxSeE78H9mdlI/XtEjYV/pFS
	WDBa9TyAA1hvCky3hCU/rQK43A32HzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748276411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOBZoZzUHONLoLLpsI1CHtBErIDxMTl1jzUF4RYHAYo=;
	b=CsXavt/HdsMZtvjnL93SN6j8O9kxB5P3HO4XnpHyYwPw2kgW70n+KrYQUkz7xjOYzpEdJZ
	KvtIIH9/SQ5cyfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A7D213964;
	Mon, 26 May 2025 16:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QazJIbuUNGjFcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 May 2025 16:20:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EB5AA09B7; Mon, 26 May 2025 18:20:11 +0200 (CEST)
Date: Mon, 26 May 2025 18:20:11 +0200
From: Jan Kara <jack@suse.cz>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
	Tao Ma <boyu.mt@taobao.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Eric Biggers <ebiggers@google.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: inline: convert when mmap is called, not when
 page is written
Message-ID: <ko3bgsd2wdluordh6phnmou3232yqlqsehxte6bvq34udq5in7@4phfw73mywjo>
References: <20250526-ext4_inline_page_mkwrite-v2-1-aa96d9bc287d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526-ext4_inline_page_mkwrite-v2-1-aa96d9bc287d@igalia.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[0c89d865531d053abb2d];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Mon 26-05-25 11:13:34, Thadeu Lima de Souza Cascardo wrote:
> inline data handling has a race between writing and writing to a memory
> map.
> 
> When ext4_page_mkwrite is called, it calls ext4_convert_inline_data, which
> destroys the inline data, but if block allocation fails, restores the
> inline data. In that process, we could have:
> 
> CPU1					CPU2
> destroy_inline_data
> 					write_begin (does not see inline data)
> restory_inline_data
> 					write_end (sees inline data)
> 
> This leads to bugs like the one below, as write_begin did not prepare for
> the case of inline data, which is expected by the write_end side of it.
> 
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/inline.c:235!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 5838 Comm: syz-executor110 Not tainted 6.13.0-rc3-syzkaller-00209-g499551201b5f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
> RIP: 0010:ext4_write_inline_data_end+0xdc7/0xdd0 fs/ext4/inline.c:774
> Code: 47 1d 8c e8 4b 3a 91 ff 90 0f 0b e8 63 7a 47 ff 48 8b 7c 24 10 48 c7 c6 e0 47 1d 8c e8 32 3a 91 ff 90 0f 0b e8 4a 7a 47 ff 90 <0f> 0b 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900031c7320 EFLAGS: 00010293
> RAX: ffffffff8257f9a6 RBX: 000000000000005a RCX: ffff888012968000
> RDX: 0000000000000000 RSI: 000000000000005a RDI: 000000000000005b
> RBP: ffffc900031c7448 R08: ffffffff8257ef87 R09: 1ffff11006806070
> R10: dffffc0000000000 R11: ffffed1006806071 R12: 000000000000005a
> R13: dffffc0000000000 R14: ffff888076b65bd8 R15: 000000000000005b
> FS:  00007f5c6bacf6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000a00 CR3: 0000000073fb6000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  generic_perform_write+0x6f8/0x990 mm/filemap.c:4070
>  ext4_buffered_write_iter+0xc5/0x350 fs/ext4/file.c:299
>  ext4_file_write_iter+0x892/0x1c50
>  iter_file_splice_write+0xbfc/0x1510 fs/splice.c:743
>  do_splice_from fs/splice.c:941 [inline]
>  direct_splice_actor+0x11d/0x220 fs/splice.c:1164
>  splice_direct_to_actor+0x588/0xc80 fs/splice.c:1108
>  do_splice_direct_actor fs/splice.c:1207 [inline]
>  do_splice_direct+0x289/0x3e0 fs/splice.c:1233
>  do_sendfile+0x564/0x8a0 fs/read_write.c:1363
>  __do_sys_sendfile64 fs/read_write.c:1424 [inline]
>  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5c6bb18d09
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5c6bacf218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f5c6bba0708 RCX: 00007f5c6bb18d09
> RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
> RBP: 00007f5c6bba0700 R08: 0000000000000000 R09: 0000000000000000
> R10: 000080001d00c0d0 R11: 0000000000000246 R12: 00007f5c6bb6d620
> R13: 00007f5c6bb6d0c0 R14: 0031656c69662f2e R15: 8088e3ad122bc192
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> 
> This happens because ext4_page_mkwrite is not protected by the inode_lock.
> The xattr semaphore is not sufficient to protect inline data handling in a
> sane way, so we need to rely on the inode_lock. Adding the inode_lock to
> ext4_page_mkwrite is not an option, otherwise lock-ordering problems with
> mmap_lock may arise.
> 
> The conversion inside ext4_page_mkwrite was introduced at commit
> 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map"). This
> fixes a documented bug in the commit message, which suggests some
> alternative fixes.
> 
> Convert inline data when mmap is called, instead of doing it only when the
> mmapped page is written to. Using the inode_lock there does not lead to
> lock-ordering issues.
> 
> The drawback is that inline conversion will happen when the file is
> mmapped, even though the page will not be written to.
> 
> Fixes: 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map")
> Reported-by: syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Convert inline data at mmap time, avoiding data loss.
> - Link to v1: https://lore.kernel.org/r/20250519-ext4_inline_page_mkwrite-v1-1-865d9a62b512@igalia.com
> ---
>  fs/ext4/file.c  | 6 ++++++
>  fs/ext4/inode.c | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index beb078ee4811d6092e362e37307e7d87e5276cbc..f2380471df5d99500e49fdc639fa3e56143c328f 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -819,6 +819,12 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!daxdev_mapping_supported(vma, dax_dev))
>  		return -EOPNOTSUPP;
>  
> +	inode_lock(inode);
> +	ret = ext4_convert_inline_data(inode);
> +	inode_unlock(inode);
> +	if (ret)
> +		return ret;
> +
>  	file_accessed(file);
>  	if (IS_DAX(file_inode(file))) {
>  		vma->vm_ops = &ext4_dax_vm_ops;

So I would *love* to do this and was thinking about this as well. But the
trouble is that this causes lock inversion as well because ->mmap callback
is called with mmap_lock held and so we cannot acquire inode_lock here
either.

Recent changes which switch from ->mmap to ->mmap_prepare callback are
actually going in a suitable direction but we'd need a rather larger
rewrite to get from under mmap_lock and I'm not sure that's justified.

Anyway, thanks for having a look!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

