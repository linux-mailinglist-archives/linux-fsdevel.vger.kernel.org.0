Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4222EA84E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 11:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbhAEKMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 05:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbhAEKMr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:12:47 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E418C061793;
        Tue,  5 Jan 2021 02:12:07 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n10so20971009pgl.10;
        Tue, 05 Jan 2021 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s6MIg1by4xxMrWniV9WmT7wL3vQp0SC+5JFNaInbk7g=;
        b=IxQVrP0of1IbChhiAKviNyE6d95TPLiOq/QqK6rbSqrFX7ayK0s3nAK8E15gNzxosg
         UXIE0C+4AEIg6kX5YcT11cbMYHb85nt/rFFyuGsBoMsO7K7AIxdeKxjSG2XWDoVxjUkh
         nfHCiLo1b8w6lkajAx1UKSdmzGFAW+MFHrm3YqTOUrJiNPKV2IFj7ktlKzOwK9QvMFhj
         iHGWoIRSaJ/wX1PqyMcgjF/U6xTQ3Fdfg9FJva0QQ2erzWvkjvVSV7uzv8rT6eNKz9mk
         WVpcnhhaRUyHj34Z0QlUHuGK9lQ2RDAS6FxWt9Obin96Z3DGdbZ9ZYTi18kHOtPWOwZi
         DDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6MIg1by4xxMrWniV9WmT7wL3vQp0SC+5JFNaInbk7g=;
        b=AiP3WXRTlO3wNZWdpVOr0gPRI1WuM5cTCTetP/z5DQ6AnStz/mE3QGOfTKdn9YIELn
         kZlFpKemEv0X/Nw13n3q5tgl1BH8pCXxeJy54+TGTVXyp6puZMlCDgqs05oulT4G6G2j
         q5vot3+L98/8DMzOhiGs+DZ1eGsjWH2cX/wlEiF7iZxZaITYBWUkjorBUWt7MZU0ovkp
         ojHIP88ssxIk9Eh4HN+C7rJOPx3zK0jpcq/74qcUHKd438ErCT0rrIUSoabpddmEKpr3
         id6GTiPTGjeze+4n5Ab5kAgP4r/bhwcpu1Zjaz1i2/fYp1wXa6Q8zzIx806q27Z3Eg6J
         831w==
X-Gm-Message-State: AOAM531cVAQdSFM9XdjbJ/c8YKpWKUPS+ryASZidU1YbfzkzttJbGqzS
        hhi8kgIzhtrvF2oSV9mO32dVOOU2Svk=
X-Google-Smtp-Source: ABdhPJzMmTATlj4o28EQdMzNkIFfTFD63ya/GZyNscl6IKKhdhsYxo35yHvASuXrlDytfK5JCFtvrQ==
X-Received: by 2002:a05:6a00:22ce:b029:197:9168:80fb with SMTP id f14-20020a056a0022ceb0290197916880fbmr48483416pfj.38.1609841527168;
        Tue, 05 Jan 2021 02:12:07 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id u12sm57403310pfh.98.2021.01.05.02.12.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 02:12:06 -0800 (PST)
Date:   Tue, 5 Jan 2021 19:12:02 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [RFC PATCH V3 1/1] block: reject I/O for same fd if block size
 changed
Message-ID: <20210105101202.GA9970@localhost.localdomain>
References: <20210104130659.22511-1-minwoo.im.dev@gmail.com>
 <20210104130659.22511-2-minwoo.im.dev@gmail.com>
 <20210104171108.GA27235@lst.de>
 <20210104171141.GB27235@lst.de>
 <20210105010456.GA6454@localhost.localdomain>
 <20210105075009.GA30039@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210105075009.GA30039@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On 21-01-05 08:50:09, Christoph Hellwig wrote:
> On Tue, Jan 05, 2021 at 10:04:56AM +0900, Minwoo Im wrote:
> > It was a point that I really would like to ask by RFC whether we can
> > have backpointer to the gendisk from the request_queue.  And I'd like to
> > have it to simplify this routine and for future usages also.
> 
> I think it is the right thing to do, at least mid-term, although I
> don't want to enforce the burden on you right now.
> 
> > I will restrict this one by checking GENHD_FL_UP flag from the gendisk
> > for the next patch.
> > 
> > > 
> > > Alternatively we could make this request_queue QUEUE* flag for now.
> > 
> > As this patch rejects I/O from the block layer partition code, can we
> > have this flag in gendisk rather than request_queue ?
> 
> For now we can as the request_queue is required.  I have some plans to
> clean up this area, but just using a request_queue flag for now is
> probably the simplest, even if it means more work for me later.

Please let me prepare the next quick fix for this issue with request_queue
flag.

Thanks!
