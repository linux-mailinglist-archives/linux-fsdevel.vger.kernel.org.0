Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E03903A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhEYORJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 10:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhEYORH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 10:17:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18825C061574;
        Tue, 25 May 2021 07:15:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so13332066pjb.2;
        Tue, 25 May 2021 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkrPM/NRzA6OLUovY7PwHEBUVl4w30B98SQNLF5Vt4A=;
        b=sJyiqTVSXQe4MClO/qmJb1twLFSWoRFzr8d6RSsxbqPEyE9lgDrtgStylxNBnBiH4i
         rp9t+pvMFgeQksIDl6KQnoXLyZ9cNVH1NqRvw0gZXMyBmyrH+doO+hCg5HILI4YUpguG
         60oMoKxHbBUhQlUXIKUEVMd6/cgaB28EBGVcVdy/kkeDki5VJyGg3W09hvPmPPzsH00L
         CDYzarx4/KVBpZBY/bSMjAPHXbxl6vJ5GHZWJsT81iGVD+KJnBUgOZkG06iTTFgAOdlC
         M29+r74g0HXdTpaNZ4ttLxMlpmJKKzZfg0HG7r500yNqSaUgQiQtDb4CDZARRTTXOded
         7WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkrPM/NRzA6OLUovY7PwHEBUVl4w30B98SQNLF5Vt4A=;
        b=qkCKAmY1EoP4Gu9kHKk638Y9gIh6A7SFJhG5fg0Shj5hGF1+6pep/O52syzDTSbJrK
         q9nsgA8fNS+buSuTWSBPTv0b0y9TrrClwbRvJSEU2OXIXEUl3P4sh4LpY/e/1x9ClL/5
         mxUJzJJmEY1znWCjhFUpbX5biipvWAX+/xxedpZTVNt0yG65LoZkTBsDrQQ4JcDVnAtQ
         Jx4aQIGcicRlmT0nbVq34DRTYeUUKLEmDcCGejc38H+gJUDkE9qYBdSfcLosT6mkM/hE
         OwAEV+d9QWIZb6ayoDtAX1JOI5QX9WG2RtfzsRmFYIEKX5ZwfMqf+G2ybDTnXdNPBpxK
         IfBA==
X-Gm-Message-State: AOAM530ZECiyANbrm+mdqYuYALfJRxg3txCetR7vtxHaEC3Pi/JcMuSs
        5YsNokF+ugyIsfOEnJATPtE=
X-Google-Smtp-Source: ABdhPJwPd1Sg0Q72B84W0/jhk4LwlrDUUHHT5A84wehRr6TTTi5c2aAxJtH30eScZ/ecomC65qZAXA==
X-Received: by 2002:a17:90b:14c3:: with SMTP id jz3mr4907353pjb.152.1621952137471;
        Tue, 25 May 2021 07:15:37 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id u7sm2261526pjc.16.2021.05.25.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:15:36 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mcgrof@kernel.org, josh@joshtriplett.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        bhelgaas@google.com, masahiroy@kernel.org,
        dong.menglong@zte.com.cn, joe@perches.com, axboe@kernel.dk,
        hare@suse.de, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, f.fainelli@gmail.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, wangkefeng.wang@huawei.com,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        chris@chrisdown.name, ebiederm@xmission.com, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org, mingo@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeyu@kernel.org
Subject: [PATCH v2 0/3] init/initramfs.c: make initramfs support pivot_root
Date:   Tue, 25 May 2021 22:15:21 +0800
Message-Id: <20210525141524.3995-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

As Luis Chamberlain suggested, I split the patch:
[init/initramfs.c: make initramfs support pivot_root]
(https://lore.kernel.org/linux-fsdevel/20210520154244.20209-1-dong.menglong@zte.com.cn/)
into three.

The goal of the series patches is to make pivot_root() support initramfs.

In the first patch, I introduce the function ramdisk_exec_exist(), which
is used to check the exist of 'ramdisk_execute_command' in LOOKUP_DOWN
lookup mode.

In the second patch, I create a second mount, which is called
'user root', and make it become the root. Therefore, the root has a
parent mount, and it can be umounted or pivot_root.

In the third patch, I fix rootfs_fs_type with ramfs, as it is not used
directly any more, and it make no sense to switch it between ramfs and
tmpfs, just fix it with ramfs to simplify the code.

Changes since V1:

In the first patch, I add the flag LOOKUP_DOWN to init_eaccess(), to make
it support the check of filesystem mounted on '/'.

In the second patch, I control 'user root' with kconfig option
'CONFIG_INITRAMFS_USER_ROOT', and add some comments, as Luis Chamberlain
suggested.

In the third patch, I make 'rootfs_fs_type' in control of
'CONFIG_INITRAMFS_USER_ROOT'.



Menglong Dong (3):
  init/main.c: introduce function ramdisk_exec_exist()
  init/do_cmounts.c: introduce 'user_root' for initramfs
  init/do_mounts.c: fix rootfs_fs_type with ramfs

 fs/init.c            |   2 +-
 include/linux/init.h |   5 ++
 init/do_mounts.c     | 109 +++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h     |  18 ++++++-
 init/initramfs.c     |  10 ++++
 init/main.c          |   7 ++-
 usr/Kconfig          |  10 ++++
 7 files changed, 158 insertions(+), 3 deletions(-)

-- 
2.32.0.rc0

