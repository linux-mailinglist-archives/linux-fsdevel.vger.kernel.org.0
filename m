Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E703073F36D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjF0EeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0EeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:34:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2171716;
        Mon, 26 Jun 2023 21:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OPyvNcbViu0Zlus2gx2uWO9nU0QCMLp8MGnwfJjfufs=; b=sPT0T5ng1PrkKAcoSvEjnolUFa
        S2r+CVP7sb0O3sLUzDg04yBIb6xSFyQnoQ8jUR2bIVivXsgzhIS7lbbZPF7jIZ0EhMDwjpLFN7pDF
        O8u8uAV9zPQnBTCzK1a3ISTbrYC2TvYC+HMpUmEuKepypA+Uk9Up7eC2u6MFYgBJKBXLWq0XvNnBJ
        jATozQTsgwi+oKlcCQGoro/1cfVy0Q6FitbUuhPWypnaOTPvBJIH8pvBTFi/IIufwP1GsSCffPFLO
        jWPJ+JyVaEVOVEYjC+e/56f/YIavqD7wuIanhpIi6WqvdgBJKV3GLYWdA/13I/sq7XnfF2dZj6SeN
        3oDuhwMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE0PB-00BhMI-1G;
        Tue, 27 Jun 2023 04:34:17 +0000
Date:   Mon, 26 Jun 2023 21:34:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 08/12] writeback: Factor writeback_get_folio() out of
 write_cache_pages()
Message-ID: <ZJpmybS4av40w87L@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-9-willy@infradead.org>
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

> +	for (;;) {
> +		folio = writeback_get_next(mapping, wbc);
> +		if (!folio)
> +			return NULL;
> +		wbc->done_index = folio->index;
> +
> +		folio_lock(folio);
> +		if (likely(should_writeback_folio(mapping, wbc, folio)))
> +			break;
> +		folio_unlock(folio);
> +	}
> +
> +	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> +	return folio;

Same minor nitpick, why not:


	while ((folio = writeback_get_next(mapping, wbc)) {
		wbc->done_index = folio->index;

		folio_lock(folio);
		if (likely(should_writeback_folio(mapping, wbc, folio))) {
			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
			break;
		}
		folio_unlock(folio);
	}

	return folio;

?
