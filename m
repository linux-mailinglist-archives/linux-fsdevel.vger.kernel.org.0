Return-Path: <linux-fsdevel+bounces-45788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FE8A7C323
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD571640B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F121B9D8;
	Fri,  4 Apr 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/Z06cZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403420E33E
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790495; cv=none; b=QyokNck1cdrEa6IIpHwG4VgrRY1Ql5nbJcJWL0kffiLacTJT/N2IXWl9es7UpW90Ti082AbLq/74u6V5DQ8bfw7bh1MxyoIwkjrwmXfVw9DwhTTkFHxOHfu0L6cnzQ13bi8P3Pd+7QfXRy0/URkg00q71HsecBD7w05LTO0zPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790495; c=relaxed/simple;
	bh=/UNkyJBVkBHaYMkjltKdmVgH3/7G53OsFpnwdChW2JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMigKC3osYFTt2L/XvtAlxQSFfYCBoqvXB7vhVjV5I2wuQ+fzBO89N6MdUlJj+zAgVpu1R9tK9Nli1mQjzH6zYljm45246YPt/PRvXsxPTbci7B27I10u6XFEKMmL2+nRwecMNzN667O37YB7xcX1BcTpSDtBoGff9E9gyl18i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/Z06cZO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22622ddcc35so31412875ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743790493; x=1744395293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl8QoDkWZfm8DTTKNPo/wCbrE6y7cAAPOUh+ANXI66Q=;
        b=C/Z06cZOcPNtMKpDPng1Rv1SQZZWS5jFSxsFjHe7IYdGbj9rCINqcs+9mjh7NBm6Pd
         +MNOfYC27WNh8eCUdnpC2OLTHQABpmd2GvboXZJCf6DC62iy2U0IizNg8Lw1bODobL5w
         T/thlvb2EupcoJBCO+AJVZ57I9rdeZ3AnnqhHbIbaxMIp93kAbYIOJlkanBgwI2cUcpk
         j3KVIS0ODo70Oqzb/WLhKENPdDR6Vinlhg9JJ6c+pmj5uuUm3k/xokc2s72lHYvsxIv/
         nBY3ubiSBWDIvpBsuoUd/xubrw7nzd8IXMuyQamWIYSaGbpkfoixEZYuB8VDKqXUMEtx
         AfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790493; x=1744395293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl8QoDkWZfm8DTTKNPo/wCbrE6y7cAAPOUh+ANXI66Q=;
        b=wzjb9XiNJq27ZDhcR5yWNntvhMYMSHQZEHYx6Fjb8bWyLMPwM/CEWCHiSvMzw8kcC7
         ZDsRp6SpVO4H7cFONmBso6w7mwjzNsSA5/e+bbUdEW+tG+jRd0jsQAa9qJ7TvhufyjWD
         3GZmpD9r6LdTsd6uQxE5eHVmmTHWPs578iVdJ7DL41aRjXGpaaFsIU4xo1umjdXfBsNt
         i051T83+1B6F3vzpFGtNLrrSpJrRt3YXf1rTyZjhf+dp8dMT9Bb8lUck2ZU5lF0TiSR7
         +W0DxPJIa5XJAWuBeTXofJ0Vm2CLmsVM1jBpgtN0Zd/wX1V3flxwkHa+9eZqAPsHCU0E
         J1NA==
X-Forwarded-Encrypted: i=1; AJvYcCWpCJtyYg0qiGeME7YKSR2CKpG0iKuxsQVCqiPs3Rp18zDOeBduXc80FUrRTYvXojeAQu5MfS69TAIqg+La@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBagcuk1zM7hKdoFeB4Qsb8i7F2S5iKFk7Hfpsg59k5bGki7l
	WgbRGLFHlGSf7dzW5mFQOfReoailvGcgeBFg+DHPurSWEvEgV5W0
X-Gm-Gg: ASbGncsAH/pjreSG+YEqpTytFKwdEvj254pXSx7MdgpRMj3O6GPnjFGAkDBZctIHI4d
	yvOAiFeCxWc/MMuALbp4bwrxdUI9txDfyDGX879719r9tnAqo03U339QjH/Sn9C0RO/s8aFQDW5
	7taV71NcZQXzgyhaRzRxoIgxhhlW+zULGE57GXxxKZTdE6TQnFdKL23DRFMQB5LvxQ8eg+Qi9qu
	L4HYYmmYt9k57hnRyCEFAeFP3WUj+lX0bEnToAXgzOMHpZ1Hk4aivmpEkIbEmEL7CvPf9T2E29F
	88AHdXkZxnE1CqALs9M3yzP8IrGa94cNQ+JXFfk=
X-Google-Smtp-Source: AGHT+IFQWuRUYtqQ9PYQeKB91kmnnsp+MBvvTBYSFVfsYjy2EJYrTFwForkG0Fjr8XsdVucFtVIK+w==
X-Received: by 2002:a17:902:ce84:b0:223:397f:46be with SMTP id d9443c01a7336-22a955881b8mr5396015ad.47.1743790493629;
        Fri, 04 Apr 2025 11:14:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e173sm35372415ad.192.2025.04.04.11.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:14:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	david@redhat.com,
	bernd.schubert@fastmail.fm,
	ziy@nvidia.com,
	jlayton@kernel.org,
	kernel-team@meta.com,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v7 1/3] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
Date: Fri,  4 Apr 2025 11:14:41 -0700
Message-ID: <20250404181443.1363005-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404181443.1363005-1-joannelkoong@gmail.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new mapping flag AS_WRITEBACK_INDETERMINATE which filesystems may
set to indicate that writing back to disk may take an indeterminate
amount of time to complete. Extra caution should be taken when waiting
on writeback for folios belonging to mappings where this flag is set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 26baa78f1ca7..762575f1d195 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
+	AS_WRITEBACK_INDETERMINATE = 9, /* Use caution when waiting on writeback */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
+static inline void mapping_set_writeback_indeterminate(struct address_space *mapping)
+{
+	set_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
+}
+
+static inline bool mapping_writeback_indeterminate(struct address_space *mapping)
+{
+	return test_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
-- 
2.47.1


