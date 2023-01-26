Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14467CA1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 12:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjAZLiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 06:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbjAZLh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A4B63866
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674733021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9FRl41p64Ud/HRzHE5h1fusxqR/GCP1j261G7nqW3g=;
        b=Ievgs7RxC6al+w7cyWRM/rhl1fPHkBu2Shtf8voijLZLtbrtkxO1OuywO2E2eULVZUKsWF
        DRYqNPyx/yWz29aQWr7o5pnxkilQzMF87IqOBq9tiRD+ZvEokQeKU5S5ngcGCsEQaukgYY
        4QmLCb9B/sa95kXyqtyF0pXziHT4m7w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-StJRgiH8Of6no2tYNCqZVg-1; Thu, 26 Jan 2023 06:36:58 -0500
X-MC-Unique: StJRgiH8Of6no2tYNCqZVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0391E101A521;
        Thu, 26 Jan 2023 11:36:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18ACB492B01;
        Thu, 26 Jan 2023 11:36:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230125210657.2335748-3-dhowells@redhat.com>
References: <20230125210657.2335748-3-dhowells@redhat.com> <20230125210657.2335748-1-dhowells@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v10 2/8] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2642249.1674733015.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 26 Jan 2023 11:36:55 +0000
Message-ID: <2642250.1674733015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iov_iter_extract_kvec_pages() isn't quite right.  The problem is that ther=
e's
not currently any path by which it can be tested, as currently
iov_iter_get_pages*() balk at it, but I managed to do that by piggybacking
some testing code on my cifs patches.

The attached change fixes the problem.

David

--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2080,9 +2080,9 @@ static ssize_t iov_iter_extract_kvec_pages(struct io=
v_iter *i,
 		skip =3D 0;
 	}
 =

-	offset =3D skip % PAGE_SIZE;
+	kaddr =3D i->kvec->iov_base + skip;
+	offset =3D (unsigned long)kaddr & ~PAGE_MASK;
 	*offset0 =3D offset;
-	kaddr =3D i->kvec->iov_base;
 =

 	maxpages =3D want_pages_array(pages, maxsize, offset, maxpages);
 	if (!maxpages)

