Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917E22EA2B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 02:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbhAEBFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 20:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbhAEBFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:05:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2391C061574;
        Mon,  4 Jan 2021 17:04:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n3so546449pjm.1;
        Mon, 04 Jan 2021 17:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1QNZU8co2AlXE0pm+2h1Yk0qrF1L4Gr1a0n9AALm2WI=;
        b=GzlACI2zcTqvhcInD1FctS9DMxGJUvSirWYap4iPn/ptH3pHIedcKVKGNDFLYs4qzs
         aLVHvpLzXdHkSaNu05fqxtXGd7h2QvC8WZfXy6ZeYJfWZdZs/UWRhUpjClpdg7B/+36f
         l2+g6Mr6Eyq3WE2pWvms2F300gFYkg8y/ehqYI1//KESqLgG/mMo24jQW6TzUvCC1Og4
         PzHG1zZjjdE1NQ4r3Atg/KmVeFTOlMlQ5jE94aD/ePNJpv8HXcbUrKQDzDqvuMQ3OyKr
         sIx9XTgObQFtr2bXmvnozVjhM6MRVlW/e4joBuHOvL/FZLvIbCc7xwKQKp5/pLs+bPbM
         wxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QNZU8co2AlXE0pm+2h1Yk0qrF1L4Gr1a0n9AALm2WI=;
        b=f8TtGkdkOeQMgcdQ4wDVUHul+6mlKaQk6X2UXIcY/UTpDBhaJ4kiOez5jYpN5Oy1Gs
         sg7mFOvMc7UuV3DMf9A9ej4pJMA8CK5R2UazULR74ZLnPEZDEq1+pcnv5ffRUq2S9sKL
         K6YQILG9DoaZ68iazDFLWUYpNTItexNQscKbuBwvhJWS3YyckeM6pM7QpnBtDlZ/femj
         GWljVv3LF7cHc6z7BZcGh1p7NCFM71BYwA6vD8B0ngQmRZLUrowsNhJnAZSYx7rlcjAa
         kvpRhBZlMVidlMycO6uASMDeKawtZWvtGO4rJg0mOeL20DAZiUWEUnPVPHymlCT3EZ2i
         ZPCg==
X-Gm-Message-State: AOAM53354CrsBs53ZQQk4Iz1/U/JLK2bwc8oPrOzkHW8ddJQf9fjUVKg
        qc8CrsZZBcLAnmiBCrDzy92xFshPf5E=
X-Google-Smtp-Source: ABdhPJxD1Vsxt83d4M4eleUDaXcH86bZP59+mQP+nnFOwm81dTJGipUq68VFfx3PsaYC/gjZ3lLJKw==
X-Received: by 2002:a17:90a:6809:: with SMTP id p9mr1490882pjj.112.1609808699244;
        Mon, 04 Jan 2021 17:04:59 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id t206sm52578539pgb.84.2021.01.04.17.04.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Jan 2021 17:04:58 -0800 (PST)
Date:   Tue, 5 Jan 2021 10:04:56 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [RFC PATCH V3 1/1] block: reject I/O for same fd if block size
 changed
Message-ID: <20210105010456.GA6454@localhost.localdomain>
References: <20210104130659.22511-1-minwoo.im.dev@gmail.com>
 <20210104130659.22511-2-minwoo.im.dev@gmail.com>
 <20210104171108.GA27235@lst.de>
 <20210104171141.GB27235@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104171141.GB27235@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christoph,

Thanks for your review.

On 21-01-04 18:11:41, Christoph Hellwig wrote:
> On Mon, Jan 04, 2021 at 06:11:08PM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 04, 2021 at 10:06:59PM +0900, Minwoo Im wrote:
> > > +	if (q->backing_dev_info && q->backing_dev_info->owner &&
> > > +			limits->logical_block_size != size) {
> > > +		bdev = blkdev_get_no_open(q->backing_dev_info->owner->devt);
> > > +		bdev->bd_disk->flags |= GENHD_FL_BLOCK_SIZE_CHANGED;
> > > +		blkdev_put_no_open(bdev);
> > > +	}
> > 
> > We really need the backpointer from the queue to the gendisk I've wanted
> > to add for a while.  Can we at least restrict this to a live gendisk?

It was a point that I really would like to ask by RFC whether we can
have backpointer to the gendisk from the request_queue.  And I'd like to
have it to simplify this routine and for future usages also.

I will restrict this one by checking GENHD_FL_UP flag from the gendisk
for the next patch.

> 
> Alternatively we could make this request_queue QUEUE* flag for now.

As this patch rejects I/O from the block layer partition code, can we
have this flag in gendisk rather than request_queue ?

Thanks,
