Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62B5662F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 08:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiGEGLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 02:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEGLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6100F2BC4
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657001489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHsZpO8jdgHqT5SmUpNg14nO4ITXQI6OxQXT89xNPRM=;
        b=aMs9S7LwOi+uRXAq3aTsAMnH6Zu9duT0ffv5o/1FJI8l6Tn5eXohWAmCKdqy1mc2CuC5E4
        c4FHcToqofQTSk3M0x5v4PU+T1zdJ35Qqdz0ff2pdXSvUN1YVXmNi9ipoyeAjgDb8pX1FD
        V5ytENJMy1+H5sU/sY4Cr1zVjhGnsns=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-DK_dPcGwPEmSlz6vymIacw-1; Tue, 05 Jul 2022 02:11:27 -0400
X-MC-Unique: DK_dPcGwPEmSlz6vymIacw-1
Received: by mail-pg1-f200.google.com with SMTP id 189-20020a6309c6000000b0041249d53b04so1354324pgj.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jul 2022 23:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QHsZpO8jdgHqT5SmUpNg14nO4ITXQI6OxQXT89xNPRM=;
        b=GwjFDA598bnKluijpcnPOUXn1wWb4FGok43/UN/M2KIgJWIcAgR59KExz0/vnzrf0+
         6qbT/i3hI7qDqEdE4iVrlJpj5xw/ZIjm3PHioY0oHJ+qdAEhVWLDwpw+4ftiLJzP40yK
         N+7Efsh69+v6C/xWEb7FFy28w1ErPbUXU/22i09Mg76jYa6XKh+fKPD5ZVa1zgVD/KfD
         B5jXrV1c+Cpi1+4ljcrzLkrRqF+JFYrpWOyeNwBPcZJdlOw1UVXo9FrMciVbrXkZl75z
         Zi2GPDoU+4IsNVZydjS9O9kedq024/5Q9uDE2dFFmdRamPnKUUgIdFrzE17IUJ6iyWWs
         aNDA==
X-Gm-Message-State: AJIora8yyXtFNySn/qr1fxmsIyWgb1vKZYBjGvxFc+glYYYbAlZtDswW
        AwyyxlDxvFNJalhi8Y4I7MhQQUqK32jDfe9N6bVb9zun+1AUhGZc/gnp5D8c9AYs6irtlV4s138
        hWoMoWDSCrAr93ZjRb/sUmzxznA==
X-Received: by 2002:a65:4907:0:b0:3fd:bc3e:fb0a with SMTP id p7-20020a654907000000b003fdbc3efb0amr27251715pgs.123.1657001486750;
        Mon, 04 Jul 2022 23:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEko2VtAQRyg0mb3j/Cx6ZkF9nqsprjC9s4bqY54uQ4+IbeXbfDUKMsX2dsTHZgTrRxxklAQ==
X-Received: by 2002:a65:4907:0:b0:3fd:bc3e:fb0a with SMTP id p7-20020a654907000000b003fdbc3efb0amr27251698pgs.123.1657001486525;
        Mon, 04 Jul 2022 23:11:26 -0700 (PDT)
Received: from [10.72.12.186] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b0016be6e954e8sm2890275pli.68.2022.07.04.23.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 23:11:25 -0700 (PDT)
Subject: Re: [RFC PATCH] netfs: do not get the folio reference twice
To:     dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
References: <20220705022219.286459-1-xiubli@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <2dcc7854-643c-0c77-b0b6-9443b9ee1dcd@redhat.com>
Date:   Tue, 5 Jul 2022 14:11:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220705022219.286459-1-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/5/22 10:22 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> And also the comment said it will drop the folio references but
> the code was increasing it.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   fs/netfs/buffered_read.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 5b93e22397fe..a44a5b3b8d4c 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -396,9 +396,6 @@ int netfs_write_begin(struct netfs_inode *ctx,
>   	 */
>   	ractl._nr_pages = folio_nr_pages(folio);
>   	netfs_rreq_expand(rreq, &ractl);
> -
> -	/* We hold the folio locks, so we can drop the references */
> -	folio_get(folio);
>   	while (readahead_folio(&ractl))
>   		;
>   

Will drop this patch, the above fix it incorrect.

Thanks!

