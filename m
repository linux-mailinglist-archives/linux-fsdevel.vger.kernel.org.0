Return-Path: <linux-fsdevel+bounces-33982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AE9C12CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B5B226A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B31F5832;
	Thu,  7 Nov 2024 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWJqld7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853181F4273
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023792; cv=none; b=LikpdRl2eTlJFuN+dZgC2sApZVxw5/5r71nMdFDPQz7tDb5Tr8C+PQP1K+p84phdx//q/t76NV1EYqoK6CzCInHZbFGd32ME0H6S2Oqilev0rLSM3MYNSqrx9+GsFOeebt/FczcXrJh71pGRvWqxfHRJiRp21+VWrdYKyQoMg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023792; c=relaxed/simple;
	bh=pARaSFmLsoPSKNsrfH3+9P8D7C7sCUc7TrWkYNvCKqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPGL+DnMJCYEkqD9BEjTFGGjZqwtEfbYGhz34ojAHLbSwCx9aECYxhB4hTax+ZqRZ155RQCxP1tt6fptqa2394cNSAkFjPYQrlZ159h2IWmv3QMhfe371/RJJOPnSxmXczMvgQVwzHwoSophjnX7EU8u0s/Mt1Du60FeOmhvjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWJqld7S; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea339a41f1so13628317b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 15:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731023789; x=1731628589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikpYM/WWgMZzee5LK9ccNIkwppCcSDNp4r5PwHAnOS0=;
        b=kWJqld7StX4X+ko86QQDSXbUCh7phjDA9KqrFmG0uCQtsQk4LldybeuSA8UYIMt4Up
         +dAUcEBvsQddOs4/rD/2RUbECpxLWi73ra+tBFXB6P8MO8w7v+Km5J6wC4pENnGmHG0O
         Xseiyzb8IROfaw2B6r5TNT7avd2JLuVv2ha0Tdmo6Gia9i6eQL9iiDKK9HCo+jS0PwO4
         CoY/ozYrWAmHBYi99mgya7I0my7OV+cIvtI9biaFz2oPuCAgNkv6exRaszoemUa0meDt
         UQVz8sdTyuqFct0EhUVtaClOPngEsgApyk99fG/W+C7GVSisCku/iE+MNbLwll298MRP
         M3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023789; x=1731628589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikpYM/WWgMZzee5LK9ccNIkwppCcSDNp4r5PwHAnOS0=;
        b=eeFtshJq2aWN/CCKEILmVgG5SYu6QGwRIO7eflqGFlpQ/kyJEv8U9EbrkKGhbBk4zf
         up6GARPbnFHQsfsUkWaCDEYa5L4oWEOxXeRL5T0Zr+NAz74o9eOt04fSe4A9pU6UhlMH
         nv31P5j0tDty9FB2CEoA55PccjOpoCy6LM5gSry0vpdbEx35o0EYSlOl1ysn5++H5WEb
         g/qDKoCTuM4piFu4zp6briGCvoQM3I/tH7fptNkC5szJt5PqzpBSMVMs2muf53/s3AW/
         lAU5Z4fMKTbfzJrrARKUcgam8o/Gvndm1TtCl3urWPxtIPGkaMVqY9JQu6zFVG43gz5P
         tIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVmURAIRrKGUPPD/eYB9+IGlz8Z2UqQy5jIjkh/aO9/TWiu1ct+PyIHewcEzTP89clJjLGCKvEdiwa4utu@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMOrqtfc0wqFq3YnzCBa3msMgPzWgo15NawG5gL0fbVyO4og2
	aAlp8MXYYfOOf438U13Gl7EPOlqqLRZKhqvlwTNoU9FT2XTP0AI0
X-Google-Smtp-Source: AGHT+IE1RwTd0+7DYupIY1PYmqJOKwOZCXsEe05QepgoB+3JP5jig5elKW2UZmO9v9UgGqA6cNuR5A==
X-Received: by 2002:a05:690c:6886:b0:6e5:b6a7:1640 with SMTP id 00721157ae682-6eaddfa967fmr10156897b3.42.1731023789401;
        Thu, 07 Nov 2024 15:56:29 -0800 (PST)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7b234sm5007697b3.98.2024.11.07.15.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:56:29 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v4 1/6] mm: add AS_WRITEBACK_MAY_BLOCK mapping flag
Date: Thu,  7 Nov 2024 15:56:09 -0800
Message-ID: <20241107235614.3637221-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107235614.3637221-1-joannelkoong@gmail.com>
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new mapping flag AS_WRITEBACK_MAY_BLOCK which filesystems may set
to indicate that writeback operations may block or take an indeterminate
amount of time to complete. Extra caution should be taken when waiting
on writeback for folios belonging to mappings where this flag is set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..eb5a7837e142 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
+	AS_WRITEBACK_MAY_BLOCK = 9, /* Use caution when waiting on writeback */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
+static inline void mapping_set_writeback_may_block(struct address_space *mapping)
+{
+	set_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
+}
+
+static inline bool mapping_writeback_may_block(struct address_space *mapping)
+{
+	return test_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
-- 
2.43.5


