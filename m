Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3300B66D79C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjAQIKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbjAQIJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:09:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373512748C;
        Tue, 17 Jan 2023 00:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pQjSKmSw6p/N0OMSHc7at4GiVU7Rg/XB3qkDkMiu+rs=; b=sFzD+basG4rvAZOsDrubDxcusL
        KFAWUTWkOY8ubdQ9rE5S0ri3fww/A//S0+L4dcIVxCUc8J4WVyFO+NRipr3GI5MV48YehqqS+7PIP
        B9uaCAs/Y2fc6HCamTtbb5sRHsKgRex7dDNaEKfnO2WIc4fX2F+My4M+KBm2AsuDiukCA8FWLvNy6
        RR6mZTk8cYOaAKhP8LHq52JGxWcLoRB7XXKnlxzSEofxxsNnIywjle0Edqar0aRttUtBtp9M+ZdLR
        r5TF5S6JJ2KD9UgNmaw7nsUn0w+ck/yj60pHY4vaLLkqTKZjT8u5Gf+qR5KAXI+kg0jeX4ZmtNZCS
        kBvwUJ/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh2A-00DHQP-F9; Tue, 17 Jan 2023 08:09:30 +0000
Date:   Tue, 17 Jan 2023 00:09:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
Message-ID: <Y8ZXukUbg0/9cYtV@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
 <Y8ZU1Jjx5VSetvOn@infradead.org>
 <3515368f-d622-f7d2-5854-9503d4a19fb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3515368f-d622-f7d2-5854-9503d4a19fb2@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:07:48AM +0100, David Hildenbrand wrote:
> Agreed. What I understand, David considers that confusing when considering
> the I/O side of things.
> 
> I recall that there is
> 
> DMA_BIDIRECTIONAL -> FOLL_WRITE
> DMA_TO_DEVICE -> !FOLL_WRITE
> DMA_FROM_DEVICE -> FOLL_WRITE
> 
> that used different defines for a different API. Such terminology would be
> easier to get ... but then, again, not sure if we really need acronyms here.
> 
> We're pinning pages and FOLL_WRITE defines how we (pinning the page) are
> going to access these pages: R/O or R/W. So the read vs. write is never from
> the POC of the device (DMA read will write to the page).

Yes.  Maybe the name could be a little more verboe, FOLL_MEM_WRITE or
FOLL_WRITE_TO_MEM.  But I'd really prefer any renaming to be split from
logic changes.
