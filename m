Return-Path: <linux-fsdevel+bounces-60378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C62B4641E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E43004E3358
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287829C323;
	Fri,  5 Sep 2025 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="h1Tu8P5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CB2853E0
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102514; cv=none; b=SM9oWRPNDsLc6CQM3x5hA1ks4fXY1nOgnKAw4czjSpWMIPXofG9HDqZzgY1m77TB25BptownPEtaDX3DqhF89DrUvGgCcbIRwHS+uQGpWAfXI/8fCnceYpSMf6vM1M5C0IV8rONuIEPqNft/e+4L/orCKQk4PoHUdgvtaIwgT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102514; c=relaxed/simple;
	bh=1pF+sWstittMgUZAcPl2M5umxp5LdS1zVdcpd3HgX8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPIWdSXxBPy5T3injR3EL6m4TAU9Ih7Jsjy4Ui15IZp4TeCCOMN4mr1thJ0GsrM53KX+Zs69EHPA0rhSvrtANRJKY4le99fUKs844AsPejKLEAqaCHX56MpEP88GL3qvX9eJpelDzBCP8/L/8JC/MQLaKG0SNpxTF1CYRdcio1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=h1Tu8P5R; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcac45so25306517b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102512; x=1757707312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYuX37VRzv81v6MGz63GM7o8pjZX+kMvsG7Qgft9nHE=;
        b=h1Tu8P5RZwudcjMXYDV8V5jwmDiDWcoZXoGoxKI3Rx8IScxHoEKwQepAON5CZ1xO/m
         6Xw7tEVKEjzlXLHnZrwQYg7mKIyLD/CZIvBV8r0ebzB28fWL0/E4ztlzrsTF7Szj3qUz
         ui/WneekqQkhtrvsyEG+XFPJ4mePu18slOI32IK9/s/oD27XqJajxzSRQ7LnxEQJSjnD
         lARQpizGqs2h0MQLVS4CCervsTlrwebIsxfux1Qgs4dDuxCiqmnaBxt2blP8pcfZ+T1W
         GsfIlqCjnwGen5Udd1sUHW/BOyfO49pyVBhJiec8DhAQsaphd9z9cOPlGDzDmr5hZvv2
         PN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102512; x=1757707312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYuX37VRzv81v6MGz63GM7o8pjZX+kMvsG7Qgft9nHE=;
        b=rmRD0ZnJ+YdwbTsoFC4IwSQO2jSxGCbGohPpIQ9s8v12MrQEqQKyHt4W5JgDGXouGp
         z8v4b/Ju66jL9E0U5y3vNIz1PNoyGU0O2PlNyJUltL+4iXraE9Retphrqjo/kmiwYoPo
         xfnCeedwkEtVjEhluSpj3uFBUNFW1UdcSoZNuVYgDKGQ4U3ok4X+gi4a1vBbok6zcrJR
         WMbU8qeREqsjAmrZsytwYnufYsjZHkCqmou/rAJ2jsaE8FI0SxoBLviJMmi/ciKhEfz8
         LrJG0IgNwqcJ8WlKlRduPYl3whIWTzh1o0ZYFVtdIIWsyIX45yNl5c61i8kTXZWF8snC
         IWoA==
X-Forwarded-Encrypted: i=1; AJvYcCXS4VlWlc6Bi2+0R79CzYri1NYaZSckFaU/xsygLZg9zxtltDqY30a/dMSbeMnPEqmUUQ7PCVjTNH69Xjg3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxj2Oleh8isqDqQ4NLb0xInlwx6u9k8FTnp8R4M+8OLOhu6R7a
	2AOmlb/vM03Dwle3J6lhWUxMEhOt9kaNwmlmtxMc62wQvNXiBIyHwQgKk0BwvSIx7Co=
X-Gm-Gg: ASbGncu5oHF/VfsejU8VKtpRSWZAyoXTa0Pxy2suxze06b549qvehIp9bh+/7C4Rt9a
	jdljPV3en34jU58X9iAeFac28mKejApCXrBzpM5XOM1zMcHRQYHkuAL8qUlKnFzgtEhGc/v8HJk
	wN6Ink3v6V5soviRRmFWLoTbuv1TsoU9zKnOW8XPqP1SLSU9xEOggqgrnGR4S+XGTQVYK+A3eRX
	yBgOfCCvwSOJ9VpRIujG9B3F3AA7YfvV9qS9K0Y0p6hOiFe1uApwb865mR+3QkPx9Sguqaw34Kl
	k1pDMc9OvC+0MtU1cfM4yt4PFqK+sFhhDpaBF1Qj3ls5pMLH+KOsuaFajrcFnhpUb/0+Ua+LzoT
	ZeP7Is5lEcQano+rVwnEsaOPx0FIs4uTEnsQ5LpMj
X-Google-Smtp-Source: AGHT+IHoUZBIyHXakAhMyeWSnT5cOdZAA1bvwP2q9VBhGEI2gVFuR9FBP59atz0L61EREE3/dkHLfw==
X-Received: by 2002:a05:690c:9689:b0:720:378:bee0 with SMTP id 00721157ae682-727f2bcbcf6mr1692117b3.11.1757102511487;
        Fri, 05 Sep 2025 13:01:51 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:50 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 04/20] ceph: add comments to declarations in ceph_features.h
