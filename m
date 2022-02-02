Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851F04A7188
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbiBBN2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 08:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiBBN2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:28:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2DC061714;
        Wed,  2 Feb 2022 05:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=boWCh/TpB/hF6hHIYdPbSg9gi1vDgJSVOPq/YXLBkx0=; b=g7uXtL49FabQfLRSKLgpHDcLNC
        Ue6aGEFhdOITM3CLsE/wEj3iL/JS7TZmyNv9aM4zQ6U4K0V1ydNWEzhiixve4eYlqJywuSN9v8mA2
        98KEy2q1dxfv1EjRnWbTODJstiqSRgTWL4NTF19f6plAFMfAtQx1aydgcdSnljILR5CxuV90btndL
        YMLhJqvGXBje3oOblaDqkJuIiBHB8a+2lT1jKGVLz/k+YBxHw8FASF86IpXrR3kS1kfEIzKn/lDlS
        oO3j098NMb3ES/bR3VlShxrmFYIOHhuPQcU4DPCKvuk9N8/0utMU/dVYQyHwWUSeC+AgvE+CfuSMj
        KJIv8E3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFFgh-00FM5N-4U; Wed, 02 Feb 2022 13:28:43 +0000
Date:   Wed, 2 Feb 2022 05:28:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 7/7] pmem: fix pmem_do_write() avoid writing to 'np'
 page
Message-ID: <YfqHC8zpPlyWhVkj@infradead.org>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-8-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128213150.1333552-8-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:31:50PM -0700, Jane Chu wrote:
> +	if (!bad_pmem) {
>  		write_pmem(pmem_addr, page, page_off, len);
> +	} else {
> +		rc = pmem_clear_poison(pmem, pmem_off, len);
> +		if (rc == BLK_STS_OK)
> +			write_pmem(pmem_addr, page, page_off, len);
> +		else
> +			pr_warn("%s: failed to clear poison\n",
> +				__func__);

This warning probably needs ratelimiting.

Also this flow looks a little odd.  I'd redo the whole function with a
clear bad_mem case:

	if (unlikely(is_bad_pmem(&pmem->bb, sector, len))) {
		blk_status_t rc = pmem_clear_poison(pmem, pmem_off, len);

		if (rc != BLK_STS_OK) {
			pr_warn("%s: failed to clear poison\n", __func__);
			return rc;
		}
	}
	flush_dcache_page(page);
	write_pmem(pmem_addr, page, page_off, len);
	return BLK_STS_OK;

