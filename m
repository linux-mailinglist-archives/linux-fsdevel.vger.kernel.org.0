Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4032CE167
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 23:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgLCWMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 17:12:48 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45451 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLCWMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:12:48 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EED963C2233;
        Fri,  4 Dec 2020 09:12:03 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kkwpW-000Cb3-Ub; Fri, 04 Dec 2020 09:12:02 +1100
Date:   Fri, 4 Dec 2020 09:12:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, jlayton@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: Problems doing DIO to netfs cache on XFS from Ceph
Message-ID: <20201203221202.GA4170059@dread.disaster.area>
References: <914680.1607004656@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <914680.1607004656@warthog.procyon.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
        a=7-415B0cAAAA:8 a=rZepROtmVEJqsJtNp94A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:10:56PM +0000, David Howells wrote:
> Hi Christoph,
> 
> We're having a problem making the fscache/cachefiles rewrite work with XFS, if
> you could have a look?  Jeff Layton just tripped the attached warning from
> this:
> 
> 	/*
> 	 * Given that we do not allow direct reclaim to call us, we should
> 	 * never be called in a recursive filesystem reclaim context.
> 	 */
> 	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> 		goto redirty;

I've pointed out in other threads where issues like this have been
raised that this check is not correct and was broken some time ago
by the PF_FSTRANS removal. The "NOFS" case here was originally using
PF_FSTRANS to protect against recursion from within transaction
contexts, not recursion through memory reclaim.  Doing writeback
from memory reclaim is caught by the preceeding PF_MEMALLOC check,
not this one.

What it is supposed to be warning about is that writeback in XFS can
start new transactions and nesting transactions is a guaranteed way
to deadlock the journal. IOWs, doing writeback from an active
transaction context is a bug in XFS.

IOWs, we are waiting on a new version of this patchset to be posted:

https://lore.kernel.org/linux-xfs/20201103131754.94949-1-laoar.shao@gmail.com/

so that we can get rid of this from iomap and check the transaction
recursion case directly in the XFS code. Then your problem goes away
completely....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
