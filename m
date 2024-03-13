Return-Path: <linux-fsdevel+bounces-14377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0326587B540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 00:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539BB1F2224A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951D5DF30;
	Wed, 13 Mar 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bnd3kWsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OJxKQlLh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bnd3kWsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OJxKQlLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEA5D737;
	Wed, 13 Mar 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372991; cv=none; b=YBBJwIA07jNmIfsfraRthCj2OpE33Uv4qGab0xwdU/835X6haRWm8lg7n1hrJttnBQfs5yBDxJTYuhtMZc9wrZiW73w/j73Z6cbDuMIeRYpSCQ4YyYk3fdQ6l4ZUn1pouQKdrR0O5FT488WgAbktHalm17ftM0kTxo4MlNB4Ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372991; c=relaxed/simple;
	bh=PEtIBk3Qox1A/f6L9nzM7j01pdfLXKimHCRyf6wX8kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/Rlt6b70Sbm09F5JX6HBlIs26YQQDelts74v1LDff+qPv3Hi1XmD+Kz8vFD0Xa/0E81R4V6d37CBFdf7vUx/eQ6tvnlJfdW9bctxcELA/d1+AZ4J3ijXpRA7HZTDaZInYmokhOWRR+HLboxu/EEnaiQdLIShc+GyQlHURIMd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bnd3kWsn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OJxKQlLh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bnd3kWsn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OJxKQlLh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 776B31F7F8;
	Wed, 13 Mar 2024 23:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710372987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZIOH1b0c2LE/iuLTWH0WnTuOq16yhQnSgF8iH0nLII=;
	b=Bnd3kWsnYDr/3ubbhuA0F23HvEmHaKaADekrRDWkckJo9Z/ZtVPe95xkXOL3uBVO8BQbwZ
	myA9JFd9BVM0i8RpdY3lezr6z/jKO5+Z4OTs16yWQbugA0mG/CMv7lkGI4yhu34yVOmRSF
	1wAJsXiLeC4QAdk5Jh23U8n9tYgS5w8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710372987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZIOH1b0c2LE/iuLTWH0WnTuOq16yhQnSgF8iH0nLII=;
	b=OJxKQlLhwCXcC4Qtt1DfDFBjyFQt+Q13XqaIqQTJVV8EtNJY+S7UikYGFlrAB1QzHHvtRT
	LMO7D2O//YY4XqCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710372987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZIOH1b0c2LE/iuLTWH0WnTuOq16yhQnSgF8iH0nLII=;
	b=Bnd3kWsnYDr/3ubbhuA0F23HvEmHaKaADekrRDWkckJo9Z/ZtVPe95xkXOL3uBVO8BQbwZ
	myA9JFd9BVM0i8RpdY3lezr6z/jKO5+Z4OTs16yWQbugA0mG/CMv7lkGI4yhu34yVOmRSF
	1wAJsXiLeC4QAdk5Jh23U8n9tYgS5w8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710372987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZIOH1b0c2LE/iuLTWH0WnTuOq16yhQnSgF8iH0nLII=;
	b=OJxKQlLhwCXcC4Qtt1DfDFBjyFQt+Q13XqaIqQTJVV8EtNJY+S7UikYGFlrAB1QzHHvtRT
	LMO7D2O//YY4XqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3165313977;
	Wed, 13 Mar 2024 23:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DYIDBns48mXSCgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 13 Mar 2024 23:36:27 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v13 2/9] f2fs: Simplify the handling of cached
 insensitive names
In-Reply-To: <20240305101608.67943-3-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Tue, 5 Mar 2024 12:16:01 +0200")
Organization: SUSE
References: <20240305101608.67943-1-eugen.hristev@collabora.com>
	<20240305101608.67943-3-eugen.hristev@collabora.com>
