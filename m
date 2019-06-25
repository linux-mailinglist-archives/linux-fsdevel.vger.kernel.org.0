Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF5554D60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfFYLTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 07:19:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730461AbfFYLTH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:19:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD39FAEFF;
        Tue, 25 Jun 2019 11:19:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jun 2019 13:19:04 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Azat Khuzhin <azat@libevent.org>, Eric Wong <e@80x24.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/14] epoll: support pollable epoll from userspace
In-Reply-To: <CAHk-=wgQaCDiH09ocVA=74ceg9XyS=kRDF5Hi=783shCaKVRWg@mail.gmail.com>
References: <20190624144151.22688-1-rpenyaev@suse.de>
 <CAHk-=wgQaCDiH09ocVA=74ceg9XyS=kRDF5Hi=783shCaKVRWg@mail.gmail.com>
Message-ID: <f0d2c829c72c63d08c8df46d2d32c2af@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-06-24 22:38, Linus Torvalds wrote:
> On Mon, Jun 24, 2019 at 10:42 PM Roman Penyaev <rpenyaev@suse.de> 
> wrote:
>> 
>> So harvesting events from userspace gives 15% gain.  Though bench_http
>> is not ideal benchmark, but at least it is the part of libevent and 
>> was
>> easy to modify.
>> 
>> Worth to mention that uepoll is very sensible to CPU, e.g. the gain 
>> above
>> is observed on desktop "Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz", 
>> but on
>> "Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz" measurements are almost 
>> the
>> same for both runs.
> 
> Hmm. 15% may be big in a big picture thing, but when it comes to what
> is pretty much a micro-benchmark, I'm not sure how meaningful it is.
> 
> And the CPU sensitivity thing worries me. Did you check _why_ it
> doesn't seem to make any difference on the Xeon 4110? Is it just
> because at that point the machine has enough cores that you might as
> well just sit in epoll() in the kernel and uepoll doesn't give you
> much? Or is there something else going on?

This http tool is a singlethreaded test, i.e. client and server
work as a standalone processes and each has a single event thread
for everything.

According to what I saw there, is that events come slowly (or event
loop acts faster?), so when time has come to harvest events there
is nothing, we take a slow path and go to kernel in order to sleep.
That does not explain the main "why", unfortunately.

I would like to retest that adding more clients to the server, thus
server is more likely to observe events in a ring, avoiding sleep.

--
Roman

