Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB7718421
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjEaOEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbjEaODn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 10:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76721E5C
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685541345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ziEVWybyK4gf6HAMK2OABfQt5DxF+29cSopVoad9/Oc=;
        b=VdNy6ImN7yRO/8q2cf1GPEwLkgV2g7K2xyQXhWFRfIxiKhLGT3gbhHqmcRy23tzXKRcMk/
        hsPX3W1sML0o3Adg/tTuxhAv8u1dWeDliqVZb5MvMH8T/xu03Q7TdGmiILVROfEsCkZCJP
        9cYY2+FbOEHFL0IdNWtQHh6wiGYlLXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-8xAnoC19Ms-okkMyrsc2Qw-1; Wed, 31 May 2023 09:55:41 -0400
X-MC-Unique: 8xAnoC19Ms-okkMyrsc2Qw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5F228032E4;
        Wed, 31 May 2023 13:55:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E03D6C154D7;
        Wed, 31 May 2023 13:55:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <492558dc-1377-fc4b-126f-c358bb000ff7@redhat.com>
References: <492558dc-1377-fc4b-126f-c358bb000ff7@redhat.com> <cbd39f94-407a-03b6-9c43-8144d0efc8bb@redhat.com> <20230526214142.958751-1-dhowells@redhat.com> <20230526214142.958751-2-dhowells@redhat.com> <510965.1685522152@warthog.procyon.org.uk>
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <703627.1685541335.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 31 May 2023 14:55:35 +0100
Message-ID: <703628.1685541335@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> Yes, it would be clearer if we would be using "pinned" now only for FOLL=
_PIN

You're not likely to get that.  "To pin" is too useful a verb that gets us=
ed
in other contexts too.  For that reason, I think FOLL_PIN was a poor choic=
e of
name:-/.  I guess the English language has got somewhat overloaded.  Maybe
FOLL_PEG? ;-)

> and everything else is simply "taking a temporary reference on the page"=
.

Excluding refs taken with pins, many refs are more permanent than pins as,=
 so
far as I'm aware, pins only last for the duration of an I/O operation.

> >> "Note that the refcount of any zero_pages returned among the pinned p=
ages will
> >> not be incremented, and unpin_user_page() will similarly not decremen=
t it."
> > That's not really right (although it happens to be true), because we'r=
e
> > talking primarily about the pin counter, not the refcount - and they m=
ay be
> > separate.
> =

> In any case (FOLL_PIN/FOLL_GET) you increment/decrement the refcount. If=
 we
> have a separate pincount, we increment/decrement the refcount by 1 when
> (un)pinning.

FOLL_GET isn't relevant here - only FOLL_PIN.  Yes, as it happens, we coun=
t a
ref if we count a pin, but that's kind of irrelevant; what matters is that=
 the
effect must be undone with un-PUP.

It would be nice not to get a ref on the zero page in FOLL_GET, but I don'=
t
think we can do that yet.  Too many places assume that GUP will give them =
a
ref they can release later via ordinary methods.

David

