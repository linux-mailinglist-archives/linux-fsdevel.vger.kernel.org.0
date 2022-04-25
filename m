Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120BE50E463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbiDYPbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiDYPbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:31:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806210F3AC;
        Mon, 25 Apr 2022 08:28:15 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f22so10503874qtp.13;
        Mon, 25 Apr 2022 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYyv8u6TK+HNnCO2dEZ8rytiI/LivMuIT6ek4UyKCZU=;
        b=By74vmVJQ/MnB36Y7p6UwVteaImK9ZjGLjA9uBcyypNXMkNwHVqIYGK4LLUcjyQtwV
         gCml6JlzZPU91AeAqZVjwtBCd+WwrZU4BVZsBjzlpPumMon3lVhe0cPKfjc3T5oxKnVu
         HJ5Owst1glYb9C6e5TXhR3fTu3L1w8PXstENMx4mPrtVGsmT1tseZ/NvR5iK5LJTXNZg
         qaxWBUpARNbeAAWobmN/fHMcJmydLk2qbVbiAKVv9qIChHO4FvS64QyRqN8zBVicu+LX
         1maxLaF5CMblXanXaZ6cfZOWpA4usEyZSVoq02wkcfGtCBDTvc54kVTcu/Wq0NKsMOmU
         ntgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYyv8u6TK+HNnCO2dEZ8rytiI/LivMuIT6ek4UyKCZU=;
        b=5lU8nCz2nwBrbkPDAcr/afoqETh1U4g3ZxKqLCLYoE/qmAOIxegp6CPWoHvjUSfy1L
         5M7rqM8WbL7sxnhxxI9d0XGG3dqqp6tpWxvbJvMaYXR6hBILf26JWYqo5dSZeoh4C/GC
         EIpgq/T7QsHlxCmOaeOBUq9MNUAqlP7S2letKZI+wWCxbaT0FPe8CliXK+9rdTgn5suX
         7ih6ll4u9beBCmFtBk/WQKw3GW40nkKW7r/HjL5FRMoLlqnp/UipfFfdEbPWxZZb6k4E
         Ik61TqP9wIZOAZ1NgRDi4nlChidhpwoaCTsGDFBJ+f6C2vbJg4XKVWDAOVFDjZcm4kiv
         CitA==
X-Gm-Message-State: AOAM530FyiD1pdoeAGd/Ej5s1FSrvXbbjaB8bz7R45o+rdRYn2VmTqvp
        0EVrTe5D3t1Qg65SvCkGQQ==
X-Google-Smtp-Source: ABdhPJyn1L63ig8CXlJylyOHi+tBOKG6YcgedNBUKOf6xBOnteBc+GTPyVacwZlkcADPpljIaz9lmQ==
X-Received: by 2002:a05:622a:1314:b0:2f3:5726:e034 with SMTP id v20-20020a05622a131400b002f35726e034mr12185089qtk.297.1650900494382;
        Mon, 25 Apr 2022 08:28:14 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 128-20020a370486000000b0069e9d72b45fsm5193739qke.13.2022.04.25.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:28:13 -0700 (PDT)
Date:   Mon, 25 Apr 2022 11:28:11 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <20220425152811.pg2dse4zybpnpaa4@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
 <YmNH/fh8OwTJ6ASC@carbon>
 <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
 <YmZpuikkgWeF2RPt@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmZpuikkgWeF2RPt@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:28:26AM +0200, Michal Hocko wrote:
> 
> > Do you know if using memalloc_noreclaim_(save|restore) is sufficient for that,
> > or do we want GFP_ATOMIC? I'm already using GFP_ATOMIC for allocations when we
> > generate the report on slabs, since we're taking the slab mutex there.
> 
> No it's not. You simply _cannot_ allocate from the oom context.

Hmm, no, that can't be right. I've been using the patch set and it definitely
works, at least in my testing. Do you mean to say that we shouldn't? Can you
explain why?
