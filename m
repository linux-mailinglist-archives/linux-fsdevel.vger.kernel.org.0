Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC19A1085A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfEANkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 09:40:22 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:35830 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfEANkW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 09:40:22 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id AD93BC02E1E;
        Wed,  1 May 2019 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556718020;
        bh=e5p92AxqIQaOpAeZxR0jM3IKHXBVCh83bkoLGhP+Xys=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=wgOPwZAYDECjiiNiuG21bj2zVr/9GsU9AfHB5HPVNTtVSXbo3ZELIz88hg266n+42
         6Ww7uoq6QAlGh+Ja4qclga3wRCw10FA0ZurdXRnJ8XJkgntzhi5qKbokQlfuWSsZ1I
         DaIQOu5cwIJHRFeFcthLFhFJaCvO2dlM1Um9O0hY=
Subject: Re: [PATCH v1 1/1] [io_uring] require RWF_HIPRI for iopoll reads and
 writes
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20190501115223.13296-1-source@stbuehler.de>
 <628e59c6-716f-5af3-c1dc-bf5cb9003105@kernel.dk>
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Message-ID: <3173f400-8efd-ec9a-6821-797a360e0c7c@stbuehler.de>
Date:   Wed, 1 May 2019 15:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <628e59c6-716f-5af3-c1dc-bf5cb9003105@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 01.05.19 14:43, Jens Axboe wrote:
> On 5/1/19 5:52 AM, Stefan Bühler wrote:
>> This makes the mapping RWF_HIPRI <-> IOCB_HIPRI <-> iopoll more
>> consistent; it also allows supporting iopoll operations without
>> IORING_SETUP_IOPOLL in the future.
> 
> I don't want to make this change now. Additionally, it's never
> going to be possible to support polled IO mixed with non-polled
> IO on an io_uring instance, as that makes the wait part of IO
> impossible to support without adding tracking of requests.
> 
> As we can never mix them, it doesn't make a lot of sense to
> request RWF_HIPRI for polled IO.

I'm not just new to memory ordering, I'm also new to kernel internals :)

To me it looks like iopoll is basically a busy-loop interface; it helps
making things move forward more quickly, while they still might (or
might not) finish on their own.

And io_do_iopoll simply loops over all requests and runs a single
iteration for them, or, if there is only one request
("!poll_multi_file"), it tells it to spin internally.

While there are multiple requests it can't spin in a single request
anyway, and I don't see why it couldn't also check for completion of
non-polled requests after looping over the polled requests (whether by
only checking the CQ tail or actively tracking (why would that be bad?)
the requests some other way).  This only means that as long there are
non-polled requests pending it mustn't spin in a single request.

And if there are no polled-requests at all it could use io_cqring_wait.

So I don't see why it would be impossible to mix polled and non-polled
IO requests.

Any hints what I'm missing here?

(Even if it turns out to be impossible I still think requiring RWF_HIPRI
would be the right way, but well...)

cheers,
Stefan
