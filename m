Return-Path: <linux-fsdevel+bounces-10091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81A847A98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6561C26B1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259997E0F0;
	Fri,  2 Feb 2024 20:39:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F67C6CE
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906393; cv=none; b=W7AFNmK+/H4ABdEE75hDTSJ5QgAAfqnPDC0p+wt8topr1wMaOIBt+2jTtpQZi0Nq9yYRjyadwk7DxahDInI5ZHnbhwlT4GSosmWsvCb3ZPS6n4OBkNyVhzLfMDNLVS6UJKldfQCoYHKRcUECVSQ8Vkn1+91ZwalqBe25yIMyO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906393; c=relaxed/simple;
	bh=PeigcjR0fJHqnWYzUNDhF0SumumPwInd9lmx/bLcwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xsb7fUpRG9xBO2qwmAGh8fOwQ7mFCseWAgwxXu+K3Fue9mxXjPAob+ih49j0YJnOu6q1qwcY9f8B0aGC28V+XcTtgcqIMCkDv2y+lnc0C/Knm+Nmau1Cwi3euzmTKtDe+9evxbqVbN6/azjA3ePH0v0eVdDDUsGla62c0ZHeHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a7a6a24b1so1141603eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906391; x=1707511191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkb7BdFD0GARRMQmHbkGbl9/+4lufBLaMcZRoVBPKBQ=;
        b=hf8VPcMDPSVlCag8RiQY3C91l07DilBDw7efHOc/lUxWyUx53Cx5UF1JZpvwuvZxUy
         p/B7m47IXH4TkFwl3udphQgyEh7HlbDTE3kl02O7xX7TR17tFfjH1aqM7p7tle7+OnHw
         vxlSLx764orx0lu1uIpcSeKjSBYCv/IjXp8tNzs2C3hp8VAOI9+haQmxHXuQlthBAH/c
         VDnNSVcqduXvlbws4NcmJy0uPvBURI41TtPZCx7j6BmpKOea3HgnI0zVQFpWm7+s7wXw
         KSLE9yWJX4lU9FH+EGBLEiavkZqE/4BnXwpY33JUL5kSVYAjz9LuoKzXOtoHcizurU6t
         u14A==
X-Gm-Message-State: AOJu0YyKk+7eAtGE4cSGTIzwVBX3gsl9KLKiasJzcxlpiv5YLBdxR6b4
	jfnVDAT+yjsUykzgQIzDypsYqbyWXDdHWkd2FUTlKTgAE67mOB19
X-Google-Smtp-Source: AGHT+IG1+uP5CcN9rTTcssYSjIZGMttSjwyGEXw6WrUqRA7pduBBrUW9Bt+kEDDLyVjGrr+305u8iQ==
X-Received: by 2002:a05:6358:3121:b0:176:40fb:e123 with SMTP id c33-20020a056358312100b0017640fbe123mr9335719rwe.5.1706906391241;
        Fri, 02 Feb 2024 12:39:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVoeej/WqOUFQ1qe4Q1EO8ooUmvGNV4cZ5QAaP9J5aquYgX5M6rwnEzGDG/U5JBeLKfI/W8p0Y28JTy5ei6Zeid0V6GIJT9Z2j8zKgvjS+t37yq1IzTe/wd6rWhB2HglRePN1R/TdNPeAEeSzzMw3vST3omXDFrebbN2vc6+qoluL3/MK9YplQ4NuSPzIkOhO+IdHeUYPAxQsz7XmVRI23kw3zbt0GWXHL/vs5+2Yaqw==
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:4cc3:4ab5:7d2:ddc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm2239678pgg.73.2024.02.02.12.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:39:50 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/6] fs: Verify write lifetime constants at compile time
Date: Fri,  2 Feb 2024 12:39:21 -0800
Message-ID: <20240202203926.2478590-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202203926.2478590-1-bvanassche@acm.org>
References: <20240202203926.2478590-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code in fs/fcntl.c converts RWH_* constants to and from WRITE_LIFE_*
constants using casts. Verify at compile time that these casts will yield
the intended effect.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3ff707bf2743..f3bc4662455f 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -270,6 +270,13 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 
 static bool rw_hint_valid(u64 hint)
 {
+	BUILD_BUG_ON(WRITE_LIFE_NOT_SET != RWH_WRITE_LIFE_NOT_SET);
+	BUILD_BUG_ON(WRITE_LIFE_NONE != RWH_WRITE_LIFE_NONE);
+	BUILD_BUG_ON(WRITE_LIFE_SHORT != RWH_WRITE_LIFE_SHORT);
+	BUILD_BUG_ON(WRITE_LIFE_MEDIUM != RWH_WRITE_LIFE_MEDIUM);
+	BUILD_BUG_ON(WRITE_LIFE_LONG != RWH_WRITE_LIFE_LONG);
+	BUILD_BUG_ON(WRITE_LIFE_EXTREME != RWH_WRITE_LIFE_EXTREME);
+
 	switch (hint) {
 	case RWH_WRITE_LIFE_NOT_SET:
 	case RWH_WRITE_LIFE_NONE:

