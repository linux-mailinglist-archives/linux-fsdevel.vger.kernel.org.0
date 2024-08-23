Return-Path: <linux-fsdevel+bounces-26955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961C95D470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91701F23FD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76F194AF0;
	Fri, 23 Aug 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e8//f4fU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E9194ACF;
	Fri, 23 Aug 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434446; cv=none; b=dB6kF+4Rf24kpC5qjOB7m+ricXIHHpaN2q4KK9HSoYkMyXrh87C8cDlSL8hHhuRF6NdjmxwfrKAJ6T4a3pc8nr3GQFB/SLbwL4jSOuuYmfwLG7JWgxeJS6nGlvy0fSwUWseXDXcFircuHUVRG0EbXmpC0cFVlIPsmlGXVYw/tg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434446; c=relaxed/simple;
	bh=SGEJQAX7zN+2ZikPoQ/1/lVDHKXUFqezT0IpKco/jLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukI+61NALA8nTABzb0PgTSPPf56lx1gOC283jZqW/OCtyynPNyZVnC41GOxvfVtcZsBMWLspbgJYHcApnvrguxPcYVETWAlOSVVuFtN6X2lk1d9zuq3YhDj32RQKxUutjfHwVvHfGvnfr0GOO6IIK69j+5uBlYT8JUUfJ2lmvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e8//f4fU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2uckVKN0pdzCghR0p6/g82d2/8anRVmY8PvlKYt2nuo=; b=e8//f4fU6MKCA9/tuu/dsGqQQ3
	10S/BJHzanaeCer9+DrWQVreL3F7xlH9HYJd0vxHwUaIRtL/OucvWMqQwlqWVqrCvj3VSIUVSlitE
	UbhWC8PtfsjPdD39u5eU6XrL+u0fb99yGwGCoVh01Uf1P2QOX/PSQ2OZfivbUlOBF+vgNq+pe3TD4
	MSoXXhtt7JjGQd4gTbRCq+hDgqxXWCqY21pgTTEKwILl5CDL2g38xAca75f4hbuj2TOcKjXvKnnzV
	LLezTv2tJ49sZBQKp2/u0m6i+E8bKg2Avu4NtztNs8tb1rnOLjECeS6kcvVsXYCS07oBAweVfjgOe
	2iDDM1Qw==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shYAe-0048Ww-Fj; Fri, 23 Aug 2024 19:33:56 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 5/5] docs: tmpfs: Add casefold options
Date: Fri, 23 Aug 2024 14:33:32 -0300
Message-ID: <20240823173332.281211-6-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823173332.281211-1-andrealmeid@igalia.com>
References: <20240823173332.281211-1-andrealmeid@igalia.com>
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


