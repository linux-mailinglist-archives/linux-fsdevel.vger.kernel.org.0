Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF640EFFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhIQDBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 23:01:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbhIQDBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:01:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D480223BD;
        Fri, 17 Sep 2021 02:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631847577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCmYAExKah/x4HefNwJ6SI3ygmGtoGw6YCC4JX6hn1A=;
        b=ZD08jNr3STpxIH2zhAj9vQ08PCu/q3GNJLyXZgVVTvIjd9eXcLIYJhnhXbjSrigDBUIuC2
        WQBHbIGiQMBjRXzZr9ZH/nF1atOn2t78ukiAIiA1h/5IZocoG6GGgoBBxuLpGXgSci4yfF
        OkJ4ZwgFwbPkHnuIb/g+WH804uf8Z8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631847577;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCmYAExKah/x4HefNwJ6SI3ygmGtoGw6YCC4JX6hn1A=;
        b=kBS9mRBLg9S4WsHwdwYdezpuGLpU07TMQfxxihZAV7Xevvz28AvWtdhEVRCrBuOlLwSmy+
        6vS8wGL3Y8Oq9MDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 029DC13D0B;
        Fri, 17 Sep 2021 02:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WSX/LJQERGF0MwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Sep 2021 02:59:32 +0000
Subject: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Fri, 17 Sep 2021 12:56:57 +1000
Message-ID: <163184741778.29351.16920832234899124642.stgit@noble.brown>
In-Reply-To: <163184698512.29351.4735492251524335974.stgit@noble.brown>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__GFP_NOFAIL is documented both in gfp.h and memory-allocation.rst.
The details are not entirely consistent.

This patch ensures both places state that:
 - there is a risk of deadlock with reclaim/writeback/oom-kill
 - it should only be used when there is no real alternative
 - it is preferable to an endless loop
 - it is strongly discourages for costly-order allocations.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/core-api/memory-allocation.rst |   25 ++++++++++++++++++++++++-
 include/linux/gfp.h                          |    6 +++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 5954ddf6ee13..8ea077465446 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -126,7 +126,30 @@ or another request.
 
   * ``GFP_KERNEL | __GFP_NOFAIL`` - overrides the default allocator behavior
     and all allocation requests will loop endlessly until they succeed.
-    This might be really dangerous especially for larger orders.
+    Any attempt to use ``__GFP_NOFAIL`` for allocations larger than
+    order-1 (2 pages) will trigger a warning.
+
+    Use of ``__GFP_NOFAIL`` can cause deadlocks so it should only be used
+    when there is no alternative, and then should be used with caution.
+    Deadlocks can happen if the calling process holds any resources
+    (e.g. locks) which might be needed for memory reclaim or write-back,
+    or which might prevent a process killed by the OOM killer from
+    successfully exiting.  Where possible, locks should be released
+    before using ``__GFP_NOFAIL``.
+
+    While this flag is best avoided, it is still preferable to endless
+    loops around the allocator.  Endless loops may still be used when
+    there is a need to test for the process being killed
+    (fatal_signal_pending(current)).
+
+  * ``GFP_NOFS | __GFP_NOFAIL`` - Loop endlessly instead of failing
+    when performing allocations in file system code.  The same guidance
+    as for ``GFP_KERNEL | __GFP_NOFAIL`` applies with extra emphasis on
+    the possibility of deadlocks.  ``GFP_NOFS`` often implies that
+    filesystem locks are held which might lead to blocking reclaim.
+    Preemptively flushing or reclaiming memory associated with such
+    locks might be appropriate before requesting a ``__GFP_NOFAIL``
+    allocation.
 
 Selecting memory allocator
 ==========================
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 55b2ec1f965a..1d2a89e20b8b 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -209,7 +209,11 @@ struct vm_area_struct;
  * used only when there is no reasonable failure policy) but it is
  * definitely preferable to use the flag rather than opencode endless
  * loop around allocator.
- * Using this flag for costly allocations is _highly_ discouraged.
+ * Use of this flag may lead to deadlocks if locks are held which would
+ * be needed for memory reclaim, write-back, or the timely exit of a
+ * process killed by the OOM-killer.  Dropping any locks not absolutely
+ * needed is advisable before requesting a %__GFP_NOFAIL allocate.
+ * Using this flag for costly allocations (order>1) is _highly_ discouraged.
  */
 #define __GFP_IO	((__force gfp_t)___GFP_IO)
 #define __GFP_FS	((__force gfp_t)___GFP_FS)


