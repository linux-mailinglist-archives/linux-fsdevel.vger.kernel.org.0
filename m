Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02AAF64BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfGJRwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 13:52:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38949 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfGJRws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:52:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so1594344pls.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7bt3uTjdvwOxCSrbgXPGxceLQgj9AhCnSmWTiQF3lg0=;
        b=Xpz1OWs0EPOn58mLkWBhZPj0ilFyo38+TfIG0u4B64TO0IAg54S4ECVhLPLqe5gbPe
         1s93oq/MKLVtxFowoz2+aHvKEm2fHJ8Tigl0xgfhA3FDHMqFZg/s9JnhG+wQLAR2Vx+6
         fcohSx5C7M09X1g6P6Twd8Cy4kZkCcCKt2IU/24708FAyvj3PfD0Ub/5a4A/wbuKyToK
         QBnxwi9ZmcZfjz+WHd7qCq72ElHe8xjDGZ1c4HbYZm19EGIi3B7SaEoanabZ2iECkcAq
         TXKx8JaVZzClM9BTtaLtgNRUzbC15I+jMzBYKKFjQdwLBYieC0O552wi/1Aste4d+RiJ
         tJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7bt3uTjdvwOxCSrbgXPGxceLQgj9AhCnSmWTiQF3lg0=;
        b=WZgO9dnEVzi0COmDRkGtJOIe+Ppe9tN+BfDf7kbiyi3o+PIw5kkqcL0A9VXBkNKKIv
         doV/JBeazv1GaYrRpDiX/ow0BWwrcnx/v+Lv+5aSNCUb2Ld+fcNFCsGjQflce90Uv3HT
         VK/+exy19rCDHs2pigQ7mk0xQ7kbCJKlgHbXEDt29yydicfQZUk271MzaqsWj3sZ9e/+
         gUE2Kx/IzX4hhGv13sdEf+03RgH1LLo7nM9h8HECyEcBLKg0jczvdmKoMZHGjgH2sJIL
         Eq+VotAErS0Jlk5zmg5BOGGBqdFmBPhknHiERe3W+X8xR9b3ptxX3BA8U7+xxtwbkNEb
         oBSw==
X-Gm-Message-State: APjAAAUwfuBWUjsujgss3rauFJdXtyBjuuLMOY+S6O8eeOGMfUdtbk0X
        H2NdjJW0lW5nqNDObIZuaAgCoQ==
X-Google-Smtp-Source: APXvYqyO2e4PUxtRgJBhe0wMewV1eQoMpbGPj6EP6YgjdiLHi9SLRVufDFsyJ/LenfbVToiBoJT2yQ==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr40140076plc.2.1562781168363;
        Wed, 10 Jul 2019 10:52:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id b3sm6722337pfp.65.2019.07.10.10.52.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:52:47 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:52:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 2/6] filemap: update offset check in filemap_fault()
Message-ID: <20190710175245.GC11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-3-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:42PM -0700, Song Liu wrote:
> With THP, current check of offset:
> 
>     VM_BUG_ON_PAGE(page->index != offset, page);
> 
> is no longer accurate. Update it to:
> 
>     VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
> 
> Acked-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
