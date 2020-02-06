Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3943E153F53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 08:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBFHlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 02:41:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBFHlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v4sgkrFRRT25twWgnublfu8qExfh0axFqZunM0WK1gU=; b=VgB0OvYzeVchVCoUP2+LkP98Af
        3gMHK/5aS3eJ9KoukvYbk0b+nJBmaQL0QEgbGs+sO1cvP4oI5Ri9bKwsrJ6vf+hBo3LPHbxWxAvu2
        gRH39qOT2jLoKfq07rUO1RbeqRLzlAtRH1fV0dNtb7yohuHMpjKTSHehAF4a0oATh8lBJBRzYPKPW
        qeFSYYoXUha5yEWdNry31aDBGq2gXAf/nsjqK4HIRB3kY8KGGdHNaMK4+yKInYQhJlUzmxJ9w2eTJ
        Olrj/7qfs0xImdjcLa68RWZrnWg2DXT60LDktCtjG8ENas/72pvNyvWuzG3B33T7nHx+E48YuJmry
        jZTSCkPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izbnC-0001q3-Tg; Thu, 06 Feb 2020 07:41:42 +0000
Date:   Wed, 5 Feb 2020 23:41:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200206074142.GB28365@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org>
 <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > will make changes.
> 
> The problem is device-mapper. That wants to use offset to route
> through the map to the leaf device. If it weren't for the firmware
> communication requirement you could do:
> 
> dax_direct_access(...)
> generic_dax_zero_page_range(...)
> 
> ...but as long as the firmware error clearing path is required I think
> we need to do pass the pgoff through the interface and do the pgoff to
> virt / phys translation inside the ops handler.

Maybe phys_addr_t was the wrong type - but why do we split the offset
into the block device argument into a pgoff and offset into page instead
of a single 64-bit value?
