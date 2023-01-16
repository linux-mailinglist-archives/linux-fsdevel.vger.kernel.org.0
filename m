Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B227766C53A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 17:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjAPQDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 11:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjAPQDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D12385B
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673884918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8pukx+I4QrScYN3Z5nRX9xtPFWya2FweofKXHmiiGPg=;
        b=UelQ2sYcbHa9PnXNk4BHAS5CxIdOwtzUkeLnK2yTSIKneeuT5O7LymnM9LDu4J+ZvXMl1E
        9p4MV/olRA3zOFFPnyN4fFspvGKK/k5IJPXylax1ioV4shotAbfZ9JOKe8fmdNhsLRyyh/
        Q/y/p66nyKDK5nEjh9AJfLja3IKxNEA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-ifNPrZcoO5aLBvu_n-6qtw-1; Mon, 16 Jan 2023 11:01:54 -0500
X-MC-Unique: ifNPrZcoO5aLBvu_n-6qtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ECF91C00426;
        Mon, 16 Jan 2023 16:01:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9562140C2008;
        Mon, 16 Jan 2023 16:01:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
cc:     dhowells@redhat.com
Subject: Is there a reason why REQ_OP_READ has to be 0?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2117828.1673884910.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 16 Jan 2023 16:01:50 +0000
Message-ID: <2117829.1673884910@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens, Christoph,

Do you know if there's a reason why REQ_OP_READ has to be 0?  I'm seeing a
circumstance where a direct I/O write on a blockdev is BUG'ing in my modif=
ied
iov_iter code because the iterator says it's a source iterator (correct), =
but
the bio->bi_opf =3D=3D REQ_OP_READ (which should be wrong).

I thought I'd move REQ_OP_READ to, say, 4 so that I could try and see if i=
t's
just undefined but the kernel BUGs and then panics during boot.

David

------------[ cut here ]------------
kernel BUG at mm/filemap.c:1615!
------------[ cut here ]------------
invalid opcode: 0000 [#1] PREEMPT SMP PTI
kernel BUG at mm/filemap.c:1615!
CPU: 1 PID: 2196 Comm: systemd-udevd Not tainted 6.2.0-rc2-build3+ #12783
Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
RIP: 0010:folio_end_writeback+0x30/0x70
Code: 48 8b 07 48 89 fb 0f ba e0 12 73 0a f0 80 67 02 fb e8 d0 de 00 00 48=
 89 df e8 fe df ff ff 48 89 df e8 f9 ac 00 00 84 c0 75 02 <0f> 0b 48 8b 03=
 84 c0 79 0d be 0f 00 00 00 48 89 df e8 44 f3 ff ff
RSP: 0000:ffff8881091a3db8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea0004271d40 RCX: 0000000000001000
RDX: 0000000000000101 RSI: 0000000000000246 RDI: ffff888107694000
RBP: ffff888100b6f600 R08: 000000204d567e99 R09: 0000000000000200
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000001000 R15: ffff888107402080
FS:  00007f65ecde8940(0000) GS:ffff88840fa80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb269292ba1 CR3: 0000000107140004 CR4: 00000000001706e0
Call Trace:
 <TASK>
 mpage_end_io+0x91/0x9b
 blk_update_request+0x200/0x2be
 scsi_end_request+0x27/0xf3
 scsi_io_completion+0x151/0x21e
 blk_complete_reqs+0x41/0x4c
 __do_softirq+0x123/0x27d
 __irq_exit_rcu+0x5a/0xcd
 common_interrupt+0x36/0xbc
 asm_common_interrupt+0x22/0x40
RIP: 0033:0x7f65edc7ab60
Code: 00 41 29 c5 4a 8d 14 ed 00 00 00 00 49 8d 34 0c 49 8d 7c 0c f8 e8 d0=
 5e ff ff 83 6d 20 01 eb 9f 66 2e 0f 1f 84 00 00 00 00 00 <f3> 0f 1e fa 53=
 48 89 fb 48 83 c7 08 e8 7f 60 ff ff 85 c0 75 0b 48
RSP: 002b:00007ffe0b70bd88 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 000055ddc430c5dc RCX: 000055ddc4301f98
RDX: 00000000000000ff RSI: 000000000000000c RDI: 000055ddc4301f98
RBP: 00007ffe0b7102d0 R08: 45d54cec8b358fc3 R09: 00544145535f4449
R10: 000000000000000c R11: f17eedd8cae0d043 R12: 000055ddc4302920
R13: 000055ddc432091a R14: 000055ddc4308460 R15: 000055ddc42d90dc
 </TASK>
Modules linked in:
invalid opcode: 0000 [#2] PREEMPT SMP PTI

