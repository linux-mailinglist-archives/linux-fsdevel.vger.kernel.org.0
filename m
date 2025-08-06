Return-Path: <linux-fsdevel+bounces-56808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1537B1BFAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E32817E6B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC51F418F;
	Wed,  6 Aug 2025 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="DK6PjxR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4981F09A8;
	Wed,  6 Aug 2025 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455737; cv=none; b=VurPjuv3yKHfj6RY6CNqeC6ZP50HJG90dQxckq4u8xtRiVd1tXHwBS56LW3NI0KkSg6uAfZ7b1ZCYGUY4rSfzj4bSTrzcC+DnohHmVSGT1NFUX+9pHs3a3u4v7uwaMvdS23Qb1g5gWbgkB/7osP7b0EwbeTafaGY/yxXwph0bXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455737; c=relaxed/simple;
	bh=4s8Gi1EenOHJaLb55g1juwsl7ZsPZjgWY4gDBSu2WAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nijj9GrOueCcGpbnz6PHrtsd9vhiuotvgCNregrfc+amQ7m/NuDPSHiMuxetJS2Wc2fkcXNPmazHK/OJe72EBLpbUvd5LzvVKqaxdnfSqPyLa7O4Vfub0XTjpbTSZpZ/Cxs274VuzxzZfJ2s2XS6FqbtPejUMqX8NBC+DaYAl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=DK6PjxR/; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bxd9J21lsz9tcW;
	Wed,  6 Aug 2025 06:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754455732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOE9waL0ew+X+ln2ytNi3KfwfeUFVHt9mFZ0tGiHb8c=;
	b=DK6PjxR/9ImS0JWNd3vv8Ze6rOf4pQNc/2QZhAdFa+q3bFH969lnNbTJtZVngV3LhWABS2
	80EEyJoAPfrLat25yfgKuyqOFDsGvLUloSaDKHls0FmYGT4PLaPlRB/oZQW9WFG03zRO8w
	Ce4YqQqWrCevQgPZeTO1u7FbF1wfVq8LMLtT7QTSB9AH7YjUC64mv29WoT5l+OKWp50rYs
	dOYPhh2aPC0YbF/yC6BKs2SCYdY5GYS8sXrxZ3A/PiBVGujQAT/bl0PMpf23ntMrTHqQ2u
	C+IAwJhidXDDCcXyQc1sCLlKmDL7wwzDIOi5a9cWx4eASxE+O/p/a0dDaNetGQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 06 Aug 2025 14:48:29 +1000
Subject: [PATCH 1/2] fscontext: add custom-prefix log helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-errorfc-mount-too-revealing-v1-1-536540f51560@cyphar.com>
References: <20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>
In-Reply-To: <20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3383; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=4s8Gi1EenOHJaLb55g1juwsl7ZsPZjgWY4gDBSu2WAI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMurcqbMnxaRq538u4Ptok++s3JBy8dXzjsfkv7LV2v
 DqVpWdm11HKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAmcuM4wz+7qU/nMKxc4aIx
 edE8+95L9h7TMj66HRGYbHSxwYUt6aQswx9eH+WT3pu0Ln/Y8MZZ2aPoxBad5xmbug/rmdXfuKL
 a8YALAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Sometimes, errors associated with an fscontext come from the VFS or
otherwise outside of the filesystem driver itself. However, the default
logging of errorfc will always prefix the message with the filesystem
name.

So, add some *fcp() wrappers that allow for custom prefixes to be used
when emitting information to the fscontext log.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/fs_context.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 7773eb870039..671f031be173 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -186,10 +186,12 @@ struct fc_log {
 extern __attribute__((format(printf, 4, 5)))
 void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...);
 
-#define __logfc(fc, l, fmt, ...) logfc((fc)->log.log, NULL, \
-					l, fmt, ## __VA_ARGS__)
-#define __plog(p, l, fmt, ...) logfc((p)->log, (p)->prefix, \
-					l, fmt, ## __VA_ARGS__)
+#define __logfc(fc, l, fmt, ...) \
+	logfc((fc)->log.log, NULL, (l), (fmt), ## __VA_ARGS__)
+#define __plogp(p, prefix, l, fmt, ...) \
+	logfc((p)->log, (prefix), (l), (fmt), ## __VA_ARGS__)
+#define __plog(p, l, fmt, ...) __plogp(p, (p)->prefix, l, fmt, ## __VA_ARGS__)
+
 /**
  * infof - Store supplementary informational message
  * @fc: The context in which to log the informational message
@@ -201,6 +203,8 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define infof(fc, fmt, ...) __logfc(fc, 'i', fmt, ## __VA_ARGS__)
 #define info_plog(p, fmt, ...) __plog(p, 'i', fmt, ## __VA_ARGS__)
 #define infofc(fc, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
+#define infofcp(fc, prefix, fmt, ...) \
+	__plogp((&(fc)->log), prefix, 'i', fmt, ## __VA_ARGS__)
 
 /**
  * warnf - Store supplementary warning message
@@ -213,6 +217,8 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define warnf(fc, fmt, ...) __logfc(fc, 'w', fmt, ## __VA_ARGS__)
 #define warn_plog(p, fmt, ...) __plog(p, 'w', fmt, ## __VA_ARGS__)
 #define warnfc(fc, fmt, ...) __plog((&(fc)->log), 'w', fmt, ## __VA_ARGS__)
+#define warnfcp(fc, prefix, fmt, ...) \
+	__plogp((&(fc)->log), prefix, 'w', fmt, ## __VA_ARGS__)
 
 /**
  * errorf - Store supplementary error message
@@ -225,6 +231,8 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define errorf(fc, fmt, ...) __logfc(fc, 'e', fmt, ## __VA_ARGS__)
 #define error_plog(p, fmt, ...) __plog(p, 'e', fmt, ## __VA_ARGS__)
 #define errorfc(fc, fmt, ...) __plog((&(fc)->log), 'e', fmt, ## __VA_ARGS__)
+#define errorfcp(fc, prefix, fmt, ...) \
+	__plogp((&(fc)->log), prefix, 'e', fmt, ## __VA_ARGS__)
 
 /**
  * invalf - Store supplementary invalid argument error message
@@ -237,5 +245,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 #define invalf(fc, fmt, ...) (errorf(fc, fmt, ## __VA_ARGS__), -EINVAL)
 #define inval_plog(p, fmt, ...) (error_plog(p, fmt, ## __VA_ARGS__), -EINVAL)
 #define invalfc(fc, fmt, ...) (errorfc(fc, fmt, ## __VA_ARGS__), -EINVAL)
+#define invalfcp(fc, prefix, fmt, ...) \
+	(errorfcp(fc, prefix, fmt, ## __VA_ARGS__), -EINVAL)
 
 #endif /* _LINUX_FS_CONTEXT_H */

-- 
2.50.1


