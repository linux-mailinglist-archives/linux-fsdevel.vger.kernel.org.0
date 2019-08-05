Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60047824E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfHESbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 14:31:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfHESbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:31:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so40051743pff.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vb8nbD2Y1AOSenS6ipNePv+hTU0AoDzRe+mZjBVr60M=;
        b=FQ8/QJpU54Q9mPsBz1vezdjjZXYOxrJuwkraIVrC3qVrJy+JMQvnudcxnrGnmYGIis
         7AK36mhKrkFLaZybuTAqOIop6z79CkC10BJ+ZUqsHEDSzK79w1IFtwJ5EUlFWKrJ4Io2
         mFPMStY1iUCBfcBX87585Ups5roZeKCmm5w1N9uypZU/sORcrcDobdmQwgHQaljfACEj
         xXetezN1a597Jlhmre0s3NXXzRpiJeCPBOd9pUkij22C2/JjPabN0W2fpiJHHeH29sFd
         MEUKK7uODxB/qLFxj+bXjbAMYsdFad36OcaKn1AjVefqUkMMX4zaQluV4Z9L/VSHur+n
         i65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vb8nbD2Y1AOSenS6ipNePv+hTU0AoDzRe+mZjBVr60M=;
        b=R3uIWLhHS4RBd4Ubk9dXlPVVBkix0hNCEgY036RvTnEHlE84/6xXfJ+YHqw88mLmex
         JxJZF48SPCJVZTAVsXnSY1quDUbhBh2eZa/rFcyKKKDUhR6Fjg8rHvl/NJY1mlI+imOQ
         jHTQKLZv5ssOOf60k0bpPNb5OBC8GEL2W8JJThLoeGwiPmPwZH9MvTUw7YbWjbpRkrtm
         ONwb2PWlDHjhpon/ATJZf2+LdgCE4n5HjLybiskqomSOu3XxrEC1LcxSbkn2XESBuS1m
         xywiaP+zmpYgaSNgBIHJecPR05yDM4q0ojHBiuUy+pzo2vlJB76l0mNhpWyPb1efnkhB
         dD2w==
X-Gm-Message-State: APjAAAUXbUT+UtuM5a+K1Cnbxx4Wemq4ZXbdQ6Ao7GH+vmwL5+HT1qKj
        z6YJBGqiBSWQkoSVuOugDU0=
X-Google-Smtp-Source: APXvYqwX4fkAXNbMrX/LeQdVs9rPoIiPR2SpBszm11zSzS9alOptNdzZLMy3TcM4lU/bdoQWooQc0Q==
X-Received: by 2002:a63:3ec7:: with SMTP id l190mr141567457pga.334.1565029897982;
        Mon, 05 Aug 2019 11:31:37 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:3cf5:36ed:899e:8d54? ([2605:e000:100e:83a1:3cf5:36ed:899e:8d54])
        by smtp.gmail.com with ESMTPSA id q69sm21408838pjb.0.2019.08.05.11.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:31:36 -0700 (PDT)
Subject: Re: Block device direct read EIO handling broken?
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
References: <20190805181524.GE7129@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
Date:   Mon, 5 Aug 2019 11:31:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805181524.GE7129@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/5/19 11:15 AM, Darrick J. Wong wrote:
> Hi Damien,
> 
> I noticed a regression in xfs/747 (an unreleased xfstest for the
> xfs_scrub media scanning feature) on 5.3-rc3.  I'll condense that down
> to a simpler reproducer:
> 
> # dmsetup table
> error-test: 0 209 linear 8:48 0
> error-test: 209 1 error
> error-test: 210 6446894 linear 8:48 210
> 
> Basically we have a ~3G /dev/sdd and we set up device mapper to fail IO
> for sector 209 and to pass the io to the scsi device everywhere else.
> 
> On 5.3-rc3, performing a directio pread of this range with a < 1M buffer
> (in other words, a request for fewer than MAX_BIO_PAGES bytes) yields
> EIO like you'd expect:
> 
> # strace -e pread64 xfs_io -d -c 'pread -b 1024k 0k 1120k' /dev/mapper/error-test
> pread64(3, 0x7f880e1c7000, 1048576, 0)  = -1 EIO (Input/output error)
> pread: Input/output error
> +++ exited with 0 +++
> 
> But doing it with a larger buffer succeeds(!):
> 
> # strace -e pread64 xfs_io -d -c 'pread -b 2048k 0k 1120k' /dev/mapper/error-test
> pread64(3, "XFSB\0\0\20\0\0\0\0\0\0\fL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1146880, 0) = 1146880
> read 1146880/1146880 bytes at offset 0
> 1 MiB, 1 ops; 0.0009 sec (1.124 GiB/sec and 1052.6316 ops/sec)
> +++ exited with 0 +++
> 
> (Note that the part of the buffer corresponding to the dm-error area is
> uninitialized)
> 
> On 5.3-rc2, both commands would fail with EIO like you'd expect.  The
> only change between rc2 and rc3 is commit 0eb6ddfb865c ("block: Fix
> __blkdev_direct_IO() for bio fragments").
> 
> AFAICT we end up in __blkdev_direct_IO with a 1120K buffer, which gets
> split into two bios: one for the first BIO_MAX_PAGES worth of data (1MB)
> and a second one for the 96k after that.
> 
> I think the problem is that every time we submit a bio, we increase ret
> by the size of that bio, but at the time we do that we have no idea if
> the bio is going to succeed or not.  At the end of the function we do:
> 
> 	if (!ret)
> 		ret = blk_status_to_errno(dio->bio.bi_status);
> 
> Which means that we only pick up the IO error if we haven't already set
> ret.  I suppose that was useful for being able to return a short read,
> but now that we always increment ret by the size of the bio, we act like
> the whole buffer was read.  I tried a -rc2 kernel and found that 40% of
> the time I'd get an EIO and the rest of the time I got a short read.
> 
> Not sure where to go from here, but something's not right...

I'll take a look.

-- 
Jens Axboe

