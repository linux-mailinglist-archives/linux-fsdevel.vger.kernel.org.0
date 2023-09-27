Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378C47B0C00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 20:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjI0Sch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Scg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:32:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB018F;
        Wed, 27 Sep 2023 11:32:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3231dff4343so5289819f8f.0;
        Wed, 27 Sep 2023 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695839553; x=1696444353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekDcWyVkbd7zDXNRjBeJ3lySaiZP1rXVA38mYoAQqBc=;
        b=gQwLPtDJimUZfMiMBDUOyuVnIDqf2sh9z/tByCtY9djP7BfKHLgUdE7bXz8HTiVQUi
         GtJrvtTU4DRyisMwUv/gW0q33SCXXxzdoDZ81jIKiodNQFxmKV/XoXn4Ewrm871y15JN
         LexsZKF1J4n9GeUppX2G3V1ieAyE0sIi98LOlZnsI5L9n88znFpJQyq/kb1eUPI1Jq2a
         sydb7vMTi1r1xxIlaa+J8TPh/+A0KOt1EWfM+nBDCgLElzRXmHjZnx9ffDWIzZE3LFMS
         yuJh0pRBzdgS/YNakc7iounI23D99i2vQ9eVfTSoaqegL/B680k6CPweMk/p970mdJK7
         +6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695839553; x=1696444353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekDcWyVkbd7zDXNRjBeJ3lySaiZP1rXVA38mYoAQqBc=;
        b=ZS6Cylo3TQGS+Py8gMq8N8jjIISKufIrVeQLTHvf1fZrHRY9tZPr8VyEkrA6yZOx4A
         LbU+QzIj9bkbt0qNqpO9zp7M2lI7iAkT15g5V8qWnqIN6aF4ibsHbyMnzbinWN/XdaWp
         i7o2tqeeKJ04C1cmNXHfcEb927gCb+DQovQzepVze2cBCL8TaVPzK4t/emptRr3RUQYu
         X9mtl740mlbVTOxNaBd/HBFXOFp3mXZfOTFdZiDNq/fXoO63bX5N9SjuS8huvmI3LOnJ
         nZoHHj3fodzCVlrUV22rcaVCkrJU8xxIJQ21oNTl5kIMfwiogl9ooQmLzFV3/9hhDZsS
         9fpw==
X-Gm-Message-State: AOJu0YxvKw44ewyTQC6ARd8xRuurJZF3jkWxS/TmccgJfgGiJ5UGVbRx
        /c2zgz7l8S5Vd8vWdloJij0=
X-Google-Smtp-Source: AGHT+IFziQLslK/sQ1tfjmko+BbqIY6+BkCYktdKi6rhWL09EYY0F2BMwsfItteaR88eRy6vIhiEVA==
X-Received: by 2002:a05:6000:4cf:b0:31f:d50e:a14f with SMTP id h15-20020a05600004cf00b0031fd50ea14fmr2498610wri.10.1695839552461;
        Wed, 27 Sep 2023 11:32:32 -0700 (PDT)
Received: from f (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b0031ad2f9269dsm17639613wrw.40.2023.09.27.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:32:31 -0700 (PDT)
Date:   Wed, 27 Sep 2023 20:32:09 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <ZRR1Kc/dvhya7ME4@f>
References: <20230926162228.68666-1-mjguzik@gmail.com>
 <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
 <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:05:37AM -0700, Linus Torvalds wrote:
> On Wed, 27 Sept 2023 at 10:56, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > Comments in the patch explicitly mention dodgin RCU for the file object.
> 
> Not the commit message,. and the comment is also actually pretty
> obscure and only talks about the freeing part.
> 

How about this:

================== cut here ==================

vfs: shave work on failed file open

Failed opens (mostly ENOENT) legitimately happen a lot, for example here
are stats from stracing kernel build for few seconds (strace -fc make):

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ------------------
    0.76    0.076233           5     15040      3688 openat

(this is tons of header files tried in different paths)

In the common case of there being nothing to close (only the file object
to free) there is a lot of overhead which can be avoided.

This boils down to 2 items:
1. avoiding delegation of fput to task_work, see 021a160abf62 ("fs:
use __fput_sync in close(2)" for more details on overhead)
2. avoiding freeing the file with RCU

Benchmarked with will-it-scale with a custom testcase based on
tests/open1.c, stuffed into tests/openneg.c:
[snip]
        while (1) {
                int fd = open("/tmp/nonexistent", O_RDONLY);
                assert(fd == -1);

                (*iterations)++;
        }
[/snip]

Sapphire Rapids, openneg_processes -t 1 (ops/s):
before:	1950013
after:	2914973 (+49%)

file refcount is checked with an atomic cmpxchg as a safety belt against
buggy consumers. Technically it is not necessary, but it happens to not
be measurable due to several other atomics which immediately follow.
Optmizing them away to make this atomic into a problem is left as an
exercise for the reader.

================== cut here ==================
 
Comment in v2 is:

/*
 * Clean up after failing to open (e.g., open(2) returns with -ENOENT).
 *
 * This represents opportunities to shave on work in the common case of
 * FMODE_OPENED not being set:
 * 1. there is nothing to close, just the file object to free and consequently
 *    no need to delegate to task_work
 * 2. as nobody else had seen the file then there is no need to delegate
 *    freeing to RCU
 */

I don't see anything wrong with it as far as information goes.

> > Well put_cred is called synchronously, but should this happen to be
> > the last ref on them, they will get call_rcu(&cred->rcu,
> > put_cred_rcu)'ed.
> 
> Yes. But the way it's done in __fput() you end up potentially
> RCU-delaying it twice. Odd.
> 
> The reason we rcu-delay the 'struct file *' is because of the
> __fget_files_rcu() games.
> 
> But I don't see why the cred thing is there.
> 
> Historical mistake? But it all looks a bit odd, and because of that it
> worries me.
> 

put_cred showed up in file_free_rcu in d76b0d9b2d87 ("CRED: Use creds in
file structs"). Commit message does not claim any dependency on this
being in an rcu callback already and it looks like it was done this way
because this was the ony spot with kmem_cache_free(filp_cachep, f) --
you ensured put_cred was always called without inspecting any other
places.

If there is something magic going on here I don't see it, it definitely
was not intended at least.
