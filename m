Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47112765919
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjG0QsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjG0QsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31C273D
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690476447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjRgRxQaqKNPsMMn79uPe+tvsQFX0TKmXt3XG72XTPI=;
        b=Pd+YcgvutUSVVOllu17TRVUnm1znExyjepnrmhsmn0qgC/BKv7jahdEAc13gylRK29JBu2
        Lu0SivYb5+zhCW88ZUoBRy5huuU8ADypZ1d4GSJnfPNAVccneSR/7WqS+H7cNMgSGRsDjq
        +Lqvt8+MZcuaIi1IzlIaHaUpl5jhE2U=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-k_2Eg7P3P0yHcS1pHedidA-1; Thu, 27 Jul 2023 12:47:23 -0400
X-MC-Unique: k_2Eg7P3P0yHcS1pHedidA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E199F29AA2C5;
        Thu, 27 Jul 2023 16:47:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 600AC492B02;
        Thu, 27 Jul 2023 16:47:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230727093529.f235377fabec606e16c20679@linux-foundation.org>
References: <20230727093529.f235377fabec606e16c20679@linux-foundation.org> <20230727161016.169066-1-dhowells@redhat.com> <20230727161016.169066-2-dhowells@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dhowells@redhat.com, Hugh Dickins <hughd@google.com>,
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
Content-ID: <175118.1690476440.1@warthog.procyon.org.uk>
Date:   Thu, 27 Jul 2023 17:47:20 +0100
Message-ID: <175119.1690476440@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> This is already in mm-unstable (and hence linux-next) via Hugh's
> "shmem: minor fixes to splice-read implementation"
> (https://lkml.kernel.org/r/32c72c9c-72a8-115f-407d-f0148f368@google.com)

And I've already reviewed it:-)

David

