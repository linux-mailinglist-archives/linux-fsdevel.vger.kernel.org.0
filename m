Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372287B1836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjI1KZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1KZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:25:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55C126;
        Thu, 28 Sep 2023 03:25:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-323168869daso9931783f8f.2;
        Thu, 28 Sep 2023 03:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695896720; x=1696501520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvZLzMFO5U6TUQj39mPsH4Ho5hoXNoZgtFVocagp1c4=;
        b=lnZ6x4giTJF1cpAj4TuYgMRUh1mMg2y05xb3f02zlF7D/kF6KbOMC2poS1VbF7DeFT
         0xc7I1jZ6rQKj1m/uo/S4yY96kUvyjio8ClXRTSBfivtC7RsqZ2xJtW019zCh1JaBj6+
         GwRBKya5izo9AePk6sQvkovq8VRDkh1K8nBWosKOW0EbthWTscNAd+cvqgd9pZgwgJce
         IJQzIbIhfZWXxAp5jpbjvVR9xMewFpywQRGhXfydHWOSt92hmChKTxuo/VzuhF7dNndM
         +GxjwvhXq9YrVI1bXkO9LJWb+YXR1KNVjOIGuvdtiZ4Oj+JaNzTrTRQEoDZDUUuFc3pA
         o4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695896720; x=1696501520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvZLzMFO5U6TUQj39mPsH4Ho5hoXNoZgtFVocagp1c4=;
        b=U4O3S0tealkUB1x0XViIOflMqHNgmeA/tTAtaJTIA/XcVuE5oRahzCB16g5YkfpsKo
         zGvvavjscLAj2f7JyVj7dHhqpQRIOTGon0pIjx7QbIspkNPOnEjeeTnEi5ONyWJkdzxP
         jYD53+CZZVtnk/sP3z4p25zOxsDTUnPp8I1uIPBbbeBMHzwVBaQVMHf3UJqGZb6HfXQf
         Ur3d56SS3rgS5YovfkOTV3Xt1ROXe/vtzYJ2itr5cKupbz36tKNEzaNVTF0cSp21i0FQ
         sQ5jFx00TkraeWTZ4u9otRPBJ9oKUS4AvBvpmKHxuA7+G1QDvFFBLXWWFmuglH7T+sJi
         e5Eg==
X-Gm-Message-State: AOJu0YxuYC2++7K534RWZJGiBivQ5futaoIzPy/Dm/ulS8HYbheN3f/w
        RHOfWj6IDdhRzIZsyXRM8yU=
X-Google-Smtp-Source: AGHT+IFmxLapyf5XY/q/LEEREICEooG8PjLhKxmuVQrcEWSJVu5800N+kF6KvO0p7j9GmxTY78/LsQ==
X-Received: by 2002:a05:6000:1a46:b0:323:269d:5a7a with SMTP id t6-20020a0560001a4600b00323269d5a7amr686143wry.5.1695896719514;
        Thu, 28 Sep 2023 03:25:19 -0700 (PDT)
Received: from f.. (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id f11-20020adff98b000000b0030fd03e3d25sm19076693wrr.75.2023.09.28.03.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 03:25:18 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] vfs: avoid delegating to task_work when cleaning up failed open
Date:   Thu, 28 Sep 2023 12:25:16 +0200
Message-Id: <20230928102516.186008-1-mjguzik@gmail.com>
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


I rebased my patch on top of the one shipped by Linus, then benched both.

My patch now depends on it going in first, inlined here for reference:

diff --git a/fs/file_table.c b/fs/file_table.c
index ee21b3da9d08..7b38ff7385cc 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -65,21 +65,21 @@ static void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f = container_of(head, struct file, f_rcuhead);

-	put_cred(f->f_cred);
-	if (unlikely(f->f_mode & FMODE_BACKING))
-		kfree(backing_file(f));
-	else
-		kmem_cache_free(filp_cachep, f);
+	kfree(backing_file(f));
 }

 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	if (unlikely(f->f_mode & FMODE_BACKING))
-		path_put(backing_file_real_path(f));
 	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
 		percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_rcuhead, file_free_rcu);
+	put_cred(f->f_cred);
+	if (unlikely(f->f_mode & FMODE_BACKING)) {
+		path_put(backing_file_real_path(f));
+		call_rcu(&f->f_rcuhead, file_free_rcu);
+	} else {
+		kmem_cache_free(filp_cachep, f);
+	}
 }

 /*
@@ -471,7 +471,8 @@ EXPORT_SYMBOL(__fput_sync);
 void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
+			SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN
+			| SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }

Sapphire Rapids, open1_processes -t 1 from will-it-scale + tmpfs on
/tmp (ops/s):
before:	1539109
after:	1785908 (+16%)

there was also a speed up for negative entries but the above should be
enough for the commit message and I don't want to duplicate the testcase
between them

Below is my rebased patch + rewritten commit message with updated bench
results. I decided to stick to fput_badopen name because with your patch
it legitimately has to unref. Naming that "release_empty_file" or
whatever would be rather misleading imho.

===================== cut here =====================
vfs: avoid delegating to task_work when cleaning up failed open

Failed opens (mostly ENOENT) legitimately happen a lot, for example here
are stats from stracing kernel build for few seconds (strace -fc make):

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ------------------
    0.76    0.076233           5     15040      3688 openat

(this is tons of header files tried in different paths)

Normally these are closed from task_work machinery, but getting there is
very expensive (see 021a160abf62 ("fs: use __fput_sync in close(2)") and
in the common case trivially avoidable.

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
before:	2299006
after:	2986226 (+29%)

v3:
- rebase on top of the patch which dodges RCU freeing altogether. the
  patch is no longer applicable on top of stock kernel.

v2:
- unexport fput_badopen and move to fs/internal.h
- handle the refcount with cmpxchg, adjust commentary accordingly
- tweak the commit message

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file_table.c | 22 ++++++++++++++++++++++
 fs/internal.h   |  2 ++
 fs/namei.c      |  2 +-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 7b38ff7385cc..8909737e1872 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -468,6 +468,28 @@ void __fput_sync(struct file *file)
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(__fput_sync);
 
+/*
+ * Clean up after failing to open (e.g., open(2) returns with -ENOENT).
+ *
+ * In the common case this avoids delegating the free to task_work.
+ */
+void fput_badopen(struct file *file)
+{
+	if (unlikely(file->f_mode & FMODE_OPENED)) {
+		fput(file);
+		return;
+	}
+
+	/*
+	 * While we did not expose the file to anyone, we may be racing against
+	 * __fget_files_rcu refing a stale object. Should this happen it is
+	 * going to backpedal with fput, but it means we have to unref with an
+	 * atomic to synchronize against it.
+	 */
+	if (atomic_long_dec_and_test(&file->f_count))
+		file_free(file);
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

