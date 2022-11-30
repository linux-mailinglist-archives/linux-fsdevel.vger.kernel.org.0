Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5163D764
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 15:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiK3OB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 09:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiK3OB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:01:27 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DE28E17
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 06:01:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gu23so23338120ejb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 06:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzoqW6ToeL+gIq/SlLW89/uISRffzAb7i4tOVqs4bmg=;
        b=QusgihwxVgmsaZPhJup4SszkG4YG0LCxOZDzRsaGTrSeN5vxQeYvWpYGh3/FQlq6Ba
         WwkEPiZg0iZh3nq8l/T0WiXwEcLoMRAb0CDNiqiNtFSj/i5oR37hcw1tFCpBg/JWS8UG
         HvRqekOInJq/kdg5s/u+X7tLgnEFU2fiSMMHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzoqW6ToeL+gIq/SlLW89/uISRffzAb7i4tOVqs4bmg=;
        b=SS2pgPWLDLlTIZwwxWbmrJFw8BgI4bebeZMW6atU00aFWiEoNPxxlnPuD2dBk96rVl
         8VLS2Q9BHlFCCKbOlgtOeoEvTfCmOCJCviVRI1D4lQfgEr9VIdBiT7K+SRZYLLv4F6iP
         oFoSc4PiWuzgEYiUXLkrNbcSxpo4E47QLGaT2mAH+R05DthgRtzfbAwU69u88V8YQEz/
         JyNnmBb5gA5suk6QtMT+2/B7MLbkPhh0W1ie3ire6CyW+MBNN7J8Lckc6DK+3ff6W2yA
         WbBJ6AxEGtDoiP7vwXYu1knU1yveSl+LnpYhorAx42dKEelTrTAnJCPYGr26GqV3EWZW
         JpYA==
X-Gm-Message-State: ANoB5pniaIzBNZbFSDOTf+XGKb70KCivYDTbG76sYP22FmBcgI4mnG5z
        KdMSUuZyBzkthF8ru5CMwd+85Jc9kfL8nN43DEW1Clm8kmDbLQ==
X-Google-Smtp-Source: AA0mqf6uBShHjZoaQLix9bz7tROUyDcDkv9R3ZejsFFc4DJpCjPbo4DDqtCIKekzpTK/DhFfx61Fp5KlRXMmpPyH4VU=
X-Received: by 2002:a17:906:3ad6:b0:7ae:40b7:7fbe with SMTP id
 z22-20020a1709063ad600b007ae40b77fbemr50194026ejd.371.1669816882292; Wed, 30
 Nov 2022 06:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20221128150301.1168324-1-jlayton@kernel.org> <CAJfpegscj=rAEn5g67DtGb5ZO5nOKjhEsd1dR_yXcVDq2K0NkQ@mail.gmail.com>
 <14d1e26a57d75c92efd2fd96ca7c675aa1410f80.camel@kernel.org>
In-Reply-To: <14d1e26a57d75c92efd2fd96ca7c675aa1410f80.camel@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Nov 2022 15:01:11 +0100
Message-ID: <CAJfpegsJk2TYAyKDQn0JRRFEvHMjmaQyrswAgRSJ1yJ3c7=knA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: drop the fl_owner_t argument from ->flush
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 30 Nov 2022 at 14:40, Jeff Layton <jlayton@kernel.org> wrote:

> This wouldn't obviate FUSE's support for POSIX locks, but I do see a
> problem for FUSE here. It looks like FUSE doesn't record POSIX locks in
> the local inode. Without that, it'd never unlock due to the optimization
> at the start of locks_remove_posix.

Indeed.

> That'd be pretty simple to fix though. We could add a fstype flag that
> just says "don't trust that list_empty check and always unlock". We'd
> set that for FUSE and you'd still get the whole-file unlock call down to
> the fs for any inode with a file_lock_context.

FUSE took that path, because it seemed impossible or impractical to
keep the kernel's locking state in sync with the filesystem's locking
state.  It was a long time ago and I don't remember the details.
Unfortunately the commit message doesn't help to explain either...

commit 7142125937e1482ad3ae4366594c6586153dfc86
Author: Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun Jun 25 05:48:52 2006 -0700

    [PATCH] fuse: add POSIX file locking support

    This patch adds POSIX file locking support to the fuse interface.

    This implementation doesn't keep any locking state in kernel.  Unlocking on
    close() is handled by the FLUSH message, which now contains the
lock owner id.

    Mandatory locking is not supported.  The filesystem may enfoce mandatory
    locking in userspace if needed.

    Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Thanks,
Miklos
