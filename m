Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9301D190C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbgEMPVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:21:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35644 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbgEMPVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:21:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id n18so645016pfa.2;
        Wed, 13 May 2020 08:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2EmjNUNQ4Z5jimRhohvy5E6UFn8J7/n3AurcqTssfc=;
        b=pKjK5/uLwvB1l4zaIfTdJJfWUmJTFDpuGrtJJT9esp2duuPlmJHlIB+eh+as55fii3
         hOi9By7XgiF6KLzjMvn4WxVV/J1fOo6sXLVpN5q//IH3Fmv/ctS88Zbc5s3j3B7iFnkn
         vgj4SJ3pdB2g8nEOXbLDjGw+ZYhGwsgZo46SEk31JbOgq9r4Uk99oq6LK97B8UZ6ABNE
         qImx4R2WBKdMwV8VLDbMmbftbdfsHv9VkLGbW+ZDZ+oAIQs6hvDAz0UWXicdGfk3ZjrF
         tbZE2KgusOnxRYswn9tmEi1uLgNqPw7SnusG0rpXVyK3W1Fr6ttvPPKkK/OP18E+amuU
         BHJQ==
X-Gm-Message-State: AGi0PuaeTKJyhXUfDAy2HW3Hf0hZ5lRqSaLOSMRgHj3HdicUT0yDZjXt
        JO0pmqF04pzZUpNm/7Qdpp0=
X-Google-Smtp-Source: APiQypLjceC/PEfdNROkTqxbFVK4lToQw5U4tMxxK9Fb2TK7BTD2Imz/M+WiRtr+fq6JB7P+q54wFA==
X-Received: by 2002:a63:1361:: with SMTP id 33mr23946447pgt.265.1589383274907;
        Wed, 13 May 2020 08:21:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j2sm15315389pfb.73.2020.05.13.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:21:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4BEB0418C0; Wed, 13 May 2020 15:21:12 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org,
        jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com
Cc:     scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/3] fs: unexport kernel_read_file()
Date:   Wed, 13 May 2020 15:21:06 +0000
Message-Id: <20200513152108.25669-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200513152108.25669-1-mcgrof@kernel.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no modular uses of kernel_read_file(), so just unexport it.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 23dc2b45d590..9791b9eef9ce 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -988,7 +988,6 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(kernel_read_file);
 
 int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 			       loff_t max_size, enum kernel_read_file_id id)
-- 
2.26.2

