Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4F7A2F00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbjIPJYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbjIPJYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:24:12 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CD1981
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Sep 2023 02:24:07 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44e8ddf1f1aso2586093137.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Sep 2023 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694856246; x=1695461046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5DU7YoagyAVqC/sHRmg2/bCsyGBzY4tUARoIU0JNDs=;
        b=GlyqsZ55+Om11NFkqUI6vpxLOyKgbA5MywfSQKeriijH2QZv+4ttI/Kah1vK2Coy4V
         LMO+ZP8937oXN55S6B4j+KxSu88aVuAHIfCExEf34Q0LS9oHeI0BTwM0ygsLj3bpULn3
         o6sjxcZDIR2VnY0nLolxbx9mE5Ce/Ojr1NcNmSgn4VJI+XqDpIF3fFdD24uPcWa4lyIB
         hEr7aEGMm3YdRE2KMs/cpT7taWuXK3zpBYpOXjl7Pk1Mb6/B5lgUTZvKPbg68peZxisE
         S8iWS9NfMcjdDdo++XUVRVC+A7c0ZResyEPJ8QWKiGDoDnMfmAgMBh0fxkisso3GrLXa
         2LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694856246; x=1695461046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5DU7YoagyAVqC/sHRmg2/bCsyGBzY4tUARoIU0JNDs=;
        b=OWcqtkEKeIM7I3Ia91BOfv9LnZhwea7eWnrwb+wYNAGdhDm1q15UTG2JL835DyYx2J
         13VsANNo5RCXJ6bwFd0NKvV56OCbhtlKvFY69yZDtPglMcDv8gKB+NXiB3OSwJszJZEW
         vJxkoSp7ujp3jtPqdFV+hxabXZkj4TRVHujeZgGmesiOnwVax/5ZTGeHIY94tpBiCU9h
         QWLkImk6FpU9NQOUKjRqewqTkuK7yodfOe0nKe2Bg2O25tdJP/A45qeuFwB0l0lpETmJ
         1EaBTdjU4HIqPQDdB6YF7u3mOwbVYxfvF81busJE3Ok4KpTEb07UaHerzSB7J6J86R8s
         /kuQ==
X-Gm-Message-State: AOJu0Yy91jDSHhfTqFCOToGRCiZd48/aSV0sOUv5H7gv7HFvfJacxwW9
        09ipWGq5LkOcu5xSg+fnNXBfnwX3APDuF4KQKmg=
X-Google-Smtp-Source: AGHT+IFwj5izvhPNmkhIWBZ4HAWGSd3si6AmvTS4PurKncdIFIcAyr9QGSewoQ1QdhyEMTBHT5Q2i4PKPr9SXLpRHiY=
X-Received: by 2002:a05:6102:36cd:b0:44e:942a:e563 with SMTP id
 z13-20020a05610236cd00b0044e942ae563mr3429549vss.0.1694856246053; Sat, 16 Sep
 2023 02:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230915234857.1613994-1-fred@cloudflare.com>
In-Reply-To: <20230915234857.1613994-1-fred@cloudflare.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 16 Sep 2023 12:23:54 +0300
Message-ID: <CAOQ4uxiGYF8EhqxM91_vrGSVYoX7dAf154btVobbsj=RUQNWAQ@mail.gmail.com>
Subject: Re: [RFC PATCH kdevops 0/2] augment expunge list for v6.1.53
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     mcgrof@kernel.org, kdevops@lists.linux.dev,
        kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Frederick!

Nice to see you joining the kdevops gang :)

On Sat, Sep 16, 2023 at 2:49=E2=80=AFAM Frederick Lawler <fred@cloudflare.c=
om> wrote:
>
> In an effort to test and prepare patches from XFS to stable 6.1.y [1], I =
needed
> to make a baseline for v6.1.53 to verify that the backported patches do n=
ot
> introduce regressions (if any). However, after a 'make fstests-baseline',=
 we
> observed that compared to v6.1.42, v6.1.53 introduced more than expected
> expunges to XFS. This RFC is an attempt to put some eyes to this and open=
 up a
> discussion.

I have refreshed the v6.1.42 expunge list very recently to uptodate fstests=
:

commit 0b58b02f08d26ea23b6ff58d9b24488c266f32d0
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Sat Aug 12 12:29:57 2023 +0300

    xfs: expunge new failing tests

    After update of fstests branch to tag v2023.08.06

There are zero changes in xfs code between v6.1.42..v6.1.53, so all
the regressions
you observed are unlikely due to the code change.

