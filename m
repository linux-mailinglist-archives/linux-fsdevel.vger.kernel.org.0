Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D0167A464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjAXU4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjAXU4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F745086A
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 12:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674593721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNCOU909aa74UNFHbyBgSXR7UD8dRUqMYVcens2n3wM=;
        b=eHs5l4FNh0iLwRaXBUtwjsWYCHPkULJcW0WH+oYoi7cYsve2NFxgF1uFJshLU+oCgWLH74
        i2b8eVAv14FEumfyhTmKPiTAa4Y0CF5DlVRIRecq1ILah19eRJdFXfwyIJbLFO8ijvRE08
        8IcNERoF/jcXURjwpO3Zis6giD2jTls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-LmiuCjddOAS3qunVR-7sEA-1; Tue, 24 Jan 2023 15:55:15 -0500
X-MC-Unique: LmiuCjddOAS3qunVR-7sEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64F15811E6E;
        Tue, 24 Jan 2023 20:55:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88002492C14;
        Tue, 24 Jan 2023 20:55:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ad671496-2461-0b25-48c8-bf474fffe41d@nvidia.com>
References: <ad671496-2461-0b25-48c8-bf474fffe41d@nvidia.com> <20230124170108.1070389-1-dhowells@redhat.com> <20230124170108.1070389-5-dhowells@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v9 4/8] block: Fix bio_flagged() so that gcc can better optimise it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1297524.1674593711.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 20:55:11 +0000
Message-ID: <1297525.1674593711@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

John Hubbard <jhubbard@nvidia.com> wrote:

> I don't know how you noticed that this was even a problem! Neatly
> fixed.

I wanted BIO_PAGE_REFFED/PINNED to translate to FOLL_GET/PIN with no more than
a single AND instruction, assuming they were assigned to the same values (1 &
2), so I checked to see what assembly was produced by:

	gup_flags |= bio_flagged(bio, BIO_PAGE_REFFED) ? FOLL_GET : 0;
	gup_flags |= bio_flagged(bio, BIO_PAGE_PINNED) ? FOLL_PIN : 0;

Complicated though it looks, it should optimise down to something like:

	and $3,%eax

assuming something like REFFED/GET == 0x1 and PINNED/PIN == 0x2.

David

