Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5F2B2DD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 16:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKNPPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKNPPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:15:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE86C0613D1;
        Sat, 14 Nov 2020 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pnMpGSz3WU3Qg8VEEi9swkyNkUmB/TSLQSr/FRvOqUs=; b=isdbDIxj3oIXpGFPhZtcqH77yD
        eBdRgfYjuDhfRo/OvV1OUi5d4ojRktgwx6KkuKlVzP/Qoo6d52ImRe3FadCWrssvlyAtqzxG7FWVZ
        0htEEW3CzMFEfr7RgfetWJklYyDp8lIzWYjWrAGrdC5dcUko4+uNgBDF+9Fm0pQquov2x8Je3lnG1
        A8zwrk4LfcIkXPYSLDMhkPq8IVHuxpXrNg92TaanaRSustnVFcQo/ngRpZM52nBE6i6Nh2OwvNYv3
        kNpmdARWu053CLUDEDvOIGqC1FnVKRrRNj45GJP7rjgBhcchOmhfA4rwWofcPV9Fa1Od4wNXMSjYf
        qqyjg+6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdxGk-00014a-Ob; Sat, 14 Nov 2020 15:15:14 +0000
Date:   Sat, 14 Nov 2020 15:15:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        yang.shi@linux.alibaba.com, dchinner@redhat.com,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 06/16] mm/filemap: Add helper for finding pages
Message-ID: <20201114151514.GL17076@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <20201112212641.27837-7-willy@infradead.org>
 <20201114100318.GG19102@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114100318.GG19102@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 14, 2020 at 11:03:18AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2020 at 09:26:31PM +0000, Matthew Wilcox (Oracle) wrote:
> > +	if (mark == XA_PRESENT)
> > +		page = xas_find(xas, max);
> > +	else
> > +		page = xas_find_marked(xas, max, mark);
> 
> Is there any good reason xas_find_marked can't handle the XA_PRESENT
> case as well?

I've been thinking about making that change.  It's a little trickier
than I thought it would be, so it's on the back burner for now.
