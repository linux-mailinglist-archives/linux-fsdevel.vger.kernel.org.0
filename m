Return-Path: <linux-fsdevel+bounces-6396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAE2817A30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A636B22AC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D15D758;
	Mon, 18 Dec 2023 18:57:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B477146E;
	Mon, 18 Dec 2023 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2797763a12.1;
        Mon, 18 Dec 2023 10:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925835; x=1703530635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG7z2aFxuG1myUjwPk7VSzvsFtYvlkLv8t5gZeaTxrg=;
        b=HvOfnafnkQNr9JqvSt36RF8OYLzUxTWEH0Vk0DJZCFq80ltHDzzJmLe+g8fhyw/H49
         1fcqLgpUr0+viTEr44gaHNVpCypB8CNBCnMYTCHGk56zS+gniSuqmkHbpkWwQwmoqCRd
         HeNdoABwQNueL+Q7OylxT9CzLPTVV9p7wKMXyKoJ1xstwKefynieXcyocV7Hxb6zhXyH
         tfboSGPWiASCleeZFghkAtkwO3SLV5YmmvIdDHbTtP+VDpYSzidE/Depf0KsR1fxQ8HO
         Wn+flrkqrsi+JUcozlMirZk9I8LtuTkfoz7GWzcbS4OJ6gd8Lx2OGUyptfbcLrLY/YB0
         wgLA==
X-Gm-Message-State: AOJu0YwcbJ0x7c8las9yPdBYhuMJMnJtAHBBrYUe57pM/Pz5TazLplWZ
	FctbuSY9kFE0QptETLlN2l/yQG75rSc=
X-Google-Smtp-Source: AGHT+IHzcTww1PRQ1iC6yPZ8qsvOOfPsBX+eE1RlF0SazGr+ZFEN+6k0XxjADLbYoRsdgCrs4chwyQ==
X-Received: by 2002:a05:6a20:100b:b0:193:fd0c:a268 with SMTP id gs11-20020a056a20100b00b00193fd0ca268mr5975053pzc.29.1702925834946;
        Mon, 18 Dec 2023 10:57:14 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:57:14 -0800 (PST)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 02/19] fs: Verify write lifetime constants at compile time
Date: Mon, 18 Dec 2023 10:56:25 -0800
Message-ID: <20231218185705.2002516-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
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

