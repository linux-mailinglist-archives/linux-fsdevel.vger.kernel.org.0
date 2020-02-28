Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552DC17396A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 15:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgB1OFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 09:05:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgB1OFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l/9vD4kWJ5DgSyvKhFv1tb5oLOTsgXLSNIzvAAdRX2o=; b=mtQ9sSvzCTY3BgpfOC5D6cHQFZ
        Ixh2Tv/4gk5gFcBys/QcmXPiA5puZzBqBTeFRuaSaH9QNSl0CfAglRw6bNLx6AhO7qlQlH957/HD6
        HM0yj+eoyohvvRCiPJYQqJWZABZeaoIgzGoT8oK1uBJSrUjBGRXGgJDcuyyxFISQGu0lsQukeM5/4
        GLt4ahZoIPPu7FbZqDZ12B/QLmJAxu3kS6CLYe1V0/Shv7FP6vb8SJfCGT0WrmWMLoe5Cd1+J4lcY
        UAGcWqH+e1nEcznk5WKgMdVW6DkCturcBrWQ1BrsKa7ai3BQXloxASvhwdD8ZZkDDocxBjmYONzzP
        80DEcfqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7gGK-00048K-IE; Fri, 28 Feb 2020 14:05:08 +0000
Date:   Fri, 28 Feb 2020 06:05:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200228140508.GA2987@infradead.org>
References: <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
 <20200224153844.GB14651@redhat.com>
 <20200227030248.GG10737@dread.disaster.area>
 <CAPcyv4gTSb-xZ2k938HxQeAXATvGg1aSkEGPfrzeQAz9idkgzQ@mail.gmail.com>
 <20200228013054.GO10737@dread.disaster.area>
 <CAPcyv4i2vjUGrwaRsjp1-L0wFf0a00e46F-SUbocQBkiQ3M1kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i2vjUGrwaRsjp1-L0wFf0a00e46F-SUbocQBkiQ3M1kg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:28:41PM -0800, Dan Williams wrote:
> "don't perform generic memory-error-handling, there's an fs that owns
> this daxdev and wants to disposition errors". The fs/dax.c
> infrastructure that sets up ->index and ->mapping would still need to
> be there for ext4 until its ready to take on the same responsibility.
> Last I checked the ext4 reverse mapping implementation was not as
> capable as XFS. This goes back to why the initial design avoided
> relying on not universally available / stable reverse-mapping
> facilities and opted for extending the generic mm/memory-failure.c
> implementation.

The important but is that we stop using ->index and ->mapping when XFS
is used as that enables using DAX+reflinks, which actually is the most
requested DAX feature on XFS (way more than silly runtime flag switches
for example).
