Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EAF599A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbfKHVQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 16:16:31 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:58299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfKHVQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:16:31 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4JVv-1iSuV33qcL-000H5U; Fri, 08 Nov 2019 22:16:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/23] y2038: timerfd: Use timespec64 internally
Date:   Fri,  8 Nov 2019 22:12:15 +0100
Message-Id: <20191108211323.1806194-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f99ERCJnaEP6l1FjibSXxcsOLJa++GmL0I70TNMWQOU34Uv4PDX
 4k8qz4hBKqfkFDCXzllbDhvO4JPGsO4Gyq0ZmO2QqnY5gw94EUNCLWlqFqVqavgc4qxeQOy
 1Vm9PZMeYtelGu9Cd9ZSuw+suaPXoCYxh2IF8qUpjaSvm57fdogUtXtLxVNtn/k+dTYz/qq
 5G4Oue57/1o4PI/8aR1KA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OkS73SaoqFM=:S+wceWhB+XNIMJ5HNqWit5
 Q3+TZe+gn6GOOFrvUfbvpDgm0Hhkc+dotB+2We9f20vQcgSdkXSa50DZXK0YA4mzI89+fC5nB
 cLo8flDUnLvtMmYSmqres7JtqLmpQFpZX8cj070PDVFCkebnoszEa5034Y8FW6eu9PH4e0gj4
 2zxiOCWw+Bx2BjpBhiuJC4jRoNbakTqLFqlw+ULkkUL7YD7Z/nKB3RKpkWBdJ9ALo9/w3qupN
 xBnCoDpVkjSSx24S5136GIctdOgTIAUCoxx0cu36TIO6pTnhH3kAA+H+14GcMaSrY5FKbtnkr
 JcDCBpKiNRGOrlvSfHe14Ctrl3c4Gg8hiU8j00U/kqDmWwEd1MW14NyzcNJVyCxB+5HW/U/wA
 COp6thxQBXwYUmqGskKaqH3myKOMgSKwk3HoL56m71vcePLblIy5QZJCBiLnw2XfC46MBoWYx
 1BMdaCnB0f+fWDWCn9qRdW+WXHDqJf+UASmsbn6o5UJKJNM3E4eWosOg+f4yqG8Yq7wRAtfK2
 Khhhge+dZhERKGj9Qm6tVOJjrHbHYM7e/llhGOX3dZy4XOIhYzDKndv+bBKr1zKYKKNa/SR4y
 UBxbe6qY/Xvj7P7deT3+XrTIeG76lTaXqn1Oqpc1jhSEvEqucK8FrZfYRO2kfLT60cw+XgFX2
 YlugG/Wky/czeO/7hd+wNB2V/9fSpapLTiP9Rk+0uiYjhk9Xukk2XNtHAZljSOtsNBZfayOXQ
 QC2oDE4+CAReHgKBjYHnoomccIouL9Ib8ssHuwDd6Dvr56Aymrc7VKz3xvxy4GYp3FdVh5S7m
 OXtwykXFhcmiy8Kr8PxH9WXJ8x3oju+NozZ8bMGVzuthp/ZUuEb77ViqksNFBaj3edaowHO7I
 LqNutc85Y4X02TS+66GQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

timerfd_show() uses a 'struct itimerspec' internally, but that is
deprecated because of the time_t overflow and a conflict with the glibc
type of the same name that is now incompatible in user space.

Use a pair of timespec64 variables instead as a simple replacement.

As this removes the last use of itimerspec from the kernel, allowing the
removal of the definition from the uapi headers along with timespec and
timeval later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/timerfd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 48305ba41e3c..ac7f59a58f94 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -302,11 +302,11 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
 static void timerfd_show(struct seq_file *m, struct file *file)
 {
 	struct timerfd_ctx *ctx = file->private_data;
-	struct itimerspec t;
+	struct timespec64 value, interval;
 
 	spin_lock_irq(&ctx->wqh.lock);
-	t.it_value = ktime_to_timespec(timerfd_get_remaining(ctx));
-	t.it_interval = ktime_to_timespec(ctx->tintv);
+	value = ktime_to_timespec64(timerfd_get_remaining(ctx));
+	interval = ktime_to_timespec64(ctx->tintv);
 	spin_unlock_irq(&ctx->wqh.lock);
 
 	seq_printf(m,
@@ -318,10 +318,10 @@ static void timerfd_show(struct seq_file *m, struct file *file)
 		   ctx->clockid,
 		   (unsigned long long)ctx->ticks,
 		   ctx->settime_flags,
-		   (unsigned long long)t.it_value.tv_sec,
-		   (unsigned long long)t.it_value.tv_nsec,
-		   (unsigned long long)t.it_interval.tv_sec,
-		   (unsigned long long)t.it_interval.tv_nsec);
+		   (unsigned long long)value.tv_sec,
+		   (unsigned long long)value.tv_nsec,
+		   (unsigned long long)interval.tv_sec,
+		   (unsigned long long)interval.tv_nsec);
 }
 #else
 #define timerfd_show NULL
-- 
2.20.0

