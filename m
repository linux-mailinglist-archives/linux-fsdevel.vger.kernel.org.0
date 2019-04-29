Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DCDEBE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfD2VE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 17:04:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33350 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfD2VE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:04:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 407B71F453;
        Mon, 29 Apr 2019 21:04:27 +0000 (UTC)
Date:   Mon, 29 Apr 2019 21:04:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Omar Kilani <omar.kilani@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190429210427.dmfemfft2t2gdwko@dcvr>
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr>
 <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr>
 <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> wrote:
> On Sun, 28 Apr 2019, Eric Wong wrote:
> 
> > Just running one test won't trigger since it needs a busy
> > machine; but:
> > 
> > 	make test/mgmt_auto_adjust.log
> > 	(and "rm make test/mgmt_auto_adjust.log" if you want to rerun)
> 
> fyi no luck reproducing on both either a large (280) or small (4 cpu)
> machine, I'm running it along with a kernel build overcommiting cpus x2.

Thanks for taking a look.

> Is there any workload in particular you are using to stress the box?

Just the "make -j$N check" I mentioned up-thread which spawns a
lot of tests in parallel.  For the small 4 CPU machine,
-j32 or -j16 ought to be reproducing the problem.

I'll try to set aside some time this week to get familiar with
kernel internals w.r.t. signal handling.
