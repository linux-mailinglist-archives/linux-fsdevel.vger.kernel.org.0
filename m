Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D272C9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbjFLPZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbjFLPYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:24:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92891BCB;
        Mon, 12 Jun 2023 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H1SeaVKDIPMJLrLkzyfFrpKPYszgw9Zhlv0q5NXPMT0=; b=lrpw8yJmr+oTAm4obdokvtvxhP
        d+85/bSGopmBUBJbQUWmXdkilS9F/Mq0Kr6CwMQ8fSS6iJ9dOlUL4FQNscG089HuNn7lnq7k2cjlP
        jwHc2C81m36seZ5BQR/FJ5Ubg8H37eeXQgrpqJJcFw95pgyxpp3RvzXJgXVakh1Lbjb7HV6AqZ3xe
        /hpJa6MuuhcmhbDdEk30dYcExIefGIC4IJik6As7fMMiFWjgQi8JEcXRtyswMfl9SidRAKT+A89Vo
        pYgKgUvjVWtJhqlQ4wGuzAWYvhJbmY2fdlFqAmpQbEaZgfeMShjTUZBwDOVUlUoYITjqcv/69Ynkw
        pgXKIgYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8jPO-002m0i-8V; Mon, 12 Jun 2023 15:24:42 +0000
Date:   Mon, 12 Jun 2023 16:24:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers
 for ifs state bitmap
Message-ID: <ZIc4ujLJixghk6Zp@casper.infradead.org>
References: <CAHc6FU5xMQfGPuTBDChS=w2+t4KAbu9po7yE+7qGaLTzV-+AFw@mail.gmail.com>
 <87o7lkhfpj.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7lkhfpj.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:48:16PM +0530, Ritesh Harjani wrote:
> > Since we're at the nitpicking, I don't find those names very useful,
> > either. How about the following instead?
> >
> > iomap_ifs_alloc -> iomap_folio_state_alloc
> > iomap_ifs_free -> iomap_folio_state_free
> > iomap_ifs_calc_range -> iomap_folio_state_calc_range
> 
> First of all I think we need to get used to the name "ifs" like how we
> were using "iop" earlier. ifs == iomap_folio_state...
> 
> >
> > iomap_ifs_is_fully_uptodate -> iomap_folio_is_fully_uptodate
> > iomap_ifs_is_block_uptodate -> iomap_block_is_uptodate
> > iomap_ifs_is_block_dirty -> iomap_block_is_dirty
> >
> 
> ...if you then look above functions with _ifs_ == _iomap_folio_state_
> naming. It will make more sense. 

Well, it doesn't because it's iomap_iomap_folio_state_is_fully_uptodate.
I don't think there's any need to namespace this so fully.
ifs_is_fully_uptodate() is just fine for a static function, IMO.
