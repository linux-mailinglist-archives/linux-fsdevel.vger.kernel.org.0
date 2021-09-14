Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DE40A1EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 02:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbhINA3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 20:29:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55050 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbhINA3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:29:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 293F9200AB;
        Tue, 14 Sep 2021 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631579270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0SHCABpDWS99bZKx2dAHZNwjxnp06aPgrFMV26MaeI=;
        b=vKluE2nOK+k9zSBiBmELjziS/Je3Eb7ExMrDxZnQgF+C9Jlx6UUT2UchNrxrTG4opSHW5e
        CKXutZ33ekHMt2YOaXMYX4apmr9T8sIP9VrAD8dS5JEAhAtmV0vAgHwumYWtDsneQYQkTB
        UeLE85Mise3J1lrnNfUn35emK0UMcjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631579270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0SHCABpDWS99bZKx2dAHZNwjxnp06aPgrFMV26MaeI=;
        b=KHVFdZ4dzTCRc/u9v2yXF/btQQFh1qUTgYDrabeG0U2Emc2V42uJV6/y0HDLdM8r95xM8U
        VRa1YzY4Iys9V4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDB7613ADE;
        Tue, 14 Sep 2021 00:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ja8IH4LsP2EUawAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 00:27:46 +0000
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>
Date:   Tue, 14 Sep 2021 10:13:04 +1000
Subject: [PATCH 1/6] MM: improve documentation for __GFP_NOFAIL
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <163157838436.13293.8832201267053160346.stgit@noble.brown>
In-Reply-To: <163157808321.13293.486682642188075090.stgit@noble.brown>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
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
 - there is a cost potentially imposed on other subsystems
 - it should only be used when there is no real alternative
 - it is preferable to an endless loop
 - it is strongly discourages for costly-order allocations.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/core-api/memory-allocation.rst |    9 ++++++++-
 include/linux/gfp.h                          |    4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 5954ddf6ee13..9458ce72d31c 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -126,7 +126,14 @@ or another request.
 
   * ``GFP_KERNEL | __GFP_NOFAIL`` - overrides the default allocator behavior
     and all allocation requests will loop endlessly until they succeed.
-    This might be really dangerous especially for larger orders.
+    The allocator may provide access to memory that would otherwise be
+    reserved in order to satisfy this allocation which might adversely
+    affect other subsystems.  So it should only be used when there is no
+    reasonable failure policy and when the memory is likely to be freed
+    again in the near future.  Its use is strong discourage (via a
+    WARN_ON) for allocations larger than ``PAGE_ALLOC_COSTLY_ORDER``.
+    While this flag is best avoided, it is still preferable to endless
+    loops around the allocator.
 
 Selecting memory allocator
 ==========================
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 55b2ec1f965a..101479373738 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -209,6 +209,10 @@ struct vm_area_struct;
  * used only when there is no reasonable failure policy) but it is
  * definitely preferable to use the flag rather than opencode endless
  * loop around allocator.
+ * Use of this flag may provide access to memory which would otherwise be
+ * reserved.  As such it must be understood that there can be a cost imposed
+ * on other subsystems as well as the obvious cost of placing the calling
+ * thread in an uninterruptible indefinite wait.
  * Using this flag for costly allocations is _highly_ discouraged.
  */
 #define __GFP_IO	((__force gfp_t)___GFP_IO)


