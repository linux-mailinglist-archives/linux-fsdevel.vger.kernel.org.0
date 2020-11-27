Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8642C6186
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 10:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgK0JVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 04:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgK0JVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:21:07 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BD6C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 01:21:06 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b6so4010102pfp.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 01:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlPx3D5OXHB3+bHYIYOC/2iLJYt2laDE8eD7s5RHs1A=;
        b=AF/93sZng2Jpchw688suTMaOITMbGX2shVh+vKA4ZUXwvo98Mv3TqqtO0ZP5fxrPdz
         dodDdIsrnZ6jlZTj31N4emPWoFqjIYW0/47hCrQkeO4R65ChCzucA5bs6nekcpyzhrkh
         LkzPmr7FIyHy1NknUTUVp0WcMxPk0Y0m1o5ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlPx3D5OXHB3+bHYIYOC/2iLJYt2laDE8eD7s5RHs1A=;
        b=WuWtc1aYFVryFky3xO6yL9cuTb/uB4QlAoGASuZezk6kEPv8WHYY4imnAc58cFF5pM
         JrC4HmSqkIZKeffuimmzRwglbCCG+U10vHvs20ciKolm/O/AYaZAtmCZ/vhqwZ5oDNAn
         mOQH8yxesSujb+ySP4ULl5pKVKwEki/29l1zCUv3n8yTb7ALIFQZZw6b7Fm5HQV1Nn86
         VFzGl+iR21ryt+Nhqi5CsD0DkV8uX+v6LDvJfA1Y+ARNAn9QwJNUENwuW5jhN01idtiX
         G+IznzXn+7zUq6TChjNR25ixXNnbcy0INEb3v1jZplDj3f54NetC0oHqlfWGVZai/OqJ
         4ckg==
X-Gm-Message-State: AOAM531+RZKVzoB1sqE98woVfWL/b+izWIXenbjiOP+iCu7iGhAVblYT
        9zXOB7vMKQKbbAAHXIz6r5eh6w==
X-Google-Smtp-Source: ABdhPJzb6MrII5EGaD2Ma7r6y4r5a7mmT/w1ly/jearBVl7o4Do185z1fw1HjYPQlowr/CvPvJmvsg==
X-Received: by 2002:aa7:8c16:0:b029:196:33d2:721f with SMTP id c22-20020aa78c160000b029019633d2721fmr6227235pfd.70.1606468866312;
        Fri, 27 Nov 2020 01:21:06 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id t9sm9938944pjq.46.2020.11.27.01.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:21:05 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v2 0/4] Make overlayfs volatile mounts reusable
Date:   Fri, 27 Nov 2020 01:20:54 -0800
Message-Id: <20201127092058.15117-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds some documentation on how the current behaviour of overlayfs
works, and adds some non-obvious caveats to the documentation. We may want
to pick those up independently.

The volatile option is great for "ephemeral" containers. Unfortunately,
it doesn't capture all uses. There are two ways to use it safely right now:

1. Throw away the entire upperdir between mounts
2. Manually syncfs between mounts

For certain use-cases like serverless, or short-lived containers, it is
advantageous to be able to stop the container (runtime) and start it up on
demand / invocation of the function. Usually, there is some bootstrap
process which involves downloading some artifacts, or putting secrets on
disk, and then upon invocation of the function, you want to (re)start the
container.

If you have to syncfs every time you do this, it can lead to excess
filesystem overhead for all of the other containers on the machine, and
stall out every container who's upperdir is on the same underlying
filesystem, unless your filesystem offers something like subvolumes,
and if sync can be restricted to a subvolume.

The kernel has information that it can use to determine whether or not this
is safe -- primarily if the underlying FS has had writeback errors or not.
Overlayfs doesn't delay writes, so the consistency of the upperdir is not
contingent on the mount of overlayfs, but rather the mount of the
underlying filesystem. It can also make sure the underlying filesystem
wasn't remounted. Although, it was suggested that we use derive this
information from the upperdir's inode[1], we can checkpoint this data on
disk in an xattr.

Specifically we checkpoint:
  * Superblock "id": This is a new concept introduced in one of the patches
    which keeps track of (re)mounts of filesystems, by having a per boot
    monotonically increasing integer identifying the superblock. This is
    safer than trying to obfuscate the pointer and putting it into an
    xattr (due to leak risk, and address reuse), and during the course
    of a boot, the u64 should not wrap.
  * Overlay "boot id": This is a new UUID that is overlayfs specific,
    as overlayfs is a module that's independent from the rest of the
    system and can be (re)loaded independently -- thus it generates
    a UUID at load time which can be used to uniquely identify it.
  * upperdir / workdir errseq: A sample of the errseq_t on the workdir /
    upperdir's superblock. Since the errseq_t is implemented as a u32
    with errno + error counter, we can safely store it in a checkpoint.

This has to be done in kernelspace because userspace does not have access
to information such as superblock (re)mounts, the writeback errseq value,
and whether the module has been (re)loaded. Although this mechanism only
determines a subset of the error scenarios, it lays out the groundwork
for adding more.

In the future, we may want to make it so overlayfs shuts down on errors,
or have some kind of other behaviour when errors are detected. If we want
a per-file (on the upperdir) piece of metadata can be added indicating
errseq_t for just that file, and we can check it on each close / open,
and then allow the user to make an intelligent decision of how they want
overlayfs to handle the error. This would allow for errors to be captured
during normal operation as opposed to just between remounts.

This also allows for:
volatile -> volatile
non-volatile -> volatile
non-volatile -> non-volatile

But, for now, prevents volatile -> non-volatile. Perhaps with the future
patches around selective inode sync, and tracking errors on every
interaction will make this possible.


Changes since:
V1 [2]:
 * Add documentation commit about current short-comings of the current volatile
   implementation.
 * Do not allow volatile mounts to be mounted as non-volatile
RFC [3]:
 * Changed datastructure names
 * No longer delete the volatile dir / dirty file
 * Moved xattr to volatile directory
 * Split errseq check

[1]: https://lore.kernel.org/linux-unionfs/CAOQ4uxhadzC3-kh-igfxv3pAmC3ocDtAQTxByu4hrn8KtZuieQ@mail.gmail.com/
[2]: https://lore.kernel.org/linux-unionfs/20201125104621.18838-1-sargun@sargun.me/T/#t
[3]: https://lore.kernel.org/linux-unionfs/20201116045758.21774-1-sargun@sargun.me/T/#t

Sargun Dhillon (4):
  fs: Add s_instance_id field to superblock for unique identification
  overlay: Document current outstanding shortcoming of volatile
  overlay: Add the ability to remount volatile directories when safe
  overlay: Add rudimentary checking of writeback errseq on volatile
    remount

 Documentation/filesystems/overlayfs.rst |  24 ++++--
 fs/overlayfs/overlayfs.h                |  38 ++++++++-
 fs/overlayfs/readdir.c                  | 104 +++++++++++++++++++++---
 fs/overlayfs/super.c                    |  74 +++++++++++++----
 fs/overlayfs/util.c                     |   2 +
 fs/super.c                              |   3 +
 include/linux/fs.h                      |   7 ++
 7 files changed, 213 insertions(+), 39 deletions(-)


base-commit: be4df0cea08a8b59eb38d73de988b7ba8022df41
-- 
2.25.1

