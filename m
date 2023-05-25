Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53DF711192
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjEYRCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEYRB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651941AC
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685034071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2kW+rTE3/dBrTBKwDunnX8pfK/lEaBYR555nV9R9qVo=;
        b=D5HdflsrLNjo8gsUTkDcbcyYxM8Mfk28pupR31ZcayfjVHfoSoSn13dtcKoIiCKYzPa0HB
        X1xqkwC+JS4hZ/aU1z4fHlwE6mw0rxquyD+U5qnUbzGBeOKd/uYm9aqkqXZFn8dti59zi4
        Uu7MP/tdtzp3BTbcC9D2s1itRLwHWiE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624--3mXKAo5NJujWbM9vOOlyQ-1; Thu, 25 May 2023 13:01:04 -0400
X-MC-Unique: -3mXKAo5NJujWbM9vOOlyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1E26801224;
        Thu, 25 May 2023 17:01:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE582166B2E;
        Thu, 25 May 2023 17:01:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
References: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com> <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com> <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org> <3215177.1684918030@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Extending page pinning into fs/direct-io.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88982.1685034059.1@warthog.procyon.org.uk>
Date:   Thu, 25 May 2023 18:00:59 +0100
Message-ID: <88983.1685034059@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> We do have cases that try to use the page coloring that we support.

What do we gain from it?  Presumably since nothing is supposed to write to
that page, it can be shared in all the caches.

David

