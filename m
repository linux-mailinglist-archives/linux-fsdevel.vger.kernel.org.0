Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71855531FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 02:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiEXAvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 20:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiEXAvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 20:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E3F020188
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653353492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYTIypUIAadfcSy41CGM20tQJDNF0c7lxi1JOJ+m/Z8=;
        b=DfuAtgdGaAenDRRp4q9ByajuyWWKc9FvP9Go8PC8UDs/+bxryRfOpvEjfO8AYOEOWTdV1f
        VzFyLI6DcVJrnfGyITJ1e3h7bve0sn3rbbkrkYU/3//yA2s6qh+bOGVZHW/b4ivsy1utat
        vQk/AjKevr758u62s9oItF63BKl4SSw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-j1B2h7BVN-yDzq-KQ3Pv4A-1; Mon, 23 May 2022 20:51:31 -0400
X-MC-Unique: j1B2h7BVN-yDzq-KQ3Pv4A-1
Received: by mail-pl1-f197.google.com with SMTP id w12-20020a170902e88c00b00161f70f090eso5361631plg.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 17:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YYTIypUIAadfcSy41CGM20tQJDNF0c7lxi1JOJ+m/Z8=;
        b=NIQRHD3RRSawOfItvWFyzj/yJoVreua4qJ0t1k+9InAAuPvYkAC/7dsJPnyiiGH2fb
         p3KdAgfjvVz/nshTnMotApUnfiNgRcxgr0PUrBmNaLKSxwRiaaefdrROg6E7XRUfdTun
         +jeC53cKt1pt58na3AfUwizJ/YUtA0TfImYyiG57ts/gewh3k+KBT/WSbGp/bc8n1OZZ
         4FAS0AEPxLGruXswxvWzeiQj9GoMvEI9R02ZLMeiQvnpTa/NlTvzqcBPYsZdjS43nD1i
         l3hQ9HjkXNVQefSyMbVQPoxfWm4Pkizd/joiW+1nGAWd5x2giD0CQiQImmPM0h/SRD34
         XFCw==
X-Gm-Message-State: AOAM530Zzb8dGo4lEp+E9UMsI8TwgmcCqBbLc2srH79UorlAp15teNkJ
        5YhI5GEduzinjnroe5LxLoumhH4O2xNWShVATM0LFYDZUlf6XIm989rMqKuk40IDi39bKPaS6uw
        9SwVpjXmOH+oloi3ABtXsfZWY/A==
X-Received: by 2002:a63:fc08:0:b0:3f9:e159:b114 with SMTP id j8-20020a63fc08000000b003f9e159b114mr13011210pgi.526.1653353489755;
        Mon, 23 May 2022 17:51:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH5R8vSDYh7Qy+89u7KjwlPHBHVSXcTSiatpbqsu0in/KQMdoJAbWkmpNFUQY2OLjaEKOovA==
X-Received: by 2002:a63:fc08:0:b0:3f9:e159:b114 with SMTP id j8-20020a63fc08000000b003f9e159b114mr13011200pgi.526.1653353489558;
        Mon, 23 May 2022 17:51:29 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l13-20020a6542cd000000b003c619f3d086sm5367802pgp.2.2022.05.23.17.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 17:51:28 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: move myself from ceph "Maintainer" to
 "Reviewer"
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220523172209.141504-1-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <70a4bb14-cdb7-2368-1a67-ab69d3ed9317@redhat.com>
Date:   Tue, 24 May 2022 08:51:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220523172209.141504-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/22 1:22 AM, Jeff Layton wrote:
> Xiubo has graciously volunteered to take over for me as the Linux cephfs
> client maintainer. Make it official by changing myself to be a
> "Reviewer" for libceph and ceph.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6d879cb0afd..39ec8fd2e996 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4547,8 +4547,8 @@ F:	drivers/power/supply/cw2015_battery.c
>   
>   CEPH COMMON CODE (LIBCEPH)
>   M:	Ilya Dryomov <idryomov@gmail.com>
> -M:	Jeff Layton <jlayton@kernel.org>
>   M:	Xiubo Li <xiubli@redhat.com>
> +R:	Jeff Layton <jlayton@kernel.org>
>   L:	ceph-devel@vger.kernel.org
>   S:	Supported
>   W:	http://ceph.com/
> @@ -4558,9 +4558,9 @@ F:	include/linux/crush/
>   F:	net/ceph/
>   
>   CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
> -M:	Jeff Layton <jlayton@kernel.org>
>   M:	Xiubo Li <xiubli@redhat.com>
>   M:	Ilya Dryomov <idryomov@gmail.com>
> +R:	Jeff Layton <jlayton@kernel.org>
>   L:	ceph-devel@vger.kernel.org
>   S:	Supported
>   W:	http://ceph.com/

Thanks Jeff.

Acked-by: Xiubo Li <xiubli@redhat.com>

