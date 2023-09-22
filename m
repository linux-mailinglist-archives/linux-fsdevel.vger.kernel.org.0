Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECD47AB614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjIVQfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVQfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:35:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E003139
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 09:35:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so6069283a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695400508; x=1696005308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=VXldlrG11szZBfan3YaFaOg1qRTFUXItPvz+d594Ed/RZo0X8fDhhFTcT+Tfee5VSP
         yLE9fyNVXNnPLkw0gSESTe8Z8WM+wGotLZjHCgzE0IfCnJJtL1u/7KVdSA3g4FbBQDNs
         0yJxayfVAnOtmdEA4zWcMbTKTM0gvJiAOw2es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400508; x=1696005308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOhjx56+C1/SUOCT4pJr+RaAn7PBsJsy8c2/c8L0wsg=;
        b=AIp3D8IYFJFMEAJYi07QYs7xfIU1hYATF93LrT+eZcgwis3ov2LKlhbYqwkz4H/fpV
         IBrf2KRtJniIAyUnQW0yzdtqe+TLKa46C1G/X8CE+oKsbfP+g8abB1PfymJTVQ8s69J8
         APJEO1L6j/qXgfiTsml4Y9oysjpXBdzmeuFQ9WHY+M/tmj6TbDcy4iKJ3JpFaYGPSkNX
         93WdlGEG65tlzUX8GSv8RMmoNixaSx4Pe0BTLXz+S0ymPUlZB0uxUZy5ZSUDjfALIq5t
         qJ2uCQKeLgBmFLdFgPGfqqNzMMdkmlIU9f1INIf6cDV27P0dbNM5zXkE5rmpGN07W4Cj
         U3vg==
X-Gm-Message-State: AOJu0Yzkl5KW63+dHTkeivV0o41gazwqDh+lSMZ7Nq9ayqIrJ7ZwnrYH
        sWZATahNzsiyDHk0TzP6yqQ+TB31/biCNBkm0kzXtU5o
X-Google-Smtp-Source: AGHT+IF0E7jVjMqNTG2LfZukiIszyNh4Xlzyvhw7m3NTawI2SX+buEOpcy4U5OXBuKlAZIdgM32ekQ==
X-Received: by 2002:a05:6402:5c4:b0:530:8fdb:39c8 with SMTP id n4-20020a05640205c400b005308fdb39c8mr4355038edx.15.1695400508626;
        Fri, 22 Sep 2023 09:35:08 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7da16000000b00532c84e6997sm2485597eds.23.2023.09.22.09.35.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-532addba879so6128669a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 09:35:07 -0700 (PDT)
X-Received: by 2002:a05:6402:27ca:b0:52c:f73:3567 with SMTP id
 c10-20020a05640227ca00b0052c0f733567mr4854122ede.13.1695400507255; Fri, 22
 Sep 2023 09:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-9-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-9-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Sep 2023 09:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Message-ID: <CAHk-=wgW5z-OBA8kbOOoM7dAriOsb1j7n6GaUNjGeg9fPY=JRw@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Sept 2023 at 05:02, David Howells <dhowells@redhat.com> wrote:
>
> iter->copy_mc is only used with a bvec iterator and only by
> dump_emit_page() in fs/coredump.c so rather than handle this in
> memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter()
> and copy_page_from_iter_atomic(),

This looks fine now, but is missing your sign-off...

             Linus
