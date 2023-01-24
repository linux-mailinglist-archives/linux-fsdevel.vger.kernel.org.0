Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1F679D11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjAXPNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 10:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjAXPNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A98A4B1A0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674573135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MHVYb+F+v1ly5jz020IbfY9LMW7KSn2BHzFvSpAZ9vY=;
        b=Z+5CId/xlkWr6HMO6gYZnJcydu+M9jjVU+E+PY2o2Mc1Tj0GqB3sqRHhIaDIj73LA0fMHj
        fnyy0opraKR07iiDx+pDlDxHxtQxpuraaKs6Qp7Yrj0c4Av/OVVF8vPRo03dP5t6iyqbQc
        U56wv1/LvaNJUXRABIqzVz8CeCg0YbQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-Zeki7l7aP_m9MDaf2hmA_A-1; Tue, 24 Jan 2023 10:12:13 -0500
X-MC-Unique: Zeki7l7aP_m9MDaf2hmA_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCD3C1871D94;
        Tue, 24 Jan 2023 15:12:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E3E2C15BA0;
        Tue, 24 Jan 2023 15:12:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/0CaBzL0VPyE2D@nvidia.com>
References: <Y8/0CaBzL0VPyE2D@nvidia.com> <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com> <852117.1674567983@warthog.procyon.org.uk> <852914.1674568628@warthog.procyon.org.uk> <859142.1674569510@warthog.procyon.org.uk> <864109.1674570473@warthog.procyon.org.uk> <875206.1674572365@warthog.procyon.org.uk>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dhowells@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
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
Content-ID: <876298.1674573129.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 15:12:09 +0000
Message-ID: <876299.1674573129@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> wrote:

> Isn't that this:
> 
> if (cleanup_flags & PAGE_CLEANUP_NEEDED)
>    gup_put_folio(folio, 1, cleanup_flags & PAGE_CLEANUP_UNPIN)
> 
> 
> ?

Yes.  As claimed, that would be three states.

> Three states - decr get, decr pinned, do nothing?

Yes.  Don't worry about it.  I'm not going to do it in gup.c.

David

