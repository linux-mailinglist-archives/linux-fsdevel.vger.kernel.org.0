Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D673161341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgBQN0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:26:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgBQN0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1g8gUNk4QZmb7qpe3MRgs3En9cghrTnYOXb1h6i0Ozs=; b=CsdmLYjlaqfr0EqLEfYRnKiJhP
        pWnSzFoQnJ8J5UvRzZRX+G66HYFWsdbr7qBCzeKS3YbJaTqEyuPcXGIvM/wFq+7Ut/uhXvyizvHvP
        vVDjeOz6fMPUJIk54s3ccJS11CQtA71624DOqRLNUq5+xlzxiiQ7itTaGLljzFMnSSQgVrI9LcGLC
        /zb4sy5Bn53taswxhaTb1RtfLSYgwuihnLC5dpxhjHURhY90aMPtDYtHE/B9VZV6T1umevGaTD1ub
        zwvG0Ur1qOWcax7mfUGhyjrmDPIDrsk5UTEp2r65Be4OkkpaUBv4iZdSby44qAI+XdkUJf6RpE/6R
        8aVypBvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gPX-0004Yx-6K; Mon, 17 Feb 2020 13:26:07 +0000
Date:   Mon, 17 Feb 2020 05:26:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 3/7] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200217132607.GD14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	int rc;
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	struct page *page = ZERO_PAGE(0);

Nit: I tend to find code easier to read if variable declarations
with assignments are above those without.

Also I don't think we need the page variable here.

> +	rc = pmem_do_write(pmem, page, 0, offset, len);
> +	if (rc > 0)
> +		return -EIO;

pmem_do_write returns a blk_status_t, so the type of rc and the > check
seem odd.  But I think pmem_do_write (and pmem_do_read) might be better
off returning a normal errno anyway.
