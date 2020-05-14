Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB3D1D3223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgENOHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgENOHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 10:07:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F12C061A0C;
        Thu, 14 May 2020 07:07:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZEW8-008HXc-IU; Thu, 14 May 2020 14:07:20 +0000
Date:   Thu, 14 May 2020 15:07:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/20] amifb: get rid of pointless access_ok() calls
Message-ID: <20200514140720.GB23230@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <CGME20200509234610eucas1p258be307cde10392b26c322354db78a9b@eucas1p2.samsung.com>
 <20200509234557.1124086-11-viro@ZenIV.linux.org.uk>
 <6f89732b-fba9-a947-6c61-5d1680747f3b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f89732b-fba9-a947-6c61-5d1680747f3b@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 03:45:09PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Al,
> 
> On 5/10/20 1:45 AM, Al Viro wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > addresses passed only to get_user() and put_user()
> 
> This driver lacks checks for {get,put}_user() return values so it will
> now return 0 ("success") even if {get,put}_user() fails.
> 
> Am I missing something?

"now" is interesting, considering
/* We let the MMU do all checking */
static inline int access_ok(const void __user *addr,
                            unsigned long size)
{
        return 1;
}
in arch/m68k/include/asm/uaccess_mm.h

Again, access_ok() is *NOT* about checking if memory is readable/writable/there
in the first place.  All it does is a static check that address is in
"userland" range - on architectures that have kernel and userland sharing the
address space.  On architectures where we have separate ASI or equivalents
thereof for kernel and for userland the fscker is always true.

If MMU will prevent access to kernel memory by uaccess insns for given address
range, access_ok() is fine with it.  It does not do anything else.

And yes, get_user()/put_user() callers should handle the fact that those can
fail.  Which they bloody well can _after_ _success_ of access_ok().  And
without any races whatsoever.

IOW, the lack of such checks is a bug, but it's quite independent from the
bogus access_ok() call.  On any architecture.  mmap() something, munmap()
it and pass the address where it used to be to that ioctl().  Failing
get_user()/put_user() is guaranteed, so's succeeding access_ok().

And that code is built only on amiga, so access_ok() always succeeds, anyway.
