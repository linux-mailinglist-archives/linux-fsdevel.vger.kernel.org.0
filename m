Return-Path: <linux-fsdevel+bounces-46505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14EA8A5AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225A3172803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4A14D8CE;
	Tue, 15 Apr 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VCkcVwf5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/30uPAb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CCFgElI/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/pvoamBT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45878221552
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738373; cv=none; b=llYfhBwimwHeYkQHs7FZs3yNoaOJ41Qk8Yhk84d2YdsgqFaFWS0B4MCgfHsi135LzTEPDuMsYCXmhlSPPP28gSun99Jv9T0MvEQhAbN51ftjZU83Jtso8F5YuwXhk5bjUpErgozGUqdyv3H5tpgBwhXjZ04gBAbipmFZJCKcDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738373; c=relaxed/simple;
	bh=2Otzs3DwCwNGfCJA4CnepeDGywULcmmWDqhlD3dwvUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhO61zLJ2JnSBuupAOKL4rLDWNAV/ApA75OJQ6SSq44Kg3UP3eaNbBBTdjvwY60PE5FFnb1LpUDBJZI+YEtl7w2g504X8cg0R9MyTFFCd7qh150pyrRdFVnDDK/Itgw6caZl5FfYrZuXqHzEhxlhkKzEiV2o+PDBWY3GcFdivsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VCkcVwf5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/30uPAb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CCFgElI/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/pvoamBT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FF1F1F749;
	Tue, 15 Apr 2025 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744738369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hus6ehOq6AF8o2QBOcdvDpNm19O1W9nkhOR+Of5UL7s=;
	b=VCkcVwf5SYH9z0rvR6rGNqHOyAoS61oaJrsJLmCFU1zz97C0gtUE2tBDHiUsvFjE5Ml4dj
	GIyOhFFh5Y+chUTd9Iq7sqWzx7weaVyMUBP64dYArdb4ZgqP6BoN1hsK23CamMo6fNcYnX
	2j4kQqSFPCUSNkniAUbko4FQZfJOs60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744738369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hus6ehOq6AF8o2QBOcdvDpNm19O1W9nkhOR+Of5UL7s=;
	b=w/30uPAbO5TK1OOmdsP6ud+mtoGQXKVa76r0TjuzsrogpIpRXOOqqG0cbrK/RB1wmWv/Wf
	98nbNtVCDyS0gOCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744738368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hus6ehOq6AF8o2QBOcdvDpNm19O1W9nkhOR+Of5UL7s=;
	b=CCFgElI/KhgtgycgZze9Bc9Kn+Q4cKUBRnbgd4YpY2qXmOZSNDuTLT0FAUFd32suoYYVqQ
	Y2tJONN2mqY8Ki2bI91Pq9sVxyvHOQfV+FiJTfXut+AYuYglKmY3r0qVz776bz2sv06ot/
	bwvxMzS1ZozDJY8KfZ4MU4ely74Nl4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744738368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hus6ehOq6AF8o2QBOcdvDpNm19O1W9nkhOR+Of5UL7s=;
	b=/pvoamBTd53lR1nXQIMIhJ4aqr6nyJPx0RR2lm2QjoMI7MeUal2tO9ymhiUse1TEJsbke2
	OaE7Z/iZNtMkdmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13050137A5;
	Tue, 15 Apr 2025 17:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EvKdBECY/mftdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 17:32:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BFEECA0947; Tue, 15 Apr 2025 19:32:47 +0200 (CEST)
Date: Tue, 15 Apr 2025 19:32:47 +0200
From: Jan Kara <jack@suse.cz>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Tao Ma <boyu.mt@taobao.com>, Jan Kara <jack@suse.com>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ext4: inline: fix len overflow in
 ext4_prepare_inline_data
