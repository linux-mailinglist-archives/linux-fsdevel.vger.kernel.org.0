Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0AAD9B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfIINH5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 9 Sep 2019 09:07:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32341 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729531AbfIINH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:07:57 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-218-k_b-RoXrNR6sA5ZeQLxIog-1; Mon, 09 Sep 2019 14:07:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Sep 2019 14:07:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Sep 2019 14:07:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dmitry Safonov' <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Pavel Emelyanov" <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 8/9] select/restart_block: Convert poll's timeout to u64
Thread-Topic: [PATCH 8/9] select/restart_block: Convert poll's timeout to u64
Thread-Index: AQHVZvizzIDwzlC570SwWwtAb/4vwqcjUHzQ
Date:   Mon, 9 Sep 2019 13:07:52 +0000
Message-ID: <fd8bfb2bed23492cb5e6c43b10be6125@AcuMS.aculab.com>
References: <20190909102340.8592-1-dima@arista.com>
 <20190909102340.8592-9-dima@arista.com>
In-Reply-To: <20190909102340.8592-9-dima@arista.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: k_b-RoXrNR6sA5ZeQLxIog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dmitry Safonov
> Sent: 09 September 2019 11:24
> 
> All preparations have been done - now poll() can set u64 timeout in
> restart_block. It allows to do the next step - unifying all timeouts in
> restart_block and provide ptrace() API to read it.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  fs/select.c                   | 27 +++++++--------------------
>  include/linux/restart_block.h |  4 +---
>  2 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 4af88feaa2fe..ff2b9c4865cd 100644
> --- a/fs/select.c
> +++ b/fs/select.c
...
> @@ -1037,16 +1030,10 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
>  		struct restart_block *restart_block;
> 
>  		restart_block = &current->restart_block;
> -		restart_block->fn = do_restart_poll;
> -		restart_block->poll.ufds = ufds;
> -		restart_block->poll.nfds = nfds;
> -
> -		if (timeout_msecs >= 0) {
> -			restart_block->poll.tv_sec = end_time.tv_sec;
> -			restart_block->poll.tv_nsec = end_time.tv_nsec;
> -			restart_block->poll.has_timeout = 1;
> -		} else
> -			restart_block->poll.has_timeout = 0;
> +		restart_block->fn		= do_restart_poll;
> +		restart_block->poll.ufds	= ufds;
> +		restart_block->poll.nfds	= nfds;
> +		restart_block->poll.timeout	= timeout;

What is all that whitespace for?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