If it is not easy for you to test on a v6.1.42 k8 host, I can re-run
the baseline loop
with v6.1.53 kernel to verify there are no regressions, but I am
betting there won't be.
So the failures you are seeing must be due to some difference between
our setups.

Note that when I started to use kdepops with libvirt, we have observed
many random
errors that were eventually attributed to faulty code in qemu nvme driver.

I am not ruling out the possibility that the expuge lists that me or
Luis prepared
for xfs in some version (5.10.y, 6.1,y, etc) are tainted with failures
related to
our specific setup.

AFAIK, we never bothered to create two different baselines from scratch in
two different envs (e.g. libvirt and GCE/OCI) and compare them.

But as it is, you already have my baseline from libvirt/kvm -
I don't think that it makes sense to add to 6.1.y expunge lists
failures due to test env change, unless you were able to prove that either:
1. Those tests did not run in my env
2. You env manages to expose a bug that my env did not expose

I can help with #1 by committing results from a run in my env.
#2 is harder - you will need to analyse the failures in your env
and understand them.

Whenever I see new failures, I always analyse them before adding
to the expunge list and I try to add a comment explaining either the
observed reason for failure or the missing fix if I know it.

>
> At Cloudflare, the Linux team does not have an easy way to obtain dedicat=
ed and
> easily configurable server infrastructure to execute kdevops filesystem t=
esting,
> but we do have an easily-configurable kubernetes infrastructure. I prepar=
ed a
> POC to spin up virtual machines [2] in kubernetes to emulate what terrafo=
rm
> may do for OpenStack, Azure, AWS, etc... to perform this test. Therefore,=
 the
> configuration option is set to SKIP_BRINGUP=3Dy
>
> In this baseline, I spun up XFS workflow nodes for:
> - xfs_crc
> - xfs_logdev
> - xfs_nocrc
> - xfs_nocrc_512
> - xfs_reflink
> - xfs_reflink_1024
> - xfs_reflink_normapbt
> - xfs_rtdev
>
> Each node is running a vanilla-stable 6.1.y (6.1.53), and the image is ba=
sed on
> latest Debian SID [3]. Each node also has its own dedicated /data and /me=
dia
> partitions to store Linux, fstests, etc... and sparse-images respectfully=
.
>
> In v6.1.42, we don't currently have expunges for xfs_reflink_normapbt, an=
d
> xfs_reflink. So those are _new_. The rest had significant additions. Howe=
ver,
> not all nodes finished their testing after >12hrs of run time. Some appea=
red to
> be stuck, in particular xfs_rtdev, and never finished (reason unknown).
> I CTRL+C and ran 'make fstests-results'.
>
> I prepared a fork [4] where the results 6.1.53.xz can be found.
>
> These patches are based on top of commit 0ec98182f4a9 ("bootlinux/fstests=
:
> remove odd hplip user")
>
> Links:
> 1: https://lore.kernel.org/all/CAOQ4uxgvawD4=3D4g8BaRiNvyvKN1oreuov_ie6sK=
6arq3bf8fxw@mail.gmail.com/
> 2: https://kubevirt.io/api-reference/v1.0.0/definitions.html#_v1_virtualm=
achine
> 3: https://cloud.debian.org/images/cloud/sid/daily/latest/ (debian-sid-ge=
nericcloud-amd64-daily.qcow2)
> 4: https://github.com/fredlawl/kdevops/commit/afcb8fe7c4498d2be5386e191db=
3534f651a3730#diff-0677846133ad9128bf752f674b3c8da437c12ce28f48d8890b9f66d0=
dcb3717c
>
> Frederick Lawler (2):
>   fstests/xfs: copy 6.1.42 baseline for v6.1.53

In this commit you copied also the ext4 and btrfs expunge lists.
That is not needed as you are not changing or intend to change them.

I don't think that forking xfs lists is going to be needed at all
once you verified what happened - if your findings are indeed
correct they probably belong in the v6.1.42 expunge list.

>   xfs: merge common expunge lists for v6.1.53

The title of this commit does not represent the change correctly.
What this commit does is to add many new tests to the 6.1.53
expunge list.

Your confusing must be from seeing my commits like:
8745d44 xfs: merge common expunge lists for v6.1.42

What these commits do is to merge common failures
in xfs_* config specific expunge lists into the common all.txt
expunge list - there are scripts that do that:
./scripts/workflows/fstests/{find,remove}-common-failures.sh

Thanks,
Amir.
