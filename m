Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78470AE21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjEUMve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 08:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjEUMvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 08:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D271EC5
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684673450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Da4xtSq0QdB30NCu+72mMP6X5NYk0+FQ0rBdl0VkLvU=;
        b=Y+AJysQ7niKH7SUa9EoI/D0LDoVUgVwvJ0n8/7BgJeJ81ylquYcIRXQsfZ21PHI+lCSe7l
        IQ4XiwLTUEHFGDyZVY/TcWrZlUdsdpoXTVHKuALgesOxbC9vRdna+zmj/4FpKZNpw40WLn
        6B0HQsrC0mk55+hE56SiR0XjFyJH4Bg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-5viUjdlnMoCZk6kLet-5VA-1; Sun, 21 May 2023 08:50:46 -0400
X-MC-Unique: 5viUjdlnMoCZk6kLet-5VA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E2691C05154;
        Sun, 21 May 2023 12:50:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D82F40CFD00;
        Sun, 21 May 2023 12:50:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230521192826.825bfafa17645aacba9b1076@kernel.org>
References: <20230521192826.825bfafa17645aacba9b1076@kernel.org> <20230520000049.2226926-1-dhowells@redhat.com> <20230520000049.2226926-27-dhowells@redhat.com>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v21 26/30] splice: Convert trace/seq to use copy_splice_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2332232.1684673440.1@warthog.procyon.org.uk>
Date:   Sun, 21 May 2023 13:50:40 +0100
Message-ID: <2332233.1684673440@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> David Howells <dhowells@redhat.com> wrote:
> 
> > For the splice from the trace seq buffer, just use copy_splice_read().
> 
> So this is because you will remove generic_file_splice_read() (since
> it's buggy), right?

An ITER_PIPE iterator has a problem if it gets reverted with other changes I
want to make.  The problem is that it may not be valid to control the lifetime
of the data in the buffer with get_page().  The pages may need a pin taking
(FOLL_PIN) or the lifetime might be controlled with kfree() or rmmod.

> > In the future, something better can probably be done by gifting pages from
> > seq->buf into the pipe, but that would require changing seq->buf into a
> > vmap over an array of pages.
> 
> ... We introduced splice support for avoiding copy ringbuffer pages, but
> this drops it. Thus this will drop performance of splice on ring buffer
> (trace file). If it is correct, can you also add a note about that?

Actually, no.  There is no special splice support for tracing_fops.  You
currently use generic_file_splice_read(), which wends its way down into
seq_read_iter.  However, the seqfile stuff uses kvmalloc() to allocate the
buffer, so you are not allowed to splice page refs from kmalloc'd or vmalloc'd
memory into a pipe, so it doesn't.  It calls copy_to_iter() which will cause
ITER_PIPE to allocate bufferage on an as-needed basis.

copy_splice_read() instead creates an ITER_BVEC and populates it up front
using the bulk allocator, so if you're splicing a lot of data, this ought to
be marginally faster.

> So what we need is to introduce a vmap?

We could implement seq_splice_read().  What we would need to do is to change
how the buffer is allocated: bulk allocate a bunch of arbitrary pages which we
then vmap().  When we need to splice, we read into the buffer, do a vunmap()
and then splice the pages holding the data we used into the pipe.

If we don't manage to splice all the data, we can continue splicing from the
pages we have left next time.  If a read() comes along to view partially
spliced data, we would need to copy from the individual pages.

When we use up all the data, we discard all the pages we might have spliced
from and shuffle down the other pages, call the bulk allocator to replenish
the buffer and then vmap() it again.

Any pages we've spliced from must be discarded and replaced and not rewritten.

If a read() comes without the buffer having been spliced from, it can do as it
does now.

David

