Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DE44B43D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 21:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbhKIUtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 15:49:53 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:33712 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234878AbhKIUtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:49:51 -0500
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 15:49:50 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=WArqkDtu5W1DQIOZg6AY0uLA7OKIXkUD3kbNB9gSEbo=;
        b=Qzlp7TLRgXgDaisYpJr22SvCHecuDcA9IG1lh74ZDfzrJv0E7iJEhLwMlC5N8P2LZwRNWztVoV+UHoWOv2/0dT1SJccI2Au0veyf4dhxiMUmMIfP/2UwlwOxi5HwldblBtVhLjY76ETUfEPCy6RqqS1rq9YwsoN0IHJfmJ6zos6l0ySbRVM5zGBn4cSAb6raeB036ce2Oh7KimRSCGdgFpo4KaoshJsAUaV/ieZP6S0Niwdu4jhM6smh1170Tf7V7jFJvSgjY5ytFnlttOwI+1Wos35qE+becR6oXWAd7CMbWoJznnWMSqXemOG2XWblgfATmnifWUpvsF8cwlbFWw==;
Received: from 201-95-14-182.dsl.telesp.net.br ([201.95.14.182] helo=localhost)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1mkXlF-0000Lh-QE; Tue, 09 Nov 2021 21:30:30 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net, gpiccoli@igalia.com
Subject: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in panic_print
Date:   Tue,  9 Nov 2021 17:28:47 -0300
Message-Id: <20211109202848.610874-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109202848.610874-1-gpiccoli@igalia.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the "panic_print" parameter/sysctl allows some interesting debug
information to be printed during a panic event. This is useful for example
in cases the user cannot kdump due to resource limits, or if the user
collects panic logs in a serial output (or pstore) and prefers a fast
reboot instead of a kdump.

Happens that currently there's no way to see all CPUs backtraces in
a panic using "panic_print" on architectures that support that. We do
have "oops_all_cpu_backtrace" sysctl, but although partially overlapping
in the functionality, they are orthogonal in nature: "panic_print" is
a panic tuning (and we have panics without oopses, like direct calls to
panic() or maybe other paths that don't go through oops_enter()
function), and the original purpose of "oops_all_cpu_backtrace" is to
provide more information on oopses for cases in which the users desire
to continue running the kernel even after an oops, i.e., used in
non-panic scenarios.

So, we hereby introduce an additional bit for "panic_print" to allow
dumping the CPUs backtraces during a panic event.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 Documentation/admin-guide/sysctl/kernel.rst     | 1 +
 kernel/panic.c                                  | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0905d2cdb2d5..569d035c4332 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3690,6 +3690,7 @@
 			bit 3: print locks info if CONFIG_LOCKDEP is on
 			bit 4: print ftrace buffer
 			bit 5: print all printk messages in buffer
+			bit 6: print all CPUs backtrace (if available in the arch)
 
 	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
 			Format: <hex>[,nousertaint]
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 70b7df9b081a..1666c1a9dbba 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -796,6 +796,7 @@ bit 2  print timer info
 bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
 bit 4  print ftrace buffer
 bit 5: print all printk messages in buffer
+bit 6: print all CPUs backtrace (if available in the arch)
 =====  ============================================
 
 So for example to print tasks and memory info on panic, user can::
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..5da71fa4e5f1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -65,6 +65,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_LOCK_INFO		0x00000008
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
 #define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
+#define PANIC_PRINT_ALL_CPU_BT		0x00000040
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -151,6 +152,9 @@ static void panic_print_sys_info(void)
 	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
 		console_flush_on_panic(CONSOLE_REPLAY_ALL);
 
+	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+		trigger_all_cpu_backtrace();
+
 	if (panic_print & PANIC_PRINT_TASK_INFO)
 		show_state();
 
-- 
2.33.1

