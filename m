Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD68536AFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiE1F7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiE1F7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:59:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE22A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=smPADnsVR5YDwQtqHwKgF9tayL1Q4tQ+CZz+VEL3i4U=; b=Gdj0VhFRWnWj2dvIQlRscq5VNW
        7dMJpkOiPCj39OFBDuSEqU1TqDuM1u0Xht8UIG77Y98yLLA9JZa9vq4M6t1C98nTHcXecaqqhCtjd
        6ZxGQc0BbitqxRdgadkEG4L88vQkGtApLEhCI53sSS8/bYMbyMYS+HFMOFaTkg7Jd1eMI65BuhItm
        +ovfNUff5wd4XwY2lGuDAtN8Ei6GryN3DVhhv8V+fdyS+Vh4m9jMg2JiAJYWjeZPv4V0JO7e/yI4d
        xVjySOa26twfLzcdJrboKt4fJhbfSLNLc0UxjbAvpKhUQKOucSIS1V93il0yu2iobt21eu0/9XoFy
        /04nmbvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupTb-001Wa2-RW; Sat, 28 May 2022 05:59:03 +0000
Date:   Fri, 27 May 2022 22:59:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/24] remap_range: Remove check of uptodate flag
Message-ID: <YpG6J7BxY3DAGp/0@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:26PM +0100, Matthew Wilcox (Oracle) wrote:
> read_mapping_folio() returns an ERR_PTR if the folio is not
> uptodate, so this check is simply dead code.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

>  /* Read a page's worth of file data into the page cache. */
>  static struct folio *vfs_dedupe_get_folio(struct file *file, loff_t pos)
>  {
> +	return read_mapping_folio(file->f_mapping, pos >> PAGE_SHIFT, file);
>  }

But I wonder if this isn't useful enough to go to filemap.c in one form
or another.
