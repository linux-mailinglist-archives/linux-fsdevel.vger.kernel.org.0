Return-Path: <linux-fsdevel+bounces-63092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A66BABC8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59AE188D77C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6A23496F;
	Tue, 30 Sep 2025 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ROgqAboI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E91EBA14
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216715; cv=none; b=ih1wjaBYt60a2/HIazZkw/V6WTOAGkRWLQVLL/FONtA6SsoaZp3huhOMr7taOjvCqFfbKNJ5Zp2FrxmcpoZIr64dGw4HfXCsGBdCupFtWGLg99x8uBQF/mQlgXjKMaEDBnzdlp22Kb5EuDK7yw6sNGG4+ttd54NcIT2zno0vYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216715; c=relaxed/simple;
	bh=ipW6bez6xeZyseUzGg/sOnqrVK201ykI3jc3dRKB/EQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6iPQYRJdpV8tmvpKdoW2U7w5lzZ7yZa+vgPxm1ZIJsi5cff4VPK0vIknvNy9jlrsUVICtOoW/stqa8zQFFP2rsEWQRhmaK1DaskVhaYC/MQfWiye1uvkThZ+h+hot6zpQj4IPj7zHdLpfrBRPSbHDGAmPhV/aRU7rpuX0gF9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ROgqAboI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5579235200so4009375a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759216713; x=1759821513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVcRBfHozAxdIH41rLvR/iw0xPOSU56Ftb6zODUXgk4=;
        b=ROgqAboI/itiZAelyruLWyZ2myBj3vQk+Gkw83iu8RDOzLWcSp3CYAkqtbZOtqUx58
         2kzFOWu3jaA8sRxtPceiOdDq39rdotIrD1yVsQD5uvRra6q+9Gva6/5eQyHSmH5DwKD+
         jR7HvamZqJdbYXYeGbE1LJFXS6jj/TIXBun/x9aYWKS4p99s036HlNSyWNORNxyKKKg8
         frehF3wHziGwtJwl6GLI7741OHQkcemyT4gezVPRS0ANo7kCx4YDUrnElwnJoQvldSIC
         726y1eO89wTG4uRzxw7rrJX3tPZ61TPSikKr2i/5pjhdic1gj99z7S1jInYNmhghNQwQ
         U6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216713; x=1759821513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVcRBfHozAxdIH41rLvR/iw0xPOSU56Ftb6zODUXgk4=;
        b=unXkKRUc2Ujh6bFr36zybQhV6BSkI8YSPyqZwlhafO4c5AfCXy9RGnG7HVK1WXWvxQ
         Rvqll01+58Pf/zIt0gZvOFOkSUn+28KIRGmowuNjk0jghhyd6amrz476FzDWEYGM+8UC
         YzM2UdESwCe5qOgeZ8rUfKTa/NWkUGHhvD4h35OILZoanS7CU5E5qJ6Gg/eymBraET/v
         RHKt0VYJ28wvI3tFOnhGeopVfRwZeeA32+K1iFcFj2w9RfUKkkEW/1uXvVRZyU9fwdAP
         LnI+VdYo8qGD5W53+g0SCN2NPGaALw7X8m+/bRAV6dvNnRN8PTxK7veiYFrHgSzn/GtE
         ycdA==
X-Forwarded-Encrypted: i=1; AJvYcCVRuSztiLY4EJdPnZSaiPNn9ZrgnD2N7ECmtHz8t19RYSIBhl6xlK0wh4nKQg8DyAB6xnKwsQGIcCK85tvg@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJKmz5qbB4JHsZ2hFgD+9mFl4ncyOZ/B+FX5SjBeLEOjauwts
	I/dUe7k5uUIbOBlvr3WCcmMZkC1Om5aJN4+U4soot6b0f59NKtD0cJ66NzkICaOFZvc=
