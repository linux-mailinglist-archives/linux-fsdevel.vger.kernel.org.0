Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800A83DEB68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhHCLAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 07:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235398AbhHCLAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627988393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3iQKu65eSqhTXq9sE5TsnnrxJkbiW7EY/s4Ku6sw54=;
        b=emEjSfcfb/8oc65VnBQFjgnsqs45hG8VlaESEdd8bR97nOGjEJMfe5G+wQutYZVUbVT8Xk
        hJe/MWeSfErkfdDrgxIdQYQsgp76AiE92ccKXAE+oVYa3BG3FUTfUCxMclOsJClpfcV0AL
        faxBEZ7kxu0fPWD1382MpBRI4qSEZwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-7iMcmDg-Om-quHLQcVjx-w-1; Tue, 03 Aug 2021 06:59:52 -0400
X-MC-Unique: 7iMcmDg-Om-quHLQcVjx-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A001801AEB;
        Tue,  3 Aug 2021 10:59:49 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0ED60C05;
        Tue,  3 Aug 2021 10:59:46 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-s390@vger.kernel.org,
        Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH 1/2] sysctl: introduce new proc handler proc_dobool
Date:   Tue,  3 Aug 2021 12:59:36 +0200
Message-Id: <20210803105937.52052-2-thuth@redhat.com>
In-Reply-To: <20210803105937.52052-1-thuth@redhat.com>
References: <20210803105937.52052-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jia He <hejianet@gmail.com>

This is to let bool variable could be correctly displayed in
big/little endian sysctl procfs. sizeof(bool) is arch dependent,
proc_dobool should work in all arches.

Suggested-by: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Signed-off-by: Jia He <hejianet@gmail.com>
[thuth: rebased the patch to the current kernel version]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index d99ca99837de..1fa2b69c6fc3 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -48,6 +48,8 @@ typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 int proc_dostring(struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dobool(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
 int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dointvec_minmax(struct ctl_table *, int, void *, size_t *, loff_t *);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 272f4a272f8c..25e49b4d8049 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -536,6 +536,21 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
+static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
+				int *valp,
+				int write, void *data)
+{
+	if (write) {
+		*(bool *)valp = *lvalp;
+	} else {
+		int val = *(bool *)valp;
+
+		*lvalp = (unsigned long)val;
+		*negp = false;
+	}
+	return 0;
+}
+
 static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
 				 int *valp,
 				 int write, void *data)
@@ -798,6 +813,26 @@ static int do_proc_douintvec(struct ctl_table *table, int write,
 				   buffer, lenp, ppos, conv, data);
 }
 
+/**
+ * proc_dobool - read/write a bool
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ *
+ * Returns 0 on success.
+ */
+int proc_dobool(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+				do_proc_dobool_conv, NULL);
+}
+
 /**
  * proc_dointvec - read a vector of integers
  * @table: the sysctl table
@@ -1630,6 +1665,12 @@ int proc_dostring(struct ctl_table *table, int write,
 	return -ENOSYS;
 }
 
+int proc_dobool(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 int proc_dointvec(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -3425,6 +3466,7 @@ int __init sysctl_init(void)
  * No sense putting this after each symbol definition, twice,
  * exception granted :-)
  */
+EXPORT_SYMBOL(proc_dobool);
 EXPORT_SYMBOL(proc_dointvec);
 EXPORT_SYMBOL(proc_douintvec);
 EXPORT_SYMBOL(proc_dointvec_jiffies);
-- 
2.27.0

