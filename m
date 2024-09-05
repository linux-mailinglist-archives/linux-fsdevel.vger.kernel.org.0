Return-Path: <linux-fsdevel+bounces-28783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F57096E2A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF81C2588E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F318D643;
	Thu,  5 Sep 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WdLwE6Cn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A418D633;
	Thu,  5 Sep 2024 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563037; cv=none; b=uuA4yNrABkKQiY4NUMfsKutOJFPgBiB1HVMWVsp3HQCWSOLZIqbGxQ8C28DQQs0IyG0Q3hRfGTtV4JUqZcZl2IYWiP9Fx1qrqGDlIyjKRkwvVww8b2z7phYg376n7FQKwILxyEL77VPJTF2OXZ3sKksKO7vBb85yI4JZKcTOwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563037; c=relaxed/simple;
	bh=w9njlXbTjKRFGbFKbv7kGAlfDQmuLVt42zz+nC9FzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6/nAeyAEq0Y6GoV8NbZ2PMQ45DfXGRq0Wkw7uLgFG68Ok7EfXFmwtMybEiQxCNcUnFYjz73/ZHNV0213TdplDaKDmkbwah/XA5iir4p76PnbXhP7uyppiZV6Q9+MaxxzhkLQpOgpPnkEdF1fmEfOye9CiyW2A/0n2PMqusCPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WdLwE6Cn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/LWMOwEq5GUDt5NImZXWEjsD4awT5R9j9E8cdrJ7p4o=; b=WdLwE6CnNPUk/lsHJztjMUkO1P
	+tQrfJtNZbR2466KvpkhAb47I8QsJqk19D2JRASXbyOu98VInDhMDWQ59T+6tthxgIv2DV3PMZTGn
	50S5rIaMFmmD6YrSxYF9uBN3+dJR/kHGxDWPFEGZLeyurkyEkWiEhU6HHQCvIjdoJZpC+/LAVS0iC
	iboVw7Uax+cEX+It6g/ziPM2e1sK+892Agovno4V+gWDpsL+DSvSchSEQdh0DFyXwj8xpAQ7jyobH
	fA61Fh/M1s2fyuoI72AvqlyV4W1Nw0byJx1aChWO4PtaufxCZptDFlTeEFBcjrfTpUhMqmpDsPsSf
	KPxrkOAg==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHli-00A6Ho-U0; Thu, 05 Sep 2024 21:03:46 +0200
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
Subject: [PATCH v3 9/9] docs: tmpfs: Add casefold options
Date: Thu,  5 Sep 2024 16:02:52 -0300
Message-ID: <20240905190252.461639-10-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905190252.461639-1-andrealmeid@igalia.com>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
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
 Documentation/filesystems/tmpfs.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 56a26c843dbe..636afd3eaf48 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -241,6 +241,27 @@ So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
 will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
 
+tmpfs has the following mounting options for case-insensitive lookups support:
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
+Note that this option doesn't enable casefold by default; one needs to set
+casefold flag per directory, setting the +F attribute in an empty directory. New
+directories within a casefolded one will inherit the flag.
+
+Example::
+
+    $ mount -t tmpfs -o casefold=utf8-12.1.0,strict_enconding fs_name /mytmpfs
+    $ mount -t tmpfs -o casefold fs_name /mytmpfs
+
 
 :Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
@@ -250,3 +271,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
    KOSAKI Motohiro, 16 Mar 2010
 :Updated:
    Chris Down, 13 July 2020
+:Updated:
+   André Almeida, 23 Aug 2024
-- 
2.46.0


