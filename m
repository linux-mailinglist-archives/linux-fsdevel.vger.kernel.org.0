Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851D672C5C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbjFLNWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjFLNW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:22:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F1E3;
        Mon, 12 Jun 2023 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/GSu6OVQs0ltyUd2o+Wvf2F1RPuhTpCI5GZst/CgoWE=; b=s1CFIqLhF/DB1BpvQzWxqDwi2X
        gBexhrVublgN5U9q9QOFWR+YkEpXhMQ0mdKamThcL8EvmOh3bMk+z0Iby+EXS+AhB245ILWc5aTk8
        1WJOlgRPEsLLuTtsSEJNCg8yQhs6po/CNCx5zliRw0RlYpwR2WOHalttAfgd4/vVhKwxbqTWGPXMK
        td6JvZ3Gt4i3ipbwviF7P7ZUeHmSb8+BvpOavFh8qc9QGRxlpYldphrXWBGMggk42xvn4FptZmqJq
        +504Lc+nBVkjvGBi5/IbEQXPs6cNjFjU1xy6njHjYwrR7l/LYepJcY8lKkDvXETGjRSU5k3IyQ/tP
        fcNPTYuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8hV0-002fOh-B5; Mon, 12 Jun 2023 13:22:22 +0000
Date:   Mon, 12 Jun 2023 14:22:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
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
Message-ID: <ZIccDjZQdAMXcnJQ@casper.infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <62950460a9e78804df28c548327d779a8d53243f.1686395560.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62950460a9e78804df28c548327d779a8d53243f.1686395560.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 10, 2023 at 05:09:05PM +0530, Ritesh Harjani (IBM) wrote:
> +static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
> +		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))

I can't help but feel that a

typedef iomap_punch_t(struct inode *, loff_t offset, loff_t length);

would make all of this easier to read.

> +	/*
> +	 * Make sure the next punch start is correctly bound to
> +	 * the end of this data range, not the end of the folio.
> +	 */
> +	*punch_start_byte = min_t(loff_t, end_byte,
> +				  folio_next_index(folio) << PAGE_SHIFT);

	*punch_start_byte = min(end_byte, folio_pos(folio) + folio_size(folio));

