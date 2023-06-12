Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA372C821
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbjFLOWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbjFLOWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:22:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBB019A7;
        Mon, 12 Jun 2023 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RYm8TX9AS1ht1L64nn/kspYUes5TLCETxAZ1YmLK/YU=; b=I5TZRN3+QYfOoBrbYOM2Q/eLZR
        c05FYuWf9pdjpv8dAMBe0JmnbOfFUlxd2Z4iDPi482SQa0c11EFX+4OhLBpMmhpjPc36j6eMFgQQ/
        wlTvNJkghvhhzhXhw6zqO0Pvya5Mb1KMx2Zn7ZHg6UqExw1CjYk5M6gbwwvEMOYvI+9DqnhBujnJj
        xlV1jbsyhDAo9VFwf0AySL5Q4j1OPT7zXHRK/w67X4L8iXkica5LwFTcGBHzWe9MMJ8BxelBu1K83
        oFccMNQOzeytYk0Xp/SbzddXn5VOF4xYByBQADjj66OoKWmhdFgh0wIp2V0dyo45D67OQ3RQnkV0C
        6/nP5cPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8iOT-002iKQ-5e; Mon, 12 Jun 2023 14:19:41 +0000
Date:   Mon, 12 Jun 2023 15:19:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 4/6] iomap: Refactor iomap_write_delalloc_punch()
 function out
Message-ID: <ZIcpfaqlWskQccAX@casper.infradead.org>
References: <ZIccDjZQdAMXcnJQ@casper.infradead.org>
 <87ttvchj66.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttvchj66.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:33:29PM +0530, Ritesh Harjani wrote:
> >> +	*punch_start_byte = min_t(loff_t, end_byte,
> >> +				  folio_next_index(folio) << PAGE_SHIFT);
> >
> > 	*punch_start_byte = min(end_byte, folio_pos(folio) + folio_size(folio));
> 
> Current code was also correct only. But I guess this just avoids
> min_t/loff_t thing. No other reason right?

Actually, it's buggy on 32-bit platforms.  folio_next_index returns
an unsigned long (32 bit), which is shifted by PAGE_SHIFT, losing the
top bits, then cast to an loff_t.  folio_pos() does this correctly.
