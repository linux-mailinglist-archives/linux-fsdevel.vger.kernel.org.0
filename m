Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64273403B85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349052AbhIHOaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:15 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41482 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351925AbhIHOaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:14 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAO-0004qv-LE; Wed, 08 Sep 2021 10:03:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] coda: Check for async upcall request using local state
Date:   Wed,  8 Sep 2021 10:03:01 -0400
Message-Id: <20210908140308.18491-3-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Originally flagged by Smatch because the code implicitly assumed outSize
is not NULL for non-async upcalls because of a flag that was (not) set
in req->uc_flags.

However req->uc_flags field is in shared state and although the current
code will not allow it to be changed before the async request check the
code is more robust when it tests against the local outSize variable.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/upcall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index eb3b1898da46..59f6cfd06f96 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -744,7 +744,8 @@ static int coda_upcall(struct venus_comm *vcp,
 	list_add_tail(&req->uc_chain, &vcp->vc_pending);
 	wake_up_interruptible(&vcp->vc_waitq);
 
-	if (req->uc_flags & CODA_REQ_ASYNC) {
+	/* We can return early on asynchronous requests */
+	if (outSize == NULL) {
 		mutex_unlock(&vcp->vc_mutex);
 		return 0;
 	}
-- 
2.25.1

