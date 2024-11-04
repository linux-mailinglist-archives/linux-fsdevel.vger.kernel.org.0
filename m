Return-Path: <linux-fsdevel+bounces-33633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AE9BC073
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29D01C21589
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C4D1FEFA2;
	Mon,  4 Nov 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rHg1+Xru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBE1FE106
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757417; cv=none; b=LizywJkniJ6IwrC/L24aHJdA+It93Ys6l09GxO3GZFHSwQmOPvCXxsr07VO3JWZ9P0lJODJBi9+OisvlYDMdfWi4O6i4q1o9DKLkZJxmMa48tiSIoGD/mTM0cQ8kF+Am8An8ao5zfkj4vfDXbPiGQxYgyCI63FtT0iTnf3F790c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757417; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3ntc+Az/WhH6OpBnjCiIKOHcJkc3pXCzFodQXRuA7s/Ym0u0uFNsaXYoJ/UT8TdFgznk6EftipJ1ul3H7xVJ34n6LYCEtIGjo0hA3TW5lBqh6g5Eqyhsg1nw2QWbZ7k0fACf2pNrcpgaMZd8vjcIiYyZjXmJ3mbzrXdAQ689Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rHg1+Xru; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20e6981ca77so49640785ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2024 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757415; x=1731362215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=rHg1+XruwEqqH7mILatPJUnGyKpgR+YajrD2RzxapmO2XEkG4XfFS5XkanPnhP0sgY
         qp64YAnaMwu9V4togVQyqcjuv3K01SYXNo1sRMW5Xs9EO4VotxbNjG8e+z1cWvvwOTdE
         pwfUrGEcxtmi6aj64eTov5NUWgmr8DJvXCbgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757415; x=1731362215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=Qh0hYw3lGvDM8/WPwFa+zZZpZkKgs7/MeMPzA2T4IzXWtILu6SyREhZNIz3eqcen9B
         wvPpFKYOYpASQpBPpVyO0zDTUzJRKGDwijvNQLe5CSIYLI9dCZ5vGFoWQzCly1n5Zkov
         Co1T00+Qxfmvi5TQxVbElJU7fVOvO6loEkYxPYTWma99pMa+kI/GcBAb1wutUZ++FY9b
         NwYeTMw0A8RXB/V3vZQREOoNTIqC9Y9wNd5i6lOLH8vJ6Z2fBbrj7j6gE0ckO9UihcpX
         i6nWcq5eU+GwuFObbYfm6TNBWMFK1S/cj+prCY2iZ7l3s7KgV1irG7C86qY8GNaUcsjo
         IUyg==
X-Forwarded-Encrypted: i=1; AJvYcCXSzbuB2KjzOH8zJpUdCAObJ6Th38GfL3Z10g1MCoT4DxcU6EAGZiJ4LDgTPHiwOjNSrB44Bzz31Ziuo8WN@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCyPoe5QqX+yeJ9iHigFXlNxFJKA76OhWoTEm+XrTUGPX8eFi
	rON0/sN7qJO/0DvJIhJeGZr97BNI5SBnLEMIhTtSGVgDFZHzNBfT9RQwO2hX7kY=
X-Google-Smtp-Source: AGHT+IHWXLfYRnyjLLBm8m8/vH3IV4zCHF4QIeTTrl45VzFqWP55kOn1ZRaQZ6RVPpoxAWT4AQ1w/w==
X-Received: by 2002:a17:902:cec9:b0:20c:872f:6963 with SMTP id d9443c01a7336-21103b1ce5amr244888585ad.33.1730757415610;
        Mon, 04 Nov 2024 13:56:55 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:55 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
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
Subject: [PATCH net-next v6 4/7] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Mon,  4 Nov 2024 21:55:28 +0000
Message-Id: <20241104215542.215919-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104215542.215919-1-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
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
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
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


