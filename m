Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE974CDEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 09:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGJHJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJHJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:09:40 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E5ABE9;
        Mon, 10 Jul 2023 00:09:38 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36A79KgT018101;
        Mon, 10 Jul 2023 09:09:20 +0200
Date:   Mon, 10 Jul 2023 09:09:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <ZKuuoB6fcAV3ucFM@1wt.eu>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
 <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
 <20230709172753.GA22287@1wt.eu>
 <df91b1d3-2c66-4a6b-9a8a-544679bc09a8@t-8ch.de>
 <20230709180432.GA22685@1wt.eu>
 <74eddce8-4f59-40c8-bc49-38c286a3cbb0@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74eddce8-4f59-40c8-bc49-38c286a3cbb0@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 09, 2023 at 08:22:31PM +0200, Thomas Weiﬂschuh wrote:
> On 2023-07-09 20:04:32+0200, Willy Tarreau wrote:
> > On Sun, Jul 09, 2023 at 07:57:27PM +0200, Thomas Weiﬂschuh wrote:
> > > On 2023-07-09 19:27:53+0200, Willy Tarreau wrote:
> > > > On Sun, Jul 09, 2023 at 07:10:58PM +0200, Thomas Weiﬂschuh wrote:
> > > > > On 2023-07-09 11:29:47+0200, Willy Tarreau wrote:
> > > > > > On Fri, Jun 30, 2023 at 10:06:09PM +0800, Zhangjin Wu wrote:
> > > > > >> [..]
> > > > > > 
> > > > > > Now queued, thanks!
> > > > > > Willy
> > > > > 
> > > > > Don't we need an Ack from the fs maintainers for the patch to
> > > > > fs/proc/proc_net.c ?
> > > > > 
> > > > > Personally I expected this series to go in via the fs tree because of
> > > > > that patch.
> > > > 
> > > > Gasp! You're totally right, I confused it with a test only changing
> > > > the nolibc-test file, as the chmod_net test appeared as a dependency!
> > > > Let me drop it from the series and push again.
> > > 
> > > I think if this patch now also goes in via both the nolibc/rcu trees and
> > > the fs tree it would not be great.
> > >
> > > The best way forward would probably for you to rebase your tree on top
> > > of mainline after the fs tree has introduced both patches of the series
> > > into Linus' tree and then you can drop your copy of the test removal.
> > 
> > Yeah I agree.
> > 
> > > I want to keep both patches together because I expect the fs change to
> > > be backported and if it is backported on its own it will break
> > > nolibc-test in those trees.
> > 
> > OK but we can also fix the test regardless, and mark it for backport, no ?
> 
> That should work fine, too.
> Can you add the Fixes and Cc-stable tags in your tree and let the fs
> maintainers know?

OK here's what it's like now, let me know if you'd prefer any change:

  commit 8c2e51e174ed0f998b6bd90244324a4966a55efc
  Author: Thomas Weiﬂschuh <linux@weissschuh.net>
  Date:   Sat Jun 24 12:30:46 2023 +0200

    selftests/nolibc: drop test chmod_net
    
    The test relies on /proc/$PID/net to allow chmod() operations.
    It is the only file or directory in /proc/$PID/ to allow this and a bug.
    That bug will be fixed in the next patch in the series and therefore
    the test would start failing.
    
    Link: https://lore.kernel.org/lkml/d0d111ef-edae-4760-83fb-36db84278da1@t-8ch.de/
    Fixes: b4844fa0bdb4 ("selftests/nolibc: implement a few tests for various syscalls")
    Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
    Tested-by: Zhangjin Wu <falcon@tinylab.org>
    Signed-off-by: Willy Tarreau <w@1wt.eu>

> Or do you want me to split and resend the series?

Not needed, thank you.
Willy
