Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEF3A3B1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2019 06:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfFIEfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jun 2019 00:35:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIEfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jun 2019 00:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3iCKY5LeaLUChDTDcVwu/h/F/j5YNJNGeSjVT5fdq88=; b=by4vZqhKqOxBJlKDd6hArInlm
        WKADOCatsOoNcHcijlFuSKSkpxMaFoz+89V6rK04DRk+KaXCbmjSjbMjOQfsAKas/yaCx5yaCrasG
        PyDXtgEdyTUBWH6O2Kupd/9erdnh9qOXU3372Xvj91W9/ecClafI8rERmnDPqNnlLZLG8HaG0+dgj
        PG34x6yfIbTqxYxkE5sdI9jS93S8CLdAEfq+8giWfgfKdy/xskycgZGnI+QZfPXyxlcVAEB/kbmeC
        MklrDoI9xw3g29y2gcGpCpY13lPuccz0x2cX4ZFoHieSnsz9BE7EtXKwrdSxm6hjjELk+Y+gJQ64J
        +1JtM+uTg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZpYN-0008Ro-Px; Sun, 09 Jun 2019 04:35:35 +0000
Subject: Re: [PATCH 02/13] uapi: General notification ring definitions [ver
 #4]
To:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190607151228.GA1872258@magnolia>
 <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk>
 <29222.1559922719@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6b6f5bb0-1426-239b-ac9f-281e31ddcd04@infradead.org>
Date:   Sat, 8 Jun 2019 21:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <29222.1559922719@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/19 8:51 AM, David Howells wrote:
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 

>>> +	__u32			info;
>>> +#define WATCH_INFO_OVERRUN	0x00000001	/* Event(s) lost due to overrun */
>>> +#define WATCH_INFO_ENOMEM	0x00000002	/* Event(s) lost due to ENOMEM */
>>> +#define WATCH_INFO_RECURSIVE	0x00000004	/* Change was recursive */
>>> +#define WATCH_INFO_LENGTH	0x000001f8	/* Length of record / sizeof(watch_notification) */
>>
>> This is a mask, isn't it?  Could we perhaps have some helpers here?
>> Something along the lines of...
>>
>> #define WATCH_INFO_LENGTH_MASK	0x000001f8
>> #define WATCH_INFO_LENGTH_SHIFT	3
>>
>> static inline size_t watch_notification_length(struct watch_notification *wn)
>> {
>> 	return (wn->info & WATCH_INFO_LENGTH_MASK) >> WATCH_INFO_LENGTH_SHIFT *
>> 			sizeof(struct watch_notification);
>> }
>>
>> static inline struct watch_notification *watch_notification_next(
>> 		struct watch_notification *wn)
>> {
>> 	return wn + ((wn->info & WATCH_INFO_LENGTH_MASK) >>
>> 			WATCH_INFO_LENGTH_SHIFT);
>> }
> 
> No inline functions in UAPI headers, please.  I'd love to kill off the ones
> that we have, but that would break things.

Hi David,

What is the problem with inline functions in UAPI headers?

>> ...so that we don't have to opencode all of the ring buffer walking
>> magic and stuff?
> 
> There'll end up being a small userspace library, I think.

>>> +};
>>> +
>>> +#define WATCH_LENGTH_SHIFT	3
>>> +
>>> +struct watch_queue_buffer {
>>> +	union {
>>> +		/* The first few entries are special, containing the
>>> +		 * ring management variables.
>>
>> The first /two/ entries, correct?
> 
> Currently two.
> 
>> Also, weird multiline comment style.
> 
> Not really.

Yes really.

>>> +		 */

It does not match the preferred coding style for multi-line comments
according to coding-style.rst.


thanks.
-- 
~Randy
