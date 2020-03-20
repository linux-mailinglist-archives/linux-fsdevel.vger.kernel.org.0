Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC78318D5D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 18:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCTRan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 13:30:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCTRam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UGITiyVmaO8X73R6wVMfMGWLW2W7neAq/9meuj1VHqo=; b=EGKIuDKu0tjZuVECGtavPDxi0D
        O6qg1HxEZ5HTL6SQ+HnHGiXg3uMjLMXJy/QxU+RUtVkogm3OV1OoYySDKdd0TNCl75RNBRD/yIw4o
        r5B74nN9dCjwBJMpXdmIQPMo0Dtd++oHnpRNcQiIMtN+2/YTHKBLp/Yz4yXCj69SdRRm0YxhO6rSh
        QXAUKzLbScpAtIooOgBnixq+3fxkEPx9tp3sn8jy4Vs+FM4MKzh0fM6tnnEsYlBa1E1lxlobx/VwW
        F43ky5cdb9YLYKc01lCcZou/2CPPrIQSZW4GwTB3CgHdAptXVKYA1oettmTxaZQrltP3u3grDMdAI
        dACn5xZg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFLTk-0003g5-Sd; Fri, 20 Mar 2020 17:30:40 +0000
Date:   Fri, 20 Mar 2020 10:30:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200320173040.GB4971@bombadil.infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
 <20200320165828.GB851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320165828.GB851@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 09:58:28AM -0700, Eric Biggers wrote:
> On Fri, Mar 20, 2020 at 07:22:18AM -0700, Matthew Wilcox wrote:
> > +	/* Avoid wrapping to the beginning of the file */
> > +	if (index + nr_to_read < index)
> > +		nr_to_read = ULONG_MAX - index + 1;
> > +	/* Don't read past the page containing the last byte of the file */
> > +	if (index + nr_to_read >= end_index)
> > +		nr_to_read = end_index - index + 1;
> 
> There seem to be a couple off-by-one errors here.  Shouldn't it be:
> 
> 	/* Avoid wrapping to the beginning of the file */
> 	if (index + nr_to_read < index)
> 		nr_to_read = ULONG_MAX - index;

I think it's right.  Imagine that index is ULONG_MAX.  We should read one
page (the one at ULONG_MAX).  That would be ULONG_MAX - ULONG_MAX + 1.

> 	/* Don't read past the page containing the last byte of the file */
> 	if (index + nr_to_read > end_index)
> 		nr_to_read = end_index - index + 1;
> 
> I.e., 'ULONG_MAX - index' rather than 'ULONG_MAX - index + 1', so that
> 'index + nr_to_read' is then ULONG_MAX rather than overflowed to 0.
> 
> Then 'index + nr_to_read > end_index' rather 'index + nr_to_read >= end_index',
> since otherwise nr_to_read can be increased by 1 rather than decreased or stay
> the same as expected.

Ooh, I missed the overflow case here.  It should be:

+	if (index + nr_to_read - 1 > end_index)
+		nr_to_read = end_index - index + 1;

Let's say index comes in at ULONG_MAX - 2, end_index is ULONG_MAX - 1
and nr_to_read is 8.  The first condition triggers and nr_to_read is
reduced to 3.  But then the second condition wouldn't trigger because
ULONG_MAX - 2 + 3 is 0.

With the rewrite I have in this message, ULONG_MAX - 2 + 3 - 1 is ULONG_MAX,
which is > ULONG_MAX - 1.  So the condition triggers and nr_to_read becomes
(ULONG_MAX - 1) - (ULONG_MAX - 2) + 1.  Which is -1 + 2 + 1, which is 2.
Which is the right answer because we want to read two pages; the one
at ULONG_MAX - 2 and the one at ULONG_MAX - 1.

Thank you!
