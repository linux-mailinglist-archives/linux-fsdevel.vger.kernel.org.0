Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B913B611902
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiJ1RME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiJ1RLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:11:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE716706B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 10:10:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d13so3845361qko.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGoG4+kkpjFKIiC1aB206pNaNNu8WHtjUzbD9QY9Ydk=;
        b=AHLpWHbvaJj6iAHcMzE5M/XFIEJbvJiM188nPc4sZcuDlddbnWJj2scjftscU4cF4x
         7ek2zIay9rBYB96uXxrfVQTv5OfVuThw3qxUxjLeEdzSlmmCOyQ3PY8Gh2POJX82KNSM
         0yIW2D4UUkVkaewo1+mavlSqKbWHmteTLXE9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGoG4+kkpjFKIiC1aB206pNaNNu8WHtjUzbD9QY9Ydk=;
        b=5PlkNhkyhDjYH41mCChvGxgGAb3hA8BPotin4/ye4ilCYDS1kO2EYa6dC0QqSCfliw
         vRX06Ml6fkPVRb+hV6ggSBTzYKV3ONcO6ClVAyXu7FntWcY4njsoc0nBzwCcI/OPebzH
         VzgZLachn5+p3f/rNPSH/FMEjRi7MDFPYCuVzNA7jRmCYezk5gERjjS99xLUPDUP84tH
         TzFz6DRA2g3f85UUgQBO2/q4wKOtXLyrvMv15CTC/e2KImulkw4z5KuZ5qHDRb1NdSHO
         JLLfsuf2TklSMlOqMOVGw3+UPrNBgk5uUoi/jAfNO3r8hUa//K0f8vyD4oGyL1Kphhla
         P2tA==
X-Gm-Message-State: ACrzQf16I8A1QsT9e6CInv1RniASaq6WOIWRxzrUE19Uaac1JLBhr7kg
        L7g5fryPpkAGNH/rscu02MPkqOW1KTogMw==
X-Google-Smtp-Source: AMsMyM6BdtrvygAYwswkp47n796s0eVIz7if47Ijz2mxHrUReefgN6C251yp39a5bzo1vvUNf98Eew==
X-Received: by 2002:a05:620a:4091:b0:6fa:dcc:9814 with SMTP id f17-20020a05620a409100b006fa0dcc9814mr198566qko.592.1666977009745;
        Fri, 28 Oct 2022 10:10:09 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a25ce00b006ec62032d3dsm3342255qko.30.2022.10.28.10.10.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:10:08 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id o70so6825312yba.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 10:10:08 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr192268ybk.501.1666977007965; Fri, 28 Oct
 2022 10:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <Y1btOP0tyPtcYajo@ZenIV> <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk> <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
 <65441.1666976522@warthog.procyon.org.uk>
In-Reply-To: <65441.1666976522@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 10:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMAxxw3n5gvURUV68zHr6vXbcvhXSzXdi2obKo2bK=Dw@mail.gmail.com>
Message-ID: <CAHk-=wgMAxxw3n5gvURUV68zHr6vXbcvhXSzXdi2obKo2bK=Dw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] use less confusing names for iov_iter direction initializers
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 28, 2022 at 10:02 AM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Honestly, I think the *real* fix would be a type-based one. Don't do
> >
> >         iov_iter_kvec(&iter, ITER_DEST, ...
> >
> > at all, but instead have two different kinds of 'struct iov_iter': one
> > as a destination (iov_iter_dst), and one as a source (iov_iter_src),
>
> Or maybe something along the lines of iov_iter_into_kvec() and
> iov_iter_from_kvec()?

For the type-based ones, you would need that to initialize the two cases.

But without the type-based approach, it ends up being yet another case
of "you just have to use the right name, and if you don't, you won't
know until the dynamic WARN_ON() tells you".

And the dynamic WARN_ON() (or, WARN_ON_ONCE(), as it should be) is
great, but only for the drivers that get active testing by developers
and robots.

Which leaves potentially a _lot_ of random code that ends up being
wrong for years.

I really like static checking that actually gets noticed by the
compiler when you get it wrong.

It may not be entirely realistic in this situation, but it would be
really nice to try...

                  Linus
