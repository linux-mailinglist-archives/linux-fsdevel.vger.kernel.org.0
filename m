Return-Path: <linux-fsdevel+bounces-31635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471D9992EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1371F2903B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8431F4FA4;
	Thu, 10 Oct 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QviYkYoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B21DFD93;
	Thu, 10 Oct 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589309; cv=none; b=Xd8ggrEW388B8LPhD7KCD3BKFRXdrqnS5SfzRASeI68DX4t0w7QuJbTykhL7Q18mH2PhWzyOBSHlWmw5cF1/mxWhS+LunOuHNYYGSIP/Eq2mk+RG76Nf8y7E874YfUy5L3UBohZE0ZvcTSQu8Df1fGTvLgFlyHE5TgFp6KIS9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589309; c=relaxed/simple;
	bh=xu7ABk+rICb5+7zadviLGl3zQLm7GHCVyk0SKFszPHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYFbfqbOggUBQ9tPUpnqprD2DF/c2r1JDvEVyDnUKIJLQ52UeNviP86avD6Y+cncP5ttDZwI7AI5gMFH7kG5fznJJz+7AmVHg8EithZive2Dm+142IV/ELjB8qqce/4UfmBG45mjLKHzgQiLkOjjSXc/kAdsSDIi/yvCWnNkxio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QviYkYoZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MO38/TKDXEZfYM/HH5HvDp3/o+h1cffvB2kBOci8370=; b=QviYkYoZfsrN9cX7rTubnq98UU
	7LyTxBOAopZwqqGYcT0V6e+Q7BQ/Dr35uDEh4j7FjWja0wRFY8+dIs2zKg+VX8ftdZIBv19sl3aWT
	8uRNDIcbA9EWiIytTjGgBDR4NmXyimdqgJwM6O7/5n3dRZXLZ2ecQ4DxGKmhrS5hSPKT8GpcSZWUj
	PWia/6xhppkTkKyrUtKdblHmaPN9BviQZ2BvK3zAknjjxgdGDds3/5r+VT79DrY3kwaLu5RDY4n5m
	l3bGuz6Ulehzjs+fE3jAQVzYLHhOMAP7kNs6J1zEx+xYKeVVUIEoOIAUEZJX2E8iTEuo/jAX0y/L/
	o1tSV/3w==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz2d-007SHz-5Z; Thu, 10 Oct 2024 21:41:43 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:45 -0300
Subject: [PATCH v6 10/10] docs: tmpfs: Add casefold options
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-10-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>
X-Mailer: b4 0.14.2

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
index 56a26c843dbe964086503dda9b4e8066a1242d72..0385310f225808f55483413f2c69d3b6dc1b9913 100644
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
2.47.0


