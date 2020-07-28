Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFFD2312E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgG1Tll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgG1Tll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:41:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B8C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o22so15556126qtt.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+oJXyfHvcy53lAyO2fdrXkaj9azqIokLoWoIQ/55Cdk=;
        b=E7W+DckP4VNYWqoPpt1xhlyAhlYu7Xo/4QS4BiNfAW6ltpeIwoiAnbMTOOu/TDbRjJ
         BIEbmU3x1k1lafHKth0kXquy6xPqIpVbeOYBC4NuuS/lfpkqksjsCJUdopnj27+qHDyQ
         PJ4swEVv70ioK15U9NuZ9iroBkeaGScMGrpN+UrgaU1rTEFMZ7A6Yel3qhiQuSQn4K+i
         DudoVWgUNDjl7woLgoCxnFjTPRhyO8zE78qmOrP5XXmDIuDuMbBLiNQFRUMDYwgM0EPO
         WzFrQCios5hDSQWDsVuGkxHyUINc/avYOc2M4OZ4d9MwBpywy8416E9bVN72sBLMl17G
         ewRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+oJXyfHvcy53lAyO2fdrXkaj9azqIokLoWoIQ/55Cdk=;
        b=PoFq6m8gD2oBvNhXQUUnxoHdTwVDUg7h4EFQtPrEPf/KtpAiCO8YhKGlvUMAIzTnqO
         64caJccGCIIHQBJ4dQJCWikBvPfjfMK30QyFCGP8vjYHgTfSm5Ytan6kj891lscFo+sP
         HmuViQGo4PX33WMKTd9mAepkICQRwRlZADzpnBYhSC/vBrh6fLiWXMfLs7vD3Vxt56BJ
         2XwHw5doOlpUCOb75qt898OcDehJZhZb2KiZ8X6UM7vNeN4/fd/Lirb3D1g/CM95VtWA
         V5xhlkU1ru4DzqTMccjlcvNrxA0khKW7hMn5WBn0vWQibZn7P1bmDOcqAQ4gnfeX/b7U
         B9jA==
X-Gm-Message-State: AOAM531n66Vr8IW3tGHbeZgIZP8F0DlWYHyskayTmRyd5byyhRlWPjp7
        2PqwUv7XThYeD61LbLkw8XsiBQ==
X-Google-Smtp-Source: ABdhPJzaxob4ToiIvp8z+VCL9GUj97VjqHBiBkH19TsREcIHObH1Arz9UB6XAuSLPa4oBiqkiMAWDg==
X-Received: by 2002:aed:3387:: with SMTP id v7mr27254682qtd.318.1595965300334;
        Tue, 28 Jul 2020 12:41:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p36sm20735569qte.90.2020.07.28.12.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:41:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k0VTm-000fz5-Io; Tue, 28 Jul 2020 16:41:38 -0300
Date:   Tue, 28 Jul 2020 16:41:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: mmu_notifier: Fix and extend kerneldoc
Message-ID: <20200728194138.GB24045@ziepe.ca>
References: <20200728171109.28687-1-krzk@kernel.org>
 <20200728171109.28687-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728171109.28687-4-krzk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 07:11:09PM +0200, Krzysztof Kozlowski wrote:
> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     mm/mmu_notifier.c:187: warning: Function parameter or member 'interval_sub' not described in 'mmu_interval_read_bgin'
>     mm/mmu_notifier.c:708: warning: Function parameter or member 'subscription' not described in 'mmu_notifier_registr'
>     mm/mmu_notifier.c:708: warning: Excess function parameter 'mn' description in 'mmu_notifier_register'
>     mm/mmu_notifier.c:880: warning: Function parameter or member 'subscription' not described in 'mmu_notifier_put'
>     mm/mmu_notifier.c:880: warning: Excess function parameter 'mn' description in 'mmu_notifier_put'
>     mm/mmu_notifier.c:982: warning: Function parameter or member 'ops' not described in 'mmu_interval_notifier_insert'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  mm/mmu_notifier.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
