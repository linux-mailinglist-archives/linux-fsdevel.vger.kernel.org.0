Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA2677A28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 12:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjAWL3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 06:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjAWL3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:29:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F111175
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 03:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674473326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhjpmPphVZgxtbvCpAWOcT3o4IDYXOiVakOwSPSv1cs=;
        b=RSBGCZLigQNFoIFIaIwAb4w43He0Y2fzXM6wlm5BB/hqWI4tkJEaCYTjBoii8KYRe4z9GR
        HchE/unh/yRKR1cihkxfXfx2CCFFP8BrmnfyjOvq4zUtqucv7fQd9cinFxeniXQaJCr5ro
        SwObTNnSfKM2G71TesXVnseDgBM4Gw8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-BUh8Pd4sOre-dUFLvGzMcQ-1; Mon, 23 Jan 2023 06:28:43 -0500
X-MC-Unique: BUh8Pd4sOre-dUFLvGzMcQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F3F6385F362;
        Mon, 23 Jan 2023 11:28:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45469492B02;
        Mon, 23 Jan 2023 11:28:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8vjlH+w1sNBPJjU@infradead.org>
References: <Y8vjlH+w1sNBPJjU@infradead.org> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-7-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 6/8] block: Make bio structs pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3813653.1674473320.1@warthog.procyon.org.uk>
Date:   Mon, 23 Jan 2023 11:28:40 +0000
Message-ID: <3813654.1674473320@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this function:

	void __bio_release_pages(struct bio *bio, bool mark_dirty)
	{
		unsigned int gup_flags = bio_to_gup_flags(bio);
		struct bvec_iter_all iter_all;
		struct bio_vec *bvec;

		bio_for_each_segment_all(bvec, bio, iter_all) {
			if (mark_dirty && !PageCompound(bvec->bv_page))
				set_page_dirty_lock(bvec->bv_page);
	>>>>		page_put_unpin(bvec->bv_page, gup_flags);
		}
	}

that ought to be a call to bio_release_page(), but the optimiser doesn't want
to inline it:-/

I found the only way I can get the compiler to properly inline it without it
repeating the calculations is to renumber the FOLL_* constants down and then
make bio_release_page() something like:

	static inline __attribute__((always_inline))
	void bio_release_page(struct bio *bio, struct page *page)
	{
		page_put_unpin(page,
		    ((bio->bi_flags & (1 << BIO_PAGE_REFFED)) ? FOLL_GET : 0) |
		    ((bio->bi_flags & (1 << BIO_PAGE_PINNED)) ? FOLL_PIN : 0));
	}

I guess the compiler optimiser isn't perfect yet:-)

David

