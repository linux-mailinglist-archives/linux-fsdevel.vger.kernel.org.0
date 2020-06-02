Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154281EB4DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 07:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgFBFDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgFBFDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:03:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED7FC061A0E;
        Mon,  1 Jun 2020 22:03:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so203133ljh.7;
        Mon, 01 Jun 2020 22:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8QQzF6XIiPRpUJoXQeMmrlURiCVGEwgv/4YD02PeuX8=;
        b=nApo+80geSDN+ByG5z6cPNjFurqx7tudzrAoX6J5V7bcaYdbd9i9Xrmz+SdX4XHZWz
         6l3WLJ6fs9lS4RpF+E7Z9wTced8AOJ3GvshjofW5UdQW/CktX+SKuPTjYaBXkkp7llUK
         KsU6Z4YH3VICyfhJ52kNdGT/iXDHOCf3munKaPbG9O0I3P3pgLri1RVVxXX8eec0eL98
         7zOziHL0N73h/MdsM8+w8SzWtCkejiazpDVImU3XK1X/YNFwi8qXrk2yjANONjOprLnT
         Zylo31EqOpGX0YQhlrGKQ+iWDMz0fPm3WdY2tZNYb2JSIJPmz5np7eIqV1uXA+MkUjOy
         CTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8QQzF6XIiPRpUJoXQeMmrlURiCVGEwgv/4YD02PeuX8=;
        b=iLhvlXx9NQHFvIvup/csd46XwDTXJjtkbVFHXyhMXBhH4VPL8QLBo7Ql34XEhLa9wF
         Lc05a/IkGNFo4khFvgyu1BCfter+21mgU3xRbPk6jq8kFEb5q0XMq+quFKmakf7AF/Hw
         H6bJBgniwlP3D5H2fAE/tOmHO0nl0QD1G4mwccqQLAAjyBLytnAML6g/SCE/L0VrXbex
         zYqwTFUh0741BWenKwOcbLgRVmZmsfBlathU3rBOwWMxAv2qbXXqsrZKY21aabnT3KiW
         z83j/nn3oZER0y2O8DGdS7mBUhfpI6bK0VDB+16xqOkdibNFjAuYLiVJ2MtE/ldXVUOA
         0DLw==
X-Gm-Message-State: AOAM531wj4L2/EcWTsGzdUd+MiNiTfhmfVEz7vna33/IvCITfF1ci1Q8
        4rseyqhmyug1FYX2jh+y6Qh2wpjAoZwu31RB4eo9J6FhQcs=
X-Google-Smtp-Source: ABdhPJwmCdnzeqKLpf9U2YYQ95O2iAC3SnSKcMlolf3vqQ0bMp2Cr6AlgaAAI/ze/2Xs8LnfCdKLsgMZkcAdTy5xeeo=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr12417458ljp.57.1591074196664;
 Mon, 01 Jun 2020 22:03:16 -0700 (PDT)
MIME-Version: 1.0
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 2 Jun 2020 13:03:05 +0800
Message-ID: <CAFcO6XPVo-u0CkBxy0Ox+FPfqgPUwmo0pnVYrLCP6EM05Sd6-A@mail.gmail.com>
Subject: memory leak in exfat_parse_param
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I report a bug (in linux-5.7.0-rc7) found by syzkaller.

kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/config-v5.7.0-rc7

and can reproduce.

A param->string held by exfat_mount_options.

BUG: memory leak

unreferenced object 0xffff88801972e090 (size 8):
  comm "syz-executor.2", pid 16298, jiffies 4295172466 (age 14.060s)
  hex dump (first 8 bytes):
    6b 6f 69 38 2d 75 00 00                          koi8-u..
  backtrace:
    [<000000005bfe35d6>] kstrdup+0x36/0x70 mm/util.c:60
    [<0000000018ed3277>] exfat_parse_param+0x160/0x5e0 fs/exfat/super.c:276
    [<000000007680462b>] vfs_parse_fs_param+0x2b4/0x610 fs/fs_context.c:147
    [<0000000097c027f2>] vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:191
    [<00000000371bf78f>] generic_parse_monolithic+0x16f/0x1f0
fs/fs_context.c:231
    [<000000005ce5eb1b>] do_new_mount fs/namespace.c:2812 [inline]
    [<000000005ce5eb1b>] do_mount+0x12bb/0x1b30 fs/namespace.c:3141
    [<00000000b642040c>] __do_sys_mount fs/namespace.c:3350 [inline]
    [<00000000b642040c>] __se_sys_mount fs/namespace.c:3327 [inline]
    [<00000000b642040c>] __x64_sys_mount+0x18f/0x230 fs/namespace.c:3327
    [<000000003b024e98>] do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
    [<00000000ce2b698c>] entry_SYSCALL_64_after_hwframe+0x49/0xb3
