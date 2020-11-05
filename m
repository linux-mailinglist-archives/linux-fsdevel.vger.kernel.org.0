Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161F42A7588
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 03:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKECdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 21:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgKECdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:33:18 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67DC0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 18:33:17 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id d24so591448ljg.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQYqfWNVXmL+M453pURwo+uK/Pyjt/WUlq/Af24pD3c=;
        b=kl5fQE7QFRo1f3Q7w7tLkO2pxRcXzDzJ2TDGvD7vrb6sJwRSfGPMbjowHOoHpjIyNy
         /Elj5mJdWn8zsaSqcsCxgCrd2imjzPfniUXQDRrGfUS4A0bffJG6WwdCQ2SeG/kakI4p
         kkBa3LpHLCNhg3Ud7y59bDhizkirSoPBr/AJMdWC/dpi88ViyfQmvRDoM2SY86R5Eg+t
         +tWxuRnYmLPs7Q3N8GdpenbO3fUWprc0DaEzOuxrQoA7Zwp0EWNYdfm89Tjv+IrBKKkD
         Uy4XyZrHP46lRP83E5J/cTCkBX7WI1GA4H1SAF7ATGs6C3VFCWojqCbMUaac9H88U2tV
         zX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQYqfWNVXmL+M453pURwo+uK/Pyjt/WUlq/Af24pD3c=;
        b=XaYQX5xrb10t0yf+ThMVmEAVa8F8C3oBWIDD3sAgWYUPxc6S5y8c2p70v1GJEycsve
         1QV7KoDsBiDXMY07Vrb7w/pj98AL+CYgUWzBXwhOQCvRR3WHTd6UxRIDAjDEWA0QnNLO
         YWV6hk9UvKnMgo3bttKtjMvVyootDd+nx3zAJg/YmY03SG6f2fLuzgjDcDPvniT/wHuG
         EVhGgq4hWNTKDmqqFNUK//xRVLrUqHpGKLe7f53FcipKcBfr86BeiYjJPrBqXbLQ0OBQ
         Vr3jiyUNAC6LSRkpzWFT54jUO1HxjJetM9wg6IMUUDg/R13rY1FE806jPKw/6o5FHq+3
         JKuw==
X-Gm-Message-State: AOAM532jsv29Bas57dWg5uUjGX6xdZv5vGUzxgUhIOn/K5UIE1t2igq9
        wK+LRyI2ZF97xR8dVMutooQ0Zyr2GRVoiSoja8Q2qZeEHNv5OzoK
X-Google-Smtp-Source: ABdhPJyMRjAMdRgOOu6tuY86KhCAujKDCCLSjZS0qK0UWuzPJc6wpdP+2Wx6B5lYYVpu2oMlK99j0JWBKwszYgMYgfM=
X-Received: by 2002:a2e:810f:: with SMTP id d15mr66992ljg.62.1604543596349;
 Wed, 04 Nov 2020 18:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20201103142852.8543-1-willy@infradead.org> <20201103171054.7d80b3010cac0bee705d0ae7@linux-foundation.org>
In-Reply-To: <20201103171054.7d80b3010cac0bee705d0ae7@linux-foundation.org>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Thu, 5 Nov 2020 11:33:05 +0900
Message-ID: <CAEcHRTqE16z-tHnKQcizVZ=aOP35wdzSVFr3JinW64KNRBTzdw@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix readahead_page_batch for retry entries
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 4, 2020 at 10:10 AM Andrew Morton <akpm@linux-foundation.org> wrote:

> It would be helpful to to provide sufficient info so that a reader of
> this changelog can recognize whether this patch might fix some problem
> which is being observed.

As you can see below the panic log, the accessing 0x402 causes panic.
In the xarray.h, 0x402 means RETRY_ENTRY.

BUG: kernel NULL pointer dereference, address: 0000000000000402
CPU: 14 PID: 306003 Comm: as Not tainted 5.9.0-1-amd64 #1 Debian 5.9.1-1
Hardware name: Lenovo ThinkSystem SR665/7D2VCTO1WW, BIOS D8E106Q-1.01 05/30/2020
RIP: 0010:fuse_readahead+0x152/0x470 [fuse]
Code: 41 8b 57 18 4c 8d 54 10 ff 4c 89 d6 48 8d 7c 24 10 e8 d2 e3 28
f9 48 85 c0 0f 84 fe 00 00 00 44 89 f2 49 89 04 d4 44 8d 72 01 <48> 8b
10 41 8b 4f 1c 48 c1 ea 10 83 e2 01 80 fa 01 19 d2 81 e2 01
RSP: 0018:ffffad99ceaebc50 EFLAGS: 00010246
RAX: 0000000000000402 RBX: 0000000000000001 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffff94c5af90bd98 RDI: ffffad99ceaebc60
RBP: ffff94ddc1749a00 R08: 0000000000000402 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000100 R12: ffff94de6c429ce0
R13: ffff94de6c4d3700 R14: 0000000000000001 R15: ffffad99ceaebd68
FS:  00007f228c5c7040(0000) GS:ffff94de8ed80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000402 CR3: 0000001dbd9b4000 CR4: 0000000000350ee0
Call Trace:
  read_pages+0x83/0x270
  page_cache_readahead_unbounded+0x197/0x230
  generic_file_buffered_read+0x57a/0xa20
  new_sync_read+0x112/0x1a0
  vfs_read+0xf8/0x180
  ksys_read+0x5f/0xe0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
