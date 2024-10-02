Return-Path: <linux-fsdevel+bounces-30676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B898D331
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C71B22E96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC51D04BE;
	Wed,  2 Oct 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="U3Vf3lDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3751D048E
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871862; cv=none; b=aMSD+mvOrAaKJPZJyRKQTBuEhGTba8TTLLsC8gNkYTXwAeGxTUXZQM7UwIBVHJhwUc56p74CsGekrEGbLaUYPyiKJK7BlTfIHYZqUrs2wY5R0sr/rpoEUrnVGm9hUhWEnvff7HqUR5lNpw3kFa5R0gvh4pile5kAuSk7eFEVsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871862; c=relaxed/simple;
	bh=6bXeKCsanUMt8vsnfk0ee0Gw9oQ7jHQbn09VlI9NjcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJwmsb1MunuPIjOaIuHZERXWi1HarCTSyzndFF5o7JRbn56ml0w1cnmmoF2u3uS45g4nERXQpnPl6g/0Wpft9efq9vZEwV2kJw10vjkZEK6ODLOO2CFvefzuAbUZ9Pi1g7Po2dnS6q7bJW8LHon8u5zmCWnfAjMpQ/WxdpyOZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=U3Vf3lDG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b49ee353cso49366165ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1727871860; x=1728476660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTNeeOGHdCxE/aLNehqkFVEv3q3dYYmghT3WJcV4lE4=;
        b=U3Vf3lDGQz+p9EKSZnBGinh7G6jIbt1j/n7Kwskrr4q5HkYnvoPpO32/tjeElRBmcq
         CRORoyZsxcSgUfwKJOFW0ObOrpdwcxAwNU7ZT05IsUXkOanmV0les70Xa+JMbZBPoQjz
         r9Qe/9mcpRk3V98g2Km8M0Qh+lb3eI63Di5vwrr3h/M5U937SbGJde01yAKxRS2zF0ud
         J22JGbZLj2e68pynHwAjdc3/M/HzOdh5wTmOEZ7CSHPUrg0dbP+kNB4qI9/DM6mHAjIW
         KM5jPYSPGmtzvofuciXY+FZdVeVW+qDRD2OiOjtsQ+38JbJDQ6xugPSHIx1wXPR8OgzQ
         /Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871860; x=1728476660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTNeeOGHdCxE/aLNehqkFVEv3q3dYYmghT3WJcV4lE4=;
        b=c07qoodQe+Xqw7BX9s7G0NouREeHoReX1OAEZ+fdXGRcuitOXag29oQ0vL0QfVUiIK
         /JqpI6MB85KoFDJnoTxedEwvUAW2VY828d4TdQ1eqw10dK3+CXsPlyz94qUv38bh/OX3
         OrwsCHWiAFb/yTEIjqfR1KHOHFrTlzvnJrQzJPqZk7tU/bSwCGlswPJPHpIiVixqE74l
         gG3Te1fAtgys4PHzPqv8h+gXdK41Zj8zSgg+y/WXReHqgC6PvvleoUSgAg3wPsJzIF97
         3Gg5j3kwRQRgv2LG1jK34QnGbsX1TOoBblhbp3zUTJBQyHSE4wnufZHvhvtOf76IxPgX
         eDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrBjAq7lOOpZ2MIdAAnJQSsuHYfGH9bjSs75oPDRZ9MFlDDqFr419gxHqba2OJOLNeO7mfjA7bIkMbAbAj@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkxvGt/OjewIcXTQQkMfGP6soSCCDcPr5QlMmrjZ1YlD1hI6w
	qFqBFTDna/zNSfbnBpeR6Wq4iYTImRYSfHdd/umJer80V1FqM1wwUjsumKWuSsM=
X-Google-Smtp-Source: AGHT+IHLY2EddxMnC8GOIHgO+9SXMorwEyuilBATFateviNAAQsWjVucg7195EwHnHLCsqszq+SKXQ==
X-Received: by 2002:a17:902:da92:b0:20b:b7b2:b6c5 with SMTP id d9443c01a7336-20bc5ae973amr45657185ad.54.1727871859880;
        Wed, 02 Oct 2024 05:24:19 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e33852sm83508625ad.199.2024.10.02.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:24:19 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: willy@infradead.org,
	akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 2/3] mm/page-writeback.c: Fix comment of wb_domain_writeout_add()
Date: Wed,  2 Oct 2024 21:00:03 +0800
Message-Id: <20241002130004.69010-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241002130004.69010-1-yizhou.tang@shopee.com>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

__bdi_writeout_inc() has undergone multiple renamings, but the comment
within the function body have not been updated accordingly. Update it
to reflect the latest wb_domain_writeout_add().

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a848e7f0719d..4f6efaa060bd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -586,7 +586,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
 	/* First event after period switching was turned off? */
 	if (unlikely(!dom->period_time)) {
 		/*
-		 * We can race with other __bdi_writeout_inc calls here but
+		 * We can race with other wb_domain_writeout_add calls here but
 		 * it does not cause any harm since the resulting time when
 		 * timer will fire and what is in writeout_period_time will be
 		 * roughly the same.
-- 
2.25.1


