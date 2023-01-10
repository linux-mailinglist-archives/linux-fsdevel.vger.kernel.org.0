Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1BC663BA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjAJIsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 03:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjAJIsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:48:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F5265F;
        Tue, 10 Jan 2023 00:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dEXzLuaqvTyI+z3V9E2DV7LmLQn86nVlheB/UL+EEQQ=; b=4+ELp8oAZD0VpajXTmN091MC6L
        ZRgGc8buu/MFV3TuLGpIeq2LzVwd4EtlS9LemmpyRIZEofEYzcvRTAsr27+I3kUaJZvTTQ1qHe1ie
        EphkUVXO6yTRnjTnzbnFeNNlFkNTvCFZNBZ2EX8f9x6gHK11Cu2nWTo6i7YRyNHvUkeRwKolStVgU
        RX4mj/aGJkdm1LTzyZ8s9C/KRvFTBl66LFWIWZHDzd8QP+Q8cGLQAnOyOh45RnWs7wf6Q3/MPTWto
        pp/Q88x9bmKvZAZqctxkIZU5iLJeoAkEflOdMcBkVvMHR4naDm+LYHWi7NaYLOs37tTII8bQYeo6u
        +i+kKG0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFAIp-005trf-CU; Tue, 10 Jan 2023 08:48:15 +0000
Date:   Tue, 10 Jan 2023 00:48:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v6 06/10] iomap: Add __iomap_get_folio helper
Message-ID: <Y70mT0Ptuy9s/une@infradead.org>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-7-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108194034.1444764-7-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 08:40:30PM +0100, Andreas Gruenbacher wrote:
> +static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
> +		size_t len)
> +{
> +	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> +
> +	if (page_ops && page_ops->page_prepare)
> +		return page_ops->page_prepare(iter, pos, len);
> +	else
> +		return iomap_get_folio(iter, pos);

Nit: No need for an else after the return.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
