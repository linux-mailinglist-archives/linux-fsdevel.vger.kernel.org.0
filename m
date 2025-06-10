Return-Path: <linux-fsdevel+bounces-51108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA95AD2CE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2009A18851B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6E25DD12;
	Tue, 10 Jun 2025 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNrrguQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3621442E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749531219; cv=none; b=g7H1LKJb1Fw5rBEB1koY5hvBs9ovGc3z/IquimJ3lYEzMRbIcv7U11RBZ71TCnY/29Eygl4dNN5RlU/t9PWIys0ZIqdfhFFxRonBV2Spk3dunVdWvqdY6Yur1p/WPLxn00nJ7OQzIjoQ6lyKFrfURIOyWG7K/vaetfxCCxsC82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749531219; c=relaxed/simple;
	bh=ntrwLd7DiChheiek1acOeN2aaBmuFDekejGtbIrfXV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkXhtI1x/M1iR2Ac9JCoDqCcZ1cl0ZWM3JIK+ksTw3zaZtEq2mFA0HEnC5ZHE5xP1hAEUFdacCuvvP7dYAnaxSzUWr5FL2uL0nYFHWdwSheuCCSTWtD6OaiF/o6zD6gRh4tvWAy0ySVHKieWGlwZx0+2vWzkQlmZwoTO//TzmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNrrguQ1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2353a2bc210so43280975ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jun 2025 21:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749531217; x=1750136017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTwTABo1wEfKsdA0QXhxKUfxxZtjZaw9y6waPC0Ywhg=;
        b=YNrrguQ1QPnlOESJg4TE2wnfBY5nqmDBR6iN1zhKzXvX5nbC97aQAjGW4Tc/XGhbJB
         sCWhstYEuSu/R1Jjiip2sqDHsJ5E0ppTfc83CYR3VtM1mcLNZ1EFSE8OUb3Ygo4tOmLi
         P6496FA9zp9pdaIYPCf6CX3KjAnm4NVIBvwbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749531217; x=1750136017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTwTABo1wEfKsdA0QXhxKUfxxZtjZaw9y6waPC0Ywhg=;
        b=eFZ1KoZ/CkUMMAqcksc0lOSiVrqrbS0nlDO7zE6fCv0FPcBGiI3TKeRsWi8Wo/rSwo
         ch2JZMG/Pco4YOv4W/YDHxAPhBy5rUPWdNrptPtBQy34pvN8jKOvzxswCPorkt1qSD5L
         WTnknI9aNX1AQJ6Wk5TyXA/oLZWWbNlX55dPsRdoAzlXE0hyVS08pGfGziNuGnzlPHar
         dPVFyhm6AEKJ7R2ZBscG61GRDjMSXEQIDQ/A49T9f47w/+0ma6Swf5bvLV1vHHa7DHBK
         T+58XPOJz6V/F317SYDE/ypPkwAkatBfAGgJaeLR9GnqzmCi/Yj5/hxuy9CcruoS8EHx
         qyHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+0BoGicqgVmaKwaILdomG2ZLl8/+R77xrN9FQaK9oOJJikqC+8o7SZZKk2PlsE52OGLPiiXRcQytsKE6L@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGfXOjDtm6jbutRmKwH1QVBZ13idhrGpLl0E+FiJEniMu2icr
	uKTr4x3s5jO1Nup2ZC7m6QlI5od33rk36rnvRlQL+sl3f8RMaQqwobd66UcWjEcobA==
X-Gm-Gg: ASbGncu3cjqXBtAI2Z97rD/YNomC2BptIkQd6CTxHDStZEGwAjTvXA7P9FCWBliSLaN
	79CA2uqzSKLc5floRu3HeMXusmB14FFqOICdDWFGxPzyk+6ZZxqe6RPw8n9wgBH+WzK2GUF7lEy
	s5ZuaRkop9fPa2aqHSyGrsdDqV+YhJxPdujTtbssI4/5nuxg/2pjAcjGyBWmzgq06rjjdc8YpuZ
	QAPgTI/uad0Ez6RIzuxLKP88B1R5JKHLjSaKS/ppUrh4uMPnEK7hxewzMhyjCGQCqh8kn73DExN
	azzAieXgZqfbZi/CCOxkO+4ecc05UeUuUCxNE6/NraNnFhUDigkv/2L0t+PMJMqJEVFrwt6g4bp
	PxRwY965TTtIRhydgOXUIYX4=
X-Google-Smtp-Source: AGHT+IGeWGyPOn+cNc2ZblDjH7E+UFhg2i8jzNL9EVxXbxCLhGSVXCrWVSYqBS0Ya6OBoPOAb951Iw==
X-Received: by 2002:a17:902:db10:b0:235:91a:2c with SMTP id d9443c01a7336-23601d82d3fmr196518145ad.42.1749531217009;
        Mon, 09 Jun 2025 21:53:37 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ca42:1883:8c66:702e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23611fde09fsm47634705ad.187.2025.06.09.21.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 21:53:36 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/2] sched/wait: Add wait_event_state_exclusive()
Date: Tue, 10 Jun 2025 13:52:28 +0900
Message-ID: <20250610045321.4030262-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows exclusive waits with a custom @state.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v2: switched to wait_event_state_exclusive()

 include/linux/wait.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 327894f022cf..9ebb0d2e422a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -968,6 +968,18 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 		      state, 0, timeout,					\
 		      __ret = schedule_timeout(__ret))
 
+#define __wait_event_state_exclusive(wq, condition, state)			\
+	___wait_event(wq, condition, state, 1, 0, schedule())
+
+#define wait_event_state_exclusive(wq, condition, state)			\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __wait_event_state_exclusive(wq, condition, state);	\
+	__ret;									\
+})
+
 #define __wait_event_killable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
 		      TASK_KILLABLE, 0, timeout,				\
-- 
2.50.0.rc1.591.g9c95f17f64-goog


