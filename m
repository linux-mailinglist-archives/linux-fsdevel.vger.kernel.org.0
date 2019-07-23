Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFC7208D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfGWULi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 16:11:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45625 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfGWULi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:11:38 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so84555601ioc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MgP9LPfN10DUEaC+WQ9A4hu3RGENheRoiLTrymj8eyk=;
        b=Dnt1CZhC2LYrT/U3mvjzzjc/RRyAMYJOiUzUkgn51dAkhx+Z4lcf09bmfDkctEXXRs
         5WL5CMAyjzmhtl34HFSzAUjLII10NFwFJuNE8hEKvnovGUJ/CiYCzeKZ7epZsxQRQPCB
         anBEh6KFs13SbidfvWEw/5+P2APykujHGOBPn/ne5C5xPjtNNmsDk7zQmjGhu412bKcU
         HWvMp9CFLG7Gk6Hau1cxqTlPc/p3VYNu5oNxRRzeC8DbrLP663nzm9UBg1/8NBQHIwcM
         gHkSsaUNCItUn0jSZR1kS8K5mPBJtzgtXi7FANNwEMluuacnQ2cQ5Dza/ryEtDKwT/5l
         CiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MgP9LPfN10DUEaC+WQ9A4hu3RGENheRoiLTrymj8eyk=;
        b=P8XLm6V05rv9lHFE51yDK9kstq1DlgCOs3SXacq2+bMW4YGPP1yifOn0ctkDt0CZlC
         Bo73Gffi8nNB+HaWrZ4dWqeQ63aM4yx5uHJ0etAWg8MwvjV+WS80dEXOupqRGGqH6TMb
         cIS9SPyBTsif7S4JoVh5xkRezrnZwwkDz08qyyCHZaYL57At+BDI4EAQH6beF8AAZl86
         OIfZBQIGGjUZdcGpJkjw1s9RLSdkoPTvkHt3+27f/OQOpkeqNY7MNZUbwVysb2YDAeZ5
         qSgaHIaSBVgnNsh8/TL+yM7mATQf7ss0i8hSP0rjHKx8hbNys+u+Uhb4kt0qaFy12jwf
         ckvQ==
X-Gm-Message-State: APjAAAXCwW8wAJCHE1ldw7LD1S9yP4UouoQRqRC+/qU2jzwNFtTs6yxf
        UyvD5OjsL4Kw3JpWpuA/At4=
X-Google-Smtp-Source: APXvYqyw+FYUYBH7PHPM9hNQ10u20FZLOaBrygg1nawT4ojZ4fbrKNALassUfMdL2vC7z2sCMRVyyg==
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr71686178iog.255.1563912697407;
        Tue, 23 Jul 2019 13:11:37 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b14sm47499178iod.33.2019.07.23.13.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:11:36 -0700 (PDT)
Subject: Re: EIO with io_uring O_DIRECT writes on ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190723080701.GA3198@stefanha-x1.localdomain>
 <9a13c3b9-ecf2-6ba7-f0fb-c59a1e1539f3@kernel.dk>
 <20190723200713.GA4565@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed518886-19b1-88c4-a63c-8bde65330e5b@kernel.dk>
Date:   Tue, 23 Jul 2019 14:11:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723200713.GA4565@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/23/19 2:07 PM, Theodore Y. Ts'o wrote:
> On Tue, Jul 23, 2019 at 09:20:05AM -0600, Jens Axboe wrote:
>>
>> I actually think it's XFS that's broken here, it's not passing down
>> the IOCB_NOWAIT -> IOMAP_NOWAIT -> REQ_NOWAIT. This means we lose that
>> important request bit, and we just block instead of triggering the
>> not_supported case.
>>
>> Outside of that, that case needs similar treatment to what I did for
>> the EAGAIN case here:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=893a1c97205a3ece0cbb3f571a3b972080f3b4c7
>>
>> It was a big mistake to pass back these values in an async fashion,
>> and it also means that some accounting in other drivers are broken
>> as we can get completions without the bio actually being submitted.
> 
> Hmmm, I had been trying to track down a similar case with virtio-scsi
> on top of LVM, using a Google Compute Engine VM.  In that case,
> xfstests generic/471 was failing with EIO, when it would pass just
> *fine* when I was using KVM with a virtio-scsi device w/o LVM.
> 
> So it sounds like that what's going on is if the device driver (or
> LVM, or anything else in the storage stack) needs to do a blocking
> memory allocation, and NOWAIT is requested, we'll end up returning EIO
> because an asynchronous error is getting reported, where as if we
> could return it synchronously, the file system could properly return
> EOPNOTSUP.  Am I understanding you correctly?

Yes, that's exactly right. The EAGAIN/EOPNOTSUPP for blocking reasons
should be returned sync, so ext4/xfs can return that error as well. This
enables us to punt the IO appropriately to a workqueue. It should NOT
result in being translated into an EIO to the application.

Working on this change right now...

> I guess there's a separate question hiding here, which is whether
> there's a way to allow dm-linear or dm-crypt to handle NOWAIT requests
> without needing to block.

That's certainly the next step. Right now we just guard this with
queue_is_mq(), but in reality it should be a queue flag so that stacking
drivers can opt in when they have been vetted/changed to support NOWAIT
properly.

But wading through this stuff is leaving me a little disappointed in the
level of NOWAIT support we have right now. It seems mostly half-assed
and there are plenty of cases where we don't really do the right thing.
I'll try and work through all that, to the extent possible.

-- 
Jens Axboe

