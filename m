Return-Path: <linux-fsdevel+bounces-26948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E9C95D452
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E981AB21CED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014E192B86;
	Fri, 23 Aug 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="twgo/R6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73628191F81
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434316; cv=none; b=cM0sPO+9UwnZq7WUM6doXVyRYaK3wMMMfzqs/hi+FvAn1TO4ZDW1NQZ0Xs7fi7xP01PjJGuPdXxiX8R4Sc0tbDQmQhPoo1yo1rGCSqwr1zMWpD+1Lvu90UBAHb1f+xvP3pDqQtDMbQaBoWwamurDqasp1RItCBc19XL2L22V/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434316; c=relaxed/simple;
	bh=uGO5dEJrzAGpkDGXLrC8ztAywM3dRMCy6F4elADygWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POFOAZbIXbmricoucEAhChBhyb5TTIIMZyjYwI94kISWhQuuIGV9n2fa1zjQxdMqkctcz7tbeBtnqFinQEC4cLnhvOY+abOGhscnMZ3ietDaF/JzSKw+uOuu2xXHRN14914Wcjnx1hiGGDOVKiFbfVmT/4+isFnK/L40ufMzKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=twgo/R6y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1344767a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724434315; x=1725039115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58S4qbuyYKoKQjyHpzs28ekwRvFYt2yreo1eLG7u1fM=;
        b=twgo/R6yBWs7WuZvoSdye6GCNXPvb0JViHYT4zcpQCEdfcSfBy9yJycfC/01CrerAK
         9I+R4bRipMWIkMu3GKP4zVmpOGxR0x71MkkOcYk+R6e2CfJwm6D2OJBlUFih08NCNNbS
         P4esa7u4fAZ6UfK+wpk6ek8BwEDw7BKiE6XGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434315; x=1725039115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58S4qbuyYKoKQjyHpzs28ekwRvFYt2yreo1eLG7u1fM=;
        b=S0SBhCZVZThTP3+LMBzrvWUso3iReNJPQCDsItEeloimJp45TRVCb36JEesVeUKRec
         fnB50onUjGgc4tRukyPzWl7SGpAvecW+TRbGWg4etco/Kjnn0v61tEK5hvBJOJqmWvlz
         O0BRcoYWR+NZWsqizKENGKUSqZgKlZvY6VqWY/zX5QWBy2iZcR0mhPCc3J5UBr3Jnnos
         7PcHhhx1TR9zRScMLOQP8xunE5P7FRHP5YckC43hOSvjNp9QE5rkUYQHorx8IO0Z9v/k
         7t5qB3hUmUegFb5gjwqR6R4Z3FfnWxi7WtfM1l5CaFXYSQZ818RLYf65LcO4IFV+aP8J
         dOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Z8G2y3Vun4+X51uadej24EOJiAvTqx93zYBV8HWeirCBe+yOSmNHERS4TVeFU5Gj5KM7FYCNw/HMZBrb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsb4Y1jdW9/NIjgIoJKltWGSsUubuoO7tHXosH6ngn9rIlu0/r
	yQtOxbRJ4PpMPWWZny50392ADMYrTcXZirI3Lajw+Bfx8ZujM705SI7sP8+JQMY=
X-Google-Smtp-Source: AGHT+IERjh31UHWhIZDePORqNzeJZelgKL0ItV5Or+5rM0DaNHnsupMW/bNRFrWJoppeQW8QJR6Ong==
X-Received: by 2002:a05:6a20:9f4a:b0:1c4:c879:b77f with SMTP id adf61e73a8af0-1cc89d7e4b6mr3579864637.27.1724434314568;
        Fri, 23 Aug 2024 10:31:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430964fsm3279624b3a.150.2024.08.23.10.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:31:54 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: amritha.nambiar@intel.com,
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
Subject: [PATCH net-next 4/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri, 23 Aug 2024 17:30:55 +0000
Message-Id: <20240823173103.94978-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823173103.94978-1-jdamato@fastly.com>
References: <20240823173103.94978-1-jdamato@fastly.com>
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
---
 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..cc47f72005ed 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!ep->busy_poll_usecs || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


