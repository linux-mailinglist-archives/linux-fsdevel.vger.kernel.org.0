Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F393467B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 19:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhCWSdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 14:33:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhCWScd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:32:33 -0400
Received: from localhost.localdomain (unknown [IPv6:2401:4900:5170:240f:f606:c194:2a1c:c147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 59CC01F44A65;
        Tue, 23 Mar 2021 18:32:26 +0000 (GMT)
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: [PATCH v3 0/4] Make UTF-8 encoding loadable
Date:   Wed, 24 Mar 2021 00:01:56 +0530
Message-Id: <20210323183201.812944-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

utf8data.h_shipped has a large database table which is an auto-generated
decodification trie for the unicode normalization functions and it is not
necessary to carry this large table in the kernel.
Goal is to make UTF-8 encoding loadable by converting it into a module
and adding a layer between the filesystems and the utf8 module which will
load the module whenever any filesystem that needs unicode is mounted.

1st patch in the series resolves the warning reported by kernel test robot
and 2nd patch fixes the incorrect use of utf8_unload() in ext4 and
f2fs filesystems.

Unicode is the subsystem and utf8 is a charachter encoding for the
subsystem, hence 3rd and 4th patches in the series are renaming functions
and file name to unicode for better understanding the difference between
UTF-8 module and unicode layer.

Last patch in the series adds the layer and utf8 module and also uses
static_call() function introducted for preventing speculative execution
attacks.

---
Changes in v3
  - Add a patch which checks if utf8 is loaded before calling utf8_unload()
    in ext4 and f2fs filesystems
  - Return error if strscpy() returns value < 0
  - Correct the conditions to prevent NULL pointer dereference while
    accessing functions via utf8_ops variable.
  - Add spinlock to avoid race conditions.
  - Use static_call() for preventing speculative execution attacks.

Changes in v2
  - Remove the duplicate file from the last patch.
  - Make the wrapper functions inline.
  - Remove msleep and use try_module_get() and module_put()
    for ensuring that module is loaded correctly and also
    doesn't get unloaded while in use.
  - Resolve the warning reported by kernel test robot.
  - Resolve all the checkpatch.pl warnings.

Shreeya Patel (4):
  fs: unicode: Use strscpy() instead of strncpy()
  fs: Check if utf8 encoding is loaded before calling utf8_unload()
  fs: unicode: Rename function names from utf8 to unicode
  fs: unicode: Rename utf8-core file to unicode-core

 fs/ext4/hash.c                             |  2 +-
 fs/ext4/namei.c                            | 12 ++---
 fs/ext4/super.c                            |  8 +--
 fs/f2fs/dir.c                              | 12 ++---
 fs/f2fs/super.c                            | 11 ++--
 fs/libfs.c                                 |  6 +--
 fs/unicode/Makefile                        |  2 +-
 fs/unicode/{utf8-core.c => unicode-core.c} | 62 +++++++++++-----------
 fs/unicode/utf8-selftest.c                 |  8 +--
 include/linux/unicode.h                    | 32 +++++------
 10 files changed, 81 insertions(+), 74 deletions(-)
 rename fs/unicode/{utf8-core.c => unicode-core.c} (72%)

-- 
2.30.1

