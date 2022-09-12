Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6785B565A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiILIgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 04:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiILIfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:35:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B55E17599;
        Mon, 12 Sep 2022 01:35:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4FDB468B05; Mon, 12 Sep 2022 10:35:05 +0200 (CEST)
Date:   Mon, 12 Sep 2022 10:35:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <20220912083504.GB11318@lst.de>
References: <20220910065058.3303831-1-hch@lst.de> <20220910065058.3303831-2-hch@lst.de> <bcabe527-7940-8658-1728-28d64bd3cf80@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcabe527-7940-8658-1728-28d64bd3cf80@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 10, 2022 at 05:34:02AM -0600, Jens Axboe wrote:
> >  	/* Start the actual read. The read will unlock the page. */
> > +	if (unlikely(workingset))
> > +		psi_memstall_enter(&pflags);
> >  	error = filler(file, folio);
> > +	if (unlikely(workingset))
> > +		psi_memstall_leave(&pflags);
> >  	if (error)
> >  		return error;
> 
> I think this would read better as:
> 
>   	/* Start the actual read. The read will unlock the page. */
> 	if (unlikely(workingset)) {
> 		psi_memstall_enter(&pflags);
> 		error = filler(file, folio);
> 		psi_memstall_leave(&pflags);
> 	} else {
> 		error = filler(file, folio);
> 	}
>   	if (error)
>   		return error;

I had it both ways.  For any non-trivial code in the conditionals I
tend to go with your version all the time.  But for two times a single
lines both variants tends to suck, so I can live with either one.
