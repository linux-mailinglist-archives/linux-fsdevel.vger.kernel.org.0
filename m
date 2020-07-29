Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3B231C68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2KCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgG2KB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:01:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0979C061794;
        Wed, 29 Jul 2020 03:01:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c6so1651447pje.1;
        Wed, 29 Jul 2020 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:to:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhqS/TVn+QryUKiM9kjYSdz+2PsU5CHJr52Pd8ZYJLU=;
        b=jTGn5BBRGJieUMUNIYAc34bvJJ5Z19vAtcH5jNHg8608wPX+lXlJu5e8EVnw2RJM8C
         tkbzoqVGwMS0V6qbqDpzlFXytGQc8Yt4wG7xR5jxtxD4nvvXO+6P4hLOfbXXS6GdKPIC
         +EKaZejqDXEsuk0yVDsME6T0E/iC6awjr/EETG6YVXHJCHOk+jycp3we2epVk4ik0Pev
         UYHcLsF4TvuLL08VWzLRZzdyn1Ey/GRVYLrmO68b5Z7SKphnyxmdqupMSsc89IV2PO6N
         Zanpk1whq9sbH11u4+DAF93rGN7v2atRJweIvDZ2YIntbMLFUwOWosH0tbHh3ztHZiuE
         vMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhqS/TVn+QryUKiM9kjYSdz+2PsU5CHJr52Pd8ZYJLU=;
        b=R8OfEYrL9vXXCSBLflD7Ww+UoTgPzNf/WQglKYrEOfZVqzCGxKJsXB3IaGBul7Dh9+
         Wg/+rli8bot7UQlmJ7xBWkgdpqXqI0eAHQ/HJQwTUm04lPUhFEGDCF0byUln0bb1+MAF
         QqMivJqvPERz0Mp0QdgQO73hrLEqPFClQrjMPsp4xTZLKRvLJ9WPhlnUChjTUmn5InSP
         ZxO6hstDwcDe0neH8P264L1FBZw4kbDuhBLycqFljQPvCrbHS5LVyiSdOwPrkUMDPwrI
         Uzezh/YFtvxKe/ikzPbElXcc9qAXQOlkOT7bM68HnT786vl09id20Vb7X9Ycq82nV+Lx
         RdHg==
X-Gm-Message-State: AOAM5312bJgMZA8b/2gD+e6MxUlWS3fzj1xf99pWzp0KI4oYyTS1uwl3
        zc3abZ7jXk6gLf3qcrUl3nhSlp5x6QQ=
X-Google-Smtp-Source: ABdhPJyz+O2zYB03eEDr+E6YXyvetH6FE51ND1NxpfVQ3sUGC2nxxxM6JOuebrri1jMzFdwF3k5D0A==
X-Received: by 2002:a17:902:ee54:: with SMTP id 20mr27271592plo.197.1596016918944;
        Wed, 29 Jul 2020 03:01:58 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:ccae:99d9:bebb:d2c4? ([2404:7a87:83e0:f800:ccae:99d9:bebb:d2c4])
        by smtp.gmail.com with ESMTPSA id f15sm1797383pfk.58.2020.07.29.03.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 03:01:58 -0700 (PDT)
Subject: Re: [PATCH v2] exfat: integrates dir-entry getting and validation
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200715012249.16378-1-kohada.t2@gmail.com>
To:     Sungjong Seo <sj1557.seo@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <3959d0a7-8457-e722-88ce-8ad28423c12f@gmail.com>
Date:   Wed, 29 Jul 2020 19:01:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715012249.16378-1-kohada.t2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/15 10:22, Tetsuhiro Kohada wrote:
> Add validation for num, bh and type on getting dir-entry.
> ('file' and 'stream-ext' dir-entries are pre-validated to ensure success)
> Renamed exfat_get_dentry_cached() to exfat_get_validated_dentry() due to
> a change in functionality.
> 
> Integrate type-validation with simplified.
> This will also recognize a dir-entry set that contains 'benign secondary'
> dir-entries.
> 
> And, rename TYPE_EXTEND to TYPE_NAME.
> 
> Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
> Changes in v2
>   - Change verification order
>   - Verification loop start with index 2

Ping.
Is there anything I should do?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
