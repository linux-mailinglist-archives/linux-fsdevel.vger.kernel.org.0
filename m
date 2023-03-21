Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C978E6C2667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 01:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCUAjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 20:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCUAjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F5199C3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679359133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wU5XOH729W23QeACiFkmwZYQQNEl+r3lctE+wUBurc=;
        b=DUZU28e42mxKSrAnEzdVdn34fVg0l2ISRZwmFmM9lEuOkNCdiMCQFBQRSF/aGaBt8TLQ49
        sYT3WNOZrDv1IYMfxtFyPWtlaIRavM/AZe9KAlszrJd6TvwMh/gQnZ69Jj9VncKTcehUOc
        MCgKJmPQNiOvawQqS9EhHbft35CCFms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-pOBDWDwgN5yYGvwt9d91KA-1; Mon, 20 Mar 2023 20:38:49 -0400
X-MC-Unique: pOBDWDwgN5yYGvwt9d91KA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13447800045;
        Tue, 21 Mar 2023 00:38:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F98F175AD;
        Tue, 21 Mar 2023 00:38:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6413675eedcfa_33bc9d208e9@willemb.c.googlers.com.notmuch>
References: <6413675eedcfa_33bc9d208e9@willemb.c.googlers.com.notmuch> <641361cd8d704_33b0cc20823@willemb.c.googlers.com.notmuch> <20230316152618.711970-1-dhowells@redhat.com> <20230316152618.711970-4-dhowells@redhat.com> <811534.1678992280@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 03/28] tcp: Support MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2040078.1679359126.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Mar 2023 00:38:46 +0000
Message-ID: <2040079.1679359126@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> David Howells wrote:
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > =

> > > The commit message mentions MSG_SPLICE_PAGES as an internal flag.
> > > =

> > > It can be passed from userspace. The code anticipates that and check=
s
> > > preconditions.
> > =

> > Should I add a separate field in the in-kernel msghdr struct for such =
internal
> > flags?  That would also avoid putting an internal flag in the same spa=
ce as
> > the uapi flags.
> =

> That would work, if no cost to common paths that don't need it.

Actually, it might be tricky.  __ip_append_data() doesn't take a msghdr st=
ruct
pointer per se.  The "void *from" argument *might* point to one - but it
depends on seeing a MSG_SPLICE_PAGES or MSG_ZEROCOPY flag, otherwise we do=
n't
know.

Possibly this changes if sendpage goes away.

> A not very pretty alternative would be to add an an extra arg to each
> sendmsg handler that is used only when called from sendpage.
> =

> There are a few other internal MSG_.. flags, such as
> MSG_SENDPAGE_NOPOLICY. Those are all limited to sendpage, and ignored
> in sendmsg, I think. Which would explain why it was clearly safe to
> add them.

Should those be moved across to the internal flags with MSG_SPLICE_PAGES?

David

