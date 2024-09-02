Return-Path: <linux-fsdevel+bounces-28301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B63969040
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 01:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41699B26483
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 23:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322E19341B;
	Mon,  2 Sep 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b4153IEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56906193404;
	Mon,  2 Sep 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317761; cv=none; b=ITcCw6A9GCM6ssPgZKPGlbcubwlGLVAOGqnOu3eYKJ+oIqARBzNrn6MlwYHPPI/iAiwgrHB2cfCP0A3JB8CkPSOnEB9wbcZz2mm1o0tS8mDGQDi6o1Z+L8W7XblFlnLq4qb+/XbIRglHwOHP88M8Sqlgw9oflN+6UX90oy8gvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317761; c=relaxed/simple;
	bh=SGEJQAX7zN+2ZikPoQ/1/lVDHKXUFqezT0IpKco/jLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YppVpw0hHo7fQ0SbFMWkLZfPl9exx2GKvAuPLZ8WeVHe9fmSP36asfPaTpVwFzsGNUhyEIcC6PkyM3ZqBFJ9lap6mxr1ZsXqpTmvzqAluUwcdqqNu0L3mj9NDnd/FQxfY6I9uT/PwL3+shp6gURJXyODJ8V241NdFBxrxkM8JsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b4153IEy; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2uckVKN0pdzCghR0p6/g82d2/8anRVmY8PvlKYt2nuo=; b=b4153IEyOlT24sPlLCTltO9k17
	8ORGs8pUbsZjsP8G/G7rTOVrboU7vVIZneJ8WVG/79knVk9jBbZVADQQB9xZ0+HNLJ6zNE+AJloa3
	PzYgotO6CNgL/5xQHs65xcK9qG4aDJXgP3vQiRQgSqUDm4kSCZPpRjEkgGosgomMKpsSp/rAt+sLx
	dNhEyyZ5vXhUHhbeICkiJlGkoJJ7dvij0gzxUPN98AoIcZgUhtSkxTe3cOBhZJVkr/hvSL4/H53/Q
	yyu6BowILx2MdeuMEF45JsXlZjoCPhaXUvslbUt7A0BEuA0KJRYHMOU2FokYx1/TWh/02jvYm/pPJ
	S24Apbjw==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxg-008VrL-3m; Tue, 03 Sep 2024 00:55:52 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 8/8] docs: tmpfs: Add casefold options
Date: Mon,  2 Sep 2024 19:55:10 -0300
Message-ID: <20240902225511.757831-9-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902225511.757831-1-andrealmeid@igalia.com>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document mounting options for casefold support in tmpfs.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 Documentation/filesystems/tmpfs.rst | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 56a26c843dbe..ce24fb16979a 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -241,6 +241,41 @@ So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
 will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
 
+tmpfs has the following mounting options for case-insesitive lookups support:
+
+================= ==============================================================
+casefold          Enable casefold support at this mount point using the given
+                  argument as the encoding standard. Currently only utf8
+                  encodings are supported.
+strict_encoding   Enable strict encoding at this mount point (disabled by
+                  default). This means that invalid sequences will be rejected
+                  by the file system.
+================= ==============================================================
+
+Note that this option doesn't enable casefold by default; one needs to set
+casefold flag per directory, setting the +F attribute in an empty directory. New
+directories within a casefolded one will inherit the flag.
+
+Example::
+
+    $ mount -t tmpfs -o casefold=utf8-12.1.0,cf_strict fs_name /mytmpfs
+    $ cd /mytmpfs # case-sensitive by default
+    $ touch a; touch A
+    $ ls
+    A  a
+    $ mkdir B
+    $ cd b
+    cd: The directory 'b' does not exist
+    $ mkdir casefold_dir
+    $ chattr +F casefold_dir/ # marking it as case-insensitive
+    $ cd
+    $ touch dir/a; touch dir/A
+    $ ls dir
+    a
+    $ mkdir B
+    $ cd b
+    $ pwd
+    /home/user/mytmpfs/casefold_dir/B
 
 :Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
@@ -250,3 +285,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
    KOSAKI Motohiro, 16 Mar 2010
 :Updated:
    Chris Down, 13 July 2020
+:Updated:
+   André Almeida, 23 Aug 2024
-- 
2.46.0


