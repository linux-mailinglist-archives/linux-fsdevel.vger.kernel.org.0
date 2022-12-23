Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5246551E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 16:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiLWPHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLWPHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:07:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1602A512;
        Fri, 23 Dec 2022 07:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0TYedYNU8D+NUsXvfS4xuhZ4V3OYraEeUZQLBYD+RCs=; b=N/kEBwpG/unle7Ub25VZd1qwlL
        3mcmvNm62Dh0AFgtKPC4/IhdjqunTc4Um2w18WeW8MuqmMDvNPOLVpa0uhMrxYKZovg0p2eoN3nlz
        fSFMZzpKkbmwYhpAoWzd6fMptO08RVZ2c5569jALuy77lbTd5BPRczbGVo3+UK64PPXqavJqWB8Mx
        cRM7TthccktrQ9KvlYt6hOsN1M30doasAqnBo7KrwqxKA3eP8CVkQcluN0jc+4t1l8ix3Fgg6SHpq
        LqyK7H8eEukQNwy4lgD9KRUGXMr/lGwKAnzPW0K+vkxKcxa2P+RGr7lybtBv2kf/U/xb5aXXiAdqr
        G1zEUabQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8je6-009DGB-Qi; Fri, 23 Dec 2022 15:07:38 +0000
Date:   Fri, 23 Dec 2022 07:07:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 5/7] iomap: Get page in page_prepare handler
Message-ID: <Y6XEOtT9Gc3p0kd4@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216150626.670312-6-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:06:24PM +0100, Andreas Gruenbacher wrote:
> Change the iomap ->page_prepare() handler to get and return a locked
> folio instead of doing that in iomap_write_begin().  This allows to
> recover from out-of-memory situations in ->page_prepare(), which
> eliminates the corresponding error handling code in iomap_write_begin().
> The ->page_done() handler is now not called with a NULL folio anymore.

Ah, okay - this is the other half of what I asked for earlier, so
we're aligned.  Sorry for the noise earlier.  I'd still prefer the
naming I suggest, though.

> +	if (page_ops && page_ops->page_prepare)
> +		folio = page_ops->page_prepare(iter, pos, len);
> +	else
> +		folio = iomap_folio_prepare(iter, pos);
> +	if (IS_ERR_OR_NULL(folio)) {
> +		if (!folio)
> +			return (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> +		return PTR_ERR(folio);
>  	}

Maybe encapsulate this in a iomap_get_folio wrapper just to keep the
symmetry with the done side.
