Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586B18266E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfHEUyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 16:54:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37005 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfHEUyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:54:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so40230819pfa.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BYZwUORecUaeQkTZfE49ilvei7zsyKX85efnVjmDIlw=;
        b=LhywjhmmXLzJYOnJkIqbdn4V9tMLhcgL82kf1iqB22CntmYWpLkjzDX1/YJfGJ4zdy
         Iji0aFanWcVverds3lUM7vSBo/MjkY7VLankQMnkc2AcGSRKrRuW8nLVctbaGqyyi0cc
         kZ0ZX9R1eqUZkLl9KzqWzHj1jzhrTIiDBFEA0likyo8JprGS/fsk70Kx+zv+iRWQVAaU
         c8HwN4QgCbcxrwm1OTe45kt7fJ0N15lf5WU2cGRTQBWOYFdKAG6ZWX/VAEbAeM6PB5hM
         om4BnNBw/u+gEpeXNOuvafE8Ll7Xummlk4InNtZyj4dnOZvv1tzKy4OCmcYYYigfi8pu
         wHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BYZwUORecUaeQkTZfE49ilvei7zsyKX85efnVjmDIlw=;
        b=NT7jDb7W5hzA3HVFZgvIPC/YmsXQLYKZvXm+pTnGM4sLwUHrnjn6yaLh6JOYtt0P6Y
         1ODfMD1rOOVg9+KkpsybJQiTDeCpWGNVBkEOalr996I9LYsmTvNqw7Yghlv+FSeHuwpf
         KFuXnFehBw09pV/ophv3P01d1j7jbBXtpNZbEV0+npXFciElugRE1p+pG1qaXuZiuwBz
         QgByUeA/wcMM7B2SyKN78yud0Dt1TU3b8jJdVTN0PdOO5HRkb1eUfyj+Cm0a6N9BKPqR
         fQFpA1BpCzAfNuFGD1zwQNCcIJLQTpJMAacI2e/WNkllJQx4KYCTzvDAAUfnDi3epBG9
         jFTA==
X-Gm-Message-State: APjAAAVSYBvDoulDOwCVcLLxBN/AFX2FwqmBT/JoxSo113mwKDmFJOoa
        MjDwh+PPv50eS1h+A6APkp1LXe+zypdAtA==
X-Google-Smtp-Source: APXvYqwH/6i6cewszH/0EDJbdAsHoDNp3FGR8pj+kKkPdEKDU7JXRuf3TZCiLO/HN9TQMVsZWkeE9Q==
X-Received: by 2002:a17:90a:2525:: with SMTP id j34mr20468793pje.11.1565038488523;
        Mon, 05 Aug 2019 13:54:48 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:3cf5:36ed:899e:8d54? ([2605:e000:100e:83a1:3cf5:36ed:899e:8d54])
        by smtp.gmail.com with ESMTPSA id r188sm133466806pfr.16.2019.08.05.13.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 13:54:47 -0700 (PDT)
