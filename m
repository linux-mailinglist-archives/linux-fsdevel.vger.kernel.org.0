Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40068318D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjAaPc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjAaPc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:32:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF62E7ED9;
        Tue, 31 Jan 2023 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Prqc74eAinoD4zprfpPJbe6K3qBobg/zze6cxcfp8s=; b=gZsdQl0wB6R57mjc3cqTuc6LGj
        zt2iEhUI4JQFk0mtu93a6KIbMq4FiEd9yO8qR2m6/Mfo8Wofqs0NGoa9u983bzRKXcnBRrUQaXTL1
        p1dE8WlhYlXpabpq8+Zx2iyDYZydvXJ7jsjc+ksoiQzo/wyyfs7xa0M94gbQ9z7EtWUCYmjjIaDEN
        CnK0Pa7In0p7/0xzqMLQNrb54Z/8ln6J9s1nS/VhF8X9QMxfOqfmUM7wnvuVkoXCdFQBtuqUm2KZK
        vxLfY9Eno1dX8D3ntbsAD0gTRSifWm4xlMy7O5h8FOHQGR3CsmXRJWK/EE9aPk4zqr4JFoKDovU5A
        K8sA6ICw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMsDA-00BOSx-Iz; Tue, 31 Jan 2023 15:06:16 +0000
Date:   Tue, 31 Jan 2023 15:06:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+707bba7f823c7b02fa43@syzkaller.appspotmail.com>,
        almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
        dchinner@redhat.com, hirofumi@mail.parknet.co.jp, jack@suse.com,
        jfs-discussion@lists.sourceforge.net, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, shaggy@kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfsplus?] [udf?] [fat?] [jfs?] [vfs?] [hfs?] [exfat?]
 [ntfs3?] WARNING in __mpage_writepage
Message-ID: <Y9kuaBgXf9lKJ8b0@casper.infradead.org>
References: <0000000000006b2ca005f38c7aeb@google.com>
 <20230131121423.pqfogvntzouymzmv@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131121423.pqfogvntzouymzmv@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:14:23PM +0100, Jan Kara wrote:
> This is the warning Willy has added as part of "mpage: convert
> __mpage_writepage() to use a folio more fully" and that warning can indeed
> easily trigger. There's nothing that serializes writeback against racing
> truncate setting new i_size so it is perfectly normal to see pages beyond
> EOF in this place. And the traditional response to such pages is "silently
> do nothing" since they will be soon discarded by truncate_inode_pages().

Absolutely right.  Not sure what I was thinking; I may have been
confused by the label being called "confused".  How about this for
Andrew to squash into that commit?

diff --git a/fs/mpage.c b/fs/mpage.c
index 2efa393f0db7..89bcefb4553a 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -559,6 +559,9 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	first_unmapped = page_block;
 
 page_is_mapped:
+	/* Don't bother writing beyond EOF, truncate will discard the folio */
+	if (folio_pos(folio) >= i_size)
+		goto confused;
 	length = folio_size(folio);
 	if (folio_pos(folio) + length > i_size) {
 		/*
@@ -570,8 +573,6 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		 * written out to the file."
 		 */
 		length = i_size - folio_pos(folio);
-		if (WARN_ON_ONCE(folio_pos(folio) >= i_size))
-			goto confused;
 		folio_zero_segment(folio, length, folio_size(folio));
 	}
 
