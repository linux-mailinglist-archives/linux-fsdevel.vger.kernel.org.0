Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99A3406E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCRNdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCRNdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:33:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6881CC06174A;
        Thu, 18 Mar 2021 06:33:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id A91E51F45F32
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     krisman@collabora.com, jaegeuk@kernel.org, yuchao0@huawei.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, drosen@google.com,
        ebiggers@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 0/4] Make UTF-8 encoding loadable
Date:   Thu, 18 Mar 2021 19:03:01 +0530
Message-Id: <20210318133305.316564-1-shreeya.patel@collabora.com>
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
Unicode is the subsystem and utf8 is a charachter encoding for the
subsystem, hence first two patches in the series are renaming functions
and file name to unicode for better understanding the difference between
UTF-8 module and unicode layer.
3rd patch resolves the warning reported by kernel test robot.
Last patch in the series adds the layer and utf8 module.

---
Changes in v2
  - Remove the duplicate file from the last patch.
  - Make the wrapper functions inline.
  - Remove msleep and use try_module_get() and module_put()
    for ensuring that module is loaded correctly and also
    doesn't get unloaded while in use.
  - Resolve the warning reported by kernel test robot.
  - Resolve all the checkpatch.pl warnings.

Shreeya Patel (4):
  fs: unicode: Rename function names from utf8 to unicode
  fs: unicode: Rename utf8-core file to unicode-core
  fs: unicode: Use strscpy() instead of strncpy()
  fs: unicode: Add utf8 module and a unicode layer

 fs/ext4/hash.c                        |  2 +-
 fs/ext4/namei.c                       | 12 ++--
 fs/ext4/super.c                       |  6 +-
 fs/f2fs/dir.c                         | 12 ++--
 fs/f2fs/super.c                       |  6 +-
 fs/libfs.c                            |  6 +-
 fs/unicode/Kconfig                    | 11 +++-
 fs/unicode/Makefile                   |  5 +-
 fs/unicode/unicode-core.c             | 60 ++++++++++++++++++++
 fs/unicode/utf8-selftest.c            |  8 +--
 fs/unicode/{utf8-core.c => utf8mod.c} | 80 +++++++++++++++------------
 include/linux/unicode.h               | 77 ++++++++++++++++++++------
 12 files changed, 206 insertions(+), 79 deletions(-)
 create mode 100644 fs/unicode/unicode-core.c
 rename fs/unicode/{utf8-core.c => utf8mod.c} (68%)

-- 
2.30.1

