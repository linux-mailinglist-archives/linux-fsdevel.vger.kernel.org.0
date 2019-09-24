Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF57BC4DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504232AbfIXJ3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 05:29:39 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56414 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504186AbfIXJ3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:29:38 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 157712E0AFF;
        Tue, 24 Sep 2019 12:29:36 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QkwcPN4QKg-TZfSidj7;
        Tue, 24 Sep 2019 12:29:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1569317376; bh=YKkn4HVvP/+S323ny4wtqnadzUN5R/l/3Q2qi4I+C20=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=sFEY7awdEgAKvKAPX0qms5EE4rM19nmu3enZSr/t/63SKXi9HMwNLdgBSZ8KwOqXg
         D5i6QuSwldSgtTjOcisJ0R2KTibZ+JyE01OrUCapm8OxcESAwyMOAfNoodsokaw2P6
         cMpXcarS4KylAWkIXppr9gv/FKtG45Hp63c8iOP4=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by vla5-2bf13a090f43.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id xBph0X0UAr-TZIeLosP;
        Tue, 24 Sep 2019 12:29:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <f9fdb72f-f0a1-8c28-f287-be6946980160@yandex-team.ru>
Date:   Tue, 24 Sep 2019 12:29:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/2019 02.05, Linus Torvalds wrote:
> On Fri, Sep 20, 2019 at 12:35 AM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>>
>> This patch implements write-behind policy which tracks sequential writes
>> and starts background writeback when file have enough dirty pages.
> 
> Apart from a spelling error ("contigious"), my only reaction is that
> I've wanted this for the multi-file writes, not just for single big
> files.
> 
> Yes, single big files may be a simpler and perhaps the "10% effort for
> 90% of the gain", and thus the right thing to do, but I do wonder if
> you've looked at simply extending it to cover multiple files when
> people copy a whole directory (or unpack a tar-file, or similar).
> 
> Now, I hear you say "those are so small these days that it doesn't
> matter". And maybe you're right. But partiocularly for slow media,
> triggering good streaming write behavior has been a problem in the
> past.
> 
> So I'm wondering whether the "writebehind" state should perhaps be
> considered be a process state, rather than "struct file" state, and
> also start triggering for writing smaller files.

It's simple to extend existing state with per-task counter of sequential
writes to detect patterns like unpacking tarball with small files.
After reaching some threshold write-behind could flush files in at close.

But in this case it's hard to wait previous writes to limit amount of
requests and pages in writeback for each stream.

Theoretically we could build chain of inodes for delaying and batching.

> 
> Maybe this was already discussed and people decided that the big-file
> case was so much easier that it wasn't worth worrying about
> writebehind for multiple files.
> 
>              Linus
> 
