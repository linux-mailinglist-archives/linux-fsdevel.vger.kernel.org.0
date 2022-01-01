Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6814148275A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiAAKwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jan 2022 05:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAAKwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jan 2022 05:52:24 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDECC061574;
        Sat,  1 Jan 2022 02:52:24 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n3bzk-0005yW-5C; Sat, 01 Jan 2022 11:52:16 +0100
Message-ID: <0bdf0a46-bd10-6b14-d569-a18e6bb73836@leemhuis.info>
Date:   Sat, 1 Jan 2022 11:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Content-Language: en-BS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info>
 <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
 <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info>
 <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
 <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
 <CAHk-=wjKNjx1EApBoaqB0kZ8BB5r+YReOELA5uwRhwMi17S=qg@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAHk-=wjKNjx1EApBoaqB0kZ8BB5r+YReOELA5uwRhwMi17S=qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641034344;05adff4e;
X-HE-SMSGID: 1n3bzk-0005yW-5C
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 31.12.21 20:22, Linus Torvalds wrote:
> On Fri, Dec 31, 2021 at 11:21 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Pushed out as 1b4e3f26f9f7 ("mm: vmscan: Reduce throttling due to a
>> failure to make progress")

Thx.

> .. and I _think_ this empties the regzbot queue for this release, Thorsten. No?

Well, it was the regression that bothered me most. But there are still a
few out there that got introduced this cycle.

There is a regression in RDMA/mlx5 introduced in v5.16-rc5:
https://lore.kernel.org/lkml/f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com/
https://lore.kernel.org/all/EEBA2D1C-F29C-4237-901C-587B60CEE113@oracle.com/
A fix is available, but got stuck afaics:
https://lore.kernel.org/lkml/f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com/
And I only noticed just now: a revert was also discussed, but not performed:
https://lore.kernel.org/all/20211222101312.1358616-1-maorg@nvidia.com/
Will let Greg know, seems the commit got backported to 5.15.

s0ix suspend broke for some AMD machines, Alex and Mario are busy
looking into it:
https://gitlab.freedesktop.org/drm/amd/-/issues/1821
https://bugzilla.kernel.org/show_bug.cgi?id=215436

Alex is also dealing with another issue where the screen contents now
get restored after some input events:
https://bugzilla.kernel.org/show_bug.cgi?id=215203

There still seems to be a performance regression that Josef and Valentin
try hard to pin down without much success for weeks now:
https://lore.kernel.org/lkml/87tuf07hdk.mognet@arm.com/

And there one more report, but it might be a follow-up error due to
another regression:
https://lore.kernel.org/linux-pm/52933493.dBzk7ret6Y@geek500/
