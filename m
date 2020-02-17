Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7414F16132E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBQNVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:21:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQNVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D5TyLgd0jRYPWavRlJvo3pOwK15lw15o14H3IXOmbJo=; b=YJpaCvYwPOT6yndq/bHvy9tOdc
        xFrtP5YNz5t64Xkw7PR2QZoAGAjBWPa4DV5et7wKneH3NQYRSWiZBf+fBMjrGz0QpVNvzfgVOpNSy
        EsQZGGrLTq3VqLL6YVQ25nAqEwAn0JNmoXf1YDZbxsJqHYZ12At2Hmr6RAq4iW2CSPIaaZHrWl4SP
        +J7L+M6fegLGJ4kkISoLkQTs2Y8rU1vHT/oa7IJJySp8JgZYTvlvYDQUA3Mnku2L3y1mitg0elIar
        Aq9W4LP7d5Rm7A5F2RwqLHrtcw8tLpneKJZgcH1V/k7V89Mdviz2+1a+42yg20UoUX9FHpxx3ZTkS
        oC0fcrSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gLC-0002Jr-K2; Mon, 17 Feb 2020 13:21:38 +0000
Date:   Mon, 17 Feb 2020 05:21:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 1/7] pmem: Add functions for reading/writing page
 to/from pmem
Message-ID: <20200217132138.GB14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-2-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 03:26:46PM -0500, Vivek Goyal wrote:
> +static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
> +			unsigned int len, unsigned int off, unsigned int op,
> +			sector_t sector)
> +{
> +	if (!op_is_write(op))
> +		return pmem_do_read(pmem, page, off, sector, len);
> +
> +	return pmem_do_write(pmem, page, off, sector, len);

Why not:

	if (op_is_write(op))
		return pmem_do_write(pmem, page, off, sector, len);
	return pmem_do_read(pmem, page, off, sector, len);

that being said I don't see the point of this pmem_do_bvec helper given
that it only has two callers.

The rest looks good to me.

