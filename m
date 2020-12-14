Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38702D91FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 04:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438084AbgLNDGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 22:06:36 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:40027 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405985AbgLNDGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 22:06:36 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id D5AB346919;
        Mon, 14 Dec 2020 14:05:53 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1koeBM-003jay-HY; Mon, 14 Dec 2020 14:05:52 +1100
Date:   Mon, 14 Dec 2020 14:05:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>
Subject: Re: "do_copy_range:: Invalid argument"
Message-ID: <20201214030552.GI3913616@dread.disaster.area>
References: <CAOg9mSSCsPPYpHGAWVHoY5bO8DozzFNWXTi39XBc+GhDmWcRTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSSCsPPYpHGAWVHoY5bO8DozzFNWXTi39XBc+GhDmWcRTA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=GAbc6ozAyOxxgJh_0oMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:26:28AM -0500, Mike Marshall wrote:
> Greetings everyone...
> 
> Omnibond has sent me off doing some testing chores lately.
> I made no Orangefs patches for 5.9 or 5.10 and none were sent,
> but I thought I should at least run through xfstests.
> 
> There are tests that fail on 5.10-rc6 that didn't fail
> on 5.8-rc7, and I've done enough looking to see that the
> failure reasons all seem related.
> 
> I will, of course, keep looking to try and understand these
> failures. Bisection might lead me somewhere. In case the
> notes I've taken so far trigger any of y'all to give me
> any (constructive :-) ) suggestions, I've included them below.
> 
> -Mike
> 
> ---------------------------------------------------------------------
> 
> generic/075
>   58rc7: ? (check.log says it ran, results file missing)
>   510rc6: failed, "do_copy_range:: Invalid argument"
>           read the tests/generic/075 commit message for "detect
>           preallocation support for fsx tests"
> 
> generic/091
>   58rc7: passed, but skipped fallocate parts "filesystem does not support"
>   510rc6: failed, "do_copy_range:: Invalid argument"
> 
> generic/112
>   58rc7: ? (check.log says it ran, results file missing)
>   510rc6: failed, "do_copy_range:: Invalid argument"
> 
> generic/127
>   58rc7: ? (check.log says it ran, results file missing)
>   510rc6: failed, "do_copy_range:: Invalid argument"
> 
> generic/249
>   58rc7: passed
>   510rc6: failed, "sendfile: Invalid argument"
>           man 2 sendfile -> "SEE ALSO copy_file_range(2)"

If sendfile() failed, then it's likely a splice related regression,
not a copy_file_range() problem. The VFS CFR implementation falls
back to splice if the fs doesn't provide a clone or copy offload
method.

THere's only been a handful of changes to fs/splice.c since 5.8rc7,
so it might be worth doing a quick check reverting them first...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
