Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD5786775
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbjHXGZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbjHXGYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:24:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E952DB
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 23:24:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68781a69befso1060439b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692858269; x=1693463069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAWLL6d+tB1TW/sa+M7W81IeOtWmeLLF2BjX95heF8Y=;
        b=WC7DtczIl2huODCCK2FUQBPFySR8Fgdq+0RzN3EpYCF6xc5qlgt5yYNUyGMzGD3Vfd
         sCmovMwZKx7eCaX+kb4GhOATxvPvZalq8HdXwztGZ/H374MK4JcYUpPJJsgpKNLIKxot
         DmBT4zE6v8oseL1JDCpoVcqcxZf5N5NE7wvMO3NRJDeqxBq3NCwRJPiax64qfPuWSob5
         mcJU3k0lorHBX5pSNWGBJw+GJKMZc4VAy8jbjqfXszKYvDjyOYUFsPD/PZLQycXFE2uX
         l6MCDqrZ3yavMHHn+nS97IILA+7i5RFenYBam2Bp94XJlGvvguZGUp/ZdPOc/jOY5cia
         xE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858269; x=1693463069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAWLL6d+tB1TW/sa+M7W81IeOtWmeLLF2BjX95heF8Y=;
        b=csiwLZkp2FNyKpI4mM6Jg6SELMdR5DmG36+1MpaiCsdnfmEawCKj0viIeoahrMHACw
         XSwej1g0QXb5YoYxjnob/vZg/FdE+hts0h6gOpnSSzUlgm1lApiZfb6AX7xc99DcLdGG
         d5iPrwF4qWeMBR+0jE9vhCaneQs2fwqhACbjuh8SPsHkXf5yWTyjy2rXPIWMEobQxdvx
         5uw7TDVjOE0frkQo+rWWfnEDFe18j5FZfDimJkfcrxVLHRuTS3mZc0XsRXFrutO28nXt
         p066tAP0TRCNMA38Uzx/8lRlPAqhJKsAPP8bi7BNyK8Vv2K6v3Db+uwpFSXX07K9SJj3
         xK+g==
X-Gm-Message-State: AOJu0YyXy5CE+/PC9TiLPwGEeD4BN5pt6rbKtvCwcuO7OJUfbtGiYIqt
        wvvxvZx2AncO/CiopK6wnsst5sMzqI1npXUEkQI=
X-Google-Smtp-Source: AGHT+IEs+IcDk16YZ3T8sMPMS+c78NyGGAK7cNqbsAY3c0HgSGha1qj1+0CJyvlKa4AYIkTewnV0cA==
X-Received: by 2002:a05:6a20:8e19:b0:13e:1d49:723c with SMTP id y25-20020a056a208e1900b0013e1d49723cmr15644854pzj.2.1692858269010;
        Wed, 23 Aug 2023 23:24:29 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id ey6-20020a056a0038c600b00686f048bb9dsm6577558pfb.74.2023.08.23.23.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:24:28 -0700 (PDT)
Message-ID: <144fd7ac-154f-79b9-5483-56b15941f62f@bytedance.com>
Date:   Thu, 24 Aug 2023 14:24:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v5 05/45] xenbus/backend: dynamically allocate the
 xen-backend shrinker
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-6-zhengqi.arch@bytedance.com>
 <d07d52b1-6e6d-4b29-a9ce-7e325e7b1f11@suse.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d07d52b1-6e6d-4b29-a9ce-7e325e7b1f11@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Juergen,

On 2023/8/24 14:00, Juergen Gross wrote:
> On 24.08.23 05:42, Qi Zheng wrote:
>> Use new APIs to dynamically allocate the xen-backend shrinker.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> CC: Juergen Gross <jgross@suse.com>
>> CC: Stefano Stabellini <sstabellini@kernel.org>
>> CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> CC: xen-devel@lists.xenproject.org
> 
> Acked-by: Juergen Gross <jgross@suse.com>

Thanks for your review!

> 
> Just one note: it seems as if most users will set seeks to DEFAULT_SEEKS.
> Wouldn't it be better to do this in shrinker_alloc() and let only callers
> who want a different value overwrite that?

I think it makes sense, will do.

Thanks,
Qi

> 
> 
> Juergen
