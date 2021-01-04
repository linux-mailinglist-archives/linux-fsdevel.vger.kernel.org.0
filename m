Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8214C2EA10C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 00:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbhADXp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 18:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbhADXp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:45:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D942C061574;
        Mon,  4 Jan 2021 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YBgRGjn+yLmFC+9fNHoHRFsXeCxEkKsHezqEmQ36bEQ=; b=XIYp5yjtmgky7iNoVOQb+o3wZr
        3L/KpsgoiU4PgUF/2JfxkJRLW1hcLCYXszkagaCvEljXe9Uz+u8+jE4+N39M+0neNh8AXn+EbgqWM
        UAxR+Arf7ji2B/OFG3Uuzpv6oLlzE/WKH4NRTf2C5ZLJ22nsjlTWilnsqIdsGcypiK9aJg4IAg5lM
        1g4r0kbHQm4M2Ktv1xQeCRGIRJ24dRRo5PufxYiZ9vMcYqdiYxSuk/oTaFj4aJIls1KwvNY3iTP+R
        Trby8W4LwayqM2o9OfZDsuFaS3Xmo2k+k2H9fTJbw7qxTzxk44Reo+ivVA4pG6SNp99GU0kgCtR58
        KvCbKeJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwWHJ-000VKI-Fy; Mon, 04 Jan 2021 20:17:08 +0000
Date:   Mon, 4 Jan 2021 20:16:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupts@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
Message-ID: <20210104201633.GE22407@casper.infradead.org>
References: <20210101042914.5313-1-rdunlap@infradead.org>
 <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 12:13:02PM -0800, Dan Williams wrote:
> On Thu, Dec 31, 2020 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > +++ lnx-511-rc1/fs/dax.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/iomap.h>
> > +#include <asm/page.h>
> 
> I would expect this to come from one of the linux/ includes like
> linux/mm.h. asm/ headers are implementation linux/ headers are api.

It does indeed come from linux/mm.h already.  And a number of
other random places, including linux/serial.h.  Our headers are a mess,
but they shouldn't be made worse by adding _this_ include.  So I
second Dan's objection here.

> Once you drop that then the subject of this patch can just be "arc:
> add a copy_user_page() implementation", and handled by the arc
> maintainer (or I can take it with Vineet's ack).
> 
> >  #include <asm/pgalloc.h>
> 
> Yes, this one should have a linux/ api header to front it, but that's
> a cleanup for another day.

Definitely more involved.

