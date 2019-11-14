Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE68FC274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 10:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfKNJUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 04:20:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34790 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfKNJUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:20:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id y186so4454083lfa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VWOUZ424cqLg2kuzZsAep0k1VB5L7ThfcMMEDK+H8tc=;
        b=HUIEkJPB/6glFajby5ySDEps1DnotXVu1qEtQ0BwJWhu32tz/9zrUk7HdFdvFdnNHH
         dxO3Rk/YldlDxbgdprqwpmmDNlU0fPIxF97ZmXNrwyUWh/QgNIbKxhMUIrEaKZy8LBu6
         f1wjBruA5fQCQetB0h1yhtxHaFdrfrDDMCpmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VWOUZ424cqLg2kuzZsAep0k1VB5L7ThfcMMEDK+H8tc=;
        b=tqEF3ISazfG49LhVbE2F47oP0QLUijrF1WTcJjoWhSk5N7/j2Yk6BAUdmDynaUU7JC
         zp4d4BgsniKTEt4bY6MrBjxLKa0qykFoCR3agEi7KNuWUuq1zYjNdrLkU859ijVmKspU
         4DjX/f2DeD0CpB1N6lIlW5d1Cz1AYq15chPvf1BMUd5ILEqCByC9bzfKi7xbQvS2iiB/
         BZ7lRisZ9VY4VmifxBBVAyVJPnmKGnoKAqWQRk1zgKCaD+AZwLAyAJ/DgYwMHuODyduG
         cweshEV4OkF/bi9xBuxvzlOR4OGeSAxS4y6cRg0pqNzzII5QTAYoDc7pXyiP2EzCBSk1
         kY/w==
X-Gm-Message-State: APjAAAUyCMAn8pPKqBWxV4H5wfQQDG92RfKsLloKX0TB1GxmPc64KjpS
        7D61s/YNjNuflo1c7OfD09DPig==
X-Google-Smtp-Source: APXvYqxa+8hUQhuGo9CVK60WwB6YzT9RYvrAB8YbUsHzRM4krnVwhJA1CpZIqJ4DKRffScVNO6jzXQ==
X-Received: by 2002:ac2:5c4e:: with SMTP id s14mr6047944lfp.23.1573723199828;
        Thu, 14 Nov 2019 01:19:59 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 190sm2535102ljj.72.2019.11.14.01.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:19:59 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
Date:   Thu, 14 Nov 2019 10:19:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/11/2019 05.49, Jens Axboe wrote:
> On 11/13/19 9:31 PM, Jens Axboe wrote:
>> This is a case of "I don't really know what I'm doing, but this works
>> for me". Caveat emptor, but I'd love some input on this.
>>
>> I got a bug report that using the poll command with signalfd doesn't
>> work for io_uring. The reporter also noted that it doesn't work with the
>> aio poll implementation either. So I took a look at it.
>>
>> What happens is that the original task issues the poll request, we call
>> ->poll() (which ends up with signalfd for this fd), and find that
>> nothing is pending. Then we wait, and the poll is passed to async
>> context. When the requested signal comes in, that worker is woken up,
>> and proceeds to call ->poll() again, and signalfd unsurprisingly finds
>> no signals pending, since it's the async worker calling it.
>>
>> That's obviously no good. The below allows you to pass in the task in
>> the poll_table, and it does the right thing for me, signal is delivered
>> and the correct mask is checked in signalfd_poll().
>>
>> Similar patch for aio would be trivial, of course.
> 
> From the probably-less-nasty category, Jann Horn helpfully pointed out
> that it'd be easier if signalfd just looked at the task that originally
> created the fd instead. That looks like the below, and works equally
> well for the test case at hand.

Eh, how should that work? If I create a signalfd() and fork(), the
child's signalfd should only be concerned with signals sent to the
child. Not to mention what happens after the parent dies and the child
polls its fd.

Or am I completely confused?

Rasmus
