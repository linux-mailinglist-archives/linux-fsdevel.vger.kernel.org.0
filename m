Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B258CA94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiHHOeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbiHHOd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3980611C00
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659969237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vZrPp9M6+vQgqOZFpLy5S17BII/izqfOFe7C4MphlAA=;
        b=IzKQkckjXl2BIPbxkXSzDVn5WOtMiFDoTHfeL4Xc0RPocYQq8b1u/kkNmcsIvElBBug9AQ
        j0zHn5JUEQvtbjV4950F+4pAiSaLyr+bnXj9etcPwPBqUA+9L2RLVqdMxG8EUilVX3bqIv
        Kv07mNuixsWxw2ycjNnhgY0C8zS/VeU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-Q4GmpSw3PZm0JNiAEKFwlQ-1; Mon, 08 Aug 2022 10:33:53 -0400
X-MC-Unique: Q4GmpSw3PZm0JNiAEKFwlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B75E738173C3;
        Mon,  8 Aug 2022 14:33:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C997D2026D4C;
        Mon,  8 Aug 2022 14:33:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cifs: Remove {cifs,nfs}_fscache_release_page()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     Jeff Layton <jlayton@redhat.com>,
        Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 08 Aug 2022 15:33:51 +0100
Message-ID: <165996923111.209242.10532553567023183407.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove {cifs,nfs}_fscache_release_page() from fs/cifs/fscache.h.  This
functionality got built directly into cifs_release_folio() and will
hopefully be replaced with netfs_release_folio() at some point.

The "nfs_" version is a copy and paste error and should've been altered to
read "cifs_".  That can also be removed.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: linux-cifs@vger.kernel.org
cc: samba-technical@lists.samba.org
cc: linux-fsdevel@vger.kernel.org
---

 fs/cifs/fscache.h |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index aa3b941a5555..67b601041f0a 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -108,17 +108,6 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
 		__cifs_readpage_to_fscache(inode, page);
 }
 
-static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	if (PageFsCache(page)) {
-		if (current_is_kswapd() || !(gfp & __GFP_FS))
-			return false;
-		wait_on_page_fscache(page);
-		fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
-	}
-	return true;
-}
-
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
@@ -154,11 +143,6 @@ cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 static inline
 void cifs_readpage_to_fscache(struct inode *inode, struct page *page) {}
 
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return true; /* May release page */
-}
-
 #endif /* CONFIG_CIFS_FSCACHE */
 
 #endif /* _CIFS_FSCACHE_H */


