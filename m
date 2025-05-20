Return-Path: <linux-fsdevel+bounces-49498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DDABD846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB97E3B9D1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0671D1A08A4;
	Tue, 20 May 2025 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFPXYsLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCA19E966
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744562; cv=none; b=R5L4DtVkIcKYWeqIjOcba5dolhQ/6IbmVTEg9ukSAgZJzw6iZLowxarmSY58+AN3CGxv1gI64dzExmeYKqwjkHq0Bi1lE4izYSsyHcmtBVWutaa5aW2iWO8zCg/rP9oWTifnJ9XpOwaavOMObEIzSNgqhx1TJvwuZPcMphSZWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744562; c=relaxed/simple;
	bh=673XBPRyzebnsJJ6ivPQwMAs0N/F83vVBY0oWEkZ3nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFH+ldwpb3QqCPOnnOvjiP+8DrF3r5IA5152wbkAndS8zBEWxyDbUOxMCulGA63FMGYJGNWsfl/nYa0MUbhocwu048QpZTFYNB0ZEObNhy8DhSvCw5RV3N9wRxRxMExeTlDtB/Re6f1CHOZkDPHnuF7LBdDeVULTvD6Yp/Agfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KFPXYsLY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74068f95d9fso4982071b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 05:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747744560; x=1748349360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFqkyuEgS2DYkSpYETdQW6012El1Bu2/BFMTj3Lxalc=;
        b=KFPXYsLYrodHMp/5DgMiSf9ZpiOSba8JSBxJEP+oP/fBh1NHbPIBS9bv2kc34CyCji
         u2ZyFyy/W7EyLsw1OALMeM5y7wPNikqQ8tHrghL0bIuygGkqTkWpOeAvZsqT/OFiAHsU
         RxjIc53fmBqp+qV3D2v8Ogk30CYF2ceGHNEso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744560; x=1748349360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFqkyuEgS2DYkSpYETdQW6012El1Bu2/BFMTj3Lxalc=;
        b=TEYXNBVnQIbTuhTZ7vWFFtl0yebqrkDfNXzAd6qXtO8bOoshPsi/HpdehBCXrC5wUF
         D+nYoKuxpHY+vC9nVQctUxt6+9BGZvejeOzJHuvVY/cV8wXlaC4jaQIw7bPbykF8oZ4y
         S5EMLHEtoEAhyzMY9auVJ1eShKnsK73EQyk0N3pfEIs7SqF+LdsdapnCi8ga6JExIEai
         idlIYkkFKqk0ydqg+XaixR6VXQoZJp+kpfomM5q525q+Sxl6+tXNIC01hGHkpKgDJ2yX
         WrNRui9xK5NZ3/pGXDg9NQAAN4/dEh4PoFpq8vwWrs6E2u4M/w/pK0T0obEbHROKciHy
         I+Yw==
X-Gm-Message-State: AOJu0YxF9Zfku44K917dDgvHdq++4o2v6lnzwrgio1I+4Cx+fJJhIaNO
	+Y47KWDq3pbkdLbRPABdptFnhoAPbhT7APKUhWkoIlbqwigQZTEFm8KIM8+7dLsZXg==
X-Gm-Gg: ASbGncv2YV9SdZj/9LkAyjKTd0lopxxZgb1NybHRP1EnBz4Vpxjed/r+8D2rmWPujeO
	twDkIj0sGBuyL4yethQ244ggd2m+HHa/Q6TZAbDpsKVDghnoKD/1MhBQFu9Qc+lsfwkEmbmiH95
	zlGnnVuINTx1dzGPDcnldwZzJCSwkHZdDNosJg5ZH6fqXxsa3ROxJ+vyNcT7lVFzOpvG8XBe/TC
	KQI80fWoH60CN7yIBGydOER1hMYxZ043PcoRhbn7yNuC/+akJrUxur+V+gHTkX6AhrixP2nsQV2
	GYOR+MXJ7EHSo4lTSg6x9UO38fE2tt5/FPGewbLY5H0DMjRpiOG5drQnxHQkFm1JEbHspBO4fle
	UoQ==
X-Google-Smtp-Source: AGHT+IGpncCXk5KCz55zccTXitwVoPNGD+eQUN+YfywndV0MF1z25HxMj+U4Tr7S90HyyHj9gOFxpw==
X-Received: by 2002:a17:90b:2b45:b0:308:7a70:489a with SMTP id 98e67ed59e1d1-30e83228dcfmr23999528a91.30.1747744560161;
        Tue, 20 May 2025 05:36:00 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:cdd3:ba65:b6f2:d55e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d6f95sm1573989a91.30.2025.05.20.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:35:59 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] fanotify: wake-up all waiters on release
Date: Tue, 20 May 2025 21:35:12 +0900
Message-ID: <20250520123544.4087208-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
References: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once reply response is set for all outstanding requests
wake_up_all() of the ->access_waitq waiters so that they
can finish user-wait.  Otherwise fsnotify_destroy_group()
can wait forever for ->user_waits to reach 0 (which it
never will.)

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 87f861e9004f..95a3b843cbbf 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1046,8 +1046,8 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	}
 	spin_unlock(&group->notification_lock);
 
-	/* Response for all permission events it set, wakeup waiters */
-	wake_up(&group->fanotify_data.access_waitq);
+	/* Response for all permission events is set, wakeup waiters */
+	wake_up_all(&group->fanotify_data.access_waitq);
 
 	/* matches the fanotify_init->fsnotify_alloc_group */
 	fsnotify_destroy_group(group);
-- 
2.49.0.1101.gccaa498523-goog


