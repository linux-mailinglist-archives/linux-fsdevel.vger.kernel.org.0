Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0AD346975
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhCWUAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhCWUAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01840C061574;
        Tue, 23 Mar 2021 13:00:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 145E31F44E0F
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 4/4] docs: tmpfs: Add casefold options
Date:   Tue, 23 Mar 2021 16:59:41 -0300
Message-Id: <20210323195941.69720-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210323195941.69720-1-andrealmeid@collabora.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document mounting options to enable casefold support in tmpfs.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/filesystems/tmpfs.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0408c245785e..84c87c309bd7 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -170,6 +170,32 @@ So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
 will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
 
+tmpfs has the following mounting options for case-insesitive lookups support:
+
+=========   ==============================================================
+casefold    Enable casefold support at this mount point using the given
+            argument as enconding. Currently only utf8 encondings are supported.
+cf_strict   Enable strict casefolding at this mouting point (disabled by
+            default). This means that invalid strings should be reject by the
+            file system.
+=========   ==============================================================
+
+Note that this option doesn't enable casefold by default, one needs to set
+casefold flag per directory, setting the +F attribute in an empty directory. New
+directories within a casefolded one will inherit the flag.
+
+Example::
+
+    $ mount -t tmpfs -o casefold=utf8-12.1.0,cf_strict tmpfs /mytmpfs
+    $ cd /mytmpfs
+    $ touch a; touch A
+    $ ls
+    A  a
+    $ mkdir dir
+    $ chattr +F dir
+    $ touch dir/a; touch dir/A
+    $ ls dir
+    a
 
 :Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
-- 
2.31.0

