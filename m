Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFA32B4EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450192AbhCCFbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbhCCCqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:46:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BFBC061788;
        Tue,  2 Mar 2021 18:45:18 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so6019191plg.5;
        Tue, 02 Mar 2021 18:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cBrDyODWb9o0wKTGlYEQJLE0F3iUV2itXWKb5sgDsGI=;
        b=S32DEI3weYwTGnPZ8gv3lwj9JSyyd87UoScYSPpyk+56v3bzARJ7vegfvrF2nPoCfX
         4JG5b1M4DIWdFv9pg/4biqSPRF07OXjCohzt+aVYyNM1poxiskVpkV5n6BzciRVZTXwZ
         FraJjTzMYwywR5pzTMOGqGIKmHgz8UA3+DQH3CCwRwHkDhbs+vuBeZ4bm653zyBNLcQM
         FYGah9blETvflovotwrZ7xPbEqmGvG7iFtPmkcFNaqUtZH+AO5/ppGzI7BNSh8qMuq09
         Wj+yrIsLqAz9x5UiM/DO43tUdFHrbxNLCk3NL5on8iv+KIFocI/YMzpPuy2M8ye7rVSY
         U36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cBrDyODWb9o0wKTGlYEQJLE0F3iUV2itXWKb5sgDsGI=;
        b=l6QnMWhxewAa43XtWtaK/xUAFoelphKhO2qL6kqOlTQVTRy/0BcRiDnXzlnwm3WqGy
         lxQ2BQwrBG69wleF27+q+Tu1FIzc0VS9V9Zg3A4UydNYDVzdJ70YfNrh6mxOx7CBIG8c
         1cTlGlqkuPw5WnvOiHaXNnQlZMYJayyzXUs5KbSES9tTu8b6Vuhz92TMgsx7OOuXPHXU
         dlDee7Ax12HOlHk122hL0c7leilFdNyZ42y5fPuBrXQ4HvtGRhnUPCgtLltLN0QoL/XX
         yd5iGvfmo1ZneUxCwWD0RVlmTr5FL/4H+JYEtHLd9DysR3V1hEe14rEJk3gSp806h7ER
         SsoA==
X-Gm-Message-State: AOAM531v9wqi59+cGVy/9L0EHSH8juvHCSvVQtgx8g/mFpyCGzYEeNVV
        Aym0PtZ1FisdxqDHX6a9tGF2WIBVXCt+Qw==
X-Google-Smtp-Source: ABdhPJz3Uicrb5pArHjvcxNRuVPXM7eJzoN2OA3/o6bPFEi4LuHy3GR0zsFUa6l5BKwnTzQroYVhVA==
X-Received: by 2002:a17:902:7597:b029:e4:156c:ba97 with SMTP id j23-20020a1709027597b02900e4156cba97mr6223687pll.63.1614739517398;
        Tue, 02 Mar 2021 18:45:17 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com ([54.240.193.1])
        by smtp.gmail.com with ESMTPSA id y15sm915385pgi.31.2021.03.02.18.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 18:45:14 -0800 (PST)
Subject: Re: [PATCH v17 1/9] mm: memory_hotplug: factor out bootmem core
 functions to bootmem_info.c
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-2-songmuchun@bytedance.com>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <baa8e9af-69f5-c301-6735-f8eedc1929c7@gmail.com>
Date:   Wed, 3 Mar 2021 13:45:00 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210225132130.26451-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/2/21 12:21 am, Muchun Song wrote:
> Move bootmem info registration common API to individual bootmem_info.c.
> And we will use {get,put}_page_bootmem() to initialize the page for the
> vmemmap pages or free the vmemmap pages to buddy in the later patch.
> So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> movement without any functional change.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
...

> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> new file mode 100644
> index 000000000000..fcab5a3f8cc0
> --- /dev/null
> +++ b/mm/bootmem_info.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  linux/mm/bootmem_info.c
> + *
> + *  Copyright (C)

Looks like incomplete


Balbir Singh


