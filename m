Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A760E7217
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfJ1Mtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:49:52 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:59760 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbfJ1Mtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:49:52 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 399322E133F;
        Mon, 28 Oct 2019 15:49:49 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id g0lC5DUKiH-nleeAlQ6;
        Mon, 28 Oct 2019 15:49:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572266989; bh=nbn/F7ubzB3gfFhaClCiJKA9kSdMFcCRJXW6XjKJ3bE=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=AgS1a0L35oEfSF2W145KMr2NS22+HqFpzkEHWNHtZBmZ6+a8TjL5D5FmYVaSNn3zL
         1z9J1W+bXi5/CtTNqSjpRts69KOOvvYXb6exfk+qeZjU/fHEakbwRa+x2uo8bNu24E
         +x8kyu4atWJrzHHUh40lt8QKWc9TssRTROgEDKiM=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id qg1g0pXFHn-nkWmd21h;
        Mon, 28 Oct 2019 15:49:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
References: <157225848971.557.16257813537984792761.stgit@buzz>
 <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <03f36def-746e-063b-7c42-91244eec87bd@yandex-team.ru>
Date:   Mon, 28 Oct 2019 15:49:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/10/2019 15.27, Linus Torvalds wrote:
> On Mon, Oct 28, 2019 at 11:28 AM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>>
>> This implements fcntl() for getting amount of resident memory in cache.
>> Kernel already maintains counter for each inode, this patch just exposes
>> it into userspace. Returned size is in kilobytes like values in procfs.
> 
> This doesn't actually explain why anybody would want it, and what the
> usage scenario is.
> 

This really helps to plot memory usage distribution. Right now file cache
have only total counters. Collecting statistics via mincore as implemented
in page-types tool isn't efficient and very racy.

Usage scenario is the same as finding top memory usage among processes.
But among files which are not always mapped anywhere.

For example if somebody writes\reads logs too intensive this file cache
could bloat and push more important data out out memory.

Also little bit of introspection wouldn't hurt.
Using this I've found unneeded pages beyond i_size.

>               Linus
> 
