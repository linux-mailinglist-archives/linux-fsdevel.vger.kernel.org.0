Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9661BB73D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 09:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD1HJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 03:09:38 -0400
Received: from verein.lst.de ([213.95.11.211]:54471 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgD1HJh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:09:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C417368CEC; Tue, 28 Apr 2020 09:09:35 +0200 (CEST)
Date:   Tue, 28 Apr 2020 09:09:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/7] signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200428070935.GE18754@lst.de>
References: <20200421154204.252921-1-hch@lst.de> <20200421154204.252921-3-hch@lst.de> <20200425214724.a9a00c76edceff7296df7874@linux-foundation.org> <20200426074039.GA31501@lst.de> <20200427154050.e431ad7fb228610cc6b95973@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427154050.e431ad7fb228610cc6b95973@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 03:40:50PM -0700, Andrew Morton wrote:
> > https://www.spinics.net/lists/kernel/msg3473847.html
> > https://www.spinics.net/lists/kernel/msg3473840.html
> > https://www.spinics.net/lists/kernel/msg3473843.html
> 
> OK, but that doesn't necessitate the above monstrosity?  How about
> 
> static int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
> 			     const struct kernel_siginfo *from, bool x32_ABI)
> {
> 	struct compat_siginfo new;
> 	copy_siginfo_to_external32(&new, from);
> 	...
> }
> 
> int copy_siginfo_to_user32(struct compat_siginfo __user *to,
> 			   const struct kernel_siginfo *from)
> {
> #if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
> 	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
> #else
> 	return __copy_siginfo_to_user32(to, from, 0);
> #endif
> }
> 
> Or something like that - I didn't try very hard.  We know how to do
> this stuff, and surely this thing isn't how!

I guess that might be a worthwhile middle ground.  Still not a fan of
all these ifdefs..
