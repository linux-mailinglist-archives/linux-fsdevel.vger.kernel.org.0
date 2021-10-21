Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9497436017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJULWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhJULWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:22:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B98C06161C;
        Thu, 21 Oct 2021 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M0rGryBEzzZjhmAi4X1KijO5IeZtO8wnm5ufeDUGYIk=; b=2Mms4J2lVeSKufy9yFdNswsyye
        2AsR+X5xVhPSAi4aQpIQzgqxqGKeFtYax7tGSuQdJYJ/PR+xx1yvJi4ILRyRtXv7ry23EP6KldqOg
        ZIB64KTzT/lvLK5e0PlfnobqN6k/btromer+WlPZYlJ2npvVSW7EuolY10LqykgCiwde7h8hyQAPT
        QPaK0aF8zEI9kA4z5vXtj21xafnTWI9MqGVHhSbu5gaukRQWUz3lqq7R89p1VJHZXVDvIPBvmxMQW
        kSny0vZxrtKEVnvfMAN1BJxmfDOTPg1GdYDe1q8RzhhEhaNRunhxb8O3axpkEZkInEeGGIPzHvN5q
        utXpNR6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdW7H-007KJP-3a; Thu, 21 Oct 2021 11:20:11 +0000
Date:   Thu, 21 Oct 2021 04:20:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] dax: prepare dax_direct_access() API with
 DAXDEV_F_RECOVERY flag
Message-ID: <YXFM64mFLN8dagrY@infradead.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <20211021001059.438843-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021001059.438843-3-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 06:10:55PM -0600, Jane Chu wrote:
> @@ -156,8 +156,8 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>  	}
>  
>  	id = dax_read_lock();
> -	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
> -	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
> +	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn, 0);
> +	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn, 0);

FYI, I have a series killing this code.  But either way please avoid
these overly long lines.

>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> -		void **kaddr, pfn_t *pfn)
> +		void **kaddr, pfn_t *pfn, unsigned long flags)

API design: I'd usually expect flags before output paramters.
