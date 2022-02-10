Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8164B0DAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 13:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiBJMms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 07:42:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiBJMmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE168F48
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 04:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644496968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgQcVzLNWYJ+JyGFAxDUrE58df6OIoPYGbPcVt2vLDw=;
        b=HPRRaEJUk07bcuhHpbIWB4gGYt4qZv8V2ax1pronYYFcH2CvzI1t7tPgIvXK30TQbS76Nl
        WLcp6LFkBWC5KDxO6c/d+lZISfToj6IlVzYQAjNSxtXioXVM2TBLEHZIxKX/a3Crp1K+3N
        DJhSNAoddb34SUpevCXvIBbWfr2Hif4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-svdgTRluPbWwjkYBXBlw8g-1; Thu, 10 Feb 2022 07:42:46 -0500
X-MC-Unique: svdgTRluPbWwjkYBXBlw8g-1
Received: by mail-qk1-f198.google.com with SMTP id u12-20020a05620a0c4c00b00475a9324977so3501949qki.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 04:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CgQcVzLNWYJ+JyGFAxDUrE58df6OIoPYGbPcVt2vLDw=;
        b=rjXHbRVAi+OeGneklYgwLIV2kyffsZGgkMKoHIi1lM41xQKX16yn6rDNfwPnhJ61WW
         1hQ1RdQrV1RHs+qTIgwhxpnBZXUqcyo4SpiI6uQb4yOdSGSoW4E5xa2EZP96RDEQ33ON
         ON6TnaHibFmmsujS/LtSNjBKBibMUviYMcU9x4dEhS5C6ajwuFS87bGzvATi/GA7ny5y
         akNcIdLyyXGSoPU1cagUaB5yQOP6c0TWV9A/GCeyhaYOR3gK2g5X1HIrsEErB8FzwKaA
         oL178SehuiDlVmGRqYQc0Q/CPoSQ8XaDh+n75bYQTg5huF8CmyXleixT3RyM+w4oSBDW
         TGSg==
X-Gm-Message-State: AOAM533ROaOL8cnc4BJ4oEBUKPSb7D2+v3rN5eWgXwTRVAblupr6UgWC
        Vx+ummyVPyAVcZGzmWmp8CutMy/9OmCdXNwF55WlaLnP2hs8EyuYkyJTXZA3/hPpkNHiisU5QT9
        2zo3F0gbYxnhdw5eIor6x11Eyeg==
X-Received: by 2002:a05:622a:190a:: with SMTP id w10mr4549845qtc.67.1644496966429;
        Thu, 10 Feb 2022 04:42:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSxh3ShHHlbmn68/LGs1Zzqz20RE7S3tXG8aJ8X1zW8qjDxf3r3MDA5nqaoEMyB1d4Pvao0Q==
X-Received: by 2002:a05:622a:190a:: with SMTP id w10mr4549835qtc.67.1644496966219;
        Thu, 10 Feb 2022 04:42:46 -0800 (PST)
Received: from ?IPV6:2601:883:c200:210:6ae9:ce2:24c9:b87b? ([2601:883:c200:210:6ae9:ce2:24c9:b87b])
        by smtp.gmail.com with ESMTPSA id g24sm9771344qkk.76.2022.02.10.04.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 04:42:45 -0800 (PST)
Message-ID: <87a0526f-7904-fe48-6896-4c72bbbe1c27@redhat.com>
Date:   Thu, 10 Feb 2022 07:42:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 26/56] gfs2: Convert invalidatepage to invalidate_folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20220209202215.2055748-1-willy@infradead.org>
 <20220209202215.2055748-27-willy@infradead.org>
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20220209202215.2055748-27-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/22 3:21 PM, Matthew Wilcox (Oracle) wrote:
> This is a straightforward conversion.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/gfs2/aops.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 3d54e6101ed1..119cb38d99a7 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -672,22 +672,23 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
>   	unlock_buffer(bh);
>   }
>   
> -static void gfs2_invalidatepage(struct page *page, unsigned int offset,
> -				unsigned int length)
> +static void gfs2_invalidate_folio(struct folio *folio, size_t offset,
> +				size_t length)
>   {
> -	struct gfs2_sbd *sdp = GFS2_SB(page->mapping->host);
> -	unsigned int stop = offset + length;
> -	int partial_page = (offset || length < PAGE_SIZE);
> +	struct gfs2_sbd *sdp = GFS2_SB(folio->mapping->host);
> +	size_t stop = offset + length;
> +	int partial_page = (offset || length < folio_size(folio));
>   	struct buffer_head *bh, *head;
>   	unsigned long pos = 0;
>   
> -	BUG_ON(!PageLocked(page));
> +	BUG_ON(!folio_test_locked(folio));
>   	if (!partial_page)
> -		ClearPageChecked(page);
> -	if (!page_has_buffers(page))
> +		folio_clear_checked(folio);
> +	head = folio_buffers(folio);
> +	if (!head)
>   		goto out;
>   
> -	bh = head = page_buffers(page);
> +	bh = head;
>   	do {
>   		if (pos + bh->b_size > stop)
>   			return;
> @@ -699,7 +700,7 @@ static void gfs2_invalidatepage(struct page *page, unsigned int offset,
>   	} while (bh != head);
>   out:
>   	if (!partial_page)
> -		try_to_release_page(page, 0);
> +		filemap_release_folio(folio, 0);
>   }
>   
>   /**
> @@ -796,7 +797,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
>   	.readahead = gfs2_readahead,
>   	.set_page_dirty = jdata_set_page_dirty,
>   	.bmap = gfs2_bmap,
> -	.invalidatepage = gfs2_invalidatepage,
> +	.invalidate_folio = gfs2_invalidate_folio,
>   	.releasepage = gfs2_releasepage,
>   	.is_partially_uptodate = block_is_partially_uptodate,
>   	.error_remove_page = generic_error_remove_page,
The gfs2 portion looks okay.

Reviewed-by: Bob Peterson <rpeterso@redhat.com>

Regards,

Bob Peterson

