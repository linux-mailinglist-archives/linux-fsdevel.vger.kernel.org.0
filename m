Return-Path: <linux-fsdevel+bounces-66951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D309DC3110D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3C14EF828
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B432EC541;
	Tue,  4 Nov 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5hbyQCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C692D2387
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260661; cv=none; b=ub0fRfK1xu45uie8X/XGSAZBZkzB+Gl57kOGxRQyjFwG992N8g1syQxZ18+RuOtpZzuIW8BJ+dxs1UZfEh84pxhGsPhCEfptGsCECEhy6269mCgYICrXK6ZKfXypg8tW3vMaSK4GktPhI64+V6DP67WHtdW1v319wQhdgyrx99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260661; c=relaxed/simple;
	bh=Zc/y7/iyuhzo73FcQYuGWiCMqi/pQGpHb9Cqw0BNl8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSlfhvTqOE6s80tMrefYl1btAlARAbjlXBNP7A0GllXGb9KpqHzqrZgeLh19rviYRHyMBly2lM3jYIP1pGMN3Wl/72ivrjNqFDjEqEk8QnGAshV5+wULuHVyQwJGeyruuLv7TxIA+p/o8Sih/MAFxzlCsSUGvCPpV+XsKcvhbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5hbyQCf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5548537b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260659; x=1762865459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8asDZdZ/5ha36TqW9viVaU035nISljT2hMRnvK4GxFQ=;
        b=N5hbyQCfZj1/OGGI72+GgKXdJ08+1645rRmavy4TlrZ2aP3Rlsohnd6HUAPJeV2/s8
         huUzE/fcj7DETBzdWOTAXqAdzp+rAOIAeluflpmfy2Gicx1lLMqmNheoEioy/GYaYx6u
         DpRK4O9nnXzCvXmOn3AI6pvQ3MbmbF0ONYLiM559v5eiNlnhKPmApca2A7MMPsO/abCf
         pDe7+v8QvbGsSuhhBFIMpreLlmHZZAed15xwJTRQLONTuArUROzG1cH+l0IGOo64Y5fw
         US4ppbUNpttTtn5/j04LmI/UHogRXNbcRaG1ZvP/127r3viM9WVnX/o/BsldFmnN98ha
         6RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260659; x=1762865459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8asDZdZ/5ha36TqW9viVaU035nISljT2hMRnvK4GxFQ=;
        b=Q28lH3Xbd2V8N2+8B+AM2wzrphqCDrL1jS50xGiIsGFySRIHZGfbxFmf4xlCEerjGq
         5bC0yF1Ht5s0krxY4XmfpC5yEgmjNHbBchZf9qHjyoQOK9kfKGEh1nftIZahO7aJ5R12
         9UZXkyUXQj29EN48Um1ZvmMSVtuoLw1d1kcW38wrmA+lT7yJImIokx1R/IXNNRa6cdAr
         4CF2VyKScVEQP2zvGntQ/5pCrrv9drJQNTQ0DhIc3HdZJ7R8MzgawomEC/RJE9Y/s0gE
         LqbvNXB6n2oHgKTRHddthVh9ncXIXs7tm7lwp+PX+hA/mJM/VinQjWbvT9ZoHz6KMjLS
         MMQA==
X-Forwarded-Encrypted: i=1; AJvYcCXGb2qUso9LmJorMlkiUy3w8A2QoCUK50pBFVqADiqvr4cEO9vsU/nGcxK7WLSGtnY3ogVr81CFIPyvMFJh@vger.kernel.org
X-Gm-Message-State: AOJu0YzAck30eeAQA+V54N6W91bPbfgXFyAkcg8H7DnL1RBpkfGRlbhi
	dctjFcTfUqqU8e+L/G4oakWaCIpLzepKPv0vMi+xXnXn0hO4dz+K/bVb
X-Gm-Gg: ASbGncv1z+PFzEhpGn0cCYjQsU7YEgywc9tIjHoajhQ9wuYsjeem2OQpuLa0clXIq8B
	YGlqaRn7cwCPlaT5tJdQ5nWwnVRqqOm98vyRLJ/hIJYRbJ6RCrJJu2yxdtJXdu1dvoiTJyGUOsO
	hCdg/AMKBXwpD4t4NTZWHBfk4N598RJdUt/oYpNPuP+0JugWwUYblJxteLTJ6w3bviGajx/cS8Z
	70ZQvRvRT9HBhMwBgSPv1fC1VI8uVPsfdUoaeQeTbnI2ZxV/BGJ8iMo7m7Eo8pdh5qYqQwXkVna
	CFXgSJ4Ri+VUA9fQvuiKldTFHfCF+OIgyHriJMcWhTIbM8q0AM1mitPRLguGdUbGlAklxgyRl6S
	t2EEZxOAkCV5YV+AzqSI+yAMWrV/QOH8eyIVSCZ/4cngYyRL+U6CKSX2ZybmDwDkar5guc0CdlR
	/6t8XpW+IMqvRLDyvkZWU6ViwfSHskOJuajENmLmkEHoo3dYB44mR3CIxQhA==
X-Google-Smtp-Source: AGHT+IFSneBnWTt2VQT9MEymny53bGd7ZCTNmsINIZkl0njlmgUgoGuMpFK6R9EKutPwtc1t3a4fcQ==
X-Received: by 2002:a05:6a00:1988:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7acbf0b9e3amr3856752b3a.1.1762260658993;
        Tue, 04 Nov 2025 04:50:58 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:50:58 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
Date: Tue,  4 Nov 2025 20:50:08 +0800
Message-ID: <20251104125009.2111925-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid
opt->blocksize and sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/isofs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..ad3143d4066b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_freesbi;
 	}
 	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
+	if (!opt->blocksize) {
+		printk(KERN_ERR
+		       "ISOFS: unable to set blocksize\n");
+		goto out_freesbi;
+	}
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */
 	sbi->s_session = opt->session;
-- 
2.43.0


