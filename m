Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A57402D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjF0SFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0SFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC78E5B
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687889103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSkYJ/7LIQNDaVX+NaIEBpGI8gb9wj1heZwmzePGVd4=;
        b=S9NMq8ii0x4oIOdoSLXLTjkr6rl/Wen0UgL6/pdPJwdEhTd/247HorhIMwX2TL2GwJpd/U
        f4uXbxdVvJa65sgoc5kgWRhjQGt7C2CCGfziycxu4PfQfh+3yK/BYja2FY5adjo38Wy3TA
        vxNQbbuvedooiZARo0Qfg1+XuSBNJ58=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-0HN0rDJNMmeDh8yE9BjIKw-1; Tue, 27 Jun 2023 14:05:01 -0400
X-MC-Unique: 0HN0rDJNMmeDh8yE9BjIKw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9885a936d01so311745266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889100; x=1690481100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSkYJ/7LIQNDaVX+NaIEBpGI8gb9wj1heZwmzePGVd4=;
        b=SZ+Bqg7pSeiVYa4XKE9Y/wIjSufbxAooK0toZYoDSYkW67mfbvPizbwfKoV/tYhRAm
         jti6Eu1FaVarBMj3fE8wJtzf6dmrD039ftIQNDVowZ+W1av5LNg7XVifY7zz3ohhYs8b
         HQ/vEn4z3BXJDfxiTFGQucYr5EBZ/3TIKHtkoWbM2qMC19lMK0Zv1J1XKqiXCGjarv10
         QLsw/GF5eLXakYoNBSsExv0ebCgr5FraquWtkYT+XNV9kZamPJrCpBk751wFuiqBr4Fx
         CQcjOPCwZFdxLbWLoB+AaUr1ou40g1T8jMnewWzmgSL0I8FymKLf4tx0fnLqLwKr83i4
         3xug==
X-Gm-Message-State: AC+VfDwFSgcV0uwqxhoTG1T0Von43A/x6QO2HCZ9fNwIFThnwk311rnY
        2YSN+CT6vsV3d6ji3mr1q/XLmYQrIWIWGXsFaZqg1lks05Kvypz8EqM3bANB9c9JOij0SKtl2zT
        NBWK2Q8j6sDESD2EZwTnS2B6WUw==
X-Received: by 2002:a17:907:5c2:b0:974:55a2:cb0b with SMTP id wg2-20020a17090705c200b0097455a2cb0bmr28675572ejb.55.1687889100397;
        Tue, 27 Jun 2023 11:05:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kFjsg3w3SaTOHLFA7v4tck3M1EXxx9ZydaHqAuSxq5qaEOkLVvrnRRwJvnqA7E61qVar7BQ==
X-Received: by 2002:a17:907:5c2:b0:974:55a2:cb0b with SMTP id wg2-20020a17090705c200b0097455a2cb0bmr28675563ejb.55.1687889100133;
        Tue, 27 Jun 2023 11:05:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b00982a352f078sm4737229ejm.124.2023.06.27.11.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:04:59 -0700 (PDT)
Message-ID: <cedbd75d-4a0f-74fb-3a6e-547862cc431e@redhat.com>
Date:   Tue, 27 Jun 2023 20:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
To:     Matthew Wilcox <willy@infradead.org>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
 <ZJsg5GL79MIOzbRf@casper.infradead.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZJsg5GL79MIOzbRf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 6/27/23 19:48, Matthew Wilcox wrote:
> On Tue, Jun 27, 2023 at 06:51:15AM -0700, Sumitra Sharma wrote:
>> +++ b/fs/vboxsf/file.c
>> @@ -234,7 +234,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
>>  	u8 *buf;
>>  	int err;
>>  
>> -	buf = kmap(page);
>> +	buf = kmap_local_folio(folio, off);
> 
> Did you test this?  'off' is the offset in the _file_.  Whereas
> kmap_local_folio() takes the offset within the _folio_.  They have
> different types (loff_t vs size_t) to warn you that they're different
> things.


Ah yes you are completely right, off is the offset in the file
and buf should point to the *start* of a mapping of the page.

Regards,

Hans



