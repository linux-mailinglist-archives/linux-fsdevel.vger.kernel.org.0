Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C396A89CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCBTyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBTyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:54:05 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142A3597
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 11:54:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u5so424812plq.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677786844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPgYLv6lYLGlNO2NPrtA30mIkNmqpF6DOGQTD6NOI2A=;
        b=WKq6nYU84T2GjPSgPjLMj9ONaPARuYK2Ad1yuOY9DGsrWGFj4WkxocR+EUW8FzXS3b
         gRhB85J69pU6QwBznfn2qrPRqHCBWvVviIwWCquS8XE50Qj43ZRvtcwrIPd85CbMEmST
         /F27/4fHRumBexB2mG/pPQnN/EtVFvZMzZlFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677786844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPgYLv6lYLGlNO2NPrtA30mIkNmqpF6DOGQTD6NOI2A=;
        b=tIkBsKyix5znJnfAmhJ8dAjUbvLcQucQ2TUa1/11qijxKfxNcKgwnc8eJrfpxQvIQq
         0TMaaVZfZ6nd86Kgp35rolDP/h7wR5USVsyUApe5jsVash4Gh4btXRbK0LPft85kGLZe
         v7hQz8VA8sIF9xs8HVTASnxH7wLHVmy3JXqrjrGg2Hsky4S/RV1zENsNvFOezsoH3o0n
         kamwIA1VfvXHB35m0fTJ1hJekB+xUQsz6QUCXAjf8owVlmwr2L8qLT0D3z8BYWvzN7Ay
         HsQv8obVmHyZE/Id3LdliN1wkN2jUq1d+5gQgQ1ec+zxtIf/mUIMjt5LHWJ7DNV5pG5g
         olxA==
X-Gm-Message-State: AO0yUKWr2DoJ5GHaPkzukXeaE6S0J3Lg9r3FjO5ZgJeDwr4ceyVD5TSC
        fK7qGehHm6ZLKuYUCfdaLFkPqQ==
X-Google-Smtp-Source: AK7set8cMneRnOzUf9HmSOrEyAAAr/zXjrTqsx0CeaOdpGYWa/1YP+GHIynAJwhigY5dwhd8TZ5YQA==
X-Received: by 2002:a17:902:c946:b0:19c:d401:ecb with SMTP id i6-20020a170902c94600b0019cd4010ecbmr12199825pla.63.1677786844233;
        Thu, 02 Mar 2023 11:54:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b0019c13c4b175sm72200plf.189.2023.03.02.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:54:03 -0800 (PST)
Message-ID: <6400fedb.170a0220.ece29.04b8@mx.google.com>
X-Google-Original-Message-ID: <202303021147.@keescook>
Date:   Thu, 2 Mar 2023 11:54:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
References: <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAD21ZEiB2V9Ttto@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 07:19:49PM +0000, Al Viro wrote:
> On Thu, Mar 02, 2023 at 11:10:03AM -0800, Linus Torvalds wrote:
> > On Thu, Mar 2, 2023 at 11:03 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
> > > just to make it possible to say - exactly in situations like this -
> > > that this particular slab cache has no advantage from pre-zeroing.
> > 
> > Actually, maybe it's just as well to keep it per-allocation, and just
> > special-case getname_flags() itself.
> > 
> > We could replace the __getname() there with just a
> > 
> >         kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO);
> > 
> > we're going to overwrite the beginning of the buffer with the path we
> > copy from user space, and then we'd have to make people comfortable
> > with the fact that even with zero initialization hardening on, the
> > space after the filename wouldn't be initialized...
> 
> ACK; same in getname_kernel() and sys_getcwd(), at the very least.

FWIW, much earlier analysis suggested opting out these kmem caches:

	buffer_head
	names_cache
	mm_struct
	anon_vma
	skbuff_head_cache
	skbuff_fclone_cache

Alexander's analysis more recently[2] of skbuff went a bit further,
I think, and allowed opt-out for non-kmem cache page allocations too.

-Kees

[1] https://lore.kernel.org/all/20190514143537.10435-5-glider@google.com/

-- 
Kees Cook
