Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D601919EE56
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Apr 2020 23:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgDEV4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 17:56:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEV4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 17:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dpw9xsZ0gY0GT7tsgtGf0/8FnrsUbxUf5AWEI2NyNks=; b=uNl11IBgUVuiJEAEneJlEoOmNV
        ns32BrV+sa/IQQIqPRBgg+QkSMiD/pFyPxe+gxE4cX4WYZ1S+sYl16UL/oZplqjVW/GAhvKgIwQqK
        9B2w1/3uPFzDEmBKnF+sOyAwnlUgw/7GQIQBh63DyTIr6qsZMdFXn/rXcAJo8rmzuH5QAwEEqIKOn
        1o7VaqD5iss01kVLoci28nHO6j4lC/BQV+PX3yoDQy6njwZqe68otmKmDFth3iZbVHcqOItKrsZsy
        f9mAd8RHtF8va5uHLZkNIJNE7qyvVwW3tu7VCm+mepzIOtAOAIyz9Jcd0wpVcuE5/f5q5M5fQwE0w
        gJAq0CuQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLDFs-0004o8-T8; Sun, 05 Apr 2020 21:56:36 +0000
Date:   Sun, 5 Apr 2020 14:56:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200405215636.GW21484@bombadil.infradead.org>
References: <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
 <20200331235912.GD21484@bombadil.infradead.org>
 <20200401221021.v6igvcpqyeuo2cws@master>
 <20200401222000.GK21484@bombadil.infradead.org>
 <20200405110743.bzpvz4jzwr4kharr@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405110743.bzpvz4jzwr4kharr@master>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 05, 2020 at 11:07:43AM +0000, Wei Yang wrote:
> Occasionally, I see this error message without my change on 5.6.

I've never seen this one before.  Maybe my test machine is insufficient ...

> random seed 1586068185
> running tests
> XArray: 21151201 of 21151201 tests passed
> =================================================================
> ==6040==ERROR: AddressSanitizer: heap-use-after-free on address 0x60c0031bce81 at pc 0x00000040b4b3 bp 0x7f95e87f9bb0 sp 0x7f95e87f9ba0
> READ of size 1 at 0x60c0031bce81 thread T11
>     #0 0x40b4b2 in xas_find_marked ../../../lib/xarray.c:1182
>     #1 0x45318e in tagged_iteration_fn /root/git/linux/tools/testing/radix-tree/iteration_check.c:77
>     #2 0x7f95ef2464e1 in start_thread (/lib64/libpthread.so.0+0x94e1)
>     #3 0x7f95ee8026d2 in clone (/lib64/libc.so.6+0x1016d2)
> 
> 0x60c0031bce81 is located 1 bytes inside of 128-byte region [0x60c0031bce80,0x60c0031bcf00)
> freed by thread T1 here:
>     #0 0x7f95ef36c91f in __interceptor_free (/lib64/libasan.so.5+0x10d91f)
>     #1 0x43e4ba in kmem_cache_free /root/git/linux/tools/testing/radix-tree/linux.c:64
> 
> previously allocated by thread T13 here:
>     #0 0x7f95ef36cd18 in __interceptor_malloc (/lib64/libasan.so.5+0x10dd18)
>     #1 0x43e1af in kmem_cache_alloc /root/git/linux/tools/testing/radix-tree/linux.c:44
> 
> Thread T11 created by T0 here:
>     #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
>     #1 0x454862 in iteration_test /root/git/linux/tools/testing/radix-tree/iteration_check.c:178
> 
> Thread T1 created by T0 here:
>     #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
>     #1 0x7f95ef235b89  (/lib64/liburcu.so.6+0x3b89)
> 
> Thread T13 created by T0 here:
>     #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
>     #1 0x4548a4 in iteration_test /root/git/linux/tools/testing/radix-tree/iteration_check.c:186
> 
> This is not always like this. Didn't figure out the reason yet. Hope you many
> have some point.

How often are you seeing it?

T1 (the thread which frees the memory) is the RCU thread, so the freeing
went through RCU.  For some reason, T11 (the iterating thread) isn't
preventing the freeing by its use of the RCU read lock.
