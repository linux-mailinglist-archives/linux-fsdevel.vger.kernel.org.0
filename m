Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20D933A1DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhCMXNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 18:13:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhCMXM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 18:12:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 5EA611F472EA
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     krisman@collabora.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@collabora.com, gustavo.padovan@collabora.com,
        andre.almeida@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 0/3] Make UTF-8 encoding loadable
Date:   Sun, 14 Mar 2021 04:42:10 +0530
Message-Id: <20210313231214.383576-1-shreeya.patel@collabora.com>
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
Last patch in the series adds the layer and utf8 module.


Shreeya Patel (3):
  fs: unicode: Rename function names from utf8 to unicode
  fs: unicode: Rename utf8-core file to unicode-core
  fs: unicode: Add utf8 module and a unicode layer

 fs/ext4/hash.c             |   2 +-
 fs/ext4/namei.c            |  12 +-
 fs/ext4/super.c            |   6 +-
 fs/f2fs/dir.c              |  12 +-
 fs/f2fs/super.c            |   6 +-
 fs/libfs.c                 |   6 +-
 fs/unicode/Kconfig         |   7 +-
 fs/unicode/Makefile        |   5 +-
 fs/unicode/unicode-core.c  | 112 +++++++++++++++++
 fs/unicode/utf8-core.c     | 248 ++++++++++---------------------------
 fs/unicode/utf8-selftest.c |   8 +-
 fs/unicode/utf8mod.c       | 246 ++++++++++++++++++++++++++++++++++++
 include/linux/unicode.h    |  52 +++++---
 13 files changed, 492 insertions(+), 230 deletions(-)
 create mode 100644 fs/unicode/unicode-core.c
 create mode 100644 fs/unicode/utf8mod.c

-- 
2.30.1

