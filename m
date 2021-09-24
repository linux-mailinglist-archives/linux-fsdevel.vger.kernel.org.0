Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD46417800
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhIXPsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhIXPs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:48:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B3C061571
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 08:46:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t13so3924181qtc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xyb9Fo0Z1UnV7+NXWV2U9pvWT/Hzng851n0k8kXhl+E=;
        b=rA5bI48uXssga616Sx+1DlmCoR4CjfgOycswGvD6x6tYuItqzPgqj1/UOP1ZXFvlP2
         Sh9U0AignKLqAEr3h0zuS5RnGE0SC2HiJFMlz9RGTqjaRbd5mXP4CDvWCkC/pumclHu4
         Qh/lEmqIbTERCv2qY8mjrcM6nJJc8yi5tIh94zgvvCmwxh3tW4Ans2YsUumCPoJD+Oia
         qRXmeRAyT1UMu4scSBvva1GdpD0usRFXOycfkZ47NxpJfaGE5bXQMMOhcnzYqk2esfs6
         Yv6zrA3Q0Gj7U5+GwX44g1vB0vA/WRPrzyE8Hat2601g/HrHfeTEW46y484oQnJX8Vun
         EEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=xyb9Fo0Z1UnV7+NXWV2U9pvWT/Hzng851n0k8kXhl+E=;
        b=BrBnRDBcp6VHvXrrEbprtnI+hybZWHSTRlGzBlUiMAy1wO8hZe0rPluV5zwg99Z69c
         dKP5WuNPt303vKjWzO7qFSydLozptuvE4l/m91dpqe+e+WUaLI3tDI/ykKbJVxmL3wyf
         IgSHtaYKTXTtwVfJxKEVDEVRS6EKVq96Mt3+D0EzTtW72vTh78uUWSM+bQXcLpoBNpfc
         oA9Jh03u8tuHprsnA4j+2AVCFTQlkqDpQ1dLHyESwXPA2Lo86EsmhN/PulVB5QRnPqqx
         t6F9t5H7Pi/wf4CVJgIVgN+okZVAYW9CMqXsP+NxofXa9yCwMADpPZtSNxGXEKAvUrMZ
         Mkhg==
X-Gm-Message-State: AOAM531320oFK5pItkbOobEJhKwtHLxTqD5ix0VgHGz9HNB4KWU2dFjO
        2Q6/BPLwhP2PjIzEryPcgajJG8N0xt5R1p+kfcWEsw0q5z7OSQ==
X-Google-Smtp-Source: ABdhPJxFs0TLE7nKPvn9HLAXkz6nzSdotaUl5FHIYQml4rKs5Zxps8s2iBVyZYkX4kAPMcAOqI5Q4wc+EKLZoMhiFxw=
X-Received: by 2002:ac8:56eb:: with SMTP id 11mr3222290qtu.246.1632498405583;
 Fri, 24 Sep 2021 08:46:45 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 24 Sep 2021 17:46:09 +0200
Message-ID: <CAG_fn=VPO65xw7NGp0k+J8tpCdzd2P5Fauant25RWJNZb3WCmQ@mail.gmail.com>
Subject: Use of uninitialized dentry->d_time in kernfs_dop_revalidate()
To:     raven@themaw.net, mszeredi@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ian, Miklos,

I've just rebased KMSAN to v5.15-rc2 and am seeing the following
reports at kernel boot-time:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
BUG: KMSAN: uninit-value in kernfs_dop_revalidate+0x61f/0x840
fs/kernfs/dir.c:1053
 kernfs_dop_revalidate+0x61f/0x840 fs/kernfs/dir.c:1053
 d_revalidate fs/namei.c:854
 lookup_dcache fs/namei.c:1522
 __lookup_hash+0x3a6/0x590 fs/namei.c:1543
 filename_create+0x312/0x7c0 fs/namei.c:3657
 do_mkdirat+0x103/0x930 fs/namei.c:3900
 __do_sys_mkdir fs/namei.c:3931
 __se_sys_mkdir fs/namei.c:3929
 __x64_sys_mkdir+0xda/0x120 fs/namei.c:3929
 do_syscall_x64 arch/x86/entry/common.c:51

Uninit was created at:
 slab_alloc_node mm/slub.c:3221
 slab_alloc mm/slub.c:3230
 kmem_cache_alloc+0x71f/0x1010 mm/slub.c:3235
 __d_alloc+0x85/0xc60 fs/dcache.c:1744
 d_alloc fs/dcache.c:1823
 d_alloc_parallel+0x12b/0x2210 fs/dcache.c:2575
 __lookup_slow+0x1a8/0x7e0 fs/namei.c:1642
 lookup_slow+0xe0/0x140 fs/namei.c:1674
 walk_component fs/namei.c:1970
 link_path_walk+0x1252/0x18a0 fs/namei.c:2297
 path_openat+0x395/0x5d30 fs/namei.c:3557
 do_filp_open+0x29b/0x6a0 fs/namei.c:3588
 do_sys_openat2+0x261/0x8f0 fs/open.c:1200
 do_sys_open fs/open.c:1216
 __do_sys_open fs/open.c:1224
 __se_sys_open fs/open.c:1220
 __x64_sys_open+0x308/0x370 fs/open.c:1220
 do_syscall_x64 arch/x86/entry/common.c:51
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Looks like some code forgets to initialize dentry->d_time before
comparing it to parent->dir.rev in kernfs_dir_changed(). When I change
__d_alloc() to allocate dentry with __GFP_ZERO, the problem goes away.

Could you please take a look?

Thanks,
Alex
--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
