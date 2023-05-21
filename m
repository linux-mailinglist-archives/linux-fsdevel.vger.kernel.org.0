Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84BC70ADBA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjEULrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjEUKkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 06:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85F219B;
        Sun, 21 May 2023 03:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 384E7616F5;
        Sun, 21 May 2023 10:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243EBC433EF;
        Sun, 21 May 2023 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664913;
        bh=fuwAavm/XaNEAXoWfH+8YMFck1QbFLwrPXjkugnEjGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZklILM9/gXHkmMK8esniIM/BsLqN2K4sb1ZQSwMJLVSn4FIJLDuSf6SqgodPF887D
         52utCGg8uIy3Mp8jHuXlxJwsrRcc/O+t8xls6IAPFPQgH05ORKDyi0aOJ1gtr7x++x
         W0ebfTTsJ7Yp//nU0gL0Qr+7jKFJ7vLuHvpol1/rEdpqamal1a7Wf5e5dPbIy8QLsD
         TzuNvtoDSvI15/io6hy7ldIoZcnXa/xOn6R2rc8sKxhS1XJvmaG0/2O6jTgizm27bg
         +sk1gfglqE5tcQsoP45sgfn2m0fyM6242S6JCtRsBYs4mjav+vqqm6wamTHlNtZQkS
         g/nJd4Gt4kRZA==
Date:   Sun, 21 May 2023 19:28:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v21 26/30] splice: Convert trace/seq to use
 copy_splice_read()
Message-Id: <20230521192826.825bfafa17645aacba9b1076@kernel.org>
In-Reply-To: <20230520000049.2226926-27-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
        <20230520000049.2226926-27-dhowells@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Sat, 20 May 2023 01:00:45 +0100
David Howells <dhowells@redhat.com> wrote:

> For the splice from the trace seq buffer, just use copy_splice_read().

So this is because you will remove generic_file_splice_read() (since
it's buggy), right?

> 
> In the future, something better can probably be done by gifting pages from
> seq->buf into the pipe, but that would require changing seq->buf into a
> vmap over an array of pages.

So what we need is to introduce a vmap? We introduced splice support for
avoiding copy ringbuffer pages, but this drops it. Thus this will drop
performance of splice on ring buffer (trace file). If it is correct,
can you also add a note about that?

Thank you,

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
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebc59781456a..c210d02fac97 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5171,7 +5171,7 @@ static const struct file_operations tracing_fops = {
>  	.open		= tracing_open,
>  	.read		= seq_read,
>  	.read_iter	= seq_read_iter,
> -	.splice_read	= generic_file_splice_read,
> +	.splice_read	= copy_splice_read,
>  	.write		= tracing_write_stub,
>  	.llseek		= tracing_lseek,
>  	.release	= tracing_release,
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
