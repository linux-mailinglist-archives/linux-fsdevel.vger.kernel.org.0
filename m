Return-Path: <linux-fsdevel+bounces-30823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D477498E757
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123EC1C25F74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967A1CCB23;
	Wed,  2 Oct 2024 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JUOKNPWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F81A0AE9;
	Wed,  2 Oct 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912752; cv=none; b=Ue2mT8Ehffzfac5ZMW1ptXtEhr31FS4VAa5nd4ecb39063caSv4J53+jdFprWYDN8OmZnK1XgJLQkoh/eHAQ7uwCRVcnxd9/IDxW0kMJ0SvaSlr+jkaHtz+LcRHcf5M7e3ZRpX+x7bGJdosmPC4LOXcpH0NcmPs9zka8jpwmF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912752; c=relaxed/simple;
	bh=g6SodgXuhFSjZPqpwigjcfcJJcRz7X6EEVS62TB2WS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6K1i4I1M+HS3Xju26VTQpDXDiwKz7aJtOU+k+NdnRgKED+njx/30XOugg1hdVVbe6u/fmROr5VYkgLH2sLCFS1QtzP5eWQaHZo263KKHM/7dl2Th4Wx/1X0got9ABN237t+rcgsE1flqUOOw0yAiVZviCbSHblpgOnRu0hQrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JUOKNPWp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bm71yghG5LmMPzMX6MAemKlkSPoby82wgR5jHJ9lUOc=; b=JUOKNPWprVahbSaKyzgJmNEx3M
	oddv6lJOok+SD7V/VPr5KC+WOTyqzaNMHoygRYybFzuPmkQvSGabEroPITqAbrEqUoJLlbjmakWUX
	hoScsaL4uMDdYEijrIvsiQxlnzqY7xACli8TttrH8Yy/LF94oWJWS2PtftPR4qaWqGqRuvnnoWKy3
	CntcYbyf3l+Z1irHv4S9UUt56wM37QvLpNIzei5pCPOpcDRWjuKox8OWO+LkUUs5Jp6TfYQ/A9P8G
	lGJTtTypJdsTL+JjpHdQkscGbV7p2UgehaMyGB0lGLtg9M8SyPMKkkCBd3EK5zQbwnJ3SKKQIc/Yi
	eB2wDhuQ==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw92M-0045tc-81; Thu, 03 Oct 2024 01:45:42 +0200
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v5 10/10] docs: tmpfs: Add casefold options
Date: Wed,  2 Oct 2024 20:44:44 -0300
Message-ID: <20241002234444.398367-11-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002234444.398367-1-andrealmeid@igalia.com>
References: <20241002234444.398367-1-andrealmeid@igalia.com>
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
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
Changes from v3:
- Rewrote note about "this doesn't enable casefold by default" (Krisman)
---
 Documentation/filesystems/tmpfs.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 56a26c843dbe..0385310f2258 100644
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
2.46.0


