Return-Path: <linux-fsdevel+bounces-3487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0D7F524F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAD51C20A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074DA1C2AC;
	Wed, 22 Nov 2023 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlX5uNar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45FF1719;
	Wed, 22 Nov 2023 13:12:35 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so167434a12.0;
        Wed, 22 Nov 2023 13:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687555; x=1701292355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOrPhfU2mXxyBlZrT3heEZSZHpuQWnnIT7HedEB0hRs=;
        b=JlX5uNarejalLnI2Pu9HRXNhGvHcdL33My/bwG9ec8rFnYIwKhWNLJ0Xq6ol+iUSR6
         Daqhk/EcldqH7f2dIz328o5byD9vx3Uybrwb7v9Qaz9MYOtXGViOpheoTDS67EnuZqNR
         lc9P2iVzKMtElT+73SsU6L2wEPfkYvsrOvccYSZw9EdPAMRhi9LachWT0FMA9TDeOuP1
         lL1jcHeIi0DV3QgZO1YCyAJhwvFX2wEFJBALpog+DvgCb2qtkg648KTK0Ob23P8j/Rqb
         kf/eOggQdNf8S3eHc8d9YFvl95uktY65xUJPfEoraCwpjmMNeczSPz3ke8iAm8ZjvfpY
         D13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687555; x=1701292355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOrPhfU2mXxyBlZrT3heEZSZHpuQWnnIT7HedEB0hRs=;
        b=MTwSuOl3ZAWmV/EQawgctdZwe0NbRgG8+AfqKVztIbCqG052bzG+4nhQqrVzGKklt8
         2FqWDWEVk2aai994xPJ/9fMKBSgYJGp3Z9T8SbGNp0tE3KzHYF8izyQRIaW2W+y0vZIu
         s3N/JzxoT4UqgAEDgj0etk1WCXbz7sZmsLsd5gG9Qq3SNGr7SCFx/HQhoEsD9i7A6LVq
         pMgzeH+ZO83KzTSL5Ib+r4N6FcyzEpjKKivy6dcBJ13n1Ak3B/DGxU6BtQyVvTgE65WE
         IDCFIMp3adGSZrDsCMGjadBtzh2VZ49tQLemagBmse5qOuovvQumt0g9VijPD8Rz2viF
         yKDw==
X-Gm-Message-State: AOJu0YwLOEOxni1bAR4+hJxFVu3LW9/51buaUaF4Va0WlKrAdB0v7soW
	jv1pJb62R2i6ThTmv9dV9Q==
X-Google-Smtp-Source: AGHT+IEMVmGwOk2fW31bSZrZqUdP6V2qhUklPoSlj+1Lun+mapADWEqdgcI4ZGVd2ENv41y7cSvJXA==
X-Received: by 2002:a05:6a21:9982:b0:189:11e8:6237 with SMTP id ve2-20020a056a21998200b0018911e86237mr4066108pzb.51.1700687554935;
        Wed, 22 Nov 2023 13:12:34 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:34 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 10/11] mm/mempolicy: mpol_parse_str should ignore trailing characters in nodelist
Date: Wed, 22 Nov 2023 16:11:59 -0500
Message-Id: <20231122211200.31620-11-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validating MPOL_PREFERRED, the nodelist has already been parsed
and error checked by nodelist_parse.  So rather than looping through
the string again, we should just check that the weight of the nodemask
is 1, which is the actual condition we care to check.

This also handles the case where newline characters are present.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a418af0a1359..eac71f2adfdc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3159,12 +3159,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 * nodelist (or nodes) cannot be empty.
 		 */
 		if (nodelist) {
-			char *rest = nodelist;
-			while (isdigit(*rest))
-				rest++;
-			if (*rest)
-				goto out;
-			if (nodes_empty(nodes))
+			if (nodes_weight(nodes) != 1)
 				goto out;
 		}
 		break;
-- 
2.39.1


