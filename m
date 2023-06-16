Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23AE733C7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 00:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjFPWkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 18:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjFPWkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:40:13 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3630EA
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 15:40:12 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b44b5adfd3so914209a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686955211; x=1689547211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eewBVDe5nNaSM8dqadQLKOlfMcQrNasJb6oD7oBFQEQ=;
        b=yLrgJ99p9qAqQys+W37noyN5JmKqgwDiiXsqJ7W3WKnxgFxaGJ8xqpnq3KJA5VuECG
         ISMC49kXDH1TMP8r+9kvepi5TOHJzElrK7adriCF4T97Q+0wzyG3lAU0sStnF1sV3hZV
         eQItJbyiN4wcTFyc6uwqTwQ85BgrRS2K9eVxnhyBboZgF0K6vJ5Lo/Lfw966X3hlBwNs
         mZB7U61oVMnWSV4MqTxQcvES6lFIaC4xSWPStZCWLoCRpwYhbjNyEjoVPa3WcIDgRfc4
         tFN7DL9I45R7fSTc3aX3G0wK6Tm9BElXVmRwAjkWtirXq+f8n4NaCx38kMpbwXkjlRGf
         4A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686955211; x=1689547211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eewBVDe5nNaSM8dqadQLKOlfMcQrNasJb6oD7oBFQEQ=;
        b=TIWt3/0NgzNNA4u0IG3LZXZ8XpfZB+gjuCmm2Vyz2c2VXeheSEIGIwFmeEjXabmztX
         TKcnxUtu6LBkcXsqqJ4TvKR9xiWigRajluoAgE7cFE6uTn/6PaoMLtuOketvM5N1Yh+V
         Z3oJhVXX4eTmk2m0dUPtSlQ7j9/id+k8/WegYOfw30GhyKhHpG6LuwJraDB1ypjcmz5O
         wAj+5jCPwKEfzO022567LksO8zrdr4IBl2JA1kJUeIboZxdvsjdIOcK2yIonafvcroMj
         2UFvPsUK5rN8+919Yf8Rp46a72igjgwGKNYpANgqO19ntqJHAqfVtpSImXadGN3K7AIG
         hLGQ==
X-Gm-Message-State: AC+VfDzSlBX+OIHJjHrbJ9HEMALeH/FCxJytiQQhwpDAPmDg/nvlwmSK
        f1MaxjCawW4IO4bYQ14q1R6ZW4OpKeDDYpWlABo=
X-Google-Smtp-Source: ACHHUZ7AZ8wn+x1kFKZKUqhmT/4coujbqi6Q5vEhyuvPN9oOMO8Tz6/cDPwzj7fGJ7HceKMbb5xx9Q==
X-Received: by 2002:a05:6358:e816:b0:12b:eac7:fd7b with SMTP id gi22-20020a056358e81600b0012beac7fd7bmr500416rwb.17.1686955211305;
        Fri, 16 Jun 2023 15:40:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id a15-20020a62e20f000000b00666777bda00sm4177438pfi.110.2023.06.16.15.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 15:40:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qAI6x-00Cdf2-0g;
        Sat, 17 Jun 2023 08:40:07 +1000
Date:   Sat, 17 Jun 2023 08:40:07 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 6/8] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZIzkx1JukDlBE8hp@dread.disaster.area>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-7-willy@infradead.org>
 <ZIeg4Uak9meY1tZ7@dread.disaster.area>
 <ZIe7i4kklXphsfu0@casper.infradead.org>
 <ZIfGpWYNA1yd5K/l@dread.disaster.area>
 <ZIfNrnUsJbcWGSD8@casper.infradead.org>
 <ZIggux3yxAudUSB1@dread.disaster.area>
 <ZIyfx+ISChR8S+fC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIyfx+ISChR8S+fC@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 06:45:43PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 13, 2023 at 05:54:35PM +1000, Dave Chinner wrote:
> > If I hadn't looked at the code closely and saw a trace with this
> > sort of behaviour (i.e. I understood large folios were in use,
> > but not exactly how they worked), I'd be very surprised to see a
> > weird repeated pattern of varying folio sizes. I'd probably think
> > it was a bug in the implementation....
> > 
> > > I'd prefer the low-risk approach for now; we can change it later!
> > 
> > That's fine by me - just document the limitations and expected
> > behaviour in the code rather than expect people to have to discover
> > this behaviour for themselves.
> 
> How about this?
> 
> +++ b/include/linux/pagemap.h
> @@ -548,6 +548,17 @@ typedef unsigned int __bitwise fgf_t;
> 
>  #define FGP_WRITEBEGIN         (FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
> 
> +/**
> + * fgf_set_order - Encode a length in the fgf_t flags.
> + * @size: The suggested size of the folio to create.
> + *
> + * The caller of __filemap_get_folio() can use this to suggest a preferred
> + * size for the folio that is created.  If there is already a folio at
> + * the index, it will be returned, no matter what its size.  If a folio
> + * is freshly created, it may be of a different size than requested
> + * due to alignment constraints, memory pressure, or the presence of
> + * other folios at nearby indices.
> + */
>  static inline fgf_t fgf_set_order(size_t size)
>  {
>         unsigned int shift = ilog2(size);

Yup, I'm happy with that - "preferred size" is a good way of
describing the best effort attempt it makes....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
