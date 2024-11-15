Return-Path: <linux-fsdevel+bounces-34993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4E9CFAEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 00:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A31B373F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36B1922F2;
	Fri, 15 Nov 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr7yu3oM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907018A924
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710818; cv=none; b=NA8qGn3cloMihQuU0LZLGX4Wd/VdUfXo6H1LiipOQFYlRpU1WZsP/ydovDALxzg7wfqjZisKdR34iIkNgIln89xU/OBvxNEq3yU8gz0uJFruzGQhu5b1DEYydF4lmhKpjv5W6rsZv2NuuE5+XbYitht6iNoz8dQEX8jSqRvlDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710818; c=relaxed/simple;
	bh=NiVYfMxiq/4CbrHhh8ZxoChEDx9tW/kNBNx4aRfyXAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJVz0nMcwiPB4dhQ4rxMDvA0Iu0HzchV42AyVlDIaGCcDGylYz4M+VzVKNRTv1zwZN8d1K8fQcAl3o0ZkaWe/Ruvfya5Co719tu5DcTByW6vwSk/oiw4XwQOW9ytM3TF/u4kG+oLLnva7d7yhH4YClzwyodgcfAClmn7GWwSUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr7yu3oM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e9ba45d67fso24794377b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731710815; x=1732315615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaJOCXiq+oAY6E09D60BMxslFUVmtN8uELYvwrLg+b4=;
        b=Cr7yu3oM41NU+H/4f2zCr1YhhnC546C7tvDxeY5oe+GGz+F7j5g23TIScIBOj0KTb1
         k2gU0+6TPMxUo8hidTWNeqwCgjHRCA4Vk3lMZTpSnrdrrZ1LhzxbxAJyzJM+aQQ82rHh
         EAzUlglt8R4XDDNRWON+yELWMLETQBKBcUf9o36COU4qIIF0aJV/xoI00D18V47pTYVT
         hWswn8RCM2mo5BoxKBu7N10iWbrJfbljH8vSO81LWZpG6+4Nr4sRlE2mfGVP5auI7O/D
         HDNI1lrxLvQMcuD1ITyvNEaClO1WjM2gweLJ/2GC/i/Pe2s/hm/W8J2KOMo+QAU/nj8L
         9k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731710815; x=1732315615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaJOCXiq+oAY6E09D60BMxslFUVmtN8uELYvwrLg+b4=;
        b=fALYqk/JWE0PFOjzMOHBokD/fBxMwwjIYRqITZOo7bEr5en4H7CpKGiM7pqBVm8kUc
         m7zopXotj0ej1eKSyQEVBmbI6Zm7oXFUZXdcq1YPHumP3GaukcGFvDz719gD5Fyoir3A
         DcHx1CeA8msh3bBCsivphugcglVGq8NLGP2IKjtGEEmIZwFpoq7vCIhaGwoUyJ3ko9Y8
         8ZtjZ50GpQnWPpt1ZL1LSyfaQcNpVDaFQhyjgJG5MFyrkmd7suY2dOzcKE8AaJX01wvT
         8FN/uiBdEASHCHEHIFIjEbjzZi+8O+qZTw+vmdeCeRz4nV4YVPDZ7RCF14E4s1h2t+ZS
         rxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5XOH9BFt+MbnJ6Z25ZxHgcJI9Izc+iIbULOhD1bvf3vUvJ1cBngYrnCY/k+p7MWRzfTh66DRiOFLQftIH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49ylCMZC3kYUQSGdnvXJHEcbiLFBWxccFwzDAe8gbc6SbiVBh
	x31Hdpmo3rVy1ldA/HRnQacnL7Aq4fbSmRK5Ns7Wz3UIvdHUtPDl
X-Google-Smtp-Source: AGHT+IFmiXgnWZZs1gqt0JF4hZXzFNRdwrn1XSh3VQKDL/elFzc3Ebo+JLJ62nqDeTWVLJwJ3hwfzw==
X-Received: by 2002:a05:690c:9682:b0:6db:db51:c02d with SMTP id 00721157ae682-6ee55c53b57mr48257857b3.25.1731710815490;
        Fri, 15 Nov 2024 14:46:55 -0800 (PST)
Received: from localhost (fwdproxy-nha-011.fbsv.net. [2a03:2880:25ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee712c2c9fsm857617b3.54.2024.11.15.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:46:55 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v5 1/5] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
Date: Fri, 15 Nov 2024 14:44:55 -0800
Message-ID: <20241115224459.427610-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115224459.427610-1-joannelkoong@gmail.com>
References: <20241115224459.427610-1-joannelkoong@gmail.com>
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


