Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948174F5688
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 08:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiDFGYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 02:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386973AbiDFGTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:19:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C161B757E;
        Tue,  5 Apr 2022 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xkKN41eLVrIheZpH/2SH1i+aJL00RRx4irbbX94rx9Q=; b=Q/3lDXWd19Mt0b3/k3Rb7zcP5h
        p5Eze/s2YucUMuPYsP3/q20TplDhpywYDITWcq7DW8bCL9f9peotPecyp39tdZIQ1ExUkalAybXyS
        Sxt54IpLbAnxVjk06D6a2NNMvqpMHsxgMeosQjblK8oh9AW6ILrD0OEcrPhOIK4bCqie2ImxZgB4X
        gS/zqX5LtXLSyVWRgAmLMMXXDrccEDWzqicolNHUqaDXH8PiWuHSYpqXNQ8jCr6Cn3U5UgMr7P2gH
        bzB3VhlCqf6aRtj6S9vDNsm1YM8SxrSXMJeCnnlVBFrEDH/mbtk/QwMI4mI6duvxeYNJiTCqNnT1B
        dCRczSmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nby6y-003oOR-F6; Wed, 06 Apr 2022 05:21:44 +0000
Date:   Tue, 5 Apr 2022 22:21:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v7 6/6] pmem: implement pmem_recovery_write()
Message-ID: <Yk0jaC9rHwwoEV11@infradead.org>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-7-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405194747.2386619-7-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:47:47PM -0600, Jane Chu wrote:
> +	off = (unsigned long)addr & ~PAGE_MASK;

offset_inpage()

> +	if (off || !(PAGE_ALIGNED(bytes))) {

No need for the inner braces.

> +	mutex_lock(&pmem->recovery_lock);
> +	pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
> +	cleared = __pmem_clear_poison(pmem, pmem_off, len);
> +	if (cleared > 0 && cleared < len) {
> +		dev_warn(dev, "poison cleared only %ld out of %lu\n",
> +			cleared, len);
> +		mutex_unlock(&pmem->recovery_lock);
> +		return 0;
> +	} else if (cleared < 0) {

No need for an else after a return.
