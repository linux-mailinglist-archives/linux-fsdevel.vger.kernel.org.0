Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F774D723C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 03:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiCMCtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 21:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiCMCtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 21:49:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8099635DF3;
        Sat, 12 Mar 2022 18:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QcQYDOcuPmJqwmxJxiKKuJQSUjnrING1uevctRC2NLI=; b=v9DNmTFBLXdbr/DsdDBdv+FDfb
        CH2QKAiE6+BMy7n16ROprwxTYPn2+VuTET4WkhEVnEoIZmTtbXB+oLS9ot9aD1uZJ1M9qTt52yIR+
        zErmGVXl9WTK9KawJ6qRcZOfR5L8lrhQGu1epaikhKNEFK5i+zpfH4OigXGzYo8Hj4WZmesUfzsgP
        Z5lKnu1na4DFZOnbEcW2chboI/yOSNQrdYJ+vnW4oOxnqzfmAQ1eSOlqyP9ff02IqLKaYatNAeats
        9wQ2YDl2LXlvDEfRXbvHdwafAxjmjFwruFsS+37cR5K5I31DXpPXI+p4GZEv/QMwUCz40fCeicDsl
        MI8Vaw8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTEHC-002tAG-BH; Sun, 13 Mar 2022 02:48:10 +0000
Date:   Sun, 13 Mar 2022 02:48:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Max Kellermann <max.kellermann@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] pipe_fs_i.h: add pipe_buf_init()
Message-ID: <Yi1bakVfs/l6CNE0@casper.infradead.org>
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
 <20220225185431.2617232-4-max.kellermann@gmail.com>
 <Yi1Y99MX7yxD2k6m@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi1Y99MX7yxD2k6m@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 13, 2022 at 02:37:43AM +0000, Al Viro wrote:
> On Fri, Feb 25, 2022 at 07:54:31PM +0100, Max Kellermann wrote:
> 
> >  			/* Insert it into the buffer array */
> >  			buf = &pipe->bufs[head & mask];
> > -			buf->page = page;
> > -			buf->ops = &anon_pipe_buf_ops;
> > -			buf->offset = 0;
> > -			buf->len = 0;
> > -			if (is_packetized(filp))
> > -				buf->flags = PIPE_BUF_FLAG_PACKET;
> > -			else
> > -				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
> > +			pipe_buf_init(buf, page, 0, 0,
> > +				      &anon_pipe_buf_ops,
> > +				      is_packetized(filp) ? PIPE_BUF_FLAG_PACKET : PIPE_BUF_FLAG_CAN_MERGE);
> 
> *cringe*
> FWIW, packetized case is very rare, so how about turning that into
> 			pipe_buf_init(buf, page, 0, 0,
> 				      &anon_pipe_buf_ops,
> 				      PIPE_BUF_FLAG_CAN_MERGE);
> 			if (unlikely(is_packetized(filp)))
> 				buf->flags = PIPE_BUF_FLAG_PACKET;
> Your pipe_buf_init() is inlined, so it shouldn't be worse from the optimizer
> POV - it should be able to start with calculating that value and then storing
> that, etc.

That's not equivalent.  I think the better option here is to always
initialise flags to 0 (and not have a parameter for it):

			pipe_buf_init(buf, page, 0, 0, &anon_pipe_buf_ops);
			if (is_packetized(filp))
				buf->flags = PIPE_BUF_FLAG_PACKET;
			else
				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;

