Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DE5256B1A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 03:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgH3Byk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 21:54:40 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33444 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgH3Byk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:54:40 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 46FB51B44DF;
        Sun, 30 Aug 2020 10:54:38 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U1sbJI322084
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 10:54:38 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U1saM43070424
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 10:54:36 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07U1sZBX3070422;
        Sun, 30 Aug 2020 10:54:35 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
References: <87ft85osn6.fsf@mail.parknet.co.jp>
        <20200830012151.GW14765@casper.infradead.org>
Date:   Sun, 30 Aug 2020 10:54:35 +0900
In-Reply-To: <20200830012151.GW14765@casper.infradead.org> (Matthew Wilcox's
        message of "Sun, 30 Aug 2020 02:21:51 +0100")
Message-ID: <874kokq4o4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sun, Aug 30, 2020 at 09:59:41AM +0900, OGAWA Hirofumi wrote:
>> On one system, there was bdi->io_pages==0. This seems to be the bug of
>> a driver somewhere, and should fix it though. Anyway, it is better to
>> avoid the divide-by-zero Oops.
>> 
>> So this check it.
>> 
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  fs/fat/fatent.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
>> index f7e3304..98a1c4f 100644
>> --- a/fs/fat/fatent.c	2020-08-30 06:52:47.251564566 +0900
>> +++ b/fs/fat/fatent.c	2020-08-30 06:54:05.838319213 +0900
>> @@ -660,7 +660,7 @@ static void fat_ra_init(struct super_blo
>>  	if (fatent->entry >= ent_limit)
>>  		return;
>>  
>> -	if (ra_pages > sb->s_bdi->io_pages)
>> +	if (sb->s_bdi->io_pages && ra_pages > sb->s_bdi->io_pages)
>>  		ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
>
> Wait, rounddown?  ->io_pages is supposed to be the maximum number of
> pages to readahead.  Shouldn't this be max() instead of rounddown()?

Hm, io_pages is limited by driver setting too, and io_pages can be lower
than ra_pages, e.g. usb storage.

Assuming ra_pages is user intent of readahead window. So if io_pages is
lower than ra_pages, this try ra_pages to align of io_pages chunk, but
not bigger than ra_pages. Because if block layer splits I/O requests to
hard limit, then I/O is not optimal.

So it is intent, I can be misunderstanding though.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
