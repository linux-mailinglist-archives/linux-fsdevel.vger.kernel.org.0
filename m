Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D6436AA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhJUSjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 14:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhJUSjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:39:14 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C6C0613B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 11:36:57 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id h19so3035697uax.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQ1BkZGdfQqr68+FkVlcNTVXjjJhPAtAhc4xVpJMJ2I=;
        b=iZrKsVtYWb8p4KD642tS9cJdWKeiXpRqG9LgpqqqwD3Zs+5/PPx5Oqp3u2VrY7Cb1U
         2cBukLctjqk9oJoe98aWlJ2yo3C65K1nIfi5Xw93OGhwwIyUcqNul/Tb4Dstd4/cO0cU
         F/v3yqO2N4/fQ+zU2tFogaBZuB1DFEcJ2eQVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQ1BkZGdfQqr68+FkVlcNTVXjjJhPAtAhc4xVpJMJ2I=;
        b=KG+ZUriBDEw99c4VUBltkcGsfBBI0xXHwwG0hQR9o6kVg8iKFDTPZbXWy7gn8iM1ol
         fA0vvD+JRkHmVfZz0XTowXs1rFoqEJpXTyBJCgD0wFsonuHGEtV42cVD9bQuGavUeecL
         ImQ6f9KwabYqI2NUYxxJgGgTHnUq6PxY3JP08Wd2tienUBVZ7bqcG3Hs0QgnK7otQcMw
         Z6QPD2X1Jxi/td+Q3zo//FHuAHVhC+6VG3qsbnn8E9lg9maW7GGrE3Su89ZW8ijUPRAm
         XJGnK89EEjmHJ8zVIuTV3Ro0ttA8GG+7el2rVyhqTyFNnAMzNRLx7kLmjprz9n2A9OEg
         CBfw==
X-Gm-Message-State: AOAM531C2RkAmQcIqWOQ6kkagt0yCP2nWY7dqon/RebZNBAOyq9Wd77/
        nTnGVhfTUiUFgQHQ4iZJCKRvlSdxeli1gTKMzf3EGNY/VZE=
X-Google-Smtp-Source: ABdhPJyVNGdGypAY0uH/Bt0x4HvnQu6vo3Z57NRnLrKa4NlK3zPvt8WC6esZANHCm6v2hw9szLV1v4L5ZN/NNp8UeOM=
X-Received: by 2002:a67:d504:: with SMTP id l4mr8759253vsj.42.1634841417011;
 Thu, 21 Oct 2021 11:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxiJrEOHyHeY49dLMaJ4-8=RCGc+oawyWPrkuP28NRsT3Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiJrEOHyHeY49dLMaJ4-8=RCGc+oawyWPrkuP28NRsT3Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Oct 2021 20:36:46 +0200
Message-ID: <CAJfpegspE8e6aKd47uZtSYX8Y-1e1FWS0VL0DH2Skb9gQP5RJQ@mail.gmail.com>
Subject: Re: [RFC] Optional FUSE flush-on-close
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021 at 18:12, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Miklos,
>
> We have a use case where fuse_sync_writes() is disruptive
> to the workload.
>
> Some applications, which are not under our control do
> open(O_RDONLY);fstat();close() and are made to block waiting on writes
> that they are not responsible for.
>
> Looking at other network filesystems, cifs and nfs only flush on close
> for FMODE_WRITE files.
> Some older SMB flavors (smb1, smb2) do also flush on RDONLY files.
>
> In particular, our FUSE filesystem does not even implement FLUSH
> and it has writeback caching disabled, so the value of flush on close
> is even more questionable.
>
> Would you be willing to consider a patch that makes flush-on-close
> behavior optional for RDONLY files?
> If so, should I make this option available only when filesystem
> does not implement FLUSH or independent?
> Should I make an option to completely disable flush-on-close
> (i.e. like most disk filesystems)?

Flushing dirty pages for writable files  is mandatory for the
writeback cache case.  Otherwise you are correct, this could be
disabled.

How about FOPEN_NOFLUSH?

Thanks,
Miklos

>
> Thanks,
> Amir.
