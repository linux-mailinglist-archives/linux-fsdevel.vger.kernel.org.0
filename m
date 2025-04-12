Return-Path: <linux-fsdevel+bounces-46315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B5A86CB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 13:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6D8C2251
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E21D9A5F;
	Sat, 12 Apr 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjtZk5Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D32B9BF;
	Sat, 12 Apr 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744456187; cv=none; b=pIkflx/Yx4v+2vVoRjNhmN1IKVomiruRsw4Wms3QqQ17BwQe4hQy9aOXYSq/UzUtPzY++SlG6cYUukMm2c7IGO1hiO1H/p2CxNFscmQG9Ow7k7GfUduMiQ8RsMI+KKW8WUZrlu/zfbGhwZzby1Bdixsg1RyHlNvKUC/HmFqSVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744456187; c=relaxed/simple;
	bh=rWUN8Z1mCOTMaKbl6yIJVQWE6ZQaqOIt7ChjcxohXEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toDtE016sQ8pNHmfpxgIqeOj+anzwtd9I5st89BVKtpLHcw84k6ZsSthmv9+fvK1NHKRnL2re1TZW8HpAdlyEN7SYGa76I2UTD7NpBKxAoelO1qKw3Xu2YYAiuCtsl1B+5SiA6s7hbUD7tm8rFWNZFhq//648EG+DXyJIIXz3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjtZk5Ln; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1662590f8f.1;
        Sat, 12 Apr 2025 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744456184; x=1745060984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfzidggO6FjeXS6iUbqAF7FeSHPmBoKvbbkf/LSnXH8=;
        b=ZjtZk5LnQ6dLipQrds2KoyM/2yt8rBrkOyzjTyBY2M3GKvLhE3tMFP5Eoz0pKElWDU
         ZGrjPq1RZ6dsLwyBJghUm3rD2UTcQgmNn/mcYqvse3vAm0XRXGKvkBilFzCzHz5CHkXu
         ooUAkW9nmnA+m287tWvtTu9chwaC/J99lVfOsSSP7CsRO+Dh0L9Ul1mccYLKGP83hNBW
         qJGXcmqNM/PL5nTXLxSVTHaQGNraBZjwgWgwUY23Em2fn8EU8YXLgTG9wYbFUVF4+c4y
         pXal1bf2FjUUGoE68a/NrDDCQ/X/we00LNM3FrIVRGwkkdg/x6I0U45yNhpNEX6bm42h
         f37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744456184; x=1745060984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfzidggO6FjeXS6iUbqAF7FeSHPmBoKvbbkf/LSnXH8=;
        b=ufEbL6CTBZCJKEy3x7AaQzwhsn3kycpuNINbCMhJ/yvA+W/XnhRN4c3qqBc7cVJ75P
         jyYOCXoAG3C0QanJCK3yd8W28Qk8N1/B/JRbNQkQieZHoNx4/+18Du52VyQs8i0Jbj+H
         2RiDZ2UZxwDEJThFMeqftZIlpeV5ca0LNbHl+LRkr4rObHSY+tGwaY+cmhtp/E7JULya
         +sjA0N6aHR5SuxiS0W9mnRezXz55mUa9Bg6Hi3i6rqpmkryJG2Ko+r5dCW5HUojob9DL
         ZRbuwF75Aj/6O8Q4vQvA6d6QDFnyxXoAra04H7Feam7o72zByHRiyfr1l+EfcE7/42WB
         vJuw==
X-Forwarded-Encrypted: i=1; AJvYcCVxx12TR8Rpgb0cwrr3AnVOLJ7wp1K5bG/6bFKGVxPjKW//Zp5xrLrlDN/1SX+q4LxIZqnLL5rU1NvDaAnb@vger.kernel.org, AJvYcCWhAgSogvbpgGncL+wSwCpnOheEbpmpBiKziYc+diYSl+IWyM8yDkHC3gjqYngSE7X09M68IqDM9i4sYMV7@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOTwPK7CB+0Nwd1zLDiB8SlijmsbCa8wv6MRDckdt5xLF86sK
	F0dGERMBkVPG2WQCnbaDC7ofmQbcULSkUlQHe9wO9RRpyEZai7yP
X-Gm-Gg: ASbGncvaaoQgzhnCBxq0FWRYxRRbDm8d51qD6b2+P3fBgY75K0E0AEB53EBn6Vm2VVR
	9v891/+5JQZas2er1l/Y3CMKC0sFescX9RQh0ykkyUCdNrHTL0YYlDzj4JhBIVvas/WyQ6VkeEu
	b15MmROTXpbyD/3HrQPl+f8arr1HHBqomGAvt+2MJ3+FCybcnFfMZeS+GGQLlG292J7L7ciVuW4
	nHVhmOMdmqXkhLSZL1kc1FDojxJJE41IBeS3SyS1Vqv63+n0e2WPFychnGWvPbczFq0SbUsfZOo
	RR79OsGTebWyDbOKdLJgtbzKhriDIF+qsGB5QG0xfXkmL/dyjrk1ZGBd
X-Google-Smtp-Source: AGHT+IHzzBIrGdFrekn7hA9hmhYH+A3II1dtwo24jWsVLSLa1RdXcGYElBEIOmB08tXnbioaF6bSvQ==
X-Received: by 2002:a5d:59ae:0:b0:391:2f15:c1f4 with SMTP id ffacd0b85a97d-39eaaecbe1fmr4718324f8f.55.1744456184042;
        Sat, 12 Apr 2025 04:09:44 -0700 (PDT)
Received: from f.. (cst-prg-90-20.cust.vodafone.cz. [46.135.90.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aeaccsm113509275e9.33.2025.04.12.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 04:09:43 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: improve codegen in link_path_walk()
Date: Sat, 12 Apr 2025 13:09:35 +0200
Message-ID: <20250412110935.2267703-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking at the asm produced by gcc 13.3 for x86-64:
1. may_lookup() usage was not optimized for succeeding, despite the
   routine being inlined and rightfully starting with likely(!err)
2. the compiler assumed the path will have an indefinite amount of
   slashes to skip, after which the result will be an empty name

As such:
1. predict may_lookup() succeeding
2. check for one slash, no explicit predicts. do roll forward with
   skipping more slashes while predicting there is only one
3. predict the path to find was not a mere slash

This also has a side effect of shrinking the file:
add/remove: 1/1 grow/shrink: 0/3 up/down: 934/-1012 (-78)
Function                                     old     new   delta
link_path_walk                                 -     934    +934
path_parentat                                138     112     -26
path_openat                                 4864    4823     -41
path_lookupat                                418     374     -44
link_path_walk.part.constprop                901       -    -901
Total: Before=46639, After=46561, chg -0.17%

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I'm looking at skipping perm checks with an "everybody can MAY_EXEC and
there are no acls" bit for opflags. This crapper is a side effect of
straighetning out the code before I get there.

 fs/namei.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..40a636bbfa0c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2424,9 +2424,12 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	nd->flags |= LOOKUP_PARENT;
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	while (*name=='/')
-		name++;
-	if (!*name) {
+	if (*name == '/') {
+		do {
+			name++;
+		} while (unlikely(*name == '/'));
+	}
+	if (unlikely(!*name)) {
 		nd->dir_mode = 0; // short-circuit the 'hardening' idiocy
 		return 0;
 	}
@@ -2439,7 +2442,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 		idmap = mnt_idmap(nd->path.mnt);
 		err = may_lookup(idmap, nd);
-		if (err)
+		if (unlikely(err))
 			return err;
 
 		nd->last.name = name;
-- 
2.43.0


