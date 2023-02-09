Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C026908E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 13:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBIMc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 07:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjBIMcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:32:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647F32CFF6;
        Thu,  9 Feb 2023 04:32:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE13E5CD40;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675945928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBw2mKwxwDgZ9MmEYLF3uXUxcpgEyk/w50QsDQavJcg=;
        b=v6GgDNU+MhJNjuIqZeR2GDsqbgKAL5N53IszLSSmggeM4zWNvrhaMVw7QdntGN6x6mkRZ4
        kHhGE+YtFiK9Oez/9T0osX0D3TCULzLsCgB5ryyLSeDxbOEI9ial3c4TZA84HxVmgpmWVw
        qmsBc3DkBJWQcGVS6ocWXufIjhOANcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675945928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBw2mKwxwDgZ9MmEYLF3uXUxcpgEyk/w50QsDQavJcg=;
        b=FXzFE75rONNstK0dAb8pdabXTcPsgPdOf7HLiGsW7rBJYR8BdI7BtAupJeqU/W6LhEqadu
        vwLD/y6aTFXNBgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF39D13A1F;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C4+tLsjn5GO/WQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 12:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8147AA06E1; Thu,  9 Feb 2023 13:32:06 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Date:   Thu,  9 Feb 2023 13:31:53 +0100
Message-Id: <20230209123206.3548-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209121046.25360-1-jack@suse.cz>
References: <20230209121046.25360-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=jack@suse.cz; h=from:subject; bh=b7iWQ5YfsZfndhNXL2+FDh805OZp7+Jpf46CR42PtdM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj5Oe57YRO7wzPJ42BfBm4SCprTnrfRpao4H5EH7xY gEZK6vuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY+TnuQAKCRCcnaoHP2RA2eMkCA DQnl4xH8vfdjSnutnULcqLL8Kq9ezcxTZO+bmhLzhnB7NAUjaACISpKijC086nmf0oiqZyqw90ylDw xpHWrFqToRVH1JrPM/P4aQEtCx8JGPO5utUYKImRrVa/2yLIWj1HVg7OAvgdhRpyt8U7C+nNQD1CPu NWNp5FUzSRyME02NaLU7Aji4OJTrN2fgIBFy1GX589g5nZBQDVMZI/NoY53I5pZk0d3h2yIwZJQt8L n2+UtOXc93bEka4NlcXi96gSH0OVyPtA5HivV03nc666TdEAf9DJC3TfyXp+QMB1Q+da4btV0UZS/j isheyYFhZduxQ4X6KGmoKYo7fny8/8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf3eedf0209c..ab3911a8b116 100644
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
+		 * pinning process is that may upset the filesystem.
+		 */
+		if (folio_maybe_dma_pinned(folio))
+			goto activate_locked;
+
 		mapping = folio_mapping(folio);
 		if (folio_test_dirty(folio)) {
 			/*
-- 
2.35.3

