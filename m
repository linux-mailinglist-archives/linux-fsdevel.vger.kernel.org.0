Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B98537AB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiE3Mgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 08:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiE3Mfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 08:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F97CB16
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dFSvQ2p+PYCQYBpVQZ7x7gApgkNJyLuRaXgrYRdhROg=; b=Qc4vcR6+59jwit6jmTm/TVBbDF
        Q+Now18yJlb9I2tQeWyYZxEIu6xZYjCIAMATc21+USERvL9YKLDk5dz+Wrl0r8Dh5LQJRfOKJbOEn
        uDHFI8m5xTgoX0traET9cbYuSIG2Nd14NqMH7hLnrQHhuY5ntSefnoQa61UEq7fgCXj1o1WaAIenF
        9beiDr9MzTGOZJGHVuFwyJ9IgGLmJDY4K6V1H02m6GVyTK3+4UMXl/HxoEs5jjA1y98ogtzeN0HGx
        5Q9EDDbJtIohcL5Mi03F2+Tetg+Seij30a0tUt0mY4kcyEPel7wDBv6pSXXFGL4j9Sk612nTHakhw
        qI8yMDew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvecO-004TDL-QB; Mon, 30 May 2022 12:35:32 +0000
Date:   Mon, 30 May 2022 13:35:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/24] remap_range: Remove check of uptodate flag
Message-ID: <YpS6FHg0Gz7yfQsj@casper.infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-15-willy@infradead.org>
 <YpG6J7BxY3DAGp/0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpG6J7BxY3DAGp/0@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 10:59:03PM -0700, Christoph Hellwig wrote:
> On Fri, May 27, 2022 at 04:50:26PM +0100, Matthew Wilcox (Oracle) wrote:
> > read_mapping_folio() returns an ERR_PTR if the folio is not
> > uptodate, so this check is simply dead code.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> >  /* Read a page's worth of file data into the page cache. */
> >  static struct folio *vfs_dedupe_get_folio(struct file *file, loff_t pos)
> >  {
> > +	return read_mapping_folio(file->f_mapping, pos >> PAGE_SHIFT, file);
> >  }
> 
> But I wonder if this isn't useful enough to go to filemap.c in one form
> or another.

It looks like it should be, but most in-kernel users of
read_mapping_folio() and its friends want to pass NULL for file as they
don't have an open file.

Indeed, this code used to until I realised we actually do have open
files here, so should pass them.  I don't think it affects anything;
the only users who need the struct file are network filesystems, and
nobody does dedupe across the network.  If it's not done transparently
by the server, it's an obvious server offload operation.
