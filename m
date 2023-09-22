Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8A7AB9A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjIVSvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjIVSvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:51:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83750AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so320638866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695408706; x=1696013506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=FaPDT8B5cyjl0XRxvrxoCfBKIU6Tjk8TycxNF/KS17PgcgdnUGUoF2m94Bw3BDqsSh
         vqkSlbpkjXp/m68rymiB5C2I4FpZvJvZpXMuV8+qGtCsYzhAFeAkU7jVNVjFOaG8jMRS
         tCyamDSFoilJgPyjciOUL0pZX1lcFBF6IMcpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408706; x=1696013506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=PNB08AohhieG1eID2DOlvdp/R0ejeEkC6QQl25qAifFG5y17hZzk6012JL1uTdkKLk
         v/OhFT9pnAXNEn7GjCZaYbyJNZWxQKlJo7nxb0m3tQYMl+d8qL9yqEq4jN4gjUEiCayu
         QejBGbPWHwRej46vb5Ae9o4EDZyfV4vpvHFMzZFyhp11x94CrGmhCwagBOfXaYF2m6+1
         5HBOpN1j16L1W1/HhyCZlSLsi2FBlSKp/Tl2LcjCh7T4/LwXQR8k5f8ypaYNavdtXoAj
         vFjFbUHFRL1Bh65m324tSs0CCrPu46xsMeXuAyOBvWL9avIGRZFnYAlMKHMhPzerB3mI
         iwoA==
X-Gm-Message-State: AOJu0YxZN5O9hAq/X062zlYsUILHLsPt8nRPpuYFQbUKw4AszoZvVdNM
        LFDq77apJliPTNolMNneCVQgOVzKI4jC4GnMSDD3ExJ/
X-Google-Smtp-Source: AGHT+IErLMATQd9ertTwk7pZzjXUUVfsx9/+JGf0GEXTov+KPT0b97ZTnRd2tkfNCFqx9sQPVOb2nw==
X-Received: by 2002:a17:906:f116:b0:9ae:68dc:d571 with SMTP id gv22-20020a170906f11600b009ae68dcd571mr189616ejb.46.1695408701223;
        Fri, 22 Sep 2023 11:51:41 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b009a1e0349c4csm3049902ejy.23.2023.09.22.11.51.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 11:51:40 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5335d9045b4so2005252a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:40 -0700 (PDT)
X-Received: by 2002:aa7:c98b:0:b0:533:310b:a8aa with SMTP id
 c11-20020aa7c98b000000b00533310ba8aamr309019edt.13.1695408696292; Fri, 22 Sep
 2023 11:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-10-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-10-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Sep 2023 11:51:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] iov_iter: Add a kernel-type iterator-only
 iteration function
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Sept 2023 at 05:03, David Howells <dhowells@redhat.com> wrote:
>
> Add an iteration function that can only iterate over kernel internal-type
> iterators (ie. BVEC, KVEC, XARRAY) and not user-backed iterators (ie. UBUF
> and IOVEC).  This allows for smaller iterators to be built when it is known
> the caller won't have a user-backed iterator.

This one is pretty ugly, and has no actual users.

Without even explaining why we'd care about this abomination, NAK.

If we actyually have some static knowledge of "this will only use
iterators X/Y/Z", then we should probably pass that in as a constant
bitmask to the thing, instead of this kind of "kernel only" special
case.

But even then, we'd want to have actual explicit use-cases, not a
hypothetical "if you have this situation here's this function".

                 Linus
