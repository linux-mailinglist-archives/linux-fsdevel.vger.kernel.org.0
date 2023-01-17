Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8366D80F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbjAQIXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjAQIW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8452748C
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 00:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673943699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97oI/IL5vpyW9d0mA0H44YuBpOV22dJNfei8BHRb/0U=;
        b=DcJUu0E8aF/LyuTsuPgiFPAA744G5U88Y79hoA/nG+3Nrul2ReXQDSinl76a2FPi5XBy4Y
        nVsBolOX4liCFa7sonX51a4S6o/V2CNu7tenfmDQWwT2oYpfin/uQN2iGNXt7sZWdHAlam
        ANUR9PxhfZNBTBS12fQX+mkiPRlhAB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-1PNR3G-BOvGdsrjjOi_D5g-1; Tue, 17 Jan 2023 03:21:33 -0500
X-MC-Unique: 1PNR3G-BOvGdsrjjOi_D5g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C5F580234E;
        Tue, 17 Jan 2023 08:21:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28E37492B10;
        Tue, 17 Jan 2023 08:21:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8ZWD82dvoulSG8k@infradead.org>
References: <Y8ZWD82dvoulSG8k@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391053934.2311931.17229969100836070492.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/34] mm: Provide a helper to drop a pin/ref on a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2330570.1673943691.1@warthog.procyon.org.uk>
Date:   Tue, 17 Jan 2023 08:21:31 +0000
Message-ID: <2330571.1673943691@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

> On Mon, Jan 16, 2023 at 11:08:59PM +0000, David Howells wrote:
> > Provide a helper in the get_user_pages code to drop a pin or a ref on a
> > page based on being given FOLL_GET or FOLL_PIN in its flags argument or do
> > nothing if neither is set.
> 
> Please don't add new page based helpers.

Yes, I know, but all of the callers still use pages, not folios.

David