Subject: Re: Block device direct read EIO handling broken?
From:   Jens Axboe <axboe@kernel.dk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
Message-ID: <1de52140-bc7b-2f1f-0c12-a2f453defdcd@kernel.dk>
Date:   Mon, 5 Aug 2019 13:54:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/5/19 1:31 PM, Jens Axboe wrote:
> On 8/5/19 11:31 AM, Jens Axboe wrote:
>> On 8/5/19 11:15 AM, Darrick J. Wong wrote:
>>> Hi Damien,
>>>
>>> I noticed a regression in xfs/747 (an unreleased xfstest for the
>>> xfs_scrub media scanning feature) on 5.3-rc3.  I'll condense that down
>>> to a simpler reproducer:
>>>
>>> # dmsetup table
>>> error-test: 0 209 linear 8:48 0
>>> error-test: 209 1 error
>>> error-test: 210 6446894 linear 8:48 210
>>>
>>> Basically we have a ~3G /dev/sdd and we set up device mapper to fail IO
>>> for sector 209 and to pass the io to the scsi device everywhere else.
>>>
>>> On 5.3-rc3, performing a directio pread of this range with a < 1M buffer
>>> (in other words, a request for fewer than MAX_BIO_PAGES bytes) yields
>>> EIO like you'd expect:
>>>
>>> # strace -e pread64 xfs_io -d -c 'pread -b 1024k 0k 1120k' /dev/mapper/error-test
>>> pread64(3, 0x7f880e1c7000, 1048576, 0)  = -1 EIO (Input/output error)
>>> pread: Input/output error
>>> +++ exited with 0 +++
>>>
>>> But doing it with a larger buffer succeeds(!):
>>>
>>> # strace -e pread64 xfs_io -d -c 'pread -b 2048k 0k 1120k' /dev/mapper/error-test
>>> pread64(3, "XFSB\0\0\20\0\0\0\0\0\0\fL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1146880, 0) = 1146880
>>> read 1146880/1146880 bytes at offset 0
>>> 1 MiB, 1 ops; 0.0009 sec (1.124 GiB/sec and 1052.6316 ops/sec)
>>> +++ exited with 0 +++
>>>
>>> (Note that the part of the buffer corresponding to the dm-error area is
>>> uninitialized)
>>>
>>> On 5.3-rc2, both commands would fail with EIO like you'd expect.  The
>>> only change between rc2 and rc3 is commit 0eb6ddfb865c ("block: Fix
>>> __blkdev_direct_IO() for bio fragments").
>>>
>>> AFAICT we end up in __blkdev_direct_IO with a 1120K buffer, which gets
>>> split into two bios: one for the first BIO_MAX_PAGES worth of data (1MB)
>>> and a second one for the 96k after that.
>>>
>>> I think the problem is that every time we submit a bio, we increase ret
>>> by the size of that bio, but at the time we do that we have no idea if
>>> the bio is going to succeed or not.  At the end of the function we do:
>>>
>>> 	if (!ret)
>>> 		ret = blk_status_to_errno(dio->bio.bi_status);
>>>
>>> Which means that we only pick up the IO error if we haven't already set
>>> ret.  I suppose that was useful for being able to return a short read,
>>> but now that we always increment ret by the size of the bio, we act like
>>> the whole buffer was read.  I tried a -rc2 kernel and found that 40% of
>>> the time I'd get an EIO and the rest of the time I got a short read.
>>>
>>> Not sure where to go from here, but something's not right...
>>
>> I'll take a look.
> 
> How about this? The old code did:
> 
> 	if (!ret)
> 		ret = blk_status_to_errno(dio->bio.bi_status);
> 	if (likely(!ret))
> 		ret = dio->size;
> 
> where 'ret' was just tracking the error. With 'ret' now being the
> positive IO size, we should overwrite it if ret is >= 0, not just if
> it's zero.
> 
> Also kill a use-after-free.

This should be better, we don't want to override 'ret' is bio->bi_status
doesn't indicate an error.


diff --git a/fs/block_dev.c b/fs/block_dev.c
index a6f7c892cb4a..1ac89f4fcbcc 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -386,6 +386,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	ret = 0;
 	for (;;) {
+		ssize_t this_size;
 		int err;
 
 		bio_set_dev(bio, bdev);
@@ -433,13 +434,14 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				polled = true;
 			}
 
+			this_size = bio->bi_iter.bi_size;
 			qc = submit_bio(bio);
 			if (qc == BLK_QC_T_EAGAIN) {
 				if (!ret)
 					ret = -EAGAIN;
 				goto error;
 			}
-			ret = dio->size;
+			ret += this_size;
 
 			if (polled)
 				WRITE_ONCE(iocb->ki_cookie, qc);
@@ -460,13 +462,14 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			atomic_inc(&dio->ref);
 		}
 
+		this_size = bio->bi_iter.bi_size;
 		qc = submit_bio(bio);
 		if (qc == BLK_QC_T_EAGAIN) {
 			if (!ret)
 				ret = -EAGAIN;
 			goto error;
 		}
-		ret = dio->size;
+		ret += this_size;
 
 		bio = bio_alloc(gfp, nr_pages);
 		if (!bio) {
@@ -494,7 +497,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	__set_current_state(TASK_RUNNING);
 
 out:
-	if (!ret)
+	if (ret >= 0 && dio->bio.bi_status)
 		ret = blk_status_to_errno(dio->bio.bi_status);
 
 	bio_put(&dio->bio);

-- 
Jens Axboe

