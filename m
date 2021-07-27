Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09EF3D7792
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhG0Nzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhG0Nzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECABC061757;
        Tue, 27 Jul 2021 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4bB1NlxVXKcS4LQH7ZeuR6Hp+on28hni4p/W0kSjD4=; b=oNBSHh/gHXG3Z45AYhgsq+WS9p
        eK3d75tBcu835JmU9D3E0+CNOwhAI3icsXwtzMWlgPhe5EZSK9qUO8RUOZwHIM8OyibmnLxmEUG0g
        AKMZWpoOIBkah6xZnXUsKIjhlbIxlvFtQW8Q1VLSLzIbXISvBgkqB7yRYzi3xpuUaG/75QpKxLTKn
        0goXwnJ6MEKbCHFftBPhwIHzWrHIOF8jN5GbNMbk0CtEmWX6S2LaOsUHD1KMs2Vsz4M6MMsvB78Mk
        boKi0VSeKtI2CojJPZ6Lgb3wUv2A2I4Zp+xbWQDPzLX+RxY6wrYecuPuqzfr+ON/qXkKWhwXScxqB
        nH07UwCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8NWR-00F4Fh-RU; Tue, 27 Jul 2021 13:53:50 +0000
Date:   Tue, 27 Jul 2021 14:53:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] fs: make d_path-like functions all have unsigned size
Message-ID: <YQAP1/N5hudsmbu6@casper.infradead.org>
References: <20210727120754.1091861-1-gregkh@linuxfoundation.org>
 <YP/+g/L6+tLWjx/l@smile.fi.intel.com>
 <YQAClXqyLhztLcm4@kroah.com>
 <YQAGvTZPex3mxrD/@casper.infradead.org>
 <YQAKj4LFifmlVi0q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAKj4LFifmlVi0q@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 03:30:55PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 27, 2021 at 02:14:37PM +0100, Matthew Wilcox wrote:
> > On Tue, Jul 27, 2021 at 02:56:53PM +0200, Greg Kroah-Hartman wrote:
> > > And my mistake from earlier, size_t is the same as unsigned int, not
> > > unsigned long.
> > 
> > No.
> > 
> > include/linux/types.h:typedef __kernel_size_t           size_t;
> > 
> > include/uapi/asm-generic/posix_types.h:
> > 
> > #ifndef __kernel_size_t
> > #if __BITS_PER_LONG != 64
> > typedef unsigned int    __kernel_size_t;
> > #else
> > typedef __kernel_ulong_t __kernel_size_t;
> > #endif
> > #endif
> > 
> > size_t is an unsigned long on 64-bit, unless otherwise defined by the
> > arch.
> 
> ugh, ok, so there really is a problem, as we have a size_t value being
> passed in as an int, and then it could be treated as a negative value
> for some fun pointer math to copy buffers around.
> 
> How is this not causing problems now already?  Are we just getting
> lucky?

include/uapi/linux/limits.h:#define PATH_MAX        4096        /* # chars in a path name including nul */

Clearly some places aren't checking that, but _in principle_, you
aren't supposed to be able to create a pathname longer than that.
