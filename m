Return-Path: <linux-fsdevel+bounces-33949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89CC9C0EBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E62C1F28084
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0718FDBC;
	Thu,  7 Nov 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcNRjv1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A77194AD6
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007046; cv=none; b=FzyYYrMV99R4QTKhUxqAxLpuGiTK5vqCdSiR2Gw5Qb/Uvz9mTQLHiAJuXFYltNTq5T3NUguO83e/MpMnMvtrKIg992EGX8aMkZu4VcbVRTkEpgZQ1phhRZPV9aAFj5iJcF9gCSh/Q2tkm/Q0ZL9U9o+KOcEPYpWBIRWfNq6JUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007046; c=relaxed/simple;
	bh=pARaSFmLsoPSKNsrfH3+9P8D7C7sCUc7TrWkYNvCKqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAdC3jd9TdHywlncH7vSh5TGy9zDQ7CFxjDf1GNgWZaTZi9Sg7st735hjMZNq6ZwxvNCBmwn4rUz3T4VJ1i/WOOE/LVW92wjUPJLu+x+227lT7M0twgJP8KXWiD+fwz8qV7WI3oFlDl7uJ2nR7ZRjPzjCb32ydPBDOEsoMK+wHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcNRjv1q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3cdbc25a0so14516787b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007043; x=1731611843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikpYM/WWgMZzee5LK9ccNIkwppCcSDNp4r5PwHAnOS0=;
        b=bcNRjv1qO6xBmMigO2iAQ8oZDrvlIbsdokMCnm7Va91oQYPHfMZ7EYdPaM45m72zrB
         UGfHLXwfU1v2ePuZqBjSqctetnO+ma6sxKXuMnvmHoLOfmFJiumEIbQzHDAtTPpbpix7
         YeMItXEJgNQtyI5c+OdXlTXFV0mNMARv/Pr9LhYfLCblXfEvIQiyLlNLIMGxJIwiBQOj
         euuKvOOs5l/ezR2Ln+KFXfz/P2KUNeOeQkTkuQ/rZogdIU29ob9+dUvDLeBNMPEqbTen
         zOY6fE/ROR3z9pvdhk3fLfd+PEzVBfI1oICBV/UN9yG2RSkE3Hx2s+AEqTd/Bv35R9nK
         8now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007043; x=1731611843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikpYM/WWgMZzee5LK9ccNIkwppCcSDNp4r5PwHAnOS0=;
        b=Y4Bh+McSWazivRAhUkZTl/dow9LYSRIDsF7TdQALsMC9pSw7fPcaDyLzJB2WivFmBy
         jPwvzjeFfxtJD2aatuFtaDoejMIr4Q/fKDF0un2yZRPflHHhmMAB80pyI2M+s4/YYJmd
         hF5TqnKMMA1nVqKoWZHyNzVphUjzT73rgsR9ZfrRyVGjlSOyQKPaO8BBO/TGFRPIaJ+H
         KIfSZzBEl/yB8uV2oRMUYM+pwc5dk7ajTUSkKPWq+vi/09s++SH8GsaaeL3TkvtI38QW
         y2pLn3InqZfiIqs4XxovyTeVj/RYTCdgBD2hbXg0FCs98sLCgyHu+cNrtXqnWJoMugzr
         mfJg==
X-Forwarded-Encrypted: i=1; AJvYcCW3wsZqIpGmz6tYsS+TWfqpNgTCkaeRmREOua7VMasr+y50njqshooEiiFdgZXJclsZEl9QCR2jZUxUDiOx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3J2I8B0RpiMjATXZtkDlnMwc0BoBZ0f48z83rIIV/3/tSwHhp
	HWRsHE/1FSkrxSgv9XPAVqjj+uWvPA03BN+jBIEH0v6qZe5IM74e
X-Google-Smtp-Source: AGHT+IFHssVnIsuRtflrMUnmonDOpNMTsU28VnY3e7vVVJcpvOBurpk0sydP4Cx4Ik3eP3kEc+Ijgw==
X-Received: by 2002:a05:690c:67c8:b0:6e3:323f:d8fb with SMTP id 00721157ae682-6eaddd994d5mr929977b3.14.1731007043403;
        Thu, 07 Nov 2024 11:17:23 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8efa7esm4148957b3.40.2024.11.07.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:23 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 1/6] mm: add AS_WRITEBACK_MAY_BLOCK mapping flag
Date: Thu,  7 Nov 2024 11:16:12 -0800
Message-ID: <20241107191618.2011146-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107191618.2011146-1-joannelkoong@gmail.com>
References: <20241107191618.2011146-1-joannelkoong@gmail.com>
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


