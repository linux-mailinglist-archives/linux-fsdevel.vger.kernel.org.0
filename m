Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E72494A32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359513AbiATI7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359412AbiATI7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:59:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F20C061748;
        Thu, 20 Jan 2022 00:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x4NWNJFPfdMZ6dsxs51T9yAg2PQobfgRFikQN4MZqzY=; b=FHhtYapIjaAV9Yu0e8p4as5cUI
        aLvqiavV/GyFE1ELMqo1eVzTacOs46MHeUg4nb2Mm9oQQ1E4itDmuqNTNgeB78SqXGjFRpiByAjEg
        oxiZOaaVVcXizkwYRFTDzlEFqekvTPbIYz9CYKGt9mC3gqNzcTdWk7GzZjkg48Ej9jmzFJADmE+d0
        k8AkTCFAvI6yiIeDiOqW5Iw5P5mOJK99ga86NjtQWHg2h7ZX9hKoL0jKWewNBECzWIrz60+X698sa
        Ey+kFJZygvziErE+CbCiPZS7GtDtUc86AopRC0sIsNWyjm3lvCHOBbUyD606ZJ46pd/Rtp0Qta0Fw
        fAfkSUYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nATHk-009z93-IJ; Thu, 20 Jan 2022 08:59:12 +0000
Date:   Thu, 20 Jan 2022 00:59:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v9 10/10] fsdax: set a CoW flag when associate reflink
 mappings
Message-ID: <YekkYAJ+QegoDKCJ@infradead.org>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-11-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226143439.3985960-11-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:34:39PM +0800, Shiyang Ruan wrote:
> +#define FS_DAX_MAPPING_COW	1UL
> +
> +#define MAPPING_SET_COW(m)	(m = (struct address_space *)FS_DAX_MAPPING_COW)
> +#define MAPPING_TEST_COW(m)	(((unsigned long)m & FS_DAX_MAPPING_COW) == \
> +					FS_DAX_MAPPING_COW)

These really should be inline functions and probably use lower case
names.

But different question, how does this not conflict with:

#define PAGE_MAPPING_ANON       0x1

in page-flags.h?

Either way I think this flag should move to page-flags.h and be
integrated with the PAGE_MAPPING_FLAGS infrastucture.
