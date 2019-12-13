Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34311DAC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 01:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfLMAKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 19:10:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36801 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbfLMAKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:10:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so349795pjc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 16:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6k/XsfzhDn6KXF2YNucRafsHSbYJhqsQlalXy2nyck=;
        b=K+xG7jANOc30B1qy0sA9C/z0h4E5ePwM5GFfoIGPnu9nl+/4mBgnMANkmOqnPZbJox
         tqm5qlXHxYwvClPuUmaAqbcZ+usjxQebBR2aTkGRmviET9XCPZBOxgyQSAJXxEcjgSI4
         f6hb2uXboXB40Ciaw4PmzGqWfoAcvEdsjEBqZ9Bvlm1bdSaZe5UTS1c/VRxn58Buff9+
         kUefb2N/l+pMhFH11NpwkVTc9X/EP/+uHwgweGAi8fHIOtp9ItYdSoxISQNLaQRXEiDL
         PtLmhOnfhpBsk6SG1wOCliWp8gFThFKKkSE5Oylcf4fGLM7Ybgy7VSwkMRjUqlho6Hr2
         54Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6k/XsfzhDn6KXF2YNucRafsHSbYJhqsQlalXy2nyck=;
        b=c+KT9TIEfQvBbpktNO/Puv7osxxDRYNgLzwG66LeOdtkJNsG8P/ucmWVDBMoptZPsS
         zGZUi50WADKFFrnU5b+gzZSHQPVpWJAGrh3FgeaypFS8ZM60FMlT/ekXiRyY2kSnx/i1
         abU55YL9KU1FCK3DaSGS7PTcG135bzEUGa6t2YZiBM15wpB3Sd0KDomd0mNQVFcqyUgn
         zw6Pet9AB9Y4rQeUTLSjsvIWHJOvIwx56FHZGV4T+05qZ5JXNUdXxqGBAhKKnsjHji9E
         fWwrsvJxeUNQfycexyBwqmGJF9GmuBu1EV9QieEUEPv6NecRHK8/epfOcc+nbX815R9V
         NANQ==
X-Gm-Message-State: APjAAAVnYk/LCYKbzvprJnWxIUqFtUPkfTt55csTux2IeTuFWxMTdH0C
        LahYP4cfXhaUMZqCJy9Faml4fw==
X-Google-Smtp-Source: APXvYqxuqRpAz7tC5HM3+JXEiYaZ3fe2a3UXXUDB8NRiz+qOZzLZ1p3vGqYYh80eng3ApFiB+cBJiA==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr3882460plp.135.1576195803960;
        Thu, 12 Dec 2019 16:10:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:10:03 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 57/58] sysctl/sysrq: Remove __sysrq_enabled copy
Date:   Fri, 13 Dec 2019 00:06:56 +0000
Message-Id: <20191213000657.931618-58-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many embedded boards have a disconnected TTL level serial which can
generate some garbage that can lead to spurious false sysrq detects.

Currently, sysrq can be either completely disabled for serial console
or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")

At Arista, we have such boards that can generate BREAK and random
garbage. While disabling sysrq for serial console would solve
the problem with spurious false sysrq triggers, it's also desirable
to have a way to enable sysrq back.

Having the way to enable sysrq was beneficial to debug lockups with
a manual investigation in field and on the other side preventing false
sysrq detections.

As a preparation to add sysrq_toggle_support() call into uart,
remove a private copy of sysrq_enabled from sysctl - it should reflect
the actual status of sysrq.

Furthermore, the private copy isn't correct already in case
sysrq_always_enabled is true. So, remove __sysrq_enabled and use a
getter-helper for sysrq enabled status.

Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c   |  7 +++++++
 include/linux/sysrq.h |  1 +
 kernel/sysctl.c       | 41 ++++++++++++++++++++++-------------------
 3 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1d4f317a0e42..c21067765091 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -73,6 +73,13 @@ static bool sysrq_on_mask(int mask)
 	       (sysrq_enabled & mask);
 }
 
+int sysrq_get_mask(void)
+{
+	if (sysrq_always_enabled)
+		return 1;
+	return sysrq_enabled;
+}
+
 static int __init sysrq_always_enabled_setup(char *str)
 {
 	sysrq_always_enabled = true;
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 8c71874e8485..4a0b351fa2d3 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -50,6 +50,7 @@ int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
 
 int sysrq_toggle_support(int enable_mask);
+int sysrq_get_mask(void);
 
 #else
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 70665934d53e..66cebf6041b4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -229,25 +229,8 @@ static int proc_dopipe_max_size(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp, loff_t *ppos);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-/* Note: sysrq code uses its own private copy */
-static int __sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
-
 static int sysrq_sysctl_handler(struct ctl_table *table, int write,
-				void __user *buffer, size_t *lenp,
-				loff_t *ppos)
-{
-	int error;
-
-	error = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (error)
-		return error;
-
-	if (write)
-		sysrq_toggle_support(__sysrq_enabled);
-
-	return 0;
-}
-
+			void __user *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 static struct ctl_table kern_table[];
@@ -747,7 +730,7 @@ static struct ctl_table kern_table[] = {
 #ifdef CONFIG_MAGIC_SYSRQ
 	{
 		.procname	= "sysrq",
-		.data		= &__sysrq_enabled,
+		.data		= NULL,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= sysrq_sysctl_handler,
@@ -2844,6 +2827,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
 }
 #endif
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static int sysrq_sysctl_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int tmp, ret;
+
+	tmp = sysrq_get_mask();
+
+	ret = __do_proc_dointvec(&tmp, table, write, buffer,
+			       lenp, ppos, NULL, NULL);
+	if (ret || !write)
+		return ret;
+
+	if (write)
+		sysrq_toggle_support(tmp);
+
+	return 0;
+}
+#endif
+
 static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int write,
 				     void __user *buffer,
 				     size_t *lenp, loff_t *ppos,
-- 
2.24.0

