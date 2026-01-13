Return-Path: <linux-fsdevel+bounces-73366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BDBD1638B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1046A300DB36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C852836B5;
	Tue, 13 Jan 2026 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r2Jv5T8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16E27A133;
	Tue, 13 Jan 2026 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269125; cv=none; b=uoT70jWSLyTpBzJ6JSnoffZK7ll0DdEEeW+l0JaLjj1w9PokWbf20+UlyGx3eCqZPgptZw9/4zmAJM1296V6BVIVNd7Gs3zvgiupL3ZiJx40Dq3EAApDIltKqMWLABv6j8uB1G4u7kpxHIiYtwJQIJ7Wmt+i+JJc3f40kYugJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269125; c=relaxed/simple;
	bh=cXWrcjIu1TuAnvLNJ1kqMczhwhCilJhwU5cxyKK0D1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBn/4Ias0k+CQ9t++cPfn6CLZ8PjorzATp9v9W9wGG6chxKIfsYOQJvtZm3t8NwSVtwRCe0OhhKtqKcaJMJvAklMhscmQlvNNhyMvqSWvGR1kozS+B9ogxduzE/TKCpZ+1CVT9f8JON7+vftAD0yvh8b+UDX1Sc2B5jZVwecDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r2Jv5T8y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KjmEHcmuPBEPC5lqMLN5wiVEiW4EnFopnwUvVuNy1ag=; b=r2Jv5T8yL6nR/rcA6Z383GLUwV
	5aXH8rN7h5T/ES3VKoVfNahVvNX4aFECmQvpTybISNuWsU6yqmfPELRYSz5EVGtdl1KUIk420NbVJ
	9oZcvC0dDxh0teeSvBJtiWN0Q9RfLtIxn+A9+n8ZWv5O6/8pMMEIBD4jh5l7nhHnWtNreSAIgb+bn
	ljl9+TDqOaisAnQ5bAhGpNbcwijl/7Y6wfAzzmfrr97iv+Bs+ZMXiz+e9OXUJ/6FRaq1eSq1w8+T6
	IFTzvMtp68amlYV4yN3+PHxKLiN1Q2CP3eTiS/IOH2SsmS5pFTsHJxRuwH83fYAxbgKRNR94PEK28
	B/TjX00Q==;
Received: from [179.118.187.16] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfTZb-004eIK-HG; Tue, 13 Jan 2026 02:51:55 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 12 Jan 2026 22:51:27 -0300
Subject: [PATCH 4/4] docs: exportfs: Use source code struct documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-tonyk-fs_uuid-v1-4-acc1889de772@igalia.com>
References: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
In-Reply-To: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Instead of duplicating struct export_operations documentation in both
ReST file and in the C source code, just use the kernel-doc in the docs.

While here, make the sentence preceding the paragraph less redundant.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 Documentation/filesystems/nfs/exporting.rst | 42 ++++-------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a2..a01d9b9b5bc3 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -119,43 +119,11 @@ For a filesystem to be exportable it must:
 
 A file system implementation declares that instances of the filesystem
 are exportable by setting the s_export_op field in the struct
-super_block.  This field must point to a "struct export_operations"
-struct which has the following members:
-
-  encode_fh (mandatory)
-    Takes a dentry and creates a filehandle fragment which may later be used
-    to find or create a dentry for the same object.
-
-  fh_to_dentry (mandatory)
-    Given a filehandle fragment, this should find the implied object and
-    create a dentry for it (possibly with d_obtain_alias).
-
-  fh_to_parent (optional but strongly recommended)
-    Given a filehandle fragment, this should find the parent of the
-    implied object and create a dentry for it (possibly with
-    d_obtain_alias).  May fail if the filehandle fragment is too small.
-
-  get_parent (optional but strongly recommended)
-    When given a dentry for a directory, this should return  a dentry for
-    the parent.  Quite possibly the parent dentry will have been allocated
-    by d_alloc_anon.  The default get_parent function just returns an error
-    so any filehandle lookup that requires finding a parent will fail.
-    ->lookup("..") is *not* used as a default as it can leave ".." entries
-    in the dcache which are too messy to work with.
-
-  get_name (optional)
-    When given a parent dentry and a child dentry, this should find a name
-    in the directory identified by the parent dentry, which leads to the
-    object identified by the child dentry.  If no get_name function is
-    supplied, a default implementation is provided which uses vfs_readdir
-    to find potential names, and matches inode numbers to find the correct
-    match.
-
-  flags
-    Some filesystems may need to be handled differently than others. The
-    export_operations struct also includes a flags field that allows the
-    filesystem to communicate such information to nfsd. See the Export
-    Operations Flags section below for more explanation.
+super_block.  This field must point to a struct export_operations
+which has the following members:
+
+.. kernel-doc:: include/linux/exportfs.h
+   :identifiers: struct export_operations
 
 A filehandle fragment consists of an array of 1 or more 4byte words,
 together with a one byte "type".

-- 
2.52.0


