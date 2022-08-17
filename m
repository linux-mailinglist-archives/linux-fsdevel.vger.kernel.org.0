Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F815976B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiHQTgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbiHQTgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:36:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6857D70E6D
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:36:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d71so12780913pgc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DwQ4nsxbFKRBGX51s8IXcm7jc9sOynsnepHYnZvK+q8=;
        b=dDflZWLDwgLNEUqS2QSEf+EU9QySzBzklxHNtjMI6KEmn6Qm4yhXCaw+IjQWz0+EwN
         8dhgPlIueNI1tSl2rnGUbdr64cP3OayomPrD6oFw+uYC11PPeERBIAp8IzdvOOJ+cf6/
         /duC6UT3tzWyZkS281siFpZEZ4LqAen6po3cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DwQ4nsxbFKRBGX51s8IXcm7jc9sOynsnepHYnZvK+q8=;
        b=RuQZONlRUiT7flhLhwATfpj+eDN+KwvpMD05Dn+B/4q8Topee43NiBaUpn+oTQzOxv
         PU+g/J6tjFJJIAwJXKDpwbYaoaZe57BvxPda/sy/pymTvW75q9962q1fAbNGlYO9Z6vH
         d43vLqx6OfdQNvwK9Oj+Lm79fVQr3wsRJmU2XV2P1sxsP710q3qidFje/FAqena73O4s
         gmVTAOlDndLVhZAuWpO8IumCcsJNk8LsGAWvekQX63JxU0GhEbiuelDjIQMCWlsvL93C
         s0NNNHHMRbNH9/GKctWIjv4JYOFmdvj7aDUVXDQllJ5FEf0u/8yG0v+f8dPi21794shS
         TqPA==
X-Gm-Message-State: ACgBeo1cyAnacHKpaRdwJd1PfEPagVRtnWO3vT3Z8/Ppo9E5aBsvcZEi
        /ELYaKhGhTA6XRIYZlXWTuwwBw==
X-Google-Smtp-Source: AA6agR45Grj5WNJlJ+fDipgaBkC5y4R4JfAofjvtsISis6BMpiiepj37XY/6B9DM7K6AjAsyVP/0IA==
X-Received: by 2002:a63:8b44:0:b0:41c:df4c:7275 with SMTP id j65-20020a638b44000000b0041cdf4c7275mr23312562pge.434.1660764995806;
        Wed, 17 Aug 2022 12:36:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090a658800b001f55dda84b3sm1917520pjj.22.2022.08.17.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:36:34 -0700 (PDT)
Date:   Wed, 17 Aug 2022 12:36:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, boqun.feng@gmail.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
Message-ID: <202208171235.52D14C2A@keescook>
References: <20220805154231.31257-2-ojeda@kernel.org>
 <Yu2cYShT1h8gquW8@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu2cYShT1h8gquW8@yadro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 06, 2022 at 01:40:33AM +0300, Konstantin Shelekhin wrote:
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index f18e6dfc68c5..52f5488c61bc 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
> >  
> >  	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
> >  	if (rc != 3) {
> > -		if (rc != EOF && fgets(name, 500, in) == NULL)
> > +		if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
> >  			fprintf(stderr, "Read error or end of file.\n");
> >  		return NULL;
> >  	}
> 
> Might be another nit, but IMO it's better to use ARRAY_SIZE() here.

I'm not sure I see a benefit for char arrays. It'll produce the same
result, and the tradition for string functions is to use sizeof().
*shrug*

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
