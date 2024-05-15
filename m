Return-Path: <linux-fsdevel+bounces-19545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE08C6ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556FC1F2350A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC147A4C;
	Wed, 15 May 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/7+wdtd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Za2/KmrJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/7+wdtd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Za2/KmrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A513BBD8;
	Wed, 15 May 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791545; cv=none; b=JD8ELiXOp8BiaCwxAJ6ZBhmgJAwqDCfv8CFEhsR836tvPNL9hw4IHWTAepr19W3o42zNVTv4CPXadXxhv3SM+A5zTmqvaxKkEyuaHZiihRbU6h8RyItC1+9qrRJfUVU0kQH6d3hhO+NF4b7V/t8LhkpBWYEH2NA1YeXssqPq+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791545; c=relaxed/simple;
	bh=oteRxhkRSkheBR+dCyzFqO/PW9nTu92rYyMHzJorGWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swcSIF/I/84LvR3KcNknywjQadVRuF13kZOjdH1ZReKtb80e586Hpd5cvDBJP/Uu/68TlY/kK2ERgQELgZf7Z/8i/cGASTJpJg6DAt3kTVlaOOHKdMsUf7KMhoqCgh8VdtRoKaJReO/7GCxzxPcS9UPS/K3d1IEuK/LTn7FDHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/7+wdtd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Za2/KmrJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/7+wdtd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Za2/KmrJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0942320924;
	Wed, 15 May 2024 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715791542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6tuMs3hYuZ/E6BFyoB8Qy0n8FiQAt3qrjRfzZpZwEQ=;
	b=n/7+wdtdr7jmb/lR0ewwFPVy0O+iGoi4/XCI4PNP9RdXO23zACn4vU87J/I0V1PtFSs9Lg
	coJP6rY2sPdIBe5CgAZ/k/JFuL48RAdrscekSFdhbaxlBK3ocZguwsagy1opm/jcJhzHmw
	Hy66Jt7k1XofDWufSdE8N05wFjdt6vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715791542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6tuMs3hYuZ/E6BFyoB8Qy0n8FiQAt3qrjRfzZpZwEQ=;
	b=Za2/KmrJw1PXd6gpZN0PTjp/Ol/IuwJfb7fNTC+Q5CTsQsr1Fnv7SCW8vA3upzmJzH/uH4
	pVliPo1uRkpV2+Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715791542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6tuMs3hYuZ/E6BFyoB8Qy0n8FiQAt3qrjRfzZpZwEQ=;
	b=n/7+wdtdr7jmb/lR0ewwFPVy0O+iGoi4/XCI4PNP9RdXO23zACn4vU87J/I0V1PtFSs9Lg
	coJP6rY2sPdIBe5CgAZ/k/JFuL48RAdrscekSFdhbaxlBK3ocZguwsagy1opm/jcJhzHmw
	Hy66Jt7k1XofDWufSdE8N05wFjdt6vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715791542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6tuMs3hYuZ/E6BFyoB8Qy0n8FiQAt3qrjRfzZpZwEQ=;
	b=Za2/KmrJw1PXd6gpZN0PTjp/Ol/IuwJfb7fNTC+Q5CTsQsr1Fnv7SCW8vA3upzmJzH/uH4
	pVliPo1uRkpV2+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD23136A8;
	Wed, 15 May 2024 16:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AU7qNLXmRGY1SgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 16:45:41 +0000
Date: Wed, 15 May 2024 18:45:36 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in folio_unlock (2)
Message-ID: <20240515164536.GS4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000009e614206177b0968@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009e614206177b0968@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.33 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=25ba1e5e9c955f1a];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.17)[70.01%];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[9e39ac154d8781441e60];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.cz:replyto,syzkaller.appspot.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 1.33
X-Spam-Flag: NO

On Thu, May 02, 2024 at 09:24:30AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9c6ecb3cb6e2 Add linux-next specific files for 20240502
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17418c40980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=25ba1e5e9c955f1a
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e39ac154d8781441e60
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e4117f180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10efe5f8980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/dc32e924f570/disk-9c6ecb3c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7bc65d787cc9/vmlinux-9c6ecb3c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/19096ecded11/bzImage-9c6ecb3c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/45e18da02dc2/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com
> 
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1088 [inline]
>  free_unref_page+0xd22/0xea0 mm/page_alloc.c:2601
>  free_contig_range+0x9e/0x160 mm/page_alloc.c:6655
>  destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1037
>  debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1417
>  do_one_initcall+0x248/0x880 init/main.c:1265
>  do_initcall_level+0x157/0x210 init/main.c:1327
>  do_initcalls+0x3f/0x80 init/main.c:1343
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1576
>  kernel_init+0x1d/0x2b0 init/main.c:1465
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:1507!

VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

fs/btrfs/extent_io.c:

1514         if (ret) {
1515                 btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
1516                                                PAGE_SIZE, !ret);
1517                 mapping_set_error(page->mapping, ret);
1518         }
1519         unlock_page(page);
^^^^
1520         ASSERT(ret <= 0);
1521         return ret;
1522 }

Trying to unlock a page that's not locked.

Code last touched by 9783e4deed7291996459858a1a16

