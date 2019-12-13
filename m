Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1869611EA73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfLMSgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 13:36:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42416 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfLMSgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:36:44 -0500
Received: by mail-io1-f66.google.com with SMTP id f82so610771ioa.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tbz2/17zT8Ai2M4oM7NQjrHb28uKPQh8iT//ot5Yuj8=;
        b=dQlSeUjmRFxMuAOL1bbejpQxLslW+811/PiBruQH9rdWgyG7FuNyckf1WzFAYM9jLO
         sR1lxIsMFis5KQiwEf7lbJEw0XpLXBoIlZci9psK0ApIJqr7TKiiDtX0hzFk+NoCbaKc
         kvvrx0QPvZY+e3NYRVRhVDtD/kuTGyKYjOD7XQwwkRaRnhW9E+WgeacXBjgXXN8vjvpQ
         XMsIQ99h3NwJIauwUF2hXQVK0sfECaFfOkUWM619fqFKtFugKsMepMWwDtJg669J+cXq
         OHRHoVQXVSdjquwLCoFDNwOUEyeVvXZCIjGq5xx7YFsjOu2tdfHtP6CqWemJ4U/MEmvT
         6mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tbz2/17zT8Ai2M4oM7NQjrHb28uKPQh8iT//ot5Yuj8=;
        b=hS5SWSYmazoJkx5wPwfjxEggr/OhWBvzDeIt2KTG7i27J5EyefK7D2OudYijvO6s5I
         TUBoSZ0dHG1ksD/K/iVei2yjdRSA9RjBzqPy+kCOTuheN5l7A++M7Z08kQziBm73bCUF
         5RkwKS1/1VRmmSku135aW6gDsTTOewwXXAccHWhnyzZ6EpJliCm7wuq5/9FHvlsFn2LU
         IkR30Nc4yuEcAJrLeu/lKZivD/oUboIYrBz08n2roOi+TBkWkel9pcuYLKqrXkO5WMZk
         l1UZn8FMHhOAh9qZYJN7GxyX3LupfPjMYR9uyPgSGjNankP9bX0y899pybK7/xeN2kOe
         1LSw==
X-Gm-Message-State: APjAAAVzowLQwf53nlut5dH3QzZ/8dAhKkHWKUbIqL906qSvMP48EFCj
        vqgfIa7BZTIuhx/RTU+UfzQ+YQ==
X-Google-Smtp-Source: APXvYqyarshMIlC2UeymxFB3ePCQGFiXdNYc9VPMrMGT5VUGCSERVuQCYgjyqMcZVeCaM7feM0nvsA==
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr8706198ioh.175.1576262203387;
        Fri, 13 Dec 2019 10:36:43 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w24sm2932031ilk.4.2019.12.13.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:36:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/10] fs: move filp_close() outside of __close_fd_get_file()
Date:   Fri, 13 Dec 2019 11:36:28 -0700
Message-Id: <20191213183632.19441-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213183632.19441-1-axboe@kernel.dk>
References: <20191213183632.19441-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just one caller of this, and just use filp_close() there manually.
This is important to allow async close/removal of the fd.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/android/binder.c | 6 ++++--
 fs/file.c                | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e9bc9fcc7ea5..e8b435870d6b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2249,10 +2249,12 @@ static void binder_deferred_fd_close(int fd)
 		return;
 	init_task_work(&twcb->twork, binder_do_fd_close);
 	__close_fd_get_file(fd, &twcb->file);
-	if (twcb->file)
+	if (twcb->file) {
+		filp_close(twcb->file, current->files);
 		task_work_add(current, &twcb->twork, true);
-	else
+	} else {
 		kfree(twcb);
+	}
 }
 
 static void binder_transaction_buffer_release(struct binder_proc *proc,
diff --git a/fs/file.c b/fs/file.c
index 3da91a112bab..a250d291c71b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -662,7 +662,7 @@ int __close_fd_get_file(unsigned int fd, struct file **res)
 	spin_unlock(&files->file_lock);
 	get_file(file);
 	*res = file;
-	return filp_close(file, files);
+	return 0;
 
 out_unlock:
 	spin_unlock(&files->file_lock);
-- 
2.24.1

