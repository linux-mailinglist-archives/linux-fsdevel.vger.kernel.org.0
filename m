Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E0A3A404D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFKKkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 06:40:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFKKkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:40:05 -0400
Received: from [192.168.1.155] ([95.115.52.72]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmlbE-1lRuAG3Qt4-00jqYY; Fri, 11 Jun 2021 12:37:38 +0200
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
To:     Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Chris Down <chris@chrisdown.name>, legion@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@kernel.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <YLi+JoBwfLtqVGiP@chrisdown.name>
 <b8c86081-503c-3671-2ea3-dd3a0950ce25@metux.net> <87k0n2am0n.fsf@disp2133>
 <YMElKcrVIhJg4GTT@cmpxchg.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <f62b652c-3f6f-31ba-be0f-5f97b304599f@metux.net>
Date:   Fri, 11 Jun 2021 12:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YMElKcrVIhJg4GTT@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fIbW0PbUEQNX5vVOCtIQaCzclCQYuoarMiwrB6inQ1JRrO6MWuG
 Z+T2GUoRqidcoMS7C1uP2/aYmALEinwUsK1Vk2rjRDdsfnnW9R3V7L8Bsti7Nk+RTqqtcXj
 Qvf+VUmXxZJnjhH8/dXalVllwCcefeOFwWzuxdTo2bKhsjgxIscVzTNdSRqPOQ27av9/bLZ
 LbjsWUbLRF73V0/JGMjIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4jMWGYSnAno=:tZFReZI/p0tb/XcCWdK9zq
 qfcVY0fVVH7NwxkgF38ii+uuitWAY2osFe/UBKC9awMqaWT09LhPfIp8kE0yFULPMlvO4sgx8
 wVkVy3C04OgIEOX7j7VUYrsNL2BTZbmEHYAAI9ZxY/e7+iP+0PoFcAtHcjoQwjCO27rfE5/DQ
 b+hlH5zWhZE59MN38VAhycWh5hWODzKOwmuCsc6fvyjLxHaila/wWVez12wxIpKOmNVBiv4HW
 HlJMywHLqeueCo5Ci4iH8yJnLaH6E55aSzd7FGlzaEM5l9JMZtJVTFHoKKXeh44LR3AYD4kLB
 XVpUm68Og6c8tp8JoL+1dMMsw7EXBHM1tUGbsUK9zAXZFIF4KNVIM8PkBHsEipY127UL06KXZ
 rJ40XTeTImaO0FyrGAf30CRPGUc64O5oG8YRmLLhExjASRHMB56/6vOtd/6L9S/2JY5HttIAF
 zViDpTZasANBk8ArS4mNqkyF9Fs6SExoG5BlypIQY2beq8QE5hKzmGwXQKioLf+8uPB51VjQ6
 jHmlyJYh6MQlXycHgMbNEQ=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.06.21 22:31, Johannes Weiner wrote:

>> Alex has found applications that are trying to do something with
>> meminfo, and the fields that those applications care about.  I don't see
>> anyone making the case that specifically what the applications are
>> trying to do is buggy.

Actually, I do. The assumptions made by those applications are most
certainly wrong - have been wrong ever since.

The problem is that just looking on these numbers is only helpful if
that application is pretty much alone on the machine. You'll find those
when the vendor explicitly tells you to run it on a standalone machine,
disable swap, etc. Database systems are probably the most prominent
sector here.

Onder certain circumstances this actually migh, heuristically, work,
but those kind of auto tuning (eg. automatically eat X% of ram for
buffers, etc) might work. Under certain circumstance.

Those assumptions already had been defeated by VMs (eg. overcommit).

I don't feel it's a good idea to add extra kernel code, just in order
to make some ill-designed applications work a little bit less bad
(which still needs to be changed anyways)

Don't get me wrong, I'm really in favour of having a clean interface
for telling applications how much resources they can take (actually
considered quite the same), but this needs to be very well thought (and
we should also get orchestration folks into the loop for that). This
basically falls into two categories:

a) hard limits - how much can an application possibly consume
    --> what makes about an application ? process ? process group ?
        cgroup ? namespace ?
b) reasonable defaults - how much can an application take at will, w/o
    affecting others ?
    --> what exactly is "reasonable" ? kernel cache vs. userland buffers?
    --> how to deal w/ overcommit scenarios ?
    --> who shall be in charge of controlling these values ?

It's a very complex problem, not easy to solve. Much of that seems to be
a matter of policies, and depending on actual workloads.

Maybe, for now, it's better pursue that on orchestration level.

> Not all the information at the system level translates well to the
> container level. Things like available memory require a hierarchical
> assessment rather than just a look at the local level, since there
> could be limits higher up the tree.

By the way: what exactly *is* a container anyways ?

The mainline kernel (in contrast to openvz kernel) doesn't actually know
about containers at all - instead is provides several concepts like
namespaces, cgroups, etc, that together are used for providing some
container environment - but that composition is done in userland, and
there're several approaches w/ different semantics.

Before we can do anything container specific in the kernel, we first
have to come to an general aggreement what actually is a container from
kernel perspective. No idea whether we can achieve that at all (in near
future) w/o actually introducing the concept of container within the
kernel.

> We should also not speculate what users intended to do with the
> meminfo data right now. There is a surprising amount of misconception
> around what these values actually mean. I'd rather have users show up
> on the mailing list directly and outline the broader usecase.

ACK.

The only practical use cases I'm aware of is:

a) safety: know how much memory I can eat, until I get -ENOMEM, so
    applications can proactively take counter measures, eg. pre
    allocation (common practise in safety related applications)

b) autotuning: how much shall the application take for caches or
    buffers. this is problematic, since it can only work on heuristics,
    which in turn can only be experimentally found within certain range
    of assumptions (eg. certain databases like to do that). By that way
    you can only find more or less reasonable parameters for the majority
    of cases (assuming you have an idea what that majority actually is),
    but still far from optimal. for *good* parameters you need to measure
    your actual workloads and applying good knowledge of what this
    application is actually doing. (one of the DBA's primary jobs)


--mtx
-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
