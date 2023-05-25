Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCE711A73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 01:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjEYXFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 19:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYXFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 19:05:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53223E2;
        Thu, 25 May 2023 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1wIWSmx8tL1zwRosKN785Bsjw/NXry+bXUPs1s1BkGA=; b=nYujE/Ekj6U8L08bVcRYWqNpVi
        gjNO473kYesKbi1pg4x7EzWo9m2GVJnkq0OKJBo8LAe6OvS5M2BgJEZRZu8Xl3HzPcwKet+nEgyoS
        rxXJxPJVrgjuoXta18NBLgspC+r1WrkTjeqpeqkh9nz5ws02AhB5trWOTKBqHJKyDuo3UzcuCob3h
        DHUVEwmrG7yeX7J00INUlganD9IUMQgcblHaTzkX9+1Tip1NCfXR9ZkxO5CMNtSbn9wY3gh7UyAk/
        /3D0s6NQU32BfbUKM0qkGhhD17VwGf0OJruB6cRTmWPTIhWPoEcpRVMUeps4bWMJVOK8S+GlWb9E1
        c5KM9IbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2K0m-000Mm9-0S;
        Thu, 25 May 2023 23:04:48 +0000
Date:   Thu, 25 May 2023 16:04:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, bp@alien8.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] signal: move show_unhandled_signals sysctl to its
 own file
Message-ID: <ZG/pkEdt9ArO4NGg@bombadil.infradead.org>
References: <20230522210814.1919325-1-mcgrof@kernel.org>
 <20230522210814.1919325-3-mcgrof@kernel.org>
 <d0fe7a6f-8cd9-0b81-758a-f3b444e74bab@intel.com>
 <ZG29HWE9NWn56hTg@bombadil.infradead.org>
 <603f5357-3018-6c1b-2dc8-ec96aee9552c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603f5357-3018-6c1b-2dc8-ec96aee9552c@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 11:52:58AM -0700, Dave Hansen wrote:
> On 5/24/23 00:30, Luis Chamberlain wrote:
> >> It doesn't actually have anything to do with moving the
> >> show_unhandled_signals sysctl, right?
> > Well in my case it is making sure the sysctl variable used is declared
> > as well.
> 
> But what does this have to do with _this_ patch?  This:

Because to create consistency for the users.

> > --- a/arch/x86/kernel/umip.c
> > +++ b/arch/x86/kernel/umip.c
> > @@ -12,6 +12,7 @@
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/signal.h>
> 
> For instance.  You don't move things to another header or make *ANY*
> change to the compilation of umip.c.  So why patch it?
> 
> It looks to me like a _fundamentally_ superfluous change.  That hunk
> literally *can't* be related to the rest of the patch.

I suspect it is not needed as otherwise compilation would have failed.
So I'll just drop it.

> >> If that's the case, it would be nice to have this in its own patch.
> > If its not really fixing any build bugs or functional bugs I don't see
> > the need. But if you really want it, I can do it.
> > 
> > Let me know!
> 
> Yes, I really want it.
> 
> Please remove all the x86 bits from _this_ patch.  If x86 has a
> separate, preexisting problem, please send that patch separately with a
> separate changelog and justification.
> 
> We'll take a look.

Sounds good.

  Luis
