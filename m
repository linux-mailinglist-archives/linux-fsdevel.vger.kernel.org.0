Return-Path: <linux-fsdevel+bounces-6141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA9813BB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892B91C20A44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84806D1B0;
	Thu, 14 Dec 2023 20:42:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C056AB80;
	Thu, 14 Dec 2023 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d35569b8c6so13909075ad.3;
        Thu, 14 Dec 2023 12:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586515; x=1703191315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG7z2aFxuG1myUjwPk7VSzvsFtYvlkLv8t5gZeaTxrg=;
        b=N/sedRUKkugiUsiF6Kd2xx4ulm8qCkaT1UDj2zI43SpqmSVy50vrhg8MODAEJJuX3W
         8fHMR5+4VC5wBoClEOiq+f3bYvujqS90lknTY/8qdNNOr1XgsiHhA9MFmpP8H+Pa8DCF
         clLQkD4eHmh83FEniShLRWi9vy8gp6bf/j+GF2lW2mOi/fIyEMdbqDdfygMzr6Q8zXqR
         YSyGEWkvnsbfiYYaVnsywaNaAMEhB9ojLPJZDiZHwSvEh4+ibW3ZOdUCToqmgYKnqmuB
         mDsLWQEYzvkKzwQKgvgjZqXXzokcLLIHmdqDHEe8HuELQHSyEzrSpN9p//jmt4vT5kyj
         jZPg==
X-Gm-Message-State: AOJu0YxNWeg1RUR2r+UyoHqyxW5Nj0eL7VJzDAe5TuzFa109NBzfUqFQ
	zlxFExCEmAE2gZL2BmmT918=
X-Google-Smtp-Source: AGHT+IHYwXQY7HgMFYOrQho/GwgPoS35s98HEsfMWra5mi0m6Iv/irRjPqpsP5bE7swAs6QlM0g5fg==
X-Received: by 2002:a17:902:8696:b0:1d2:eea4:a7cd with SMTP id g22-20020a170902869600b001d2eea4a7cdmr5410577plo.15.1702586515167;
        Thu, 14 Dec 2023 12:41:55 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:41:54 -0800 (PST)
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
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v6 02/20] fs: Verify write lifetime constants at compile time
Date: Thu, 14 Dec 2023 12:40:35 -0800
Message-ID: <20231214204119.3670625-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214204119.3670625-1-bvanassche@acm.org>
References: <20231214204119.3670625-1-bvanassche@acm.org>
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

