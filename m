Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2722B1D3885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENRll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgENRll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 13:41:41 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB4C061A0C;
        Thu, 14 May 2020 10:41:41 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZHrP-008NZt-Fd; Thu, 14 May 2020 17:41:31 +0000
Date:   Thu, 14 May 2020 18:41:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/20] amifb: get rid of pointless access_ok() calls
Message-ID: <20200514174131.GD23230@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <CGME20200509234610eucas1p258be307cde10392b26c322354db78a9b@eucas1p2.samsung.com>
 <20200509234557.1124086-11-viro@ZenIV.linux.org.uk>
 <6f89732b-fba9-a947-6c61-5d1680747f3b@samsung.com>
 <20200514140720.GB23230@ZenIV.linux.org.uk>
 <f6fcfa46-6271-45ea-37c2-62bcf0a607cb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fcfa46-6271-45ea-37c2-62bcf0a607cb@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 04:25:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Thank you for in-detail explanations, for this patch:
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Could you also please take care of adding missing checks for {get,put}_user()
> failures later?

Umm...  OK; put_user() side is trivial -  the interesting part is what to do
about get_user() failures halfway through.  Right now it treats them as
"we'd read zeroes".  On anything else I would say "screw it, memdup_user()
the damn thing on the way in and copy from there", but... Amiga has how
much RAM, again?

OTOH, from my reading of that code it does appear to be limited to
4Kb of data to copy, so it's probably OK...  Hell knows - I'm really
confused by those #ifdef __mc68000__ in there; the driver *is*
amiga-only:
obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p_planar.o
config FB_AMIGA
        tristate "Amiga native chipset support"
        depends on FB && AMIGA
and AMIGA is defined only in arch/m68k/Kconfig.machine.  So how the
hell can it *not* be true?  OTOH, it looks like hand-optimized
asm equivalents of C they have in #else, so that #else might be
meant to document what's going on...

I've no idea how to test any changes to that thing - the only
m68k emulator I'm reasonably familiar with is aranym, and
that's Atari, not Amiga.  Never got around to setting up UAE...
So I can do a patch more or less blindly (memdup_user() after
it has checked the limits on height/width, then dereferencing
from copy instead of get_user()), but I won't be able to test
it.
