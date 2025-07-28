Return-Path: <linux-fsdevel+bounces-56177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335DB1432C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065AF18C2D08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B8328312F;
	Mon, 28 Jul 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLcT1N7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A91280330
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734704; cv=none; b=rM14vVVNYDYCA+nj1xL/p550aLCZw9ssh2tXTOt32DS02GMR1Z8a5zHBg2WxLOPbzQ8jz+TM16u7mtkhY6P0S5uSJ75XQoxo/jjVbm10KbXg03HUMQl6p78ck9WC8WnarSAbOpdcRAfbpVPZpASqOw+yBQ3ZgxxojdQmyvUTWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734704; c=relaxed/simple;
	bh=pEsdBsP++Y85G6aS7bR9cTIxDhq123OG0RgfqhdTNOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4i1RTyFhuzRGC9Ro20QJYf5WOY6o3jhB8m/Tpk9nXp6c9d1LOTbaN6737m6ho2A1rGMjReIG1Y+7Z2EJEhAdr9kbV03c1sXQt0n/n/W9mFRwfvvEV8TFjvq7r1DPXUcuQqxCGHTAdl8U8VlDtH92DSB4tLiA4ocQc5Q3fvm2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLcT1N7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvsKU5ht1WKmP/gTh8rNGT9sMvO2NAzg8uCQD7oEXFQ=;
	b=PLcT1N7Kbny7lptvmax2N4jtScSgSOqcEKwtfa9EKf+vyiDLo33x4OtPg94it+ppmNOVez
	eVLN+nCxWEFfObwkdy1+xGgfpECCqupksq3MA4uWa917OQl4wCW3Lpk8ie65xkBM/iVItP
	YmNZ+fjy3Qavqn9bqee2XGOUvDoTTcY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-fIb24G3EPY-uoTSK03fHuw-1; Mon, 28 Jul 2025 16:31:41 -0400
X-MC-Unique: fIb24G3EPY-uoTSK03fHuw-1
X-Mimecast-MFC-AGG-ID: fIb24G3EPY-uoTSK03fHuw_1753734700
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-613559d197dso4142821a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734700; x=1754339500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvsKU5ht1WKmP/gTh8rNGT9sMvO2NAzg8uCQD7oEXFQ=;
        b=tGZGmm50ZKAlWQdP8gYE9wyuVZmsBtSxdQKMlvai5davtqcGu+6hq8kKipCPT3Np7j
         lHQxG0OvQvLXHOFU66u11sDa2RNsyijOXA3S87JPTQEdw1Pmj3fy9GKnpeBcisEM0OiM
         aCdbAze3SU5HpIcpVGKuQr4aF227QNR9kk1mON9NPQWn9tHmlqYNSyzkX2DJ5p5qmdxL
         gJ3Aq5mQDwL6CxY5vBG6+eSWSyxq+qoRS1Ca1O08AeeJweiA4nQZX1idlDwBGr24aet7
         jThliCRbDsOQ6vB7T+490BNQ833zXApsMC3jftAj7pspxmAwyWXaOQUK3FAe8wAZnWpV
         8x4A==
X-Forwarded-Encrypted: i=1; AJvYcCVLCNruFWeBqoIf82UHygvJcI9my4oH5kfMq+UaAQzqzhJHzfEEhJHeedBsHeIpQSCCJfna5TEtHi73C/cD@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNHw5y2FoQ9rc80fl7s5PonTbArdvbwYCI5I+y4TvUdigpOTi
	gLIcQ8t//KscFn1G4r97HhKPbqxo7eVTE+XlMN45Ui0m2YFqCXrHnbqm6R3/Cl+i56Oxj+KF2FI
	mQ7gsyIPDcCrkmyvj0dZNIe0IQYSB9f4/Z4MZ1/ESigbv9Dct/brpp9vDOyvXQzDg0w==
X-Gm-Gg: ASbGncvHoXFfl+8Na48aSXKU7615veI9uSiRGOZMU/bAR3ozoG4E3GM7+iP4j9FN8NZ
	2nnQO45BII2AJiW7ozXSGR8NhblOOr3Sdwq7hKH91WYpjAa2X0MFOOr+0a9Q6/QOG//yomoYoON
	Kv+zCZxoqQjoEFjXGBclFAfPKW8fGNc/szANn7Wvc45PGA5LsrEDUgjsPWbBLwBsni2p9PVK9LX
	3hoapmQlvn5jE/IGUHvNmvoHeRjM6uPLqyNu/bKz8t/EJsDFf1ScI4BCc/8b8FLOGNPoXl+Hc0s
	snKtZsRBjRq7pE1XHLJExxkbiM7XhQTpVqTEboLvqtnuOw==
X-Received: by 2002:a05:6402:4301:b0:612:3d0c:a71a with SMTP id 4fb4d7f45d1cf-614f1d1fb27mr12150581a12.14.1753734699803;
        Mon, 28 Jul 2025 13:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAgVdoNTEBJPqNHsQOHuT9fwO/DO3qMlfW/S4s3Osuit2xlyTjHHaIzxM7/XbZcrxj7z3tdA==
X-Received: by 2002:a05:6402:4301:b0:612:3d0c:a71a with SMTP id 4fb4d7f45d1cf-614f1d1fb27mr12150558a12.14.1753734699371;
        Mon, 28 Jul 2025 13:31:39 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:38 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:22 +0200
Subject: [PATCH RFC 18/29] xfs: don't allow to enable DAX on fs-verity
 sealed inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-18-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=VsEwWloIYSoJV3t10dMO/UU69MLyJpIl83HjhawNhNE=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSaSauInrBJydPPWKkpFKI8MDeYdw853hsVkzN
 /I8trh34lVHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiSRGMjJczTb9yi05r+xl
 4rdFa1eLfF/6KK25opvb576Gyvs9l9e+Z2T4luqUMafv5KawH4qnzDbxLM48f8iIf+313i8mWQf
 ON7ziBAB2pUkA
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix typo in subject]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 83d31802f943..2d8ecdd0b403 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1365,6 +1365,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)

-- 
2.50.0


