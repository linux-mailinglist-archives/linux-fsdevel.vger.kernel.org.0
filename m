Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98850C0A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 22:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiDVUQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiDVUQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:16:19 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E95373043;
        Fri, 22 Apr 2022 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650657795;
        bh=YAXMPs+cpGG9Fbfwn2u2th0nZlCAFyC0num0OzVX/2s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=BQUhN0L2unkvkiMumNC3p8/41OGywwmf3wbclyvKvJ6Y33cK1/pWOEAusgQ+uCtCI
         3QKRpTI4qXp/5t9r5Aq0VGGFz34+LZexh7hdY7NhITKBYb0bgybEIBVNqX3bjIw9y8
         L09zOY7/y+7aazqSIYl+8KWpBKj7hgYT9V2DbC7I=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 31FED1289863;
        Fri, 22 Apr 2022 16:03:15 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GHNGq47j4p7D; Fri, 22 Apr 2022 16:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650657795;
        bh=YAXMPs+cpGG9Fbfwn2u2th0nZlCAFyC0num0OzVX/2s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=BQUhN0L2unkvkiMumNC3p8/41OGywwmf3wbclyvKvJ6Y33cK1/pWOEAusgQ+uCtCI
         3QKRpTI4qXp/5t9r5Aq0VGGFz34+LZexh7hdY7NhITKBYb0bgybEIBVNqX3bjIw9y8
         L09zOY7/y+7aazqSIYl+8KWpBKj7hgYT9V2DbC7I=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1060912891DA;
        Fri, 22 Apr 2022 16:03:13 -0400 (EDT)
Message-ID: <1f3ce897240bf0f125ca3e5f6ded7c290118a8dc.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Date:   Fri, 22 Apr 2022 16:03:12 -0400
In-Reply-To: <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
         <20220421234837.3629927-7-kent.overstreet@gmail.com>
         <20220422042017.GA9946@lst.de> <YmI5yA1LrYrTg8pB@moria.home.lan>
         <20220422052208.GA10745@lst.de> <YmI/v35IvxhOZpXJ@moria.home.lan>
         <20220422113736.460058cc@gandalf.local.home>
         <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-04-22 at 15:30 -0400, Kent Overstreet wrote:
> Hi Steve!
> 
> On Fri, Apr 22, 2022 at 11:37:36AM -0400, Steven Rostedt wrote:
> > On Fri, 22 Apr 2022 01:40:15 -0400
> > Kent Overstreet <kent.overstreet@gmail.com> wrote:
[...]
> > > Now yes, I _could_ do a wholesale conversion of seq_buf to
> > > printbuf and delete that code, but doing that job right, to be
> > > confident that I'm not introducing bugs, is going to take more
> > > time than I really want to invest right now. I really don't like
> > > to play fast and loose with that stuff.
> > 
> > I would be happy to work with you to convert to seq_buf. If there's
> > something missing from it, I can help you change it so that it
> > doesn't cause any regressions with the tracing subsystem.
> > 
> > This is how open source programming is suppose to work ;-)
> 
> Is it though? :)
> 
> One of the things I've been meaning to talk more about, that
> came out of a recent Rust discussion, is that we in the kernel
> community could really do a better job with how we interact with the
> outside world, particularly with regards to the sharing of code.
> 
> The point was made to me when another long standing kernel dev was
> complaining about Facebook being a large, insular, difficult to work
> with organization, that likes to pretend it is the center of the
> universe and not bend to the outside world, while doing the exact
> same thing with respect to new concerns brought by the Rust
> community. The irony was illuminating :)

Hey, I didn't say that at all.  I said vendoring the facebook reference
implementation wouldn't work (it being 74k lines and us using 300) but
that facebook was doing the right thing for us with zstd because they
were maintaining the core code we needed, even if we couldn't vendor it
from their code base:

https://lore.kernel.org/rust-for-linux/ea85b3bce5f172dc73e2be8eb4dbd21fae826fa1.camel@HansenPartnership.com/

You were the one who said all that about facebook, while incorrectly
implying I said it first (which is an interesting variation on the
strawman fallacy):

https://lore.kernel.org/rust-for-linux/20220415203926.pvahugtzrg4dbhcc@moria.home.lan/

James



