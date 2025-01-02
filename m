Return-Path: <linux-fsdevel+bounces-38341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB279FFF40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F8F163E7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9161B3959;
	Thu,  2 Jan 2025 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hofMHmpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89F86250;
	Thu,  2 Jan 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844764; cv=none; b=YOvfDTt2UnT668vh2DXAA/7swPqmciDFEjl/fVRFy+nsLd+bw/rKRPEFPSa21lhMjy8qujl4THnXZ+wPzN5G45tPg73iM1zF7Lumybc+l4u8vA6gLCTXxEIDYyegqJ/L3DcbHfUQDjRr6p9mGTbK24gryrtJRxaNyIL9o9iTV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844764; c=relaxed/simple;
	bh=ftl/2BMkCA5Lyzg2ahZXP9K48mcjBKP/HhO/xGp9WYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvtE+Tx813R0DwgrpUFKwzFevNDZbWetPmUahTEROV2c8A4t+hHcvFavbVzMdLK1HCOq3CkQZNdC0ftZMlMLcNwgsYCP/CxXf6IaQsQurCdfgu87XL4albKhMgr8QIlP89PeekhgiiZOCJfxRr1Vb7pY3FpeXBv+ffAJ1SXpQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hofMHmpd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216395e151bso116063155ad.0;
        Thu, 02 Jan 2025 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735844762; x=1736449562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxuW0cgSEfBWMH2lV5SJSiaf6CcTpbxwJndRWFEJY/4=;
        b=hofMHmpdYbCgZ+LlW5Eb97V+Ocioyt7fVXwl3wKmY3apiM/ue69KnYAi6MezcgZEtz
         NACXm24z23jTuulqwxT5ayUdWNdxv0RfQ4HfCTciOEXknbKbWqBIkRB6RwwShhqJZxhn
         VDkqCYdg4OSDUOBCCecn6nY012mK2nuuBsR8Hdq+K/JhTIolAOLSiLgEXxiubO4FGhJA
         LdqRPpPuykjSAirtZVZzM5TSFeh+hdo0VKfvmm3tvy4kVeTLk2kQ4i4E4x4GVTMrtFqd
         CzLAlf3GFixA3zi4WX2RWQTaRkG+j1xcsJt2stmFhi6BVxynxtnPiSiTSlYGfJ10+Rop
         z1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735844762; x=1736449562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxuW0cgSEfBWMH2lV5SJSiaf6CcTpbxwJndRWFEJY/4=;
        b=SgPzlFEQgnpwyumFawaipx3lUBVk4xwZfGVr7o0wCZupwyIJBq/1AQgBGG6XJcvJMz
         pmgmm50/5blgSYaQwkCrQDmOe/0ToujWt+RMxCQCvNGRaqXhewut3oCXF0ctQj8b1qnF
         AcoLMO66UpN+wkg8+F49foC5grCWU93nbjUEDC96QB2562whXx28g7I7svYM01uwN1En
         VwcenuQB/dnBpNZZOkrl8VLBOOJR2TeGYxagswTCkXJd2LR0ey35YrbU1pNm+ogZ2HeB
         yQAu1tJD9WlxQC5bJNkw/4cQLGAVuX+HVWFS6ezRMZ8Wyh+TpHzTdz9GlbIF8H9q8MyW
         uelA==
X-Forwarded-Encrypted: i=1; AJvYcCVWXJ7RwRbwmagUjUfnFf7Hk9TaNfx3gRWi/COfOFyaWnwd2bkdhPjL6K7fKFvO9HMTXiyaYEobjEmimZ27@vger.kernel.org, AJvYcCXA2qVvceKzxez+l2CbY8ERik7EdW6ce/J+0KPi17bQtlS4sv99c8CRcUQId7G+iN7/fPWiV7SHrXx7oYPR@vger.kernel.org, AJvYcCXOuUKY416sKdBEPlrM4/I59d7+jmghURn7XC/clgY2+EIxKh95/lPvt+XnjdhoqqvhCV7VxuQydgN2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9dmDI4q+tl3XmI8a44QMl6DiIwpWPMyAmrCPN9RuOuLgpg+0
	lcNQ3TXzOCoRxm0j+TWlWEWexnRrAMlHHnoRO+sA0owRFj+2ElAI
X-Gm-Gg: ASbGncsAi56S0i5/J5PjU/qcJta5T5SimNXYnqgJltyGefobjk6JplmmMZ/kPUZcEqo
	URkCYWjfDflfgB3/2ClaavP+SF/mq+Y6rGHCIkVsfm26Ee3+oUiXWGZAMym+HVQk1ep47q1wF3G
	LtDkp+GoSq3IWKdyKjhuaPdl21DWdhzr1F2NlplempgayN6kAGRqZBPJ3vHryXamLl4n0jhWzAr
	bEhepaN4EJJnQjKT256zuyoodjIjsEV9V/eHX0XQT6saaJ2Yk1Wu87fmrveNHuidfXyQkkC6t24
	T6e1o9KCzKicpkXAkWUAxJI=
X-Google-Smtp-Source: AGHT+IFgSN9UePaqEwcS7Xh91XACZd/nc8+4GtjpV3DisyOIYhd1B+z+3CyATnEhABGNEeP3/Knj+g==
X-Received: by 2002:a17:903:2ac3:b0:215:9eac:1857 with SMTP id d9443c01a7336-219da5b9caemr676513085ad.5.1735844762049;
        Thu, 02 Jan 2025 11:06:02 -0800 (PST)
Received: from perforce2 (75-4-202-173.lightspeed.sntcca.sbcglobal.net. [75.4.202.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde5bsm231464325ad.116.2025.01.02.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 11:06:01 -0800 (PST)
Received: by perforce2 (sSMTP sendmail emulation); Thu, 02 Jan 2025 11:05:59 -0800
From: Marco Nelissen <marco.nelissen@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: Marco Nelissen <marco.nelissen@gmail.com>
Subject: [PATCH] filemap: avoid truncating 64-bit offset to 32 bits
Date: Thu,  2 Jan 2025 11:04:11 -0800
Message-ID: <20250102190540.1356838-1-marco.nelissen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

on 32-bit kernels, folio_seek_hole_data() was inadvertently truncating a
64-bit value to 32 bits, leading to a possible infinite loop when writing
to an xfs filesystem.

Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f61cf51c2238..f5c93683dbcf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3005,7 +3005,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 		if (ops->is_partially_uptodate(folio, offset, bsz) ==
 							seek_data)
 			break;
-		start = (start + bsz) & ~(bsz - 1);
+		start = (start + bsz) & ~((u64)bsz - 1);
 		offset += bsz;
 	} while (offset < folio_size(folio));
 unlock:
-- 
2.39.5


