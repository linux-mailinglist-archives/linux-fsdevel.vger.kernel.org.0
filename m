Return-Path: <linux-fsdevel+bounces-57731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33FB24D43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B41663CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFB21ABD7;
	Wed, 13 Aug 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehYLU645"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EB1FC7CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098424; cv=none; b=ZCpv61oci8bb547iyvvuOY/jjNUQ4pQZNsc7Ikl8Pto3eNXrbBfOGnK6FLJCCRqqt/pX+Gpn01abUnyzMZvmirghdnIgcjH6REztNQ9FdcGP++RHRt2YGIo2tUi4kSMjWf6cpf24Wrux2BaFZGJ2xGHrpQ2GO77MVc0JxBgjDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098424; c=relaxed/simple;
	bh=zelzCXFsoUxUzfvWcdsoKzGEhp3Vd+Zs2nB56ddoPgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/Z1f5YmaHqVgKwBfjdQQT/3uKMspWVQlWK2tot12NMQF2FSTyP2yP/OX+dckvizdzWBfQBRLdirr0PoOOz+IK0s4voPzoNNGgQ6DKnP82nAKlTCnQDcGp70Umdbz01+REloZQGpWWM7tyfjl1bYZhQGVSiiEBY7y7lVVMB7RM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehYLU645; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qs+uvqsTAq7/QLzhBjesvITe8yceIRYOS1EXK24w9kY=;
	b=ehYLU645vPfQMQ0yjaHm68Z2hrH22co2snUYi9Cj0qNdAF2gSVW0hPTE0URAoTJgZJgKHn
	FUNXpzSSBEJGx8gETlNICdCBj2Qo7b6Q+r95M0gzXe/fGeZio5MtF8nlvrpxjQMdndJiv/
	RTQR5RvzZe7KfZVttvdJzricS4bi+Pk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-vWeL7jnLMNaAC0WXX2IUNQ-1; Wed, 13 Aug 2025 11:20:20 -0400
X-MC-Unique: vWeL7jnLMNaAC0WXX2IUNQ-1
X-Mimecast-MFC-AGG-ID: vWeL7jnLMNaAC0WXX2IUNQ_1755098420
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d8020b7bso35016575e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 08:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098419; x=1755703219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs+uvqsTAq7/QLzhBjesvITe8yceIRYOS1EXK24w9kY=;
        b=vQfx1sJU3we7mvOjFlheM4gzHHKvxf1Yhi4VegXRFcY2ONY+axh2IbgvZuBdLK8N6y
         54J/5E/oMXCdRk1peex7UTq5Zs9OKTOs9foreoQYEwQ4v5tkDwHQuF42PLIm4thS8IVy
         5UppgXS922pSGYf65GvN/Sk3szJ9MvZh6BYsynn3Mzm04sLUOI4AVLun5sCj02+6sCX9
         jFlZ2jWs897ewZRVZP/ynMQ8NbPDC43PVdL8lZFjOqfCS2+MrlHwPptIhiQFa3OxT6Oz
         arCyxI0ERLD2C6+1l6PhiKafLgLbriq8kVPcQ8w3vOjg5JoqQa3JyZ0lkVNyxSAxB6HF
         R++A==
X-Gm-Message-State: AOJu0YyizSvwHKUQdem5FFQQEex8fszalR4oZAU06gjALuSaecwRKt/M
	981OSXTCcKFa8e6jEzP5a3TKMn4YNvZZa8vEnqMcG49ozUnGSuYj5uvFeA4qp+rfsXyzAb+4xM3
	SkBluxnhcgRuW1ae1pXIBf8fs4ZAkmiCJnWJaF41RAh35bXg1jSn3DDvB29VTs/BNuyxkVX70Qn
	aHEkeiZCbjVEhnk4AhofbVEV4fx4ACQ+aaagtdCDJAC5plWLpnCTYLww==
X-Gm-Gg: ASbGnctogUu/mH5pr+W65YJhyM7Y/x5AleNdmT8fP0vcv4MAfV+ihJ/620g/Kfi9DLh
	MqqctHJjjQGNk8zH4zS1kledcGplmg1dgKnCqWTyFIhx/Hg1OjaNd596L/ZOnPglT54L416Ke66
	sIzjQmGsiXNsFW2dBBzTFYeJk47rgh/wLEvknRgGgRmxZgSLr4wqPu+hpd4hnUJ64Vz1VI2i545
	lY02JtaYtcsB7MyGSHbBmuKVf9zkStCrUSsnTl4HwL4UQsbRofSrzwE0zlE9BQgzLxLM0t9I8oo
	CZ8W9wc0XsVqkJmg2jXJcrThSX/8QHSt9a/zofDI39iMS8aO/gRTiW3AN6tPjjfV7EkCYWUWaXf
	mzlfN1lZxwJS3
X-Received: by 2002:a05:600c:4587:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45a16593b94mr36973545e9.0.1755098419227;
        Wed, 13 Aug 2025 08:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYxQu8lTH95YgRx2lulP9ABmic2/Mc6Q2gPRc6slnYatyLjXPS6dzwX3uETbvh2aVpOD1Dg==
X-Received: by 2002:a05:600c:4587:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45a16593b94mr36973125e9.0.1755098418717;
        Wed, 13 Aug 2025 08:20:18 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-46.pool.digikabel.hu. [94.21.53.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48584381f8f.68.2025.08.13.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:20:18 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	Florian Weimer <fweimer@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] fuse: prevent overflow in copy_file_range return value
Date: Wed, 13 Aug 2025 17:20:12 +0200
Message-ID: <20250813152014.100048-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813152014.100048-1-mszeredi@redhat.com>
References: <20250813152014.100048-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FUSE protocol uses struct fuse_write_out to convey the return value of
copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
interface supports a 64-bit size copies.

Currently the number of bytes copied is silently truncated to 32-bit, which
may result in poor performance or even failure to copy in case of
truncation to zero.

Reported-by: Florian Weimer <fweimer@redhat.com>
Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
Fixes: 88bc7d5097a1 ("fuse: add support for copy_file_range()")
Cc: <stable@vger.kernel.org> # v4.20
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 45207a6bb85f..4adcf09d4b01 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2960,7 +2960,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		.nodeid_out = ff_out->nodeid,
 		.fh_out = ff_out->fh,
 		.off_out = pos_out,
-		.len = len,
+		.len = min_t(size_t, len, UINT_MAX & PAGE_MASK),
 		.flags = flags
 	};
 	struct fuse_write_out outarg;
-- 
2.49.0


