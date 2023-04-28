Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0664D6F184B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjD1Mmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346113AbjD1Mmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:42:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FFD26BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 05:42:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51B7121F42;
        Fri, 28 Apr 2023 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682685705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aeFFTFYKMtDVQ6F3/9oAFwX26oySNi64w+5WjgKZrg4=;
        b=L9BHsLEz0vERc36POhCu0GVDD990fmyjZEYv/UOC+BF8g7nPwXJvv3AnTOlKDj521EBiXr
        T7JoDCN2tLXiPiv5vKyxTRbjevCx+XEX0UJ753ecd3vvLGVcTiIbbW2V3vI9hIX0xU8Ppd
        5gGLPopwKbrPAYVS5VlJhUpa9xOmfrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682685705;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aeFFTFYKMtDVQ6F3/9oAFwX26oySNi64w+5WjgKZrg4=;
        b=nTRLgnoawPqf+PggXAFsoC/WWcGvH+GkTTjLR0R6+rCLk8oC/es+xX0/KiNSg8+qDLoXOE
        nAB6ly7w4am/xrDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4141D1390E;
        Fri, 28 Apr 2023 12:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rSPkDwm/S2TZAgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 12:41:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB9FBA0729; Fri, 28 Apr 2023 14:41:44 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-mm@kvack.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] mm: Do not reclaim private data from pinned page
Date:   Fri, 28 Apr 2023 14:41:40 +0200
Message-Id: <20230428124140.30166-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=jack@suse.cz; h=from:subject; bh=VhR45B065VmS3m1QAwuuueeTtqJBvGh05kRL+9zQOvI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkS7791o0ClFedJaG0n1Kh5ZzrZe52VXmFvp4V0/vf 5sh7IQ2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZEu+/QAKCRCcnaoHP2RA2UW6CA DWSYFyTiHP43msHY1/1+T7TJ8aLmgLu5LtlBRE5ZgyiwZ6JwvZJHxT5TkpRnRBpqa7my2w4ZG/VK04 FY7uPFYTbaJf9VeVjXNUwJqvc89uWyRWpiYHrCciQgFpJygMwsk6v1emH/jqPp9rJSr+2gsTYOrWj0 O5QYdk2ri6C6BM79qUUDCEoCzPG3+F61Ijnkmzs9mCReEwWaWWFgvrVA+5LrS2wa7EWTbVaMqJzgfo GvW3Z1vdcvyYWOwlafWggIrfhGMSUha67FY9ZAXJAsucjKQk45sjPbMhVGM77HkwmORWE6FEK8wG6K 3pnp54kpEHrnwTlsDAAQf/td2WcE5l
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the page is pinned, there's no point in trying to reclaim it.
Furthermore if the page is from the page cache we don't want to reclaim
fs-private data from the page because the pinning process may be writing
to the page at any time and reclaiming fs private info on a dirty page
can upset the filesystem (see link below).

Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/vmscan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

This was the non-controversial part of my series [1] dealing with pinned pages
in filesystems. It is already a win as it avoids crashes in the filesystem and
we can drop workarounds for this in ext4. Can we merge it please?

[1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf3eedf0209c..401a379ea99a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			}
 		}
 
+		/*
+		 * Folio is unmapped now so it cannot be newly pinned anymore.
+		 * No point in trying to reclaim folio if it is pinned.
+		 * Furthermore we don't want to reclaim underlying fs metadata
+		 * if the folio is pinned and thus potentially modified by the
+		 * pinning process as that may upset the filesystem.
+		 */
+		if (folio_maybe_dma_pinned(folio))
+			goto activate_locked;
+
 		mapping = folio_mapping(folio);
 		if (folio_test_dirty(folio)) {
 			/*
-- 
2.35.3

