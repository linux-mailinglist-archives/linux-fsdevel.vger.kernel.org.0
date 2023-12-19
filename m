Return-Path: <linux-fsdevel+bounces-6439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B4817E6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C881C22D00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A1256C;
	Tue, 19 Dec 2023 00:08:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46C15C4;
	Tue, 19 Dec 2023 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d3165ac96bso1175759b3a.0;
        Mon, 18 Dec 2023 16:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944503; x=1703549303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bB8lgLvC3lKlVnAPADTYlVdXiEGCv0SGER7G70aB71Y=;
        b=PCLzcdZKE+XAn9EFm/svqvCmMW0AHORuCwxTIKQiGJjvTpQl07t8SaQRh4lo/M0WY+
         IyGSajbL1yEqy+vE2eMNLyVlQahGy8mYYAlJv2ILXzEo/FxS7x9vjqAa8ZuM/56Hujny
         3to6Bp5eW3A62pahp+Lt+mx+zPvW+a8qbpiUC0N3ojM5mp5Zka/U7d5yFQYRB2CXKJu0
         //0G3z5mInQXAkK621OPA8fhXA6chccFbt3gtUDGbpDPf8Lh8wFUU8GAAPpgmuLPO9cv
         nZid7mbDAlr8i8iEsNzcyv2ImDGMG5Y5YAxYojLcsZZvs2vBwAhpmxlP2fovrlt4kZ2L
         o+5w==
X-Gm-Message-State: AOJu0YxItfMzBh8vvzWmMD2gArYZfBnZ07DuQBlfmDcFgk/pLtVXTkwO
	KEL10ObY06pvIdIL8UNfTMw=
X-Google-Smtp-Source: AGHT+IFLlSeb2kbimS3u3sBSEl5IR2z4V2UCC9EHVv4KteOlXDNyp9cZXsOxB6WflTYDhZEVfuqn1w==
X-Received: by 2002:a05:6a20:320f:b0:190:6d43:be53 with SMTP id hl15-20020a056a20320f00b001906d43be53mr7995693pzc.119.1702944503410;
        Mon, 18 Dec 2023 16:08:23 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:23 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v8 02/19] fs: Verify write lifetime constants at compile time
Date: Mon, 18 Dec 2023 16:07:35 -0800
Message-ID: <20231219000815.2739120-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
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

