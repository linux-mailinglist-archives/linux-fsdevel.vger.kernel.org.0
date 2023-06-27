Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83F273FF99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjF0PZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF0PZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:25:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FC2976;
        Tue, 27 Jun 2023 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vhqu6XD+ruq8OkOqwki1HcqcvHS0A0VxJzjy8VCYPok=; b=gF3SuW5w8QlP57FlWiVqozsltn
        qL4gcSC5D9eBV6xSGUahoYZRBX9hMcnXeEyyg6H4gARpZVJD8RCmUfP8H3iOg80vFMtIChpurZqr5
        UKKvD5fwjqQJHIIxCRNb3VmMyfJfrNvMzm7SfMtPfsuve4rwYnFs0r03ws/ugfbnaOeZ5KJ5x1VVB
        cRPSpv6zjlXN+fNTonnSN0L4WpsWKxjnd06FAEIb+GojSj/gGdJhSf5dx9lVxB5viYmNCbXXMQyjl
        MGAmLJijEtfpUE669GKOHBWN1xRzfNVCltfJAD5Qq74qOalF30o32nUZffq03IcELOK+TuVw34+un
        +/5fyhWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEAYy-002qIS-Rt; Tue, 27 Jun 2023 15:25:04 +0000
Date:   Tue, 27 Jun 2023 16:25:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 08/12] writeback: Factor writeback_get_folio() out of
 write_cache_pages()
Message-ID: <ZJr/UHDEIbieQOsv@casper.infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-9-willy@infradead.org>
 <ZJpmybS4av40w87L@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJpmybS4av40w87L@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:34:17PM -0700, Christoph Hellwig wrote:
> > +	for (;;) {
> > +		folio = writeback_get_next(mapping, wbc);
> > +		if (!folio)
> > +			return NULL;
> > +		wbc->done_index = folio->index;
> > +
> > +		folio_lock(folio);
> > +		if (likely(should_writeback_folio(mapping, wbc, folio)))
> > +			break;
> > +		folio_unlock(folio);
> > +	}
> > +
> > +	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> > +	return folio;
> 
> Same minor nitpick, why not:
> 
> 
> 	while ((folio = writeback_get_next(mapping, wbc)) {
> 		wbc->done_index = folio->index;
> 
> 		folio_lock(folio);
> 		if (likely(should_writeback_folio(mapping, wbc, folio))) {
> 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> 			break;
> 		}
> 		folio_unlock(folio);
> 	}
> 
> 	return folio;
> 
> ?

Because we end up having to call writeback_finish() somewhere, and it's
neater to do it here than in either writeback_get_next() or both callers
of writeback_get_folio().
