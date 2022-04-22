Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9150C42F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiDVW5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiDVW47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:56:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CBF19ADAD;
        Fri, 22 Apr 2022 15:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 595F0B832D5;
        Fri, 22 Apr 2022 22:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16240C385AA;
        Fri, 22 Apr 2022 22:20:53 +0000 (UTC)
Date:   Fri, 22 Apr 2022 18:20:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422182052.4994525d@gandalf.local.home>
In-Reply-To: <20220422215146.i663tn6zzn6blzo3@moria.home.lan>
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
        <20220422215146.i663tn6zzn6blzo3@moria.home.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Apr 2022 17:51:46 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> 
> But it's definitely not an unreasonable idea - I can try it out and see how it
> turns out. Would you have any objections to making some changes to seq_buf?

No I don't mind, and that's why I want the coupled, as enhancements or bug
fixes would happen to both.

> 
>  - You've got size and len as size_t, I've got them as unsigned. Given that we
>    need to be checking for overflow anyways for correctens, I like having them
>    as u32s.

I had it as size_t as I had planned (and still plan to) make seq_file use
seq_buf, and seq_file uses size_t. Who knows, perhaps in the future, we may
have strings that are more than 4GBs. ;-)

>  - seq_buf->readpos - it looks like this is only used by seq_buf_to_user(), does
>    it need to be in seq_buf?

Perhaps.

>  - in printbufs, I make sure the buffer is always nul-terminated - seems
>    simplest, given that we need to make sure there's always room for the
>    terminating nul anyways.

I'm not against that. It was an optimization, but I never actually
benchmarked it. But I'm not sure how many fast paths it is used in to
warrant that kind of optimization over the complexity it can bring for
users.


> 
> A downside of having printbuf on top of seq_buf is that now we've got two apis
> that functions can output to - vs. if we modified printbuf by adding a flag for
> "this is an external buffer, don't reallocate it". That approach would be less
> code overall, for sure.
> 
> Could I get you to look over printbuf and share your thoughts on the different
> approaches?

Sure, but will have to wait till next week.

-- Steve
