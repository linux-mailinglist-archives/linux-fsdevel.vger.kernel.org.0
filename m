Return-Path: <linux-fsdevel+bounces-47427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4BCA9D690
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911F99250C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D72118DB0D;
	Sat, 26 Apr 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV8HkFFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1B189B8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626214; cv=none; b=T5VAJGRjLVx0wQ8v2/F9x8Xq9Ampdpq5SLqd9F0+sSvRReLtUvp6NfYovyCXGlT5e1BQ5jNo8HA0AOZtJ0M9kxX3+hrJgnrium6Uv8eXYQg9TRuHhTSXKmcq9M9vtf3vplOumGAly4X/OLG2c8+ELkbCoc7Jaldb/CqlZ9EDROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626214; c=relaxed/simple;
	bh=Ky7CiQu8Zo6jrzkMoi6uk/3V/Rd+ZVxaO3vh0LF4s3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYYIiQxkdlULtMGKUttYuIiBCefNvEJ5m1HJbaHrTcWFxVOQ1Xx2ahnRmo4Nl2dzHg7f0E2oLLnlj1Sel5vwVRMRyZExgnrgq/LwR9mgT54vBjYhmjVQB9l65bKRNdEkoMpRhvT+U4En8xLgsTIzp5umJCMq96QNapggUZNDseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV8HkFFd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso45705375ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626212; x=1746231012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnctMLn3JOXmPLObAEVTiR1lz8G0mGidN7qDPnZJRco=;
        b=FV8HkFFd5ysqHC6ypwy2DzCn5hoN56+xpHlNtKXgW52o7OFux3kojm1h1Mk2HSQARn
         wIS3HX4pHbatF+RktdzsK0F1nr3MIwlrYQMiLiSKORea5uTeydrdFHRxIXjJPoMAv6vQ
         LwofDrdGmb8GqfSqdiaE1uN6CSm6xYLDFYyuk8LBQ+DSq7TJHBkJIE266yODtWX5ybgC
         jcUhfzmGeCl6KGBfOacc0R/cBdf/yfYp9047KJrB2DSiEVt3C0gIRXsU4ZHbq72fdC8q
         XptWUyyKZE+n0ZhcmhQ/kdFt3M6kLaePkWGVhiFtzA8XdTTN2+U6p6sBB8CnDTuGrE5X
         zDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626212; x=1746231012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnctMLn3JOXmPLObAEVTiR1lz8G0mGidN7qDPnZJRco=;
        b=wRXVXAwoqSEceVQiZR46jfnaNIOyZqkllxT8LhNCOI4W+ClGp9SOA2D1jJ+ftmQM+v
         5yWGyqgdQzJ4rAZFyehnG1pMnXbqtvj9Q884hdvby9HXf+iwN927YSkZiR3ZdRGYiZi5
         BWbPRuOAl6n4Wr993/aoYq7ZRqXj1/FPF2TzRiSYBPqW6XvsownMVBbTmOE9g06uSBza
         ZWL5XEXXCohEOUmFS+rV7kI4QmzxIdz1WTo1a93E8mV4Xncxt4BrhZVS9seDmIRvWGVk
         wnWMvO1URvJ1pDNU7/g8L+IpLCsAN2VPzY1kkE/Skvqqm824Me3jr+HvaCOBJCrNbrIo
         5VJg==
X-Gm-Message-State: AOJu0Yyfa/op01qFoxFymTl51Oz4zFlleyhaiH+82ydZYtmkcCLD9ani
	b5LdXu5pk6mJAgYYDkVy7hCkQYqWnGTYODJnDvBLhmUDGbYq2uiTSP1UfA==
X-Gm-Gg: ASbGncuDUoVmB1qNPCMQaPttxeEcQf8wKu2BIkkVufq7mxVP6PPQzmAeuyg+I02Zv0A
	tEvkxjgGdeDcZklsSdJSUJAV9jMugDCFtqeJc4EakqHxA/nxy1fVAEXhK8YlR/tCN9xXK7t9JHj
	f8wud1v1Hgu8uq/bdrSXMVAMxgDej9MVdVDQYCFDYyKmiq+dSe2xTK4FoEI1l+kH6AQxilTeo1Q
	bNt7T4T4sRs494YVgocO1mdPcw82rUfSuTkDzrqldByMJu81b6KXtuEpCH8Z1swm2p4RBYj6nE6
	4fYK2XysMasrITyAndQiSAyOW0PMxAhMXKVvfgkIdcs9IRA=
X-Google-Smtp-Source: AGHT+IH+jaUtebhMTeVC4oD2Y684YFzd5Ol/fnOY1xJ3OesxsrcG1MBjmA4KVnYF8r4BbvkFUhwtEg==
X-Received: by 2002:a17:903:fb0:b0:223:f928:4553 with SMTP id d9443c01a7336-22dc6a8745emr22768935ad.44.1745626212417;
        Fri, 25 Apr 2025 17:10:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5104ec7sm38580595ad.175.2025.04.25.17.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:12 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 04/11] fuse: support large folios for writethrough writes
Date: Fri, 25 Apr 2025 17:08:21 -0700
Message-ID: <20250426000828.3216220-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for writethrough
writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index edc86485065e..e44b6d26c1c6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1146,7 +1146,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		unsigned bytes = min(PAGE_SIZE - offset, num);
+		unsigned int bytes;
+		unsigned int folio_offset;
 
  again:
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
@@ -1159,7 +1160,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		bytes = min(folio_size(folio) - folio_offset, num);
+
+		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
 		flush_dcache_folio(folio);
 
 		if (!tmp) {
@@ -1180,6 +1184,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		err = 0;
 		ap->folios[ap->num_folios] = folio;
+		ap->descs[ap->num_folios].offset = folio_offset;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
 
@@ -1187,11 +1192,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		pos += tmp;
 		num -= tmp;
 		offset += tmp;
-		if (offset == PAGE_SIZE)
+		if (offset == folio_size(folio))
 			offset = 0;
 
-		/* If we copied full page, mark it uptodate */
-		if (tmp == PAGE_SIZE)
+		/* If we copied full folio, mark it uptodate */
+		if (tmp == folio_size(folio))
 			folio_mark_uptodate(folio);
 
 		if (folio_test_uptodate(folio)) {
-- 
2.47.1


