Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2343943D818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 02:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhJ1A1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 20:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhJ1A1R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:27:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF4FB60F9B;
        Thu, 28 Oct 2021 00:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635380691;
        bh=FiS4PSp9dq5XSaCsWhfnvL9XlrVWGShYyfrLJTdu9vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLiu9hL0Nnfj0wrmhGnnxL5+8GTJJbXO4vG40Y4IEyaBbUa88fsVA0M+rE2wPP55K
         VLA6cRwCiUhxECHQOahortB3Yo2VP+oFbMEG0uElQs81v4jqhfp8kRYJAeUnnA16zJ
         b+HS7hPoUelooieVdCl2Nx6xZkxw/UW2E15yHmAfP3nhWY0ybavp+pTPnAHxX+G4UW
         F0ZV+G9Tqf5vDpTUtdu8DAFnC69xwsGEyN/qag6omHGpOOd3XLSLw822wOCWuz45t8
         xD8mrOpLmMT4K4s0abdIP5Oo4QMzSeb0EDc/7elPxTr+C57KbXjFo3PtV8fNtBQS9d
         bD3r72wnTUFYA==
Date:   Wed, 27 Oct 2021 17:24:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <20211028002451.GB2237511@magnolia>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXj2lwrxRxHdr4hb@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:49:59PM -0700, Christoph Hellwig wrote:
> On Fri, Oct 22, 2021 at 08:52:55PM +0000, Jane Chu wrote:
> > Thanks - I try to be honest.  As far as I can tell, the argument
> > about the flag is a philosophical argument between two views.
> > One view assumes design based on perfect hardware, and media error
> > belongs to the category of brokenness. Another view sees media
> > error as a build-in hardware component and make design to include
> > dealing with such errors.
> 
> No, I don't think so.  Bit errors do happen in all media, which is
> why devices are built to handle them.  It is just the Intel-style
> pmem interface to handle them which is completely broken.  

Yeah, I agree, this takes me back to learning how to use DISKEDIT to
work around a hole punched in a file (with a pen!) in the 1980s...

...so would you happen to know if anyone's working on solving this
problem for us by putting the memory controller in charge of dealing
with media errors?

> > errors in mind from start.  I guess I'm trying to articulate why
> > it is acceptable to include the RWF_DATA_RECOVERY flag to the
> > existing RWF_ flags. - this way, pwritev2 remain fast on fast path,
> > and its slow path (w/ error clearing) is faster than other alternative.
> > Other alternative being 1 system call to clear the poison, and
> > another system call to run the fast pwrite for recovery, what
> > happens if something happened in between?
> 
> Well, my point is doing recovery from bit errors is by definition not
> the fast path.  Which is why I'd rather keep it away from the pmem
> read/write fast path, which also happens to be the (much more important)
> non-pmem read/write path.

The trouble is, we really /do/ want to be able to (re)write the failed
area, and we probably want to try to read whatever we can.  Those are
reads and writes, not {pre,f}allocation activities.  This is where Dave
and I arrived at a month ago.

Unless you'd be ok with a second IO path for recovery where we're
allowed to be slow?  That would probably have the same user interface
flag, just a different path into the pmem driver.

Ha, how about a int fd2 = recoveryfd(fd); call where you'd get whatever
speshul options (retry raid mirrors!  scrape the film off the disk if
you have to!) you want that can take forever, leaving the fast paths
alone?

(Ok, that wasn't entirely serious...)

--D
