Return-Path: <linux-fsdevel+bounces-33386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EE9B87DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9540FB22428
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702B84A2F;
	Fri,  1 Nov 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EOl9dT7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C6450F2
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422166; cv=none; b=LQU2Fi5e++nR6DkiadW3Y/Y0E1yhEkNHPEHuKhuxZzH+qgrh2W2V/bk9uzG/CfmtNGbzuxkLxio+BOz1Cbrkxn7Bq1i5FyZCK0eGfF9Wxw71hrDCXePUe3VQlmptwaZCmE+UO51QaaY3cX9HipShuZ6kxyWNU7d4SDQvBavNOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422166; c=relaxed/simple;
	bh=aGe3m9f05dLxeBPRr1eRz+KFLkuOg8ceUeij3ovk3Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnUdzKdWzAzv74/uO/SXMwhe86TkWMp3uUqcSW6gAk1RqoVEtgWn91Yw65aM8VWRjNh6xnvc2CY9CCARF6QHqtHQFFhDsg6RNfWWhxjrwZdrwUpUSSwqZxUtNvb7h+X8lacigYLjBWbsQZokpNlBL/RHia7VP9Lbi5n2u7yFcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EOl9dT7r; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1281467b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422160; x=1731026960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=EOl9dT7rqZ/XjE/Es3RJSORRnQSOmGvYBzkLqlURXuMRCAha7Loeei7+POyhP8uY9C
         4YQIvmTbQZPtVgIuUPSM+X9Twy+T8eKSO5/FKJjqIa9ua3K9IpiiN+fwcogFG46qCYki
         dB5tO5+fOGPLW97Ia9OplWjtER+O/Pjaps/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422160; x=1731026960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=mSD6ZguACSnBo9QIcph5Uo8I74MHFLZ2SFKDi3+ecNPgemxYViJVHZjCvtHr11v6Cw
         QweSIdTRILhh1gQmRMslz6MGaKHvSIk8jOYvKf6aqRngT1Doynb/rMtZciIk/1Q31Dzy
         F8XZ5jyuL5EEoe5Qavny87ZEi4BP3GeyqsWpoMcElEtl5SjdR6eifx7TqTQd8QxpH1Je
         4g5VxysmOJQHRc/rFCfRlotInSZQOkJnMtBLsyVqpu7DJcOUBnVW919x2DRhPxbMmuUY
         o1glZVZV7B3mBc3Xkr+cnMuGnZCHZdOB+G7UNhGh9GuflCvD9kTKx97HSXVIeHieeRy4
         w8uA==
X-Forwarded-Encrypted: i=1; AJvYcCWBKtfut0hr/Kw8WmGenGZnV7SZSPi+Ff5HZU4tU/0l1wMPGMKyqdLvygryOCX1bsVuUSfsLu6/UiTu0Pbl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24hcxDnL26wOxh0lwNuuhO0tMp4JMimeh7ziROeejdyMsuOIU
	z3k6k84Bpmiw3RkX5Ce0E4sntMrBBJdd25wkc3pQLvwQSllPIwgVqY+iAxVl5JE=
X-Google-Smtp-Source: AGHT+IGknkQOlPQzMWzF3Nd5ddeqEP5+C9cHjsG5MuxNVuNJP+70dz/NU6AVLw9eSZ98XT55SfIr/w==
X-Received: by 2002:a05:6a20:c998:b0:1d9:1c20:4092 with SMTP id adf61e73a8af0-1db91d892d8mr5691359637.16.1730422159752;
        Thu, 31 Oct 2024 17:49:19 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:19 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 4/7] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri,  1 Nov 2024 00:48:31 +0000
Message-Id: <20241101004846.32532-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Setting prefer_busy_poll now leads to an effectively nonblocking
iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 v1 -> v2:
   - Rebased to apply now that commit b9ca079dd6b0 ("eventpoll: Annotate
     data-race of busy_poll_usecs") has been picked up from VFS.

 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..f9e0d9307dad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


