Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24C57295B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 00:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiGLWco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiGLWco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:32:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A39BDBB2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 15:32:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 42B88338E1;
        Tue, 12 Jul 2022 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657665162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=djVB62Hyf3MJYjdVGCDxC+DCq9fAhm/sf6UrIyp92tE=;
        b=mzq2+oNeNjNQGLhmIiWn+VRqgKlNtjty50qCfWu59qWEUqRoxTHHOG+xQnXNT4NRLXzHqV
        6VvDp/qkfEvRvEYR+texdDibXC7WmkASfyIZaOAku24Y9yJ8w0DgBewyvDkUmz0ym0kNKR
        DV7CV1cnF5Ffz2EnrmSFXDCQauWE2IA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2E6972C141;
        Tue, 12 Jul 2022 22:32:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9DB7DA823; Wed, 13 Jul 2022 00:27:53 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] affs: replace kmap_atomic() with kmap_local_page()
Date:   Wed, 13 Jul 2022 00:27:44 +0200
Message-Id: <20220712222744.24783-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible. With kmap_local_page(), the mapping is per thread,
CPU local and not globally visible, like in this case around a simple
memcpy().

CC: Ira Weiny <ira.weiny@intel.com>
CC: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/affs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index cd00a4c68a12..92754c40c5cd 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -545,9 +545,9 @@ affs_do_readpage_ofs(struct page *page, unsigned to, int create)
 			return PTR_ERR(bh);
 		tmp = min(bsize - boff, to - pos);
 		BUG_ON(pos + tmp > to || tmp > bsize);
-		data = kmap_atomic(page);
+		data = kmap_local_page(page);
 		memcpy(data + pos, AFFS_DATA(bh) + boff, tmp);
-		kunmap_atomic(data);
+		kunmap_local(data);
 		affs_brelse(bh);
 		bidx++;
 		pos += tmp;
-- 
2.36.1

