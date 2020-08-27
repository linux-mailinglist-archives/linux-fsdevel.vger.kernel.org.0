Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0742544FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH0MdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 08:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgH0Mau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:30:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2389DC061264;
        Thu, 27 Aug 2020 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQrO7zSmwpoV78sFk/k8GlXhRlZp5fVDS/YXvPmt6Ks=; b=XEFUWH1VZvasCNuBMkR9BGN7FI
        Xqf7NbTIficZUx7OfNX+7TQyHPA+9htVxHBJr8YZIiOMRI6HcRA7yIxbsMCIOEALPFimM8Fq2AeP3
        eJTCS+2a8Iyxg1AubpNLaz+DgggU0X9e4dK4Iq275YmvXqxfks3oTE/DWzcnUn4VvMHZTgJco83E8
        xqdvYYN7TuGjToI4/pu6nCaE/lWCF9QKiCMtAlwJsX6aDIBBKQnzuP+ILVk0EGLYPbtk8qel5vuFR
        8Ma+ZfpkYHnvMla73yOy6xeoZ88qwYhwN9CMEYMlJYqCaXLNgwH9mr7kimEM+5kBAedWncNsfg8t6
        bt3c3XCg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBH3A-0002SH-NF; Thu, 27 Aug 2020 12:30:40 +0000
Date:   Thu, 27 Aug 2020 13:30:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuqi Jin <jinyuqi@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fs: Optimized fget to improve performance
Message-ID: <20200827123040.GE14765@casper.infradead.org>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 06:19:44PM +0800, Shaokun Zhang wrote:
> From: Yuqi Jin <jinyuqi@huawei.com>
> 
> It is well known that the performance of atomic_add is better than that of
> atomic_cmpxchg.

I don't think that's well-known at all.

> +static inline bool get_file_unless_negative(atomic_long_t *v, long a)
> +{
> +	long c = atomic_long_read(v);
> +
> +	if (c <= 0)
> +		return 0;
> +
> +	return atomic_long_add_return(a, v) - 1;
> +}
> +
>  #define get_file_rcu_many(x, cnt)	\
> -	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
> +	get_file_unless_negative(&(x)->f_count, (cnt))
>  #define get_file_rcu(x) get_file_rcu_many((x), 1)
>  #define file_count(x)	atomic_long_read(&(x)->f_count)

I think you should be proposing a patch to fix atomic_long_add_unless()
on arm64 instead.
