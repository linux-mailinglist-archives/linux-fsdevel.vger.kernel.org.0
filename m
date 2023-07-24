Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB01C75FDD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGXReW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGXReV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:34:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01113188;
        Mon, 24 Jul 2023 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1RR7SJ5J9bSabO2nn8ri1D3skM02qsCIJVqOYYsqxxM=; b=ObOKjtJ/THa+xqWvy7oYFf9v1F
        T1jW7wp0gQh1KChroWUqIsXM2WD6qHEjUlVhy1EXQn+y2hxVI8iF1zCbTv5liX9EwkOvfd9uLZ1DE
        nfqrtlYWV/MYoJGOC4jhjB/XXMW4MCdMEL3h2i0H7Z/ifAXtYbbpLBh9QI24+qa8H0q7Vk8QNRtGS
        OAYzoUDt/quatb9MyXKQmfXwj7s0rSuPymo08nhQ5qY4AA+hIQIy4VU7sbfUwGrrrxL104Es3d1rR
        0k3G7Y+VKToa54/y+PSAsQ9Qcw9vZ2rSma6Kpw4etEox2eXO1JuPbFqd6nOhUydeAjpQ7s6TVAz2q
        AsmhqVuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNzRs-0054IL-2J;
        Mon, 24 Jul 2023 17:34:20 +0000
Date:   Mon, 24 Jul 2023 10:34:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 05/20] block: Allow bio_iov_iter_get_pages() with
 bio->bi_bdev unset
Message-ID: <ZL62HKrAJapXfcaR@infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-6-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211115.2174650-6-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:11:00PM -0400, Kent Overstreet wrote:
> bio_iov_iter_get_pages() trims the IO based on the block size of the
> block device the IO will be issued to.
> 
> However, bcachefs is a multi device filesystem; when we're creating the
> bio we don't yet know which block device the bio will be submitted to -
> we have to handle the alignment checks elsewhere.

So, we've been trying really hard to always make sure to pass a bdev
to anything that allocates a bio, mostly due due the fact that we
actually derive information like the blk-cgroup associations from it.

The whole blk-cgroup stuff is actually a problem for non-trivial
multi-device setups.  XFS gets away fine because each file just
sits on either the main or RT device and no user I/O goes to the
log device, and btrfs papers over it in a weird way by always
associating with the last added device, which is in many ways gross
and wrong, but at least satisfies the assumptions made in blk-cgroup.

How do you plan to deal with this?  Because I really don't want folks
just to go ahead and ignore the issues, we need to actually sort this
out.
