Return-Path: <linux-fsdevel+bounces-41446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F60A2F944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E39188A3BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D824C663;
	Mon, 10 Feb 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY1IkaGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B624C686
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216719; cv=none; b=nUIjhAkB1Ptx32xHisACJxRxNbflzoOlnDATIl+NsXGD4BSYzz/mh9uGv+pyiOHTW/QTUBU2MHeLDzG2timG675tTHj1pva3X1itjP85+VtmNk8Y1qz4qDUqS5MqUPmCO/nvi9sdyefPJHgrheBDxvV342PaX2zD6V40Sts1cQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216719; c=relaxed/simple;
	bh=dz7LxZV1nfgCzmAuep2NZbFxKl1hjyf7lLkOJCVdldw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG/SP0Rit9Af3gxVJAM0WBfiivJEOyioWP/3tevQD5CV/xy+yGn6eL5bkyEPdbONS3ZOA0DIQm/msTmQIYDrLaDGTruMN4ysAcGaFrAnR+jANtIOYtQhwqfTxhX13pjipdTqNHa266kyB0ORsfvCCNHTn+dYokxxq3VleXY98Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XY1IkaGU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QqCXjtSE10Zs+4B0p2/DvM2wnpUl444vokiGOL6h4dA=;
	b=XY1IkaGUj6rIW+axO+K4aT5D4X2FJayNGMOw3lJkJvY7+IwuhJsM3F3hQSU+K0o4Z9oVF0
	HIPjUl1EHEbtZy0PGm2EvQT97ZY7r9aqopKLPq4nBp+wtyLs6wDySy6UQyMDRm6cS5irFj
	/wRIKUC6I7ZY6CNTyl+CW8Vi0VEtSWs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-Wwh006gXPWqzFRjuOtKjXg-1; Mon, 10 Feb 2025 14:45:15 -0500
X-MC-Unique: Wwh006gXPWqzFRjuOtKjXg-1
X-Mimecast-MFC-AGG-ID: Wwh006gXPWqzFRjuOtKjXg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab78f2aa826so240507966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216714; x=1739821514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqCXjtSE10Zs+4B0p2/DvM2wnpUl444vokiGOL6h4dA=;
        b=optaNheL2ZI48Gmch6HgYgRKEnsl4YHIv1cXP5bdcHOfkFJqCVNH+8XYOWlwGEAq9g
         4x37naKutYDyCLMUHNadAeOJNxFgzEkq4r9Rs5ZRhUocbSefTr/bnRwpcFbdmwdFCgIU
         WN33FQnCYvaRTut794wkQt3+zLExVE1fQ8BjTwTV8Ok1+b542wE367A8rtFV2BO/d4t8
         iXW0ZuoTtt62XmojYZwxjSw3stQhG908TkOCk02uNsgRZZhlN/pIkbdcyrvzWfk0Fs9E
         RyjA0me5HcN29rqwmPyuAsBhthDnYydLgAooAYyUCZEEo6sGuQkbqdSqTCDvhU19HlQo
         Erag==
X-Forwarded-Encrypted: i=1; AJvYcCXLxg/j41HAhvJRlIXadqdF/DMX/2BKqzQwJbNrEqZ0dniS4PHaEyBLjkF5l1OtoaWaiK4srVrD7K1orvT5@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZEAq4C8k/RPhzOJcUDIW/i16P3C2gLaA2DjHm2ua0Zj+yj99
	ROJrNHtX+H3yALHztoQZ0GvamGNdyDKoM4QNa2S+suPDGQhhAVK7/vNBk0TQQBssLCu1gF72iHb
	O8CQesYkaAJ5YvAPUyxU2kGLIG51HnxuwZitwWCaNE1/R0o/IRYbsDImMd71wd6g=
X-Gm-Gg: ASbGncsXyOL+OT3XwJXbEFDUpfNw1KTD7Abu/UKS5L4EeW87wBwChky3A4Fv32hngyf
	0t48T4OL1vEV2SMkcaAwCvgSjntmHHkt0lRZWjeIxQ0/bWhfsLUueuI5UB6yH48RzaiXNH6SyCa
	tE83WxuTCDm9dtO+FZU8CQK8XW7Ja61aK96awMd+xUoivEuXm0aUKFSWMrOI7Ca4S+WQRPhjmGp
	10wWcTG2UeXeNHbtMH1eKYqGws81nxOs6Rfyy7ml46hXST8W8AclEyumyk9ZbL5b7Vp7qjYntgR
	s/3ZJDn07fxDU9v3LZu9PgcqwzY1pF5ceCIXoha4EDqs4U3U6g4cWg==
X-Received: by 2002:a05:6402:5386:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5de45017b76mr39887438a12.15.1739216714186;
        Mon, 10 Feb 2025 11:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkVngYg1NEXt/C5/FojOQgVIut41Geeor5s6D+qJmWdODol38eHGIfsFnlwT7mUxGvmQgf7g==
X-Received: by 2002:a05:6402:5386:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5de45017b76mr39887397a12.15.1739216713837;
        Mon, 10 Feb 2025 11:45:13 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-3-29.pool.digikabel.hu. [84.236.3.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7922efbb7sm702006666b.2.2025.02.10.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:45:13 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] ovl: don't allow datadir only
Date: Mon, 10 Feb 2025 20:45:05 +0100
Message-ID: <20250210194512.417339-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory overlayfs could support upper layer directly referring to a data
layer, but there's no current use case for this.

Originally, when data-only layers were introduced, this wasn't allowed,
only introduced by the "datadir+" feture, but without actually handling
this case, resuting in an Oops.

Fix by disallowing datadir without lowerdir.

Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by one")
Cc: <stable@vger.kernel.org> # v6.7
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..b11094acdd8f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1137,6 +1137,11 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (ctx->nr == ctx->nr_data) {
+		pr_err("at least one non-data lowerdir is required\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	err = -EINVAL;
 	for (i = 0; i < ctx->nr; i++) {
 		l = &ctx->lower[i];
-- 
2.48.1


