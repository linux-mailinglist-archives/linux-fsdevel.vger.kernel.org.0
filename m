Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FED650D889
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 06:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiDYFB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 01:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDYFB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:01:57 -0400
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Apr 2022 21:58:54 PDT
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D876287
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 21:58:54 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 76B4B26104;
        Mon, 25 Apr 2022 04:49:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 43C5620027;
        Mon, 25 Apr 2022 04:49:01 +0000 (UTC)
Message-ID: <9ab6601364a16c782ca36ab22a2c67face0785a7.camel@perches.com>
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev
Date:   Sun, 24 Apr 2022 21:48:58 -0700
In-Reply-To: <20220425041909.hcyirjphrkhxz6hx@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
         <20220421234837.3629927-7-kent.overstreet@gmail.com>
         <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
         <YmYLEovwj9BqeZQA@casper.infradead.org>
         <20220425041909.hcyirjphrkhxz6hx@moria.home.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 43C5620027
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Stat-Signature: 8ixc8cziybhcpcydbdn3a73gyuqoij5i
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18F4WG3efadNZRt+nKwL12BAjeAFjDke3g=
X-HE-Tag: 1650862141-114345
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-04-25 at 00:19 -0400, Kent Overstreet wrote:
> On Mon, Apr 25, 2022 at 03:44:34AM +0100, Matthew Wilcox wrote:
> > On Sun, Apr 24, 2022 at 04:46:03PM -0700, Joe Perches wrote:
> > > > + * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
> > > > + * readable units.
> > > 
> > > Why not extend vsprintf for this using something like %pH[8|16|32|64] 
> > > or %pH[c|s|l|ll|uc|us|ul|ull] ?
> > 
> > The %pX extension we have is _cute_, but ultimately a bad idea.  It
> > centralises all kinds of unrelated things in vsprintf.c, eg bdev_name()
> > and clock() and ip_addr_string().
> 
> And it's not remotely discoverable. I didn't realize we had bdev_name()
> available as a format string until just now or I would've been using it!

Documentation/core-api/printk-formats.rst


