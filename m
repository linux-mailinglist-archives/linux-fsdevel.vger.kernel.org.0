Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC36BA1FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCNWKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCNWJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5F28D0E
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678831723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+QymJ+GCZW28tJ8JK9HTXv9GxubpscA9882LeMgv9w=;
        b=R4DPIoMMJdtHq3Fq8tqDH20Nn4KnyRQMeqSTDr+drXH2CYu6mvzFmuNSrG0VCHbedwPZz6
        tSXQtxlsRxQlPQFuX1koYBsVnu03X/kpoKKW55iJ1AK5m4tbbvBs9xwk31bL1PetC0IOTN
        3/CQRBa3VTlAPmXb88qFxY3eWzs6JUQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-n0ZfiDmHMfGhrz83iRoe6A-1; Tue, 14 Mar 2023 18:08:40 -0400
X-MC-Unique: n0ZfiDmHMfGhrz83iRoe6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E35971C08798;
        Tue, 14 Mar 2023 22:08:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CADA6C164E7;
        Tue, 14 Mar 2023 22:08:37 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v18 11/15] block: Fix bio_flagged() so that gcc can better optimise it
Date:   Tue, 14 Mar 2023 22:07:53 +0000
Message-Id: <20230314220757.3827941-12-dhowells@redhat.com>
In-Reply-To: <20230314220757.3827941-1-dhowells@redhat.com>
References: <20230314220757.3827941-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix bio_flagged() so that multiple instances of it, such as:

	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
	    bio_flagged(bio, BIO_PAGE_PINNED))

can be combined by the gcc optimiser into a single test in assembly
(arguably, this is a compiler optimisation issue[1]).

The missed optimisation stems from bio_flagged() comparing the result of
the bitwise-AND to zero.  This results in an out-of-line bio_release_page()
being compiled to something like:

   <+0>:     mov    0x14(%rdi),%eax
   <+3>:     test   $0x1,%al
   <+5>:     jne    0xffffffff816dac53 <bio_release_pages+11>
   <+7>:     test   $0x2,%al
   <+9>:     je     0xffffffff816dac5c <bio_release_pages+20>
   <+11>:    movzbl %sil,%esi
   <+15>:    jmp    0xffffffff816daba1 <__bio_release_pages>
   <+20>:    jmp    0xffffffff81d0b800 <__x86_return_thunk>

However, the test is superfluous as the return type is bool.  Removing it
results in:

   <+0>:     testb  $0x3,0x14(%rdi)
   <+4>:     je     0xffffffff816e4af4 <bio_release_pages+15>
   <+6>:     movzbl %sil,%esi
   <+10>:    jmp    0xffffffff816dab7c <__bio_release_pages>
   <+15>:    jmp    0xffffffff81d0b7c0 <__x86_return_thunk>

instead.

Also, the MOVZBL instruction looks unnecessary[2] - I think it's just
're-booling' the mark_dirty parameter.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108370 [1]
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108371 [2]
Link: https://lore.kernel.org/r/167391056756.2311931.356007731815807265.stgit@warthog.procyon.org.uk/ # v6
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..d9d6df62ea57 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -229,7 +229,7 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
 
 static inline bool bio_flagged(struct bio *bio, unsigned int bit)
 {
-	return (bio->bi_flags & (1U << bit)) != 0;
+	return bio->bi_flags & (1U << bit);
 }
 
 static inline void bio_set_flag(struct bio *bio, unsigned int bit)

