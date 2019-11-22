Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A5E10627E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 07:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfKVGE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 01:04:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33511 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfKVGEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:04:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so2686410plb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IJ0HXeQ4d+68jwWIyI+XQ5DbgzQ1/j4dM9G5pBOB+eo=;
        b=vJ9jtHmYPtLtKFi3vCRLLTUHiSSKMy3wEpuZ12W/IL3jWTM11eh2l9uDYBR1l2hDOP
         ATt0hRwOr3n8y9U2u/6ryAlcdnOnhzlpxg58f9f7giJvyGr79bFrUUhKK6PQByG97I9d
         +Ahkv0MKlnD6BC83ogQrOuNWQytOtf/83m6tFEqQtPu2OKZcDhrliEOaLu+aCPq3G8B8
         PXMHjMPwI8cXeLW3OH7Yh/ivcgf6WxQ/BpWY+NPj4/xP0L5pBcKCsnZNN8MemRcbIHIj
         8Vs6YxOifbHIKkPWlwVK4RfIG1iOiIQXF11sjAYUj9Hx9RjtqTiKCupuCUawpElp0SZv
         TnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IJ0HXeQ4d+68jwWIyI+XQ5DbgzQ1/j4dM9G5pBOB+eo=;
        b=Y3aqL/fX50GnK929zYra40P4Tm5aRJDUxY71kHAOtxNEzj6a0op/PGv+zMtfUp2e5K
         YFYKffGm6J5L+hoqMzbYzJ6c9FSgsQ14VYu5g+Idh+VlSRmmhiSlLfMczonmIiyVKjGF
         1+VRq2O9h5On31xmzFG5bI6D77j64y9F8lt0HDQNEgMGXRrgiwopxvZhuohyQ8dvRz4X
         Jd1uWZ1tQdsIEYkYEhlWjz62/bDjqJuyheYF2JgVvHOpR/dUofkyS+G56bNGVSI+jemB
         EIMd0R2zmA03ZzTiAhx9tW+bLhroCBgOJpWqikbe8GTjbvYA29cMKEKOH8aAh8WotQ7l
         Hefw==
X-Gm-Message-State: APjAAAV++yNs3SNRJuwyYn6CVm3a57w3CwbqJUjfa+VB25FOdwKoXNlw
        /GW67mjoHkWZP/diSux/Q2Uti9fsng==
X-Google-Smtp-Source: APXvYqzoH8MKHCeNwMO8iuN66ncBbRVk1BNgd3NNugpsk+1JUny3bvPS9DWSBHfRL8gsi9eV2ebyoA==
X-Received: by 2002:a17:90b:281:: with SMTP id az1mr17024907pjb.27.1574402664010;
        Thu, 21 Nov 2019 22:04:24 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id b24sm5607526pfi.148.2019.11.21.22.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 22:04:23 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:04:17 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: Fix pipe page leakage during splicing
Message-ID: <20191122060415.GA13786@bobrowski>
References: <20191121161144.30802-1-jack@suse.cz>
 <20191121161538.18445-1-jack@suse.cz>
 <20191121235528.GO6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121235528.GO6211@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:55:28PM -0800, Darrick J. Wong wrote:
> On Thu, Nov 21, 2019 at 05:15:34PM +0100, Jan Kara wrote:
> > @@ -497,8 +497,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  		}
> >  		pos += ret;
> >  
> > -		if (iov_iter_rw(iter) == READ && pos >= dio->i_size)
> > +		if (iov_iter_rw(iter) == READ && pos >= dio->i_size) {
> > +			/*
> > +			 * We will report we've read data only upto i_size.
> 
> Nit: "up to"; will fix that on the way in.

A nit of a nit: "We will report that we've read..."; I think it reads
better, so might as well update it if you're already fixing the other
nit up as you're pulling this in. :P

/M
