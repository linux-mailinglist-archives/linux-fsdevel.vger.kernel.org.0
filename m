Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5209D320388
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 04:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBTDjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 22:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhBTDjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 22:39:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6577CC061574;
        Fri, 19 Feb 2021 19:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BVvSTy4Ph1YhvWKdzvOR3CYS1ZzHodAH4zck7F/I9So=; b=iOuAFPLXlVR9yXhHEn49dj0XHV
        34VeudUAA30kub6pjTR/kgAfiVwLgagCpSxGgR+KlhRTUSVexeBMW9vEuEYZ41FFw0BsCfebZ0/CS
        TwnqgYlyUGbiXF2tcEL5VRe5BmmoMJnkYeQ/iBAVvj2Iug9g9GYRPDkw2sGUncVjHFqv4h0AnzxEx
        Rq6AUYa0+Oqeyk0qr8Vg5huuZ7u0WW4qACGFntkRXtRsNDW/QyhRVq4DTxThQ4Cr1myiWVwyb25HA
        jr96yA9BRwHIjkVj255aEi0j+QB7ZvVfCU+ppB8E+FFvIQvYe6Vd23S42bCRbskvayo3M+Z90Nwih
        EVofeSww==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDJ4P-003aOy-38; Sat, 20 Feb 2021 03:36:48 +0000
Date:   Sat, 20 Feb 2021 03:36:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     SelvaKumar S <selvakuma.s1@samsung.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        damien.lemoal@wdc.com, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, snitzer@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v5 3/4] nvme: add simple copy support
Message-ID: <20210220033637.GA2858050@casper.infradead.org>
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98@epcas5p2.samsung.com>
 <20210219124517.79359-4-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219124517.79359-4-selvakuma.s1@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:15:16PM +0530, SelvaKumar S wrote:
> +	struct nvme_copy_range *range = NULL;
[...]
> +	range = kmalloc_array(nr_range, sizeof(*range),
> +			GFP_ATOMIC | __GFP_NOWARN);
[...]
> +	req->special_vec.bv_page = virt_to_page(range);
> +	req->special_vec.bv_offset = offset_in_page(range);
> +	req->special_vec.bv_len = sizeof(*range) * nr_range;
[...]
> +struct nvme_copy_range {
> +	__le64			rsvd0;
> +	__le64			slba;
> +	__le16			nlb;
> +	__le16			rsvd18;
> +	__le32			rsvd20;
> +	__le32			eilbrt;
> +	__le16			elbat;
> +	__le16			elbatm;
> +};

so ... at 32 bytes, you can get 128 per 4kB page.  What happens if you
try to send down a command that attempts to copy 129 ranges?
