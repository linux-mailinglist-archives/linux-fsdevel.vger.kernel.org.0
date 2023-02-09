Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD76908DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 13:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjBIMc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 07:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjBIMcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:32:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6397023DBF;
        Thu,  9 Feb 2023 04:32:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A9A635CD3D;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675945928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QhZwB9U7b83UUjuf0FerFqngTCr+3tOZyqFA7jbxxWw=;
        b=UnoKA55DZCyI92tzkqVVWvljTVeb8GzneLp9fZD9LtZE7vFAo1oMrWiJl3sP5afaKNU5CZ
        gY3bcZSIrYa3b03Fg3NzT6MDXsH+19pHDzF4wTrRsrEHAkcfVmpc9/EvtJCkmognu1MAzU
        K/7YL9t8uyYZiLRBm/oobi1cf5ULHp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675945928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QhZwB9U7b83UUjuf0FerFqngTCr+3tOZyqFA7jbxxWw=;
        b=+UQmLWz5ID5aDnNFR4jFhyRmnHsPbR20qhz7V0/3UaMFWYEeECOhTH4zInmI3Q1AHyriO7
        n0Gb+RNdOXpe8lBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CFF5138E4;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nLtNJsjn5GO0WQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 12:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C450A06D8; Thu,  9 Feb 2023 13:32:06 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH RFC 0/5] Writeback handling of pinned pages
Date:   Thu,  9 Feb 2023 13:31:52 +0100
Message-Id: <20230209121046.25360-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=jack@suse.cz; h=from:subject:message-id; bh=FD3tsBd7xXXbKwex9PrXtOhdF1jN0T1qyzMIxfFavdQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj5Oel8IdyTOxSydblEscUFigdfJgN2ZSU6/K9BJ/M aLxM1kOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY+TnpQAKCRCcnaoHP2RA2fkAB/ 9sFUyN6fP03NQoam23qygpwii0em4S3TLu6xQFTSdcVVp78Esl2J4L1nVJbDc8cGIGBPTEErYPKbpj CXaqS8674vvwxZJEVkt9dLj8FNxKysfsMdQ91LmrwHjY7iEhLa8Rmz+uArXkgxNyqGrxbVRogOhWWg PmfMUGRLdCKcxiAcGJxfBziAVEpe9gafTcokar3q3cnaImh3NSezpM/dLzpRVVgoFIDiUIzQbPxF1X eXH/CGXkog0wW4BNg6vpq39Y6jpVJ7aQ+7MzPjzrbL/Vpy3j3JnhVbJiohtNrrTVIbs/yrBYolGyuN fDV7rJAu4sdkpS4u3MNdA+qKK7gSZb
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

Hello,

since we are slowly getting into a state where folios used as buffers for
[R]DMA are detectable by folio_maybe_dma_pinned(), I figured it is time we also
address the original problems filesystems had with these pages [1] - namely
that page/folio private data can get reclaimed from the page while it is being
written to by the DMA and also that page contents can be modified while the
page is under writeback.

This patch series is kind of an outline how the solution could look like (so
far only compile tested). The first two patches deal with the reclaim of page
private data for pinned pages.  They are IMO no-brainers and actually deal with
99% of the observed issues so we might just separate them and merge them
earlier. The remainder of the series deals with the concern that page contents
can be modified while the page is being written back. What it implements is
that instead we skip page cleaning writeback for pinned pages and if we cannot
avoid writing the page (data integrity writeback), we bite the bullet and
bounce the page.

Note that the conversion of clear_page_dirty_for_io() (and its folio variant)
is kind of rough and providing wbc to the function only in the obvious cases -
that will need a bit more work but OTOH functionally passing NULL just retains
the old behavior + WARNs if we actually see pinned page in the writeback path.

Opinions?

								Honza

[1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
