Return-Path: <linux-fsdevel+bounces-47934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F2AA7632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC159E3CEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E9E2580C0;
	Fri,  2 May 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHvCMtWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCE23B0;
	Fri,  2 May 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200295; cv=none; b=kj0t1Qp4FfzomjI3VVLafW2H/l7E+8R5yxMaO5VFui9Vi8IoYpNnXN9AfcMvyhGztF9xX++NPXeymZ1T/02BysjBFQ0rn3sjzRA+kIFSGUZ1QIWXwujRwyQLO44YWKt224UHezrNWCE+bWlAf1/UDMz5xzCIyugoVEinVIcrIXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200295; c=relaxed/simple;
	bh=+EbFaAul4sYbEwIMXue0ZrWzbKCgLDgm9uvsMI5mxIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DShlQNnMGd9C+FqEt8TpJKvY+y32LzKUEHevKzAb1CK0XdAfvOy0LRcsUO2PKBX/wZpJ8uis1t238yUOm8Fq6zMBelWVKio1Y5S8A99m4WT6rUEXMedP+z9ET72MnHJdTgnzN4Hj8Lkk/GqTu6veOYDQaJIjdtagSPPF519Gayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHvCMtWV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33e4fdb8so23054375ad.2;
        Fri, 02 May 2025 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746200294; x=1746805094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLBKIU7fLn783vyRrwQ5nLvlEI11nNGPE7lwiiP5H4A=;
        b=YHvCMtWVAjN9mGj3RHFuaPene+mMff0dQpKFtmgXbtYt+iWZe79R0sAe2X5xqnbmv3
         VRiOtu93OAFNPnMjrrbCtOt0tPu6rKdxQQc4IvelGjRT4IWHcVloIfk4EesYcBEy+zOO
         xt0cCbDAuaPxCOR4vI8cs3xc5nboQaCCXcU11dwa7+nKMy0hEWZgu63SiLsoyj/RvRYn
         OtWi5sD3YX3pLxG6hGFwfvoXzSxs66PqXn1cAlje0pbeScmXYIxRRYnmhXOZwmn891Qs
         7riqQHg6IVpKow34ciCOTQxVbY1aiMGFPvMf87uexeGOrTou8870gLMv8a70YXOSo3eK
         3tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746200294; x=1746805094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLBKIU7fLn783vyRrwQ5nLvlEI11nNGPE7lwiiP5H4A=;
        b=MRLanulnTdI+u7UF4LcK+6csMfskCfMIXcdOik1zlblK6/I9RNuq02/90+nfhv2/TT
         iuswaVvnXxKjRXSJvvLH//GtPdNhoVcDUqNTp0BDu9lORqd6wmACTtPg7T1q6mJSwjIn
         n526SjR5txdb/cVulzraFrhIsNnyidL3carIonqhSs+20IMW5gAgzsPrLIhixWNofw4X
         KGzsckylCSD/uCUpVEgtZSeileQtUDMLqi9VuP1dz+m4Gg1LCKRWzA7t661170LV0Sah
         4wm7api7/zkw5o4Q1LlQHbpOzHrJNkTxSlypRCkHYYZI2kmRsFXgUSJGSm06xQIUEu0Z
         u46A==
X-Forwarded-Encrypted: i=1; AJvYcCV9YX1D6k1R2H6cqKP2tR2ZJBnonq6vcsbkJhVk1MBH3ANTDvfpvvPaaFwFlKZZrUIBjvuUlvzlZ8RrIkH4@vger.kernel.org, AJvYcCVrP8vmRqmoPT4o6ghdUToo2kUGb0TWTJW6lViojxgA3Ih/yH3SfrQe4poG+ie+zwjQ411gTbhJChY0KQ/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1L+CovhmXEXRKyckYzWEijcy714xvH/J3ciJnVjWoKyKB2Hm
	HYi1stNU/ts33AuDErwfs4L7qZdL1tZ9bwTqFxR3+M6yQFweN/+3
X-Gm-Gg: ASbGncvQMkF+rbnZXD+9411PRw+yC1Pgje4jpQasYKv52umeLq1ZKXchxiI/SiCt9IH
	raAIsj7HmeNXH60sBN0lJpTCUjtnVOzMvU7J8EWPIwEU02RYF7Bu/v/ZAp1hS0DqwPHp3xy+swb
	QcFhBOxAGPh0s/cgwbD8SHL+s/Qty5/uqwaBVaLzdAan0Uo/GBYarc/swXxsVs3T2pT6kMTkQe1
	Ku8iQ4Q3VydsWPJGwuIshKsXny1DbguK9XknEJT1QvbJJEO294oZyE17izx9tELb8HzuDUe7UAu
	IjVvi9OuaGCmfVjadHJ84fp8yfgfjSPp88QkUq5vDTAfAiYNAobP0PUHoVhHENA7vbRORSZbSgu
	4vAg7YEcD7B/lh7WHQn8E
X-Google-Smtp-Source: AGHT+IFajp66gmseTOYhGIHylGu7DHbckOMLRN1NUAWSX3WFhJmt3yida5qoHACmAJMFYibLqqQzAg==
X-Received: by 2002:a17:903:1450:b0:224:122d:d2de with SMTP id d9443c01a7336-22e1031e63amr51321435ad.16.1746200293619;
        Fri, 02 May 2025 08:38:13 -0700 (PDT)
Received: from localhost.localdomain ([159.226.94.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3924dd2sm925206a12.14.2025.05.02.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:38:13 -0700 (PDT)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org
Cc: ocfs2-devel@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhiyu Zhang <zhiyuzhang999@gmail.com>
Subject: [PATCH] ocfs2: Fix potential ERR_PTR dereference in ocfs2_unlock_and_free_folios
Date: Fri,  2 May 2025 23:37:42 +0800
Message-Id: <20250502153742.598-1-zhiyuzhang999@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocation of a folio fails (e.g., -ENOMEM), ocfs2_write_begin_nolock()
stores an ERR_PTR in wc->w_folios[i]. ocfs2_unlock_and_free_folios() later
walks this array but only skips NULL entries, thus passing the error pointer
to folio_unlock(), which eventually dereferences it in const_folio_flags and
panics with BUG: unable to handle kernel paging request in const_folio_flags.

This patch fixes this issue by adding IS_ERR_OR_NULL() to filter both NULL
and error entries before any folio operations.

Fixes: 7e119cff9d0a ("ocfs2: convert w_pages to w_folios")
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/CALf2hKtnFskBvmZeigK_=mqq9Vd4TWT+YOXcwfNNt1ydOY=0Yg@mail.gmail.com/T/#u
Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
 fs/ocfs2/aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 40b6bce12951..9e500c5fee38 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -760,7 +760,7 @@ void ocfs2_unlock_and_free_folios(struct folio **folios, int num_folios)
 	int i;

 	for(i = 0; i < num_folios; i++) {
-		if (!folios[i])
+		if (IS_ERR_OR_NULL(folios[i]))
 			continue;
 		folio_unlock(folios[i]);
 		folio_mark_accessed(folios[i]);
--
2.34.1


