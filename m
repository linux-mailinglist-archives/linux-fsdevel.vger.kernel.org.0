Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1953A2148
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 02:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFJAX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 20:23:29 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44666 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFJAX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:23:28 -0400
Received: by mail-pg1-f179.google.com with SMTP id y11so12977274pgp.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 17:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TfNz2ZNpp6dNRK3iotr7VECkWYZVH4AaZ4EFsjw87Q=;
        b=YbR8T67BbF+HkAvWvv1dop3ZquLweOMEp+IY2rqpV0IpI0GGLA5BuMxu/4jEJe1NCj
         Vy4DN9Y9oqsck9njEWSj6zz3F52n9eGiUFQunnsPXy6vU7Ev4Va1JubvuOkU6+TiHiuW
         dEOk9yLy1UIja9KIGBSaR4Wo797ahnTjJ7isaxqLEz5gGDcX1ORWrSYVZUFLOPkzJ/ro
         Mo9l0MpHUwyhaYcDpnvoqL0wvH8S0sd5vYeW6N2R4I8f2TGkK5qZo5LsPY1SzpO3F7rH
         7vrZ8VOcPWZsJjeJYQM6rBapqTx2eecR89jidb+EMlgSADyVGJQKDUMVk9Q9sW9pvX/p
         uk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TfNz2ZNpp6dNRK3iotr7VECkWYZVH4AaZ4EFsjw87Q=;
        b=fLvVw6YmjKrd/wSoQVuRKVJarj6ZroUdMh1atOqLH4mJpEbk5Vq4P5zkm2HS+ObR/g
         GWZS4CrRwQly0NOixPy6QvK+PFfAPqj0nXFuxqsLzE9pO835cI5HZPvab1jhfNfQ/N7p
         EG3agafR+AFRvf55GKN31JuSfwTsOjXREAdBa+QjEsDSTGGj+wcMWBcT6e8yiZCTVAJr
         xWNeXEpfODXxk9C6EiJNxEaDgUgjxyDtjQCuEQZpdcihqa7fqrWZ1wLDdNJ1lnkMqRn+
         0outjZpbXUnjVMTlDm6NFpLIHT/BIED/6J37scJxNwZnwX0GNMsz45GAudyBDaoLXBCm
         D9Tg==
X-Gm-Message-State: AOAM531kdKTW8n8fmKP6vFNTx6gVBvxEi6BZh167R+LYeDiQ3/SSIQPr
        yZuEp0y+46aTqKOoSKmVtdoQow==
X-Google-Smtp-Source: ABdhPJwE/qhRzHZ5xeqpFBgQL6C66IrpYjggs2rhL2MzS9isWZBVcWI4BSVyYTfQ7fc/NKmN5zXRig==
X-Received: by 2002:a63:4a49:: with SMTP id j9mr2256779pgl.234.1623284420019;
        Wed, 09 Jun 2021 17:20:20 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id bo14sm5853250pjb.40.2021.06.09.17.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:20:19 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:20:06 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 1/5] kernel/pid.c: remove static qualifier from
 pidfd_create()
Message-ID: <db15a492d4e1cd8aaecfa6802d0bb289d1b539e3.1623282854.git.repnop@google.com>
References: <cover.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623282854.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the idea of returning pidfds from the fanotify API, we need to
expose a mechanism for creating pidfds. We drop the static qualifier
from pidfd_create() and add its declaration to linux/pid.h so that the
pidfd_create() helper can be called from other kernel subsystems
i.e. fanotify.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 include/linux/pid.h | 1 +
 kernel/pid.c        | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index fa10acb8d6a4..af308e15f174 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,6 +78,7 @@ struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
+int pidfd_create(struct pid *pid, unsigned int flags);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index ebdf9c60cd0b..d3cd95b8b080 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -550,10 +550,12 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Note, that this function can only be called after the fd table has
  * been unshared to avoid leaking the pidfd to the new process.
  *
+ * This symbol should not be explicitly exported to loadable modules.
+ *
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid, unsigned int flags)
+int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
-- 
2.30.2

/M
