Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CFD54F9EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383059AbiFQPMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382966AbiFQPMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4035541308
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655478743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=IchAmwo0SaHdL4wHu2LsM5UV8Cx8Y6esFaus+GxxJPQ=;
        b=PbZaNXhIb5DF+qhQAzIhWWRk4YiBwW4Xgf4Ef6vw4RvGlmMyyOkb5DXHoLaNR6AuysQ0PH
        ImbIkZ6L9YY7PoDFaYjNo5wkIIklyBoG8rbtdK7tdXcVUFxV0VUO65Oc2dy6kkttEz1pPY
        pUKmElAo66kY+tLmHnQECqkQPpz6GWU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-3aoaiIKXOQGUOLXA32x_Ow-1; Fri, 17 Jun 2022 11:12:21 -0400
X-MC-Unique: 3aoaiIKXOQGUOLXA32x_Ow-1
Received: by mail-qk1-f200.google.com with SMTP id az18-20020a05620a171200b006a708307e94so5254219qkb.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 08:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=IchAmwo0SaHdL4wHu2LsM5UV8Cx8Y6esFaus+GxxJPQ=;
        b=c1G4k07xdt/WKNKTfComs4idHUTeRl37miGC1heidtcFwkj37N+WTmx3ljtp6XWW+J
         NZOU0QTJc+xsaZOz4JkWPhQWmKPvI7LZvvvpEcShv1T9h91ZZcHOkgAP9SEDMyrtHBGy
         GPqobJBRUJUQBQi4L4RifuGC6ovTy6K3j+ixWM1PTugRhiKdwmgr/9ecIyAxtEuS21TX
         0ChviHAEIE4OLJahvu9T62UWNWyIAYIPBt5nrcwAj/giGDsAhmw/GIBZvKE2nNJt+HNe
         W5D8jAzaJj4m7HKAHjv3Km/nDv19zjF7wn9vH396tCJ6bN3Sn4LwDrPwajZjw6EqaSM/
         /teA==
X-Gm-Message-State: AJIora+unC82eSEAQ+Z3By2MVre4BDWpqZpHq93plDdAmJ4rAfyLlFc4
        CqdGfTEoYdsdeKVuls1w4hlIeCe9Q7JnzkuVZqgYFNKWLSnjwk6UCB36yqM9nccdo1csX85h8G9
        QS8RmLaYIspk0RqLTAlNzJwmmT1/GicU+WnfGcRA0A47kaIAMSPQYa9EPbIA48aiVa7+9UhnH9y
        Hn
X-Received: by 2002:a05:620a:bc9:b0:6a9:8e98:8b94 with SMTP id s9-20020a05620a0bc900b006a98e988b94mr7381616qki.729.1655478741013;
        Fri, 17 Jun 2022 08:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRmBefQDOhd1WK2z//524xVXVObxsdcEWjH40XurpUvQoTnY0yoGbsTCweTRjFeVa3iy7kUA==
X-Received: by 2002:a05:620a:bc9:b0:6a9:8e98:8b94 with SMTP id s9-20020a05620a0bc900b006a98e988b94mr7381582qki.729.1655478740544;
        Fri, 17 Jun 2022 08:12:20 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00304ef50af9fsm4426058qtr.2.2022.06.17.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 08:12:20 -0700 (PDT)
Date:   Fri, 17 Jun 2022 11:12:18 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [BUG] filemap_get_read_batch()
Message-ID: <YqyZ0gsIqiAzJfeU@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've hit the filemap_get_read_batch() BUG [1] that I think I saw Dave
had also recently reported. It looks like the problem is essentially a
race between reads, pagecache removal and folio reinsertion that leads
to an invalid folio pointer. E.g., what I observe is the following
(ordered) sequence of events:

Task A:
- Lands in filemap_get_read_batch() looking for a couple folio indexes,
  currently both populated by single page folios.
- Grabs the folio at the first index and starts to process it.

Task B:
- Invalidates several folios from the mapping, including both the
  aforementioned folios task A is after.

