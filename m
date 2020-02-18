Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44537162B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgBRRKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:10:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgBRRKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FMtS++UxKyfh+g0VsO76i6wRu/DQe7FSEBQsPlMCkME=; b=ErgdrkXZ3+X5SfKFrikmqUXKf3
        HPM9t9RkonupUYNYNEhrORKUT8MPYZNTQOBp9LCQzBIn/lHky+EOAiPFydTPp+VYPpaqT7Mapi7NV
        GmPWyI2UgRprBGCY0cOunBPWOTpbfht7kRvCzMhBH2dAgleAj9Spemp2V4NutFawSAXd8vaN+8Sgk
        L7UUAluxSSxWpPtycv24IW/MRPat084z1jbQ1yU8RZkNS+ZyICtBCN/q/YYyKgA9Khmp9Go2ZZWZW
        c7WNZeEl2hUKmwNDSCo2+72YcgPNOIqxEhXXC/KUXHLBT0S1VGt9ZX6ClrZnznILfN9LFBnBXuPXP
        MTu4Ue2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j46Nq-0000qW-2x; Tue, 18 Feb 2020 17:10:06 +0000
Date:   Tue, 18 Feb 2020 09:10:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v4 3/7] dax, pmem: Add a dax operation
 zero_page_range
Message-ID: <20200218171006.GC30766@infradead.org>
References: <20200217181653.4706-1-vgoyal@redhat.com>
 <20200217181653.4706-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217181653.4706-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
> +				    size_t len)
> +{
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	blk_status_t rc;
> +
> +	rc = pmem_do_write(pmem, ZERO_PAGE(0), 0, offset, len);
> +	return blk_status_to_errno(rc);

No real need for the rc variable here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
