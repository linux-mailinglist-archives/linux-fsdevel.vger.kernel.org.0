Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA363CAF28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhGOWgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:36:52 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:34958 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhGOWgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:36:51 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 2124947A2;
        Fri, 16 Jul 2021 08:33:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m49vU-006zDa-HD; Fri, 16 Jul 2021 08:33:52 +1000
Date:   Fri, 16 Jul 2021 08:33:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, djwong@kernel.org
Subject: Re: [PATCH] vfs: Optimize dedupe comparison
Message-ID: <20210715223352.GB219491@dread.disaster.area>
References: <20210715141309.38443-1-nborisov@suse.com>
 <YPBGoDlf9T6kFjk1@casper.infradead.org>
 <7c4c9e73-0a8b-5621-0b74-1bf34e4b4817@suse.com>
 <YPBPkupPDnsCXrLU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPBPkupPDnsCXrLU@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=kj9zAlcOel0A:10 a=e_q4qTt1xDgA:10 a=7-415B0cAAAA:8
        a=Uyr77oSfMRdB5wXE46cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:09:06PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 15, 2021 at 05:44:15PM +0300, Nikolay Borisov wrote:
> > I was wondering the same thing, but AFAICS it seems to be possible i.e
> > if userspace spaces bad offsets, while all kinds of internal fs
> > synchronization ops are going to be performed on aligned offsets, that
> > doesn't mean the original ones, passed from userspace are themselves
> > aligned explicitly.
> 
> Ah, I thought it'd be failed before we got to this point.
> 
> But honestly, I think x86-64 needs to be fixed to either use
> __builtin_memcmp() or to have a nicely written custom memcmp().  I
> tried to find the gcc implementation of __builtin_memcmp() on
> x86-64, but I can't.

Yup, this. memcmp() is widley used in hot paths through all the
filesystem code and the rest of the kernel. We should fix the
generic infrastructure problem, not play whack-a-mole to with custom
one-off fixes that avoid the problem just where it shows up in some
profile...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
