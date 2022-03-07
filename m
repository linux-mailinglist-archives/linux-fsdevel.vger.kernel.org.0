Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D94CFFC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 14:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbiCGNSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 08:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiCGNSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:18:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486A2649;
        Mon,  7 Mar 2022 05:17:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25CA3611FE;
        Mon,  7 Mar 2022 13:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09884C340E9;
        Mon,  7 Mar 2022 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646659055;
        bh=KXqVJsDGXLlSnyeaHKWpPIVZqxg9O3xVmH+wFrsgfeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCpGcO8HZcqQApVVZm6OEvQrrIR4vyEHePNnzVROHw1K1NkFuEfNdTu1I59Pj136m
         4rX6fL04mPPpcVfgqfegolGRx6CRsxOiRqFeONVkYWTB6X9EcC5pWRk7rEUGXwdqU6
         OvEMg+WzhEBC6xQTzvpMuPW0Z7aAedCqClhox8xbo/mIon3gdW3d/6JNZjCYFLY4FS
         10pjlBodTW1xrm6ejzkguCe+Ekh4JJCoJJ2mSCIq0lgnb+KYirBLVYOdxv5JfFOaTJ
         0Fzo4KQ6CulRfULGVd4l8OZP4WX94xCRchBbHGrVpM8g8sXszWhkjT9Jfz9c+lUM6v
         8PJS0P6GeVloQ==
Date:   Mon, 7 Mar 2022 15:16:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Alexey Gladkov <legion@kernel.org>, linux-mips@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        codalist@coda.cs.cmu.edu, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] mm: Add f_ops->populate()
Message-ID: <YiYFxq87p2WVkZcz@iki.fi>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <20220306053211.135762-2-jarkko@kernel.org>
 <YiSGgCV9u9NglYsM@kroah.com>
 <YiTpQTM+V6rlDy6G@iki.fi>
 <YiU5E6qqYAI+WPw9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiU5E6qqYAI+WPw9@casper.infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 10:43:31PM +0000, Matthew Wilcox wrote:
> On Sun, Mar 06, 2022 at 07:02:57PM +0200, Jarkko Sakkinen wrote:
> > So can I conclude from this that in general having populate available for
> > device memory is something horrid, or just the implementation path?
> 
> You haven't even attempted to explain what the problem is you're trying
> to solve.  You've shown up with some terrible code and said "Hey, is
> this a good idea".  No, no, it's not.

The problem is that in order to include memory to enclave, which is
essentially a reserved address range processes virtual address space
there's two steps into it:

1. Host side (kernel) does ENCLS[EAUG] to request a new page to be
   added to the enclave.
2. Enclave accepts request with ENCLU[EACCEPT] or ENCLU[EACCEPTCOPY].

In the current SGX2 patch set this taken care by the page fault
handler. I.e. the enclave calls ENCLU[EACCEPT] for an empty address
and the #PF handler then does EAUG for a single page.

So if you want to process a batch of pages this generates O(n)
round-trips.

So if there was a way pre-do a batch of EAUG's, that would allow
to load data to the enclave without causing page faults happening
constantly.

One solution for this simply add ioctl:

https://lore.kernel.org/linux-sgx/YiLRBglTEbu8cHP9@iki.fi/T/#m195ec84bf85614a140abeee245c5118c22ace8f3

But in practice when you wanted to use it, you would setup the
parameters so that they match the mmap() range. So for pratical
user space API having mmap() take care of this would be much more
lean option.

BR, Jarkko
