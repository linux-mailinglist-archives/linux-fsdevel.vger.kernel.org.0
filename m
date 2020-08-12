Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19117242BDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHLPE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:04:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0B5C061383;
        Wed, 12 Aug 2020 08:04:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so1284860pjb.1;
        Wed, 12 Aug 2020 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GVj1Bd9vGqDIY2wrdhBDYL6yBxh1ELUeddi/DGvIx5k=;
        b=G38vR3pqBUwt5RXS8vzmxUdhWHtQGuwRqevWTsPsEnVg3v5dHjxrpID0tijCkqwcEM
         3ztWg5Abb16pfFllLw/BVmw8VU6d53QtySC/2r9eY4ZLOMjcLEszcmzNvb4n+1P0JBAE
         /Cj0JV42HYvrUALogZ09D6lba8dsIMX9d1fZfKN2qj0vR5e4PDZsszERFGx122vqU9FH
         hR1IFqDkktE27jzCMUeqdDglnAvEKEaM2KYWtL7UxS5l3YR66eHlX7e2iSXGJvGEeUn5
         jepHxw6aU2tbcK/Buqov5pE1CYAQlG76jkSU2ngZsxssVP/iAihPHgSfuz/Lg/Q4wFjX
         qPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GVj1Bd9vGqDIY2wrdhBDYL6yBxh1ELUeddi/DGvIx5k=;
        b=GFG9m9KPzTbXrfibnBBJ1HH65dD5PuYKbEXNPHB+toAQRSNEuXR2DFRjehfH8fZbp5
         +nq1TJ3Dm1Gr4kfB2yTi+74koDA2sVHFIqLY0H46rrmkfUhf1EPlzRFSmzLWxumK66C9
         voM8KitXYcEd6Z1ryRNNZA3BUGPCulhwvFGaDbNdWs1Z6qlhvZouRy9jG1rBHBicYr5F
         7kRsC/3M7yz2uKbXRImAjhaqihIy3XdJgE6Fc21qN3vL8c2aYFD6K2JPAgRknrPN/7LK
         NTIAqfUh3vfy9RScJ0EbHr5ys94nkt8zKKPLy46Ta0TDURL6PRrjK1bivdxidcN4UETh
         b/yg==
X-Gm-Message-State: AOAM531CAxyt/9njivlSMYHem9UxixDqnCOA3xodDAOVpWS3gnCOYZX0
        yTuJ5iGCNVXuaujTrwLgtmT/KabF
X-Google-Smtp-Source: ABdhPJx97G0QkFJ2BuQRwud2BecWo0oHI4Dmm4mjXLbOCTIthuqJM+ZIcKGt2nJxTIrFQKRskhuUog==
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr414522pjb.211.1597244695485;
        Wed, 12 Aug 2020 08:04:55 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:5c24:508b:d8c0:f3b? ([2404:7a87:83e0:f800:5c24:508b:d8c0:f3b])
        by smtp.gmail.com with ESMTPSA id d13sm2385311pjz.3.2020.08.12.08.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:04:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] exfat: add NameLength check when extracting name
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200806055718epcas1p1763d92dbf47e2a331a74d0bb9ea03c15@epcas1p1.samsung.com>
 <20200806055653.9329-1-kohada.t2@gmail.com>
 <003d01d66edd$5baf4810$130dd830$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <ed561c17-3b85-9bf1-e765-5d9a15786585@gmail.com>
Date:   Thu, 13 Aug 2020 00:04:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <003d01d66edd$5baf4810$130dd830$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your reply.

>> -static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
>> -		struct exfat_chain *p_dir, int entry, unsigned short *uniname)
>> +static int exfat_get_uniname_from_name_entries(struct exfat_entry_set_cache *es,
>> +		struct exfat_uni_name *uniname)
>>   {
>> -	int i;
>> -	struct exfat_entry_set_cache *es;
>> +	int n, l, i;
>>   	struct exfat_dentry *ep;
>>
>> -	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
>> -	if (!es)
>> -		return;
>> +	uniname->name_len = es->de_stream->name_len;
>> +	if (uniname->name_len == 0)
>> +		return -EIO;
> Can we validate ->name_len and name entry ->type in exfat_get_dentry_set() ?

Yes.
As I wrote in a previous email, entry type validation, name-length validation, and name
extraction should not be separated, so implement all of these in exfat_get_dentry_set().
It can be easily implemented by adding uniname to exfat_entry_set_cache and calling
exfat_get_uniname_from_name_entries() from exfat_get_dentry_set().

However, that would be over-implementation.
Not all callers of exfat_get_dentry_set() need a name.
It is enough to validate the name when it is needed.
This is a file-system driver, not fsck.
Validation is possible in exfat_get_dentry_set(), but unnecessary.

Why do you want to validate the name in exfat_get_dentry_set()?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