X-Gm-Gg: ASbGncsMCmcGLo8jKofGHzqbaTHyNjcebWR2qB36CTef86YEX7PkohOZprbatLqTeuY
	XPuPM/HLeJ+1Z8hkoTkFNYTeRIR0aAt0IJzajJYExxDIpsBx2FVdb5qGTU9ZwflzFRZUsmL7ZBg
	aPF/OelSoDTJo91WjA7oy9rL7q1ysnXgH73Oxdol6KncmN4F1JCyUNul4IFtQ7sMVNHfcMEeDME
	+2jrlOES2rXImY99+oZeMc+wq8HWMRCPz8HQi+b0ymG32Kjurzw4Ko7IzdH41gAZQKIDsVMGDkQ
	9i7U/vljUWYz0xCRKhUgtZH89bc2ipNEKLpwFlWC+b8S5oibJOgzZoIpKCdJxAttINaGi8xWPq6
	6VMmb/waglqDKtyMvdkBKzLNBTD5rorOPl6W3ZiCq7k1yBMOpHj3fp47cTg==
X-Google-Smtp-Source: AGHT+IH1yhfyTy56jpcFtEfQ+PO+uYSH8CgqF0ACOBc247/uOjGOLjnebzQDO7EqDUDGB6Io2gSElw==
X-Received: by 2002:a17:90b:4d08:b0:32b:6cf2:a2cf with SMTP id 98e67ed59e1d1-3342a3e634dmr21670819a91.14.1759216712838;
        Tue, 30 Sep 2025 00:18:32 -0700 (PDT)
Received: from localhost ([106.38.226.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90367sm19079026a91.5.2025.09.30.00.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:18:32 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: sunjunchao@bytedance.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v3 2/2] writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)
Date: Tue, 30 Sep 2025 15:18:29 +0800
Message-Id: <20250930071829.1898889-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930065637.1876707-1-sunjunchao@bytedance.com>
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a writeback work lasts for sysctl_hung_task_timeout_secs, we want
to identify that there are tasks waiting for a long time-this helps us
pinpoint potential issues.

Additionally, recording the starting jiffies is useful when debugging a
crashed vmcore.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
Changes in v3:
 * Show blocked task info instead of BDI info as Jan suggested.

Changes in v2:
  * rename start to wait_stamp
  * init wait_stamp in wb_wait_for_completion()

 fs/fs-writeback.c                | 17 +++++++++++++++--
 include/linux/backing-dev-defs.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 61785a9d6669..4b54189f27ac 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -201,6 +201,19 @@ static void wb_queue_work(struct bdi_writeback *wb,
 	spin_unlock_irq(&wb->work_lock);
 }
 
+static bool wb_wait_for_completion_cb(struct wb_completion *done)
+{
+	unsigned long waited_secs = (jiffies - done->wait_start) / HZ;
+
+	done->progress_stamp = jiffies;
+	if (waited_secs > sysctl_hung_task_timeout_secs)
+		pr_info("INFO: The task %s:%d has been waiting for writeback "
+			"completion for more than %lu seconds.",
+			current->comm, current->pid, waited_secs);
+
+	return !atomic_read(&done->cnt);
+}
+
 /**
  * wb_wait_for_completion - wait for completion of bdi_writeback_works
  * @done: target wb_completion
@@ -213,9 +226,9 @@ static void wb_queue_work(struct bdi_writeback *wb,
  */
 void wb_wait_for_completion(struct wb_completion *done)
 {
+	done->wait_start = jiffies;
 	atomic_dec(&done->cnt);		/* put down the initial count */
-	wait_event(*done->waitq,
-		   ({ done->progress_stamp = jiffies; !atomic_read(&done->cnt); }));
+	wait_event(*done->waitq, wb_wait_for_completion_cb(done));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 1057060bb2aa..fd71340e5562 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -64,6 +64,7 @@ struct wb_completion {
 	atomic_t		cnt;
 	wait_queue_head_t	*waitq;
 	unsigned long progress_stamp;	/* The jiffies when slow progress is detected */
+	unsigned long wait_start;	/* The jiffies when waiting for the writeback work to finish */
 };
 
 #define __WB_COMPLETION_INIT(_waitq)	\
-- 
2.39.5


