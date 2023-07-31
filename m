Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618F76991F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 16:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGaOMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGaOMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:12:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB1C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 07:12:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c10ba30afso259023266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690812747; x=1691417547;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+4GnjKOZl0AfbckrXekCIDJuMby+PvR01pu0MVMOJg=;
        b=KUciOO7TTdDWResLUUeTpwRlYx7LXeZL30gof9oLe5yr4fs/YfcfZYrlm/CxH5jQTZ
         SRFGaB3NKvXr2QP3v8PF7kyFhG5TlFulNm18FtQXlBz2oz75tElokPaAIA9hNKd8Bmmn
         CqXk9mK4xwMl6fhw48Qnze2XrMIxW9AMeqfCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812747; x=1691417547;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+4GnjKOZl0AfbckrXekCIDJuMby+PvR01pu0MVMOJg=;
        b=RCW9VOoPIScfkIdvlIbIjwfaUbr98cZppjOl7k+LNss6SAZIEo4SHsHwAy0uWdYyYQ
         oLtQemoX3I0oWDw5YM/iWhS8m65nP14ucARGmsXehqoypWvUL1635IgoGUXgHqxdGJv6
         x4mdcX6a07pLuNBPHS1r6IHD+qdKABP3uuzo4QK03aeikCqdL5UlAcxIJawLbh9lFTW8
         R7oQcEQOvRDHcP2XCc6RMFbzD7t9wxxAJ/hagdInvw3ntSoH/LpybEENPuDEn+XxSEzQ
         2Yvz0+ygrONXYq1fPTfb7J0jolY7eYD4acCoWxFSRq4fTvsQ7ughTXLAXgZvucl/4q1m
         QKfw==
X-Gm-Message-State: ABy/qLZTElBSiokzDeQR1Xqqd4Q+cEOvEVe9HmLkLPc0yQ6fGvvqodhv
        2MBPIEFFaeXaS2ejNMDxYBNBwJrBDmogL1UsGifXxw==
X-Google-Smtp-Source: APBJJlGQJyJ6eRLgXkMITxauX5YHxSiLXjT5Q2QcydKGkwLnh6s1Yujvy/BTA1iBlkxhbpWKtslse0ccjmwoQNTgjeI=
X-Received: by 2002:a17:907:3e8f:b0:966:1bf2:2af5 with SMTP id
 hs15-20020a1709073e8f00b009661bf22af5mr8004338ejc.22.1690812746782; Mon, 31
 Jul 2023 07:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org> <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org> <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
In-Reply-To: <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 Jul 2023 16:12:15 +0200
Message-ID: <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Jul 2023 at 10:52, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, 28 Jul 2023 at 10:45, Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> > I've pushed an instrumented snapshot to
> > https://github.com/s3ql/s3ql/tree/notify_delete_bug. For me, this
> > reliably reproduces the problem:
> >
> > $ python3 setup.py build_cython build_ext --inplace
> > $ md bucket
> > $ bin/mkfs.s3ql --plain local://bucket
> > [...]
> > $ bin/mount.s3ql --fg local://bucket mnt &
> > [...]
> > $ md mnt/test; echo foo > mnt/test/bar
> > $ bin/s3qlrm mnt/test
> > fuse: writing device: Directory not empty
> > ERROR: Failed to submit invalidate_entry request for parent inode 1, name b'test'
> > Traceback (most recent call last):
> >   File "src/internal.pxi", line 125, in pyfuse3._notify_loop
> >   File "src/pyfuse3.pyx", line 915, in pyfuse3.invalidate_entry
> > OSError: [Errno 39] fuse_lowlevel_notify_delete returned: Directory not
> > empty

I get this:

root@kvm:~/s3ql# bin/s3qlrm mnt/test
WARNING: Received unknown command via control inode
ERROR: Uncaught top-level exception:
Traceback (most recent call last):
  File "/root/s3ql/bin/s3qlrm", line 21, in <module>
    s3ql.remove.main(sys.argv[1:])
  File "/root/s3ql/src/s3ql/remove.py", line 74, in main
    pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
  File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'

All packages are from debian/testing, except python3-dugong, which is
from bullseye (oldstable), becase apparently it was removed from the
recent release.

Thanks,
Miklos
