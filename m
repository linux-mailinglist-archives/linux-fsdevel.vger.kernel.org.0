Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD61631EA26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhBRM65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhBRMQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:16:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B85C061574;
        Thu, 18 Feb 2021 04:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v3SwnkJsMELC9SE5dvpsa5IIrh1hU1zdxGUYiPT3UtE=; b=uxK1wBp5wfyYq29eGpAiFLQ+gP
        5JRxD/J+zH90/XyU+b7q1w15LcIyboTDT6+7mHcqRyyIk8jyXq2LsKDFup3GdsnDWd6/X6jS8NfCe
        HFfvbbP9cxriBuGYgnx9DVWt5CJpG7F5xWUe+mcsQX3QzibhOism7/Wrxp0B3rRkUBj9cIyPbEtEL
        YmdrAS+GoYUFCDxXcI1o2Fy64lk8MrzhpO3QrF04KskREEOjTM+23Q712CPV57Hw58KODM5vuZAuK
        sQVyCvsAJqxfyAAk0vTsAWQEJ1c7yFEYLZEZjayikAknoPF58KnVzimABP3i7w9h8piXIXRp8AUpK
        8EnFSj5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCiD1-001e5i-DY; Thu, 18 Feb 2021 12:15:07 +0000
Date:   Thu, 18 Feb 2021 12:15:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210218121503.GQ2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 04:54:46PM +0800, Qu Wenruo wrote:
> Recently we got a strange bug report that, one 32bit systems like armv6
> or non-64bit x86, certain large btrfs can't be mounted.
> 
> It turns out that, since page->index is just unsigned long, and on 32bit
> systemts, that can just be 32bit.
> 
> And when filesystems is utilizing any page offset over 4T, page->index
> get truncated, causing various problems.

4TB?  I think you mean 16TB (4kB * 4GB)

Yes, this is a known limitation.  Some vendors have gone to the trouble
of introducing a new page_index_t.  I'm not convinced this is a problem
worth solving.  There are very few 32-bit systems with this much storage
on a single partition (everything should work fine if you take a 20TB
drive and partition it into two 10TB partitions).

As usual, the best solution is for people to stop buying 32-bit systems.
