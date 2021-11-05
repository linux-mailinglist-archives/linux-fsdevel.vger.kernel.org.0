Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE3445F8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 06:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhKEF77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhKEF75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 01:59:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A9DC061714;
        Thu,  4 Nov 2021 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q5/17tD8LaKtjZDpNegEPg9bSu3BcN6DQsTcfo5uoWw=; b=00wPjkQcL0jxfRnklje0+0t/6b
        ptvBwjh/Sjak6dBkwFgMDJgx9cYXPvLUJcE5AcKnCabpvl+ThnhDDj8JHlX+OlB5oeF3TAX/nKxTA
        mjU4yXRvLWe2vrKCtYIEmZ+ALv6DiDKeVPQHz81ak5EMbrahhuc30FFhI0Dr134dQz1dUFOwq0X9b
        bJaQ3xbd4DI0cZ0Ilo2VQvCxbHUUjydlnXVmGmAl1ckchy85rzdLenU1j/a0jJhxjF5UlDHrYWqGP
        UNw8+wtYTZkeZfnPGRz+GDRDBs4CWjib8gx5TBLrb2aQKCt73LAXP6H3Ear8zsDDV8gQ7GDm9vQ97
        Lvg1wLUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1misDY-00AfD8-3j; Fri, 05 Nov 2021 05:56:48 +0000
Date:   Thu, 4 Nov 2021 22:56:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
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
Message-ID: <YYTHoP5vAdel2Djt@infradead.org>
References: <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org>
 <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
 <YYK/tGfpG0CnVIO4@infradead.org>
 <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
 <YYOaOBKgFQYzT/s/@infradead.org>
 <CAPcyv4jKHH7H+PmcsGDxsWA5CS_U3USHM8cT1MhoLk72fa9z8Q@mail.gmail.com>
 <6d21ece1-0201-54f2-ec5a-ae2f873d46a3@oracle.com>
 <CAPcyv4hJjcy2TnOv-Y5=MUMHeDdN-BCH4d0xC-pFGcHXEU_ZEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hJjcy2TnOv-Y5=MUMHeDdN-BCH4d0xC-pFGcHXEU_ZEw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 12:00:12PM -0700, Dan Williams wrote:
> > 1. dax_iomap_iter() rely on dax_direct_access() to decide whether there
> >     is likely media error: if the API without DAX_F_RECOVERY returns
> >     -EIO, then switch to recovery-read/write code.  In recovery code,
> >     supply DAX_F_RECOVERY to dax_direct_access() in order to obtain
> >     'kaddr', and then call dax_copy_to/from_iter() with DAX_F_RECOVERY.
> 
> I like it. It allows for an atomic write+clear implementation on
> capable platforms and coordinates with potentially unmapped pages. The
> best of both worlds from the dax_clear_poison() proposal and my "take
> a fault and do a slow-path copy".

Fine with me as well.

> 
> > 2. the _copy_to/from_iter implementation would be largely the same
> >     as in my recent patch, but some changes in Christoph's
> >     'dax-devirtualize' maybe kept, such as DAX_F_VIRTUAL, obviously
> >     virtual devices don't have the ability to clear poison, so no need
> >     to complicate them.  And this also means that not every endpoint
> >     dax device has to provide dax_op.copy_to/from_iter, they may use the
> >     default.
> 
> Did I miss this series or are you talking about this one?
> https://lore.kernel.org/all/20211018044054.1779424-1-hch@lst.de/

Yes.  This is an early RFC, but I plan to finish this up and submit
it after the updated decouple series. 

> 
> > I'm not sure about nova and others, if they use different 'write' other
> > than via iomap, does that mean there will be need for a new set of
> > dax_op for their read/write?
> 
> No, they're out-of-tree they'll adjust to the same interface that xfs
> and ext4 are using when/if they go upstream.

Yepp.
