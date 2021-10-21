Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04B43603A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhJULbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJULbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:31:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B1FC061749;
        Thu, 21 Oct 2021 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/qf9x5zobmso29yEG7gFdwTwQzI2ArNVYsHjq8xdPdM=; b=QEUb546e9a6j/h8xSaw5S+nPTM
        clDEVIF+Obeqijj3acOBmpGzHzgbnC/MuFS2rJjaB5oa0zPCX0xNqHmyas6Mr/McBnx1aO5CXrNDp
        nTN1mY9QIkkr8rPcmWRVltUZX45nupW1prRUAjGSkouoWLMvfxL1JvwbgqtVb/kk3xcaRAKTgyMEF
        ou0plgdinyMhbp60EjG3WK2/BVD9ahRP/cKVFutEnXlqHZMAmjjntkj9vLYlS5SHz6MLAICwS7XZM
        6YLmN94o+TNWA529d87QXqv6gssX8XzCu8fV4DsLFTuPtiN1KUL/+qqY9awRIPucYbI+EmI/MoeV9
        ydmJsYWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdWFe-007Lv7-EG; Thu, 21 Oct 2021 11:28:50 +0000
Date:   Thu, 21 Oct 2021 04:28:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/6] dax,pmem: Add data recovery feature to
 pmem_copy_to/from_iter()
Message-ID: <YXFO8uCgIDoIqTgC@infradead.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-6-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021001059.438843-6-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (flags & DAXDEV_F_RECOVERY) {
> +		lead_off = (unsigned long)addr & ~PAGE_MASK;
> +		len = PFN_PHYS(PFN_UP(lead_off + bytes));
> +		if (is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, len)) {
> +			if (lead_off || !(PAGE_ALIGNED(bytes))) {
> +				dev_warn(dev, "Found poison, but addr(%p) and/or bytes(%#lx) not page aligned\n",
> +					addr, bytes);
> +				return (size_t) -EIO;
> +			}
> +			pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
> +			if (pmem_clear_poison(pmem, pmem_off, bytes) !=
> +					BLK_STS_OK)
> +				return (size_t) -EIO;
> +		}

Shouldn't this just go down in a separe ->clear_poison operation
to make the whole thing a little easier to follow?
