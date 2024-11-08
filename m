Return-Path: <linux-fsdevel+bounces-33997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848569C15B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 05:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B02F1F21963
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 04:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335E1D221D;
	Fri,  8 Nov 2024 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="X73AnGG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16881D12F8
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041681; cv=none; b=k4hiHSfVR/TqLNssO2QybUExEtSHOQQmG2Ceq6I7YiZ4RrduzSpz5OqrUpYDMTjnD+jGH4Wv3F51jkBUWavbSurLGIEK+4OOFO134XTY9AFz/bH35ZeskJYUyQE3M/Y+vIBubk3CfA5or5uY68Ehb1UJaFx0GlIue0AdiNaMeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041681; c=relaxed/simple;
	bh=ZvawQy978AWawDyo2L5Npe51s7GUMbBNxiumv6HwfAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aB/Zw9iTy3H8fcytKBAUtfP25SoEPEwj3h5BcuckUHQVFirwHdP1gU327dLNQP7fRGaZFxcsU6+bcga/Ao2RNHA2EA7DKFHyL5+WzlCV+2x2X/cYkUgBVTA+kId5VMKxwOsse5mUfA5y+e21I2CqDaIF5YWNsQfSwuNd3opNqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=X73AnGG9; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288d4da7221so965556fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 20:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041679; x=1731646479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=X73AnGG9B2YuSIyKCGsdJMQ3PV8XSM6taTsWTp15sAORh0Z6oWV4ahDC//QiJNuFEo
         +vvdsJ0Fz0ewu+lkHYF1OlE58C/7VdC27BR7AQkzSX9WBwXiFkeCvo0h5oaAV0QPQ7we
         dPfmYiKFz+9v3cDtaKg8M+nbhXeMR6v6f2KVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041679; x=1731646479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=LHgZ97eJmIb2xDFN7hcfmXlnzJo9j+4wmqtb6DxkfyJFVmEZA4gfNpuCjgy+6baPjY
         yRuYPLROpPW81aoziVdM0x58EntLvL/5yp4RrRMYluGe/RKcYKaf1F9oyQA8gYYFJYYB
         R7QbHlOANR+ipKChI2k6zKWxCGT6mr+PL3VJw+S8Of3TvnuK/jNmTJ8tIvLm7CyCHllR
         cbA8bkmd4op3U/oiIXdn2W/ulwNG7fukLqT0y2Dwhe1Kg2UVEnKjqcfxyZLte+5Zrb1/
         Jo3U0/Re17bsh8Yk6EwiEB3YbSFzUmJAoFXMnFtLY7iRS7e8naQ3ql+Ncg8dhqkUmZEA
         Ir+A==
X-Forwarded-Encrypted: i=1; AJvYcCXgLzfjP0BvLT6KgdPfuBe4WXKOar27Ki0Pc8g5050EegP/Mj9cufp+E8rNspHan9y4xvG8k7fXBThemBDM@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ40vb/djyaOZnK2LJ/mCGF90+F0wqnO09AUjpTJ6MdF2sNUga
	8MJiSK6yymWYs3mNWG6qUgCmHru6MCuYuWyKG4UTYm1yaiqrI58cwkuz9nJEFRA=
X-Google-Smtp-Source: AGHT+IH55t59fuYvzj0FqE8ebzx+qaclLE2JK9uo243GdJ/0tMudnVucF1IpjqmFSqL02Rh8E4X+XQ==
X-Received: by 2002:a05:6871:4397:b0:277:fdce:675c with SMTP id 586e51a60fabf-295600659f0mr1767104fac.15.1731041678860;
        Thu, 07 Nov 2024 20:54:38 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm2697476b3a.48.2024.11.07.20.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:54:38 -0800 (PST)
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
Subject: [PATCH net-next v8 4/6] eventpoll: Control irq suspension for prefer_busy_poll
Date: Fri,  8 Nov 2024 04:53:26 +0000
Message-Id: <20241108045337.292905-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108045337.292905-1-jdamato@fastly.com>
References: <20241108045337.292905-1-jdamato@fastly.com>
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v5:
   - Only call ep_suspend_napi_irqs when ep_send_events returns a
     positive value. IRQs are not suspended in error (e.g. EINTR)
     cases. This issue was pointed out by Hillf Danton.

 rfc -> v1:
   - move irq resume code from ep_free to a helper which either resumes
     IRQs or does nothing if !defined(CONFIG_NET_RX_BUSY_POLL).

 fs/eventpoll.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f9e0d9307dad..83bcb559b89f 100644
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
@@ -2005,8 +2032,11 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			 * trying again in search of more luck.
 			 */
 			res = ep_send_events(ep, events, maxevents);
-			if (res)
+			if (res) {
+				if (res > 0)
+					ep_suspend_napi_irqs(ep);
 				return res;
+			}
 		}
 
 		if (timed_out)
-- 
2.25.1


