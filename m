Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2E717A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 10:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjEaIhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 04:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjEaIhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 04:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34839188
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685522164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2ZwdaLGqkNgpQd/gtgsXYogAn46nzSogOGGTIXtoVA=;
        b=M73s+6SiBFyhptqAx6InFyD8MrVfdegj9A5R8eoA8VeXThd4GtBP8R3E9EiHJ8oYIHSrHR
        XxY/UGZixf1layWXBWO8dqzdhS10Q9rICW99/qKKOZX/juFWn7MDx6+NoN50ZXVPnz0tt1
        2XHUWomkXQaeZkfg2f6+QYpeaqroxfQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-akBoGxAJNLKPo3Ap7wG4_g-1; Wed, 31 May 2023 04:35:59 -0400
X-MC-Unique: akBoGxAJNLKPo3Ap7wG4_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0837B800159;
        Wed, 31 May 2023 08:35:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32053112132C;
        Wed, 31 May 2023 08:35:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <cbd39f94-407a-03b6-9c43-8144d0efc8bb@redhat.com>
References: <cbd39f94-407a-03b6-9c43-8144d0efc8bb@redhat.com> <20230526214142.958751-1-dhowells@redhat.com> <20230526214142.958751-2-dhowells@redhat.com>
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
Content-ID: <510964.1685522152.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 31 May 2023 09:35:52 +0100
Message-ID: <510965.1685522152@warthog.procyon.org.uk>
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

> > Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a poi=
nter
> > to it from the page tables and make unpin_user_page*() correspondingly
> > ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning =
a
> > zero page's refcount as we're only allowed ~2 million pins on it -
> > something that userspace can conceivably trigger.
> =

> 2 millions pins (FOLL_PIN, which increments the refcount by 1024) or 2 m=
illion
> references ?

Definitely pins.  It's tricky because we've been using "pinned" to mean he=
ld
by a refcount or held by a flag too.

2 million pins on the zero page is in the realms of possibility.  It only
takes 32768 64-page DIO writes.

> > @@ -3079,6 +3096,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
> >    *
> >    * FOLL_PIN means that the pages must be released via unpin_user_pag=
e(). Please
> >    * see Documentation/core-api/pin_user_pages.rst for further details=
.
> > + *
> > + * Note that if a zero_page is amongst the returned pages, it will no=
t have
> > + * pins in it and unpin_user_page() will not remove pins from it.
> >    */
> =

> "it will not have pins in it" sounds fairly weird to a non-native speake=
r.

Oh, I know.  The problem is that "pin" is now really ambiguous.  Can we ch=
ange
"FOLL_PIN" to "FOLL_NAIL"?  Or maybe "FOLL_SCREW" - your pages are screwed=
 if
you use DIO and fork at the same time.

> "Note that the refcount of any zero_pages returned among the pinned page=
s will
> not be incremented, and unpin_user_page() will similarly not decrement i=
t."

That's not really right (although it happens to be true), because we're
talking primarily about the pin counter, not the refcount - and they may b=
e
separate.

David

