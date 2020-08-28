Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC38255914
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgH1LEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 07:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbgH1LEN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:04:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEED207DF;
        Fri, 28 Aug 2020 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598612653;
        bh=c7c25Ad7ytC5Nvm3HpoIhR0Ip8Ni9wwASMQD/vt/XEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdkPbxH3//2B1lmlRwK/7kEk7/mQ+9ro8Jd3YUEfOEhH19iqvfDxISyROvjy2/glP
         bm3gJ7K8TB6Taob/SGu4njdFkrNda4Oa1jnzEwmVX53RM1O5zTfCmUo21Tir9tX866
         BjxQc4iICM4k4NWVGLOh5kJ64l7n4KbOiXjemdRY=
Date:   Fri, 28 Aug 2020 12:04:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuqi Jin <jinyuqi@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [NAK] Re: [PATCH] fs: Optimized fget to improve performance
Message-ID: <20200828110408.GA30722@willie-the-truck>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200827142848.GZ1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827142848.GZ1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:28:48PM +0100, Al Viro wrote:
> On Thu, Aug 27, 2020 at 06:19:44PM +0800, Shaokun Zhang wrote:
> > From: Yuqi Jin <jinyuqi@huawei.com>
> > 
> > It is well known that the performance of atomic_add is better than that of
> > atomic_cmpxchg.
> > The initial value of @f_count is 1. While @f_count is increased by 1 in
> > __fget_files, it will go through three phases: > 0, < 0, and = 0. When the
> > fixed value 0 is used as the condition for terminating the increase of 1,
> > only atomic_cmpxchg can be used. When we use < 0 as the condition for
> > stopping plus 1, we can use atomic_add to obtain better performance.
> 
> Suppose another thread has just removed it from the descriptor table.
> 
> > +static inline bool get_file_unless_negative(atomic_long_t *v, long a)
> > +{
> > +	long c = atomic_long_read(v);
> > +
> > +	if (c <= 0)
> > +		return 0;
> 
> Still 1.  Now the other thread has gotten to dropping the last reference,
> decremented counter to zero and committed to freeing the struct file.
> 
> > +
> > +	return atomic_long_add_return(a, v) - 1;
> 
> ... and you increment that sucker back to 1.  Sure, you return 0, so the
> caller does nothing to that struct file.  Which includes undoing the
> changes to its refecount.
> 
> In the meanwhile, the third thread does fget on the same descriptor,
> and there we end up bumping the refcount to 2 and succeeding.  Which
> leaves the caller with reference to already doomed struct file...
> 
> 	IOW, NAK - this is completely broken.  The whole point of
> atomic_long_add_unless() is that the check and conditional increment
> are atomic.  Together.  That's what your optimization takes out.

Cheers Al, yes, this is fscked.

As an aside, I've previously toyed with the idea of implementing a form
of cmpxchg() using a pair of xchg() operations and a smp_cond_load_relaxed(),
where the thing would transition through a "reserved value", which might
perform better with the current trend of building hardware that doesn't
handle CAS failure so well.

But I've never had the time/motivation to hack it up, and it relies on that
reserved value which obviously doesn't always work (so it would have to be a
separate API).

Will
