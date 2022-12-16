Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214F464EF24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 17:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiLPQa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 11:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLPQa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:30:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F052E9EE;
        Fri, 16 Dec 2022 08:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5rY6k+TkStBSKHUWEHUZh6+NC6Q6aDUW2nIr4sNKMfg=; b=PI/buYUkmozKCsd7wVHlZV/df9
        /FnG9RyByLMNa6tzvrzwpwQ3DED7EHDBTP3Zc6k8KRXMNkFdrslcCb6e+yco2Cm0Zd4hyvOobIYke
        IUwa47W4Jha+rZ0bEjNi5vkhLNiKqYTDHwgy16SqfjWlxaTQJFS18LB45TtAkeScQ5xwivbJQlC5k
        hembnALoFerDZegAiqXEm14b+yJRsQBNkiVCFPLH6B8BvfDWbpcSvr82i36qBZFX89+ay6sEhr/+E
        tXaBSQgX6OTqVsMbY1TPmGlqvdBMDXerw9gRFSu5Lhm7ku6lc8zhEIhVMe+oxTa9RCXJGyb8H8mAM
        5eagHWFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6DbK-00FcwU-P0; Fri, 16 Dec 2022 16:30:22 +0000
Date:   Fri, 16 Dec 2022 16:30:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 5/7] iomap: Get page in page_prepare handler
Message-ID: <Y5ydHlw4orl/gP3a@casper.infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216150626.670312-6-agruenba@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:06:24PM +0100, Andreas Gruenbacher wrote:
> +	if (page_ops && page_ops->page_prepare)
> +		folio = page_ops->page_prepare(iter, pos, len);
> +	else
> +		folio = iomap_folio_prepare(iter, pos);
> +	if (IS_ERR_OR_NULL(folio)) {
> +		if (!folio)
> +			return (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> +		return PTR_ERR(folio);

Wouldn't it be cleaner if iomap_folio_prepare() always
returned an ERR_PTR on failure?