Date: Fri,  5 Sep 2025 13:00:52 -0700
Message-ID: <20250905200108.151563-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905200108.151563-1-slava@dubeyko.com>
References: <20250905200108.151563-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

We have a lot of declarations and not enough good
comments on it.

Claude AI generated comments for CephFS metadata structure
declarations in include/linux/ceph/*.h. These comments
have been reviewed, checked, and corrected.

This patch adds detailed explanation of several constants
declarations and macros in include/linux/ceph/ceph_features.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/ceph_features.h | 47 ++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 3a47acd9cc14..31a270b624fe 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -3,37 +3,60 @@
 #define __CEPH_FEATURES
 
 /*
- * Each time we reclaim bits for reuse we need to specify another bit
+ * Feature incarnation metadata: Each time we reclaim bits for reuse we need to specify another bit
  * that, if present, indicates we have the new incarnation of that
  * feature.  Base case is 1 (first use).
  */
+/* Base incarnation - original feature bit definitions */
 #define CEPH_FEATURE_INCARNATION_1 (0ull)
+/* Second incarnation - requires SERVER_JEWEL support */
 #define CEPH_FEATURE_INCARNATION_2 (1ull<<57)              // SERVER_JEWEL
+/* Third incarnation - requires both SERVER_JEWEL and SERVER_MIMIC */
 #define CEPH_FEATURE_INCARNATION_3 ((1ull<<57)|(1ull<<28)) // SERVER_MIMIC
 
+/*
+ * Feature definition macro: Creates both feature bit and feature mask constants.
+ * @bit: The feature bit position (0-63)
+ * @incarnation: Which incarnation of this bit (1, 2, or 3)
+ * @name: Feature name suffix for CEPH_FEATURE_* constants
+ */
 #define DEFINE_CEPH_FEATURE(bit, incarnation, name)			\
 	static const uint64_t __maybe_unused CEPH_FEATURE_##name = (1ULL<<bit);		\
 	static const uint64_t __maybe_unused CEPH_FEATUREMASK_##name =			\
 		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
 
-/* this bit is ignored but still advertised by release *when* */
+/*
+ * Deprecated feature definition macro: This bit is ignored but still advertised by release *when*
+ * @bit: The feature bit position
+ * @incarnation: Which incarnation of this bit
+ * @name: Feature name suffix
+ * @when: Release version when this feature was deprecated
+ */
 #define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when) \
 	static const uint64_t __maybe_unused DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit);	\
 	static const uint64_t __maybe_unused DEPRECATED_CEPH_FEATUREMASK_##name =		\
 		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
 
 /*
- * this bit is ignored by release *unused* and not advertised by
- * release *unadvertised*
+ * Retired feature definition macro: This bit is ignored by release *unused* and not advertised by
+ * release *unadvertised*. The bit can be safely reused in future incarnations.
+ * @bit: The feature bit position
+ * @inc: Which incarnation this bit was retired from
+ * @name: Feature name suffix
+ * @unused: Release version that stopped using this bit
+ * @unadvertised: Release version that stopped advertising this bit
  */
 #define DEFINE_CEPH_FEATURE_RETIRED(bit, inc, name, unused, unadvertised)
 
 
 /*
- * test for a feature.  this test is safer than a typical mask against
- * the bit because it ensures that we have the bit AND the marker for the
- * bit's incarnation.  this must be used in any case where the features
- * bits may include an old meaning of the bit.
+ * Safe feature testing macro: Test for a feature using incarnation-aware comparison.
+ * This test is safer than a typical mask against the bit because it ensures that we have
+ * the bit AND the marker for the bit's incarnation. This must be used in any case where
+ * the features bits may include an old meaning of the bit.
+ * @x: Feature bitmask to test
+ * @name: Feature name suffix to test for
+ * Returns: true if both the feature bit and its incarnation markers are present
  */
 #define CEPH_HAVE_FEATURE(x, name)			\
 	(((x) & (CEPH_FEATUREMASK_##name)) == (CEPH_FEATUREMASK_##name))
@@ -174,7 +197,9 @@ DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facin
 
 
 /*
- * Features supported.
+ * Default supported features bitmask: Defines the complete set of Ceph protocol features
+ * that this kernel client implementation supports. This determines compatibility with
+ * different Ceph server versions and enables various protocol optimizations and capabilities.
  */
 #define CEPH_FEATURES_SUPPORTED_DEFAULT		\
 	(CEPH_FEATURE_NOSRCADDR |		\
@@ -219,6 +244,10 @@ DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facin
 	 CEPH_FEATURE_MSG_ADDR2 |		\
 	 CEPH_FEATURE_CEPHX_V2)
 
+/*
+ * Required features bitmask: Features that must be supported by peers.
+ * Currently set to 0, meaning no features are strictly required.
+ */
 #define CEPH_FEATURES_REQUIRED_DEFAULT	0
 
 #endif
-- 
2.51.0


