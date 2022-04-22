Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720E050B455
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350687AbiDVJrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 05:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446201AbiDVJrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:47:15 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E75553B7E;
        Fri, 22 Apr 2022 02:44:16 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a5so5637448qvx.1;
        Fri, 22 Apr 2022 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UcveCi2DaIN2/KSCk6hBDKNXuFrosOlo6laoUxh4W9g=;
        b=Nl0NCVZlpHcgEFTHsNvXnmfaN9kpdjAiLg7axGQJrxeBtLMw5/R03Xf5Tk0MBtLE1J
         n5A1sSjQEc2LAFnnnVQSBjQlp5tswwF05kglqNyvJIjiic+7pUu3GRiI34mYLcSZxFel
         hcogw0SQN8aLYXZHnAG1/2mWirNc9rp3en1Wake6MguWKkSuilZ3xOTYKi66K8ISgFJy
         gHf9JMVmDpHkzP4jEgWdKzufmM/btYHXCyOBhrJMI7NOypKAcXAumRmpwEzsLinPmP7b
         mOBRoQYbl7O8QG8U/WDilP5bBFEmQPvFjagIRxcvEdhVo2Am7WDe3sekTXm9S/hq4VP/
         VesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcveCi2DaIN2/KSCk6hBDKNXuFrosOlo6laoUxh4W9g=;
        b=7JsmcrXu2u4vo8SNY7Pexw4v149FIPEXO3kgOxOnvdEvkHCwpQ8Bjg41/v1kqV5k/o
         /Vd5NDgJShCEI2YviCfcKecELB+JzQJig3gdBdgHiBjamhcoz8bstW4uBKwjWgPx5iuB
         LNxs4hlfGbj3Ptkb5CSNY081tosa5WjNaL8ANAU3gmrxzGGvJPhMfH/NXR1GBKR+fay0
         Q8rECs1en87BNqmrsJ+xuIn+9hMapsX6S42Uz3KxRQutGxsaBJgn+fAXs+6qyxdodXxa
         NBCYq3fGAI8oIec2whAoP5IPFCUTyfrVXG6Q3jjB93q2NtJZF8fP41Q3FHDdvxprQ447
         xRlw==
X-Gm-Message-State: AOAM531MMRETOIYvIgl9A/AUx+NwxrZEogbKsSP34CypMwfOIuqkjFmW
        pscKe5g8n6nXnEazL7Ap926zORhmsfiP
X-Google-Smtp-Source: ABdhPJyYfLrGLQNtjreIBelDOsFYXAjNfMntgtcIFvmkDRKUQsrsFpgGCmUtr7v+vz6OLBy7Qr+cQQ==
X-Received: by 2002:ad4:5389:0:b0:42e:90eb:1f7d with SMTP id i9-20020ad45389000000b0042e90eb1f7dmr2842265qvv.103.1650620656115;
        Fri, 22 Apr 2022 02:44:16 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j12-20020a05622a038c00b002f340aeffb3sm984621qtx.85.2022.04.22.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:44:15 -0700 (PDT)
Date:   Fri, 22 Apr 2022 05:44:13 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <20220422094413.2i6dygfpul3toyqr@moria.home.lan>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
 <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
 <20220420165805.lg4k2iipnpyt4nuu@moria.home.lan>
 <YmEhXG8C7msGvhqL@dhcp22.suse.cz>
 <20220421184213.tbglkeze22xrcmlq@moria.home.lan>
 <YmJhWNIcd5GcmKeo@dhcp22.suse.cz>
 <20220422083037.3pjdrusrn54fmfdf@moria.home.lan>
 <YmJ06cEyX2u4DGtD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJ06cEyX2u4DGtD@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:27:05AM +0200, Michal Hocko wrote:
> We already do that in some form. We dump unreclaimable slabs if they
> consume more memory than user pages on LRUs. We also dump all slab
> caches with some objects. Why is this approach not good? Should we tweak
> the condition to dump or should we limit the dump? These are reasonable 
> questions to ask. Your patch has dropped those without explaining any
> of the motivation.
> 
> I am perfectly OK to modify should_dump_unreclaim_slab to dump even if
> the slab memory consumption is lower. Also dumping small caches with
> handful of objects can be excessive.
> 
> Wrt to shrinkers I really do not know what kind of shrinkers data would
> be useful to dump and when. Therefore I am asking about examples.

Look, I've given you the sample output you asked for and explained repeatedly my
rationale and you haven't directly responded; if you have a reason you're
against the patches please say so, but please give your reasoning.
