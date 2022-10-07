Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39915F8113
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 01:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJGXRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJGXRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:17:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377480495
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 16:17:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so5952401pjk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VntPma6h9YXldWusKRirKa+AxvzlFLxSpnoOOvfbEY=;
        b=Lw5fVRNuMGTXDOBUV8sWh1sbwxiATNyFn5sU8LQHGlrdcjl2RO1zQMGM4h2Tmbbrg/
         dzR4AX2LEsdqHpEtq2VXT1AktDCi/eAxuoTHKd+2004AmAbkDVEQ2gpm5lwFjwdNDPKc
         hc/pJ0qDS8e7vs4IkKY5iNoPL2VqtIZCdDMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VntPma6h9YXldWusKRirKa+AxvzlFLxSpnoOOvfbEY=;
        b=QpDRICezwZqiaCT6jXxrdbu2IK9jrLEfx5oPc2hUS6Fhls7EwhO5AU1q9Q7SUcU/V9
         NrYeMV6WOW+rm5N+tGjOl2bhNK0kK3uIa70sf8dHOtt95aVp1d8FmsiU2cSTKwPlUHyv
         iugrze4U00ppOBcji1n2k4KBORD5V4RUzalx9xy3+yYYLHW5/wncLr+rurIcc103Kjnb
         gZ/L6E2F/JxWigZ+g8HCFCaekmISD8zARNpSKH4+hy/i+V0fBDphAkeb+riYOMU1Y5IR
         qqqpkwuix4III+f+XQk834t8gmemQhbN3ElEAPbqa5WmZ1z82jYJ3D0tTPZzq0B27uTd
         HiBQ==
X-Gm-Message-State: ACrzQf2MZOiojLK13snlNcTUV1ffApYeCKJfb1P1Iq19Nezis5xHNFDM
        Hc85n/6p58dfIMM7CfQyI/0vvg==
X-Google-Smtp-Source: AMsMyM6dsbNeWBcjJm9aRIb7GnG5PGfyHyuEE4bQKFj2jK/3xPcKVdrwJUFENovkupK3JRiP3BgzWw==
X-Received: by 2002:a17:902:b182:b0:178:8977:4013 with SMTP id s2-20020a170902b18200b0017889774013mr6762196plr.27.1665184657464;
        Fri, 07 Oct 2022 16:17:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b00562a0c8a195sm2155931pfz.69.2022.10.07.16.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 16:17:36 -0700 (PDT)
Date:   Fri, 7 Oct 2022 16:17:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Paul Kirth <paulkirth@google.com>
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
Message-ID: <202210071614.4297AB65D8@keescook>
References: <20190307090146.1874906-1-arnd@arndb.de>
 <20221006222124.aabaemy7ofop7ccz@google.com>
 <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com>
 <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
 <e554eb3c-d065-4aad-b6d2-a12469eaf49c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e554eb3c-d065-4aad-b6d2-a12469eaf49c@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:42:51PM +0200, Arnd Bergmann wrote:
> On Fri, Oct 7, 2022, at 9:04 PM, Nick Desaulniers wrote:
> > On Fri, Oct 7, 2022 at 1:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >> - The behavior of -ftrivial-auto-var-init= is a bit odd here: with =zero or
> >>   =pattern, the stack usage is just below the limit (1020), without the
> >>   option it is up to 1044. It looks like your .config picks =zero, which
> >>   was dropped in the latest clang version, so it falls back to not
> >
> > Huh? What do you mean by "was dropped?"
> >
> > The config I sent has:
> > CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
> > CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
> > CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> > # CONFIG_INIT_STACK_NONE is not set
> > CONFIG_INIT_STACK_ALL_ZERO=y
> 
> When I use this config on my kernel tree (currently on top of
> next-20220929 for unrelated work) and build with clang-16,
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO is disabled, so it falls
> back from CONFIG_INIT_STACK_NONE instead of the unavailable
> CONFIG_INIT_STACK_ALL_ZERO.

I think you have a very recent Clang but are building a tree that
doesn't have commit 607e57c6c62c ("hardening: Remove Clang's enable flag
for -ftrivial-auto-var-init=zero").

-- 
Kees Cook
