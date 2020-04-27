Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8F1BB192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 00:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD0Wkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 18:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgD0Wkw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:40:52 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8742075E;
        Mon, 27 Apr 2020 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588027251;
        bh=CC6rMEFyGSKGcmYNdgrkgIArdM9m2XSVKnBpMMN2Afc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M1Bzf7imQ9+pFeCE+KA+cbdSB5d1Q5QGQB9MnKaltdtd5VWtUvFW7fQAnmE0URwl5
         3BA6ohXMoMglNl9UZcTo0fBye8BSMjujqHnJjVYOuU0KjCzBVzKwaD+JYsXxpLWgrr
         AEvVdCbCW82EWkeE0LLaMEaXsLBh2Bd66+0Ooopg=
Date:   Mon, 27 Apr 2020 15:40:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/7] signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-Id: <20200427154050.e431ad7fb228610cc6b95973@linux-foundation.org>
In-Reply-To: <20200426074039.GA31501@lst.de>
References: <20200421154204.252921-1-hch@lst.de>
        <20200421154204.252921-3-hch@lst.de>
        <20200425214724.a9a00c76edceff7296df7874@linux-foundation.org>
        <20200426074039.GA31501@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 26 Apr 2020 09:40:39 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Sat, Apr 25, 2020 at 09:47:24PM -0700, Andrew Morton wrote:
> > I looked at fixing it but surely this sort of thing:
> > 
> > 
> > int copy_siginfo_to_user32(struct compat_siginfo __user *to,
> > 			   const struct kernel_siginfo *from)
> > #if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
> > {
> > 	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
> > }
> > int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
> > 			     const struct kernel_siginfo *from, bool x32_ABI)
> > #endif
> > {
> > 	...
> > 
> > 
> > is too ugly to live?
> 
> I fixed it up in my earlier versions, but Eric insisted to keep it,
> which is why I switched to his version given that he is the defacto
> signal.c maintainer.
> 
> Here is what I would have preferred:
> 
> https://www.spinics.net/lists/kernel/msg3473847.html
> https://www.spinics.net/lists/kernel/msg3473840.html
> https://www.spinics.net/lists/kernel/msg3473843.html

OK, but that doesn't necessitate the above monstrosity?  How about

static int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
			     const struct kernel_siginfo *from, bool x32_ABI)
{
	struct compat_siginfo new;
	copy_siginfo_to_external32(&new, from);
	...
}

int copy_siginfo_to_user32(struct compat_siginfo __user *to,
			   const struct kernel_siginfo *from)
{
#if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
#else
	return __copy_siginfo_to_user32(to, from, 0);
#endif
}

Or something like that - I didn't try very hard.  We know how to do
this stuff, and surely this thing isn't how!