Date: Wed, 13 Mar 2024 19:36:25 -0400
Message-ID: <87edcdk8li.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bnd3kWsn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OJxKQlLh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 776B31F7F8
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> +void f2fs_free_casefolded_name(struct f2fs_filename *fname)
> +{
> +	unsigned char *buf = (unsigned char *)fname->cf_name.name;
> +
> +	kmem_cache_free(f2fs_cf_name_slab, buf);
> +	fname->cf_name.name = NULL;

In my previous review, I mentioned you could drop the "if (buf)" check
here *if and only if* you used kfree. By doing an unchecked kmem_cache_free
like this, you will immediately hit an Oops in the first lookup (see below).

Please, make sure you actually stress test this patchset with fstests
against both f2fs and ext4 before sending each new version.

Thanks,


[   74.202044] F2FS-fs (loop0): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
[   74.206592] F2FS-fs (loop0): Found nat_bits in checkpoint
[   74.221467] F2FS-fs (loop0): Mounted with checkpoint version = 3e684111
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 sle15sp5 6.7.0-gf27274eae416 #8 SMP PREEMPT_DYNAMIC Thu Mar 14 00:22:47 CET 2024
MKFS_OPTIONS  -- -O encrypt /dev/loop1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /root/work/scratch

[   75.038385] F2FS-fs (loop1): Found nat_bits in checkpoint
[   75.054311] F2FS-fs (loop1): Mounted with checkpoint version = 6b9fbccb
[   75.176328] F2FS-fs (loop0): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
[   75.179261] F2FS-fs (loop0): Found nat_bits in checkpoint
[   75.194264] F2FS-fs (loop0): Mounted with checkpoint version = 3e684114
f2fs/001 1s ... [   75.570867] run fstests f2fs/001 at 2024-03-14 00:24:33
[   75.753604] BUG: unable to handle page fault for address: fffff14ad2000008
[   75.754209] #PF: supervisor read access in kernel mode
[   75.754647] #PF: error_code(0x0000) - not-present page
[   75.755077] PGD 0 P4D 0 
[   75.755300] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   75.755683] CPU: 0 PID: 2740 Comm: xfs_io Not tainted 6.7.0-gf27274eae416 #8
[   75.756266] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[   75.756911] RIP: 0010:kmem_cache_free+0x6a/0x320
[   75.757309] Code: 80 48 01 d8 0f 82 b4 02 00 00 48 c7 c2 00 00 00 80 48 2b 15 f8 c2 18 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 d6 c2 18 01 <48> 8b 50 08 49 89 c6 f6 c2 01 0f 85 ea 01 00 00 0f 1f 44 00 00 49
[   75.758834] RSP: 0018:ffffa59bc231bb10 EFLAGS: 00010286
[   75.759270] RAX: fffff14ad2000000 RBX: 0000000000000000 RCX: 0000000000000000
[   75.759860] RDX: 0000620400000000 RSI: 0000000000000000 RDI: ffff9dfc80043600
[   75.760450] RBP: ffffa59bc231bb30 R08: ffffa59bc231b9a0 R09: 00000000000003fa
[   75.761037] R10: 00000000000fd024 R11: 0000000000000107 R12: ffff9dfc80043600
[   75.761626] R13: ffffffff8404dc7a R14: 0000000000000000 R15: ffff9dfc8f1aa000
[   75.762221] FS:  00007f9601efb780(0000) GS:ffff9dfcfbc00000(0000) knlGS:0000000000000000
[   75.762888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   75.763372] CR2: fffff14ad2000008 CR3: 0000000111750000 CR4: 0000000000750ef0
[   75.763962] PKRU: 55555554
[   75.764194] Call Trace:
[   75.764435]  <TASK>
[   75.764677]  ? __die_body+0x1a/0x60
[   75.764982]  ? page_fault_oops+0x154/0x440
[   75.765335]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.765760]  ? search_module_extables+0x46/0x70
[   75.766149]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.766548]  ? fixup_exception+0x22/0x300
[   75.766892]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.767292]  ? exc_page_fault+0xa6/0x140
[   75.767633]  ? asm_exc_page_fault+0x22/0x30
[   75.767995]  ? f2fs_free_filename+0x2a/0x40
[   75.768362]  ? kmem_cache_free+0x6a/0x320
[   75.768703]  ? f2fs_free_filename+0x2a/0x40
[   75.769061]  f2fs_free_filename+0x2a/0x40
[   75.769403]  f2fs_lookup+0x19f/0x380
[   75.769712]  __lookup_slow+0x8b/0x130
[   75.770034]  walk_component+0xfc/0x170
[   75.770353]  path_lookupat+0x69/0x140
[   75.770664]  filename_lookup+0xe1/0x1c0
[   75.770991]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.771393]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.771792]  ? do_wp_page+0x3f6/0xbf0
[   75.772109]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.772523]  ? preempt_count_add+0x70/0xa0
[   75.772902]  ? vfs_statx+0x89/0x180
[   75.773224]  vfs_statx+0x89/0x180
[   75.773530]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.773939]  vfs_fstatat+0x80/0xa0
[   75.774237]  __do_sys_newfstatat+0x26/0x60
[   75.774595]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.775021]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.775448]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.775878]  ? do_user_addr_fault+0x563/0x7c0
[   75.776273]  ? srso_alias_return_thunk+0x5/0xfbef5
[   75.776699]  do_syscall_64+0x50/0x110
[   75.777028]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   75.777479] RIP: 0033:0x7f9601b07aea
[   75.777793] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 89 ca b8 06 01 00 00 0f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 01 23 0e 00 f7
[   75.779391] RSP: 002b:00007ffc160eaae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
[   75.780050] RAX: ffffffffffffffda RBX: 0000000000000042 RCX: 00007f9601b07aea
[   75.780663] RDX: 00007ffc160eab80 RSI: 00007ffc160ecb88 RDI: 00000000ffffff9c
[   75.781278] RBP: 00007ffc160ead20 R08: 00007ffc160ead20 R09: 0000000000000000
[   75.781902] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc160eae70
[   75.782532] R13: 00007ffc160ecb88 R14: 00007ffc160eae70 R15: 0000000000000020
[   75.783150]  </TASK>
[   75.783349] Modules linked in:
[   75.783628] CR2: fffff14ad2000008
[   75.783918] ---[ end trace 0000000000000000 ]---
[   75.784315] RIP: 0010:kmem_cache_free+0x6a/0x320
[   75.784718] Code: 80 48 01 d8 0f 82 b4 02 00 00 48 c7 c2 00 00 00 80 48 2b 15 f8 c2 18 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 d6 c2 18 01 <48> 8b 50 08 49 89 c6 f6 c2 01 0f 85 ea 01 00 00 0f 1f 44 00 00 49
[   75.786294] RSP: 0018:ffffa59bc231bb10 EFLAGS: 00010286
[   75.786747] RAX: fffff14ad2000000 RBX: 0000000000000000 RCX: 0000000000000000
[   75.787369] RDX: 0000620400000000 RSI: 0000000000000000 RDI: ffff9dfc80043600
[   75.788016] RBP: ffffa59bc231bb30 R08: ffffa59bc231b9a0 R09: 00000000000003fa
[   75.788672] R10: 00000000000fd024 R11: 0000000000000107 R12: ffff9dfc80043600
[   75.789296] R13: ffffffff8404dc7a R14: 0000000000000000 R15: ffff9dfc8f1aa000
[   75.789938] FS:  00007f9601efb780(0000) GS:ffff9dfcfbc00000(0000) knlGS:0000000000000000
[   75.790677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   75.791212] CR2: fffff14ad2000008 CR3: 0000000111750000 CR4: 0000000000750ef0
[   75.791862] PKRU: 55555554
[   75.792112] Kernel panic - not syncing: Fatal exception
[   75.792797] Kernel Offset: 0x2a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


-- 
Gabriel Krisman Bertazi

