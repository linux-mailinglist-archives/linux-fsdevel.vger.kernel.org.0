Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5093508C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 23:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCaVIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 17:08:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34586 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhCaVIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:08:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 626441F461A9
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: [PATCH v6 0/4] Make UTF-8 encoding loadable
Date:   Thu,  1 Apr 2021 02:37:47 +0530
Message-Id: <20210331210751.281645-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
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
Currently only UTF-8 encoding is supported but if any other encodings
are supported in future then the layer file would be responsible for
loading the desired encoding module.

1st patch in the series resolves the warning reported by kernel test
robot by using strscpy instead of strncpy.

Unicode is the subsystem and utf8 is a charachter encoding for the
subsystem, hence 2nd and 3rd patches in the series are renaming functions
and file name to unicode for better understanding the difference between
UTF-8 module and unicode layer.

Last patch in the series adds the layer and utf8 module and also uses
static calls which gives performance benefit when compared to indirect
calls using function pointers.

---
Changes in v6
  - Add spinlock to protect utf8mod and avoid NULL pointer
    dereference.
  - Change the static call function names for being consistent with
    kernel coding style.
  - Merge the unicode_load_module function with unicode_load as it is
    not really needed to have a separate function.
  - Use try_then_module_get instead of module_get to avoid loading the
    module even when it is already loaded.
  - Improve the commit message.

Changes in v5
  - Remove patch which adds NULL check in ext4/super.c and f2fs/super.c
    before calling unicode_unload().
  - Rename global variables and default static call functions for better
    understanding
  - Make only config UNICODE_UTF8 visible and config UNICODE to be always
    enabled provided UNICODE_UTF8 is enabled.  
  - Improve the documentation for Kconfig
  - Improve the commit message.
 
Changes in v4
  - Return error from the static calls instead of doing nothing and
    succeeding even without loading the module.
  - Remove the complete usage of utf8_ops and use static calls at all
    places.
  - Restore the static calls to default values when module is unloaded.
  - Decrement the reference of module after calling the unload function.
  - Remove spinlock as there will be no race conditions after removing
    utf8_ops.

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
  fs: unicode: Rename function names from utf8 to unicode
  fs: unicode: Rename utf8-core file to unicode-core
  fs: unicode: Add utf8 module and a unicode layer

 fs/ext4/hash.c                             |   2 +-
 fs/ext4/namei.c                            |  12 +-
 fs/ext4/super.c                            |   6 +-
 fs/f2fs/dir.c                              |  12 +-
 fs/f2fs/super.c                            |   6 +-
 fs/libfs.c                                 |   6 +-
 fs/unicode/Kconfig                         |  17 ++-
 fs/unicode/Makefile                        |   5 +-
 fs/unicode/unicode-core.c                  | 152 +++++++++++++++++++++
 fs/unicode/{utf8-core.c => unicode-utf8.c} |  98 ++++++++-----
 fs/unicode/utf8-selftest.c                 |   8 +-
 include/linux/unicode.h                    | 100 +++++++++++---
 12 files changed, 344 insertions(+), 80 deletions(-)
 create mode 100644 fs/unicode/unicode-core.c
 rename fs/unicode/{utf8-core.c => unicode-utf8.c} (57%)

-- 
2.30.2

