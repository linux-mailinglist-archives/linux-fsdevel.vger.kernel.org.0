Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED53E8EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhHKKdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:33:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48756 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhHKKdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:33:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1ED1221D1;
        Wed, 11 Aug 2021 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0IOg7NR69YsOCPb2F2+XbGSCne9GswMDQ6Ct/w6xk0=;
        b=arNPy9+c9zlxKrC9LXa0fOXS2sQDJzCp4BoJgWZUBkfFO/9rtgdaI9AMh+9R2blC/3uAb/
        QrOxXZ29/Jf67CbQ+6LWDR8iRBWf+g6dqZRdyMiqByVrHEE8RV/Pg0q2U/OMB3Kdm3G++2
        IVUYQ07Y7mAvV0ofM9qGEDyUupaOFv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677965;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h0IOg7NR69YsOCPb2F2+XbGSCne9GswMDQ6Ct/w6xk0=;
        b=VrjbUvhxHK82obxp+Y+Sq9yhmbTdVvXLf12WqiCQH2wlo8kJjryDqpvjwS3evruf3bZfDG
        Ww9ApOH6BXC1/6CQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C03A0131F5;
        Wed, 11 Aug 2021 10:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6QVELk2nE2FREAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 10:32:45 +0000
Subject: Re: [PATCH v14 038/138] mm/memcg: Add folio_memcg() and related
 functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-39-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1eb08e30-3a84-eaae-e9ee-07d59cbde807@suse.cz>
Date:   Wed, 11 Aug 2021 12:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-39-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> memcg information is only stored in the head page, so the memcg
> subsystem needs to assure that all accesses are to the head page.
> The first step is converting page_memcg() to folio_memcg().
> 
> The callers of page_memcg() and PageMemcgKmem() are not yet ready to be
> converted to use folios, so retain them as wrappers around folio_memcg()
> and folio_memcg_kmem().  They will be converted in a later patch set.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Acked-by: Vlastimil Babka <vbabka@suse.cz>


Nit:

> ---
>  include/linux/memcontrol.h | 109 ++++++++++++++++++++++---------------
>  mm/memcontrol.c            |  21 ++++---
>  2 files changed, 77 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bfe5c486f4ad..eabae5874161 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -372,6 +372,7 @@ enum page_memcg_data_flags {
>  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
>  
>  static inline bool PageMemcgKmem(struct page *page);

I think this fwd declaration is no longer needed.

> +static inline bool folio_memcg_kmem(struct folio *folio);
>  
