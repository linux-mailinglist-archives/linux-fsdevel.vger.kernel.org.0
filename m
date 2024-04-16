Return-Path: <linux-fsdevel+bounces-17058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F78A71E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF221F23ED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52D131E21;
	Tue, 16 Apr 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDYr91ST";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2joM5M0e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ae0gGnxd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="amWRgvx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AB02EAF9;
	Tue, 16 Apr 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287066; cv=none; b=cv7vwNCYNNWrhHryew0M3yqisn8p8UEYjZTFRquP7bBUg3oTeCaU0fNHSTKrsTRfr/pZpY67DYbEFEYcKJpn/pC6MpCS0uA1VwWMdFYO+s9KiOUv1qzDuhSi7dY3tx8RwP/wPEBGS7INad4Kf0oNlPCfmMrXavzBVunSg7Po+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287066; c=relaxed/simple;
	bh=smozM9jF1fgEa0jo5wcKDyao5GQFouQ/Furzv3/aqFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZjgcLEiet2FOW6/99SP5RwnzOVhzx9QaupSMID/uS+bfiN+tj1LpNnIOT8Fiyjv4Wdfm+xBJWdgs5BPHAaXFsUn3LvJGuyYewH8ONI0B0TP+M0vEgm4c/R2zVziyFSmab2zUhB3tJ/qazItrkOc7+smTrbX9wYaqV96qUt2o5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDYr91ST; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2joM5M0e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ae0gGnxd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=amWRgvx/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CAA81F7C4;
	Tue, 16 Apr 2024 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713287059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmF+X66qXKP4uAwVMy4ZKy9VoRjMIrIQQD+AMJy3/rM=;
	b=MDYr91STVJoNWxZhqSg2uy5Kw/MIdL6pC2WieISYnxY9HMaDRBMHgCBUd2f9BFVZRRJYyJ
	fCO6/k6uH+2fpTspFFMk6tmRRanOmAvap1oKKgGfmqkRZBfJNeWazjC6V+nSqqcfDp5pMe
	ILLp977WnrTzxjuEpUO27tmXdkA3u7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713287059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmF+X66qXKP4uAwVMy4ZKy9VoRjMIrIQQD+AMJy3/rM=;
	b=2joM5M0egcib8sTxUUqc6TrDI43rBAkVjVtCEg1SYgWpB8zoD/efYFIY50vMJbHCIGisMC
	gdRZGy2264fm6aBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713287058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmF+X66qXKP4uAwVMy4ZKy9VoRjMIrIQQD+AMJy3/rM=;
	b=ae0gGnxd/wTLaP35Hhq8QbqNn1rtWeL1tBCL1XkgKi+bbABrBWF7NlJvbbhlmCkluKteGl
	h5PcfVfBOyw2dOttqIjaOLZsCwCSKhRn2OG93UqISqwUS0WbuOiQ1rUeJ7nMwYSMRj9RMd
	PsuU4WQRIAHTSkluuoViKVoqfoNjcJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713287058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmF+X66qXKP4uAwVMy4ZKy9VoRjMIrIQQD+AMJy3/rM=;
	b=amWRgvx/OUa0dd0i2x47/zLltJnD+n/BDPibTKM2vgWgECWLwE5xskJZhvpQrhdoL1KzAm
	QswOoa635H1i4OAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 428DF13432;
	Tue, 16 Apr 2024 17:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lXwdEJKvHmYbKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 16 Apr 2024 17:04:18 +0000
Date: Tue, 16 Apr 2024 18:56:49 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KMSAN: kernel-infoleak in
 btrfs_ioctl_logical_to_ino (2)
Message-ID: <20240416165648.GS3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000196a39061636840a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000196a39061636840a@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -1.50
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=87a805e655619c64];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[510a1abbb8116eeb341d];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Tue, Apr 16, 2024 at 06:14:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cef27048e5c2 Merge tag 'bcachefs-2024-04-15' of https://ev..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a1fec7180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
> dashboard link: https://syzkaller.appspot.com/bug?extid=510a1abbb8116eeb341d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fce0439cf562/disk-cef27048.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/99540e71cf72/vmlinux-cef27048.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/65fbfc2c486f/bzImage-cef27048.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com
> 
> BTRFS info (device loop1): first mount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
> BTRFS info (device loop1): using crc32c (crc32c-generic) checksum algorithm
> BTRFS info (device loop1): using free-space-tree
> =====================================================
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _copy_to_user+0xbc/0x110 lib/usercopy.c:40
>  copy_to_user include/linux/uaccess.h:191 [inline]
>  btrfs_ioctl_logical_to_ino+0x440/0x750 fs/btrfs/ioctl.c:3499
>  btrfs_ioctl+0x714/0x1260
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>  x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
>  __do_kmalloc_node mm/slub.c:3954 [inline]
>  __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
>  kmalloc_node include/linux/slab.h:648 [inline]
>  kvmalloc_node+0xc0/0x2d0 mm/util.c:634
>  kvmalloc include/linux/slab.h:766 [inline]
>  init_data_container+0x49/0x1e0 fs/btrfs/backref.c:2779

2767 struct btrfs_data_container *init_data_container(u32 total_bytes)
2768 {
2769         struct btrfs_data_container *data;
2770         size_t alloc_bytes;
2771
2772         alloc_bytes = max_t(size_t, total_bytes, sizeof(*data));
2773         data = kvmalloc(alloc_bytes, GFP_KERNEL);

and then data is passed around in the ioctl.

>  btrfs_ioctl_logical_to_ino+0x17c/0x750 fs/btrfs/ioctl.c:3480
>  btrfs_ioctl+0x714/0x1260
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>  x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Bytes 40-65535 of 65536 are uninitialized

It is possible to let the ioctl allocate a big buffer but return it
filled only partially. So it should be kvcalloc.

