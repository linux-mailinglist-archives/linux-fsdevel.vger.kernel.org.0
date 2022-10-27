Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9423C6100E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiJ0S6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 14:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiJ0S6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:58:24 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B48248C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 11:58:22 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u7so2202175qvn.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enc8IrGpVjXGNTcKz9NxXiwj8ah68/uzbqH61bvPW30=;
        b=T2O/UqT9b2lz5tGyVKo3w7qSdvlSrNFQ37SWI2uZf0Nn4+uPmE9YdNtiJPcnQSKinL
         B+eqU34CGQmU9wle9SLzksOFAmckb66lWvuozE7KgX+n9kcb/Ub7DRCrODUmlcQYK39F
         06hV4YwV43E0Nruyr0qfriRMkV9nvTunLOmD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enc8IrGpVjXGNTcKz9NxXiwj8ah68/uzbqH61bvPW30=;
        b=Cw3XZ7WVEdnCqmfoLEdu4SSdGjKEz5TFaMq7WXmg1LTtmYedjkl80YibR/b20PQRjN
         5VuyhmMD1cU2p9zq4TGWZtKiShNESmQ3XAgmqqPBZF0MqGDqzLam9rKlN+tboZ0idwga
         NwWUj5GLkPWawB4KNxzyoLmdKCzQaWoJ0MDgryoyXxpjQTXuavXssGYgxiqXMuGTkgph
         KWjfAGaG3V26ce5Jh/zn17r0wGT/j2ttAUdXX8r9MdCDro1MYU1GL3veAnEagOp9HEQZ
         Va4Q8j0kA6QvudEcZkHbGgZU7mIbo3oQoeClsaXFdD7DL9qukRj/2o8ToheulK55omSV
         L51Q==
X-Gm-Message-State: ACrzQf1wNP8N7r/TVgtnIYDLFJ30OCS+D3w9dWO9NkgmHX0F/At5R+wS
        xwdKhzi7GnM6vFdulOtGEBJCfFTxkwxEcw==
X-Google-Smtp-Source: AMsMyM6vDA5iBznM4D/+l799XAJ0CsezFbb0YkmTp3DIqf87ayIjqNzrfCvhTI4lC5DSqHIq9pBIhg==
X-Received: by 2002:a05:6214:248f:b0:4bb:59ee:738c with SMTP id gi15-20020a056214248f00b004bb59ee738cmr26876720qvb.61.1666897101016;
        Thu, 27 Oct 2022 11:58:21 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a409200b006cdd0939ffbsm1473465qko.86.2022.10.27.11.58.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 11:58:19 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id n130so3346124yba.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Oct 2022 11:58:19 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr45238400ybb.184.1666897099027; Thu, 27
 Oct 2022 11:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <Y1oPDy2mpOd91+Ii@sol.localdomain>
In-Reply-To: <Y1oPDy2mpOd91+Ii@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 11:58:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDQiJn6YUJ18Nb=L82qsgx3LBLtQu0xANeVoc6OAzFtQ@mail.gmail.com>
Message-ID: <CAHk-=wjDQiJn6YUJ18Nb=L82qsgx3LBLtQu0xANeVoc6OAzFtQ@mail.gmail.com>
Subject: Re: [GIT PULL] fscrypt fix for 6.1-rc3
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
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

On Wed, Oct 26, 2022 at 9:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Fix a memory leak that was introduced by a change that went into -rc1.

Unrelated to the patch in question, but since it made me look, I wish
code like that fscrypt_destroy_keyring() function would be much more
obvious about the whole "yes, I can validly be called multiple times"
(not exactly idempotent, but you get the idea).

Yes, it does that

        struct fscrypt_keyring *keyring = sb->s_master_keys;
        ...
        if (!keyring)
                return;
        ...
        sb->s_master_keys = NULL;

but it's all spread out so that you have to actually look for it (and
check that there's not some other early return).

Now, this would need an atomic xchg(NULL) to be actually thread-safe,
and that's not what I'm looking for - I'm just putting out the idea
that for functions that are intentionally meant to be cleanup
functions that can be called multiple times serially, we should strive
to make that more clear.

Just putting that sequence together at the very top of the function
would have helped, being one simple visually obvious pattern:

        keyring = sb->s_master_keys;
        if (!keyring)
                return;
        sb->s_master_keys = NULL;

makes it easier to see that yes, it's fine to call this sequentially.

It also, incidentally, tends to generate better code, because that
means that we're just done with 'sb' entirely after that initial
sequence and that it has better register pressure and cache patterns.

No, that code generation is not really important here, but just a sign
that this is just a good coding pattern in general - not just good for
people looking at the code, but for the compiler and hardware too.

                   Linus
