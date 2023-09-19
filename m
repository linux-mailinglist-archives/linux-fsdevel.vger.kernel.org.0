Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7652F7A5CCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjISInh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISInf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:43:35 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D669D12C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:43:29 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7a7d7283fe5so1681725241.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695113009; x=1695717809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7XikjWd3jwDbO28i8wYpygIPE/xIN558cD7Z/sU1GI=;
        b=eAL6gOTWMSMRPqWmUr+ln1BbRNJBO+51hOefL6IyHsk2+g9k/ApbwxDEwCQwcbMPFh
         +AziX7bHM2KA01P11JDw+ypKsu3ztDATKHUuut7h61sAbEjRfyVp5oVfZBzBkJjANiXk
         0u4+9EKJU5E3Ivo2+db1LHM/9tqwMEmoYCd8Our3ctuJLvD6ljERUku721HPOlTdrSmj
         bqv9GV5KQ2dN1NRRdVHzzaORoPHAr9ceKAVf6BSsaH9UskDNU+ue8oGDAwWQcbmCh0ma
         7sqDtB2CKGRZrGbwntQy5qspwDvWIX8K+hB3e5b9VjdrwEb+mlt0GDAwoojJ82AUEbPm
         ZGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695113009; x=1695717809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7XikjWd3jwDbO28i8wYpygIPE/xIN558cD7Z/sU1GI=;
        b=slt5B4ENyL16vyRbMG2f73OWJTJ+M8JPpd7cTfKwXihIQYVO0XEL96/18mIjLjcJAh
         WkRda+O/OHeKFxaTYf4HKZUfq5mbNraMQYg2jT93Inr6P1fFbWdshqMGpt+lfy0CLKI1
         SL0570QRjutmXLjJ7RD0CRMUx+FczROEjiNW5oZpzEElh/Fcpok1e7PaYyYmqfwGoW3X
         QDOixk600p8TKbgjgE6PD+oD0VLJEDhVTIKx5bCmnjUt2p8PSahNg2v0nAKWJE/U4gMI
         t3T5W7z/Oj3HvXimosNs4qw7rJpi5XHuzBmaCp8zwsijEXvlpk/ly72FPHtfErN6QDki
         BfFQ==
X-Gm-Message-State: AOJu0YzUjzQfBjFCM+7dIBuVWiWKVrJ65jYq6G/lRg6THSra/OfE0+7Q
        A6EFP4T9e6q+OT0vHZQuhZSK1unQzpOez+be1Jw=
X-Google-Smtp-Source: AGHT+IEA2AHn2sZDufX/u73qRXw+p3X79qC9hLOanykfA+/LaMJ3rW8wL179S0KG55Jcb6xkEveQzUbC9hBjqGLDb4s=
X-Received: by 2002:a1f:c684:0:b0:493:8019:ea65 with SMTP id
 w126-20020a1fc684000000b004938019ea65mr6227078vkf.6.1695113008811; Tue, 19
 Sep 2023 01:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com> <202309191018.68ec87d7-oliver.sang@intel.com>
In-Reply-To: <202309191018.68ec87d7-oliver.sang@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 11:43:17 +0300
Message-ID: <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        ltp@lists.linux.it, mszeredi@redhat.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 5:47=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "ltp.readahead01.fail" on:
>
> commit: f49a20c992d7fed16e04c4cfa40e9f28f18f81f7 ("[PATCH] vfs: fix reada=
head(2) on block devices")
> url: https://github.com/intel-lab-lkp/linux/commits/Reuben-Hawkins/vfs-fi=
x-readahead-2-on-block-devices/20230909-124349
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 32b=
f43e4efdb87e0f7e90ba3883e07b8522322ad
> patch link: https://lore.kernel.org/all/20230909043806.3539-1-reubenhwk@g=
mail.com/
> patch subject: [PATCH] vfs: fix readahead(2) on block devices
>
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20230715
> with following parameters:
>
>         disk: 1HDD
>         fs: ext4
>         test: syscalls-00/readahead01
>
>
>
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz=
 (Ivy Bridge) with 8G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202309191018.68ec87d7-oliver.san=
g@intel.com
>
>
>
> COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 3917     -n 3917=
 -p -f /fs/sdb2/tmpdir/ltp-R8Bqhtsv5t/alltests -l /lkp/benchmarks/ltp/resul=
ts/LTP_RUN_ON-2023_09_13-20h_17m_53s.log  -C /lkp/benchmarks/ltp/output/LTP=
_RUN_ON-2023_09_13-20h_17m_53s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN=
_ON-2023_09_13-20h_17m_53s.tconf
> LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2023_09_13-20h_17m_53s.l=
og
> FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-20h=
_17m_53s.failed
> TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-20h_=
17m_53s.tconf
> Running tests.......
> <<<test_start>>>
> tag=3Dreadahead01 stime=3D1694636274
> cmdline=3D"readahead01"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> readahead01.c:36: TINFO: test_bad_fd -1
> readahead01.c:37: TPASS: readahead(-1, 0, getpagesize()) : EBADF (9)
> readahead01.c:39: TINFO: test_bad_fd O_WRONLY
> readahead01.c:45: TPASS: readahead(fd, 0, getpagesize()) : EBADF (9)
> readahead01.c:54: TINFO: test_invalid_fd pipe
> readahead01.c:56: TPASS: readahead(fd[0], 0, getpagesize()) : EINVAL (22)
> readahead01.c:60: TINFO: test_invalid_fd socket
> readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded
>

Reuben,

This report is on an old version of your patch.
However:
1. LTP test readahead01 will need to be fixed to accept also ESPIPE
2. I am surprised that with the old patch readahead on socket did not
    fail. Does socket have aops?

Please try to run LTP test readahead01 on the patch that Christian queued
and see how it behaves and if anything needs to be fixed wrt sockets.

Thanks,
Amir.
