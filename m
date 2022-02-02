Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE74A6979
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 02:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbiBBBHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 20:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbiBBBHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:07:54 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04140C06173B
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 17:07:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so16984715pgc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 17:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSo0lKBxOCaeF2/Z6BYia50YxeJQ1xKTwofT0YCtOAQ=;
        b=B3j4wMvjt0cGoNPIVXr6D80603KlI3Z7B+sUmYIOhoFgfE2zf3NRTDe4GSRjHWwW31
         fk1LI0CfMYHlx/H3SeBT1X5DbmR63YNeyglveui0E8zE97a081Ul3E7Sx99BKqcCnCaw
         Qnk20qVNZEqsc0IgJ6FgFIXWg838wQWG1FbXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSo0lKBxOCaeF2/Z6BYia50YxeJQ1xKTwofT0YCtOAQ=;
        b=M2+NsrypEQ1KaBV1KrAPWg9suj8WytRlCT5vRUd7CN4ky6x4Nzxa/MQWrONDz9MG5i
         bQ14qN93PDqldFKRAGq/gitcwXtQNHe8qMU4bycANGVIK0oMvuw2cUocQyXDJX+psjKp
         D1XEqnwy8oBLfu9f5me5y7Za4f3BCDUZ2DinrYhogbJK7Z4RzxoBd1a9vRAu5m3feBAN
         Gy1aO44ujxtWetXCrA3CiQ0tKHKkaP0y0JbIzdmxs9wmCEdSlviz3KDjFm8FEK49dr4W
         ngU3ozs1Xg17KWhtTp4c8x71qKopAEhaxODmuDoiGdP6mLpNIkzNqy6VAzLOW+d/ssxT
         Bu5w==
X-Gm-Message-State: AOAM5327SOfSDxoZ5gmktY4dp4mlsHqQTFkP+QQNKv4o5R/EMfKbQ198
        29TPoXejtC/m+FShrKAn0NHByw==
X-Google-Smtp-Source: ABdhPJxPjwMwuYyjXbYv75EsIRWlL4woTQ0yr1bgcp5S7GmLVGAyQU2AJPAJggFeEX/0dz94hZOq7A==
X-Received: by 2002:a63:343:: with SMTP id 64mr22646388pgd.463.1643764073491;
        Tue, 01 Feb 2022 17:07:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nv13sm4471158pjb.17.2022.02.01.17.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 17:07:53 -0800 (PST)
Date:   Tue, 1 Feb 2022 17:07:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <202202011707.F4137C55B@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
 <202201281347.F36AEA5B61@keescook>
 <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:48:16PM -0800, Andrew Morton wrote:
> On Fri, 28 Jan 2022 14:30:12 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
> > Andrew, can you update elf-fix-overflow-in-total-mapping-size-calculation.patch
> > to include:
> > 
> > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > Cc: stable@vger.kernel.org
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> Done.
> 
> I'm taking it that we can omit this patch ("elf: Relax assumptions
> about vaddr ordering") and that Alexey's "ELF: fix overflow in total
> mapping size calculation" will suffice?

Yes, it has the same result. Thanks!

-- 
Kees Cook
