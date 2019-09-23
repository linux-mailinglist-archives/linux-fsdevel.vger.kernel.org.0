Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3FBB90F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 18:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfIWQGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 12:06:00 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:38112 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387866AbfIWQGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:06:00 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 0B7432E1493;
        Mon, 23 Sep 2019 19:05:57 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 5DFzfrorlR-5uE8IrZq;
        Mon, 23 Sep 2019 19:05:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1569254757; bh=IXcoUvIXF995IhaYye9MIGZQTDEPJgvaMrA8NeaSgm4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=IeVleuB0zPc0Ac/Wy3UG/+YJdbPerDRmG86tkmfYqhk6L4jnUbAL9UAlFmedok+Ee
         BHflD7BFVXSvcRZ9KDAbKF/exr68OX1tyy5z8z6v33qaYDuFel1WGJl0mOlA19dKWp
         HC665E7zR8I0cHJLG5taFdeOEfoQNaLaKrItvI5w=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id YPqHsg4d3K-5uIK39Dl;
        Mon, 23 Sep 2019 19:05:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
 <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
 <1882a6da-a599-b820-6257-11bbac02b220@kernel.dk>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a5e769db-823d-9a48-b5f9-a4b406710c6f@yandex-team.ru>
Date:   Mon, 23 Sep 2019 19:05:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1882a6da-a599-b820-6257-11bbac02b220@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/09/2019 18.36, Jens Axboe wrote:
> On 9/20/19 5:10 PM, Linus Torvalds wrote:
>> On Fri, Sep 20, 2019 at 4:05 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>>
>>> Now, I hear you say "those are so small these days that it doesn't
>>> matter". And maybe you're right. But particularly for slow media,
>>> triggering good streaming write behavior has been a problem in the
>>> past.
>>
>> Which reminds me: the writebehind trigger should likely be tied to the
>> estimate of the bdi write speed.
>>
>> We _do_ have that avg_write_bandwidth thing in the bdi_writeback
>> structure, it sounds like a potentially good idea to try to use that
>> to estimate when to do writebehind.
>>
>> No?
> 
> I really like the feature, and agree it should be tied to the bdi write
> speed. How about just making the tunable acceptable time of write behind
> dirty? Eg if write_behind_msec is 1000, allow 1s of pending dirty before
> starting writbeack.
> 

I haven't digged into it yet.

But IIRR writeback speed estimation has some problems:

There is no "slow start" - initial speed is 100MiB/s.
This is especially bad for slow usb disks - right after plugging
we'll accumulate too much dirty cache before starting writeback.

And I've seen problems with cgroup-writeback:
each cgroup has own estimation, doesn't work well for short-living cgroups.
