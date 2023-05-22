Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF870C172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjEVOvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEVOvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 10:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69619BB
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684767013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYtoaiOBfTiLctYxaMtqzFI78VjutRXpKlguOTW1tdA=;
        b=g4CcVNma19LeQc75MhFRYpePhTCWRl7l9i50DqVqKA8ZiIF/jhZ10Y1uyJv/jKQje41wON
        yG8lIkRKjKJYjFnNRLmhJ3OoPeXCZ1exv9SK2EN491PMVOGlEFFWBQfPJIr5J1K+5lviy+
        +Ad6xJk82PT/43APxx66n87YFkk6q/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-vN46sNt1Pr-bP0jWnEdEQw-1; Mon, 22 May 2023 10:50:09 -0400
X-MC-Unique: vN46sNt1Pr-bP0jWnEdEQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95F5A800BFF;
        Mon, 22 May 2023 14:50:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA1DC1121314;
        Mon, 22 May 2023 14:50:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230522102920.0528d821@rorschach.local.home>
References: <20230522102920.0528d821@rorschach.local.home> <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-24-dhowells@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v20 23/32] splice: Convert trace/seq to use direct_splice_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2812411.1684767005.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 22 May 2023 15:50:05 +0100
Message-ID: <2812412.1684767005@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:

> > In the future, something better can probably be done by gifting pages =
from
> > seq->buf into the pipe, but that would require changing seq->buf into =
a
> > vmap over an array of pages.
> =

> If you can give me a POC of what needs to be done, I could possibly
> implement it.

I wrote my idea up here for Masami[*]:

We could implement seq_splice_read().  What we would need to do is to chan=
ge
how the seq buffer is allocated: bulk allocate a bunch of arbitrary pages
which we then vmap().  When we need to splice, we read into the buffer, do=
 a
vunmap() and then splice the pages holding the data we used into the pipe.

If we don't manage to splice all the data, we can continue splicing from t=
he
pages we have left next time.  If a read() comes along to view partially
spliced data, we would need to copy from the individual pages.

When we use up all the data, we discard all the pages we might have splice=
d
from and shuffle down the other pages, call the bulk allocator to replenis=
h
the buffer and then vmap() it again.

Any pages we've spliced from must be discarded and replaced and not rewrit=
ten.

If a read() comes without the buffer having been spliced from, it can do a=
s it
does now.

David
---

[*] https://lore.kernel.org/linux-fsdevel/20230522-pfund-ferngeblieben-53f=
ad9c0e527@brauner/T/#mc03959454c76cc3f29024b092c62d88c90f7c071

