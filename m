Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF070C11A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjEVO3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjEVO3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 10:29:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046AAF;
        Mon, 22 May 2023 07:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF03561DC1;
        Mon, 22 May 2023 14:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E4C433D2;
        Mon, 22 May 2023 14:29:22 +0000 (UTC)
Date:   Mon, 22 May 2023 10:29:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v20 23/32] splice: Convert trace/seq to use
 direct_splice_read()
Message-ID: <20230522102920.0528d821@rorschach.local.home>
In-Reply-To: <20230519074047.1739879-24-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
        <20230519074047.1739879-24-dhowells@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 May 2023 08:40:38 +0100
David Howells <dhowells@redhat.com> wrote:

> For the splice from the trace seq buffer, just use direct_splice_read().
> 
> In the future, something better can probably be done by gifting pages from
> seq->buf into the pipe, but that would require changing seq->buf into a
> vmap over an array of pages.

If you can give me a POC of what needs to be done, I could possibly
implement it.

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Masami Hiramatsu <mhiramat@kernel.org>
> cc: linux-kernel@vger.kernel.org
> cc: linux-trace-kernel@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  kernel/trace/trace.c | 2 +-

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebc59781456a..b664020efcb7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5171,7 +5171,7 @@ static const struct file_operations tracing_fops = {
>  	.open		= tracing_open,
>  	.read		= seq_read,
>  	.read_iter	= seq_read_iter,
> -	.splice_read	= generic_file_splice_read,
> +	.splice_read	= direct_splice_read,
>  	.write		= tracing_write_stub,
>  	.llseek		= tracing_lseek,
>  	.release	= tracing_release,

