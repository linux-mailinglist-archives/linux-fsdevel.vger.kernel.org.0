Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E372FD50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbjFNLrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjFNLrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:47:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138A1BE9;
        Wed, 14 Jun 2023 04:46:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B36A82252F;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686743217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07KAYk4SthrO3fQhas82j8fyHpnc5bRMX3kImRSFlUk=;
        b=Kp7aqo3YOc2v6vzpWLCRu5NMYJAlqDzGoIt9Wywl4nnU5pIKA6Qwb4ilRVNtBBhd9MHd9w
        6/UkRMkd4j0A84amowZr76QsU7iDsm2fA4yXj/ZyudHg/ya/UFQkR8UOO5dO9C39N3Q/1U
        QbrCro1ElbWTz1c54Ht+1yJbolv1JH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686743217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07KAYk4SthrO3fQhas82j8fyHpnc5bRMX3kImRSFlUk=;
        b=MfAA5PP+8kGCQ480wk1yiwsSkZerT4G5Yj2tu2k3gsQaH3BqJvIm9L6eDGAgU2HXVRSSVC
        NzGXsfuur5b//HAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A41492C14F;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id A009C51C4E17; Wed, 14 Jun 2023 13:46:57 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 7/7] mm/readahead: align readahead down to mapping blocksize
Date:   Wed, 14 Jun 2023 13:46:37 +0200
Message-Id: <20230614114637.89759-8-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614114637.89759-1-hare@suse.de>
References: <20230614114637.89759-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the blocksize of the mapping is larger than the page size we need
to align down readahead to avoid reading past the end of the device.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 mm/readahead.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 031935b78af7..91a7dbf4fa04 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -285,6 +285,7 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 	struct inode *inode = ractl->mapping->host;
 	unsigned long index = readahead_index(ractl);
 	loff_t isize = i_size_read(inode);
+	unsigned int iblksize = i_blocksize(inode);
 	pgoff_t end_index;	/* The last page we want to read */
 
 	if (isize == 0)
@@ -293,6 +294,9 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 	end_index = (isize - 1) >> PAGE_SHIFT;
 	if (index > end_index)
 		return;
+	if (iblksize > PAGE_SIZE)
+		end_index = ALIGN_DOWN(end_index, iblksize);
+
 	/* Don't read past the page containing the last byte of the file */
 	if (nr_to_read > end_index - index)
 		nr_to_read = end_index - index + 1;
-- 
2.35.3

