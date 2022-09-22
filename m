Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57F85E67D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiIVP5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIVP5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:57:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87193E5FBC
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:57:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l10so9164808plb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DFca6W2geua6z8QZaei3L7obYL69ycUV+0eXMSxJFmM=;
        b=jvl2IXIRx3EhOhhqaTOf5Lt+fk9xx9Irq6xcu/7k7oCaAudZivnlCg4zfyCIBsgQa9
         qBtVWGjfuRNfAqWNaj6IsSNxrO0lvCUNMMis5T9m3env78npe1AQYwW4n7mGlSRQHwQP
         cG9vbxRd7c25yIHtYw1xafxyLneU1vdiRP2x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DFca6W2geua6z8QZaei3L7obYL69ycUV+0eXMSxJFmM=;
        b=cDoAGkaBEfX2jK3afVW+bZLIDkzagp2w34mde993KtDkm8WlZiSp//qpcCvwFoGPGg
         8+3VfLAowZ5hHT0lyRT8uGZVM9KiSfconn3Z/XSgrRNv/a1PQB1EYyt6Yi+L+alfdp2p
         QhUibuGdxuWTWwIRVl8VIr1Cb3py4OD0GQ2Ao5rrAPvlqxo8AR9lwG6jgTHMB3Bhvknu
         yKTVzFqr91JC5LlHccNtYTaICKuWedoMFdw/fgW+xKbPzcDiESy2jBBkRfNmnQFEKcjV
         qICpzPumqOb1FMrS/gB+35qPhTekA4ef5s28U072Jdr86AhW0SKKhbfiAVlVB1JQJTOt
         p5Aw==
X-Gm-Message-State: ACrzQf3iQ9yW5gws+I6q3FdJ0qZdp5zL5rtMS+xAYJvm5oXK3jihofAY
        nuMtsEkiY2mNKS6Qu8AQ9qC6iQ==
X-Google-Smtp-Source: AMsMyM4DbOcH8T52s44Y0t4Ur0sebk5QTw9RJNQKJ+FFAkxJV0gLFIOVmBX/n1oFJJpAp4+llFExqQ==
X-Received: by 2002:a17:902:e848:b0:176:c746:1f69 with SMTP id t8-20020a170902e84800b00176c7461f69mr3892270plg.125.1663862268452;
        Thu, 22 Sep 2022 08:57:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p63-20020a625b42000000b005367c28fd32sm4575617pfb.185.2022.09.22.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:57:47 -0700 (PDT)
Date:   Thu, 22 Sep 2022 08:57:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Elder <elder@ieee.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jacob Shin <jacob.shin@amd.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, dev@openvswitch.org,
        x86@kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/12] net: ipa: Proactively round up to kmalloc bucket
 size
Message-ID: <202209220857.A6EBCF031E@keescook>
References: <20220922031013.2150682-1-keescook@chromium.org>
 <20220922031013.2150682-4-keescook@chromium.org>
 <4d75a9fd-1b94-7208-9de8-5a0102223e68@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d75a9fd-1b94-7208-9de8-5a0102223e68@ieee.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:45:19AM -0500, Alex Elder wrote:
> On 9/21/22 10:10 PM, Kees Cook wrote:
> > Instead of discovering the kmalloc bucket size _after_ allocation, round
> > up proactively so the allocation is explicitly made for the full size,
> > allowing the compiler to correctly reason about the resulting size of
> > the buffer through the existing __alloc_size() hint.
> > 
> > Cc: Alex Elder <elder@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/net/ipa/gsi_trans.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
> > index 18e7e8c405be..cec968854dcf 100644
> > --- a/drivers/net/ipa/gsi_trans.c
> > +++ b/drivers/net/ipa/gsi_trans.c
> > @@ -89,6 +89,7 @@ int gsi_trans_pool_init(struct gsi_trans_pool *pool, size_t size, u32 count,
> >   			u32 max_alloc)
> >   {
> >   	void *virt;
> > +	size_t allocate;
> 
> I don't care about this but the reverse Christmas tree
> convention would put the "allocate" variable definition
> above "virt".

Oops, yes; thank you!

-Kees

-- 
Kees Cook
