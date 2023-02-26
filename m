Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693FF6A3593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 00:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBZXXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 18:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZXXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:23:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88443BB97;
        Sun, 26 Feb 2023 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HrU4A5BoPxZ9+wtELP5ZS9Kc1aKd7euzLE9nr/rlVlk=; b=YqJYOS3nQ/OAClXrBj/Dnch0wp
        x1FRQNqxm9G6tRRAVR3+lWZwe3KAb4XNIPobm5mDWP1LnhLF1drgntwIZIbPiJZzy27OUw3cCxYAk
        gtQqKs5BvUmde3gvUHAvRN/7jBP8d3ZD3buFXjBOgmxs5EfTUrK9/UIkpj3WZ5FvKEuylGiKlpB/L
        d49V3W2pdPA21uk0VDfa8ajdcBnl6GvVxj8z5AXym33pUS+/thLns/ETbmMyrMFDvZuf8dz7zi2rD
        3SrymLPsSe+0DIkz3RZ7se71efN0972Lqrg3pKUejbOFCT1M2siMWlNlQRdtAszliuTAuDYueAw2B
        SQyesVEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWQMJ-00HEbI-72; Sun, 26 Feb 2023 23:23:11 +0000
Date:   Sun, 26 Feb 2023 23:23:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 2/3] iomap: Change uptodate variable name to state
Message-ID: <Y/vp36n3n3MNUjqD@casper.infradead.org>
References: <cover.1677428794.git.ritesh.list@gmail.com>
 <457680a57d7c581aae81def50773ed96034af420.1677428794.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457680a57d7c581aae81def50773ed96034af420.1677428794.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:13:31AM +0530, Ritesh Harjani (IBM) wrote:
> +static inline bool iop_test_uptodate(struct iomap_page *iop, unsigned int pos,
> +				unsigned int nrblocks)
> +{
> +	return test_bit(pos, iop->state);
> +}

'pos' is usually position within file, not within the folio.  That
should be called 'block' or 'start' like the other accessors.

> +static inline bool iop_full_uptodate(struct iomap_page *iop,
> +				unsigned int nrblocks)
> +{
> +	return bitmap_full(iop->state, nrblocks);
> +}

Not sure I like iop_full_uptodate() as a name.  iop_entirely_uptodate()?
iop_folio_uptodate()?  iop_all_uptodate()?

