Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215964C81D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 04:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiCAEAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 23:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiCAEAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7F214505A
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 19:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646107189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kc+N+qIBFHQOsV5ZDL0yG8r9s2qldX+du39vXBk/zTE=;
        b=SqLtMwbU7MWDG42LwQgI1nYKhk8jCHa5Devv1TqyhuC1A+SLR7g8+96A5AMA5FtHr58VZp
        oGgC0fSuTscXHorVR/29e0gmWnZLISSd/UYfwa95el1jVgk04tvhKyKkDegjA1Z96Lodnl
        tYnHYAGnc5vyp22qYZmAqhubn276Rvk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-T-UF6tRWPOWYR2TVtNrNKg-1; Mon, 28 Feb 2022 22:59:47 -0500
X-MC-Unique: T-UF6tRWPOWYR2TVtNrNKg-1
Received: by mail-pg1-f197.google.com with SMTP id t68-20020a635f47000000b003732348b971so7800051pgb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 19:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kc+N+qIBFHQOsV5ZDL0yG8r9s2qldX+du39vXBk/zTE=;
        b=jvNCxkRORBRfmXl3gaZdZYXZVTQnUfog6GWPl2nrbkcie2ERgUcMHOubaSKHrRPiMu
         Wk+NEhFZeeV9ywcvZ6908biR/T1Smv9NUy35P4xkAgFhzqoRVF7wvYRo62ceNbv6BO5r
         H+/PPWuE9cNVw9ge8MAVliATlGXstkGbhZXEiLo2Wbwd/dNqdt/HWRgSSfHTuO+u2tZ6
         MtBj8GIAIDzau0QvLXWB0isGfHtvuTt+YpepOWo5l1gLTg3Cc1wvkCNbe1zW9QkOxfgh
         3rClvufJ8lYk2Q8NA9ajb+hZhWem44GJ0IZGyGvFZqsrHpZRJudJD1LgM2BPTdmR2h4K
         IqIQ==
X-Gm-Message-State: AOAM531p1sMSrnuHjLBEprtNXRgJoFdJfdNfNwK5ii3cK56VKVA41ETG
        mvSxmYFRWRo6GcbzbK8k6jhTvjmxQqr5YrHlmtbMPRdLXC7JYs4TfM4T4MsFT+Rw0kkY96rlUka
        WxrQw2W27tTLH3qoRxa7MgajcWw==
X-Received: by 2002:a17:902:8f82:b0:151:5d30:a019 with SMTP id z2-20020a1709028f8200b001515d30a019mr10730788plo.145.1646107186340;
        Mon, 28 Feb 2022 19:59:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbE+FEQtLqQRsJnG0YfHtxsy1ARbqSF6OQ1/QB6BaWcv9noNbWhkppUSvRbmDWW85pILm69Q==
X-Received: by 2002:a17:902:8f82:b0:151:5d30:a019 with SMTP id z2-20020a1709028f8200b001515d30a019mr10730772plo.145.1646107186093;
        Mon, 28 Feb 2022 19:59:46 -0800 (PST)
Received: from xz-m1.local ([94.177.118.144])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f0f0f852a4sm15490396pfx.77.2022.02.28.19.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 19:59:45 -0800 (PST)
Date:   Tue, 1 Mar 2022 11:59:38 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        tiberiu.georgescu@nutanix.com, florian.schmidt@nutanix.com,
        ivan.teterevkov@nutanix.com, sj@kernel.org, shy828301@gmail.com,
        david@redhat.com, axelrasmussen@google.com, linmiaohe@huawei.com,
        aarcange@redhat.com, ccross@google.com, apopple@nvidia.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: fix documentation and description of mmap
Message-ID: <Yh2aKofkcWsLswQm@xz-m1.local>
References: <20220301032115.384277-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301032115.384277-1-yun.zhou@windriver.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:21:15AM +0800, Yun Zhou wrote:
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 78125ef20255..75511f78075f 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1596,7 +1596,8 @@ static const struct mm_walk_ops pagemap_ops = {
>   * Bits 5-54  swap offset if swapped
>   * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
>   * Bit  56    page exclusively mapped
> - * Bits 57-60 zero
> + * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
                                                ^^^^^^^^^^^^^^^^^ remove these?

Thanks,

-- 
Peter Xu

