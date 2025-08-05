Return-Path: <linux-fsdevel+bounces-56789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B226B1BA19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65CE3AF43E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91625295D86;
	Tue,  5 Aug 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqmX1X/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B414A0B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418627; cv=none; b=F1ryPzREpKUCfRI1Ro7ssFK0fC/GcRWRTcw0AcfSl956VXxtqYhL/VcRwAKUF5No7aRKN9CCJ4U67GlepOBbLfdewB2EnIAt29//fP05w5VL9cXi1lQ1TzYlzXcQ2nwovs7OEZsBoVlrycRiDUKEeJEM16NVk/LjY+RA/LpeoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418627; c=relaxed/simple;
	bh=D3Q62JDOJMoCruOsnz+vC8PgQX3Y7tK6WSKtlJ2Rnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anF4hYnQA3qfVSpD3TICP4iCOIxGBrwrV0XirNdYso9cNc1pOnRpoLER8+s2uCZExMbYEz7Jf5q+aiD5iBKIRgaQAQADez/wFdsuFazj5LdKYbBV4SpUydSRiwHppmT0CmyI1AVi6gd2Ji5ZweV8C8+vyl+DGyh5Ekq2si1uNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqmX1X/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754418624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsajB2UO0A1Piq3NOBQB21g4NsKLS1tqOn8nF+qqwHU=;
	b=eqmX1X/QhaRrsGF44qMPRPK04Cd/RkpoNVa6BlxM8WzPC4eDjnRDSVoOhXTFrmUMHZx26Q
	P7lJZd5B/EEl/UtTHFetI4t0Pp/vDrA3W/F6qnx0f8gjWv7EZRkHS6LaDcuWe/sbCGKVfh
	g2X4OltATk4hx7mHukSXwlrA9ikY+sk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-fioK_HJQP9u-KZkyDXuASw-1; Tue, 05 Aug 2025 14:30:23 -0400
X-MC-Unique: fioK_HJQP9u-KZkyDXuASw-1
X-Mimecast-MFC-AGG-ID: fioK_HJQP9u-KZkyDXuASw_1754418622
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d8020b7bso16280715e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 11:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418622; x=1755023422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsajB2UO0A1Piq3NOBQB21g4NsKLS1tqOn8nF+qqwHU=;
        b=prZvJS5ExplKg7EPofn3qU6qRS1KgQhWWbHldpgNIrVppQJmu1qyHrWMGfJl53SyRU
         /PeJdu+AoaMRW9XrxgtOAPQGzVhFrOdtTa90xLLTqS1wKBUbMGb+bzh7e/5mb3fSHIjh
         h4J8CS36qn8B28bFNsM4H0IYI1wkcbMx/QPS/Paz5Qvnp9nw/fNJZ9Q0GLrCz/4B2Bka
         SQ8EKNElmyxoFEolEDWfjlwDoJyXHpvM64cHnuxFQcvMwdjLnAo4zhHxkBneD1wkkL2Y
         wcsqCPUDJ3bIJdWOjdtBlVZv+huursNHO0OpHzL2XteSzq+FrBmRXef5B8ooa+5aM/1y
         WXVg==
X-Gm-Message-State: AOJu0YxkizO4p6dDviUVcPNzAzd2NLrqQOnk/RFV4Ys/Yg19cgtpdQDt
	VCf7scOOoC2Pyni2PkfLqCiz3/FkXIWc+3jEPFdK1mlgytYNFebIYy47L7dS2vRkG3IusAjLjiS
	RZY3Rc3E9LzdYZM0m0vronOUgScGx3jMVuJuI68CJvu6PV+jL5uMEb0ATagKikkGY0JM7q1VJxt
	AXYzLrN0W1veUpsk8OT42/lRMDdDuo5zUaG8tWPu4yqp4aIbvHiOpzQA==
X-Gm-Gg: ASbGncvuY9rqegCEFxrlnff5clcwf0uMVooXUPqHWQPIFSw0qcHYyqV2546KojRxRg6
	ShrLKqREdJSacB41GJofWBQMnRyY0O8vso88cUIH3ZH7QMQ2BDr3xLSd8U9iCJuadwR6EbBkbjf
	GuL0q/CBfsPp2JrV33N1Lzpm4Tqak4i4ZurrVUBvm7d91A2u+JiQYJWd0SI9YzqOB3U8FcdG4mK
	qV0nGzhvYRUgKe8iTN77EMfUAzmEnNKXV8VRNdT+bmbH06fch/RR4inZHUS5BMarjDozUad0X36
	A0x1dhOg5DzhPBEf6Gsb9ihYZDTJ+VKmnoauf1R2DeBIGTtKwP+CCWTMFIHxH4Hl1CTuKXjK9OT
	1vmA+IDBSvVWD+3O9wCLMSFe9mBXsed7Rvio6cXQPbQi/axiT6hhD
X-Received: by 2002:a05:600c:3145:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-458b69ddc11mr110879875e9.11.1754418621606;
        Tue, 05 Aug 2025 11:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsZ3CjrIs1HhwsUKFyZq2yQgnd/j48KFVjB9s+monVp4A6XH4Y5mB6lgT4Dk9MJh2D0PvxuA==
X-Received: by 2002:a05:600c:3145:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-458b69ddc11mr110879535e9.11.1754418621005;
        Tue, 05 Aug 2025 11:30:21 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (2A00111001223DBEE14EFA8D033F8FE7.mobile.pool.telekom.hu. [2a00:1110:122:3dbe:e14e:fa8d:33f:8fe7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586ad64sm14164595e9.20.2025.08.05.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 11:30:20 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 2/2] copy_file_range: limit size if in compat mode
Date: Tue,  5 Aug 2025 20:30:16 +0200
Message-ID: <20250805183017.4072973-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805183017.4072973-1-mszeredi@redhat.com>
References: <20250805183017.4072973-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the process runs in 32-bit compat mode, copy_file_range results can be
in the in-band error range.  In this case limit copy length to MAX_RW_COUNT
to prevent a signed overflow.

Reported-by: Florian Weimer <fweimer@redhat.com>
Closes: https://lore.kernel.org/all/lhuh5ynl8z5.fsf@oldenburg.str.redhat.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/read_write.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0ef70e128c4a..e2ccc44d96e6 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1576,6 +1576,10 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (len == 0)
 		return 0;
 
+	/* Make sure return value doesn't overflow in 32bit compat mode */
+	if (in_compat_syscall() && len > MAX_RW_COUNT)
+		len = MAX_RW_COUNT;
+
 	file_start_write(file_out);
 
 	/*
-- 
2.49.0


