Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43236CCA2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjC1Spm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 14:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjC1Spl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:45:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FB1FE5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:45:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so53621443ede.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680029136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5ELjhHPH9QaW8hBVzNt3TIl7nZDW5SXeFSz7nHPO7o=;
        b=FuAdJ6a+b4kAUAzXWR2r0p85hwLP+RdEXx9x+1o6oMns5DHcLHNDH9ObvTp9XeDTgv
         PdAv+fQcakLu6h+9f700NC+FS0xi/Yaq6f9Mt0nsS7e3dh9//mLqKdBjuDXCyshxovKA
         YI+i+3Ri/nyQ4dWxcY8mdtHB9KTFntflSzDBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5ELjhHPH9QaW8hBVzNt3TIl7nZDW5SXeFSz7nHPO7o=;
        b=ZQbSNwctE/Qrvu4ddV0r5OHfoPot0ThbyyFVQknGTic7K9fXvX/JGUwKUR+tzugSrj
         8nHFSHnMduQG0NieJTaBu0Km4b9uXK3jSfkyGZf2tpkZYB/f9oMCL5473VJjOddlAJDC
         tcpQy6AUZYb0COoj345wOE6ap2X5Q/e8TF3z3kX6vLKb/hrnx9OHWqrgGGLOmEymum+x
         MSZT+WCyB8x6y35ISdO1Nyq25bgHtyGCF2QzkWN4xKDsa6vOPvDI0H9NmbQHJTUvKKpH
         KaDq2GZeWlETRgLauvCTgLld02nOw6AWDFGWm7qDG1rPRJZDUwATankvJu0FwG36TmqL
         eH9w==
X-Gm-Message-State: AAQBX9dVlx+bf7SnHhvzXVgIAHypgwWwoKaQYyYaiOZYWTnMTHDCx4SI
        3p9cMUW7c5Zp4qE26tTxp28PFcxyQRwdu7sFTIaRjQ==
X-Google-Smtp-Source: AKy350Y/faLVBnK/IB6suvobiQuzMeM+4/0xLlGk8dkJ+1UyizJ1kop4kT0QqIYbm2Jg0DY83Ymq0w==
X-Received: by 2002:aa7:c448:0:b0:4fb:86c8:e9cc with SMTP id n8-20020aa7c448000000b004fb86c8e9ccmr16804786edr.40.1680029136618;
        Tue, 28 Mar 2023 11:45:36 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id w29-20020a50d79d000000b004bf5981ef3dsm15695576edi.94.2023.03.28.11.45.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 11:45:35 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id x3so53556357edb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:45:35 -0700 (PDT)
X-Received: by 2002:a50:a6d1:0:b0:4fa:da46:6f1c with SMTP id
 f17-20020a50a6d1000000b004fada466f1cmr8581963edc.2.1680029135424; Tue, 28 Mar
 2023 11:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173613.555192-1-axboe@kernel.dk> <20230328173613.555192-3-axboe@kernel.dk>
 <20230328184220.GL3390869@ZenIV>
In-Reply-To: <20230328184220.GL3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 11:45:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLfRenukzsYR8S0tR6towY+icX+voWr1Q8owGPQP8rTQ@mail.gmail.com>
Message-ID: <CAHk-=wgLfRenukzsYR8S0tR6towY+icX+voWr1Q8owGPQP8rTQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] iov_iter: add iovec_nr_user_vecs() helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:42=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> Umm...  Why not set ->nr_segs to 1 in iov_iter_ubuf() instead?  Note that
> it won't be more costly; that part of struct iov_iter (8 bytes at offset =
40
> on amd64) is *not* left uninitialized - zero gets stored there.  That way
> you'll get constant 1 stored there, which is just as cheap...

Ack. And with my suggestion to embed a 'struct iov' in the 'struct
iov_iter' for the ITER_UBUF case (see previous email, try not to
barf), we really end up with a pretty cheap "ITER_UBUF can be used
almost as-is for any ITER_IOV case".

                 Linus
