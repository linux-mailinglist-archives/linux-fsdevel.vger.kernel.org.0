Return-Path: <linux-fsdevel+bounces-32517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17E9A9018
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 21:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBAAB21B36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856FB1C9EAB;
	Mon, 21 Oct 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU7dzmr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C92145FE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540113; cv=none; b=dAsaGW2HvmZL2/0U+uLJN7EnPq4dK0dUQUCo8od/qmXxcCq/m5RAVafWRqYyy+gmvS7sJe3qTxWDmDQKgxBV355Tum+aIzpEo85GQzeK6rISpwS4+J6A/J64D2XsUMcAJcSKglZpcaJE1CEOd6TzWSg2JKXNbXirCGc5bOC/1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540113; c=relaxed/simple;
	bh=1mhtp26nldbkYkNL9WgdwxCUmet/2hIoEzLsfujmG6E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ifhac+S/zo4napxaAYn1V+kMgZHeGhu26kD2oPDU2NeqfrQBXePfELqpJ7I69u1vtJNN3c1sTNivfjcb72EqD8wsE6i2VgESP3wwzLPzlFjHVhYjvGjJUX+uXstbHAYXde/0/tK3eribeUuIwIMm/xWC+Yy3AKUBlROsWBxVZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bU7dzmr9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729540110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvLTrAc+n+1CPaIy+KG+kXWufej77bt1knPj7ZYg6H4=;
	b=bU7dzmr9SMtGHM6vfzYYP+ycKEcOy6YqG54nvX6+Drzj2Tps9gw57b3fA0xx9uhRiVDj6t
	OMI0stDFtTiPZQnGN+Tk8HyonAZEs83pnXFASUEYSdm/wvIce7VuJypqwO67QoIAU1p4+X
	H0pVZqy4PjJrFjX3g92rmHVIb4LufaY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-FN0_IHLiPoaEXLCJMnkWUA-1; Mon,
 21 Oct 2024 15:48:29 -0400
X-MC-Unique: FN0_IHLiPoaEXLCJMnkWUA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 052521955F3C;
	Mon, 21 Oct 2024 19:48:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CCA030001A3;
	Mon, 21 Oct 2024 19:48:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxZ4-9guCQdAQLpu@Antony2201.local>
References: <ZxZ4-9guCQdAQLpu@Antony2201.local> <ZxFQw4OI9rrc7UYc@Antony2201.local> <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me> <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info> <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me> <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com> <2171405.1729521950@warthog.procyon.org.uk>
To: Antony Antony <antony@phenome.org>
Cc: dhowells@redhat.com, Sedat Dilek <sedat.dilek@gmail.com>,
    Maximilian Bosch <maximilian@mbosch.me>,
    Linux regressions mailing list <regressions@lists.linux.dev>,
    LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2196249.1729540103.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2024 20:48:23 +0100
Message-ID: <2196250.1729540103@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I may have reproduced the bug (see attached), though the symptoms are slig=
htly
different.  Hopefully, it's just the one bug.

David
---
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x5626ca804 pfn=
:0x7948
flags: 0x2000000000000000(zone=3D1)
raw: 2000000000000000 ffffea000024d3c8 ffffea00001e5248 0000000000000000
raw: 00000005626ca804 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio=
) + 127u <=3D 127u))
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:1444!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 UID: 0 PID: 303 Comm: md5sum Not tainted 6.12.0-rc2-ktest-00012-g57=
e4ac5316ef-dirty #8
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/=
01/2014
RIP: 0010:__iov_iter_get_pages_alloc+0x701/0x7e0
Code: 0f 0b 4d 85 f6 0f 85 f8 fc ff ff e9 21 fe ff ff 48 c7 c6 38 6b 40 82=
 e8 cd f4 aa ff 0f 0b 48 c7 c6 38 6b 40 82 e8 bf f4 aa ff <0f> 0b 4d 89 6a=
 18 49 89 52 08 4d 89 42 10 45 88 4a 20 e9 26 fb ff
RSP: 0018:ffff88800804f5c0 EFLAGS: 00010286
RAX: 000000000000005c RBX: 0000000000001000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000027 RDI: 00000000ffffffff
RBP: ffff88800804f648 R08: ffff88807f1d8fa8 R09: 00000000fffc0000
R10: ffff88807dbd9000 R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000001000
FS:  00007f0c42c29580(0000) GS:ffff88807d8c0000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560cff5bb000 CR3: 00000000046a0002 CR4: 0000000000370eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x2b
 ? __die+0x2a/0x40
 ? die+0x2f/0x50
 ? do_trap+0xb8/0x100
 ? do_error_trap+0x6c/0x90
 ? __iov_iter_get_pages_alloc+0x701/0x7e0
 ? exc_invalid_op+0x52/0x70
 ? __iov_iter_get_pages_alloc+0x701/0x7e0
 ? asm_exc_invalid_op+0x1b/0x20
 ? __iov_iter_get_pages_alloc+0x701/0x7e0
 ? radix_tree_node_alloc.constprop.0+0xab/0xf0
 iov_iter_get_pages_alloc2+0x20/0x50
 p9_get_mapped_pages.part.0+0x77/0x260
 ? find_held_lock+0x31/0x90
 ? p9_tag_alloc+0x1c8/0x2f0
 p9_virtio_zc_request+0x339/0x6f0
 ? debug_smp_processor_id+0x17/0x20
 ? debug_smp_processor_id+0x17/0x20
 ? rcu_is_watching+0x11/0x50
 ? p9_client_prepare_req+0x15f/0x190
 p9_client_zc_rpc.constprop.0+0xe6/0x330
 p9_client_read_once+0x145/0x2b0
 p9_client_read+0x59/0x80
 v9fs_issue_read+0x3d/0xa0
 netfs_read_to_pagecache+0x27b/0x580
 netfs_readahead+0x197/0x2f0
 read_pages+0x4a/0x300
 page_cache_ra_unbounded+0x197/0x250
 page_cache_ra_order+0x2f7/0x400
 ? __this_cpu_preempt_check+0x13/0x20
 ? lock_release+0x168/0x290
 page_cache_async_ra+0x1be/0x220
 filemap_get_pages+0x2f3/0x870
 filemap_read+0xdc/0x470
 ? __this_cpu_preempt_check+0x13/0x20
 ? lock_acquire+0xcc/0x1c0
 ? preempt_count_add+0x4e/0xc0
 ? down_read_interruptible+0xb3/0x1b0
 netfs_buffered_read_iter+0x5c/0x90
 netfs_file_read_iter+0x29/0x40
 v9fs_file_read_iter+0x1b/0x30
 vfs_read+0x22b/0x330
 ksys_read+0x62/0xe0
 __x64_sys_read+0x19/0x20
 x64_sys_call+0x1b70/0x1d20
 do_syscall_64+0x47/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e


