Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4975C73D755
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 07:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFZFzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 01:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZFzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:55:37 -0400
X-Greylist: delayed 804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 22:55:35 PDT
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E905AB;
        Sun, 25 Jun 2023 22:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687758928; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EgqXIH866ELXGq+mpnR4Eo84d907wx4Op+QW5TGOxwRYybbzxwCaqR/QYoo2XHE3sO
    O8hxtrXLtTHIKU2ZSBQKVXcar1ffNhS9uaOvq5SZcIYgfq066kD30uakd8cgODyZMSWd
    Ux0ZFlR6CCQ7fQHYdrqA18kl3kkP5qKnhX5pWIrTDCffwGIJkgnmisTiasfVOc7XR/pz
    wrTKKyIlXdadrwbSTzMXh9GP84vS/ntzDyxuCnw6yI45EdbvJQ9Bvk4S/W3gikyM2yaj
    oNGWiiMM9bhmILZyjElRBDxqmMeAOJfrDumjbsZ8OHlkl86AV71G5hp7wxpDbgjWrruK
    l8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758928;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9JeG8e5YLzIlPXpqO3TJNmd5ODQ+yL/DZJEHg5yXjTE=;
    b=nWoxz5+A/k/RoHG4mmlMrqdSxOOlepNMU8x2QAvJSBtskui+vKEENoLsTc3YTi0hA1
    rPHIzgcl4pBcyJ13X8nDzxUVYmQ4TdvR+y/1AfzGE/l0OBTrb46q2yed4ZXXAgoucuKo
    QttaxXBoGpAweZPDrnQLv1Q14b/XjIrZ7Mqf8Q55pfG3Zs9H8gAll+mZnlzmB4ew5Eif
    fZ3/sAh0WZcgWc9C4aMZ9WgR8FzY8czcPNOD9Rp4d61jOnSyCL3np43woSxh5VgFXtxz
    wQV6b1DDGhYPqdVJtF52We3PeLIZEjiFpGmNnnCw1ZbYrJTRrFt6wkB5cQkXeuyjHigx
    cJqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758928;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9JeG8e5YLzIlPXpqO3TJNmd5ODQ+yL/DZJEHg5yXjTE=;
    b=bhHuxVIF+VVHUfX01w2F4AvCX8xSsCAen9xIdGzxz7X79QsodQ+Qe5KOE7Z44hAggk
    1NyB5d6YbDMuDUBSN0ZrIKqN/yanGQHGKXLGer0DkdgWTqfUiGsQ9t6g4zRRCjp/sdS2
    6/c1M/z7gswtwjnPVuyRhdYI4CYQbWEnLrNJ8QxHEyoNDSCwiL26X1JJkpwUE8KcL7m0
    vcMwKFocz7beTTJC+PXYEG8reeORzxxr4uc2Gfy/KH7NwGjvCVbMPc7zIbl13rQd6Q+H
    xl/OEcL4fwFz7LyLsqmzXbeo7n0ItnBLYDjgDlQ+OYmvkrSTR+iX3lRbMw90sqWguYBM
    +lKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687758928;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9JeG8e5YLzIlPXpqO3TJNmd5ODQ+yL/DZJEHg5yXjTE=;
    b=leG3fCEvi5hPT0fBTmq9D2X7bfNIhUAhanHELXceIBPiOCl+GQkXnfPaQBd83VSROr
    xP02/5ZSkcyBilmaNbAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RrW5o+P9bSFaHg+gZu+uCjL2b+VQTRnVQrIOQ=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5Q5tRVy5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Jun 2023 07:55:27 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [RESEND PATCH v3 1/2] fs/buffer: clean up block_commit_write
Date:   Mon, 26 Jun 2023 07:55:17 +0200
Message-Id: <20230626055518.842392-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626055518.842392-1-beanhuo@iokpp.de>
References: <20230626055518.842392-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Originally inode is used to get blksize, after commit 45bce8f3e343
("fs/buffer.c: make block-size be per-page and protected by the page lock"),
__block_commit_write no longer uses this parameter inode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 fs/buffer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c..50821dfb02f7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2180,8 +2180,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-static int __block_commit_write(struct inode *inode, struct folio *folio,
-		size_t from, size_t to)
+static int __block_commit_write(struct folio *folio, size_t from, size_t to)
 {
 	size_t block_start, block_end;
 	bool partial = false;
@@ -2277,7 +2276,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
 	flush_dcache_folio(folio);
 
 	/* This could be a short (even 0-length) commit */
-	__block_commit_write(inode, folio, start, start + copied);
+	__block_commit_write(folio, start, start + copied);
 
 	return copied;
 }
@@ -2601,8 +2600,7 @@ EXPORT_SYMBOL(cont_write_begin);
 int block_commit_write(struct page *page, unsigned from, unsigned to)
 {
 	struct folio *folio = page_folio(page);
-	struct inode *inode = folio->mapping->host;
-	__block_commit_write(inode, folio, from, to);
+	__block_commit_write(folio, from, to);
 	return 0;
 }
 EXPORT_SYMBOL(block_commit_write);
@@ -2650,7 +2648,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 
 	ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
 	if (!ret)
-		ret = __block_commit_write(inode, folio, 0, end);
+		ret = __block_commit_write(folio, 0, end);
 
 	if (unlikely(ret < 0))
 		goto out_unlock;
-- 
2.34.1

