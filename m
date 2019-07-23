Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04E371B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfGWPUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 11:20:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46271 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGWPUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:20:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id k189so554222pgk.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMqaj6SGuLc8j2Ie/pnfPLRSqGInfw4Z/fscLy0d0hE=;
        b=JalB773CKhMYQbon3eAFra8DgLUptwg6nV5QM/M4iWOmo6Mz9JDKYfqPvuyvbVA5M2
         HJU8Mue5IR0ltMqCnRe4dpOUw53cybld7HYaNbRYmCvK7kgpAkEQ8y5cKyYTlHsFPVIh
         EK5NdezKFepLPOR9+dqVstDY+f2n9BfberTkCNno914PUYfvbVv/2JIt6qXwyawA0nqM
         WzwJ/SAtFy/IYy1YcR+tipCJUJy6zOv4496FsEkj47uJkNoeXbV/8U0vqkSG8l8dBYW4
         QKIWaxcGhl+HcsXIMnM4qSNqIcxme/oBt5HXSX4rA3/hqmBo4Hh+BKHiqmU8Ufomt94J
         7X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMqaj6SGuLc8j2Ie/pnfPLRSqGInfw4Z/fscLy0d0hE=;
        b=PxPoaiqHuCX21NT+VR0ulc/QRhTZB0dMsW5BGJCsAb+naxOosDwRIY4claR5HgsXj8
         cdPES/vFlt+Bkf6Ym64psLhxnczU/RAV5BRV6ylZ/ku8wshN0bzBgihNcoIGqyY1e8nU
         wiZCAhn5VHR2loyz+1n16NijOE9HI7bwYjyq88W8CUo4U8ffyjyd4Jqa6Xi5Ckd069wb
         JE0jwQvcdQIigvz0ohjcGSIkQVkvx6oDwkSuoQsP3BuZrwKwiSFBQJYnqZE14NKebn2T
         0LykxAyTMb2AcJlLLLIYLFBKoJKV7RXdxNbjJtMAbNks6g/gpzs9hjAwJ85HyI23tHPC
         Zo9A==
X-Gm-Message-State: APjAAAW7jGgZdXAv1qg/llTK5Efcgf60D0TtX1M0gR3rQrsI0ewXc9f7
        PHR04F47SLCkdtXYnK5N1Ao=
X-Google-Smtp-Source: APXvYqymCR57kpY7Y+rT9jru5QurmeRERrc+/cqlKX6J3Cv+ot5V12N25HQTM41/Wjppk6XDAufdmQ==
X-Received: by 2002:a63:f452:: with SMTP id p18mr51184567pgk.373.1563895208235;
        Tue, 23 Jul 2019 08:20:08 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id p20sm64809458pgj.47.2019.07.23.08.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 08:20:07 -0700 (PDT)
Subject: Re: EIO with io_uring O_DIRECT writes on ext4
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20190723080701.GA3198@stefanha-x1.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a13c3b9-ecf2-6ba7-f0fb-c59a1e1539f3@kernel.dk>
Date:   Tue, 23 Jul 2019 09:20:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723080701.GA3198@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/23/19 2:07 AM, Stefan Hajnoczi wrote:
> Hi,
> io_uring O_DIRECT writes can fail with EIO on ext4.  Please see the
> function graph trace from Linux 5.3.0-rc1 below for details.  It was
> produced with the following qemu-io command (using Aarushi's QEMU
> patches from https://github.com/rooshm/qemu/commits/io_uring):
> 
>    $ qemu-io --cache=none --aio=io_uring --format=qcow2 -c 'writev -P 185 131072 65536' tests/qemu-iotests/scratch/test.qcow2
> 
> This issue is specific to ext4.  XFS and the underlying LVM logical
> volume both work.
> 
> The storage configuration is an LVM logical volume (device-mapper linear
> target), on top of LUKS, on top of a SATA disk.  The logical volume's
> request_queue does not have mq_ops and this causes
> generic_make_request_checks() to fail:
> 
>    if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
>            goto not_supported;
> 
> I guess this could be worked around by deferring the request to the
> io_uring work queue to avoid REQ_NOWAIT.  But XFS handles this fine so
> how can io_uring.c detect this case cleanly or is there a bug in ext4?

I actually think it's XFS that's broken here, it's not passing down
the IOCB_NOWAIT -> IOMAP_NOWAIT -> REQ_NOWAIT. This means we lose that
important request bit, and we just block instead of triggering the
not_supported case.

Outside of that, that case needs similar treatment to what I did for
the EAGAIN case here:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=893a1c97205a3ece0cbb3f571a3b972080f3b4c7

It was a big mistake to pass back these values in an async fashion,
and it also means that some accounting in other drivers are broken
as we can get completions without the bio actually being submitted.
This was fixed for just the EAGAIN case here:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=c9b3007feca018d3f7061f5d5a14cb00766ffe9b

but that's still broken for EOPNOTSUPP.

tldr is that we should pass these errors back sync, and it was a
mistake to EVER try and do that through ->bi_end_io(). That behavior
was introduced by:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=03a07c92a9ed9938d828ca7f1d11b8bc63a7bb89

I'll add a patch on top of my for-linus branch that makes us handle
the EOPNOTSUPP case similarly. You are right that in those cases we
should just punt to the async worker internally.

-- 
Jens Axboe

