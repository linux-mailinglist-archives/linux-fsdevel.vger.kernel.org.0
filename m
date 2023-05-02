Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80BD6F4721
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjEBP1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjEBP1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 11:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFD3583
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683041189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akPo+KEGYmrPGo7TbxAq62xUrfsEw0cvTEcJNIXnSOo=;
        b=g/dVx99phXVAY/BUsdDoMecwGnxjGxYhZv8qdpmEsgDnDJ5vR3PoVjh/tDEhWEh4SpWB37
        5khr5DFarGkRgBCHoW2VoOOXieNYJkATdw9+ayERluXDNyxppUKudwqZQHDomqoQ7dkEiB
        r2ttXBQfiTDYhKwQ+IniUqHL3DSFlbI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-5gyCgZEoOs2dN84QMOD94A-1; Tue, 02 May 2023 11:26:27 -0400
X-MC-Unique: 5gyCgZEoOs2dN84QMOD94A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef67855124so6542546d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 08:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683041187; x=1685633187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akPo+KEGYmrPGo7TbxAq62xUrfsEw0cvTEcJNIXnSOo=;
        b=h4eE/4KqzxG0KKVe3ZearWne+HuB8uImzSS0EI3vK2gVsUlgBPZ7yh5Y2MRa4+ly7e
         1cPqLAOoJaK9wM/MSXdAqPH0GDGXT/EzfYFhSm3TkbiLvwlV8Yf9SLOFRAfueK/2o10x
         H7Jwl35M76o6VZl5HewsbIbq2o5qhGjhbio8MbF9UMPZGCgLC+Vg/bJjr4JSXGVWhfCK
         8UycQSSwNBNConH/1ikbIc358QSR56Zu+UG4WJ78G9K+Suvya7vfE2KyfS5kgH3UCgSw
         nA/PI4rlItrmQsImO7ta3zgwofWVxSXj6xGheRhzabM69JQEC5LaVLz0EH6jLF0jMe1+
         Tm3g==
X-Gm-Message-State: AC+VfDyN/9OpAP51ARvGhfSPq34p/l429H/qr4UoaBU6D5VaqLVhd10K
        qJhT5xeHMTIxZCbzV2nXjj7OKI0RkBPsuluN4+KQt4LmLiLDxsd27CS4lmr9Mt6RLszuI1tPV5B
        3woMcEXaEVzEAzk2oobQ+TalWwA==
X-Received: by 2002:ad4:5fcf:0:b0:61b:6b8e:16e0 with SMTP id jq15-20020ad45fcf000000b0061b6b8e16e0mr2257108qvb.1.1683041187455;
        Tue, 02 May 2023 08:26:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7JHOpeTuTrkxkrIFVKlTemcyqHPBbWZl+er1BpBHHrIGnRkOX888+uNoF/CwVWZpV2ykDgEQ==
X-Received: by 2002:ad4:5fcf:0:b0:61b:6b8e:16e0 with SMTP id jq15-20020ad45fcf000000b0061b6b8e16e0mr2257084qvb.1.1683041187220;
        Tue, 02 May 2023 08:26:27 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id u16-20020a0cf1d0000000b005ef42464646sm9585700qvl.118.2023.05.02.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:26:26 -0700 (PDT)
Date:   Tue, 2 May 2023 11:26:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Message-ID: <ZFErn2Hl3mWiIudD@x1n>
References: <20230428124140.30166-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230428124140.30166-1-jack@suse.cz>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:41:40PM +0200, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).
> 
> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  mm/vmscan.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> This was the non-controversial part of my series [1] dealing with pinned pages
> in filesystems. It is already a win as it avoids crashes in the filesystem and
> we can drop workarounds for this in ext4. Can we merge it please?
> 
> [1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bf3eedf0209c..401a379ea99a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			}
>  		}
>  
> +		/*
> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> +		 * No point in trying to reclaim folio if it is pinned.
> +		 * Furthermore we don't want to reclaim underlying fs metadata
> +		 * if the folio is pinned and thus potentially modified by the
> +		 * pinning process as that may upset the filesystem.
> +		 */
> +		if (folio_maybe_dma_pinned(folio))
> +			goto activate_locked;
> +
>  		mapping = folio_mapping(folio);
>  		if (folio_test_dirty(folio)) {
>  			/*
> -- 
> 2.35.3
> 
> 

IIUC we have similar handling for anon (feb889fb40fafc).  Should we merge
the two sites and just move the check earlier?  Thanks,

-- 
Peter Xu

