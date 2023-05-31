Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713CB7179E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 10:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjEaIVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjEaIVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 04:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29087132
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685521250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2xqQ8QtVhR4dtUGdOzaqMX0PFWzp9qZzhrt4LUFs0A=;
        b=Gn/rRNW95KVJNfpu7TNjjMaqKBK012wD1Q5z5hQ0Il0mOs5xI1PMhas6HNspMcoK1czpKy
        QZRe7+Aj0GhTC1H3ZcglDlejIU4sC1XiCPisKHdqCbXX+CQ3sQYnR7grcRRWXrgKRbNs23
        XPwN3dX/TkEt8ER7DQNFDYkGeW7uOmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-Q1l0x163N-GW70wGNxEGmQ-1; Wed, 31 May 2023 04:20:45 -0400
X-MC-Unique: Q1l0x163N-GW70wGNxEGmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E31F085A5A8;
        Wed, 31 May 2023 08:20:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CBD0112132C;
        Wed, 31 May 2023 08:20:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <de425aeb-4064-733a-52ed-e702c640c36f@redhat.com>
References: <de425aeb-4064-733a-52ed-e702c640c36f@redhat.com> <20230526214142.958751-1-dhowells@redhat.com> <20230526214142.958751-3-dhowells@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: Provide a function to get an additional pin on a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510618.1685521238.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 31 May 2023 09:20:38 +0100
Message-ID: <510619.1685521238@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> > Provide a function to get an additional pin on a page that we already =
have
> > a pin on.  This will be used in fs/direct-io.c when dispatching multip=
le
> > bios to a page we've extracted from a user-backed iter rather than red=
oing
> > the extraction.
> > =

> =

> I guess this function is only used for "replicating" an existing pin, an=
d not
> changing the semantics of an existing pin: something that was pinned
> !FOLL_LONGTERM cannot suddenly become effectively pinned FOLL_LONGTERM.
> =

> Out of curiosity, could we end up passing in an anonymous page, or is th=
is
> almost exclusively for pagecache+zero pages? (I rememebr John H. had a s=
imilar
> patch where he said it would not apply to anon pages)

It has to be able to handle anything in a process's VM that you can
legitimately use as the buffer for a DIO read/write.  If we can get a pin =
on
it from pin_user_pages_fast(), then we need to be able to get an additiona=
l
pin on it.  For the moment it's just in the old DIO stuff, but it will alm=
ost
certainly be necessary in the networking code too to handle splicing into
network packets.

David

