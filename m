Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD8266314
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgIKQKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgIKPnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252FC061349;
        Fri, 11 Sep 2020 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hY9rmfrv8UCuGHdrvMA74LoUacs54okGTn77tgIOUTg=; b=gjqxNSJhTHRI78NdQ0N+CiZ7aa
        8XuuMyP7Bup4JqKaiohZzpS/aPpZM7QZkyein2/NrRK0U9Bcmz1TmQNJ6ED+ISDuwZqx0HnpHlHOz
        UgsO1nXNSRG1za4KU+Tyk+jvpcP6rCyQckymDzhVTdIMTlmSEgxU+SMybyflZAAx23QdXsOiKJGfz
        DXjjudLlTaQyNREvphjeGK3/Xr+BA3qlfnw4TzAf98OWkVo+j1xC5DuWcmchf74jlMBVLo3XRFIjv
        b/WKmmWiS1cNVGowM8BsmHFcuOKZZoWRJ4DHSX0sMiYRdTOY6Lf0bcwtP49bBeZQvLLkgVU6DVWV0
        M32EEAEg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGjrb-0004AW-9r; Fri, 11 Sep 2020 14:17:19 +0000
Date:   Fri, 11 Sep 2020 15:17:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 19/39] btrfs: limit bio size under max_zone_append_size
Message-ID: <20200911141719.GA15317@infradead.org>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200911123259.3782926-20-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911123259.3782926-20-naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 09:32:39PM +0900, Naohiro Aota wrote:
> +		if (fs_info->max_zone_append_size &&
> +		    bio_op(bio) == REQ_OP_WRITE &&
> +		    bio->bi_iter.bi_size + size > fs_info->max_zone_append_size)
> +			can_merge = false;
> +
>  		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
>  		    force_bio_submit ||
>  		    bio_add_page(bio, page, page_size, pg_offset) < page_size) {

For zoned devices you need to use bio_add_hw_page instead of so that all
the hardware restrictions are applied.  bio_add_hw_page asso gets the
lenght limited passed as the last parameter so we won't need a separate
check.