Task C: 
- Instantiates a compound (order 2) folio that covers both indexes being
  processed by task A.

Task A:
- Iterates to the next xarray index based on the (now already removed)
  non-compound folio via xas_advance()/xas_next().
- BUG splat down in folio_try_get_rcu() on the folio pointer..

I'm not quite sure what is being returned from the xarray here. It
doesn't appear to be another page or anything (i.e. a tail page of a
different folio sort of like we saw with the iomap writeback completion
issue). I just get more splats if I try to access it purely as a page,
so I'm not sure it's a pointer at all. I don't have enough context on
the xarray bits to intuit on whether it might be internal data or just
garbage if the node happened to be reformatted, etc. If you have any
thoughts on extra things to check around that I can try to dig further
into it..

In any event, it sort of feels like somehow or another this folio order
change peturbs the xarray iteration since IIUC the non-compound page
variant has been in place for a while, but that could just be wrong or
circumstance. I'm not sure if it's possible to check the xarray node for
such changes or whatever before attempting to process the returned entry
(and to preserve the lockless algorithm). FWIW wrapping the whole lookup
around an xa_lock_irq(&mapping->i_pages) lock cycle does make the
problem disappear.

Brian

[1]

BUG: kernel NULL pointer dereference, address: 0000000000000106
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 72 PID: 297881 Comm: xfs_io Tainted: G          I       5.19.0-rc2+ #160
Hardware name: Dell Inc. PowerEdge R740/01KPX8, BIOS 1.6.11 11/20/2018
RIP: 0010:filemap_get_read_batch+0x8e/0x240
Code: 81 ff 06 04 00 00 0f 84 f7 00 00 00 48 81 ff 02 04 00 00 0f 84 c4 00 00 00 48 39 6c 24 08 0f 87 84 00 00 00 40 f6 c7 01 75 7e <8b> 47 34 85 c0 0f 84 a8 00 00 00 8d 50 01 48 8d 77 34 f0 0f b1 57
RSP: 0018:ffffacdf200d7c28 EFLAGS: 00010246
RAX: 0000000000000039 RBX: ffffacdf200d7d68 RCX: 0000000000000034
RDX: ffff9b2aa6805220 RSI: 0000000000000074 RDI: 00000000000000d2
RBP: 0000000000000075 R08: 0000000000000402 R09: ffff9b2a89ac4488
R10: 0000000000020000 R11: 0000000000000000 R12: ffff9b2a89ac4600
R13: 0000000000000075 R14: 0000000000000074 R15: ffffacdf200d7e88
FS:  00007fbba6ce7800(0000) GS:ffff9b29c1100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000106 CR3: 0000000150c7e001 CR4: 00000000007706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 filemap_get_pages+0x80/0x710
 ? current_time+0x1b/0xd0
 ? atime_needs_update+0xfc/0x170
 ? touch_atime+0x27/0x190
 filemap_read+0xa8/0x310
 ? __folio_start_writeback+0x91/0x2d0
 ? folio_add_lru+0x8d/0x100
 ? _raw_spin_unlock+0x15/0x30
 ? __handle_mm_fault+0xd13/0xf50
 xfs_file_buffered_read+0x50/0xd0 [xfs]
 xfs_file_read_iter+0x70/0xd0 [xfs]
 new_sync_read+0xf6/0x160
 vfs_read+0x138/0x190
 __x64_sys_pread64+0x6e/0xa0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fbba71fa1ef
Code: 08 89 3c 24 48 89 4c 24 18 e8 2d f4 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 7d f4 ff ff 48 8b
RSP: 002b:00007ffcdc03d0d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbba71fa1ef
RDX: 0000000000001000 RSI: 000056021a601000 RDI: 0000000000000003
RBP: 0000000000074000 R08: 0000000000000000 R09: 00007fbba7140a60
R10: 0000000000074000 R11: 0000000000000293 R12: 0000000000074000
R13: 000000000002c000 R14: 00000000000a0000 R15: 0000000000001000

