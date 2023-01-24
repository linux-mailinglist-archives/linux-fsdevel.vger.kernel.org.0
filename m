Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71593679C3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjAXOms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjAXOma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:42:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7D84A203
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674571300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d37L5XoD9UmKyFiIbLoq3/jcaRqHcwYhpCXewMHEs3Q=;
        b=KulrHf7lP+O2hXR7K50RbiDBBbH6nmEw8/fQpA3fZYqdOWRw6FaBsDjFOcUV3ud+3r6m7J
        kf1sdXtPN2dnHFUTFuwYkONyYxJWdTfapjo2Puq6GSoS0VZElKy3T5UZpTJz0jsOnD8+2D
        qcOMYn28U6cc4PFdhB38A8K56fRq4s0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-jr89MHhgPKaL45ENIVsbsg-1; Tue, 24 Jan 2023 09:41:37 -0500
X-MC-Unique: jr89MHhgPKaL45ENIVsbsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC22D858F09;
        Tue, 24 Jan 2023 14:41:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4ED2026D2B;
        Tue, 24 Jan 2023 14:41:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <fc18c4c9-09f2-0ca1-8525-5ce671db36c5@redhat.com>
References: <fc18c4c9-09f2-0ca1-8525-5ce671db36c5@redhat.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-4-dhowells@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 03/10] mm: Provide a helper to drop a pin/ref on a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <874545.1674571293.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 14:41:33 +0000
Message-ID: <874546.1674571293@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> > Provide a helper in the get_user_pages code to drop a pin or a ref on =
a
> > page based on being given FOLL_GET or FOLL_PIN in its flags argument o=
r do
> > nothing if neither is set.
> =

> Does the FOLL_GET part still apply to this patch set?

Yes.  Christoph insisted that the bio conversion patch be split up.  That
means there's an interval where you can get FOLL_GET from that.  However,
since Jason wants to hide FOLL_PUT, this is going to have to be removed an=
d
the switching done in the bio code for the bio case (until that reduces to
just pinning) and the skbuff cleanup code (when that is eventually done - =
that
will have the possibility of skbuffs comprising a mix of ref'd, pinned and
unpinned data, albeit in separate fragments; I've posted patches that
illustrate this[1]).

David

https://lore.kernel.org/all/167391047703.2311931.8115712773222260073.stgit=
@warthog.procyon.org.uk/ [1] Patches 33-34

