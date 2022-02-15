Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326ED4B6848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 10:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiBOJ4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 04:56:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiBOJ4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:56:50 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4D108759
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 01:56:40 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id e6so10053168vsa.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 01:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV9b+cKLMc+taV0E0thVfuoXTKPyMNBl8U5rNvre5qw=;
        b=RH0RXuwhdhEgwG6CEP1Pt9fHVQy4soD2TJ+IpVuxgtAqBQw3Sebbzc7/1oJkQ8wCJ8
         3o0wZ6HXpUJYbiJpByjTCyCSHtHEAKsGscPkvPh5WhXqrQcSOJ/mXsEuPM2zYZs3hK6Q
         UmdL603FjaB8BVRAaZS/S2ZVaIjXev4IZlUkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV9b+cKLMc+taV0E0thVfuoXTKPyMNBl8U5rNvre5qw=;
        b=x/lS9LkNCj2g7XTf5YD+767cLpFCmY+2G71O5GUh9eZLSlFi/25rUd0Ohn1DOvv1tl
         1z5MVBLQ7WhlVTY68jbV+ec8JJl9ecwQLF/YUqc+beUzEpOdi8cKFMyfJA10wun2Gnc2
         jhF4SS5LHKtzzfyc6vQ3ChcmsE71ikvMbYNXMewidcSxa1WKxXVIspk38jaK8z5LiGh6
         XW1Mz0cE4Kup/VkTXOuXZQ+LzGCsXR9ocNcWjCpRm6UoGPDbaf4gWluIB1s4/SjVrx/F
         Uku140nCgJm3RMSc6Ych4geIzwF3jv5ub7lvIsMRXBFQC+gRR2nYlbtnrz4H/Q1csMRK
         OTxQ==
X-Gm-Message-State: AOAM530h3ospaUuFpamkngiKF53MZBeq05syRLdqxtwU7Z6Aekd/UkK5
        7UH6ENLhf95/x4xkBFH5yfgWTkFpQ3BcHKxjEOMGFg==
X-Google-Smtp-Source: ABdhPJyHRK9A/0HBH5/KKjNI20lBkuXxfgBQxJo3eep6C4GYCrDFTcZMWCjl6PPIFOVyed25ViaCgIWoVevZ8BxfBnE=
X-Received: by 2002:a05:6102:558b:: with SMTP id dc11mr65470vsb.87.1644919000014;
 Tue, 15 Feb 2022 01:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20220214210708.GA2167841@xavier-xps>
In-Reply-To: <20220214210708.GA2167841@xavier-xps>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 15 Feb 2022 10:56:29 +0100
Message-ID: <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
To:     Xavier Roche <xavier.roche@algolia.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Feb 2022 at 22:07, Xavier Roche <xavier.roche@algolia.com> wrote:
>
> There has been a longstanding race condition between vfs_rename and do_linkat,
> when those operations are done in parallel:
>
> 1. Moving a file to an existing target file (eg. mv file target)
> 2. Creating a link from the target file  to a third file (eg. ln target link)
>
> A typical example would be (1) a regular process putting a new version
> of a database in place and (2) a regular process backuping the live
> database by hardlinking it.
>
> My understanding is that as the target file is never erased on client
> side, but just replaced, the link should never fail.
>
> The issue seem to lie inside vfs_link (fs/namei.c):
>        inode_lock(inode);
>        /* Make sure we don't allow creating hardlink to an unlinked file */
>        if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
>                error =  -ENOENT;
>
> The possible answer is that the inode refcount is zero because the
> file has just been replaced concurrently, old file being erased, and
> as such, the link operation is failing.
>
> The race appears to have been introduced by aae8a97d3ec30, to fix
> _another_ race between unlink and link (but I'm not sure to understand
> what were the implications).
>
> Reverting the inode->i_nlink == 0 section "fixes" the issue, but would
> probably reintroduce this another issue.
>
> At this point I don't know what would be the best way to fix this issue.

Doing "lock_rename() + lookup last components" would fix this race.
If this was only done on retry, then that would prevent possible
performance regressions, at the cost of extra complexity.

Thanks,
Miklos
