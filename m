Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC191613A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgBQNhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:37:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQNhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6JduFHaGXL6ZuUJZD2z7J2KoISh0UFSCSqAsPWSzYK8=; b=WcToiemT9OwiY1JVONw87kYRgg
        X5bvNrZQCaBXL0cJztVNL6JdmzJgQQ0Kx2v1BzlHKuy2ZGQNS9dLRCgp/Y81iiX1BUJhj/TndRTS0
        lgq/rcNlgk8h4ez5IDuX1CgYpr6OShWYd6vHS+LXIdkL9x1h7RMrD8shn20i+ophyXl98cosFpBxq
        CLlCtncouXaYUGS4wIwPozUAjCWkJv0fmjsb6Hm3PffYgmgsEb1v7+CktaJ+PR3ydgoPRUxYKkpna
        rQutu0bPqSZujsZtAInJ26K+UEP3OlzqAZSHSfiiav5faBiiG49Jh69tU77ZxfEJ4h+M28XS147F+
        xtm/+fgg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gap-0002YG-Fr; Mon, 17 Feb 2020 13:37:47 +0000
Date:   Mon, 17 Feb 2020 05:37:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 1/6] dax: Define a helper dax_pgoff() which takes in
 dax_offset as argument
Message-ID: <20200217133747.GJ7778@bombadil.infradead.org>
References: <20200212170733.8092-1-vgoyal@redhat.com>
 <20200212170733.8092-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212170733.8092-2-vgoyal@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:07:28PM -0500, Vivek Goyal wrote:
> +int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t *pgoff)
> +{
> +	phys_addr_t phys_off = (dax_offset + sector) * 512;
> +
> +	if (pgoff)
> +		*pgoff = PHYS_PFN(phys_off);
> +	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> +		return -EINVAL;
> +	return 0;

This is why we have IS_ERR_VALUE().  Just make this function return
a pgoff_t.

