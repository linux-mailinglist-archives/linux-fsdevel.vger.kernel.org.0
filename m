Return-Path: <linux-fsdevel+bounces-32450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE09A58B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 03:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDD91C20FF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 01:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76C126C0B;
	Mon, 21 Oct 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jPaPMNaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833C82D83
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729475645; cv=none; b=PBECYa4PDYOdubqXZJJ6m7omGWxKEymez/1alLIhHZjs+gJy9kDfhpgphQY0HQ4pQu4Tv4y23KQWGuen83kd81ffohL62D+LyJMlVqleo8uqrgOWYxUAaRoxMEwHYkAZrVHGs63PUlCDsnOJ+EoOJosc2/L5a6n7wx5gv6K52vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729475645; c=relaxed/simple;
	bh=+v/H79GmiAG3naN0zeRg2nElJUiBqVhmyL2Hh1hlU1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1rm+RvQuVTV5hODBJgHz94t1iB/m+7h88h47JGWV0/zbB4rO5ahlt0jjHo21jX66j3TOrQD0GD7OgTZuW/y3jiP54KH5mjywA9h2eRQnCZYOX9WfsdCvR4NkLT5RJJwAXVyEHrFmaoG467bGvcv0Z8nDnKJe70MK2bI2gavrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jPaPMNaz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbb1cf324so35098955ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2024 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729475642; x=1730080442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmUjBpdJ0f8V/MHrwl+AGewKk5aAt+i1MtpvNR8b1Y8=;
        b=jPaPMNazIG9wKFrhCiVuME+1DCpbm3buJdEvqMBu/yXUuXMFWHrj7IiEkhnaMV9KZJ
         m/m5dncBvKrF9U0CB2ZPEaBkp0Xf5w3ftOpoeYIiyM0UI2HBOIQtaAGg+2iSzFbdH23f
         Sug6HtzSIp23FZ2OWhTySPXE8KVAlx60d5GTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729475642; x=1730080442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmUjBpdJ0f8V/MHrwl+AGewKk5aAt+i1MtpvNR8b1Y8=;
        b=TggaACfzYywKuw54/SbdbMAapsEVAZ+wcyMLQTZYYRpjhxp4PZN+jqLP5anukv5IT1
         Rdigm80AnISrFMRX/kNxej7shN0PHuO4S7yuouj0ciLVK81oUlPTqtZX7kTWu0Iq3THq
         Ji69PJ4Uyts1faQnnaAyAVWvy7ThRK0/5lUadWEzU6cta021aa5lLRSpjFi1rSwDYCTr
         ELE/E4ii/qbzEWmdY/J+EL5wif8zz/X+q1dfIhqEiilPqjbxS6hOrGTP0Na410Sa3/fc
         5BLGLjHd/4+PoVyl1D3M+yJaux75bgQw+m2XA/oj1CoRZ2y+hUlucxamI9My4Xt+ysHH
         vVHA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/0x3nQLmXXACNel7YgNSlWPHSyEH8gDJn6kLYzL7hlgiA6CkCcKe7zVQhe6Fp4j2u5vz1s2kzDtfviIx@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTmtwODgDtux5gIU9qyvFcIs3VcrJSffhIkdsTDwhWMJE4Erx
	HGwH8z/nIpdPlm5aj40JOkBiGYsiVvYZVkF48yd2nTu89AMoScpHS44XdLVRwBI=
X-Google-Smtp-Source: AGHT+IGVda21+4TkdnbM/4Q+uHbJcBEZbiTKQt97djp2s9YV3IPbRBsjbBBv8Rl+668P90LjyRMasw==
X-Received: by 2002:a17:902:f906:b0:20b:8776:4906 with SMTP id d9443c01a7336-20e5a8ee770mr105564285ad.37.1729475642435;
        Sun, 20 Oct 2024 18:54:02 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee650bsm15859985ad.34.2024.10.20.18.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:54:01 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: namangulati@google.com,
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
Subject: [PATCH net-next v2 5/6] eventpoll: Control irq suspension for prefer_busy_poll
Date: Mon, 21 Oct 2024 01:53:00 +0000
Message-Id: <20241021015311.95468-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021015311.95468-1-jdamato@fastly.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When events are reported to userland and prefer_busy_poll is set, irqs
are temporarily suspended using napi_suspend_irqs.

If no events are found and ep_poll would go to sleep, irq suspension is
cancelled using napi_resume_irqs.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 rfc -> v1:
   - move irq resume code from ep_free to a helper which either resumes
     IRQs or does nothing if !defined(CONFIG_NET_RX_BUSY_POLL).

 fs/eventpoll.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f9e0d9307dad..36a657594352 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -457,6 +457,8 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 		 * it back in when we have moved a socket with a valid NAPI
 		 * ID onto the ready list.
 		 */
+		if (prefer_busy_poll)
+			napi_resume_irqs(napi_id);
 		ep->napi_id = 0;
 		return false;
 	}
@@ -540,6 +542,22 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_suspend_irqs(napi_id);
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_resume_irqs(napi_id);
+}
+
 #else
 
 static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
@@ -557,6 +575,14 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	return -EOPNOTSUPP;
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -788,6 +814,7 @@ static bool ep_refcount_dec_and_test(struct eventpoll *ep)
 
 static void ep_free(struct eventpoll *ep)
 {
+	ep_resume_napi_irqs(ep);
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
@@ -2005,8 +2032,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			 * trying again in search of more luck.
 			 */
 			res = ep_send_events(ep, events, maxevents);
-			if (res)
+			if (res) {
+				ep_suspend_napi_irqs(ep);
 				return res;
+			}
 		}
 
 		if (timed_out)
-- 
2.25.1


