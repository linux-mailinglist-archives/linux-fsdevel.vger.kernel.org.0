Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5052539C58C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 05:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFEDsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 23:48:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43627 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFEDsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:48:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id e22so9353531pgv.10;
        Fri, 04 Jun 2021 20:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QsXBeBaWFBjeD0ncOeH0DMH46dHl4w0eLvaZn5kV6U=;
        b=Y3Ht4MCFl8VcpYkyr59eCwOGoZsP4JDW47lirSER11VaPmyV3iEnZ/qbayg6mwvq4V
         bBhBZSFCVXum4Nvy/6dBJAgYYKwIx+Gei1STR9CiAeNazHTJoZbHPDes0nNHgmWpWm2d
         B9Vcp3sU7Gc1Tn+xLgXQXSgwCYnrilE+bt8KSRstC+w4Ikk1TMSuhAODI7wkCXZJW7l+
         WHgt4RPM2ezE08bEW3fyWzDgq0fg/V21U5UhEBf+LOcyo8o6ygWPtEIM3fqAxArDfzCv
         LvoDQXaKzwb6ZQg1W82w8QnxWjWjRWqX4GAqvVjz9w3u3lf6mkzjx9BeKivU75K7GkXY
         lSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QsXBeBaWFBjeD0ncOeH0DMH46dHl4w0eLvaZn5kV6U=;
        b=Th3oIe54UUpc+YezyoQW/RS8ir0ntj9y4PKwTYZJk6yuqy3tewOHA2gV0DoyRjX6/7
         dPbpvhtNk3gUHShEx39pOFRD9skm8obDj6l6JNLsLfcnBPm/3ZdCV5Fba4y2AkoBVhwc
         L6dOdFnLStcTjNLh7g5PbG0z2mwuzDkTjgqTCX5MHpEP+ZYO5xEfzSeTB/EMxW3rXfmc
         VD4eVQfHzkHloqiJD0T5bLz75RMfz0JmnlVGs7/S4F2uejcIVIVyjOYnAuyuJWLJYK+l
         ZeCeQXyDKj1W1n5SjtFv63qurUg5ijtY1oHy7ZXwZOIBAmRXhaGJMEfE8AstwLjcP9pg
         YnMA==
X-Gm-Message-State: AOAM532NAIXMIHLgIDtCD4w6+AY11m/4x2UE5nXivo5HyvXi3VryVPQx
        31/dEFCnRD5KBGkwr1JhQ2Q=
X-Google-Smtp-Source: ABdhPJwnV03Cv9eIU/d+1dgLMedKW03uhbUrdpP6Apw/WW3AZRGY0WXT13jU4Fa/1XrWDW9cvDD1Uw==
X-Received: by 2002:a05:6a00:b46:b029:2d3:3504:88d9 with SMTP id p6-20020a056a000b46b02902d3350488d9mr7652400pfo.39.1622864710859;
        Fri, 04 Jun 2021 20:45:10 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id p11sm3022371pgn.65.2021.06.04.20.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 20:45:10 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, joe@perches.com,
        dong.menglong@zte.com.cn, jack@suse.cz, hare@suse.de,
        axboe@kernel.dk, tj@kernel.org, gregkh@linuxfoundation.org,
        song@kernel.org, neilb@suse.de, akpm@linux-foundation.org,
        linux@rasmusvillemoes.dk, brho@google.com, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        mhiramat@kernel.org, rostedt@goodmis.org, vbabka@suse.cz,
        glider@google.com, pmladek@suse.com, johannes.berg@intel.com,
        ebiederm@xmission.com, jojing64@gmail.com, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, arnd@arndb.de,
        chris@chrisdown.name, mingo@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v6 0/2] init/initramfs.c: make initramfs support pivot_root
Date:   Sat,  5 Jun 2021 11:44:45 +0800
Message-Id: <20210605034447.92917-1-dong.menglong@zte.com.cn>
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


Changes since V5:

Remove the third patch and make it combined with the second one.


Changes since V4:                                                                                                                                                     
                                                                                                                                                                      
Do some more code cleanup for the second patch, include:                                                                                                              
- move 'ramdisk_exec_exist()' to 'init.h'                                                                                                                             
- remove unnecessary struct 'fs_rootfs_root'                                                                                                                          
- introduce 'revert_mount_rootfs()'                                                                                                                                   
- [...]                                                                                                                                                               


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



Menglong Dong (2):
  init/do_mounts.c: create second mount for initramfs
  init/do_mounts.c: fix rootfs_fs_type with ramfs

 include/linux/init.h |   4 ++
 init/do_mounts.c     | 101 ++++++++++++++++++++++++++++++++++++++++---
 init/do_mounts.h     |  16 ++++++-
 init/initramfs.c     |   8 ++++
 usr/Kconfig          |  10 +++++
 5 files changed, 131 insertions(+), 8 deletions(-)

-- 
2.32.0.rc0

