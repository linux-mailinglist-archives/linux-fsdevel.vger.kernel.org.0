Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613BE3B16DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFWJc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFWJcy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:32:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3295C061574;
        Wed, 23 Jun 2021 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NU7eentD395rdHeDZnxtO6t94JfTEFM9vaCy6vjeiLE=; b=TpyRcfJAQcJETLpJhvymhsCd9K
        lmpYZgQoE+WXW7WlWJSdxAyarKrD/3Mh3ZqcJmy2ApK1wEwpJ4uYUYNpmc8fJxlpw7DyQMpis76YI
        BH5hnix8ZqRL/sL1wtXPr/CKDmbTd7vjwv2Hzm52mlcNX6YS+u4m74YbmPd4Sftpe8vReBEZJQvzt
        3fQ353Kpzakay+T+ZTY18CZdQZzV318cCqwAGaE/d5dldyX0bIawT+DVdAU187PMSqLo6wB/du6uH
        oWPmXJfHPeH77er7UQ3jFafrVNpMLU1AaX5cyJbCHmDynATXHZnyh92L8LF1pe297SFEjGbd48HkZ
        KRXJtKuQ==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzCE-00FGQZ-TG; Wed, 23 Jun 2021 09:29:27 +0000
Date:   Wed, 23 Jun 2021 11:27:12 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 27/46] mm/writeback: Add __folio_mark_dirty()
Message-ID: <YNL+cHDPMfvvXMUh@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-28-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-28-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:32PM +0100, Matthew Wilcox (Oracle) wrote:
> Turn __set_page_dirty() into a wrapper around __folio_mark_dirty() (which
> can directly cast from page to folio because we know that set_page_dirty()
> calls filesystems with the head page).  Convert account_page_dirtied()
> into folio_account_dirtied() and account the number of pages in the folio.

Is it really worth micro-optimizing a transitional function like that?
I'd rather eat the overhead of the compound_page() call over adding hacky
casts like this.
