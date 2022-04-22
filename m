Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA7250C389
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiDVWgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiDVWgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:36:09 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3022C3C5;
        Fri, 22 Apr 2022 14:51:49 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id fu34so6463120qtb.8;
        Fri, 22 Apr 2022 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RZMfk42e8wN88X1x4Oc4ckY2xJ8vXIPWfHgWdfKTn9M=;
        b=OSzfMYbMeDyu2ee3SkdVdwdxHDs6Jzcx2Ft5LhsurqKR50qJ8HRKBjD3f87T0XNmxR
         qPnidw8ZJGlkLY4hMiMsUUqST228rD37ocmfljP7rOdrbzZs3xADUHms29i9T65N5q9E
         clMgoBeG13AcWf9ZZfieqatqAf8Yj3w3rxiAT2PbzEXyVNfRiReGT+XgQbJekBqIWe5q
         P/XFEhR+21IEscdN+hf34slbakBnAe7UATNkKqG4TVmxXH+UjyXh7SddnQ7HDYvfH9Nt
         OEqb8324QrpnTlQriByF9ZcZf/Go3TvUITwT8PsNgo2rtCmUHHWiuk1BEArJwiB3TjTB
         bExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RZMfk42e8wN88X1x4Oc4ckY2xJ8vXIPWfHgWdfKTn9M=;
        b=5Qycu7xY6XTw1/MlnTnSvQQ+h8U81dPsVKgvdUmzkEHLOZx6HFCQMB3oEh7upWR+tU
         SHIijXfzsIG1JMXPj+TKUCodQbAwb13uNkKJqueK5ZjXizHvZPobsLhARckIXmE9pSzZ
         B1p8CV8D5XJ1nfQHb3nYGhw93qqdmcJmTEqnh5mk+zlb/l/iYwNGuZdWKKCcfYdaBgE0
         utxGDwOo9nY0F7nZ8odrhE++tKuCXatN/cc7A8QLhcy/ME2hq5Uiwm5caDhCkrfEvlSg
         G7JX19otKVyoDed7mvpa/YvBXnupS78fMvH3HOw/bEABgxFXpdgUcEqZG4p8XU2FBhLX
         wJZA==
X-Gm-Message-State: AOAM530d/h1v3j9q0NZdJah39aNaQ/q9DL9NPoF8JA0YHhEMr7p1/Sll
        meTv1Rb43x6c8qReQaLxOw==
X-Google-Smtp-Source: ABdhPJxyyCkFj9u8Z2ocvKIb99chaQNgfvpROYCjFGnjIdmRADHMMNVhTGFRGUajfZ+aBtu4TsJEvA==
X-Received: by 2002:a05:622a:1a86:b0:2f3:4be4:42dd with SMTP id s6-20020a05622a1a8600b002f34be442ddmr4854803qtc.55.1650664308682;
        Fri, 22 Apr 2022 14:51:48 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id y20-20020a05622a121400b002eefd7bf5basm2080434qtx.63.2022.04.22.14.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:51:48 -0700 (PDT)
Date:   Fri, 22 Apr 2022 17:51:46 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422215146.i663tn6zzn6blzo3@moria.home.lan>
References: <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
 <YmI/v35IvxhOZpXJ@moria.home.lan>
 <20220422113736.460058cc@gandalf.local.home>
 <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
 <20220422153916.7ebf20c3@gandalf.local.home>
 <20220422203057.iscsmurtrmwkpwnq@moria.home.lan>
 <20220422164744.6500ca06@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422164744.6500ca06@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:47:44PM -0400, Steven Rostedt wrote:
> Which is something you could do on top of seq_buf. Point being, you do not
> need to re-implement printbuf, and I have not looked at the code, but
> instead, implement printbuf on top of seq_buf, and extend seq_buf where
> needed. Like trace_seq does, and the patches I have for seq_file would do.
> It would leave the string processing and buffer space management to
> seq_buf, as there's ways to see "oh, we need more space, let's allocate
> more" and then increase the heap.

That sounds like it could work. 

> I would be more willing to accept a printbuf, if it was built on top of
> seq_buf. That is, you don't need to change all your user cases, you just
> need to make printbuf an extension of seq_buf by using it underneath, like
> trace_seq does. Then it would not be re-inventing the wheel, but just
> building on top of it.

Hmm... At first glance, redoing printbuf on top of seq_buf looks like it would
save a pretty trivial amount of code - and my engineering taste these days leans
more toward less layering if it's only slightly more code; I think I might like
printbuf and seq_buf to stay separate things (and both of them are pretty
small).

But it's definitely not an unreasonable idea - I can try it out and see how it
turns out. Would you have any objections to making some changes to seq_buf?

 - You've got size and len as size_t, I've got them as unsigned. Given that we
   need to be checking for overflow anyways for correctens, I like having them
   as u32s.
 - seq_buf->readpos - it looks like this is only used by seq_buf_to_user(), does
   it need to be in seq_buf?
 - in printbufs, I make sure the buffer is always nul-terminated - seems
   simplest, given that we need to make sure there's always room for the
   terminating nul anyways.

A downside of having printbuf on top of seq_buf is that now we've got two apis
that functions can output to - vs. if we modified printbuf by adding a flag for
"this is an external buffer, don't reallocate it". That approach would be less
code overall, for sure.

Could I get you to look over printbuf and share your thoughts on the different
approaches?
