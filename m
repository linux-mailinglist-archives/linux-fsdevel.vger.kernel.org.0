Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63943964D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhJYM3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhJYM3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35CFC061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g8CiSFTvsHWubeN5NteUNrldvXscttE+QlbugViYzU0=; b=f38Wxza+vt9E831L28kPH7GfTl
        rtQfVmrMJmHPc2OBuUaQtlnhlhx+fQ0f4ylTXePmHJyWk8ojw8B2Dkz6L4mk45xmeY2TDUgeUUWGJ
        MgkVLsVgB//AWjI9NBOCi7eiUh9SxnUIHLidEVkCgYLhgoI42yOt++6c02ZWYJiy96U3mdINk6qax
        ndBctwWBPUNAPo9t511XisxOd8WYxi/ARB8k/ppmUfNdwRZ4fPOiV3+ifeWbPFHbwSdPvTbhcmxf6
        UvsF2E2nvAvM+IzV4NOWchVNR8NNzCxCHz8Bw4rVZdJPC2HfvgesY8Djy2Kk24AMgc2izNkPq2jbE
        uY4LnFyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mez2q-00G7HE-5c; Mon, 25 Oct 2021 12:25:55 +0000
Date:   Mon, 25 Oct 2021 13:25:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Azat.Nurgaliev@dlr.de
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Turn off readahead completely
Message-ID: <YXaiRCbm9pcG9pur@casper.infradead.org>
References: <8aa213d5d5464236b7e47aaa6bb93bb8@dlr.de>
 <YXFq0QYhDBQC5G0l@casper.infradead.org>
 <066d9015e3c44c3a84eca5886d80bf04@dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066d9015e3c44c3a84eca5886d80bf04@dlr.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:55:03AM +0000, Azat.Nurgaliev@dlr.de wrote:
> Thank you for the reply, Matthew.
> 
> I'm experimenting with GDAL and, in particular, working on improving the I/O performance of geo-applications.
> I wanted to get more control from the application over how the kernel handles I/O requests.
> But basically all the optimizations are hidden in readahead. Whatever requests are executed are all translated into readahead.
> 
> It would be very useful to be able to evaluate the difference with more fine-grained control on the application side.

Ah!  Then what you've done will be fine for your purpose.

What's going on here is that the kernel tries to read() from part of
the file that isn't cached.  So it allocates a page of memory and then
does a page-sized readahead to that one page.  It then waits for the
readahead to complete.  If it fails (eg EIO), it'll try to read the
page using the filesystem's ->readpage operation.

While you see a readahead operation, it's not *really* a readahead
operation.  It's doing the exact same read that you'd see if there
were no readahead operation.

> -----Original Message-----
> From: Matthew Wilcox <willy@infradead.org> 
> Sent: Donnerstag, 21. Oktober 2021 15:28
> To: Nurgaliev, Azat <Azat.Nurgaliev@dlr.de>
> Cc: linux-fsdevel@vger.kernel.org
> Subject: Re: Turn off readahead completely
> 
> On Thu, Oct 21, 2021 at 01:16:46PM +0000, Azat.Nurgaliev@dlr.de wrote:
> > Hello everyone,
> > 
> > I need to turn readahead off completely in order to do my experiments. 
> > Is there any way to turn it off completely?
> > 
> > Setting /sys/block/<dev>/queue/read_ahead_kb to 0 causes readahead to become 4kb.
> 
> That's entirely intentional.  What experiment are you actually trying to perform?
