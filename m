Return-Path: <linux-fsdevel+bounces-57810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F6B256DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FCC9E0636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B453009C3;
	Wed, 13 Aug 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NENZjkAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5893002CD;
	Wed, 13 Aug 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124671; cv=none; b=fx3lBe9AZor2RqmEBUjHCe44GfRwP/Gh35p0CskRFhA8PgRQgP4J0C357+9ZSD6uKdoOA3ltLmDa38jUrxFuDapQ0YxSNgz6WBXek2gCeuOQ/nTQdzZZBQBi7LleVD1cZPS4KLtQNuak4zFMQZJ50RyMDt+geH5Y12bMqrCwgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124671; c=relaxed/simple;
	bh=A+N8wnRu45k2gcVZ9YAl5PweYWKQWyAh8iCFjdwnaUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAZK+dZQl9GJ9x6hPUXGrdTx2RN6VaAwzmKBA2zBUjF5OlqjLn8rHB3FPe6q1srGPH1sjlUv1kETcNVoFWAib2soRskyir53GpAFI67BYHIwuinfvsV5cdS0grPAl+GcfAgJAQ8YLPhQwY+8guwuUWOnDfJ3Pzh9m5qS8do5/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NENZjkAk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cv3fcHf48DjB8ea0TBmFVJymw4b3vUHLc9r9wSKK1QU=; b=NENZjkAkg0YaCqKznsr8M1SjbV
	xrctuqmXQ57qglbYbJnH2Bf1oqm3d1ygX6Tw1kfZDR7AfrixIH7DFML4i0aNacPPUeYsBdv1SUNP5
	M5/8wqw2Fbx8WfbmZDHGwcSEek/855RxvZ0DPBcWHInmKrfzp2uO+KTRTKWLGoC9Ijw7O3KOzoDZ2
	D7q+vaj2SviTgUxCb6rDnFhNrIZReIH30YqAbsYoCJz7naaQ2hYC3uVLCe04M+UB9oIio2oFrHxxp
	1of96cxmFBzCIzzSZfiHcA07cpMWqOexgTJh7y24rh6mvmGygFX/O6bIEllwQvFa8Ok2DLqOvZDRc
	9pPZ75Rg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK6K-00Ds0c-Ic; Thu, 14 Aug 2025 00:37:44 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 13 Aug 2025 19:36:45 -0300
Subject: [PATCH v4 9/9] ovl: Allow case-insensitive lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-tonyk-overlayfs-v4-9-357ccf2e12ad@igalia.com>
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Drop the restriction for casefold dentries lookup to enable support for
case-insensitive filesystems in overlayfs.

Support case-insensitive filesystems with the condition that they should
be uniformly enabled across the stack and the layers (i.e. if the root
mount dir has casefold enabled, so should all the dirs bellow for every
layer).

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- New patch, splited from the patch that creates ofs->casefold
---
 fs/overlayfs/namei.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 76d6248b625e7c58e09685e421aef616aadea40a..e93bcc5727bcafdc18a499b47a7609fd41ecaec8 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	char val;
 
 	/*
-	 * We allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories. If someone has enabled case
-	 * folding on a directory on underlying layer, the warranty of the ovl
-	 * stack is voided.
+	 * We allow filesystems that are case-folding capable as long as the
+	 * layers are consistently enabled in the stack, enabled for every dir
+	 * or disabled in all dirs. If someone has modified case folding on a
+	 * directory on underlying layer, the warranty of the ovl stack is
+	 * voided.
 	 */
-	if (ovl_dentry_casefolded(base)) {
-		warn = "case folded parent";
+	if (ofs->casefold != ovl_dentry_casefolded(base)) {
+		warn = "parent wrong casefold";
 		err = -ESTALE;
 		goto out_warn;
 	}
@@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		goto out_err;
 	}
 
-	if (ovl_dentry_casefolded(this)) {
-		warn = "case folded child";
+	if (ofs->casefold != ovl_dentry_casefolded(this)) {
+		warn = "child wrong casefold";
 		err = -EREMOTE;
 		goto out_warn;
 	}

-- 
2.50.1


