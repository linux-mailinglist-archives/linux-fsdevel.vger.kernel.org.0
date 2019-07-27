Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6F77AB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfG0RQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 13:16:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60662 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbfG0RQ6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 13:16:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E65BA1F462;
        Sat, 27 Jul 2019 17:16:57 +0000 (UTC)
Date:   Sat, 27 Jul 2019 17:16:57 +0000
From:   Eric Wong <e@80x24.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Azat Khuzhin <azat@libevent.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] epoll: support pollable epoll from userspace
Message-ID: <20190727171657.cisalgn3wfs5opyi@dcvr>
References: <20190611145458.9540-1-rpenyaev@suse.de>
 <20190726162208.0a9a244d41d9384fb94d9210@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190726162208.0a9a244d41d9384fb94d9210@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 11 Jun 2019 16:54:44 +0200 Roman Penyaev <rpenyaev@suse.de> wrote:
> > In order to measure polling from userspace libevent was modified [1] and
> > bench_http benchmark (client and server) was used:
> > 
> >  o EPOLLET, original epoll:
> > 
> >     20000 requests in 0.551306 sec. (36277.49 throughput)
> >     Each took about 5.54 msec latency
> >     1600000bytes read. 0 errors.
> > 
> >  o EPOLLET + polling from userspace:
> > 
> >     20000 requests in 0.475585 sec. (42053.47 throughput)
> >     Each took about 4.78 msec latency
> >     1600000bytes read. 0 errors.
> 
> It would be useful to include some words which describe the
> significance of this to real-world userspace.  If a real application is
> sped up 0.000000001% then this isn't very exciting ;)

Agreed.  I've put my wfcqueue changes from years back on hold
because I couldn't show a meaningful improvement in real-world
cases: https://lore.kernel.org/lkml/20130401183118.GA9968@dcvr.yhbt.net/

Roman's changes have me interested in seeing how my previous
changes would stack up (no UAPI changes required).
I've been looking for time to forward port my wfcqueue work
to the current kernel (but public-inbox takes priority;
not that I have much time for that).

On the userspace side; I'm not sure any widely-used open source
project is really impacted by epoll performance...
Most everybody seems to use level-trigger :<
