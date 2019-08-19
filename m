Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848B591D54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfHSGww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 02:52:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:45078 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHSGww (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:52:52 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hzbX6-0008In-Ez; Mon, 19 Aug 2019 09:52:48 +0300
Subject: Re: [PATCH] fuse: BUG_ON's correction in fuse_dev_splice_write()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <d99f78a7-31c4-582e-17f5-93e1f0d0e4c2@virtuozzo.com>
 <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <5cb431ed-5fba-0223-2d4f-64efd36c1c24@virtuozzo.com>
Date:   Mon, 19 Aug 2019 09:52:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/1/19 2:01 PM, Miklos Szeredi wrote:
> On Tue, Jul 23, 2019 at 8:33 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> commit 963545357202 ("fuse: reduce allocation size for splice_write")
>> changed size of bufs array, so first BUG_ON should be corrected too.
>> Second BUG_ON become useless, first one also includes the second check:
>> any unsigned nbuf value cannot be less than 0.
> 
> This patch seems broken: it assumes that pipe->nrbufs doesn't change.
> Have you actually tested it?

You're right, I've missed it.
I've prepared second patch version which fixes first BUG_ON only.
checkpatch.pl also advises to replace BUG_ONs to WARN_ONs and 'unsigned' to 'unsigned int'
however I'm don't understand what it's better here:
- keep all as is, 
- or merge all changes together,
- or do it in separate patches,
- or do something else?

I believe it makes sense to remove BUG_ONs in separate patch, or may be merge it with current one,
but I do not like an idea to fight against bare 'unsigned' in fuse.

Could you please comment it?

Thank you,
	Vasily Averin


