Return-Path: <linux-fsdevel+bounces-46713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4479A942BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27C38A4FC3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741BB1CAA82;
	Sat, 19 Apr 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDzMiz5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812813CFB6
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057228; cv=none; b=s1K4SsbqUmq3kxrGNap6mzVHlREA8gVLGyfshu0QNaH1y6gq/04rdI10qdVPzVaSnjj0GlfCG4MjGru1nKhlJDN5vfTPK4RvV88YWjHIt+ZIjL7S1i8sUvl+5kDNZYuS5Uxu99zg40XHiXVM09xgHTmCAO2NE8yMEutUgvur7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057228; c=relaxed/simple;
	bh=doC0C9FuHlnU3HJ+BrbpGIuYaY5ADywA4krzyLA62Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKRcP7OzciQNM40/KUjFw9dewWtY7HyqDXmDzJEx8kOecR/S2yqHtPwPjskv0ADsJgCyZMEf7qRmTd5vC7un3zIt6YHPLHUsqunt2GOEYtGNTGAoX3Ir3J0/K2VnYwd1Q7Rs/6hO2qRp8x0r8QdnAzO0i04P26OI4ZaABZuuvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDzMiz5V; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb5ec407b1so366554766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745057225; x=1745662025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TAyDGwn1qRuxYLt/VZ9jh0xi58B7pkPr18aYRJgglQ=;
        b=dDzMiz5V6xIaveXdt440foCI+7FW6IlLhPyfPgWcIiKjSmjhXSRsXophR8rkHlzVxS
         RV2PYrLLleTbKAcSGUWPgsGa/V0+Rl2YtID/6pg4KE4FILJL7sPw6wAyxcR/uh/uOs3z
         36YAA3c/LsSaBr8uyTpv7snCe9rCGKF/xADXLXoILQJAxm4ejw3KUaf9Y3f04K3+M0hM
         dcapC5dzLB1bsBa4xWw+SwTGr6qkjzXQg5zjlUhreRWxpnoG/TlU6mLqWwrMPCI/ELDj
         +DQvWgIVSnQjW54srr9anXYLvCeQsh4gXlo8awsXMTNFPIk9395rHjLX/MFIOmXN0wz2
         8ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745057225; x=1745662025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TAyDGwn1qRuxYLt/VZ9jh0xi58B7pkPr18aYRJgglQ=;
        b=N+fdDHFCHpTQJKRsZRVh1/NJD3FmOMJfxbsckzQsm2IimHFZXAPmriOzowjWikQC10
         0YY7xyMEaqh/RpgyLuTsPiiUGnueWJumc8lq1dbEwli+fghrTxBg1CQs64kTbKyZAwYX
         1id/NIMZUHO+RfQUVN5V8ygQe7t5fvlIpKr+9DMi6GRaUUJuVappEjP+GommwSVkMsGv
         OQJbdsi4UxFr35wulBc3+lRUaTIpHfoL7DUeKnyIurNhN7txbvoI/9rHWth8+R5g7cnt
         UVxKmRpLJxxCqlndi9Zr0nIbWiV8j3zRUlZlP6w6y1o+Bn4J1cKo2PCnLewk++hpHlCD
         0bKw==
X-Forwarded-Encrypted: i=1; AJvYcCUYQjCIahCfI/DPzQaXWrGPWmTI8NEYelNzWA7OzVstUN8QGm4kRT3RLH4Q0CDJchNB94SowZkJJhSW3LAM@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdJ5/rt2sL+sUeIHu8+QlTCK8yJ2DlJDBLuL4niA5bWGyWzO4
	Mvzoqmmx73H9rk5drqY5HoIjbHLMZBTU8JGZHeJdt5qmvJ/530o0
X-Gm-Gg: ASbGnct7BmUKNclvU4gQE703uB7ozGG4T0OXztAuAMGWYOrNmX7Rt1hb2wERFQqcZcR
	lhu5mVqBpVBZw3HHFm3OHitvblzdjEEdLSogUBplR7O7hIw3yr5pmXF+rhjOst3zYgF3ENQfA01
	q8V2iNbID2CmTKZoiKeQa2e2he++hrxJAv2f8/iKYIhGfglv151EjrfkzJo7KdoLCOg1xCfjnQD
	Zqe1zWLjEOk/JL7WjTfxtdb6/ROpEYz+0F0xMMEGMsXbAHjgMlYQqhm6eOh5YTcQNvszS9CK4pt
	mLygVqEGs3wwynCHhyscxH2ZOdCJHnqtx1wCObE6niAdPdx+3NyHbtT3PJVtw/6Opd5mCZWbctj
	nmnQLKM/lWwtRn8cUd8W7b8LcrEtNk/buFl0z0Q==
X-Google-Smtp-Source: AGHT+IEVspfjkAY13Ow6qLg+D9N2LAYBVrhKQ9qM6C20nCJ08or3yXpp6aVdmU4eE5NreVQYBn/+cw==
X-Received: by 2002:a17:906:d54e:b0:ac7:31a4:d4e9 with SMTP id a640c23a62f3a-acb74ac5189mr552837066b.4.1745057225117;
        Sat, 19 Apr 2025 03:07:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec507c9sm245894866b.69.2025.04.19.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 03:07:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fanotify: remove redundant permission checks
Date: Sat, 19 Apr 2025 12:06:56 +0200
Message-Id: <20250419100657.2654744-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250419100657.2654744-1-amir73il@gmail.com>
References: <20250419100657.2654744-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FAN_UNLIMITED_QUEUE and FAN_UNLIMITED_MARK flags are already checked
as part of the CAP_SYS_ADMIN check for any FANOTIFY_ADMIN_INIT_FLAGS.

Remove the individual CAP_SYS_ADMIN checks for these flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 87f861e9004f..471c57832357 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1334,6 +1334,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	 * A group with FAN_UNLIMITED_MARKS does not contribute to mark count
 	 * in the limited groups account.
 	 */
+	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_MARKS));
 	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS) &&
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
@@ -1637,21 +1638,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		goto out_destroy_group;
 	}
 
+	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
 	if (flags & FAN_UNLIMITED_QUEUE) {
-		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
 		group->max_events = UINT_MAX;
 	} else {
 		group->max_events = fanotify_max_queued_events;
 	}
 
-	if (flags & FAN_UNLIMITED_MARKS) {
-		fd = -EPERM;
-		if (!capable(CAP_SYS_ADMIN))
-			goto out_destroy_group;
-	}
-
 	if (flags & FAN_ENABLE_AUDIT) {
 		fd = -EPERM;
 		if (!capable(CAP_AUDIT_WRITE))
-- 
2.34.1


