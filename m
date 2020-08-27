Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04725411E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgH0Iod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 04:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0Ioc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:44:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F5EC061264;
        Thu, 27 Aug 2020 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XCNfEIVVuEm9Nii0PBLcxslSyiHh28f54cDTYv6Ia/I=; b=myVpZlgS5AxWgCy47srlPuWNAT
        WxrcwoebKp2asNE7Jh3DH0HA8gcWt/25m22bDVLeKU4uzkCFKbraCqIJJuWv1uHiXpn6ARuq9rPCL
        fBLdrk3IbGTC+5Naqkas+u8sBkr39za4lSKkEmHictQpXTHJxLwnEKopFbz0x4ThiIsAj6gkc37C5
        tqm1Vvw7ZOiZCjOCu+/FHuchbdMcMmelFpO+E1wvnfghYdlDBrU+TVyp1ppdMll29y78lGr7dAVpA
        aJy6lpPD7M4HMh8g9dWgu2qKWV2d4mxYc99l9VBZzNrvQ7uexcOdwWWFAZJVkcVZaeBpBIOgOsioA
        ndKhqjxg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBDWJ-0004Gq-4P; Thu, 27 Aug 2020 08:44:31 +0000
Date:   Thu, 27 Aug 2020 09:44:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] block: Add bio_for_each_thp_segment_all
Message-ID: <20200827084431.GA15909@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
 <20200824151700.16097-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824151700.16097-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 04:16:53PM +0100, Matthew Wilcox (Oracle) wrote:
> Iterate once for each THP instead of once for each base page.

FYI, I've always been wondering if bio_for_each_segment_all is the
right interface for the I/O completions, because we generally don't
need the fake bvecs for each page.  Only the first page can have an
offset, and only the last page can be end earlier than the end of
the page size.

It would seem way more efficient to just have a helper that extracts
the offset and end, and just use that in a loop that does the way
cheaper iteration over the physical addresses only.  This might (or
might) not be a good time to switch to that model for iomap.
