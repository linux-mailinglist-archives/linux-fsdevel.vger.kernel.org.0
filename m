Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB8398D62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFBOsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBOst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:48:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932F3C061574;
        Wed,  2 Jun 2021 07:46:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g18so2385381pfr.2;
        Wed, 02 Jun 2021 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFhBv3P/CMQqX0kCJSqkaDf0YsrFNm/vuqtLa8LET58=;
        b=XeBnXTMGLRT1N1VvnG8J0JfYo9xcPHJidl5dvIDrLCcPPhVHTqdFU1r5cuya48XKcX
         zxPPZf6/3uKpbZQmWcaKLpeGoZyZYyicldsDcR/18ajvKTKlsp6AeKhJ9RGNiI/QO0PI
         hLL1THvTlOt3Lxj5NVgUhPZyBLCXfCkcFnEblYJs0/Z+/EmYNkLGS6PPPgr86pmITv4g
         N17IOpMAeAyCPDhTUHGv2gmk2hYfWjgN9TC2c2tusSUT90r2pnHe7HOqB3Idg7sWu5bC
         5lOk1g1S67ytYq13L/d51601sJvOkgegw7lKtWwqLRwxxyHs/6b/3lwFbbs+qt81h6lp
         5jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFhBv3P/CMQqX0kCJSqkaDf0YsrFNm/vuqtLa8LET58=;
        b=LyXKVEf7gW16lbwXKylFJW4zjaqp5fnl7jSfpa11eB/8dBiuskHxSROBZwgqMMhDI/
         gUdlbD6sC0pv5fHZN8Z6MaVVdw7os4+GqAUOGSinX8iSZJca6PjC1qV1ZlEVW7jbyreu
         JixOADkFvtmU2rpK2ZDTfds8cGxlg0JYAUe5i0GK6ZsH1+3tjHcqtvpIp6Ml1E4e8dyd
         uooj4Dt1G74i5Ryw+C4TjZpRGPMnhqGrxGOVUOwBUnPkXpArN9Ch5TPIThl0exL/SrdL
         Yz4HE896SzPn4/2PhXyXIpgh5bjWIiSs85CSfdnPrDAVhys1Hehb9wS5+FrU+8x3bkVH
         /Lvw==
X-Gm-Message-State: AOAM533WRT2clF8wBoqr7ewBbNqRehtoY9dZJd1a6+QmOLjonk0PL4hY
        kIRuq8nGCb7ogXnC0PVr5xg=
X-Google-Smtp-Source: ABdhPJx39eESncZM65uP9p0EMY6BTJM6mfNVVUzLJWiV6uKzLLHWgyaDKlrHsLMo1oXkpuHPues+qQ==
X-Received: by 2002:a05:6a00:c8e:b029:2e9:c6a2:bd78 with SMTP id a14-20020a056a000c8eb02902e9c6a2bd78mr17784024pfv.1.1622645213109;
        Wed, 02 Jun 2021 07:46:53 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id s29sm43942pgm.82.2021.06.02.07.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:46:52 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        akpm@linux-foundation.org, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, joe@perches.com, hare@suse.de,
        axboe@kernel.dk, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        brho@google.com, mcgrof@kernel.org, palmerdabbelt@google.com,
        arnd@arndb.de, f.fainelli@gmail.com, linux@rasmusvillemoes.dk,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, pmladek@suse.com,
        glider@google.com, chris@chrisdown.name, ebiederm@xmission.com,
        jojing64@gmail.com, mingo@kernel.org, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v4 0/3] init/initramfs.c: make initramfs support pivot_root
Date:   Wed,  2 Jun 2021 22:46:27 +0800
Message-Id: <20210602144630.161982-1-dong.menglong@zte.com.cn>
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

Changes since V3:

Do a code cleanup for the second patch, as Christian Brauner suggested:
- remove the concept 'user root', which seems not suitable.
- introduce inline function 'check_tmpfs_enabled()' to avoid duplicated
  code.
- rename function 'mount_user_root' to 'prepare_mount_rootfs'
- rename function 'end_mount_user_root' to 'finish_mount_rootfs'
- join 'init_user_rootfs()' with 'prepare_mount_rootfs()'

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
  init/do_mounts.c: create second mount for initramfs
  init/do_mounts.c: fix rootfs_fs_type with ramfs

 fs/init.c            |  11 ++++-
 include/linux/init.h |   4 ++
 init/do_mounts.c     | 101 ++++++++++++++++++++++++++++++++++++++++---
 init/do_mounts.h     |  16 ++++++-
 init/initramfs.c     |   8 ++++
 init/main.c          |   7 ++-
 usr/Kconfig          |  10 +++++
 7 files changed, 146 insertions(+), 11 deletions(-)

-- 
2.32.0.rc0

