Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E8738D5A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhEVLdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 07:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhEVLdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 07:33:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27509C061574;
        Sat, 22 May 2021 04:32:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a7so3610328plh.3;
        Sat, 22 May 2021 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kOHHb+Y1mDpGXTDWCoDuGyBc8YqEz2A5xaJqIhlchQ=;
        b=gAzPsBMXEQuxRpMyvG3kICmHXTgzm6Ob0J2tx3Yt4keonOI3K1g5XKYsZsmFLo39h3
         JyUxdKwMfYZ6fCb3TPiN/WtxHPsAp4B5DmmN6ubQpARdvZN/X6DaguYrPsJFxCOnuVAA
         DoZa1rQei9VDfoUfM6UodhdUWb4VDuwV3z+IoNXUipzIqLUcCpg8mbJ/YAOKHJNcoOJ8
         b172jM28j77307jsjTqJ1ocGIHjVAcDivKi7yX7y9Idz6MybRvL4SThVK4TiSbSFhTlU
         zdcaLjqQWq+v8cTDEOH+F2hvsChJuFuEj5b6qPkqw/qLEe4dytXojL3qsEyyloS7BkiB
         1XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kOHHb+Y1mDpGXTDWCoDuGyBc8YqEz2A5xaJqIhlchQ=;
        b=gSvaGmi2sX//T4KsRD04gsogY5OO2w8B/5Jx7I+qOuXlOo1J/bMT/UQWLgx3KVcg8R
         b5zXfwYdTMjywNkW1WvSuRULWKaveCHmuBI5GQUd8LiSq896mEeBylZ/ceeAFmjZQRzS
         dWS4ZvbBDC+8uTJGL2k5UsxUrN4ndNlFVPUCbwUwGsaX7uNB5syn3eY0ZsqmisgDVeDc
         XLTbakkbuXDpp5Ytlri4may6NJF5rvPSvoMMDnVZ0dBYA7CHKdH1LS2ugUs+5buj0JzX
         T7hc5wgAlhcMq7jl1rQIooPHt8RJcFIiqiJCuHtr/PTpKew1NcA9s1NpsMMBck8ixQlc
         pOFQ==
X-Gm-Message-State: AOAM532KiraoOknWHlYLmJA8i/Y97IpTKGb/K1b9sHsMOv/Pes2o+rNP
        qu4vcrXKEce8fPGUPoGVGKw=
X-Google-Smtp-Source: ABdhPJyy9kDrw5mMb3hWHBO3hq5vNdGZTAIBlBJyZ7co9ngyDEULlX+CctHNvUTmKzQisYwQbVt0Cw==
X-Received: by 2002:a17:902:d903:b029:ef:abd0:d8fa with SMTP id c3-20020a170902d903b02900efabd0d8famr16587186plz.49.1621683132609;
        Sat, 22 May 2021 04:32:12 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id e7sm7020330pfl.171.2021.05.22.04.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 04:32:11 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mcgrof@kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, joe@perches.com, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, jack@suse.cz, axboe@kernel.dk, hare@suse.de,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, brho@google.com,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] init/initramfs.c: make initramfs support pivot_root
Date:   Sat, 22 May 2021 19:31:52 +0800
Message-Id: <20210522113155.244796-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.31.1
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
is used to check the exist of 'ramdisk_execute_command' in relative path
mode.

In the second patch, I create a second mount, which is called
'user root', and make it become the root. Therefore, the root has a
parent mount, and it can be umounted or pivot_root.

Before change root, I have to check the exist of ramdisk_execute_command,
because 'user root' should be umounted if ramdisk_execute_command not
exist. 'user root' is mounted on '/root', and cpio is unpacked to it. So
I have to use relative path to do this check, as 'user root' is not the
root yet.

Maybe I can do the check after change root, but it seems complex to
change root back to '/'. What's weird is that I try to move 'user root'
from '/root' to '/', but the absolute path lookup seems never follow the
mount. That's why I introduced ramdisk_exec_exist.

In the third patch, I fix rootfs_fs_type with ramfs, as it is not used
directly any more, and it make no sense to switch it between ramfs and
tmpfs, just fix it with ramfs to simplify the code.



Menglong Dong (3):
  init/main.c: introduce function ramdisk_exec_exist()
  init/do_cmounts.c: introduce 'user_root' for initramfs
  init/do_mounts.c: fix rootfs_fs_type with ramfs

 fs/namespace.c       |  2 --
 include/linux/init.h |  1 -
 init/do_mounts.c     | 82 +++++++++++++++++++++++++++++++++++++-------
 init/do_mounts.h     |  7 +++-
 init/initramfs.c     | 10 ++++++
 init/main.c          | 17 ++++++++-
 6 files changed, 101 insertions(+), 18 deletions(-)

-- 
2.31.1

