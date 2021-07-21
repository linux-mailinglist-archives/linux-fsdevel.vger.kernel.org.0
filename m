Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FB3D17A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 22:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhGUTci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 15:32:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39506 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhGUTch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:32:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 565512258A;
        Wed, 21 Jul 2021 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626898392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnugCTEBu/3zdvXcY55icg8lMm81MI8TLb/CodM5bQ4=;
        b=Q3dgsvHCULcJ/SqVmQxhIrkMuUCDzdLhFmrnDGcZNqkr1xgEy4QK7yHLVfABgJtYUUer54
        jz62fd45a7ax5Z7G87TQRg350dZfoMia9EFD5kHKVfBu/aJWy21zRZaCiyVGX21E84WorC
        ph13hTPc6uWv72rfmRD2i0p/A5PundI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626898392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnugCTEBu/3zdvXcY55icg8lMm81MI8TLb/CodM5bQ4=;
        b=i77W9cAZ6xZdrQcCdPf5TLuSIGRu7hT3cO+1QLjU8gPMujSJyBm94BUhf3i5V0qKexTICD
        N/XC57je7LvTQHAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 46C59A3B85;
        Wed, 21 Jul 2021 20:13:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA8AEDA701; Wed, 21 Jul 2021 22:10:29 +0200 (CEST)
Date:   Wed, 21 Jul 2021 22:10:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
Message-ID: <20210721201029.GQ19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:00:59AM -0700, Linus Torvalds wrote:
> On Wed, Jul 21, 2021 at 6:59 AM Nikolay Borisov <nborisov@suse.com> wrote:
> >
> > This is glibc's memcmp version. The upside is that for architectures
> > which don't have an optimized version the kernel can provide some
> > solace in the form of a generic, word-sized optimized memcmp. I tested
> > this with a heavy IOCTL_FIDEDUPERANGE(2) workload and here are the
> > results I got:
> 
> Hmm. I suspect the usual kernel use of memcmp() is _very_ skewed to
> very small memcmp calls, and I don't think I've ever seen that
> (horribly bad) byte-wise default memcmp in most profiles.
> 
> I suspect that FIDEDUPERANGE thing is most likely a very special case.
> 
> So I don't think you're wrong to look at this, but I think you've gone
> from our old "spend no effort at all" to "look at one special case".

The memcmp in question is fs/remap_range.c:vfs_dedupe_file_range_compare

   253                  src_addr = kmap_atomic(src_page);
   254                  dest_addr = kmap_atomic(dest_page);
   ...
   259                  if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
   260                          same = false;
   261  
   262                  kunmap_atomic(dest_addr);
   263                  kunmap_atomic(src_addr);

so adding a memcmp_large that compares by native words or u64 could be
the best option. There's some alignment of the starting offset and
length but that can be special cased and fall back to standard memcmp.
The dedupe ioctl is typically called on ranges spanning many pages so
the overhead of the non-paged portions should be insignificant.
