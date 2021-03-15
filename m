Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC42933C4C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhCORtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhCORs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:48:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C9AC061765
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 10:48:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f8so2162729plg.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4LOOlKghqKoUuetivtR1XqBry1SjVqiUzM952HtSrQ=;
        b=gOpBnYQkTAQNlY7h/6aAMYNLrGslqM/a1BwxSCghq1Xx5KlFtg8dQo49K0HBXRi5qN
         d+1KJjYaXMLjbWt+YzchPZ3fzFOGhQmgrrLk7VNu34kQDtUlUa/7UVDnB0/+sZ2Oe2g0
         pUSXS71v2v0wNYJbjUbgTkE6Uy5Xw7quYdiG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l4LOOlKghqKoUuetivtR1XqBry1SjVqiUzM952HtSrQ=;
        b=HL/k4ldNYHHR+Xyz85k7WGdaxyfHhCFOlsqRyvuphBFB9/f1saixIIWVZieCExeGsf
         27R2OM+8tSotRHmkFcfPTfVYntMcTj8jd1CqjEa/o5z4wOuTSwKEQh4yfqSsLsEaN0uK
         O/cZ+HJ8+c2ShB7e4Vu/Ih61buWy4pjf95miBq8mwFNJfgt2dFmdPZqsSqv4djhfHw8o
         869R+BoOvEbEzR+yE8ah063ObRlTrWaigLiZVRNj9uxei37hIBFb0PBz2NfdTobFR4mm
         ftyoQfVArkSq2b1bYxvh53T3JxTA1FHN5GbMswyoGAgHNp5gnQK6nmO6pN3FQtMvXW30
         TCzQ==
X-Gm-Message-State: AOAM531tXSLwWyTiK+0r5QJQc/ug9Gv3+8sKWNxzKaXw4j+gk1CpEPLM
        qeMEXRK7QoVF07L3HHW5/L6rDg==
X-Google-Smtp-Source: ABdhPJytQqspNyAmFVJp2yMxsg3y4Bpu+X+d/dwmCmDHRxFkOkOmLwVjDTGgiWbdlQgl/KqrFXf+DQ==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr247088pjb.1.1615830538984;
        Mon, 15 Mar 2021 10:48:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm14254077pfg.215.2021.03.15.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:48:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Date:   Mon, 15 Mar 2021 10:48:51 -0700
Message-Id: <20210315174851.622228-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=8127f4bb12fc6c17d3829b992d9a4a2e95e55109; i=wnTs9CQ9b8oyAQUYWk1TWb6rr60OLTnvw/rrLAiBrmk=; m=WalZI6OWPnXJm31CATxJMvj5D+0cNcW5LRPeotCFpyY=; p=zv6zDQp+zJmS7mw61IUyZUpJiDoSaUWpqGFE94Dk8kY=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBPngIACgkQiXL039xtwCYaRA//bG9 CB3WWFg4jlT5EKm/W144wZYrWglGNAxyEPNd5poScEppgxVgn/GH0OVQqpJJ0L4YFWnJRdYVA390F yfuOuok9B61Vb9/pZ8M17bLNDu0bFnqkPm6he8p3lQWS1k5OwwT+a2O8TjTOLHG0XurastgeTAXF7 l77h6KV2VoX7QtaZRhAGSROGDU+z2Hzm1eX9bGnFM/o5K4GXO8V+pjkwqt+6fEc0GyydBoVYZuMDn AW2pqOlg1AtuvxPVTda7oKblHRPtrRE3FCZjXLvDCzBrsJEHKi+RgcRO1fvmVcSaa3GTDZJndNHuY Pa5tI1DrhWUnBvzWUKTfyWhsneDYLIfFoJ0D+x55pzM0DSGkoO5/SSnGNX6Lau0x+c+k8d0gM0Abi 9pgQxbhcIiW04KZvLrvl4B1EjgZRuXaPWq7nVR6GHjgUGO/SFbEnf8lR3PtbzZMxWKXYyohBuCnHm flNEXnYN+9zcrASK6lQ/KH5pjfJ+YQQlXvI5uuXxesWztdEbCkgOOcqcjs0XSXMZnnAXaU3cuBjhD pTz9vVXDOtiT7ZOiTjLmfVwsUEkCvx0KnBd9u+3tz3zjqft4qWDsQykY/bieSNeupTViLaKuLp0VR JwGDU0TZl5vcvYOo0O1HI9cZtOjet792j0GQ1qDpEH5oEEs7pwEpwCMEc1ZmjwbY=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sysfs interface to seq_file continues to be rather fragile, as seen
with some recent exploits[1]. Move the seq_file buffer to the vmap area
(while retaining the accounting flag), since it has guard pages that
will catch and stop linear overflows. This seems justified given that
seq_file already uses kvmalloc(), is almost always using a PAGE_SIZE or
larger allocation, has allocations are normally short lived, and is not
normally on a performance critical path.

[1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/seq_file.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index cb11a34fb871..16fb4a4e61e3 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -32,7 +32,12 @@ static void seq_set_overflow(struct seq_file *m)
 
 static void *seq_buf_alloc(unsigned long size)
 {
-	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
+	/*
+	 * To be proactively defensive against buggy seq_get_buf() callers
+	 * (i.e. sysfs handlers), use the vmap area to gain the trailing
+	 * guard page which will protect against linear buffer overflows.
+	 */
+	return __vmalloc(size, GFP_KERNEL_ACCOUNT);
 }
 
 /**
@@ -130,7 +135,7 @@ static int traverse(struct seq_file *m, loff_t offset)
 
 Eoverflow:
 	m->op->stop(m, p);
-	kvfree(m->buf);
+	vfree(m->buf);
 	m->count = 0;
 	m->buf = seq_buf_alloc(m->size <<= 1);
 	return !m->buf ? -ENOMEM : -EAGAIN;
@@ -237,7 +242,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto Fill;
 		// need a bigger buffer
 		m->op->stop(m, p);
-		kvfree(m->buf);
+		vfree(m->buf);
 		m->count = 0;
 		m->buf = seq_buf_alloc(m->size <<= 1);
 		if (!m->buf)
@@ -349,7 +354,7 @@ EXPORT_SYMBOL(seq_lseek);
 int seq_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *m = file->private_data;
-	kvfree(m->buf);
+	vfree(m->buf);
 	kmem_cache_free(seq_file_cache, m);
 	return 0;
 }
@@ -585,7 +590,7 @@ int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
 		return -ENOMEM;
 	ret = single_open(file, show, data);
 	if (ret) {
-		kvfree(buf);
+		vfree(buf);
 		return ret;
 	}
 	((struct seq_file *)file->private_data)->buf = buf;
-- 
2.25.1

