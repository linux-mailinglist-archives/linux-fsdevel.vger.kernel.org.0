Return-Path: <linux-fsdevel+bounces-61693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11EBB58DA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24B7480518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD522F290B;
	Tue, 16 Sep 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL+Xia8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFB2F1FD9
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998190; cv=none; b=eEIgHTN2hbeH0sPKZ0wfJM32RJm/Qz+IRAMxpxvMXqnWpEk2NcvSNiRbXl+LGB/42takkYB99W52Rwuq1a6suykj9LUctXLEaP54CNemA6gXhRqUBy5REvhSz02fOU1U0evHmSdvABVXzdzSlQ2bNfba0Gj7hp5JOrcw828gf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998190; c=relaxed/simple;
	bh=slyVnZPzDDOXEcpF4QZOR3I7YB3yd3f7Gxtzb+FU87Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgBA8tfsbPyJu+OFl77283+dFoEmNxRA6/CxBwN1VEXb60i4kx4Su6wFAcZoZBY5yfxD6q1lotuYaYnbto+3/wiSNsK5pGoX7Wc1jTOXUY+G8G3Up23RER98nntYtImbfjq8drphQO5QFYlUZ+FkvMde/6tswxiRdlowXM8XBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL+Xia8W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-266fa7a0552so15568305ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998187; x=1758602987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=JL+Xia8W4uyroTDLgoFXQGcvga86g7+1VEKz2roIDSxQwxKuGGI1kJw0E5mRvO2QSO
         m/1WcvkXEpAacTm9jy5S7c5V4Dczrr3meBJOyddNip27HVCCCOgthvtb5FLtkxbvF41s
         iGlUzzPGymDg3T5amMQJm6PDCBR7n+L0ahtyEay0NJYWIu7m2vFg6tr2ajT32yaanfBd
         xDtJu+c4X/3CeTjTCyDCOh+jJ9IMVyUrOd4EWhGGuGTa3TWSp3+no8CtHQqAuwI3rWWA
         BuIdQSsCM/Xgm1YsJeGbAazZkNWV/RcrZ3PBFtpntXLtYH4Vrd8FCoda8o0sXcMxI94o
         +OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998187; x=1758602987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=oTT6CJcrZZX5/38ujnuYE2wRcjn5b4ihfpsYmRH5Jjb4+ZsukZ/zE0KFeYVHQyLrvu
         JcIV+vKPLJJODcz863PcFRYldishgBBsvDZ+hjyudQlb0rNbQjVMM1WXSa+Y8AkRipeU
         2FEtx3A2gZza2HjmprL0K6o3J8xl9tNRnVjPwoIzPdUUPnHg7brLJieSvxx3OcYkKzcr
         RSoDuPmMJvRAY5zt0/h6HLYLWV0rUhIX9BIejmjw3hZH6P96GGd238KwL9znKh02hmRF
         9XWqLxki+y5ch31+kLXdfDxmrSPUNdq/MBKeWDNbd0ggI9kGZEuMZFMkXVT57teLliLU
         G6dg==
X-Forwarded-Encrypted: i=1; AJvYcCWo+r7LWPwGPsH0AGeDWqm51uSaHBoMsA7Fz0og878d1Mr3HhcfWF+SWwQ+1G858rNPlJ5qI5FK7yuTZt8d@vger.kernel.org
X-Gm-Message-State: AOJu0Yx667DPy7Xrv+uQKqAdpVduX/NC3q+hrH/Y+nFnpvprk5nWGxRA
	1jxRMb2mtfmW2uafaMNxmbCRtw7hmUf9rAEWF8EsKXYrI5WGQcmRqUwp
X-Gm-Gg: ASbGncsxjTkee/iwTqwFn4qs78m/XKitvKNNBIgAPAN7OIGxg1OLvZvLUe832hDw5rf
	PcQxHvgeSEcTTpMmitwkjiD9iyjRP/I8v67JQ5XGQQofBbJZskjg9QSGaWlUq/LASecsJ/T/uJO
	566IYv1BqbPZ3/o0wkcUsVsXrh1qjWTXjtYupZIhM1i+0JB1rUb9R6DHN1kWW80wDeTo6H+PDop
	mRbo+chSQP3Gr1qqwylmzBCQW1iujYNIz93b8bqT30ozE+e3t2GEjGlVSQmGi08IcvMVcJakQq1
	ToXSwoD+GGDQMEnyoUkhabgjCBC/MH/GvCxMRqbggCGHmdWwoRz3AKfGVIzFVCLO+H7GiSovztC
	n3KZEmKYr3lSbiYNYZmnOnChpWPFeF8vXV3AJsVjbURSGKzyMQA==
X-Google-Smtp-Source: AGHT+IFV4zbzh4iycIfH4WDU92suC0bCanMglT0Ogl2GwpwL8kM68NHrYSygkh1AIkIcAzvJhqwslA==
X-Received: by 2002:a17:903:2f4f:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25d267641camr179941415ad.30.1757998187203;
        Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:46 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	"Toke" <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:35 +0800
Message-Id: <20250916044735.2316171-15-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: "Toke" <toke@toke.dk>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0ac9212e42f7..4a0f465aa2fe 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1993,7 +1993,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 
 	ieee80211_txq_schedule_start(hw, txq->mac80211_qnum);
 	spin_lock_bh(&sc->chan_lock);
-	rcu_read_lock();
 
 	if (sc->cur_chan->stopped)
 		goto out;
@@ -2011,7 +2010,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&sc->chan_lock);
 	ieee80211_txq_schedule_end(hw, txq->mac80211_qnum);
 }
-- 
2.34.1


