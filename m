Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9973CFE66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbhGTPRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbhGTOeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:34:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CA8C0613F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=crxOsS/ZsTpvwkWTHW6E0Yf3BMU9zXIsPqzdw7CxMUM=; b=B/dwjVesZfA/Dfpa/Rpe6XlvEY
        NjcfOPmzB3UvTYhf1iyX6e0xr2FSQ+YSBsCGGrXCEuGaU9PBwaCGzOPMANExTKuyP1+u9ZKkcf3WU
        qWFivD+lj/h29IcLWDgMwxdSUtQ7A7EJHdRK3wi2RWkoY6GUwThQGrcbzBoyVU4ew0sbMFltDyAuI
        emhn0gtkEextANCVeTqmHw0kFWqGgbhsMj/HYGf9T3/IDNVBPffNrkTciMeMRDgFIU4TDMRLOSkxd
        Jqy0pzpwtZVMDDptancqJh77SrYIc7X50pu2kQP5webQS92MSoVwvR8e9ihlDzmTtM2o3K6sVnc8m
        OyIujF/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5rPd-008F2w-Eb; Tue, 20 Jul 2021 15:12:09 +0000
Date:   Tue, 20 Jul 2021 16:12:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, djwong@kernel.org
Subject: Re: [PATCH] vfs: Optimize dedupe comparison
Message-ID: <YPbnwbXUw1dVbQIF@casper.infradead.org>
References: <20210715141309.38443-1-nborisov@suse.com>
 <YPBGoDlf9T6kFjk1@casper.infradead.org>
 <7c4c9e73-0a8b-5621-0b74-1bf34e4b4817@suse.com>
 <YPBPkupPDnsCXrLU@casper.infradead.org>
 <20210715223352.GB219491@dread.disaster.area>
 <dba60154-874e-b6b9-21c4-5c2d9735029a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dba60154-874e-b6b9-21c4-5c2d9735029a@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 05:58:39PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.07.21 г. 1:33, Dave Chinner wrote:
> > On Thu, Jul 15, 2021 at 04:09:06PM +0100, Matthew Wilcox wrote:
> >> On Thu, Jul 15, 2021 at 05:44:15PM +0300, Nikolay Borisov wrote:
> >>> I was wondering the same thing, but AFAICS it seems to be possible i.e
> >>> if userspace spaces bad offsets, while all kinds of internal fs
> >>> synchronization ops are going to be performed on aligned offsets, that
> >>> doesn't mean the original ones, passed from userspace are themselves
> >>> aligned explicitly.
> >>
> >> Ah, I thought it'd be failed before we got to this point.
> >>
> >> But honestly, I think x86-64 needs to be fixed to either use
> >> __builtin_memcmp() or to have a nicely written custom memcmp().  I
> >> tried to find the gcc implementation of __builtin_memcmp() on
> >> x86-64, but I can't.
> > 
> > Yup, this. memcmp() is widley used in hot paths through all the
> > filesystem code and the rest of the kernel. We should fix the
> > generic infrastructure problem, not play whack-a-mole to with custom
> > one-off fixes that avoid the problem just where it shows up in some
> > profile...
> 
> I ported glibc's implementation of memcmp to the kernel and after
> running the same workload I get the same performance as with the basic
> memcmp implementation of doing byte comparison ...

That's bizarre because the glibc memcmp that you pointed to earlier
basically does what your open-coded solution did.  Is it possible
you have a bug in one of the tests and it's falling back to the byte
loop?

Specifically for the dedup case, we only need the optimisation that

	if ((p1 | p2 | length) & 7)
		... do the byte loop ...
	... do the long-based comparison ...

so another possibility is that memcmp is doing too many tests.
