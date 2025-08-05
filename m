Return-Path: <linux-fsdevel+bounces-56711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715CB1ACA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95180180554
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C091F7586;
	Tue,  5 Aug 2025 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FYMQQOOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811761C7017;
	Tue,  5 Aug 2025 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754363378; cv=none; b=UIecuznUGXVH9NYpHEC/K8UvGiVd6Hle1t6EJsszKu9MtG2llfCOv8JRvAbvAavNnGTxmMKBJkw+UR/Z3eu5xYf9eUoxDP0y894pBS380K2s7EWOgjqpcKf90HR4F5av+6cTEmP+PrvxKYXlNDeGWEyfB2Ve3NRIAZXUWg/zFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754363378; c=relaxed/simple;
	bh=sVKGQYZABr+uXF5DuzMT4wcV399UBDjv2xqzr5bfYaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlMfDvNlWVhWDo8hD6VdQpieEiEhbn5/T9xx/EoxlB9ezTm1NU1PBNMCzbB8g4YNerPrxXEebCQ8n7MZ0xRu3r/RzGHdOYt1JpCOjQdb9e6jGXq14/dD8j5eP5IaQ7B8pVfAFgHaOs7lck2TbeQ/g+vDeb7S3u1PBI7mL9M4HLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FYMQQOOi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r7L8d0fGkTI8sFsx42NCIdi0nGDAC2uQf7TDxAnWwwM=; b=FYMQQOOi623eQaHcZuOtIsvTZe
	5Dmb07Kimx3TUJdOXWZhWCh8s+JQwB0OIxALbJeK9xZTGGlZJgOWiclPsWWW5hef9P9cJ44StwgPY
	9+k033eSh8/Xvws11d9iIktN49SdhVVwdP3yJPgOMaKOnCF7E9UDOoIjW2i1lyWzH1sX6C8Y1V4Xb
	GtiUuaXntvn+wF+o8/l2aeuZ642TM3Oob80LWjUnwnh0cLY05ROpAKMiiVSnOU0uEni5Zf2frd7IK
	lTbLeNcu96iJih4FJUCVbX0WTTlyP/fL/+0eBnogZffZmd2EGqp6uWzaidku44iRmQxEVy8oYZpO5
	LqWziO8A==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83S-009TiJ-5D; Tue, 05 Aug 2025 05:09:34 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:11 -0300
Subject: [PATCH RFC v2 7/8] ovl: Check casefold consistency in ovl stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-7-0e54281da318@igalia.com>
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
In-Reply-To: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

overlayfs supports case-insensitive filesystems as long as they are
consistent regarding its enabled status. If one layer has it enabled,
every other layer must have it enabled as well. Check if this
consistency is being respected, and return an error otherwise.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/namei.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 76d6248b625e7c58e09685e421aef616aadea40a..5dee504667911f04ce543f7977d0d4c4a1190cc7 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -238,18 +238,6 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	bool is_upper = d->layer->idx == 0;
 	char val;
 
-	/*
-	 * We allow filesystems that are case-folding capable but deny composing
-	 * ovl stack from case-folded directories. If someone has enabled case
-	 * folding on a directory on underlying layer, the warranty of the ovl
-	 * stack is voided.
-	 */
-	if (ovl_dentry_casefolded(base)) {
-		warn = "case folded parent";
-		err = -ESTALE;
-		goto out_warn;
-	}
-
 	this = ovl_lookup_positive_unlocked(d, name, base, namelen, drop_negative);
 	if (IS_ERR(this)) {
 		err = PTR_ERR(this);
@@ -259,9 +247,16 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		goto out_err;
 	}
 
-	if (ovl_dentry_casefolded(this)) {
-		warn = "case folded child";
-		err = -EREMOTE;
+	/*
+	 * We allow filesystems that are case-folding capable as long as the
+	 * layers are consistently enabled in the stack, enabled for every layer
+	 * or disabled in all layers. If someone has enabled case
+	 * folding on a directory on underlying layer, the warranty of the ovl
+	 * stack is voided.
+	 */
+	if (ovl_dentry_casefolded(base) != ovl_dentry_casefolded(this)) {
+		warn = "casefold mismatch between parent and child";
+		err = -ESTALE;
 		goto out_warn;
 	}
 

-- 
2.50.1


