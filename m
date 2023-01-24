Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59C679AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjAXNyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjAXNyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:54:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D0347EDD
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674568200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETrfxyrVdU7X1rX1QL9lvr6n2bGLp1QRnmU9FMajeiU=;
        b=B1PDOh9HCzImLPffXWtmONJJ3pTTcKvRkKqEswHWPNyhJJ/1D6cYue2jiC/yho7okCRJAF
        wFcrreEyU710Pd0MZDD0cs/p1u/mkW04H7j7p8FVQ3KUNw1mHbPn6zdwGX69n+wNmrsA32
        ByMNUkHnGSd0Ry98sIVi2UPgMN7BRMs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-YMTlk8RlN1GqCVMCLPBtqg-1; Tue, 24 Jan 2023 08:46:26 -0500
X-MC-Unique: YMTlk8RlN1GqCVMCLPBtqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D36318030CC;
        Tue, 24 Jan 2023 13:46:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E5D71121330;
        Tue, 24 Jan 2023 13:46:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/ZekMEAfi8VeFl@nvidia.com>
References: <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
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
Content-ID: <852116.1674567983.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 13:46:23 +0000
Message-ID: <852117.1674567983@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> wrote:

> Yeah, I already wrote a similar patch, using the 1<< notation, 
> splitting the internal/external, and rebasing on the move to
> mm_types.. I can certainly drop that patch if we'd rather do this.

Note that I've already given Andrew a patch to move FOLL_* to mm_types.h.

I'm happy to go with your patch on top of that if you can just renumber
FOLL_PIN to 0 and FOLL_GET to 1.

David

