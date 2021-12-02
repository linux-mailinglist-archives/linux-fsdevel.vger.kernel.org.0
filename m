Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3B466A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 20:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhLBTlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 14:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhLBTlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:41:05 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A879C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 11:37:43 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id y5so1143445ual.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 11:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wNplOXKowJpyWzLgxX3W2ldQtfsv2Liwori4v7n79M=;
        b=f38hPcGreY9eI9znOytsipFtYrCbkQusmbEU8r5/sHUxB5wwCxqJEU/RGKFnjpG4zn
         9sNGPozsXye03zmA47mAVeWXgV29k6rS8YfKJZ+zLd4xtjDr7wdrpkBQfFuHrNXUfpxA
         lFhA6+qxQtIH1z3oJV2X2OYHVdGSkXgAlcW44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wNplOXKowJpyWzLgxX3W2ldQtfsv2Liwori4v7n79M=;
        b=jdS/SAInOIUWEATCPWPs1aARJBJfXuNvQ7AfTqZR3EJjx5NPlovw5g1wrdaj597W8m
         WHkQ+9wA2MqoxNx9uLAeHX0T9dz1qmk2dV+P0IiC1LjRUBJ1PHDH1Iiq9NILdALyEusz
         x314rxRoB5qweCqK7dxlhMstyGzsbP9t53Zo5gLerR+8koKAYzGFKh3mnjokn63xFPoK
         1VWh2EthG/wGyDz4PWli+pEWdSML26o0XXybYO2CoLH98ev8AdAU0HCC6GGJxuSHptn8
         0apNKGhQmUJ4nCIFI9EVlS4QeyIUiPz6LK56WWNbofRfyba+Aw5dZVEXDgH+fHnc2ft5
         eAgw==
X-Gm-Message-State: AOAM530crZLqkOtlip52i0Ww0bBXHroXiNUYsmxQAJk64DVej7DVIpkd
        5pTgMzjGNh8XDtVYaL3ty+8WDB1e6622elI85NVhj+OJ46rvjA==
X-Google-Smtp-Source: ABdhPJx6EySbpUKs02C/KU7YjjUAQYtCsSwYMkPq9IRxM9DouCVYzbThm8cXgqlmqwq4Wjew2JU3YsgvQaatRBPa7Ao=
X-Received: by 2002:a05:6102:c4e:: with SMTP id y14mr18326470vss.61.1638473862037;
 Thu, 02 Dec 2021 11:37:42 -0800 (PST)
MIME-Version: 1.0
References: <CAMBWrQnfGuMjF6pQfoj9U5abKBQpaYtSH11QFo4+jZrL32XUEg@mail.gmail.com>
In-Reply-To: <CAMBWrQnfGuMjF6pQfoj9U5abKBQpaYtSH11QFo4+jZrL32XUEg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Dec 2021 20:37:31 +0100
Message-ID: <CAJfpegvsiW-UsnhSrbQ2X0JpLAppUy3+WaNnzFrPwrKCmg82Fg@mail.gmail.com>
Subject: Re: overlay2: backporting a copy_file_range bug fix in Linux 5.6 to 5.10?
To:     Stan Hu <stanhu@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Dec 2021 at 22:31, Stan Hu <stanhu@gmail.com> wrote:
>
> A number of users have reported that under certain conditions using
> Docker and overlay2, copy_file_range() can unexpectedly create a
> 0-byte file: In https://github.com/docker/for-linux/issues/1015.
>
> We started seeing mysterious failures in our CI tests as a result of
> files not properly being copied.
>
> https://github.com/docker/for-linux/issues/1015#issuecomment-841915668
> has a sample reproduction test.
>
> I analyzed the diff between 5.10 and 5.11 and found that if I applied
> the following kernel patch, the reproduction test passes:
>
> https://lore.kernel.org/linux-fsdevel/20201207163255.564116-6-mszeredi@redhat.com/#t
>
> This landed in this merge commit and this commit:
>
> 1. https://github.com/torvalds/linux/commit/92dbc9dedccb9759c7f9f2f0ae6242396376988f
> 2. https://github.com/torvalds/linux/commit/82a763e61e2b601309d696d4fa514c77d64ee1be
>
> Could this patch be backported for kernels 5.6 to 5.10?

Yes, looks like the patch can be backported.

Note:  you also need to backport this commit which is a fix for the first one:

9b91b6b019fd ("ovl: fix deadlock in splice write")

Thanks,
Miklos
