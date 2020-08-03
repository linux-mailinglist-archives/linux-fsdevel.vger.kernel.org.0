Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2766A23A7D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHCNjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:39:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727042AbgHCNjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKTs8Nwt3RaCnuVZm1ZkfO1PiNt5ZHF2aGwikX+kxWQ=;
        b=FVvfEqgHSZMQ+GW2+GxORTtv/hDZDAdCxoX01EcxhNICa9Q866PrS/50gCA9Ui7pjm85Hl
        xGX6oHqjUwYyxZGzb3JWRebag+GzdTVqECQCjmBIX8wAjTRxh34IcYUKJSz3Y4ufTDSdDR
        3hFc4P1/+f7D+9B8KQzMW+yr61bikm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-I3WAXrGGOFyBHp2YBmWWmw-1; Mon, 03 Aug 2020 09:39:10 -0400
X-MC-Unique: I3WAXrGGOFyBHp2YBmWWmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A556C1016A80;
        Mon,  3 Aug 2020 13:38:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 084045DA69;
        Mon,  3 Aug 2020 13:38:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/18] errseq: add a new errseq_scrape function [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Jeff Layton <jlayton@kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>, dhowells@redhat.com,
        torvalds@linux-foundation.org, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:38:43 +0100
Message-ID: <159646192315.1784947.14996325679562019699.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

To grab the current value of an errseq_t, mark it as seen and then
return the value with the seen bit masked off.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/errseq.h |    1 +
 lib/errseq.c           |   33 +++++++++++++++++++++++++++++++--
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


