Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D34586174
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiGaUvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaUvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:51:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ADE120BA
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 13:51:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id uk30so4824296ejc.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D1fnuTWJXlc2dukCsRsC5YQz2zD6ofMDDxPYK2SWWv4=;
        b=d4o7e56v6jaT/H39UmhsDACmb3MPAMvJJPhLDSCiN2LHVwivDQ648MIwKHekYwgCeK
         yNYv4J6/pOe8JmTVWy1w2wnXmQagkxahHOq+/eIYdSbqC1T6I7bBJiwyd+hqGrvUgq4Q
         pLQG2n9c3fDKVgK0znE3hVIfiq3PTKLVMybfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D1fnuTWJXlc2dukCsRsC5YQz2zD6ofMDDxPYK2SWWv4=;
        b=rTI1ahjDX1nAR9QRSetn0/aEDISyu43MOOPYN4AdKgZLzqZsb+IHXspXzcFM1/3Xg3
         CEIDZNhNwnMPmT3PnOIH9WIkPH2NfqOtYi6fU4jBQzYtSZLUfq4muXo5DSMxRPL67pZw
         D6vFtAe9cEqwzPmqkCHXGbap6oUaRFlhs31Wyi73e989RDg+Db9br9JqnUtq/l3xpMP1
         SyfFbSO7wYDLkl9/Z6C4ohyyZai09qmj30pI6hW9ZAs2FkIL+J8dvBw0fg/a+NCtu3RW
         NmNkzSPVwSlEX8H5Dz6qHlQ2N7DU1bivz7Gv3NkJPiQ1fZQvv91NUkDU5nbqekvlhA4p
         BJkw==
X-Gm-Message-State: AJIora/FDgkudcJ1/C4DJpd/qnqpMZ71wDhAppkAUto59LBG1Yn3vk21
        mQZDNmPLvf/AlgcUYfVtEeL5n0Tk2Kvk6qsB4JU=
X-Google-Smtp-Source: AGRyM1t+qdZTmbQTi3ZkFXHcQSnnY+BH7Gk6EOIs0xTbXnVZ3GMLd8N9RL/CVusG8hbnIHGAZfbxrQ==
X-Received: by 2002:a17:907:2723:b0:72b:5a8a:f983 with SMTP id d3-20020a170907272300b0072b5a8af983mr10348101ejl.635.1659300699221;
        Sun, 31 Jul 2022 13:51:39 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7cd07000000b0043a87e6196esm5783321edw.6.2022.07.31.13.51.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 13:51:38 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id v5so4914412wmj.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 13:51:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr9272114wmq.154.1659300698214; Sun, 31
 Jul 2022 13:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jul 2022 13:51:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmO0aWk_X5nKWEmquQ9VDzauKRW4oK4++0HNFgGo9Rvw@mail.gmail.com>
Message-ID: <CAHk-=wjmO0aWk_X5nKWEmquQ9VDzauKRW4oK4++0HNFgGo9Rvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] make buffer_locked provide an acquire semantics
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 31, 2022 at 1:43 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> +
> +static __always_inline int buffer_locked(const struct buffer_head *bh)
> +{
> +       unsigned long state = smp_load_acquire(&bh->b_state);
> +       return test_bit(BH_Lock, &state);

This should not use 'test_bit()'. I suspect that generates horrendous
code, because it's a volatile access, so now you'll load it into a
register, and I suspect it will generate s pointless spill just to do
a volatile load.

I didn't check.

So once you've loaded b_state, just test the bit directly with

    return (state & (1u << BH_Lock)) != 0;

or whatever.

              Linus
