Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C175F06FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiI3JAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiI3JAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0105BC1F
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664528431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5ZYOZmjWVg8D52uEiY1GVsoniAEpU3zbZzf0uuSNYs=;
        b=dLSE52JFt8GqVwIUUstw2BPKNEM2nL7/tOEE45wcCTaWkKsyidXRCzbWrNopKZI3FCZ1yj
        hBRPDv7DYnGXWIILodsDh+cRsNzbmaCXGi6Ssafm+0blb2L9tMi/QWvKaqoFgFGIGVuQG1
        x5zcEnQD2hwKjySV/aCGjn7cM/nCtT0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-L_7q_pfeN7aa3nScWgVXvw-1; Fri, 30 Sep 2022 05:00:26 -0400
X-MC-Unique: L_7q_pfeN7aa3nScWgVXvw-1
Received: by mail-wm1-f69.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso1776401wma.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 02:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e5ZYOZmjWVg8D52uEiY1GVsoniAEpU3zbZzf0uuSNYs=;
        b=zSibavEcxbDOOJNuV99hJfTKLyiynicOXJ0uqISqBK2FLq3upMr88m2QPkvurVwAnR
         DB2OcU50cRK3IriJq//zzShv6kg3V3AScp4ithPZLK/nzzkZ12cyc/5BLO/qTXAmRLIu
         SjNSmci4NNncWIu+lyaM1weFyn0N+smKlkLoRsMB1hXh6b6JS4ypRJ5HKKzxYVLY3oPd
         +I79oMcdS5OP1bEf74yrtbIxLDfj007JOjwi/xz/KrDWuVHo1gRxrxryv1471ZOQpkDy
         /lIhGdeSpcON/rm1UOe1+7RGbmWgi+pUCCNF2OCT62mqVQVIxJ7ZP6UVsR6BR5+m/2fG
         FATg==
X-Gm-Message-State: ACrzQf28TfzFXgiUZWPgaaE+f9KjBf3v17TcvzTnMjgjGqzrttb2PiuM
        64/tkvKxLW2M4Z362XPA3KDEyx/SWayORj4Upa51eg4/dVkib3moIldYfvpowaNDZCC9YPxb5ej
        buX8KmdoiFS0mm0MYeAFXkb/f3Q==
X-Received: by 2002:a05:600c:218d:b0:3b4:7749:c920 with SMTP id e13-20020a05600c218d00b003b47749c920mr14038631wme.190.1664528424635;
        Fri, 30 Sep 2022 02:00:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56kix7o7o0o8acTXkRZX11JFs2khtHABKoMBpzE3+fY/pl2285mS4RWYAgsnPu5u6Mha/J1g==
X-Received: by 2002:a05:600c:218d:b0:3b4:7749:c920 with SMTP id e13-20020a05600c218d00b003b47749c920mr14038613wme.190.1664528424401;
        Fri, 30 Sep 2022 02:00:24 -0700 (PDT)
Received: from [192.168.100.81] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0022917d58603sm1459613wrz.32.2022.09.30.02.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:00:22 -0700 (PDT)
Message-ID: <1ec3ff28-04e7-1b31-5cb0-fd0fde8f582c@redhat.com>
Date:   Fri, 30 Sep 2022 11:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] exfat: use updated exfat_chain directly during renaming
To:     Sungjong Seo <sj1557.seo@samsung.com>, linkinjeon@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7@epcas1p1.samsung.com>
 <20220608020408.2351676-1-sj1557.seo@samsung.com>
Content-Language: en-US
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <20220608020408.2351676-1-sj1557.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/8/22 04:04, Sungjong Seo wrote:
>
> Fixes: d8dad2588add ("exfat: fix referencing wrong parent directory information after renaming")

Hello,

I just wonder, since the fixed patch had tag: 'Cc: stable@vger.kernel.org' should this, fixing patch, go to stable as well?

Thanks!

