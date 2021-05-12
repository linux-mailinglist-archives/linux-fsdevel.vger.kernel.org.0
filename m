Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9237B9EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 12:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELKGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 06:06:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:56896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhELKGx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 06:06:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BED42AC87;
        Wed, 12 May 2021 10:05:44 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 916aae09;
        Wed, 12 May 2021 10:07:18 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
References: <87czu45gcs.fsf@suse.de>
        <2507722.1620736734@warthog.procyon.org.uk>
Date:   Wed, 12 May 2021 11:07:18 +0100
In-Reply-To: <2507722.1620736734@warthog.procyon.org.uk> (David Howells's
        message of "Tue, 11 May 2021 13:38:54 +0100")
Message-ID: <87tun8z2nd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Hi Luis,

Hi David,

(thanks for the feedback and sorry for the delay replying -- in the
meantime I had problems with my test environment that I had to fix first.)

>> I've been seeing fscache complaining about duplicate cookies in 9p:
>> 
>>  FS-Cache: Duplicate cookie detected
>>  FS-Cache: O-cookie c=00000000ba929e80 [p=000000002e706df1 fl=226 nc=0 na=1]
>
> This cookie is marked acquired (fl=2xx), but not relinquished (fl=4xx), so it
> would still seem to be active:-/.  Pretty much one of the first things
> __fscache_relinquish_cookie() does is to set that bit (should be bit 10).
>
> One thing that might be useful is if you can turn on a couple of fscache
> tracepoints:
>
> echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_acquire/enable
> echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_relinquish/enable
>
> The cookie pointers in the duplicate cookie report should match the entries in
> the trace output.

Awesome, thanks for the suggestion.  So, here's what I did: I enabled the
2 tracepoints you suggested *and* I've also enabled the 'fscache_cookie'
tracepoint so that I would see the collision in the trace.  I then started
my test and after I see the duplicated cookie warning I stopped it.  And
here's what I got in the logs:

[   29.702428] FS-Cache: Duplicate cookie detected
[   29.703859] FS-Cache: O-cookie c=0000000046a8b5b3 [p=00000000b2d5d5a9 fl=216 nc=0 na=0]
[   29.705922] FS-Cache: O-cookie d=0000000000000000 n=0000000000000000
[   29.706996] FS-Cache: O-key=[8] '0312710100000000'
[   29.707597] FS-Cache: N-cookie c=000000002b6a2db1 [p=00000000b2d5d5a9 fl=2 nc=0 na=1]
[   29.708712] FS-Cache: N-cookie d=000000006a7abbdd n=00000000188a0c4c
[   29.709568] FS-Cache: N-key=[8] '0312710100000000'

and in the trace ('=>' identifies the old cookie):

=>         <...>-2712    [000] ...1    29.551257: fscache_acquire: c=0000000046a8b5b3 p=00000000b2d5d5a9 pu=50 pc=49 pf=22 n=9p.inod
           <...>-2820    [000] ...1    29.707083: fscache_relinquish: c=000000003ca97471 u=1 p=00000000b2d5d5a9 Nc=0 Na=1 f=26 r=0
           <...>-2820    [000] ...1    29.707087: fscache_cookie: PUT rlq c=000000003ca97471 u=0 p=00000000b2d5d5a9 Nc=0 Na=0 f=16
           <...>-2820    [000] ...1    29.707090: fscache_cookie: PUT prn c=00000000b2d5d5a9 u=49 p=000000005cf9f76e Nc=48 Na=1 f=22
           <...>-2821    [002] ...2    29.709010: fscache_cookie: GET prn c=00000000b2d5d5a9 u=50 p=000000005cf9f76e Nc=48 Na=1 f=22
           <...>-2821    [002] ...1    29.709011: fscache_acquire: c=00000000ca586ae6 p=00000000b2d5d5a9 pu=50 pc=49 pf=22 n=9p.inod
           <...>-2847    [002] ...1    29.750224: fscache_relinquish: c=00000000ca586ae6 u=1 p=00000000b2d5d5a9 Nc=0 Na=1 f=26 r=0
           <...>-2847    [002] ...1    29.750228: fscache_cookie: PUT rlq c=00000000ca586ae6 u=0 p=00000000b2d5d5a9 Nc=0 Na=0 f=16
           <...>-2847    [002] ...1    29.750230: fscache_cookie: PUT prn c=00000000b2d5d5a9 u=49 p=000000005cf9f76e Nc=48 Na=1 f=22
           <...>-2851    [003] ...2    29.751561: fscache_cookie: GET prn c=00000000b2d5d5a9 u=50 p=000000005cf9f76e Nc=48 Na=1 f=22
           <...>-2851    [003] ...1    29.751562: fscache_acquire: c=0000000019a5a5e8 p=00000000b2d5d5a9 pu=50 pc=49 pf=22 n=9p.inod
           <...>-2863    [001] ...1    29.771136: fscache_relinquish: c=0000000019a5a5e8 u=1 p=00000000b2d5d5a9 Nc=0 Na=1 f=26 r=0
           <...>-2863    [001] ...1    29.771140: fscache_cookie: PUT rlq c=0000000019a5a5e8 u=0 p=00000000b2d5d5a9 Nc=0 Na=0 f=16
           <...>-2863    [001] ...1    29.771143: fscache_cookie: PUT prn c=00000000b2d5d5a9 u=49 p=000000005cf9f76e Nc=48 Na=1 f=22
           <...>-2865    [002] ...2    29.773439: fscache_cookie: GET prn c=00000000b2d5d5a9 u=50 p=000000005cf9f76e Nc=48 Na=1 f=22
           <...>-2865    [002] ...1    29.773440: fscache_acquire: c=00000000ca586ae6 p=00000000b2d5d5a9 pu=50 pc=49 pf=22 n=9p.inod
=>         <...>-2869    [003] ...2    29.779784: fscache_cookie: *COLLISION* c=0000000046a8b5b3 u=1 p=00000000b2d5d5a9 Nc=0 Na=1 f=26
           <...>-2876    [002] ...1    29.779966: fscache_relinquish: c=0000000046a8b5b3 u=1 p=00000000b2d5d5a9 Nc=0 Na=1 f=26 r=0
           <...>-2876    [002] .N.1    29.779969: fscache_cookie: PUT rlq c=0000000046a8b5b3 u=0 p=00000000b2d5d5a9 Nc=0 Na=0 f=16
           <...>-2869    [003] .N.1    29.787568: fscache_cookie: DISCARD c=000000002b6a2db1 u=1 p=00000000b2d5d5a9 Nc=0 Na=1 f=02

[ I wonder why the timestamps don't match between the traces and the
  kernel log... ]

So, can we infer from this trace that an evict could actually be on-going
but the old cookie wasn't relinquished yet and hence the collision?

> Note that my fscache-iter branch[1] improves the situation where the disk I/O
> required to effect the destruction of a cache object delays the completion of
> relinquishment by inserting waits, but that oughtn't to help here.

Right, I haven't looked at it yet (I'll try to) but that could make things
even worse, right?

Cheers,
-- 
Luis
