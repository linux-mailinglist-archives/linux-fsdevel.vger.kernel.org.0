Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0563B09BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhFVQCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 12:02:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55158 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhFVQCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:02:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D52421969;
        Tue, 22 Jun 2021 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624377622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1W/0v/vQfxGL6eOZngl0+8ELUUoab+oqUZvYfnAJG3o=;
        b=J2mDgggwCWET9zFUPajfXQgpVIEN1UKRKJJ4LnyI5Eeiys/pPJff+3uzGF9KZFS2e8Y2ME
        N7NG6ioYOwEgQ7vd6etpFUOBEZPBOYoVyQsDLa92UA/IwDTG0kfm+e1OEFP341DfZbU0Jt
        KHAe1Jk/YbiJEKhlvp/M2qKwDfMJhtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624377622;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1W/0v/vQfxGL6eOZngl0+8ELUUoab+oqUZvYfnAJG3o=;
        b=FK2MfB/e/nhp6xkH0s20PWuQiv4eh97FG9a3BNwlTJZC/nfHnaeFfhBdpeRwToSU7tXnnU
        iuVNLOdiCk8umzDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id EA24BA3B8E;
        Tue, 22 Jun 2021 16:00:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA2761E1515; Tue, 22 Jun 2021 18:00:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] dax: Fix ENOMEM handling in grab_mapping_entry()
Date:   Tue, 22 Jun 2021 18:00:15 +0200
Message-Id: <20210622160015.18004-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; h=from:subject; bh=6TMOKHIi6wiBQviWBONJJbsLIW+lhRS/aimVF7mj4HU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg0gjuu+bLgSFKbI0kx3Xq820Q9ucmjbhALiWEWF3Y nWT+KcaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYNII7gAKCRCcnaoHP2RA2Z0aCA CcPg+bzI4tfiFOvHvrUtDFL/qUOhji7n94AEVlb5jAdbnQF3jVGBAXzOAzpR4pCTL3YfUVkg8q83u8 CONxZizZ4srizqkF6DihkOq6clr+Qg6A3mz/qAX2kqEhJpymUZGGU91U3XMg3GLNN+wxPSst5IVqjV OnwTXxKD4mMhG4ycOhL307jj75f5FG6emfRSs6+FUvem/PFWV5bc8aWvXYSLCmq+wPT3ozPMlMkPJw QFGzRqTEi12fzFnZS7uwzh1hvzpra6l+0kZVRBUo2RXE80w9wZgJ3O1dfDYam5dwZqkQudZkNPQyNW KkBGriyobXzyhBMlfPmQTwOSe0OXf9
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

grab_mapping_entry() has a bug in handling of ENOMEM condition. Suppose
we have a PMD entry at index I which we are downgrading to a PTE entry.
grab_mapping_entry() will set pmd_downgrade to true, lock the entry,
clear the entry in xarray, and decrement mapping->nrpages. The it will
call:

	entry = dax_make_entry(pfn_to_pfn_t(0), flags);
	dax_lock_entry(xas, entry);

which inserts new PTE entry into xarray. However this may fail
allocating the new node. We handle this by:

	if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
		goto retry;

however pmd_downgrade stays set to true even though 'entry' returned
from get_unlocked_entry() will be NULL now. And we will go again through
the downgrade branch. This is mostly harmless except that
mapping->nrpages is decremented again and we temporarily have invalid
entry stored in xarray. Fix the problem by setting pmd_downgrade to
false each time we lookup the entry we work with so that it matches
the entry we found.

Fixes: b15cd800682f ("dax: Convert page fault handlers to XArray")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 62352cbcf0f4..da41f9363568 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -488,10 +488,11 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		struct address_space *mapping, unsigned int order)
 {
 	unsigned long index = xas->xa_index;
-	bool pmd_downgrade = false; /* splitting PMD entry into PTE entries? */
+	bool pmd_downgrade;	/* splitting PMD entry into PTE entries? */
 	void *entry;
 
 retry:
+	pmd_downgrade = false;
 	xas_lock_irq(xas);
 	entry = get_unlocked_entry(xas, order);
 
-- 
2.26.2

