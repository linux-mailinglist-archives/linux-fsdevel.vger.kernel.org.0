Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417A6A4CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 22:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjB0VCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 16:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0VCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:02:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF123DAF
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 13:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tob57UFyeBCiGpzZYnSrMZZK1HMTjtbuXQGmlUbhJd4=; b=OcT3ucNukKyKdSx3bbfTRw37ku
        r9l0Sj2A1kT+BQmFitLRNFixcUmkpbVZ2KI9UY6B0QUle773f03ihOmgdwuG9cdqkk979mjShGyHf
        xmSya6JPzQ9u0uY833JmPAJ3UeEAjM4SzjPqv/AQl39kRY/HftifHNPX3ZQKlT+yxqMKhyZs2gADk
        eLzMpW9KFAuwGdE4TPpy1BLhS8aKiUhgJOVsj040OAwBP/d94nQrfp0WUoE3Ur1NMM2di81P0UB5I
        tTio6GKDZX3F9e6ARZiY0oT3uA6tMpm/L7ueoh5vjGwHyjkEILw5A20KBsrg2H519UHHB3oO1SLv0
        v3tIkI+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWkdh-000Oid-NR; Mon, 27 Feb 2023 21:02:29 +0000
Date:   Mon, 27 Feb 2023 21:02:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus @imap.suse.de>> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y/0aZYKvvyinw3b6@casper.infradead.org>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y9X+5wu8AjjPYxTC@casper.infradead.org>
 <20230208160422.m4d4rx6kg57xm5xk@quack3>
 <Y/0D2UYzmhuCigg4@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/0D2UYzmhuCigg4@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:26:17AM -0800, Darrick J. Wong wrote:
> > As I wrote above, for metadata there ought to be something as otherwise it
> > will be real pain (and no gain really). But I guess the concrete API only
> > matterializes once we attempt a conversion of some filesystem like ext2.
> > I'll try to have a look into that, at least the obvious preparatory steps
> > like converting the data paths to iomap.
> 
> willy's tried this.

Well, I started on it.  The first thing I looked at was trying to decide
how to handle the equivalent of BH_boundary:

https://lore.kernel.org/linux-fsdevel/20200320144014.3276-1-willy@infradead.org/

I'm no longer sure that's the right approach.  Maybe we do want to have
an IOMAP_F_BOUNDARY to indicate that the bio should be submitted before
calling iomap_iter() again.  But we're definitely still missing the piece
where we start the I/O to the page by setting iop->read_bytes_pending
to folio_size() and then subtract off each piece as we either zero it
or the I/O completes.

I have a bunch of other pagecache / fs work queued up for this cycle, so
I wasn't planning on leaping back into this.  But it's worth making sure
hat people know about one of the problems we figured out three years ago:
https://lore.kernel.org/linux-fsdevel/20200505190825.GB5694@magnolia/
