Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8915441231
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 03:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKAChb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 22:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhKACh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CEAC061714;
        Sun, 31 Oct 2021 19:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVq1DQ33vlTfqQwlUVtldRtum7VTJ4Qf1wo2xOWYsbs=; b=gRMXvXUxYDh5PXfGY5PmoKkYNO
        XFLFQoynUl1o2KWv51EHkiPEdljCH01lPjc7+M/bKuM+7+9IMZ5jSaJ1MGCpifQEIS4Qcd4dJc1Wa
        8dO9Kqrf/Di+5EBltPtFcL+YtbwV3OLvk6Xd+aK2ECFw7/Gdg6aHCwAbztH3lXoJa/BeCs6oUo293
        PDjr1JQ8F7sTCQXgKQMS9nw7lOnA4+04vMjmHw0d21F6Bmw25BeerzvqDabqxyqC/dw8tJs3qOPJ5
        esyiwcXYwn4sfB97InYFLCCmiTcpnwhbut8Sq53K97IVVQd9qJb66Xm71VeQJPsOdp6iE9VKRW5XR
        oQBeZ3uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhN6c-003SWk-T1; Mon, 01 Nov 2021 02:31:47 +0000
Date:   Mon, 1 Nov 2021 02:31:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <YX9RftrcBNwgyCXc@casper.infradead.org>
References: <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
 <20211028225955.GA449541@dread.disaster.area>
 <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
 <20211029223233.GB449541@dread.disaster.area>
 <1a76314d-9b62-82a3-2787-96e6b83720fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a76314d-9b62-82a3-2787-96e6b83720fc@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 31, 2021 at 01:19:48PM +0000, Pavel Begunkov wrote:
> On 10/29/21 23:32, Dave Chinner wrote:
> > Yup, you just described RWF_HIPRI! Seriously, Pavel, did you read
> > past this?  I'll quote what I said again, because I've already
> > addressed this argument to point out how silly it is:
> 
> And you almost got to the initial point in your penult paragraph. A
> single if for a single flag is not an issue, what is the problem is
> when there are dozens of them and the overhead for it is not isolated,
> so the kernel has to jump through dozens of those.

This argument can be used to reject *ANY* new feature.  For example, by
using your argument, we should have rejected the addition of IOCB_WAITQ
because it penalises the vast majority of IOs which do not use it.

But we didn't.  Because we see that while it may not be of use to US
today, it's a generally useful feature for Linux to support.  You say
yourself that this feature doesn't slow down your use case, so why are
you spending so much time and energy annoying the people who actually
want to use it?

Seriously.  Stop arguing about something you actually don't care about.
You're just making Linux less fun to work on.
