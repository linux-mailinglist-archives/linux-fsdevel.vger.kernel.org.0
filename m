Return-Path: <linux-fsdevel+bounces-29109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D065B9755F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007001C265EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189B1AB512;
	Wed, 11 Sep 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f8TRd/op"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542F1B2EC2;
	Wed, 11 Sep 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065963; cv=none; b=kB82uJMQvqRGBxHDQWU4iBWZhpo4JwTSHWd/XJLxVp10161InYojdtaIRXWvlZz/e5GUfcmIY5E5vprJJwr6YdU2Y9baAFCPVQsBHnpHcwgu1xNLelbkv3Iy0KaYizUg7pJTtNEMlApSUGBdzTQ+ARS2fYp5n9vvz6oGQQ3hWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065963; c=relaxed/simple;
	bh=tAhx4WtHwtNNtqBtA6C9IS/6URDL5GzuezIWXIWXOJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV+8xFYUahd7V3MjwoypKLclEzeoBTM0857ei/D49A5It1w5Ek4rojiaX3ZGmb4hVKIYCo51wfuxIAUl9fZVCbQVwatHPcuTGBf27iDKorKxX4l+xGbkwOCNCN2jYuCfog4ypEX1x44EaHCThptTgOGqCo49P+Bm163Jk/in5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f8TRd/op; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZrWTg49UzMkjH8qd8vKX5SzyF13hb+rnSQKtHmhmDkI=; b=f8TRd/opCrY9v2ZjWMMp83cRTL
	K8o057bdo7X+rtob6NwPA+uNCqwDbmAUYFeIZd6ShwqIRTBRRgq/TkNEG8FpwNDUl61n13XXNjRfo
	L/wvYEiBYcPJ275FTVs6AoJ1R55b4O7yXher5u36fgakVeVl/A7tEmS9ahsG3H6xcgbgthySTSrHD
	ba2x2Az6gGYRk9WHA/sB3qy5rbduq6QgwF4cZ8zD/lxKMxVreJwGZlG/NwU11Rd1vUKu3jJBjYuXr
	ChfM17dfstrvbewzcKEifKQ2ILLXzPsc4Hz+qOEnh6qBLVhaLiAi76y5NeURt73wDP7P0pLjMh4ZC
	apRs/NMA==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soObR-00CTwi-OM; Wed, 11 Sep 2024 16:45:54 +0200
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
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 10/10] docs: tmpfs: Add casefold options
Date: Wed, 11 Sep 2024 11:45:02 -0300
Message-ID: <20240911144502.115260-11-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911144502.115260-1-andrealmeid@igalia.com>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
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
Changes from v3:
- Rewrote note about "this doesn't enable casefold by default" (Krisman)
---
 Documentation/filesystems/tmpfs.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 56a26c843dbe..f72fcc0baef3 100644
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
+still set the casefold flag per directory, by flipping +F attribute in an empty
+directory. Nevertheless, new directories will inherit the attribute. The
+mountpoint itself will cannot be made case-insensitive.
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
2.46.0


