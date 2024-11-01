Return-Path: <linux-fsdevel+bounces-33393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD19B88A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66D328288A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2B823DE;
	Fri,  1 Nov 2024 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F29RFp4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FA3F9CC;
	Fri,  1 Nov 2024 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425096; cv=none; b=cB4rDBf3vaBybmGHIfsGPIIZxxjU2BAzoqRJRpMISdm7MxmPRVyDvH2SGInoQFqYmTRL/Ai6GVlQ01folShBUxPPSZrIHJiaSkJ5WKvMRAvUqqWJEWirGD/AkORCtFa/1T9sIk9jDTkzExSfBfGrA8C/bQ2r6Ve7wOHEDjEdGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425096; c=relaxed/simple;
	bh=emJCuip6O+uYAJz+KzUytVj8TFsHxkL2bexsE8nkMbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idjz+dWJJLYVnWAiXNoUSo1LdRwBSR1b4nYBF1S8kQ+3YNv/ba8q3XivyVkjyDvr2zrZvyoTk2la4YXRjklBo7imMpI/ZR5f6Qj9ij6qU3xymMdU6HKvAR4K2o6TJfgqedb4xS/s+BFSAFiA+a91ap4a4a9JoQDvGZA8IVerZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F29RFp4N; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8swRcMqa/BS2pXAGjnNhVyXxuHalIiMIO71jJmsFBEs=; b=F29RFp4N0vPj0s1J5QEIiOahhJ
	XtmstjmkH5wGBzWkqKIEA2OND/3xKxCb9IEFo6qCWlDuQUR5ousxHS8g3uJENfHud0qXvl4NTrPCN
	dviD8nbyefB44gJh9xemI7cUIggGvtLvhYX89M6abblhgPv8kDkh4tN9Haq95WNrpI8zaTZWKj6ly
	SuhaBPbLcCtIVKQG7cgniiwSRd+pSEpfxhAWMKAzuEMOUBvk0ZXR9HEhnLn6jEL6eDElGjGeLFRKI
	f7liZadXemfK5Ip7WLRt8d4nYTXsQ3hkFzmReoEDsMG/+k+wlw3DF5/yoqIOwXTnl9gQLak28w572
	LDDltqDg==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6gbq-000G0m-O1; Fri, 01 Nov 2024 02:37:55 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 1/3] libfs: Fix kernel-doc warning in generic_ci_validate_strict_name
Date: Thu, 31 Oct 2024 22:37:39 -0300
Message-ID: <20241101013741.295792-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101013741.295792-1-andrealmeid@igalia.com>
References: <20241101013741.295792-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the indentation of the return values from
generic_ci_validate_strict_name() to properly render the comment and to
address a `make htmldocs` warning:

Documentation/filesystems/api-summary:14: include/linux/fs.h:3504:
WARNING: Bullet list ends without a blank line; unexpected unindent.

Fixes: 0e152beb5aa1 ("libfs: Create the helper function generic_ci_validate_strict_name()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20241030162435.05425f60@canb.auug.org.au/
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/fs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b279f60e48f..b562a161e2ee 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3499,12 +3499,12 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  * @name: name of the new file
  *
  * Return:
- * * True if the filename is suitable for this directory. It can be
- * true if a given name is not suitable for a strict encoding
- * directory, but the directory being used isn't strict
+ * * True: if the filename is suitable for this directory. It can be
+ *   true if a given name is not suitable for a strict encoding
+ *   directory, but the directory being used isn't strict
  * * False if the filename isn't suitable for this directory. This only
- * happens when a directory is casefolded and the filesystem is strict
- * about its encoding.
+ *   happens when a directory is casefolded and the filesystem is strict
+ *   about its encoding.
  */
 static inline bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name)
 {
-- 
2.47.0


