Return-Path: <linux-fsdevel+bounces-36404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30219E36F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 10:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F62164495
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F041ABEDC;
	Wed,  4 Dec 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boAwLDfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5D18A6C4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306210; cv=none; b=GvdigiYo9ZstMRi40IzrsJ382tvFMUwhKubf3p+XNhHZCrxh17e7pZuryap6/F6O74QxEnakBqXdAWi6ZPK4ndnfedXs3H0W23Mu39/C8zw8GzLOoxER0+5Lc2IYlZ0K4oUoRMk/J209hl1EdCiGhhyLiaQv1U9vfF/hFLDaBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306210; c=relaxed/simple;
	bh=z0r02GOTsgnnZBZyYBHGi4Y/zi6zlaDPgcANI4yLS/g=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=k/wfSh2B/9WBFYTo66LeMLuBcVgumQeS6kcKAap0Fn6mkC6g9ML1pLVQBqoO305elBqAeLN9gW56cyqkzkAIc3kz2IFNs0MvlzGlk7Fm0pQ8TLWlZO0PYdnDaHul7P3CkWAEI6LIufabVkVLNObIoISZsMC6LEeCx1bkGtDfbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boAwLDfu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733306207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJNI533Crd7GYCjIgVZGSj79RM759v5i3jMuDe10RZA=;
	b=boAwLDfue6/TwkDdbFLMPBQdHL9L19JCXGCkIVViEAMXLuR9ixcRbUq31eiehxOC0awxrq
	AxMicdBcb5VZBtC16OhdJhknwi3w+Rfg2Jl/LDLwH75DM2mHOLdCLL03LWbojcAcMqhAGq
	6yjBn2Cp2rlPSVcHdx0kq6GKOL5HYaU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-ZeNldURKOFyIwFGi-fSFzg-1; Wed,
 04 Dec 2024 04:56:46 -0500
X-MC-Unique: ZeNldURKOFyIwFGi-fSFzg-1
X-Mimecast-MFC-AGG-ID: ZeNldURKOFyIwFGi-fSFzg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 270271954221;
	Wed,  4 Dec 2024 09:56:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0056D1956054;
	Wed,  4 Dec 2024 09:56:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241202093943.227786-1-dmantipov@yandex.ru>
References: <20241202093943.227786-1-dmantipov@yandex.ru>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Dmitry Antipov <dmantipov@yandex.ru>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org,
    syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Subject: syzbot program that crashes netfslib can also crash fuse
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1100512.1733306199.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Dec 2024 09:56:39 +0000
Message-ID: <1100513.1733306199@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Interesting...  The test program also causes fuse to oops (see attached) o=
ver
without even getting to netfslib.  The BUG is in iov_iter_revert():

	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
		BUG(); /* We should never go beyond the start of the specified
			* range since we might then be straying into pages that
			* aren't pinned.
			*/

I was trying the C reproducer from here:

	https://syzkaller.appspot.com/bug?extid=3D404b4b745080b6210c6c

David
---
 FAULT_INJECTION: forcing a failure.
 name failslab, interval 1, probability 0, space 0, times 1
 CPU: 3 UID: 0 PID: 5926 Comm: repro-12bc200f9 Not tainted 6.13.0-rc1-buil=
d3+ #5189
 Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x47/0x70
  should_fail_ex+0x12e/0x160
  should_failslab+0x50/0x60
  __kmalloc_noprof+0x9f/0x290
  ? fuse_get_user_pages+0xad/0x290
  ? kmem_cache_debug_flags+0xc/0x20
  fuse_get_user_pages+0xad/0x290
  ? fuse_folios_alloc+0x13/0x30
  fuse_direct_io+0x220/0x460
  fuse_direct_write_iter+0x10f/0x180
  vfs_write+0x142/0x1e0
  ? __pfx_fuse_file_write_iter+0x10/0x10
  ksys_write+0x6d/0xc0
  do_syscall_64+0x80/0xe0
  entry_SYSCALL_64_after_hwframe+0x71/0x79
 RIP: 0033:0x7fdd71f0f85d
 Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 f=
f ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007fdd71df7e68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 00007fdd71df8cdc RCX: 00007fdd71f0f85d
 RDX: 000000000000000f RSI: 0000000020000280 RDI: 0000000000000005
 RBP: 00007fdd71df7e90 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdd71df86c0
 R13: ffffffffffffff88 R14: 0000000000000002 R15: 00007fffe6090bd0
  </TASK>
 ------------[ cut here ]------------
 kernel BUG at lib/iov_iter.c:626!
 Oops: invalid opcode: 0000 [#1] SMP PTI
 CPU: 3 UID: 0 PID: 5926 Comm: repro-12bc200f9 Not tainted 6.13.0-rc1-buil=
d3+ #5189
 Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
 RIP: 0010:iov_iter_revert+0x4c/0xf0
 Code: 80 f9 06 0f 84 bf 00 00 00 48 8b 47 08 48 39 f0 72 0c 48 29 f0 48 8=
9 47 08 c3 cc cc cc cc 48 29 c6 80 f9 05 74 04 84 c9 75 02 <0f> 0b 80 f9 0=
2 48 8b 47 10 75 15 8b 48 f8 48 83 e8 10 48 ff 42 20
 RSP: 0018:ffff88811f16fd00 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff888107504900 RCX: 0000000000001600
 RDX: ffff88811f16fe60 RSI: 000000000000000f RDI: ffff88811f16fe60
 RBP: 0000000000000000 R08: ffff88840fb9fa40 R09: ffff88840fb9fa60
 R10: 0000000000000006 R11: 0000000000000020 R12: ffff88810b481400
 R13: 00000000fffffff4 R14: ffff88811ce26cc0 R15: ffff88811f16fdb8
 FS:  00007fdd71df86c0(0000) GS:ffff88840fb80000(0000) knlGS:0000000000000=
000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000560d9a217710 CR3: 000000010760e003 CR4: 00000000001706f0
 Call Trace:
  <TASK>
  ? __die_body+0x1a/0x60
  ? die+0x30/0x50
  ? do_trap+0x7a/0x100
  ? iov_iter_revert+0x4c/0xf0
  ? iov_iter_revert+0x4c/0xf0
  ? do_error_trap+0x6e/0xa0
  ? iov_iter_revert+0x4c/0xf0
  ? exc_invalid_op+0x49/0x60
  ? iov_iter_revert+0x4c/0xf0
  ? asm_exc_invalid_op+0x16/0x20
  ? iov_iter_revert+0x4c/0xf0
  fuse_direct_io+0x398/0x460
  fuse_direct_write_iter+0x10f/0x180
  vfs_write+0x142/0x1e0
  ? __pfx_fuse_file_write_iter+0x10/0x10
  ksys_write+0x6d/0xc0
  do_syscall_64+0x80/0xe0
  entry_SYSCALL_64_after_hwframe+0x71/0x79


