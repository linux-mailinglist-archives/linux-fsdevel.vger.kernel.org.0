Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4426A176199
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCBRvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 12:51:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38825 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgCBRvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:51:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id u9so210358wml.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Kx8nmukttqpHZuRHsPDhtzyv3nWI/Y/L038RHlsnVE=;
        b=cY3FpIMeyInIz2doBDLxFNAFHqc1qD0znP6ZLavRTpcOQcgXbOs42hRxp/v3oCNQTC
         gNZMqt0kIvodHf6h1byZ/YfxeVdI9edWJH/rNJ/eiwnWkhz+WE7JsS/+QuczW+PrTEEb
         C94HRXntlxPyf8uzT1p4+Lfr7XHukd6lFAJR/rsjNyAKcZ0IsnYXOBQeNuXiVlRf+AVA
         wW4ydVDlTj89sbZMiF9VnmL2IBus+WHKWJ5p1UDZ2Ayixu/1FOoAwOxAFUaF4R0JuCKm
         QnjRugMytS0vjHaljWCNKaJdIPUYkY+eFg1UxLq0EIj16qbO2eXh7HGtIUeu4FvsPGj3
         /C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Kx8nmukttqpHZuRHsPDhtzyv3nWI/Y/L038RHlsnVE=;
        b=DjWchE732GV32D4IQBY1wXlYX699hwcpQtmXVVqONwcAaiQy1L6xOEGA25V9OifLSM
         v9aVgS9JRvsewJDwTyGhT853DEUP+2A4Q57yXYkP6EQZAJa/1/HZCAoWFybzKt1v5k9U
         ohaGu8XHBy8OjNkvvF4xGQ32Y+SAEnIjoI5qroFRN9lRo7HsG0woEUK1F6AWgCqOkQJw
         r+uAWNimVSslxE7IJ/kcEez2a4ad0LHVCQimzGh2TBkbie2ZFkLpakwjhX1qZap2Wu4l
         zZaUqR0IRD5KdyoH1uPDmGHfQb1zbi7tzMxu7dF+NgTsKQwv2wlRwKsaU9sd5mZuLqBf
         yr9Q==
X-Gm-Message-State: ANhLgQ1Yyw+5Iaa1ZQmbqvNTegHY9WxzYwrIbt9zTajRzIHwA19g9doZ
        ByOeQjh4+3YK3ldB5t6+1rBtNQ==
X-Google-Smtp-Source: ADFU+vtgPa2Arj/pPLh1i+Bqz7hGA3XBaKwKSk813DrexkuAYMePD9J51tk5ngXW0YRa/3R5XgCfXg==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr238182wmj.0.1583171503168;
        Mon, 02 Mar 2020 09:51:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b10sm163234wmh.48.2020.03.02.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:51:42 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHv3 1/2] sysctl/sysrq: Remove __sysrq_enabled copy
Date:   Mon,  2 Mar 2020 17:51:34 +0000
Message-Id: <20200302175135.269397-2-dima@arista.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302175135.269397-1-dima@arista.com>
References: <20200302175135.269397-1-dima@arista.com>
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
getter-helper sysrq_mask() to check sysrq_key_op enabled status.

Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c   | 12 ++++++++++++
 include/linux/sysrq.h |  7 +++++++
 kernel/sysctl.c       | 41 ++++++++++++++++++++++-------------------
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f724962a5906..5e0d0813da55 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -63,6 +63,18 @@ static bool sysrq_on(void)
 	return sysrq_enabled || sysrq_always_enabled;
 }
 
+/**
+ * sysrq_mask - Getter for sysrq_enabled mask.
+ *
+ * Return: 1 if sysrq is always enabled, enabled sysrq_key_op mask otherwise.
+ */
+int sysrq_mask(void)
+{
+	if (sysrq_always_enabled)
+		return 1;
+	return sysrq_enabled;
+}
+
 /*
  * A value of 1 means 'all', other nonzero values are an op mask:
  */
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 8c71874e8485..8e159e16850f 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -50,6 +50,7 @@ int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
 
 int sysrq_toggle_support(int enable_mask);
+int sysrq_mask(void);
 
 #else
 
@@ -71,6 +72,12 @@ static inline int unregister_sysrq_key(int key, struct sysrq_key_op *op)
 	return -EINVAL;
 }
 
+static inline int sysrq_mask(void)
+{
+	/* Magic SysRq disabled mask */
+	return 0;
+}
+
 #endif
 
 #endif /* _LINUX_SYSRQ_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..94638f695e60 100644
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
@@ -2835,6 +2818,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
 }
 #endif
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static int sysrq_sysctl_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int tmp, ret;
+
+	tmp = sysrq_mask();
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
2.25.0

