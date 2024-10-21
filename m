Return-Path: <linux-fsdevel+bounces-32509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9ED9A6FE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F18B227DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD01FAC3B;
	Mon, 21 Oct 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V2FlZGvv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380F1EABDA;
	Mon, 21 Oct 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528704; cv=none; b=M2GwGBiXCXj+isSEOxRmogFiENIaezbVo12t1ZGp+35U6PeoEZZnJt/A1d86pDpKvjiQ9uIfSVYD6OILKnzGm7FrF+k5i0HMN09AV7Xqx0mmjulkTalH047cl7rd+6Y3u38Q50h/zQDBaMM9Q30awfxmg/kERBMQAzARlHwJ0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528704; c=relaxed/simple;
	bh=d+DWM6oMJSU8ul54RI6qsVi4beI/rFF9uAWkAJ2qkuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDXTK2CVfXD2VexxK6RR3NqFz5VV+uQwXvts7f2c96bI2FJoRnbVtu9Yxjk2Zd4+VaaZX+0lJ9ZzbLezy4KFWYwPLlXAvDbLKAO0lVPAmSY/iNUGze+5U7zl8NlWfyspLNQNyK7iXMlE+4rzQQuQDvjjymyQz0X8irIQweBi3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V2FlZGvv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IRWzJ2ihFV+Or6Yh2tTDHkDcDI2/Jt0crAI74pE29VE=; b=V2FlZGvv0GJNi7LqNPWoCYWe6T
	IkwHBJYGJ+UMuht6t72Uh3VCoWz68gVRWqEbZFagUWe9x7/A0ezMs/UiC/c4DJmOYrRcFZ3Lyxjot
	47BDGhrMfAYzpMpD2UVR9+/fldHg+jpxD2KQ5PHkjAcWueBNoH9mq+ZUjG8DvwdhDW6/U3mTkxnVG
	XNUawWorxooLY1LtJwijslHO5Q3PEh4xE6Ijzu9Hz6byJ4CiNigt+12Fn0h1nxM0EBM0Or8V4CKac
	pFzUu5ary992udtZ0y2pP0Qp0lvbOhTcP8801kQmPgA6te+sRvFoFyKoDgkhpOTq/rvslEYjRjawC
	CF8EthZw==;
Received: from [191.204.195.205] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2vQC-00DECf-1s; Mon, 21 Oct 2024 18:38:20 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 21 Oct 2024 13:37:25 -0300
Subject: [PATCH v8 9/9] docs: tmpfs: Add casefold options
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-tonyk-tmpfs-v8-9-f443d5814194@igalia.com>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
In-Reply-To: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Document mounting options for casefold support in tmpfs.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- Rewrote note about "this doesn't enable casefold by default" (Krisman)
---
 Documentation/filesystems/tmpfs.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 56a26c843dbe964086503dda9b4e8066a1242d72..d677e0428c3f68148a3761bb232bbed5b9a41f76 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -241,6 +241,28 @@ So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
 will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
 
+tmpfs has the following mounting options for case-insensitive lookup support:
+
+================= ==============================================================
+casefold          Enable casefold support at this mount point using the given
+                  argument as the encoding standard. Currently only UTF-8
+                  encodings are supported. If no argument is used, it will load
+                  the latest UTF-8 encoding available.
+strict_encoding   Enable strict encoding at this mount point (disabled by
+                  default). In this mode, the filesystem refuses to create file
+                  and directory with names containing invalid UTF-8 characters.
+================= ==============================================================
+
+This option doesn't render the entire filesystem case-insensitive. One needs to
+still set the casefold flag per directory, by flipping the +F attribute in an
+empty directory. Nevertheless, new directories will inherit the attribute. The
+mountpoint itself cannot be made case-insensitive.
+
+Example::
+
+    $ mount -t tmpfs -o casefold=utf8-12.1.0,strict_encoding fs_name /mytmpfs
+    $ mount -t tmpfs -o casefold fs_name /mytmpfs
+
 
 :Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
@@ -250,3 +272,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
    KOSAKI Motohiro, 16 Mar 2010
 :Updated:
    Chris Down, 13 July 2020
+:Updated:
+   André Almeida, 23 Aug 2024

-- 
2.47.0


