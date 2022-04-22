Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA350B5CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446979AbiDVLBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiDVLBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:01:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F85623A;
        Fri, 22 Apr 2022 03:58:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id f14so5226307qtq.1;
        Fri, 22 Apr 2022 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QypjtVLosJi9K+p/leRPpb/U1nKpemLV34xYlxrVTho=;
        b=Yhd2wyuoROb2LgW9En5TdALxryVE8CW8M13ZqC/KTkBxqiEruz7oeltFzq5Yaqn6r4
         8g+isYsvK0tKt9V+PoB/eg3GTYt2UTmD42NM7YU+6eW9g2j19eEEegShfpWl03nEy85Z
         iukDLpCwRwn1Dh/tcBqUVLFWEB44tLzipW2w/81L4YD4ZBEo9DGjMCizjaEzSyiWA8J9
         gjmdqMtrHjuyOLx7c+OO1hX2hP/IojXwBrIQpBI9Ob1ulq+XUCf4udBoTzaBIG34gl4r
         hcd3IKtiOXdY/Rt7S8ynKR61wOcBDET5LJlaOUa8cXXoTN1CqIfwCtFcfOOCo7o9QNnw
         2UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QypjtVLosJi9K+p/leRPpb/U1nKpemLV34xYlxrVTho=;
        b=pDNQZbIvnTN/JXgE5C/oy1FcbRuAJEXv6XWtT9r6bBDwepuYAE2qgerj33mDkDDGER
         4/se9rQLJuV480rT/0dkI2HEfPFHjGmidueTplzMW72ZhkyBQd36u1EEywhaqvoOQeug
         /7xFUQWmABgTnEGye7pGfkzbHEMSD2COAlsl8XAIPVE2t0JQ/TeWHxXVzMWzrmr8eWWr
         +q3IvQEnX6A+jj13o1fDBn5AhnK+Hc3V0mBZdHS5L59L3iVwURuK8kcJs/RtoNfvQr7t
         ETlHjitEh3HKZl/ASsQlzwub1fecEWWHuTnhkl+690+Df/U1LWFEa76xy+EP8wYBbo4B
         kGJQ==
X-Gm-Message-State: AOAM5325U6Whoz9N29iORt5FTseKSku2gdlBoZuYd5ckrNrj0A7rzzrV
        Gs3ZWKesjkYTJ69Nv0lMfA==
X-Google-Smtp-Source: ABdhPJyUw/DBNTUoA6r40E+V89EntU+6CVJ8v221kGQcJMu0tV7OZdPe5zSdIMrn6qY9Sjzvn+xQ/A==
X-Received: by 2002:ac8:70da:0:b0:2f1:d195:cfaf with SMTP id g26-20020ac870da000000b002f1d195cfafmr2596174qtp.247.1650625123494;
        Fri, 22 Apr 2022 03:58:43 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id c13-20020a37e10d000000b0069c268c37f1sm768427qkm.23.2022.04.22.03.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:58:42 -0700 (PDT)
Date:   Fri, 22 Apr 2022 06:58:40 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <20220422105840.wsrlxt3emw4vagcm@moria.home.lan>
References: <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
 <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
 <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
 <YmJhWNIcd5GcmKeo@dhcp22.suse.cz>
 <20220422083037.3pjdrusrn54fmfdf@moria.home.lan>
 <YmJ06cEyX2u4DGtD@dhcp22.suse.cz>
 <20220422094413.2i6dygfpul3toyqr@moria.home.lan>
 <YmKInWEihG+7mkU6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmKInWEihG+7mkU6@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:51:09PM +0200, Michal Hocko wrote:
> On Fri 22-04-22 05:44:13, Kent Overstreet wrote:
> > On Fri, Apr 22, 2022 at 11:27:05AM +0200, Michal Hocko wrote:
> > > We already do that in some form. We dump unreclaimable slabs if they
> > > consume more memory than user pages on LRUs. We also dump all slab
> > > caches with some objects. Why is this approach not good? Should we tweak
> > > the condition to dump or should we limit the dump? These are reasonable 
> > > questions to ask. Your patch has dropped those without explaining any
> > > of the motivation.
> > > 
> > > I am perfectly OK to modify should_dump_unreclaim_slab to dump even if
> > > the slab memory consumption is lower. Also dumping small caches with
> > > handful of objects can be excessive.
> > > 
> > > Wrt to shrinkers I really do not know what kind of shrinkers data would
> > > be useful to dump and when. Therefore I am asking about examples.
> > 
> > Look, I've given you the sample
> 
> That sample is of no use as it doesn't really show how the additional
> information is useful to analyze the allocation failure. I thought we
> have agreed on that. You still haven't given any example where the
> information is useful. So I do not really see any reason to change the
> existing output.
> 
> > output you asked for and explained repeatedly my
> > rationale and you haven't directly responded;
> 
> Your rationale is that we need more data and I do agree but it is not
> clear which data and under which conditions.

You're completely mischaractarizing and making this _way_ more complicated than
it has to be, but I'll repeat:

- For the slab changes, top 10 slabs in sorted order, with human readable units
  are _vastly_ easier on human eyes than pages of slab output, in the previous
  format

- Shrinkers weren't reported on before at all, and as shrinkers are part of
  memory reclaim they're pretty integral to OOM debugging.

> > if you have a reason you're
> > against the patches please say so, but please give your reasoning.
> 
> I have expressed that already, I believe, but let me repeat. I do not
> like altering the oom report without a justification on how this new
> output is useful. You have failed to explained that so far.

Uh huh.

Sounds like someone has some scripts he doesn't want to have to update.
