Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D33B15F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFWIkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWIkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:40:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7116C061574;
        Wed, 23 Jun 2021 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rM2Yp+8Itjz90D0EXjNMSXvd4FeigAopuxmvxgM0gQY=; b=XlkpC2A5OOR2l6x79e+08Mm8OT
        9tWohCTbGn4GV+5+sIvTjLkW8POgOoFdW5IK/lqJtgwDwPIsSRxGOIY6o1PiSyvoofnuk1u7tW9+K
        Ez34DmiuekyOaZ6e0Jd2R2YaegIPowfIwl4ST+E5rnAvzNXhdVPwQvazgcd8mgXdbN9LESJCNsspE
        7Jp+3FlpR0KlX13Bv/0ft0WRSxj9JH0+RqpBoBxiqEInsMqPa6jd54wwNL4+4ZZEamlNtopDB92bH
        sgXS2vhn/7VrQcR4ElYLIBuddMHHOJ8Iv6waBHNmUrNleouDtNmEMrSoDrd1jVooxwrOKHgJv4CyL
        DNyDJ+lg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyNj-00FDev-Gr; Wed, 23 Jun 2021 08:37:18 +0000
Date:   Wed, 23 Jun 2021 10:35:00 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/46] mm/migrate: Add folio_migrate_copy()
Message-ID: <YNLyNJupwcDdj0ZG@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-21-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
>  {
> +	unsigned int i = folio_nr_pages(folio) - 1;
>  
> +	copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
> +	while (i-- > 0) {
> +		cond_resched()a
> +		/* folio_page() handles discontinuities in memmap */
> +		copy_highpage(folio_page(newfolio, i), folio_page(folio, i));
> +	}
> +

What is the advantage of copying backwards here to start with?
