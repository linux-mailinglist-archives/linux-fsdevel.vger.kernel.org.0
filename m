Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768D4352DB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhDBQ0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhDBQ0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:26:46 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72BC061788
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Apr 2021 09:26:44 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t14so5055476ilu.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hn40bJBlTBATV+azNkuBgNlV84MuYO3hU1eZaj+u9Fk=;
        b=uOYLnk6kMncaFjl8A/ExK1RWatwMj6DkL3uvwUyT3TI7M57zZSk+LsDPB/RWs/H1Hb
         7ysZeaLTjh0EMC9uIwwq3lPSa8fl7kJWZzBiX9VF81PBUJWrVfr8p3P7IxdvZiuATB4p
         4g20BL/+bddbwSHZIK/H8aT1zoCerh6pJ4mMBEmRZkqaGZXz4Ug7svXis6GDZ+mBXS5i
         88l37oVPJKZCTslzuekiqB5RZmAAMaSP5AtX0L70ZuPP+NQtW9NuKZlcAxV6ZX+m4inT
         1WDH489DAs9kWqvx/y7t8fAulIV9DjxYPMDPioxYZOxcqAsr+4aQLXUESVs08QossG8e
         MzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hn40bJBlTBATV+azNkuBgNlV84MuYO3hU1eZaj+u9Fk=;
        b=EZPFOKCRpkt3Ke2X8K6cQtU4PXGwyYTtBfYE/b0TK6FazWrTLdUCjRxlL8SgtabYS4
         xntAk84YEpcNi9+K4iLPPAjp7n4KrrMwrG7n3HSQmROlKnZx0zBJK4qRSYL4Fxpqa5np
         GcjP8h0GHl5NtapJK2ZsNawUcRDnCNA8+UfiSRkQovJ5sAiOFs3J6gpqYPVjnPuAUvjI
         o4IwjNqU5g7JJ6MJ6+0w0NsJMwXJXQLkYjWg/Cdjp6ppi2fCGw9zGEZzQlF2+VdFqsr7
         mABHG+hS/zdktIo8HbY+Y+IN3xRHBwFDgD7Sm5aj7D55eCWTbzqOMZNBP2SgMs+W6D2g
         Jklg==
X-Gm-Message-State: AOAM5308msfmgHocHBeIm0a/TUOhBBIw1kv3WOOcvesVSjYKhWarGWc5
        pqfNsxxeWXuGl8vCysb/DWluvA==
X-Google-Smtp-Source: ABdhPJytHRUm1y/S/ZGTjgFx4zIYADx5RAn4J4NcvacXzNm7k+aafYLjuLjjK9G6idvwWssyC0MTmQ==
X-Received: by 2002:a05:6e02:1286:: with SMTP id y6mr11541067ilq.270.1617380803892;
        Fri, 02 Apr 2021 09:26:43 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g16sm4327609ilk.22.2021.04.02.09.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 09:26:43 -0700 (PDT)
Subject: Re: [PATCH v3 RESEND] iomap: set REQ_NOWAIT according to IOCB_NOWAIT
 in Direct IO
To:     Pavel Begunkov <asml.silence@gmail.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Hao Xu <haoxu@linux.alibaba.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        io-uring@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <1607075096-94235-1-git-send-email-haoxu@linux.alibaba.com>
 <20201207022130.GC4170059@dread.disaster.area>
 <9bbfafcf-688c-bad9-c288-6478a88c6097@linux.alibaba.com>
 <20201209212358.GE4170059@dread.disaster.area>
 <adf32418-dede-0b58-13da-40093e1e4e2d@linux.alibaba.com>
 <20201210051808.GF4170059@dread.disaster.area>
 <fdb6e01a-a662-90fa-3844-410b2107e850@linux.alibaba.com>
 <20201214025655.GH3913616@dread.disaster.area>
 <a0760c52-cdd7-eb66-27dc-27582c2db825@linux.alibaba.com>
 <1e687bef-3d96-69ad-ec98-c674f5a88ca2@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62452618-d44f-fb88-18b6-80bcf5c8b81d@kernel.dk>
Date:   Fri, 2 Apr 2021 10:26:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1e687bef-3d96-69ad-ec98-c674f5a88ca2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/2/21 8:32 AM, Pavel Begunkov wrote:
> On 15/12/2020 09:43, JeffleXu wrote:
>> Thanks for your explanation, again.
> 
> Got stale, let's bring it up again.

How about something like this - check upfront if we're going to be
using multiple bios, and -EAGAIN for NOWAIT being set if that is
the case. That avoids the partial problem, and still retains (what
I consider) proper NOWAIT behavior for O_DIRECT with IOCB_NOWAIT
set.

It's also worth nothing that this condition exists already for
polled IO. If the bio is marked as polled, then we implicitly
set NOWAIT as well, as there's no way to support polled IO with
sleeping request allocations. Hence it's worth considering this
a fix for that case, too.


diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e2c4991833b8..6f932fe99440 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -66,6 +66,8 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 
 	if (dio->iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(bio, dio->iocb);
+	if (dio->iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
 
 	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
 	if (dio->dops && dio->dops->submit_io)
@@ -236,6 +238,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	unsigned int align = iov_iter_alignment(dio->submit.iter);
+	bool nowait = dio->iocb->ki_flags & (IOCB_HIPRI | IOCB_NOWAIT);
 	unsigned int bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
@@ -296,7 +299,17 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	 */
 	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
 
-	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_PAGES);
+	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, INT_MAX);
+
+	/* Can't handle IOCB_NOWAIT for split bios */
+	if (nr_pages > BIO_MAX_PAGES) {
+		if (nowait) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		nr_pages = BIO_MAX_PAGES;
+	}
+
 	do {
 		size_t n;
 		if (dio->error) {
@@ -326,6 +339,19 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			goto zero_tail;
 		}
 
+		/*
+		 * If there are leftover pages, bail if nowait is set to avoid
+		 * multiple bios and potentially having one of them -EAGAIN
+		 * with the other succeeding.
+		 */
+		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
+						 BIO_MAX_PAGES);
+		if (nr_pages && nowait) {
+			ret = -EAGAIN;
+			bio_put(bio);
+			goto out;
+		}
+
 		n = bio->bi_iter.bi_size;
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
@@ -337,8 +363,6 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		dio->size += n;
 		copied += n;
 
-		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
-						 BIO_MAX_PAGES);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);

-- 
Jens Axboe

