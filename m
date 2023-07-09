Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D074C6F8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGISWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGISWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 14:22:35 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A466EC;
        Sun,  9 Jul 2023 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688926952; bh=/mzXwqYhhaEswyZUayjPFVq1MZwMJWSKNHX6GofhBfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUi+Q7ng8OGkIsJEI8Eh6pFJ/y49A02iZR4+6nAyx0EB0CzH/vzOkALcZo3oHp2qB
         wjHF8lPPVt5ozJy7UvfKktMc89wZpNXa5AzFtZ/JUoo6flsuKM7RuR9aKLmkhEd3AY
         u85aPxxjXG2Betc7k5uuWCYCMyQayMmVZQZ75yts=
Date:   Sun, 9 Jul 2023 20:22:31 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <74eddce8-4f59-40c8-bc49-38c286a3cbb0@t-8ch.de>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
 <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
 <20230709172753.GA22287@1wt.eu>
 <df91b1d3-2c66-4a6b-9a8a-544679bc09a8@t-8ch.de>
 <20230709180432.GA22685@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230709180432.GA22685@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-09 20:04:32+0200, Willy Tarreau wrote:
> On Sun, Jul 09, 2023 at 07:57:27PM +0200, Thomas Weißschuh wrote:
> > On 2023-07-09 19:27:53+0200, Willy Tarreau wrote:
> > > On Sun, Jul 09, 2023 at 07:10:58PM +0200, Thomas Weißschuh wrote:
> > > > On 2023-07-09 11:29:47+0200, Willy Tarreau wrote:
> > > > > On Fri, Jun 30, 2023 at 10:06:09PM +0800, Zhangjin Wu wrote:
> > > > >> [..]
> > > > > 
> > > > > Now queued, thanks!
> > > > > Willy
> > > > 
> > > > Don't we need an Ack from the fs maintainers for the patch to
> > > > fs/proc/proc_net.c ?
> > > > 
> > > > Personally I expected this series to go in via the fs tree because of
> > > > that patch.
> > > 
> > > Gasp! You're totally right, I confused it with a test only changing
> > > the nolibc-test file, as the chmod_net test appeared as a dependency!
> > > Let me drop it from the series and push again.
> > 
> > I think if this patch now also goes in via both the nolibc/rcu trees and
> > the fs tree it would not be great.
> >
> > The best way forward would probably for you to rebase your tree on top
> > of mainline after the fs tree has introduced both patches of the series
> > into Linus' tree and then you can drop your copy of the test removal.
> 
> Yeah I agree.
> 
> > I want to keep both patches together because I expect the fs change to
> > be backported and if it is backported on its own it will break
> > nolibc-test in those trees.
> 
> OK but we can also fix the test regardless, and mark it for backport, no ?

That should work fine, too.
Can you add the Fixes and Cc-stable tags in your tree and let the fs
maintainers know?
Or do you want me to split and resend the series?

> > But maybe I'm overthinking it, nobody is running nolibc-test on
> > non-mainline kernels anyways and both patches can be split.
> 
> I agree that we shouldn't grant too much importance to this test ;-)
> I'm regularly seeing Sasha propose them for backports and am thinking
> "ok it cannot hurt but I'm not convinced anyone will notice the fix".
> 
> > If they are to be kept together and go via fs an Ack on the nolibc-test
> > patch is probably needed, too.
> 
> OK. Let's first see if someone from FS agrees on the change.

Sounds good.


Thomas
