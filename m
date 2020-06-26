Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772B720B424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgFZPFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 11:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgFZPFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:05:03 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0C920706;
        Fri, 26 Jun 2020 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593183903;
        bh=9i6P/z6NfUDRDD46kUh4BiJshxJZ3hX+mLCM84PbP5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXqiI471a/lTlWu3I94Wn4KbKsuG5UlLpwpLNCLcnVLLkGbJfPhPAoA+hDsB9l+Qk
         kGWoGlGzukCPdvluiFFW2ZswDMDOxGa7lqk+EeUV5QW+zw+sxEcID7Nm3IXAtTR4vA
         IJDjGoVlB0DSNh8HNdUh4I3UF7rWDOTJgvDYu9U4=
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, andres@anarazel.de
Subject: [fsinfo PATCH v2 1/3] errseq: add a new errseq_scrape function
Date:   Fri, 26 Jun 2020 11:04:58 -0400
Message-Id: <20200626150500.565417-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626150500.565417-1-jlayton@kernel.org>
References: <20200626150500.565417-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

To grab the current value of an errseq_t, mark it as seen and then
return the value with the seen bit masked off.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 include/linux/errseq.h |  1 +
 lib/errseq.c           | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..de165623fa86 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -9,6 +9,7 @@ typedef u32	errseq_t;
 
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_scrape(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e7..8ded0920eed3 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -108,7 +108,7 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 EXPORT_SYMBOL(errseq_set);
 
 /**
- * errseq_sample() - Grab current errseq_t value.
+ * errseq_sample() - Grab current errseq_t value (or 0 if it hasn't been seen)
  * @eseq: Pointer to errseq_t to be sampled.
  *
  * This function allows callers to initialise their errseq_t variable.
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(errseq_set);
  * see it the next time it checks for an error.
  *
  * Context: Any context.
- * Return: The current errseq value.
+ * Return: The current errseq value or 0 if it wasn't previously seen
  */
 errseq_t errseq_sample(errseq_t *eseq)
 {
@@ -130,6 +130,35 @@ errseq_t errseq_sample(errseq_t *eseq)
 }
 EXPORT_SYMBOL(errseq_sample);
 
+/**
+ * errseq_scrape() - Grab current errseq_t value
+ * @eseq: Pointer to errseq_t to be sampled.
+ *
+ * This function allows callers to scrape the current value of an errseq_t.
+ * Unlike errseq_sample, this will always return the current value with
+ * the SEEN flag unset, even when the value has not yet been seen.
+ *
+ * Context: Any context.
+ * Return: The current errseq value with ERRSEQ_SEEN masked off
+ */
+errseq_t errseq_scrape(errseq_t *eseq)
+{
+	errseq_t old = READ_ONCE(*eseq);
+
+	/*
+	 * For the common case of no errors ever having been set, we can skip
+	 * marking the SEEN bit. Once an error has been set, the value will
+	 * never go back to zero.
+	 */
+	if (old != 0) {
+		errseq_t new = old | ERRSEQ_SEEN;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return old & ~ERRSEQ_SEEN;
+}
+EXPORT_SYMBOL(errseq_scrape);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.
-- 
2.26.2

