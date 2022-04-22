Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB27950BBCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385527AbiDVPnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449473AbiDVPke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD55AED6;
        Fri, 22 Apr 2022 08:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C436193E;
        Fri, 22 Apr 2022 15:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80C5C385A4;
        Fri, 22 Apr 2022 15:37:38 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:37:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422113736.460058cc@gandalf.local.home>
In-Reply-To: <YmI/v35IvxhOZpXJ@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
        <20220421234837.3629927-7-kent.overstreet@gmail.com>
        <20220422042017.GA9946@lst.de>
        <YmI5yA1LrYrTg8pB@moria.home.lan>
        <20220422052208.GA10745@lst.de>
        <YmI/v35IvxhOZpXJ@moria.home.lan>
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

On Fri, 22 Apr 2022 01:40:15 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> So I'm honestly not super eager to start modifying tricky arch code that I can't
> test, and digging into what looked like non trivial interactions between the way
> the traceing code using seq_buf (naturally, given that's where it originates).

Yes, seq_buf came from the tracing system but was to be used in a more
broader way. I had originally pushed trace_seq into the lib directory, but
Andrew Morton said it was too specific to tracing. Thus, I gutted the
generic parts out of it and created seq_buf, which looks to be something
that you could use. I had patches to convert seq_file to it, but ran out of
time. I probably can pull them out of the closet and start that again.

> 
> Now yes, I _could_ do a wholesale conversion of seq_buf to printbuf and delete
> that code, but doing that job right, to be confident that I'm not introducing
> bugs, is going to take more time than I really want to invest right now. I
> really don't like to play fast and loose with that stuff.

I would be happy to work with you to convert to seq_buf. If there's
something missing from it, I can help you change it so that it doesn't
cause any regressions with the tracing subsystem.

This is how open source programming is suppose to work ;-)

-- Steve
