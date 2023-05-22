Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC59C70C54C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjEVSiX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjEVSiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 14:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754ACB6;
        Mon, 22 May 2023 11:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12CAE6226A;
        Mon, 22 May 2023 18:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79441C433EF;
        Mon, 22 May 2023 18:38:18 +0000 (UTC)
Date:   Mon, 22 May 2023 14:38:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v20 23/32] splice: Convert trace/seq to use
 direct_splice_read()
Message-ID: <20230522143814.6efbbb4d@gandalf.local.home>
In-Reply-To: <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
        <20230519074047.1739879-24-dhowells@redhat.com>
        <20230522102920.0528d821@rorschach.local.home>
        <2812412.1684767005@warthog.procyon.org.uk>
        <CAHk-=wgg4iDEuSN4K6S6ohAm4zd_V5h4tXGn6-2-cfOuJPFDZQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 May 2023 10:42:12 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, May 22, 2023 at 7:50 AM David Howells <dhowells@redhat.com> wrote:
> >
> > We could implement seq_splice_read().  What we would need to do is to change
> > how the seq buffer is allocated: bulk allocate a bunch of arbitrary pages
> > which we then vmap().  When we need to splice, we read into the buffer, do a
> > vunmap() and then splice the pages holding the data we used into the pipe.  
> 
> Please don't use vmap as a way to do zero-copy.
> 
> The virtual mapping games are more expensive than a small copy from
> some random seq file.
> 
> Yes, yes, seq_file currently uses "kvmalloc()", which does fall back
> to vmalloc too. But the keyword there is "falls back". Most of the
> time it's just a regular boring kmalloc, and most of the time a
> seq-file is tiny.

I was thinking this change had to do with the splice callback for
trace_pipe_raw (which is a hot path that does zero copy of the ftrace ring
buffer into files). But looking at this further, I see that it's for just
the "trace" file, which is a textual conversion of the tracing data (slow
path, although some user space uses this and parses the text, which IMHO is
wrong).

In other words, I don't really care much about this code being "efficient".

-- Steve

