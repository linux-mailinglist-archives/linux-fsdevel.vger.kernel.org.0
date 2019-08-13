Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE16C8B5CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfHMKn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 06:43:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37496 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfHMKn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:43:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so4463756pfa.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1qklavnkTkWQJy1JopwbXdEDiZx8NzuMuRiS/ag2Wgs=;
        b=GCczMx5epHAUCi8ppC9r92rGWtBdcIQUaqjdTrk2/fLntT8fEjLlxy9wRHZA3xU+ql
         3AwKB5s/DdQSlqfXDvR6Yh38AqJi/OgU8DqHW4kkdWsD15nccdwZ+qeW5KUE9UGAiwVX
         Mfxo/pTPVsm/3eKj4AAe77vE+bWXeyC9VxVlzfLIXOyq5iDU8vG9IKA/60wNlfyd1t3t
         hDXd1dUbNocIdUK3+W562n07rN3luWkV9n44OQSKbt8DtJPST3sLvsF4Apb4bpkEFb9m
         myTSHbPHUrjhGOFwV7nH5zd6xIgmGUIz6Qa5DgI41ym2t1h4Yz+NK2QLHQuQ5IAPmamW
         DCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1qklavnkTkWQJy1JopwbXdEDiZx8NzuMuRiS/ag2Wgs=;
        b=tMWndyAlUggmIOWdD9YdSgKq2rRIs+mFZp5gnBIgzm8QB1dIAHdbu6Ti3Oh9ly5RRX
         0Z2qaoJUbmx8jP75vEzWfKlCgkLRGzzlv5xgu7MhDFbiZnC7lkoUnBC+na0eT5RmGr4z
         VkPaDmqmgQfB8OYSe7LyKWxslfsuCDmrMYJTQAkt/qtQOCMZAI3IVnoIPHRr/T4evdt9
         65gGLNtwYuMhDAFnS4qiJq3xKCSAWB0AVdUtmindH1syRNUiTHptweRl+zkY23evxl2F
         Drfiwj0dBoE9voBLrUg27w9KXaveHPdzp2k/ActXkXB3XwCnv5exlonUytzwfD6hRMjg
         EEfQ==
X-Gm-Message-State: APjAAAXhps81yy/xsAuDJl7wArPDv5+13qjOO3IP9ofs8Gq+RCzUMJaA
        IEti/bbqHsUsWjp9vf1uF0LW
X-Google-Smtp-Source: APXvYqw+03RFdMM3Vy6a0u+2sgJvuS/z55JRiw2M+5zYi2IK9y+vx1Ks2ApbZH64SHRsFl8zW/eX4w==
X-Received: by 2002:aa7:96ee:: with SMTP id i14mr19469600pfq.217.1565693035778;
        Tue, 13 Aug 2019 03:43:55 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id n7sm123051936pff.59.2019.08.13.03.43.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:43:55 -0700 (PDT)
Date:   Tue, 13 Aug 2019 20:43:49 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 3/5] iomap: modify ->end_io() calling convention
Message-ID: <20190813104347.GA27628@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <f4abda9c0c835d9a50b644fdbec8d43269f6b0f7.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812171832.GA24564@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812171832.GA24564@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:18:32AM -0700, Christoph Hellwig wrote:
> please add linux-xfs to the cc list for the whole series.  Besides
> touching xfs itself it is also mentioned in MAINTAINERS for the iomap
> code.

Firstly, thank you for the review, highly appreciated! Secondly, not a
problem, will do.

> On Mon, Aug 12, 2019 at 10:53:11PM +1000, Matthew Bobrowski wrote:
> > -	if (size <= 0)
> > -		return size;
> > +	if (error || !size)
> > +		return error ? error : size;
> 
> This should be:
> 
> 	if (error)
> 		return error;
> 	if (!size)
> 		return 0;

OK.

> >  	if (flags & IOMAP_DIO_COW) {
> > -		error = xfs_reflink_end_cow(ip, offset, size);
> > -		if (error)
> > +		ret = xfs_reflink_end_cow(ip, offset, size);
> > +		if (ret)
> 
> I think we can just keep reusing error here.

Ah yes, that will work.

> > +typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size,
> > +				 ssize_t error, unsigned int flags);
> 
> error should be an int and not a ssize_t.

Updated.

--M
