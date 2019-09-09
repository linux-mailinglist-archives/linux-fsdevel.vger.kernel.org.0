Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD765AD6BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbfIIKYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:24:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51768 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390681AbfIIKX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so3500761wme.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNRbbp8G8eTiBWYxO3vdxym/3OjnixNj+aS47nL+0BI=;
        b=hdrHIIyjAT+k8oXsgByuk1ULYIDO+Lqvl8Os8lSPNmqm+S5M/kr39Eu+i1bqKs0oqE
         GbyGOXmIcEeO7lx6L7xndSmFNg19q/AHrkqXIniqCq9qxVfhEa5MWCqCMP6aCSbmGOFY
         JI/eilxR5hDviGih9niYE5XoqIVGnwXZsTAwI2SeDmpFAijfmaRJIlmGFM9B5VOtST/N
         8EJqVLfAj+4vORTmeH6VlvR5DN9zKPAqS4ZdYzpmdRI5HelsEGQcfB0teFgEQ9eI6D4D
         HYGMrzj/9sxZHkiVXR2V0dR0nlWucvdBRwj/BFZ7F88N7t09MdvMgmMxKNQcdCB2lG6E
         v7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNRbbp8G8eTiBWYxO3vdxym/3OjnixNj+aS47nL+0BI=;
        b=e/yL/6m0YEBDkwVlJRbwkY7KuWzlclBz5tt1Jac0sfEHGaC3BB5p7iMscl2LNLQson
         fSXFgTAlRfYbQyPBvtR7YAxE4BaCwpGj82BBbBWYxFKVavQ/QxpydV1SkUuhv6TJmziH
         0RFMyNUgMUwhz+/9bzmA18nuHZtpB9EPylFNJe+Vi9LuriP7Txeq8T1+gc2RmITi90SA
         fqvMAEHBCmOHoGqWcYeEFLiRNZ+JrWC1j7oOl3PmxCx7xA/HeGHy5OZr6XOCzYtqenRr
         ng+86yUsuFZ1lLialjEoDyGd7KjWVomAGcTuFrka+ANyD/DetvUnV84T7PweLnwoC+Zy
         Hgdw==
X-Gm-Message-State: APjAAAX8j9vjTZYvACo3QkwoNXMQRXcobmlXtCPv4+c7+Z2x3t+Lelyy
        fVs+lq1A0psfBe2nTNZWx9fkbQ==
X-Google-Smtp-Source: APXvYqxZzvWmASuH6w4UTwekMD7soXRGZno3Iw5SFEGT0uhY8x9yZWUYfyFpI1sm8te4R9c2x47VEA==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr17778107wmk.13.1568024634967;
        Mon, 09 Sep 2019 03:23:54 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] select/restart_block: Convert poll's timeout to u64
Date:   Mon,  9 Sep 2019 11:23:39 +0100
Message-Id: <20190909102340.8592-9-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All preparations have been done - now poll() can set u64 timeout in
restart_block. It allows to do the next step - unifying all timeouts in
restart_block and provide ptrace() API to read it.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c                   | 27 +++++++--------------------
 include/linux/restart_block.h |  4 +---
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 4af88feaa2fe..ff2b9c4865cd 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1001,14 +1001,9 @@ static long do_restart_poll(struct restart_block *restart_block)
 {
 	struct pollfd __user *ufds = restart_block->poll.ufds;
 	int nfds = restart_block->poll.nfds;
-	ktime_t timeout = 0;
+	ktime_t timeout = restart_block->poll.timeout;
 	int ret;
 
-	if (restart_block->poll.has_timeout) {
-		timeout = ktime_set(restart_block->poll.tv_sec,
-				    restart_block->poll.tv_nsec);
-	}
-
 	ret = do_sys_poll(ufds, nfds, timeout);
 
 	if (ret == -ERESTARTNOHAND) {
@@ -1021,14 +1016,12 @@ static long do_restart_poll(struct restart_block *restart_block)
 SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		int, timeout_msecs)
 {
-	struct timespec64 end_time;
 	ktime_t timeout = 0;
 	int ret;
 
 	if (timeout_msecs >= 0) {
-		poll_select_set_timeout(&end_time, timeout_msecs / MSEC_PER_SEC,
-			NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC));
-		timeout = timespec64_to_ktime(end_time);
+		timeout = ktime_add_ms(0, timeout_msecs);
+		timeout = ktime_add_safe(ktime_get(), timeout);
 	}
 
 	ret = do_sys_poll(ufds, nfds, timeout);
@@ -1037,16 +1030,10 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		struct restart_block *restart_block;
 
 		restart_block = &current->restart_block;
-		restart_block->fn = do_restart_poll;
-		restart_block->poll.ufds = ufds;
-		restart_block->poll.nfds = nfds;
-
-		if (timeout_msecs >= 0) {
-			restart_block->poll.tv_sec = end_time.tv_sec;
-			restart_block->poll.tv_nsec = end_time.tv_nsec;
-			restart_block->poll.has_timeout = 1;
-		} else
-			restart_block->poll.has_timeout = 0;
+		restart_block->fn		= do_restart_poll;
+		restart_block->poll.ufds	= ufds;
+		restart_block->poll.nfds	= nfds;
+		restart_block->poll.timeout	= timeout;
 
 		ret = -ERESTART_RESTARTBLOCK;
 	}
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index e66e982105f4..63d647b65395 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -49,11 +49,9 @@ struct restart_block {
 		} nanosleep;
 		/* For poll */
 		struct {
+			u64 timeout;
 			struct pollfd __user *ufds;
 			int nfds;
-			int has_timeout;
-			unsigned long tv_sec;
-			unsigned long tv_nsec;
 		} poll;
 	};
 };
-- 
2.23.0

