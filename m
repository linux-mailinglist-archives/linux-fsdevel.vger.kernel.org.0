Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8676B5EDFD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiI1PLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiI1PKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:10:55 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C219C17;
        Wed, 28 Sep 2022 08:10:54 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id v28so7451704wrd.3;
        Wed, 28 Sep 2022 08:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a7vLBMT/E4442MupPoT+pHag9Mp/Q4EXWsrU1jJIFGw=;
        b=tAAMt2itvPRyxJJmUqv3YkESszzuv7uTdb2AuIijFAh3+XY5e94/6s90e8hqqGF54k
         xFxW7UpWTymbyDnJtStLY14GABtyNKkZBwn1VpvNWb9IsHfz9yQWMaEfLqzv9avXCflG
         L4N0ztZb4kHlpOnj26eXT/7Bp2IvSiITl97kgpLSG3D1ikaZFaxBmEq0iwdZFZQPjF9l
         yZlZ8NwIq8z6GSeTHJLEHkAzgtyvcZQDriShTQvB+R3dvADWvLgJK0eVD8S6eT0WokXX
         rQZ/gVtmjI3Rf+8FbqrFqqTbfYNKoDuuPH/sZQwCHyExsV3Wj8Cf/bwpRRijpUOsjGz8
         pKYw==
X-Gm-Message-State: ACrzQf0nwxYWCCk2GdCFKp8Q8tGR6ufdOR4blHRK4ux6ZhRPbbhMBdbe
        IBA/VChqtFmnbOZwp+U41KU=
X-Google-Smtp-Source: AMsMyM7LFfPMWiwrUKZs1m9whot2DEqwso07KVrBGjYZYygeqa1Kb9evcZNTDI1rLZa8b6y5zBrQ7g==
X-Received: by 2002:adf:f58a:0:b0:22c:be20:24e8 with SMTP id f10-20020adff58a000000b0022cbe2024e8mr5903192wro.245.1664377853246;
        Wed, 28 Sep 2022 08:10:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y3-20020a5d4ac3000000b0022ac672654dsm4642497wrs.58.2022.09.28.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:10:52 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:10:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 08/27] rust: adapt `alloc` crate to the kernel
Message-ID: <YzRj+47LIz2G9omo@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-9-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-9-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:39PM +0200, Miguel Ojeda wrote:
> +    /// Tries to append an element to the back of a collection.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut vec = vec![1, 2];
> +    /// vec.try_push(3).unwrap();
> +    /// assert_eq!(vec, [1, 2, 3]);
> +    /// ```
> +    #[inline]
> +    #[stable(feature = "kernel", since = "1.0.0")]
> +    pub fn try_push(&mut self, value: T) -> Result<(), TryReserveError> {
> +        if self.len == self.buf.capacity() {
> +            self.buf.try_reserve_for_push(self.len)?;
> +        }
> +        unsafe {
> +            let end = self.as_mut_ptr().add(self.len);
> +            ptr::write(end, value);
> +            self.len += 1;
> +        }

Missing safety comment here?

With a safety comment added:

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> +        Ok(())
> +    }
