Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533A387A79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbhERN54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbhERN54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 09:57:56 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061CBC061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 06:56:38 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id f1so3236336uaj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0218MIjV6sDk3GtBhJUUBoqbpznvnThNvXyXAl2dRdo=;
        b=cRL2w3zHWlxCUzo28Q5gSGrJRv38mw6NXXdLPG2CP2eZHhN5159XlXpc4TnJ74kX/1
         kg8/NtknW1TWLEtB1XL9yfyrlnDrtBj3qRO4ARcBnSO+ZoHNNy6CUMo4J9451eOa3cY0
         jSJ/yB9Ld6UNrUHjv7GP5lWg33y8WbC5pVsAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0218MIjV6sDk3GtBhJUUBoqbpznvnThNvXyXAl2dRdo=;
        b=qCtn4lVpQLrYbdbbifXxAkNN+6315EWCtb+veaZ3ym9ebJFhwqdBrd54yn4hcTW25c
         b91ihFiTWcm0KajByNvVi8OGJa3EuTzQfpIwPW8JcTwDXcxBcjK/jTQ4jvG5+nAP7R5G
         PDBk5/bEpwqPR0d1yf2gzHFnLEtjy6mxxhAaJpS2GXSNI7nbIvpymwBuce7P+Nxq03el
         XgGFRtYx9pv+nCnnelmLWTFFHKK+7XiFulGyKGFO/HUHoIPYVE5axrQ6CIZAYYtY4MCt
         YxxU1laW5wTIdkfTWJjt9YIiGBJDFncJVZcsLCWyP8fYQpTAdMFJcls7jX5gEoQDBCVF
         cdxA==
X-Gm-Message-State: AOAM533NyHcCc+EdR8ZV7IeLK/4u1lpFG1Y+mfV3VaI40wN20XZh0hBL
        n7dYOOkCtRk85kaZLtAklvCbGzVbES9pSoeAYGRpfXUohyg=
X-Google-Smtp-Source: ABdhPJxte7giQP+HVI9f/B2gI531JC6jLeyS0GC1SRzloLPO6wRCAOAhyugLZlibpywStzpKhIzB6TLxKGXUlchCa8Y=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr6459810uao.9.1621346197241;
 Tue, 18 May 2021 06:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210512161848.3513818-1-rjones@redhat.com> <20210512161848.3513818-2-rjones@redhat.com>
In-Reply-To: <20210512161848.3513818-2-rjones@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 May 2021 15:56:25 +0200
Message-ID: <CAJfpegv=C-tUwbAi+JMWrNb+pai=HiAU8YCDunE5yUZB7qMK1g@mail.gmail.com>
Subject: Re: [PATCH v4] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com,
        Shachar Sharon <synarete@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 May 2021 at 18:19, Richard W.M. Jones <rjones@redhat.com> wrote:
>
> The current fuse module filters out fallocate(FALLOC_FL_ZERO_RANGE)
> returning -EOPNOTSUPP.  libnbd's nbdfuse would like to translate
> FALLOC_FL_ZERO_RANGE requests into the NBD command
> NBD_CMD_WRITE_ZEROES which allows NBD servers that support it to do
> zeroing efficiently.
>
> This commit treats this flag exactly like FALLOC_FL_PUNCH_HOLE.

Thanks, applied.

Miklos
