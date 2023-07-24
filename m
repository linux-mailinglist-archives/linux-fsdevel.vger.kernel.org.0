Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8475EB72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGXGYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjGXGYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9B5B0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690179840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZEd3y5m5T6ObBTdJq73wFLu8a8S74TGSO2fnmaNWAY=;
        b=DoB6rkoI7r8Rl6n9nCpkLwy8qboLGWG9j7+QwV008VmO7B9NQETM48pc2DymJ3YyE0re7K
        1sRvcxEVMoWFlKh2Ht18YJETq5SMVwfMwlrPGTnnsMWVKK3k1PRqER3vF8up1V3XHYWej8
        liQUe7Cad5/JHgyyq0rtb0W3uD2F1dY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-f0olRiCAOT2D9xHBYg91Yw-1; Mon, 24 Jul 2023 02:23:58 -0400
X-MC-Unique: f0olRiCAOT2D9xHBYg91Yw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-316f39e3e89so2380510f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 23:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179837; x=1690784637;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZEd3y5m5T6ObBTdJq73wFLu8a8S74TGSO2fnmaNWAY=;
        b=DB5yJPSE9YDeXJFUlpPiSKZ0LwUu/rbbTUrAmfbwO3RP43ZA+NlyH2ku9KNhVgo6uB
         Z7cif4JcsZGHJ2oWo9Rv+dl2idB/tIbVCN0wfPP7zPcsNu/dzfLtLAOtilVc+49xwGmZ
         HHo0ajHSDMf29oqFe0B5y0xrBo7RfX37tKiHF5jpk+D+3FwOloQcqtEug846zTJsSPBj
         /SV2UjiUkJnZOHTG8kGZpfG1g5eZK1fTl4voMzqPZ2BVnl5WNbXWKVmYDKvdaPgex68A
         KdMtUARVneU4hdvGvtgiqAYzybdKt/SONYNI37j5x5wBNYcpYE4TzmJB0rKOE4nIKH2H
         Lm3w==
X-Gm-Message-State: ABy/qLZoW1/4a+B9EvoBZZCFb2EpZUrgQ5j/oHtMIsk6Ci3JSFy841Vu
        Zs908ep26VZ4i9zDeuHbHLTVhG1jk7M5KXfv7Z/2w/5PMx9Q8zpZnZ6/5adxNCc60vlUqcbyVmB
        KlnEjLTUYyD7ACZWJ6qbveBuavV47jtpAmQ==
X-Received: by 2002:adf:e74f:0:b0:317:3e26:1699 with SMTP id c15-20020adfe74f000000b003173e261699mr4271853wrn.24.1690179837371;
        Sun, 23 Jul 2023 23:23:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpW5m2s9rcQCA2y/SQn5BT+f9W2+cbW1Dhq/5Htb1O461c05ftyJmBOOOEljHVXnntLoe8dw==
X-Received: by 2002:adf:e74f:0:b0:317:3e26:1699 with SMTP id c15-20020adfe74f000000b003173e261699mr4271844wrn.24.1690179836981;
        Sun, 23 Jul 2023 23:23:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003143867d2ebsm11776170wrn.63.2023.07.23.23.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 23:23:56 -0700 (PDT)
Message-ID: <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
Date:   Mon, 24 Jul 2023 08:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Jiri Olsa <olsajiri@gmail.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava> <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> 
> I met this too when I executed below command to trigger a kcore reading.
> I wanted to do a simple testing during system running and got this.
> 
>    makedumpfile --mem-usage /proc/kcore
> 
> Later I tried your above objdump testing, it corrupted system too.
> 

What do you mean with "corrupted system too" --  did it not only fail to 
dump the system, but also actually harmed the system?

@Lorenzo do you plan on reproduce + fix, or should we consider reverting 
that change?

-- 
Cheers,

David / dhildenb

