Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BEA33DF86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 21:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhCPUui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 16:50:38 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42534 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231679AbhCPUuP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:50:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id CFC0E4128C;
        Tue, 16 Mar 2021 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1615927812; x=
        1617742213; bh=+eOq+PHS71rrOXWV+hY1ea0YXuZgnR7/GhXqiRPzpug=; b=H
        d3bl+N8MiafMUXIdrb2POFMbwj+ePslFii74AWjYGbR0S3AbUHKZ15E9dwcE1XYi
        mmMj0SskBwZpVV8GifXv7F0Ww1qIX21xjj8ukxVyw1pp3Ycz/UIoyznv8oWDou7N
        9mZgkU0kxyYbaCSJMguNe/o5U8goWnByqRdNCY/sF8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N5pr4pb3jJsa; Tue, 16 Mar 2021 23:50:12 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id DB06D4127A;
        Tue, 16 Mar 2021 23:50:09 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.78) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 16
 Mar 2021 23:50:09 +0300
From:   <m.malygin@yadro.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <r.bolshakov@yadro.com>, <yangyicong@hisilicon.com>,
        <linux@yadro.com>, Mikhail Malygin <m.malygin@yadro.com>
Subject: [PATCH] Revert "libfs: fix error cast of negative value in simple_attr_write()"
Date:   Tue, 16 Mar 2021 23:49:39 +0300
Message-ID: <20210316204939.39812-1-m.malygin@yadro.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.78]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mikhail Malygin <m.malygin@yadro.com>

This reverts commit 488dac0c9237647e9b8f788b6a342595bfa40bda.

An established and documented [1] way of of configuring unlimited number of failures in fault-injection framework is to write -1:

- /sys/kernel/debug/fail*/times:

 specifies how many times failures may happen at most.
 A value of -1 means "no limit".

Commit 488dac0c92 inadverently breaks that.

1. https://www.kernel.org/doc/Documentation/fault-injection/fault-injection.txt

Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
Signef-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 fs/libfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e2de5401abca..9bea71111299 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -961,7 +961,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos)
 {
 	struct simple_attr *attr;
-	unsigned long long val;
+	u64 val;
 	size_t size;
 	ssize_t ret;
 
@@ -979,9 +979,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;
 
 	attr->set_buf[size] = '\0';
-	ret = kstrtoull(attr->set_buf, 0, &val);
-	if (ret)
-		goto out;
+	val = simple_strtoll(attr->set_buf, NULL, 0);
 	ret = attr->set(attr->data, val);
 	if (ret == 0)
 		ret = len; /* on success, claim we got the whole input */
-- 
2.24.3

