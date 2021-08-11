Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB73E8D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 11:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhHKJhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 05:37:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbhHKJhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:37:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DA842216B;
        Wed, 11 Aug 2021 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628674632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oztmLtuICT2IcFqFQvVL636C+wIDTuWJpaM9f5ZQmqk=;
        b=tmiq9qvhwgTXYYZnvnaSIxsg0080TOI5DY19EdXEcyPVyKRvlLO4OBY+2SchQjmo0PzfVO
        zlZ9erIV/2ibLI99Bpn59hWqoVz8naUfP60ln3OAyHEutXr2rA1aesXBcybZyynHLZsBuX
        E3tHpwLkogWx+mFk4MwGkl6evJCaukY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628674632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oztmLtuICT2IcFqFQvVL636C+wIDTuWJpaM9f5ZQmqk=;
        b=/rKQsLcr/EBM5ESYsZiuxRFtkApWDIU9g50whbbHHtMIKWMyl+gMT/d3twpwpiRoghBqu4
        c1bnHPiE2KhnP9AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F0B18136D9;
        Wed, 11 Aug 2021 09:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Cs55N0eaE2HlAgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 09:37:11 +0000
Subject: Re: [PATCH v14 033/138] mm: Add folio_nid()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-34-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6a31a92c-0de7-bd96-f179-537f3a68b67b@suse.cz>
Date:   Wed, 11 Aug 2021 11:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-34-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_to_nid().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8b79d9dfa6cb..c6e2a1682a6d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1428,6 +1428,11 @@ static inline int page_to_nid(const struct page *page)
>  }
>  #endif
>  
> +static inline int folio_nid(const struct folio *folio)
> +{
> +	return page_to_nid(&folio->page);
> +}
> +
>  #ifdef CONFIG_NUMA_BALANCING
>  static inline int cpu_pid_to_cpupid(int cpu, int pid)
>  {
> 

