Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C56782EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjAWRU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjAWRUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E564684
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674494397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOoqxnL289W8RYJpdgnKmU7vs7+RtONm5/MOnF58uqA=;
        b=gcYYI2nv0G0NDHeTOjHEFy7hUkizXsFgK3MeEN/SYDOakdNfQpCeyV0WRyYzV8X7p+Ya+f
        RBWQKLR6fYzq2JshfbXZ4MI3LATFbs+DRwroyB01qTr5fxcxlmmOzU/3LlHlR7WM85L532
        1aEp1QQ5YiOiU6XBt/OjfShIVpnnrJg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-DQJIWadMMVONSMP0SVtNSQ-1; Mon, 23 Jan 2023 12:19:53 -0500
X-MC-Unique: DQJIWadMMVONSMP0SVtNSQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE35D3C10220;
        Mon, 23 Jan 2023 17:19:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1421492B02;
        Mon, 23 Jan 2023 17:19:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y865EIsHv3oyz+8U@casper.infradead.org>
References: <Y865EIsHv3oyz+8U@casper.infradead.org> <Y862ZL5umO30Vu/D@casper.infradead.org> <20230120175556.3556978-1-dhowells@redhat.com> <318138.1674491927@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <324814.1674494391.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Jan 2023 17:19:51 +0000
Message-ID: <324815.1674494391@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Wouldn't that potentially make someone's entire malloc() heap entirely=
 NOCOW
> > if they did a single DIO to/from it.
> =

> Yes.  Would that be an actual problem for any real application?

Without auditing all applications that do direct I/O writes, it's hard to
say - but a big database engine, Oracle for example, forking off a process=
,
say, could cause a massive slow down as fork suddenly has to copy a huge
amount of malloc'd data unnecessarily[*].

[*] I'm making wild assumptions about how Oracle's DB engine works.

> > Also you only mention DIO read - but what about "start DIO write; fork=
();
> > touch buffer" in the parent - now the write buffer belongs to the chil=
d
> > and they can affect the parent's write.
> =

> I'm struggling to see the problem here.  If the child hasn't exec'd, the
> parent and child are still in the same security domain.  The parent
> could have modified the buffer before calling fork().

It could still inadvertently change the data its parent set to write out. =
 The
child *shouldn't* be able to change the parent's in-progress write.  The m=
ost
obvious problem would be in something that does DIO from a stack buffer, I
think.

David

