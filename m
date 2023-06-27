Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA873F368
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjF0EcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjF0Eb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:31:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36601716;
        Mon, 26 Jun 2023 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a2dR7xpPIXwa7mgxrA3ZYrC24teMCgTKOM+0t+zuPts=; b=NAnu0sELXqjPhTmBs+owObHvJ1
        Y8QXdx/O0B8x9h7c8zwr9S/aT3AzDtTSi6yj9ZU5tvT4HjQcFd/ZPyuif5a7LIMPkrQVOaCS80w2C
        /fVxFqPBAy371n2w84c/K69IY3QaDcrZtVPJfatNWhQDEjFM1oConavbkIJjsZsQXOZeo2jYLOD+9
        BbJB/NpLw22IILLQHoKBoyTsDMrVaN1s65BkvkB17qym3YNhoAEZYP1Eczk6KHeAUAdVAJducqCzd
        fzs7eGHb+dD64gL6Was8/8odNLBv4ySJlu0W2RqmgyTFXCfe1nb0ZsRdf0MMzWHhJ92ZcdRQccpcO
        YhDDW2/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE0Mu-00BhBJ-31;
        Tue, 27 Jun 2023 04:31:56 +0000
Date:   Mon, 26 Jun 2023 21:31:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 07/12] writeback: Factor writeback_iter_init() out of
 write_cache_pages()
Message-ID: <ZJpmPOEH7rYkETsQ@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-8-willy@infradead.org>
 <ZJplzwnPBHo4ZK60@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJplzwnPBHo4ZK60@infradead.org>
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

On Mon, Jun 26, 2023 at 09:30:07PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 26, 2023 at 06:35:16PM +0100, Matthew Wilcox (Oracle) wrote:
> > +	for (folio = writeback_iter_init(mapping, wbc);
> > +	     folio;
> > +	     folio = writeback_get_next(mapping, wbc)) {
> 
> Ok that's another way to structure it.  Guess I should look over the
> whole series first..

That beeing said.  Given that writeback_iter_init calls 
writeback_get_next anyway,

	writeback_iter_init(mapping, wbc);
	while ((folio = writeback_get_next(mapping, wbc)))

still feels a little easier to follow to be.  No hard feelings either
way, just an observation.

