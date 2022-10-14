Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6056A5FE78C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 05:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJNDYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 23:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJNDYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:24:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D2BE5EE3;
        Thu, 13 Oct 2022 20:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k1olnhMeFRc72L34mxBEB4SzA8A37natGttf+ivr3P4=; b=YBejHR2p9R8AVJoQ/S7beTojDp
        0d+esxsc8ZK7xqQTD4QbhTESxcj7VXIwDujaglOJLMkptWIeop5ac2Pa5FxuV2AIIshJY2C68FCh7
        BgOGJSzIsdkTC/6bsf/n6xKXCgPZKk5135ZBUzbGKjt9kKBjj+NVrS3TGDoSDlWbCIN/qReKCRwtl
        skoEc7VZVWUEuGlbDBYURd4rEhiiJjUG9GI6eCaw1sRicXqr5fXmFMuH7rrxIPLOd6o0DlGJy3fJ9
        5IbUIdFOT219fqArZJOlXSm9wTSFAEeWYUZ1NKN1bAxTAr0WFiXGT1oSSGtorOuab5iYsQCafznfr
        srem/QdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojBIn-007IgQ-Ms; Fri, 14 Oct 2022 03:24:01 +0000
Date:   Fri, 14 Oct 2022 04:24:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] filemap: find_lock_entries() now updates start
 offset
Message-ID: <Y0jWUSLY1aiVWDIb@casper.infradead.org>
References: <20221013225708.1879-1-vishal.moola@gmail.com>
 <20221013225708.1879-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013225708.1879-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:57:07PM -0700, Vishal Moola (Oracle) wrote:
> Initially, find_lock_entries() was being passed in the start offset as a
> value. That left the calculation of the offset to the callers. This led
> to complexity in the callers trying to keep track of the index.
> 
> Now find_lock_entires() takes in a pointer to the start offset and

s/entires/entries/

> updates the value to be directly after the last entry found. If no entry is
> found, the offset is not changed. This gets rid of multiple hacky
> calculations that kept track of the start offset.

> @@ -2120,8 +2120,17 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
>  put:
>  		folio_put(folio);
>  	}
> -	rcu_read_unlock();
>  
> +	if (folio_batch_count(fbatch)) {
> +		unsigned long nr = 1;
> +		int idx = folio_batch_count(fbatch) - 1;
> +
> +		folio = fbatch->folios[idx];
> +		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
> +			nr = folio_nr_pages(folio);
> +		*start = indices[idx] + nr;
> +	}
> +	rcu_read_unlock();
>  	return folio_batch_count(fbatch);

Do we need to move the rcu_read_unlock()?  Pretty sure we can do all
these calculations without it.

This all looks good.  It's certainly more ergonomic to use.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
