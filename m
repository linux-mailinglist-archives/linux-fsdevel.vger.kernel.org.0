Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F56550F25D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbiDZH3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbiDZH3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:29:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C90CBC26;
        Tue, 26 Apr 2022 00:26:16 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d14so11992137qtw.5;
        Tue, 26 Apr 2022 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yrE6/KgEQNtC6XhgTjcpn5HXwreHk+7lNm/A5Ylaexs=;
        b=MMOnHZll5VuB7PYy60Iysska6rZSf2D5NP4yAERa9ryhogeag6xqgyUSPbZb7bCeBK
         zbPmDR7lIYjgg0DO3yolNQW7Ogg07Z4TUMtWNedywiiUIx0jk/eaAtWyItzk/sxt+yed
         4SRUSei87FUEuymIi/ktCyE2nuDCXqfJKyc2XXy53P716xjN7yKfexduMdDMsZiv4XEP
         9vcmY1/aI/VVw/kLKbTXqZ/peUEm3mEvblkK9ttYNhxNT2YqT5nsVou+xnqP34ArGUw9
         qdsC5WFU/Wo9Z2mZHsrZOr8pR4Yq89/4smKLo3zo3V05YP0f/XOv861ZQoTPtID7L4E2
         0n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yrE6/KgEQNtC6XhgTjcpn5HXwreHk+7lNm/A5Ylaexs=;
        b=fSKD7JcW5cVIdrEHfLMpSbTQfrkWSmSwzlffPlAqzKZ5pxy0Ha5ZpaihMVxtSTT3g8
         OnU93mAC+Bijv6vP3xjjtTATCW4LPbXHkZowH+rELfFu9vophRx7KmTayZQ9Vs9ItRu/
         +5i5pvdss6lZo6ezs5ypaglut/E3N4PzrIkCiqEg/yHxGhLBmrhIGMe+tsjLH/e3QByf
         H+T6KmUOExppkUPKr23s6YNB1zY1ftlBjrUiDWzmbRO97G1a/PSX4i6K0gF6UaTiQett
         a2aNXuRH9UEke1E6Tlqe5grEPGQK/0uDw8WVljRtdNAEOIebHtm3oZlb7OQyiiSZYiwb
         n1mg==
X-Gm-Message-State: AOAM532rfP9m2l3xBjks+LrwTBTAxBQvuyvik0/zrL2widLvVGyE4vTc
        O7XtbTe5K3dyN3mJ1XpTVncdT4hvZ/QD
X-Google-Smtp-Source: ABdhPJzHLhUkK0sbZJ+wWcmBR8J6P7yXgVyWf0qd7Fln2lMBrwIRo1ub7hHecfTdSVOahkHtW1uTeA==
X-Received: by 2002:a05:622a:34d:b0:2f3:44d9:41a8 with SMTP id r13-20020a05622a034d00b002f344d941a8mr14286734qtw.217.1650957975499;
        Tue, 26 Apr 2022 00:26:15 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id f127-20020a379c85000000b0069c921d6576sm6308392qke.76.2022.04.26.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:26:14 -0700 (PDT)
Date:   Tue, 26 Apr 2022 03:26:12 -0400
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
Message-ID: <20220426072612.7wgpzndigr4ybrh4@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
 <YmNH/fh8OwTJ6ASC@carbon>
 <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
 <YmZpuikkgWeF2RPt@dhcp22.suse.cz>
 <20220425152811.pg2dse4zybpnpaa4@moria.home.lan>
 <Ymeck8AaTwaB29KS@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymeck8AaTwaB29KS@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:17:39AM +0200, Michal Hocko wrote:
> I have already touched on that but let me reiterate. Allocation context
> called from the oom path will have an unbound access to memory reserves.
> Those are a last resort emergency pools of memory that are not available
> normally and there are areas which really depend on them to make a
> further progress to release the memory pressure.
> 
> Swap over NFS would be one such example. If some other code path messes
> with those reserves the swap IO path could fail with all sorts of
> fallouts.
> 
> So to be really exact in my statement. You can allocate from the OOM
> context but it is _strongly_ discouraged unless there is no other way
> around that.
> 
> I would even claim that the memory reclaim in general shouldn't rely on
> memory allocations (other than mempools). If an allocation is really
> necessary then an extra care has to prevent from complete memory
> depletion.

100% agreement with this, I've always made sure IO paths I touched were fully
mempool-ified (some of my early work was actually for making sure bio allocation
underneath generic_make_request() won't deadlock - previously allocated bios
won't make forward progress and be freed due to generic_make_request() turning
recursion into iteration, but that's all ancient history).

Anyways, the reason I think this allocation is fine is it's GFP_NOWAIT and it's
completely fine if it fails - all we lose is some diagnostics, and also it's
released right away.

But there's also no need for it to be a point of contention, the way I'm going
with printbufs it'll be trivial to mempool-ify this if we want.

Before I get back to this I'm changing the approach I'm taking with printbufs
and first using it to clean up vsnprintf() and all the related code, which is..
a bit of an undertaking. End result is going to be really cool though.
