Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8941F4A6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFJAr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 20:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFJAr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 20:47:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8EC05BD1E;
        Tue,  9 Jun 2020 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yKJyUj/3R7RSHXTKevwkAZZndA2cyR/n186sIHxNisA=; b=BigP+aR3UJ1Ba4pnzTnqfWlPgb
        V/ccgh/UtzI/+CVhLnAqMSbTdFKQY/8GAQCXqccuaihFojzckm+oWVLihfulVCiZlSiji8ZiVlMhW
        84ZSmoNDZvVh1wVRyCrdFUoXT5ASQvwy0n+x6AAi0JyqZoiUuhNKSRKh3O8G/2hAizar2xtBbjR/M
        Ynx47HI1faIMqCOftFhYLC8sTl4e9pr97ZmmLH+WtMPzBgRBy/w6xtd/nhM3wacgiUnNjEqG6sjBJ
        Cn+v5bE92gYvPeix22lUQlMHXNl0kQLMMmmAHLzsAy/22gRh9SDjp7J7LISFJpq/v2yUgF8CUSuC9
        pC1Yc1kQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiouH-0003qF-7T; Wed, 10 Jun 2020 00:47:53 +0000
Date:   Tue, 9 Jun 2020 17:47:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: generic_file_buffered_read() now uses
 find_get_pages_contig
Message-ID: <20200610004753.GE19604@bombadil.infradead.org>
References: <20200610001036.3904844-1-kent.overstreet@gmail.com>
 <20200610001036.3904844-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610001036.3904844-3-kent.overstreet@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 08:10:36PM -0400, Kent Overstreet wrote:
> @@ -2275,83 +2287,93 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		struct iov_iter *iter, ssize_t written)
>  {
>  	struct file *filp = iocb->ki_filp;
> +	struct file_ra_state *ra = &filp->f_ra;
>  	struct address_space *mapping = filp->f_mapping;
>  	struct inode *inode = mapping->host;
> -	struct file_ra_state *ra = &filp->f_ra;
>  	size_t orig_count = iov_iter_count(iter);
> -	pgoff_t last_index;
> -	int error = 0;
> +	struct page *pages[64];

That's 512 bytes which seems like a lot of stack space.  Would 16 be
enough to see a significant fraction of the benefit?
