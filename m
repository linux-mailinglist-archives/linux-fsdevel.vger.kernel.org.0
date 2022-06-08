Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085754384C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiFHQCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiFHQCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:02:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A62258AB;
        Wed,  8 Jun 2022 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JYL5LzwJMvkTknN2K06oEaqVJPOmxsFkjiVJNTycVrw=; b=X+I1FhaXH6WS4+ZGaHmjXumtnF
        hSMv1wP/ojs80wam+20Lk7FXy18+7BcczL5HefwpYesKkTphZ1xvan83qkGvXvbh1X1hcfU4CYk+3
        a8IhuvNpYCyrYbi/279R8dZs9dPVbn7b0rkDGr1JfKpud+bH/f/7KCuDr0VrxNhUfV1UdTGe/Exrp
        bdjE400FzSvqmUVCnGHFO59IlhUWLZPlD33Eh4sWfaa45ILPYlUY7CwO2mDsrpL1ilaXKfGB/Kt0I
        tAKJeNKT5w2M4QSVh/EDJ92w5JF6VHLuksFN5sICMhG7SlEO5/KMmexF9zTbYI2fuNTkUefBjh9O4
        45XHM6Bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyy8m-00CmAT-Km; Wed, 08 Jun 2022 16:02:40 +0000
Date:   Wed, 8 Jun 2022 17:02:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 03/10] ext4: Convert mpage_release_unused_pages() to use
 filemap_get_folios()
Message-ID: <YqDIIH2d7iu1o7D0@casper.infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-4-willy@infradead.org>
 <YqBXjjkRZsP8K8fO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqBXjjkRZsP8K8fO@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 01:02:22AM -0700, Christoph Hellwig wrote:
> On Sun, Jun 05, 2022 at 08:38:47PM +0100, Matthew Wilcox (Oracle) wrote:
> > If the folio is large, it may overlap the beginning or end of the
> > unused range.  If it does, we need to avoid invalidating it.
> 
> It's never going to be larger for ext4, is it?  But either way,
> those precautions looks fine.

I don't want to say "never".  Today, it's not, but if ext4 ever does
gain support for large folios, then this is a precaution it will need
to take.  I'm trying not to leave traps when I do conversions.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
