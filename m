Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFE4153832
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgBESd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:33:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBESd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kCaUjwxLyxoE0RNdCEgG1o8G9nXdq6WoXoKYNVIpnOU=; b=t0EF1vH+aRuezWyirREnxroEMA
        jYT3bxspZ8xkSTUYIFlkrCGH7qk9Pg8rlegbclD4rrMV/XOZeZYJ5hk6tLJ8cgGirnpUSq3eCTRUJ
        1p3YvGIWyg3pp15kIBp7S9+rIAx5x1fpGBsHHY6DyqyTbWRRgK5yIhFK+Iq1tUUWSQbpYXwewlp2s
        AoJpkGZRpVExG6cMS0G0Mob+SSN1US1s8ZuFyYtSPn+inYKk0TnN1CWkd5phBy3Oo8UM27QjVKCnt
        qfhX7WO0XCfJeeusaBtC+XWDC2R/R2BbJmRljxw5Dr0XCfoPmj1e0eVPRrJ9tTTM77R1mx9tqtK+0
        zo9YuEfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izPUq-0001ds-4s; Wed, 05 Feb 2020 18:33:56 +0000
Date:   Wed, 5 Feb 2020 10:33:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com
Subject: Re: [PATCH 4/5] dax,iomap: Start using dax native zero_page_range()
Message-ID: <20200205183356.GD26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-5-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-5-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 03:00:28PM -0500, Vivek Goyal wrote:
> +	id = dax_read_lock();
> +	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> +	dax_read_unlock(id);
> +	return rc;

Is there a good reason not to move the locking into dax_zero_page_range?
