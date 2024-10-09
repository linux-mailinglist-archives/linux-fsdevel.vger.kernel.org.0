Return-Path: <linux-fsdevel+bounces-31471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C59975BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653721C22FB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0661E1311;
	Wed,  9 Oct 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iugtz3cB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26B1D318A;
	Wed,  9 Oct 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502639; cv=none; b=IrPw/IzSfNTztLbs3URunE5WAUhKtJs/1sTwcveTJgMinlPxvYkbVGOqTlO4S7Epb4uL9Klw5IR86MXj8+tdCZHquovJL5enBQF/2HaWV3IeYSHI51rlHaQA+RqNC2aysri2KSzmSe25u9nAdEGFU6NvNhobSbpUKYqTih2M7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502639; c=relaxed/simple;
	bh=yfnl9wnKLAH43BhXhHaeVnvLuTap4gCs21PcEP8hLag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SH3Gij/eH3FI68k9TRJKhNWuP+QViHlM3GqCyiTmKlaSrdQHgMekQA6vtV0slmScj5Xwnyn/x8mCfvKqdpwNdn1WjnkJyicpxVfsxYxzEM/01hdtf7hYq68pCvaa3M2LFwRnY+UdhajtqX7a0YCzWcgXid7xy6Nx+/vB0dTsg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iugtz3cB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45f05f87ca5so1276741cf.2;
        Wed, 09 Oct 2024 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728502637; x=1729107437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeY+531wVEOKyYvPQ23C+PCHJtQWCZt5wgvONe9jcpo=;
        b=Iugtz3cBYom57L3CULMgc7G6k8fhvS8HzKUqW1xTiZ3Sj69J7wyJQ9EBTX2nsnnUzV
         Q6HlfuBuLDi90X5DLQ+EtrePLQOrXsuCFwIlcx0F7vnekPtO6csPF5emsvZPLga5kd3B
         u9YS9AHWwysOZ5jHFva0OsvbvmRE06tcT1IyhHSSbvfhbXIAWZojHEyJTL7uZEDRZrS+
         oNVeAX6Khq+PQAWxEXU63HD1WGnP2WIPSuD1q7NHo8UVXLwO9QSDJf9aOEZC3bbSKqf9
         EvxnYHbcnO8O0Gtjft7GVoD/7SBBS2Ufe7tDsO2zFWQvtObVwXYQDUviJIWCS7i8O4Z6
         BBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502637; x=1729107437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeY+531wVEOKyYvPQ23C+PCHJtQWCZt5wgvONe9jcpo=;
        b=k0FcmX0W/bxVez9nV+Ygn/LGylKaVoeqW+yCZuF48i1/GOKlBqCRnrdRWgZ4xZkovN
         eBRX+tchee0xn/ohA2Rz12EviGUkzmofZWm2uQpRIoQGXiS9BM8lFdcrqrKuONbR+1zf
         6oHMPO09mm5olk9G1NdLhzXKwJykv+KHrD6cs3rLFqfE8SdplM71SL8vleQkhRKHf9/+
         w2BUj9Ynn7PjFGg3laI//EmHkQDE4qfbaLqC0riouBDSPcU3eOMX2AN+YUkj+apdICM6
         qjLiEMUDkIN3WqXgVa89OEciUbD6M5DJdhdg1/Rcsd/kqP/cmtEejaGTLr4ziAghRbgt
         k5sA==
X-Forwarded-Encrypted: i=1; AJvYcCUFTf08y7gjyXwWaiVZj/y4gvxVElWYnCUv/ETbaumPWScvmIVkJIVilcoGMgWbbR9RZai0WkVIHiA=@vger.kernel.org, AJvYcCUzf7NMV9SV/m85MIWMII6fgOU30hiPdQ21V0k7PVxipxz3EDScpjQ4c6rlwRn93YgNndgbZvUr3u7grqQZ@vger.kernel.org, AJvYcCUzqkyTuGu9Qw9CpEa4Bufjt9Tb/nAD1eJyI48yY+HSXHPpVYSYiTqxRtcCXx4v0efg4cQ66XZ0ESCi+ybFYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZobWBVWTlI+NCkbkFSGQo0e6sv4w8EvOagUmOFgURN0eTTJNw
	AFuSr7a+hzNi1R2jpvVd/Xhv63fuUnodTASQ4ij9hUQwgJwZ6PID
X-Google-Smtp-Source: AGHT+IFmQNidanZEo1iJfH03sW/6YFXSHvGf1HoTnU+Lu30/hGsutXRwEKfvoda+w7Ih7PCIsUqAbQ==
X-Received: by 2002:a05:622a:138b:b0:458:2e21:e422 with SMTP id d75a77b69052e-45fb0e75330mr49739781cf.50.1728502636865;
        Wed, 09 Oct 2024 12:37:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:600::1:6bd1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4603ef1fa00sm2630041cf.36.2024.10.09.12.37.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 12:37:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] XArray: minor documentation improvements
Date: Wed,  9 Oct 2024 15:36:03 -0400
Message-ID: <20241009193602.41797-2-tamird@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Replace "they" with "you" where "you" is used in the preceding
  sentence fragment.
- Use "erasing" rather than "storing `NULL`" when describing multi-index
  entries. Split this into a separate sentence.
- Add "call" parentheses on "xa_store" for consistency and
  linkification.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Documentation/core-api/xarray.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 77e0ece2b1d6..d79d4e4ceff6 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -42,8 +42,8 @@ call xa_tag_pointer() to create an entry with a tag, xa_untag_pointer()
 to turn a tagged entry back into an untagged pointer and xa_pointer_tag()
 to retrieve the tag of an entry.  Tagged pointers use the same bits that
 are used to distinguish value entries from normal pointers, so you must
-decide whether they want to store value entries or tagged pointers in
-any particular XArray.
+decide whether use want to store value entries or tagged pointers in any
+particular XArray.
 
 The XArray does not support storing IS_ERR() pointers as some
 conflict with value entries or internal entries.
@@ -52,8 +52,8 @@ An unusual feature of the XArray is the ability to create entries which
 occupy a range of indices.  Once stored to, looking up any index in
 the range will return the same entry as looking up any other index in
 the range.  Storing to any index will store to all of them.  Multi-index
-entries can be explicitly split into smaller entries, or storing ``NULL``
-into any entry will cause the XArray to forget about the range.
+entries can be explicitly split into smaller entries. Erasing any entry
+will cause the XArray to forget about the range.
 
 Normal API
 ==========
@@ -64,7 +64,7 @@ allocated ones.  A freshly-initialised XArray contains a ``NULL``
 pointer at every index.
 
 You can then set entries using xa_store() and get entries
-using xa_load().  xa_store will overwrite any entry with the
+using xa_load().  xa_store() will overwrite any entry with the
 new entry and return the previous entry stored at that index.  You can
 use xa_erase() instead of calling xa_store() with a
 ``NULL`` entry.  There is no difference between an entry that has never
-- 
2.47.0


