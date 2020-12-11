Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EDE2D82ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394212AbgLKXwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 18:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437460AbgLKXv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:51:28 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E0C0617A6
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:13 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n1so5515880pge.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWr4dlswm/DRNu6GTIuObFvq9ZljqhYX8xwv7K9hdSQ=;
        b=jqQ0QIg7eKKpcLBX+VXe3oiPkcuw6okzb/PvhUNHkBLSDGxy6KT18KvgIoncC8UKwY
         Zggcf9dTdzz4N6TUG/ZJgGi6WT+ZjERt1kNeYu/uSf1GrcOCDPRdp/I2xkhjvLj+fxPi
         VSXyI+uL+yHsTH+1WNkFUGj9Y50ODIY6PlH6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWr4dlswm/DRNu6GTIuObFvq9ZljqhYX8xwv7K9hdSQ=;
        b=qf5AHygcvsVcG1ufRax0iw5X9kp4AaZ50NnR5u3ZIhStzVRqTD8PZ0ypMcgOUVxOqK
         cTuwYvEAD+hbj2F///+oQihMISGYgA7u2shs0dWO82RhsVHtZQqx8cCj6Y1omBcaa65Q
         66LAJw4zuI89F38Yszezrt5wLoW9jxFHYhBlIyLRy6Co/R93Hrea2FimaLlZki68xgpe
         18M/clD+ExUGdp1ckXhSZSK9uLxpRDEYA77B6iVcBITFqGYOgn3fO4b6/5bBYTQqlF6X
         iTC6mQwGxGF9gORpN+njEQJn8dfL10ag8DOSEfY2Yn7NXcTgdaXFKlgTRvQ3kuguFIo9
         3gnA==
X-Gm-Message-State: AOAM532med0VXJoooKV370+F5k0vm4JVx18ry+z++O5PbEgtsli8YWcD
        2trP7AblraiDfhzsEAmALVac9w==
X-Google-Smtp-Source: ABdhPJxIK3BkR45TwQEgkdprgBAjp4tW7Ab+Doh1jVf0TGCBwxsXrQzrE660WhUEwngMr/jDDlKC1g==
X-Received: by 2002:a05:6a00:a91:b029:19d:9421:847 with SMTP id b17-20020a056a000a91b029019d94210847mr4722715pfl.72.1607730612912;
        Fri, 11 Dec 2020 15:50:12 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b12sm11324641pft.114.2020.12.11.15.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:50:12 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Sargun Dhillon <sargun@sargun.me>, Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 2/3] errseq: Add mechanism to snapshot errseq_counter and check snapshot
Date:   Fri, 11 Dec 2020 15:50:01 -0800
Message-Id: <20201211235002.4195-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211235002.4195-1-sargun@sargun.me>
References: <20201211235002.4195-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the function errseq_counter_sample to allow for "subscribers"
to take point-in-time snapshots of the errseq_counter, and store the
counter + errseq_t.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/errseq.h |  4 ++++
 lib/errseq.c           | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index 35818c484290..8998df499a3b 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -25,4 +25,8 @@ errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
+void errseq_counter_sample(errseq_t *dst_errseq, int *dst_errors,
+			   struct errseq_counter *counter);
+int errseq_counter_check(struct errseq_counter *counter, errseq_t errseq_since,
+			 int errors_since);
 #endif
diff --git a/lib/errseq.c b/lib/errseq.c
index d555e7fc18d2..98fcfafa3d97 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -246,3 +246,54 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 	return err;
 }
 EXPORT_SYMBOL(errseq_check_and_advance);
+
+/**
+ * errseq_counter_sample() - Grab the current errseq_counter value
+ * @dst_errseq: The errseq_t to copy to
+ * @dst_errors: The destination overflow to copy to
+ * @counter: The errseq_counter to copy from
+ *
+ * Grabs a point in time sample of the errseq_counter for latter comparison
+ */
+void errseq_counter_sample(errseq_t *dst_errseq, int *dst_errors,
+			   struct errseq_counter *counter)
+{
+	errseq_t cur;
+
+	do {
+		cur = READ_ONCE(counter->errseq);
+		*dst_errors = atomic_read(&counter->errors);
+	} while (cur != READ_ONCE(counter->errseq));
+
+	/* Clear the seen bit to make checking later easier */
+	*dst_errseq = cur & ~ERRSEQ_SEEN;
+}
+EXPORT_SYMBOL(errseq_counter_sample);
+
+/**
+ * errseq_counter_check() - Has an error occurred since the sample
+ * @counter: The errseq_counter from which to check.
+ * @errseq_since: The errseq_t sampled with errseq_counter_sample to check
+ * @errors_since: The errors sampled with errseq_counter_sample to check
+ *
+ * Returns: The latest error set in the errseq_t or 0 if there have been none.
+ */
+int errseq_counter_check(struct errseq_counter *counter, errseq_t errseq_since,
+			 int errors_since)
+{
+	errseq_t cur_errseq;
+	int cur_errors;
+
+	cur_errors = atomic_read(&counter->errors);
+	/* To match the barrier in errseq_counter_set */
+	smp_rmb();
+
+	/* Clear / ignore the seen bit as we do at sample time */
+	cur_errseq = READ_ONCE(counter->errseq) & ~ERRSEQ_SEEN;
+
+	if (cur_errseq == errseq_since && errors_since == cur_errors)
+		return 0;
+
+	return -(cur_errseq & MAX_ERRNO);
+}
+EXPORT_SYMBOL(errseq_counter_check);
-- 
2.25.1

