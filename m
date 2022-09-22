Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8E5E6EC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 23:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiIVVtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiIVVtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:49:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74071FF3E4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 14:49:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so11120190pjg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=HR7XDnra6aPtamhjv2ZebPHNXJTov7JqNOvsimryjio=;
        b=SzXIxv6C1tCw5E3cmrWDJ/hT6jlBfbW+dFuRj81LBsGuMMA1AsgUJRpxwVsVSvwR2s
         HjojE3kOc43go5tDIXGrMTl5j+2eCPTyOeyLkDKEdQ6zWs58EaHgr7cs3m2ezx/7gyPH
         QYSAs2hvSa7UX6V/rYFn8OuKvubD7Tx83ZZcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HR7XDnra6aPtamhjv2ZebPHNXJTov7JqNOvsimryjio=;
        b=f2Oi0YnH0rMu7XHcQ0UbuUMdx1umbnS5CsDrMHNX+E7sOl3LBCKRP4DsqbyasJm3lc
         L5JWLU3IMVKzQnDEX0S+CPvnX+htc8MMrnFhM3BHfRC4xFtCic0rKtGm2n6zjlepnZff
         9HPGjMskDa1SjKcT6wW+EF8kHInqz0hHRfX0/o8BjkaFYtHz9gU0tdik4L78tkkFoQlJ
         vRLSzxG4upzmXGLZBsTIHBqzLJAvchRI4+3w+vosSBtS+ZNN7v81awbP4YQ16XK9Hf0/
         3c4aTa0/E9pliTfO9+B6HLEYOpK4bNffIFJ+jeeKeAuImg4KsrsiO5m5M7pHHIl7XrGS
         MZZQ==
X-Gm-Message-State: ACrzQf1Hup4VDIuMBb57MDkNDLAZ+XhYn/SNyxfv55wL3XTyLOHaNoZA
        3NVnOAGdCeIQ8krIcHuIRlquLQ==
X-Google-Smtp-Source: AMsMyM7EVCvewBY8ReI9lCX0qEaIkOeoxfNJfZf95NgQUB74fHJwtUZioqBUOFwe31SWjNTGJEPjqg==
X-Received: by 2002:a17:902:d2d2:b0:177:4940:cc0f with SMTP id n18-20020a170902d2d200b001774940cc0fmr5257349plc.4.1663883350927;
        Thu, 22 Sep 2022 14:49:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b00176acc23a73sm4597636plx.281.2022.09.22.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 14:49:10 -0700 (PDT)
Date:   Thu, 22 Sep 2022 14:49:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Pekka Enberg <penberg@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        dev@openvswitch.org, x86@kernel.org,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 00/12] slab: Introduce kmalloc_size_roundup()
Message-ID: <202209221446.5E90AEED@keescook>
References: <20220922031013.2150682-1-keescook@chromium.org>
 <673e425d-1692-ef47-052b-0ff2de0d9c1d@amd.com>
 <202209220845.2F7A050@keescook>
 <cb38655c-2107-bda6-2fa8-f5e1e97eab14@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb38655c-2107-bda6-2fa8-f5e1e97eab14@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:05:47PM +0200, Vlastimil Babka wrote:
> On 9/22/22 17:55, Kees Cook wrote:
> > On Thu, Sep 22, 2022 at 09:10:56AM +0200, Christian König wrote:
> > [...]
> > > So when this patch set is about to clean up this use case it should probably
> > > also take care to remove ksize() or at least limit it so that it won't be
> > > used for this use case in the future.
> > 
> > Yeah, my goal would be to eliminate ksize(), and it seems possible if
> > other cases are satisfied with tracking their allocation sizes directly.
> 
> I think we could leave ksize() to determine the size without a need for
> external tracking, but from now on forbid callers from using that hint to
> overflow the allocation size they actually requested? Once we remove the
> kasan/kfence hooks in ksize() that make the current kinds of usage possible,
> we should be able to catch any offenders of the new semantics that would appear?

That's correct. I spent the morning working my way through the rest of
the ksize() users I didn't clean up yesterday, and in several places I
just swapped in __ksize(). But that wouldn't even be needed if we just
removed the kasan unpoisoning from ksize(), etc.

I am tempted to leave it __ksize(), though, just to reinforce that it's
not supposed to be used "normally". What do you think?

-- 
Kees Cook
