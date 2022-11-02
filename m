Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879A1615DE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 09:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKBIgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiKBIgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:36:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DF815FE6;
        Wed,  2 Nov 2022 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DMLANRxsWdHHYZSkQAEEoH9bza0b+OnzdgYT1aXAhAg=; b=IMuCC3UD5Smpa2+InQp2kNyVq2
        COvu+lBNeLbrlLkI81rxARwwQDKY5v8+eKL0NOUFm2wBXYOZ9th4aFVGlh7hLF3JbqDiBYhK8BWB/
        m5iGa/V7AaopxoNuyr5Zb3d9xwrijcCgQcxVmELdC+XnAu6jqj3HSKRk2rR0iqFQysnEBRntWLA2Y
        xVSsZ+iJ6NMwhXrudt6cl9t98KPLJy1Q3scd5QoRpMtRF3Iv5nuWErLCKWlIHgo6KZ+AG5+3dS+lB
        KVJRIYb18GUTKfMsilz8ZdSMVMsTzxAF1v+YvlaTuG73/JlnYwMqS4baMoZlYecJUnWLFi03u3lRY
        ipRwHZOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq9En-0091Uc-Pw; Wed, 02 Nov 2022 08:36:41 +0000
Date:   Wed, 2 Nov 2022 01:36:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] iomap: write iomap validity checks
Message-ID: <Y2IsGbU6bbbAvksP@infradead.org>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-6-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:34:10AM +1100, Dave Chinner wrote:
> +	/*
> +	 * Now we have a locked folio, before we do anything with it we need to
> +	 * check that the iomap we have cached is not stale. The inode extent
> +	 * mapping can change due to concurrent IO in flight (e.g.
> +	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
> +	 * reclaimed a previously partially written page at this index after IO
> +	 * completion before this write reaches this file offset) and hence we
> +	 * could do the wrong thing here (zero a page range incorrectly or fail
> +	 * to zero) and corrupt data.
> +	 */
> +	if (ops->iomap_valid) {
> +		bool iomap_valid = ops->iomap_valid(iter->inode, &iter->iomap);
> +
> +		if (!iomap_valid) {
> +			iter->iomap.flags |= IOMAP_F_STALE;
> +			status = 0;
> +			goto out_unlock;
> +		}
> +	}

So the design so far has been that everything that applies at a page (or
now folio) level goes into iomap_page_ops, not iomap_ops which is just
the generic iteration, and I think we should probably do it that way.

I'm a little disappointed that we need two callout almost next to each
other, but given that we need to validate with the folio locked, and
gfs2 wants the callback with the folio unlocked I think we have to do
it that.
