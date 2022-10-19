Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA90604FEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJSSv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 14:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJSSvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:51:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA261958F1;
        Wed, 19 Oct 2022 11:51:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id iv17so13512649wmb.4;
        Wed, 19 Oct 2022 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0fcZsMcV++wS9erLfLUrZhIdXu0ptY0D42u7+sQS44=;
        b=A6k7IHBKKTdEorIYyQ8sm/RETfOUEOuUs3QMPWIf+PUUCAIsYxKo21Umb8weTkNBGL
         x2PqEJdO/GX68SAbe2PFJQeCkds+ahIEc33DZTunh0P4OYWVfHhIR79mbmwqFhQQdYLN
         MZ7EKivr8evJFFgr5fKpq4IUdYXmk+v1aQ6IS6OSUTwPim2yEGeVd+eVStoFiqBYGIdo
         w5YTNbmGLIf27S83D2rXLLB3Dr+pHCrvV8Yf4WC2YqiGQXwkBYqIvpnbvn+a6y1aFa+v
         zi8f5dnmcNywcRLH+MKgkUoGPvkOqAs9F9uDoqslqKjxbUEWsZuxBLE9prbSYhevEajv
         g5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0fcZsMcV++wS9erLfLUrZhIdXu0ptY0D42u7+sQS44=;
        b=FxAWP7GQ/21rev+Q6WqKgXuTQP3h+l6B25DdxW7HlXHI60J4Foj9WzmW9yf39tXiRG
         0HZmNRiNscxAq6n2YG10yugGuFTbPgjBE+rDrlEgDvVYS5Hw+TACwsruMF6bF8sAPgc4
         KhMMpMf5SPp0dsRVztuaV46WxEzeIN2XmhN7swuGRx/CsnxgA3Ecxnv1z2XdDbNqL15y
         sRckjmFU03HrmpYBjy6YJYCf+68w9q9y9gM4i6IkHhIx3IgClKkXDeuEKE414Pchu4MC
         kKmcT8TiAFFpCsbuJxJVvmhSDN0Yl45QO0VhKDmshqfrZ4OaVnWM1RbQBSuc1Vj7CW8c
         f7eA==
X-Gm-Message-State: ACrzQf1Udl3Yf9qzc/1UyvUp2ntm9z0hRLEn/BLF1Qk8isvik85diRWk
        7lbbCEyFSX5XOfDp/v61VKo=
X-Google-Smtp-Source: AMsMyM5iTchuKTIwIWt5w3AMhqFK6E0+OXpdSL9Vj55lRMD+setBVuVAXjy14gOhWb9svY4clcmtxQ==
X-Received: by 2002:a05:600c:ad7:b0:3c6:facf:1f5f with SMTP id c23-20020a05600c0ad700b003c6facf1f5fmr10000295wmr.171.1666205511436;
        Wed, 19 Oct 2022 11:51:51 -0700 (PDT)
Received: from mypc.localnet (host-82-59-43-249.retail.telecomitalia.it. [82.59.43.249])
        by smtp.gmail.com with ESMTPSA id dn3-20020a05600c654300b003a5f3f5883dsm731312wmb.17.2022.10.19.11.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:51:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Wed, 19 Oct 2022 20:52:04 +0200
Message-ID: <2851287.e9J7NaK4W3@mypc>
In-Reply-To: <x49h6zzvn1a.fsf@segfault.boston.devel.redhat.com>
References: <20221016150656.5803-1-fmdefrancesco@gmail.com> <x49h6zzvn1a.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, October 19, 2022 5:41:21 PM CEST Jeff Moyer wrote:
> "Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:
>=20
> > The use of kmap() and kmap_atomic() are being deprecated in favor of
> > kmap_local_page().
> >
> > There are two main problems with kmap(): (1) It comes with an overhead =
as
> > the mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when t=
he
> > kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> > utilized until a slot becomes available.
> >
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, t=
he
> > kernel virtual addresses are restored and still valid.
> >
> > Since its use in fs/aio.c is safe everywhere, it should be preferred.
>=20
> That sentence is very ambiguous.  I don't know what "its" refers to, and
> I'm not sure what "safe" means in this context.

I'm sorry for not being clearer.

"its use" means "the use of kmap_local_page()". Few lines above you may als=
o=20
see "It is faster", meaning "kmap_local_page() is faster".

The "safety" is a very concise way to assert that I've checked, by code=20
inspection and by testing (as it is better detailed some lines below) that=
=20
these conversions (1) don't break any of the rules of use of local mapping=
=20
when converting kmap() (please read highmem.rst about these) and (2) the ca=
ll=20
sites of kmap_atomic() didn't rely on its side effects (pagefaults disable =
and=20
potential preemption disables).=20

Therefore, you may read it as it was: "The use of kmap_local_page() in fs/
aio.c has been carefully checked to assure that the conversions won't break=
=20
the code, therefore the newer API is preferred".

I hope it makes my argument clearer.

>=20
> The patch looks okay to me.
>=20
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>=20

Thank you so much for the  "Reviewed-by" tag.

Regards,

=46abio=20




