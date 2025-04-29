Return-Path: <linux-fsdevel+bounces-47606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77081AA1093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823724A0C3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B1221717;
	Tue, 29 Apr 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sor68NNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BD216386
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940868; cv=none; b=qr2b0ZNHdJEH6auFDm6/4/QdnvNhjWGerU5qPSYN9n+C9vmhytlXt1QsBjkWqB2iX15YxVLMNNl9aStMJ9LBKbvpYLGa5dsl9axTVQZTKaGxYcQkALI3+NXhiSSFwKiXbjER4/36UTtE63YxoCU8NshtCNWgObxGRA0OvkrXir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940868; c=relaxed/simple;
	bh=tibaVybjpzAuYiRZ5j1Pwnla0w4c8ydA402MSqNDJfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3kbg0Udrovzq8WQvBqNd56y4s9foWNrRLVnFuvZ6GjkS5Wqrlavy8cxVAbAvusqU2FKzdRas0/uhss9KRwRxg4NONRgs18Ev2u0tkPP+sTi/BNpnKd3CiNaHywMZ9ZotEEnXinaUji3m7Stto2nFcllRPk2fr3bEz1zwqFpAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sor68NNK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso7825563a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745940865; x=1746545665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnUkSyi8yoyA+VJzSElKzGl7Uo741FBMA+bn3K0dXP8=;
        b=sor68NNKiChgj4VvxGhv2gl5ymcwCbyEiJkUcheG+cA2QI5Kqn+ZH5yrFh6ah4nP5i
         yrC++RbclnwVqD1O4jaC/5OtLtZseaiH7jO3voiyi4Ix0SzvY4GsQobIOSgT6FqPEWhu
         1Vng8tF2uzbi6A8SKNzBolQ3o1UIhMysBUdFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745940865; x=1746545665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnUkSyi8yoyA+VJzSElKzGl7Uo741FBMA+bn3K0dXP8=;
        b=gcKQ4p4afD4p45GKaeuBzZBVz79vxnBu/IHaDUO6OVPIPP32wgpbfU8dm6gUaO/CYA
         cuUV3f2dQgwPyZrhpEk66I85IpdHy45BuuyUqGAQnvkRSX/NsA6auYIy6gyYEBtwQHxe
         XODM02M0mByuypkSm8MLKPhuGEJ4SPLgdUdf+nGLSiVl+MPlrQSz9sVcPSzgo6AGu5yy
         b41M7KxVfPeNEhejnCE0AInYUjd1tE5hC9pUHeIceJgMGjElLt3Akmz1DYtkvHIBAzBU
         c0tnsdAcqnivwPOVH43IiNWpVAk0RsYnXxXQDOqgv8b9f/C1b2YGvG6sdESbCswpUMQy
         W7Hg==
X-Gm-Message-State: AOJu0Yx2URX3J0ZlqQNwI1IjcJ6CRl8v1/yxPC0Oeck1g/lPrUVtEZv+
	JztKAjQ9OZDJYCSDquqlPP8pJZIr9Cl1mjkvRIRZOOPGFPldncothxjZhbhEpSgmSJCLDR7ap+0
	A0yG5ZClbnro/sBIAhlraYp9DrOHW4bTUSQ7YT3woZtJ6dga3n/zFBCBX/EJMqWxXaApAR7h4fb
	1TZ3qxUSkYowwTDOB/AqARsA9vwd3bvHUBHs33lu78WeUl
X-Gm-Gg: ASbGnctv7njrkyP6EnnU7luUiadUkpj4XkZcoSqVu8jL9PQCwqg4mP3+itgCRleMZFu
	h6GoQV2N7vzqktLrXnB5D2iL8epBfOfsXtiXFAoRJk6Wn5m8o7F4PUT471HGPB+JsT97rKuJJSJ
	DfRf9+50Fc3pfyW38dxIqvXjzWvJLKs0Rp9ZgN4DKKmCkr4Hio9827cFkDoEsCXU1FFzZQ9Sq+a
	paxSIgIdfVj+UCSfd2+ASXGJJanJ15+R0ploIFZ15ME/S+WZEU83OGdnYeuZJXN4q6m5p7VuhKZ
	8K7qhhNPmyzU59IusNV919I2tOJqOn5koliNwCvpBhXouRSg
X-Google-Smtp-Source: AGHT+IFlgfMl04kK4KrlY2CMQdov14qWDEOc+SHDYw5ScrR6I51QGMaBXsx96/yH3hBue0l8iz318g==
X-Received: by 2002:a05:6a21:8dcc:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-2046a402b02mr20763355637.7.1745940865516;
        Tue, 29 Apr 2025 08:34:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7fb7e54sm9135581a12.30.2025.04.29.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:34:25 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Christian Brauner <brauner@kernel.org>,
	Mike Pagano <mpagano@gentoo.org>,
	Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs.fixes] eventpoll: Prevent hang in epoll_wait
Date: Tue, 29 Apr 2025 15:34:19 +0000
Message-ID: <20250429153419.94723-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the
future"), a bug was introduced causing the loop in ep_poll to hang under
certain circumstances.

When the timeout is non-NULL and ep_schedule_timeout returns false, the
flag timed_out was not set to true. This causes a hang.

Adjust the logic and set timed_out, if needed, fixing the original code.

Reported-by: Christian Brauner <brauner@kernel.org>
Closes: https://lore.kernel.org/linux-fsdevel/20250426-haben-redeverbot-0b58878ac722@brauner/
Reported-by: Mike Pagano <mpagano@gentoo.org>
Closes: https://bugs.gentoo.org/954806
Reported-by: Carlos Llamas <cmllamas@google.com>
Closes: https://lore.kernel.org/linux-fsdevel/aBAB_4gQ6O_haAjp@google.com/
Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
Tested-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4bc264b854c4..1a5d1147f082 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2111,7 +2111,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 		write_unlock_irq(&ep->lock);
 
-		if (!eavail && ep_schedule_timeout(to))
+		if (!ep_schedule_timeout(to))
+			timed_out = 1;
+		else if (!eavail)
 			timed_out = !schedule_hrtimeout_range(to, slack,
 							      HRTIMER_MODE_ABS);
 		__set_current_state(TASK_RUNNING);

base-commit: f520bed25d17bb31c2d2d72b0a785b593a4e3179
-- 
2.43.0


