Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF063604E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 14:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiKWNr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 08:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiKWNrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D311166
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 05:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669210521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fPZl80clgJEOhCWJTzGU2bHEtRGaUbcwve3HQWi3lhY=;
        b=NPQSCk205/3vekXujHsLrWZDC8yv/w81jDg/4IPxDlp7pnfQBHrMV6Ns41lxTbx/RLlKQj
        N1ZEPxXEPoYN3C4gn7H0egTTSfpCECvH0xC975MyiOoX1oJJCx1AGITgSM1XuJXUpS/p2w
        ugPvT07tyD6WqSwgN+nVsTr2+ov4S3g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-WdEaAAr1MUmDkjhNT0rVJw-1; Wed, 23 Nov 2022 08:35:20 -0500
X-MC-Unique: WdEaAAr1MUmDkjhNT0rVJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DF2C29DD9B1;
        Wed, 23 Nov 2022 13:35:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8EA2028E8F;
        Wed, 23 Nov 2022 13:35:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Should iov_iter_get_pages*() be EXPORT_SYMBOL_GPL?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1464423.1669210515.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 23 Nov 2022 13:35:15 +0000
Message-ID: <1464424.1669210515@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I recently posted an intended replacement[1] for iov_iter_get_pages*() whi=
ch,
instead of always just getting a ref on the pages it extracts from the
iterator it is given, will pin them or leave them unaltered (but still in =
the
list) as appropriate.

However, Christoph objected[2] to my using EXPORT_SYMBOL() with it on the
basis that:

	get_user_pages_fast, pin_user_pages_fast are very intentionally
	EXPORT_SYMBOL_GPL, which should not be bypassed by an iov_* wrapper.

but iov_iter_get_pages*() is EXPORT_SYMBOL(), so it's already possible to
bypass this restriction.  He has also raised other objections[3].

Should we then convert this to EXPORT_SYMBOL_GPL(), as per the attached pa=
tch?

Link: https://lore.kernel.org/r/166920902005.1461876.2786264600108839814.s=
tgit@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/Y3zFzdWnWlEJ8X8/@infradead.org/ [2]
Link: https://lore.kernel.org/lkml/20221025154143.GA25128@lst.de/ [3]
---
iov_iter: Mark iov_iter_get_pages2*() as EXPORT_SYMBOL_GPL()

iov_iter_get_pages2*() should be marked EXPORT_SYMBOL_GPL() as the use
get_user_pages_fast()[1].

Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/Y3zFzdWnWlEJ8X8/@infradead.org/ [1]
---
 iov_iter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 612fc9bf9881..02b02a5fece4 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1502,7 +1502,7 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i,
 =

 	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
 }
-EXPORT_SYMBOL(iov_iter_get_pages2);
+EXPORT_SYMBOL_GPL(iov_iter_get_pages2);
 =

 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
@@ -1519,7 +1519,7 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i=
,
 	}
 	return len;
 }
-EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
+EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc2);
 =

 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)

