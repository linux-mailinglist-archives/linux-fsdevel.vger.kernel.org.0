Return-Path: <linux-fsdevel+bounces-50955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B442AD167D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 03:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6243A9BC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 01:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9017DA6D;
	Mon,  9 Jun 2025 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YPYHJcSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50ED33F6;
	Mon,  9 Jun 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749431967; cv=none; b=pcVn1QKEaTWyXfGbBWZtC9ZUHgi+bRbGmIEz5PlgUYxiivPwXEpglpxQJjY7NdU2GuKyPDPZnc9dPjS23GWQZLotyhiZkOquhvVVkZvwssLjJMeOWDk9UKOIgWpX35Qah9nxaPoiYjCrqPa+2m8o5E+no73rbZzWFyv/ChUnybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749431967; c=relaxed/simple;
	bh=XLZMwSRESW/C5OkrpBMkd7IG+fBAs0orxV9EKuOiPnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrMr5o2JznnDjokT6XjQq+V9fgmJeDv8i+ds5pjFz5BWOndugxPhwNdxDge9CIMcI+2GhFeV0I+pQcK1Hq5xsA5IrWKVFWhK8lhyC6VhO6/+iMaGU1YYeqB1rI9K9115E2+GDa5s+USbt7y5/SWN2C8UghOAr7r9Du/BBucdW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YPYHJcSj; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VXsWntt029waI1pQVSsbwUYWzJDbn6MIbHHxgxV23sY=; b=YPYHJcSjrXmUftZB
	SWWYZXsdrS4K08DZL3530vPoGClZ1/9qJn57AkCfzGe/n9I0sGd+1ZI5XZJTmQ6lDdvmg827Lu1lL
	4yIGvmLOBUt1VfwudsSp8W85nOjQ8Ku/UysXabP7JT/yvhfhN4yH8BGmrigOM89r4n13+WMeYQL+Q
	aZS6p+PyeLrlO/IFbptiWfSLmoqsNwDKg2kTof/J9a660abpv7yrmpj+bPJJ+KRuuB8BNeYhJmMVg
	bqq30lhY7RRyoGiO8XQcdZ5UTC3q+LnSM1X5fHEJnU3fnNFDImVE12qQrXReVuwijl4onKMkep/dN
	DFN729p+YoO7ZEd0DQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uORAY-008JU6-29;
	Mon, 09 Jun 2025 01:19:22 +0000
From: linux@treblig.org
To: krisman@kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] utf8: Remove unused utf8_normalize
Date: Mon,  9 Jun 2025 02:19:21 +0100
Message-ID: <20250609011921.378433-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

utf8_normalize() was added in 2019 as part of
commit 9d53690f0d4e ("unicode: implement higher level API for string
handling")
but has remained unused.

(I think because the other higher level routines added by that patch
normalise as part of their operations)

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/unicode/utf8-core.c  | 22 ----------------------
 include/linux/unicode.h |  3 ---
 2 files changed, 25 deletions(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 6fc9ab8667e6..1a30447c4743 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -138,28 +138,6 @@ int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 }
 EXPORT_SYMBOL(utf8_casefold_hash);
 
-int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
-		   unsigned char *dest, size_t dlen)
-{
-	struct utf8cursor cur;
-	ssize_t nlen = 0;
-
-	if (utf8ncursor(&cur, um, UTF8_NFDI, str->name, str->len) < 0)
-		return -EINVAL;
-
-	for (nlen = 0; nlen < dlen; nlen++) {
-		int c = utf8byte(&cur);
-
-		dest[nlen] = c;
-		if (!c)
-			return nlen;
-		if (c == -1)
-			break;
-	}
-	return -EINVAL;
-}
-EXPORT_SYMBOL(utf8_normalize);
-
 static const struct utf8data *find_table_version(const struct utf8data *table,
 		size_t nr_entries, unsigned int version)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 5e6b212a2aed..64fa44fe180c 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -66,9 +66,6 @@ int utf8_strncasecmp_folded(const struct unicode_map *um,
 			    const struct qstr *cf,
 			    const struct qstr *s1);
 
-int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
-		   unsigned char *dest, size_t dlen);
-
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen);
 
-- 
2.49.0


