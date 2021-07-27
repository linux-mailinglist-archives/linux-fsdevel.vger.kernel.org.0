Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146703D76C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhG0Nbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 09:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236827AbhG0Na4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:30:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FC7A61A61;
        Tue, 27 Jul 2021 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627392656;
        bh=dxaQw/xuCLmsummPPWWr8Km+zLNtYNzzPr/WRkXIVZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrSiPVui0U7qmCjWn16WdPqKgZLBXxN+0fBYVMRjOHehjStMtMizAAWZ37Wp1tyh4
         VwkKya08Oba026Ye5a9DMROlDBqefrQxJUdPB5auBiY3JFLuaoO9DtA5iEdyFxkfdS
         0pMBnqbZLK9+jRzN6VOcyYYhnZ+g/ledwovn7TGc=
Date:   Tue, 27 Jul 2021 15:30:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] fs: make d_path-like functions all have unsigned size
Message-ID: <YQAKj4LFifmlVi0q@kroah.com>
References: <20210727120754.1091861-1-gregkh@linuxfoundation.org>
 <YP/+g/L6+tLWjx/l@smile.fi.intel.com>
 <YQAClXqyLhztLcm4@kroah.com>
 <YQAGvTZPex3mxrD/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAGvTZPex3mxrD/@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:14:37PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 27, 2021 at 02:56:53PM +0200, Greg Kroah-Hartman wrote:
> > And my mistake from earlier, size_t is the same as unsigned int, not
> > unsigned long.
> 
> No.
> 
> include/linux/types.h:typedef __kernel_size_t           size_t;
> 
> include/uapi/asm-generic/posix_types.h:
> 
> #ifndef __kernel_size_t
> #if __BITS_PER_LONG != 64
> typedef unsigned int    __kernel_size_t;
> #else
> typedef __kernel_ulong_t __kernel_size_t;
> #endif
> #endif
> 
> size_t is an unsigned long on 64-bit, unless otherwise defined by the
> arch.

ugh, ok, so there really is a problem, as we have a size_t value being
passed in as an int, and then it could be treated as a negative value
for some fun pointer math to copy buffers around.

How is this not causing problems now already?  Are we just getting
lucky?

thanks,

greg k-h
