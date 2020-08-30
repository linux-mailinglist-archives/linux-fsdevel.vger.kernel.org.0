Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11703256CFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgH3JEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 05:04:30 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33532 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgH3JE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 05:04:28 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 236971B44DF;
        Sun, 30 Aug 2020 18:04:27 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U94PrB325008
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 18:04:26 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U94PQ43124274
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 18:04:25 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07U94NY33124271;
        Sun, 30 Aug 2020 18:04:23 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
References: <87ft85osn6.fsf@mail.parknet.co.jp>
        <20200830012151.GW14765@casper.infradead.org>
        <874kokq4o4.fsf@mail.parknet.co.jp>
        <20200830035300.GX14765@casper.infradead.org>
Date:   Sun, 30 Aug 2020 18:04:23 +0900
In-Reply-To: <20200830035300.GX14765@casper.infradead.org> (Matthew Wilcox's
        message of "Sun, 30 Aug 2020 04:53:00 +0100")
Message-ID: <87zh6co67c.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sun, Aug 30, 2020 at 10:54:35AM +0900, OGAWA Hirofumi wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> Hm, io_pages is limited by driver setting too, and io_pages can be lower
>> than ra_pages, e.g. usb storage.
>> 
>> Assuming ra_pages is user intent of readahead window. So if io_pages is
>> lower than ra_pages, this try ra_pages to align of io_pages chunk, but
>> not bigger than ra_pages. Because if block layer splits I/O requests to
>> hard limit, then I/O is not optimal.
>> 
>> So it is intent, I can be misunderstanding though.
>
> Looking at this some more, I'm not sure it makes sense to consult ->io_pages
> at all.  I see how it gets set to 0 -- the admin can write '1' to
> /sys/block/<device>/queue/max_sectors_kb and that gets turned into 0
> in ->io_pages.

	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
		return -EINVAL;

It should not set to 0 via /sys/.../max_sectors_kb. However the default
of bdi->io_pages is 0. So it happened if a driver didn't initialized it.

> But I'm not sure it makes any sense to respect that.  Looking at
> mm/readahead.c, all it does is limit the size of a read request which
> exceeds the current readahead window.  It's not used to limit the
> readahead window itself.  For example:
>
>         unsigned long max_pages = ra->ra_pages;
> ...
>         if (req_size > max_pages && bdi->io_pages > max_pages)
>                 max_pages = min(req_size, bdi->io_pages);
>
> Setting io_pages below ra_pages has no effect.  So maybe fat should also
> disregard it?

          |-----------------------| requested blocks
[before]
 ra_pages |===========|===========|===========|
 io_pages |---------|---------|---------|
 req      |---------|-|-------|---|

[after]
 ra_pages |=========|=========|=========|
 io_pages |---------|---------|---------|
 req      |---------|---------|---|

This path is known the large sequential read there. Well, anyway, this
intent is to use [after] as 3 req, instead of [before] as 4 req.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