Message-ID: <ddz2qz3vxsjlkgzdt2fxxss2yes77iglwiers7bjwf6xm3yqw5@ozr2jqs27utn>
References: <20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-ext4-prepare-inline-overflow-v1-1-f4c13d900967@igalia.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[fe2a25dae02a207717a0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,igalia.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 15-04-25 11:53:04, Thadeu Lima de Souza Cascardo wrote:
> When running the following code on an ext4 filesystem with inline_data
> feature enabled, it will lead to the bug below.
> 
>         fd = open("file1", O_RDWR | O_CREAT | O_TRUNC, 0666);
>         ftruncate(fd, 30);
>         pwrite(fd, "a", 1, (1UL << 40) + 5UL);
> 
> That happens because write_begin will succeed as when
> ext4_generic_write_inline_data calls ext4_prepare_inline_data, pos + len
> will be truncated, leading to ext4_prepare_inline_data parameter to be 6
> instead of 0x10000000006.
> 
> Then, later when write_end is called, we hit:
> 
>         BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
> 
> at ext4_write_inline_data.
> 
> Fix it by using a loff_t type for the len parameter in
> ext4_prepare_inline_data instead of an unsigned int.
> 
> [   44.545164] ------------[ cut here ]------------
> [   44.545530] kernel BUG at fs/ext4/inline.c:240!
> [   44.545834] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [   44.546172] CPU: 3 UID: 0 PID: 343 Comm: test Not tainted 6.15.0-rc2-00003-g9080916f4863 #45 PREEMPT(full)  112853fcebfdb93254270a7959841d2c6aa2c8bb
> [   44.546523] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   44.546523] RIP: 0010:ext4_write_inline_data+0xfe/0x100
> [   44.546523] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 49
> [   44.546523] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
> [   44.546523] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: 0000010000000006
> [   44.546523] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: ffff9329c158e738
> [   44.546523] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> [   44.546523] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: 0000006210000000
> [   44.546523] R13: fffffc7e4015e700 R14: 0000010000000005 R15: ffff9329c158e738
> [   44.546523] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) knlGS:0000000000000000
> [   44.546523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.546523] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: 0000000000770eb0
> [   44.546523] PKRU: 55555554
> [   44.546523] Call Trace:
> [   44.546523]  <TASK>
> [   44.546523]  ext4_write_inline_data_end+0x126/0x2d0
> [   44.546523]  generic_perform_write+0x17e/0x270
> [   44.546523]  ext4_buffered_write_iter+0xc8/0x170
> [   44.546523]  vfs_write+0x2be/0x3e0
> [   44.546523]  __x64_sys_pwrite64+0x6d/0xc0
> [   44.546523]  do_syscall_64+0x6a/0xf0
> [   44.546523]  ? __wake_up+0x89/0xb0
> [   44.546523]  ? xas_find+0x72/0x1c0
> [   44.546523]  ? next_uptodate_folio+0x317/0x330
> [   44.546523]  ? set_pte_range+0x1a6/0x270
> [   44.546523]  ? filemap_map_pages+0x6ee/0x840
> [   44.546523]  ? ext4_setattr+0x2fa/0x750
> [   44.546523]  ? do_pte_missing+0x128/0xf70
> [   44.546523]  ? security_inode_post_setattr+0x3e/0xd0
> [   44.546523]  ? ___pte_offset_map+0x19/0x100
> [   44.546523]  ? handle_mm_fault+0x721/0xa10
> [   44.546523]  ? do_user_addr_fault+0x197/0x730
> [   44.546523]  ? do_syscall_64+0x76/0xf0
> [   44.546523]  ? arch_exit_to_user_mode_prepare+0x1e/0x60
> [   44.546523]  ? irqentry_exit_to_user_mode+0x79/0x90
> [   44.546523]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [   44.546523] RIP: 0033:0x7f42999c6687
> [   44.546523] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [   44.546523] RSP: 002b:00007ffeae4a7930 EFLAGS: 00000202 ORIG_RAX: 0000000000000012
> [   44.546523] RAX: ffffffffffffffda RBX: 00007f4299934740 RCX: 00007f42999c6687
> [   44.546523] RDX: 0000000000000001 RSI: 000055ea6149200f RDI: 0000000000000003
> [   44.546523] RBP: 00007ffeae4a79a0 R08: 0000000000000000 R09: 0000000000000000
> [   44.546523] R10: 0000010000000005 R11: 0000000000000202 R12: 0000000000000000
> [   44.546523] R13: 00007ffeae4a7ac8 R14: 00007f4299b86000 R15: 000055ea61493dd8
> [   44.546523]  </TASK>
> [   44.546523] Modules linked in:
> [   44.568501] ---[ end trace 0000000000000000 ]---
> [   44.568889] RIP: 0010:ext4_write_inline_data+0xfe/0x100
> [   44.569328] Code: 3c 0e 48 83 c7 48 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 e4 fa 43 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 0f 0b <0f> 0b 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 49
> [   44.570931] RSP: 0018:ffffb342008b79a8 EFLAGS: 00010216
> [   44.571356] RAX: 0000000000000001 RBX: ffff9329c579c000 RCX: 0000010000000006
> [   44.571959] RDX: 000000000000003c RSI: ffffb342008b79f0 RDI: ffff9329c158e738
> [   44.572571] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> [   44.573148] R10: 00007ffffffff000 R11: ffffffff9bd0d910 R12: 0000006210000000
> [   44.573748] R13: fffffc7e4015e700 R14: 0000010000000005 R15: ffff9329c158e738
> [   44.574335] FS:  00007f4299934740(0000) GS:ffff932a60179000(0000) knlGS:0000000000000000
> [   44.575027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.575520] CR2: 00007f4299a1ec90 CR3: 0000000002886002 CR4: 0000000000770eb0
> [   44.576112] PKRU: 55555554
> [   44.576338] Kernel panic - not syncing: Fatal exception
> [   44.576517] Kernel Offset: 0x1a600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Reported-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
> Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Cc: stable@vger.kernel.org

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 2c9b762925c72f2ff5a402b02500370bc1eb0eb1..e5e6bf0d338b965a885fb99581f9ed5e51c5257c 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -397,7 +397,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
>  }
>  
>  static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
> -				    unsigned int len)
> +				    loff_t len)
>  {
>  	int ret, size, no_expand;
>  	struct ext4_inode_info *ei = EXT4_I(inode);
> 
> ---
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> change-id: 20250415-ext4-prepare-inline-overflow-8db0e747cb16
> 
> Best regards,
> -- 
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

