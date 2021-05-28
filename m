Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8648739444B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhE1Okq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1Okp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 10:40:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE7C06174A;
        Fri, 28 May 2021 07:39:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f22so3439423pfn.0;
        Fri, 28 May 2021 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lv0Kb494zFJwqBOfwUjOAI6JWygR12iP5UgAX5IqtW8=;
        b=dEqvQr3dOmcSgqSUciWdOQWg+qp2Vj6exhTuu5GNWOXP2keZSQMBqMOiVDechqOAPB
         MYw+9VNd8qFhij33PpiL2+s+J9VKQ6tjCStmJtzUIgFZ/2XZEs1Zb5nlQAHrVX2MZO57
         tZZ5sPSVo9O/n96JEkVR98WkM9wTOhT4bsQ/T03U+9rS4VnUq/Zvqppc5xELV/jVlkJt
         Nd3AKiLGAllI80wcsVSrIeyZ/bIckNQ50vThBZp9UfHV9six+kkE7+i3yvOKCJS9pwQq
         0qo3CdlggPlkDJ85jMZPiVXfRDawTIXdsT5IOroI/rCOgsBuYDMCihWAGoF9niqXPFUu
         vE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lv0Kb494zFJwqBOfwUjOAI6JWygR12iP5UgAX5IqtW8=;
        b=CMxbHjAB1ZzN/F4tbTMcN2FnmgnyoY2CjpxToq4m+MhvIBzsfteDi3GDuRzuGJpior
         TkugEVDXTEHJfBpmWNcKwBTUvQPKDRf8U1S6HVPyeDSazR9grSPHeeVBm67Yf49aGh2T
         R6/dUb95troCv2q8c6vmxKxbyK7ftJaxikP7twH5RphLr6k3eXUDE5tEKVuGbu1iIqM/
         ZmHnXrgdUI7qCcmP9vDy/DmGsDi0/k4zKOZr0yN+1Pci1v+nuNw3LBuTYq+Nkchcjunj
         PeQGU/DgjLSoHWo6MWj9ly/1seqD/7hevmnGIe8kp8ThgBwNguyNxEp4h5/uxMLUaTtw
         8u+Q==
X-Gm-Message-State: AOAM532VxCHsQedT2mL8vI/N0VwA1rUWovz64YicxJhhzQg8dxW54qkp
        7aTgDrqg+FfgUL9pwLrS3EQ=
X-Google-Smtp-Source: ABdhPJy03nWY9owzxjn9rnRYAvbH4gVJdjtWe36Wnq2cuYeA4P4jEugkBCunZsGC1AcwvG+tsNbwsg==
X-Received: by 2002:a63:7703:: with SMTP id s3mr9423616pgc.339.1622212750907;
        Fri, 28 May 2021 07:39:10 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id n2sm4424540pjo.1.2021.05.28.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:39:10 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mhiramat@kernel.org, mcgrof@kernel.org, josh@joshtriplett.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, jack@suse.cz, hare@suse.de,
        tj@kernel.org, gregkh@linuxfoundation.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, brho@google.com, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, jojing64@gmail.com, ebiederm@xmission.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: [PATCH v3 0/3] init/initramfs.c: make initramfs support pivot_root
Date:   Fri, 28 May 2021 22:37:59 +0800
Message-Id: <20210528143802.78635-1-dong.menglong@zte.com.cn>
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


Changes since V2:

In the first patch, I use vfs_path_lookup() in init_eaccess() to make the
path lookup follow the mount on '/'. After this, the problem reported by
Masami Hiramatsu is solved. Thanks for your report :/


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

 fs/init.c            |  11 ++++-
 include/linux/init.h |   5 ++
 init/do_mounts.c     | 109 +++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h     |  18 ++++++-
 init/initramfs.c     |  10 ++++
 init/main.c          |   7 ++-
 usr/Kconfig          |  10 ++++
 7 files changed, 166 insertions(+), 4 deletions(-)

-- 
2.32.0.rc0

