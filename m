Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4E454827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhKQOKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 09:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKQOKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:10:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E8C061570;
        Wed, 17 Nov 2021 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mWEYaeuenYjOK9SZVevVvi0N1QEaT81uieLufHXvInk=; b=bQrKFGAFn6L4WxVofpzkB2mUig
        8YtxqxrqhUrMuON2r0d2oDw7GU6VPlbDI3q30KAs7jzBotUaMlBm0uS8U37jj1o/74gvRlLb196Fh
        0P8p6B2Z0+jYxObVa9UM62bKBP3q5P3qBWojKCMRuiLG78DyH5yLogSdMBrl54WvDHXTP9wpDRBLU
        DYzMYYXUz8VAzDvjQRSRFiUbW/WqiU/+M2SiyQuo3Q0Cpamd0gyZCER3aXtvj6yub3xNIPYVxD5tk
        Qk/LCKFPZ1WTXxijrYLQqRZWv2U9YnNoGYsFamZs4hcGU2UuUbMjETneLNTcX83KNUpkhnXF96sFQ
        HW2b+h5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnLaW-007esQ-9T; Wed, 17 Nov 2021 14:07:00 +0000
Date:   Wed, 17 Nov 2021 14:07:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Message-ID: <YZUMhDDHott2Q4W+@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-3-willy@infradead.org>
 <20211117044527.GO24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117044527.GO24307@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 08:45:27PM -0800, Darrick J. Wong wrote:
> > +/**
> > + * folio_zero_segment() - Zero a byte range in a folio.
> > + * @folio: The folio to write to.
> > + * @start: The first byte to zero.
> > + * @end: One more than the last byte in the first range.
> > + */
> > +static inline void folio_zero_segment(struct folio *folio,
> > +		size_t start, size_t end)
> > +{
> > +	zero_user_segments(&folio->page, start, end, 0, 0);
> > +}
> > +
> > +/**
> > + * folio_zero_range() - Zero a byte range in a folio.
> > + * @folio: The folio to write to.
> > + * @start: The first byte to zero.
> > + * @length: The number of bytes to zero.
> > + */
> > +static inline void folio_zero_range(struct folio *folio,
> > +		size_t start, size_t length)
> > +{
> > +	zero_user_segments(&folio->page, start, start + length, 0, 0);
> 
> At first I thought "Gee, this is wrong, end should be start+length-1!"
> 
> Then I looked at zero_user_segments and realized that despite the
> parameter name "endi1", it really wants you to tell it the next byte.
> Not the end byte of the range you want to zero.
> 
> Then I looked at the other two new functions and saw that you documented
> this, and now I get why Linus ranted about this some time ago.
> 
> The code looks right, but the "end" names rankle me.  Can we please
> change them all?  Or at least in the new functions, if you all already
> fought a flamewar over this that I'm not aware of?

Change them to what?  I tend to use 'end' to mean 'excluded end' and
'max' to mean 'included end'.  What would you call the excluded end?
