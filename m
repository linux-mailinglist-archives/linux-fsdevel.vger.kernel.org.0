Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA3352281
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 00:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhDAWNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhDAWNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:13:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B433C0613AE
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 15:13:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so3797164pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMK0dD8EUOpMnQqN+YrkNT1KRoH/Rg1BtnXVKHHSQEw=;
        b=FEec6d8j783rUOlGRor6Ix55R/XeyADTFdyGebVpwODs8v1VbT6NPeGTU2Qx0NfqO1
         cqoQ61LHpuaCaEhG9PjflLvPT65ZFGaHAGbsh5qoS7O1Myj2BzX6ZJ5cjjdjdDLHsiUW
         1gTCOMrrPCvEjDpAdKV0c4o5xE1uVaitI2elI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMK0dD8EUOpMnQqN+YrkNT1KRoH/Rg1BtnXVKHHSQEw=;
        b=HEAPdvafyKl9RGfvqnxBiI9S19e3m1mq1Ljii8J4AyutngRX4gBcXBQOGN7wvlpDA3
         glerSt+oOOus6QjnTLTpnsY0C+ZpWH0ZBhezea1Zlox0wKFLNPc34lSaLNlSY9ftjayT
         GCxz7JmDHmJHE15Y9wootQLVri44Erxo574HROFTs6ULzy3YJLEfR5Bahn5FLN8ot8/h
         8chqpmtqIvl0cf1fIBsq0CoX0C7uP4xPKItSn1AA/odGJ1lU/RKTWb1vFfAoofw5Jq6b
         qw3LXpRBGqAZP38NZmyrxePBK2t5Cz/1WJBII7eVS6wOcjVfeA+/PnBJS7bg/2AwUPCH
         Nigg==
X-Gm-Message-State: AOAM5331kG8qHxanLLa3Jq9l1niOO7O0j6XisQDU3UWhtnjhN6afOjlE
        5UcVxkoNLCxuk43m2BypqEcftA==
X-Google-Smtp-Source: ABdhPJz+He35I/mX8zgLQgen2hel8CVQVyy/0OetIdnt55DRJtYU9oNFtDNxLJhw0IJRLu0nNB5p8Q==
X-Received: by 2002:a17:902:aa0c:b029:e5:da5f:5f66 with SMTP id be12-20020a170902aa0cb02900e5da5f5f66mr9806341plb.81.1617315210147;
        Thu, 01 Apr 2021 15:13:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 186sm6655069pfb.143.2021.04.01.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:13:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4 3/3] sysfs: Unconditionally use vmalloc for buffer
Date:   Thu,  1 Apr 2021 15:13:20 -0700
Message-Id: <20210401221320.2717732-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401221320.2717732-1-keescook@chromium.org>
References: <20210401221320.2717732-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=c5db4de46e2fb011df00756d4f9e98c350db4340; i=MEvu9Y2iWCN6KW+GL93HEcZTxkhRtLohrU2GVi3yOA0=; m=B8J2zz7Y7XtsJeOjLQdM8fQ2tr4ToEl/kdZtP2sPkVo=; p=RMI7dJzQuU2ORbbN3pLYdhsh2IhVTz/8JKubIRzXcE8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBmRX8ACgkQiXL039xtwCaYSQ/9G7W veN/zfdOwGX1mTnL3JETf/YN7qmk/i17DV9sk+90V2GFpMrZd4mCP6IiejJO+oHNidVLOyjw+hhdV LWoHb0juROgtSbTzsrqPznUuHE/GHS0aWOvILlgPzg6Y2vsQ9sPnqj5ruWOAtS9gbjBXMAwBRlB6d B6U+uKHoFdHCaTn0hfpomgwBg3N4kiII1j7f31c+FdTUO7mFieVPd50b226QL2dTL1b3VcL3FCa1J 5xz4HXGQt0Wzw8P8DMhGwD7CLQUISRHWF609rjSb7vP4KYphXWoeX1ZGlVmdrVyfh/bpFeO9JsQsG usToUcnz5T8NZ8BCG9g0rgd3b2Ak0Fz+gTku/iq92DPM9mUc3Jc+Yz7IQ4RX7nL0qFbeXqglFXeVv bBieHV4e9dqZdA26C4Igx8WQX5FVjsgl9E9BLCqCi6esSsh3jZo02n91jqp1btE+h9LIk4rM4PE9H ZA+twsg5g4XMMN3kGZpyhTFXJO5/mt6KhJBwa/wEfyTtIJ5N/UXeRppIgmCYAvboPy00dgEYKXeUn LFk0mJDoqePbN+6cD2FUkRMIWXR/scEVHBhHL/uMrU2+H4RvoWQe2WXFGZCkLM+2uzgaJ/YszJdKJ GR/n8w5O/RdeJj5rUfT6cvTvZPH4pD7UjkH47rzTgenq3C+zBqPAkrihofQBMzYc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sysfs interface to seq_file continues to be rather fragile
(seq_get_buf() should not be used outside of seq_file), as seen with
some recent exploits[1]. Move the seq_file buffer to the vmap area
(while retaining the accounting flag), since it has guard pages that will
catch and stop linear overflows. This seems justified given that sysfs's
use of seq_file almost always already uses PAGE_SIZE allocations, has
normally short-lived allocations, and is not normally on a performance
critical path.

Once seq_get_buf() has been removed (and all sysfs callbacks using
seq_file directly), this change can also be removed.

[1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/sysfs/file.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 9aefa7779b29..351ff75a97b1 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 #include "sysfs.h"
 
@@ -32,6 +33,31 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
 	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
 }
 
+/*
+ * To be proactively defensive against sysfs show() handlers that do not
+ * correctly stay within their PAGE_SIZE buffer, use the vmap area to gain
+ * the trailing guard page which will stop linear buffer overflows.
+ */
+static void *sysfs_kf_seq_start(struct seq_file *sf, loff_t *ppos)
+{
+	struct kernfs_open_file *of = sf->private;
+	struct kernfs_node *kn = of->kn;
+
+	WARN_ON_ONCE(sf->buf);
+	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
+	if (!sf->buf)
+		return ERR_PTR(-ENOMEM);
+	sf->size = kn->attr.size;
+
+	/*
+	 * Use the same behavior and code as single_open(): continue
+	 * if pos is at the beginning; otherwise, NULL.
+	 */
+	if (*ppos)
+		return NULL;
+	return SEQ_OPEN_SINGLE;
+}
+
 /*
  * Reads on sysfs are handled through seq_file, which takes care of hairy
  * details like buffering and seeking.  The following function pipes
@@ -206,14 +232,17 @@ static const struct kernfs_ops sysfs_file_kfops_empty = {
 };
 
 static const struct kernfs_ops sysfs_file_kfops_ro = {
+	.seq_start	= sysfs_kf_seq_start,
 	.seq_show	= sysfs_kf_seq_show,
 };
 
 static const struct kernfs_ops sysfs_file_kfops_wo = {
+	.seq_start	= sysfs_kf_seq_start,
 	.write		= sysfs_kf_write,
 };
 
 static const struct kernfs_ops sysfs_file_kfops_rw = {
+	.seq_start	= sysfs_kf_seq_start,
 	.seq_show	= sysfs_kf_seq_show,
 	.write		= sysfs_kf_write,
 };
-- 
2.25.1

