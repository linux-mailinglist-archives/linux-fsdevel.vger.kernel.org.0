Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B11A679BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjAXO0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjAXO0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A648609
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674570337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XO5A6WAtDgp5br3HLb+4sHFyIh5WN7cTJ94YiThUnn4=;
        b=GRkCMYlLlf3+82wbK1tmYHWnoEc0mRLek28ILdi08qv8IfqEiO/zuUFgYAtRWt/d3XDbjj
        e/T81+obfYKS7ycXK9f+OUuseY5LH4Gi5Ed5F3G9aN2XlZ6We4FhGjAbCiHlxLcT8aprWZ
        1TiSvg/pWaR4q+mYtEf75DC58x9306o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-vsV2wBhuNOufnzk2IHIz6w-1; Tue, 24 Jan 2023 09:25:15 -0500
X-MC-Unique: vsV2wBhuNOufnzk2IHIz6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 405A385C064;
        Tue, 24 Jan 2023 14:25:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0FA040AE1E9;
        Tue, 24 Jan 2023 14:25:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/njtHRF/dXM+cx@infradead.org>
References: <Y8/njtHRF/dXM+cx@infradead.org> <Y8/lEVirzumLn4OG@infradead.org> <Y8/hhvfDtVcsgQd6@nvidia.com> <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com> <852117.1674567983@warthog.procyon.org.uk> <852914.1674568628@warthog.procyon.org.uk> <859186.1674569545@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <863856.1674570312.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 14:25:12 +0000
Message-ID: <863857.1674570312@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > > With the latest series we don't need PAGE_CLEANUP_PUT at all.
> > 
> > We will when it comes to skbuffs.
> 
> I'm a little doubtful of that.

skbuff fragments will be and will have to be a mixture of allocated pages that
need putting and pinned or non-ref'd and non-pinned zerocopy stuff.  I have
posted a patch that works for the limited amount of driverage that I use on my
test machine.

Think network filesystem messages where you have a mixture of protocol bits
generated by the kernel and data provided by direct I/O being sent by zerocopy
(libceph, for example).

David

