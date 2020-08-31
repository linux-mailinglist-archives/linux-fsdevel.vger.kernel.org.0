Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CEF257FB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgHaRjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 13:39:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33976 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgHaRjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:39:22 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1A9151B44DF;
        Tue,  1 Sep 2020 02:39:21 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VHdJa6366555
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 02:39:20 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VHdJ753466384
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 02:39:19 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07VHdIdG3466383;
        Tue, 1 Sep 2020 02:39:18 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
References: <87ft85osn6.fsf@mail.parknet.co.jp>
        <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
        <87o8mq6aao.fsf@mail.parknet.co.jp>
        <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk>
        <20200831165659.GH14765@casper.infradead.org>
        <33eb2820-894e-a42f-61a5-c25bc52345d5@kernel.dk>
Date:   Tue, 01 Sep 2020 02:39:18 +0900
In-Reply-To: <33eb2820-894e-a42f-61a5-c25bc52345d5@kernel.dk> (Jens Axboe's
        message of "Mon, 31 Aug 2020 11:00:14 -0600")
Message-ID: <87d03667g9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 8/31/20 10:56 AM, Matthew Wilcox wrote:
>> On Mon, Aug 31, 2020 at 10:39:26AM -0600, Jens Axboe wrote:
>>> We really should ensure that ->io_pages is always set, imho, instead of
>>> having to work-around it in other spots.
>> 
>> Interestingly, there are only three places in the entire kernel which
>> _use_ bdi->io_pages.  FAT, Verity and the pagecache readahead code.
>> 
>> Verity:
>>                         unsigned long num_ra_pages =
>>                                 min_t(unsigned long, num_blocks_to_hash - i,
>>                                       inode->i_sb->s_bdi->io_pages);
>> 
>> FAT:
>>         if (ra_pages > sb->s_bdi->io_pages)
>>                 ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
>> 
>> Pagecache:
>>         max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
>> and
>>         if (req_size > max_pages && bdi->io_pages > max_pages)
>>                 max_pages = min(req_size, bdi->io_pages);
>> 
>> The funny thing is that all three are using it differently.  Verity is
>> taking io_pages to be the maximum amount to readahead.  FAT is using
>> it as the unit of readahead (round down to the previous multiple) and
>> the pagecache uses it to limit reads that exceed the current per-file
>> readahead limit (but allows per-file readahead to exceed io_pages,
>> in which case it has no effect).
>> 
>> So how should it be used?  My inclination is to say that the pagecache
>> is right, by virtue of being the most-used.
>
> When I added ->io_pages, it was for the page cache use case. The others
> grew after that...

FAT and pagecache usage would be similar or same purpose. The both is
using io_pages as optimal IO size.

In pagecache case, it uses io_pages if one request size is exceeding
io_pages. In FAT case, there is perfect knowledge about future/total
request size. So FAT divides request by io_pages, and adjust ra_pages
with knowledge.

I don't know about verity.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
