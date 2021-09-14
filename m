Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA57340A1F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 02:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhINA3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 20:29:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhINA3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:29:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94D4E200AA;
        Tue, 14 Sep 2021 00:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631579280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fz478wuK2aqSUdVMTm0N58JnzuLLXcDfeQcH+i0TRAc=;
        b=xe9UJcFJ9/etWuZVpkedbCfZdZGh4I+9k/xRiVFR+eOLjUc/38MzmSICzhxCaBDieHWCCU
        IGfVi+k1JTkaS1tbSmYAM2N1g3fFIk1xYp+Z9Ww/PkVOo0+PW5yrER7llpNQuvMk4su7zT
        Bx3yl4AFRjURJB8UHQZi0ijxP89K9dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631579280;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fz478wuK2aqSUdVMTm0N58JnzuLLXcDfeQcH+i0TRAc=;
        b=Z5hLlNcuwJJinzCF56fW+4/hhbShZz4exvm5VcH5q6dN4x9juqo28ZwRLP51q89RkWh1Kh
        Pld6ww2EgjdayQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 386E713ADE;
        Tue, 14 Sep 2021 00:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5x0MOozsP2EiawAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 00:27:56 +0000
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>
Date:   Tue, 14 Sep 2021 10:13:04 +1000
Subject: [PATCH 2/6] MM: annotate congestion_wait() and wait_iff_congested()
 as ineffective.
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <163157838437.13293.15392955714346973750.stgit@noble.brown>
In-Reply-To: <163157808321.13293.486682642188075090.stgit@noble.brown>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only 4 subsystems call set_bdi_congested() or clear_bdi_congested():
 block/pktcdvd, fs/ceph fs/fuse fs/nfs

It may make sense to use congestion_wait() or wait_iff_congested()
within these subsystems, but they have no value outside of these.

Add documentation comments to these functions to discourage further use.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/backing-dev.h |    7 +++++++
 mm/backing-dev.c            |    9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index ac7f231b8825..cc9513840351 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -153,6 +153,13 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
 	return wb->congested & cong_bits;
 }
 
+/* NOTE congestion_wait() and wait_iff_congested() are
+ * largely useless except as documentation.
+ * congestion_wait() will (almost) always wait for the given timeout.
+ * wait_iff_congested() will (almost) never wait, but will call
+ * cond_resched().
+ * Were possible an alternative waiting strategy should be found.
+ */
 long congestion_wait(int sync, long timeout);
 long wait_iff_congested(int sync, long timeout);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4a9d4e27d0d9..53472ab38796 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1023,6 +1023,11 @@ EXPORT_SYMBOL(set_bdi_congested);
  * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) to exit
  * write congestion.  If no backing_devs are congested then just wait for the
  * next write to be completed.
+ *
+ * NOTE: in the current implementation, hardly any backing_devs are ever
+ * marked as congested, and write-completion is rarely reported (see calls
+ * to clear_bdi_congested).  So this should not be assumed to ever wake before
+ * the timeout.
  */
 long congestion_wait(int sync, long timeout)
 {
@@ -1054,6 +1059,10 @@ EXPORT_SYMBOL(congestion_wait);
  * The return value is 0 if the sleep is for the full timeout. Otherwise,
  * it is the number of jiffies that were still remaining when the function
  * returned. return_value == timeout implies the function did not sleep.
+ *
+ * NOTE: in the current implementation, hardly any backing_devs are ever
+ * marked as congested, and write-completion is rarely reported (see calls
+ * to clear_bdi_congested).  So this should not be assumed to sleep at all.
  */
 long wait_iff_congested(int sync, long timeout)
 {


