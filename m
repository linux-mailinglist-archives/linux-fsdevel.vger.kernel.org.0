Return-Path: <linux-fsdevel+bounces-35617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAD39D664B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4B1282168
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195A1A4F22;
	Fri, 22 Nov 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSeXvtab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039D18BC0B
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317867; cv=none; b=dYii1V56A0qbt6usFk6kqhciN6CB0kN+/pLL6uh/7HfMGakmO6Mzw9kSpLsp3O8FVbSr7U9vIupJAcmC9ML1FDfcjp+M3sQzM2tYXt58CQUf2mRBwKL/uOi87XFhhpP60Ee3+s5bSiqAjnMvrt0P0ff3t6WNsZKJlqKHWvzFVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317867; c=relaxed/simple;
	bh=eQgH7T/CLuXVM79Gn7+HepWbp7aZ67dVdNuYoVQHzco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWFssb4xfTAm6DVubzHVR37V1hYKKwDPwRMAve8E+Ru52UMpt38KcGCyYL9C4t64hpfDpnRmc9ZMysC0B+Wqrxr/IFIAay052B5BErlc3or+sGtIeCNQL3KUUPoAcTwYLAWA0EZtuUfb+9BnFDOzZTWVJP8xyIG1qi+o7D8qEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSeXvtab; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ee676b4e20so28807917b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732317865; x=1732922665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5u3R1yw+kui0tyYMObpxZCZs3WeGMww1fJq5IP8R1c=;
        b=NSeXvtabdi9XiPLzSd8lzSmVTXS1hkRbaoUJRimPhY1kByX7dwcNeQIveGMSwiAoSH
         WBeJGfH22JHnSbmGvxlP04w0GpjcD8SbYiIX5DcQICptWP0JbQG84eQ75J9Y0xI/S8W0
         fGUO9BuZ2icsQDQ2/Jqiz4gmZ5JQ8Lxuoi7Zl1T2yaBcHFlT6ReFVMVSg41hBM7JDj9K
         CT83l2Gd8U+6WgbdZ68W7Ej+niLw74rXTlephnfCOk5Rxikrx7OltwArmvhbtcr1wGLk
         0doz6DvK891DS2qTU4mIOK45zdZBuX5ygfrDkQ+MWTYdWnk+UkPhs05W8o8AWa2feEKV
         ZCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732317865; x=1732922665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5u3R1yw+kui0tyYMObpxZCZs3WeGMww1fJq5IP8R1c=;
        b=slhoAeWG2KewxPnAIKsrJccWQp9LvKvEGCpGJAf5qItqPrKhj4HEeJsvohtGY2aRqJ
         GADM7hT6mIeXlvTol80SLPuk0yOMoXDU5yEihqlqmapYkpuVAA09UBpDYMBiRBw6CG4N
         IqIqYL6IiEPxwaSPkz1nwXoFxfkd/86dQVjyShQDgyumvIiiBg9WIFsUAJtTX2GAW6bU
         cqcox45t3OAr3LaAUDofOIny3ksdo72KDgwG8oLy8+rXpNmM41dOqlR1WVvKe8OG5IEE
         MH7ux1a9nhJo92GYLM/Kdi+cUQikNrpeYEgQwkmVrXTVp4Xom6ort7lMrXJirmrXiTnx
         MpLA==
X-Forwarded-Encrypted: i=1; AJvYcCVcuW+tNjgvu1xIyUV1FQdRH8yNcHEEMS/1DiY4/qHII1P4GkHZ3F1hWOkXxuJ3HaKhdF8XPMFfSWWVANxo@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbyJSXEpfWEmtgrhF9wnhHufBSrraVr0Kel0BvKv5ziAogkQj
	LSEDG8bQ0mlcIOJBDsFn3OJRNOF9iOMEBakQhPuv7Hb4CTskr+Pt
X-Gm-Gg: ASbGncs8CrQ3ErxCgnZFL/TStFQhAlmn6YSJZj1W4wbilsQKpulass131122+Rr0odT
	yLcebwUtpmxYNjO/057vbN+d5jd1LfDAqHVOUbhjATmsKvyEZg+EbDr5H6l5ZSLQSM3fqbEiBU/
	NRRUrZSRru2cY6sgElVqd2MfuGzyTwW6Ceh/9no14cptWDp2+XzFHc2HETyy20VhQ/xiJ+vDZTa
	QqZdmUfe5AODeqRwPw61hFYdUUbhBbj3PFKOl6IQll+7EWFFLXyAEp/Q20wP/jOPcq5XhgiEvgR
	KxojoI4/
X-Google-Smtp-Source: AGHT+IE31ZflB95lghWnoApBp5JoBxyoMgfn9RvO479pqfokI54v3mfaN5/ufMEOG8SbV3Cy8wagiw==
X-Received: by 2002:a05:690c:6e09:b0:6ee:664e:8c03 with SMTP id 00721157ae682-6eee08b90bcmr51886217b3.19.1732317865368;
        Fri, 22 Nov 2024 15:24:25 -0800 (PST)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe2c142sm6918817b3.48.2024.11.22.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 15:24:25 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v6 1/5] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
Date: Fri, 22 Nov 2024 15:23:55 -0800
Message-ID: <20241122232359.429647-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241122232359.429647-1-joannelkoong@gmail.com>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
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
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..fcf7d4dd7e2b 100644
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
2.43.5


