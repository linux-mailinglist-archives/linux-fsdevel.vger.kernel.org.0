Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879D773F32E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjF0EMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjF0EML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:12:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2750A10FC;
        Mon, 26 Jun 2023 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BLmHsyqPufGEDqWhK4TW18ghrPJRAcuDI9St068tosg=; b=1DFDuaCtDRl1uZpfCO7uKXpBIV
        VDMYxiOdi74H4VKK0YxlX2JekqT4HUmiYgQPXywh0R+d45YLFWDNUWk0mQ50cgiq+BhpjeAWJjb8e
        6ispYPCbW3c/ywQj5scvFylnY4HlmWrzQjfmuKmz3whr32i11q69fE/KGMIMkcKIxDi+LR1kCtYkj
        43K2Nu0OrWxrLsmg4dK1XhD5UypUcCAZLftXfQXNA6o7CsUiaj4gabHIFX1GdHPK1FoBCy2QcNLfn
        hdEcMx7gK6McDE2GiEjX6drIj4rAcEyw/TgBHKZK6AUPLp0JSeR6+t/3gg3HCyw9uMzC3MfunDvkI
        26BF9OoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE03j-00Bf19-36;
        Tue, 27 Jun 2023 04:12:07 +0000
Date:   Mon, 26 Jun 2023 21:12:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 03/12] writeback: Factor should_writeback_folio() out of
 write_cache_pages()
Message-ID: <ZJphl4Ws4QzitTny@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (folio_test_writeback(folio)) {
> +		if (wbc->sync_mode != WB_SYNC_NONE)
> +			folio_wait_writeback(folio);
> +		else
> +			return false;
> +	}

Please reorder this to avoid the else and return earlier while you're
at it:

	if (folio_test_writeback(folio)) {
		if (wbc->sync_mode == WB_SYNC_NONE)
			return false;
		folio_wait_writeback(folio);
	}

(that's what actually got me started on my little cleanup spree while
checking some details of the writeback waiting..)

> +	BUG_ON(folio_test_writeback(folio));
> +	if (!folio_clear_dirty_for_io(folio))
> +		return false;
> +
> +	return true;

..

	return folio_clear_dirty_for_io(folio);

?

