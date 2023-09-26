Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7650E7AF09C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjIZQWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjIZQWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:22:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCE193;
        Tue, 26 Sep 2023 09:22:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdcade7fbso1114626166b.1;
        Tue, 26 Sep 2023 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695745355; x=1696350155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isZM+KwQz6FTkMCGH532kqIWoaREk87BS2KHMsM0vxI=;
        b=Du8aKXzXnXcB9Blv6K7GkXTPf23dFYXchl+3MC/9QrTedHKSCpQilNi6/sLJqohkRj
         +lw0Xeen8lMAxGuGwuuAMNeGcP+nAMcNdZVLQNldBiUjzZRJnp+rAwxhDOAJqOKCDsq2
         XZAAzVAcWOCJgDaMtgDiobkEuowhlFFHxKL2K0EnlSwsi/q7S+Ib9gAyBdlL4rbGVHmS
         WfFgva88XG11XmvBHP7+cqzoRXsNmm6ksnFwitt0BtJfqWcgIvwj299p5inlSKxB9HIu
         QZLOdG7J56Gu1/kqPjinK1lO8uK0UBcLrdGRbhx4WIbgqX2IFrnArWDpa5kun+SzUPuv
         ovHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695745355; x=1696350155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isZM+KwQz6FTkMCGH532kqIWoaREk87BS2KHMsM0vxI=;
        b=suxSAkm2Z7C8mzptFmhr1zzSEGJp4wgxj+4+onRkn53t5BlM1KIh2ZPPIXEwIRSVf3
         Wz0ivtf2Zgi+YZTsy8yyvmJx5/3jSBeaAW2m+m5R/hk4hXWPZVtaE6VGkyZ5xvvZaIOo
         aL/HrdKl/O75JMMlpjPmfMtndaYhz1g51N+pE3eN7kzzHi8ctzXBznhr2k8KJPxlu5Nv
         PsVM89wB1GBew1p8lFXm4UMulGcLaypyOKJzkL+NrKf3u4NJPQF6FisHggxIrLH+bavr
         YqzFGg4SGboLE8hCZAYLaOtnwtEMuNcZjlgglEghbHamQLpvkLsnsHzWZ5T5MCS5Ekz0
         08Og==
X-Gm-Message-State: AOJu0YyaTSN4oiE9jwsSLRbfnNYF4GHKJVa6+Pm2MpYfNSoAejH7WMah
        uWiPc+VNez9TgVJ9gz6R6fw=
X-Google-Smtp-Source: AGHT+IGCHG2a21RArwSr62WMP93eCUhZBNB4pDl+jjjmBDHchjYALy1n+C6/trhIJHsw1JzfzZG3VA==
X-Received: by 2002:a17:906:844f:b0:9a1:c991:a521 with SMTP id e15-20020a170906844f00b009a1c991a521mr8627387ejy.4.1695745354996;
        Tue, 26 Sep 2023 09:22:34 -0700 (PDT)
Received: from f.. (cst-prg-24-34.cust.vodafone.cz. [46.135.24.34])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906168400b009ad829ed144sm7951148ejd.130.2023.09.26.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:22:33 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] vfs: shave work on failed file open
Date:   Tue, 26 Sep 2023 18:22:28 +0200
Message-Id: <20230926162228.68666-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Failed opens (mostly ENOENT) legitimately happen a lot, for example here
are stats from stracing kernel build for few seconds (strace -fc make):

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ------------------
    0.76    0.076233           5     15040      3688 openat

(this is tons of header files tried in different paths)

In the common case of there being nothing to close (only the file object
to free) there is a lot of overhead which can be avoided.

This is most notably delegation of freeing to task_work, which comes
with an enormous cost (see 021a160abf62 ("fs: use __fput_sync in
close(2)" for an example).

Benchmarked with will-it-scale with a custom testcase based on
tests/open1.c, stuffed into tests/openneg.c:
[snip]
        while (1) {
                int fd = open("/tmp/nonexistent", O_RDONLY);
                assert(fd == -1);

                (*iterations)++;
        }
[/snip]

Sapphire Rapids, openneg_processes -t 1 (ops/s):
before:	1950013
after:	2914973 (+49%)

file refcount is checked as a safety belt against buggy consumers with
an atomic cmpxchg. Technically it is not necessary, but it happens to
not be measurable due to several other atomics which immediately follow.
Optmizing them away to make this atomic into a problem is left as an
exercise for the reader.

v2:
- unexport fput_badopen and move to fs/internal.h
- handle the refcount with cmpxchg, adjust commentary accordingly
- tweak the commit message

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file_table.c | 35 +++++++++++++++++++++++++++++++++++
 fs/internal.h   |  2 ++
 fs/namei.c      |  2 +-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index ee21b3da9d08..6cbd5bc551d0 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -82,6 +82,16 @@ static inline void file_free(struct file *f)
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
 
+static inline void file_free_badopen(struct file *f)
+{
+	BUG_ON(f->f_mode & (FMODE_BACKING | FMODE_OPENED));
+	security_file_free(f);
+	put_cred(f->f_cred);
+	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
+		percpu_counter_dec(&nr_files);
+	kmem_cache_free(filp_cachep, f);
+}
+
 /*
  * Return the total number of open files in the system
  */
@@ -468,6 +478,31 @@ void __fput_sync(struct file *file)
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(__fput_sync);
 
+/*
+ * Clean up after failing to open (e.g., open(2) returns with -ENOENT).
+ *
+ * This represents opportunities to shave on work in the common case of
+ * FMODE_OPENED not being set:
+ * 1. there is nothing to close, just the file object to free and consequently
+ *    no need to delegate to task_work
+ * 2. as nobody else had seen the file then there is no need to delegate
+ *    freeing to RCU
+ */
+void fput_badopen(struct file *file)
+{
+	if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
+		fput(file);
+		return;
+	}
+
+	if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1)) {
+		fput(file);
+		return;
+	}
+
+	file_free_badopen(file);
+}
+
 void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cc..93da6d815e90 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -95,6 +95,8 @@ struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
 
+void fput_badopen(struct file *);
+
 static inline void put_file_access(struct file *file)
 {
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..67579fe30b28 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3802,7 +3802,7 @@ static struct file *path_openat(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	fput(file);
+	fput_badopen(file);
 	if (error == -EOPENSTALE) {
 		if (flags & LOOKUP_RCU)
 			error = -ECHILD;
-- 
2.39.2

