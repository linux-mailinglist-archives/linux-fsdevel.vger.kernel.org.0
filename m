Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B5765C6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjG0TuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjG0TuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6330CA
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690487352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhKBfrs7PWxagBM4M/4Uh0236cjqOcIxZ56PmZEdO5Q=;
        b=CDWpo489G/Kvo327LcneaKGL4uCx87Aj78cmwvPf9fT/dQLsM1RaV/LjTmgBZdZ9q9Uwx1
        /E7eFH4v33eS2SdATFFnP97UiZQoW44PVNRTswvdrRVOUqScLnJVe37UOmht9e16vgi8p7
        af9Ox8/c8nFx3c9/BYaSeXslEGfaYZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-o54PgO0nPbi9ttTz3960KA-1; Thu, 27 Jul 2023 15:49:06 -0400
X-MC-Unique: o54PgO0nPbi9ttTz3960KA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2441B185A7BC;
        Thu, 27 Jul 2023 19:49:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECB371121330;
        Thu, 27 Jul 2023 19:49:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b0d380c-d5d6-6ab1-67b5-8dc514127f8f@google.com>
References: <b0d380c-d5d6-6ab1-67b5-8dc514127f8f@google.com> <20230727093529.f235377fabec606e16c20679@linux-foundation.org> <20230727161016.169066-1-dhowells@redhat.com> <20230727161016.169066-2-dhowells@redhat.com> <175119.1690476440@warthog.procyon.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] shmem: Fix splice of a missing page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <178882.1690487342.1@warthog.procyon.org.uk>
Date:   Thu, 27 Jul 2023 20:49:02 +0100
Message-ID: <178883.1690487342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugh Dickins <hughd@google.com> wrote:

> On Thu, 27 Jul 2023, David Howells wrote:
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > This is already in mm-unstable (and hence linux-next) via Hugh's
> > > "shmem: minor fixes to splice-read implementation"
> > > (https://lkml.kernel.org/r/32c72c9c-72a8-115f-407d-f0148f368@google.com)
> > 
> > And I've already reviewed it:-)
> 
> I'm not sure whether that ":-)" is implying (good-natured) denial.

I've reviewed it, and the review still seems good.

> You reviewed the original on 17 April, when Jens took it into his tree;
> then it vanished in a rewrite, and you didn't respond when I asked about
> that on 28 June;

I missed it in the rush to try and get everything debugged during the merge
window prior to going on holiday.

> then you were Cc'ed when I sent it to Andrew on 23 July (where I explained
> about dropping two mods but keeping your Reviewed-by).

Hmmm...  I don't find that one in my inbox.

> This version that Andrew has in mm-unstable includes the hwpoison fix
> that we agreed on before, in addition to the len -> part fix.

Ok.

David

