Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B092AD0AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 08:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgKJHwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 02:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJHwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:52:40 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FF2C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 23:52:38 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id r23so3670377uak.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 23:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCW6KHW55j94vINgS4ySzjAjrMDhUIihDEm+/LvUsIE=;
        b=YydZNRksYBJoa4vOgUx56KCShxjRMPNm6qn+DxNHKQyuJQ8j8f5Iob8ry21idpUPTo
         gHVytv5aDmcCXiRtESVAs8WQgP+fcBI2ckCRXbUuOTYBGqJPtPoYRyBOagTN6XfvG/Ng
         zd66VV7N0Kq7l3JdUO97VJlIUfZST2wYl/30Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCW6KHW55j94vINgS4ySzjAjrMDhUIihDEm+/LvUsIE=;
        b=ptMy4fydERsMk52d1iE2UIGyDsCnGHIFr6cvlZNKgzTyef6Uew5iX55JODosHBI0HM
         5xHin1LWBOKk65p/lqCImjaC7nY3wn7C21nimDoR6P7PjOyNkNYwlrU/+QHSh2MZfDAc
         M+YxKKCvuQmODiUgQO5W2BqlBhbRip6rgMYymJg1PwF7fGlaVyyfkP0tvZeAGfJbKJ+B
         cciKDNzRI3u0qcGWRIZJweNPKqDaOxOcKup7dNEy7g7GcigWBBg6tud7VfwT/2kpD6My
         SodDVARPF3f42x8m0s7hAn/Sxiq902r7j9UznpBAZLMArRaAIwpwvb1DHgwHiZpYd5m4
         SRNw==
X-Gm-Message-State: AOAM532dr33kVLM0EeKtKKLrbD/MQ3Y5uSSWibHGEP/yPYCarH+bBeam
        FkN68FwxC8GNjxgcflgEnZszHfS6fcLs83/UMwWINw==
X-Google-Smtp-Source: ABdhPJwrZJgrj741kD29v9ybkGIHMRvwDollWA/MIxzA4RjrQmxi53FEYCveTgDDUOF/P5l4AlEDdhzQs/kvMcP1BWM=
X-Received: by 2002:ab0:2a1:: with SMTP id 30mr6013365uah.72.1604994757919;
 Mon, 09 Nov 2020 23:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20201109100343.3958378-1-chirantan@chromium.org>
 <20201109100343.3958378-3-chirantan@chromium.org> <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
 <CAJFHJrqZMg6A_QnoOL3e5gNZtYquUPSr4B0ZLZMSKQH6o7sxag@mail.gmail.com>
In-Reply-To: <CAJFHJrqZMg6A_QnoOL3e5gNZtYquUPSr4B0ZLZMSKQH6o7sxag@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Nov 2020 08:52:27 +0100
Message-ID: <CAJfpegsjeRSeabJK5xLr4g7mDkwT88u+iOnhwCj_78-HT+HVqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Chirantan Ekbote <chirantan@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 4:33 AM Chirantan Ekbote <chirantan@chromium.org> wrote:

> That's not the behavior I observed.  Without this, the O_TMPFILE flag
> gets passed through to the server.  The call stack is:
>
> - do_filp_open
>     - path_openat
>         - do_tmpfile
>             - vfs_tmpfile
>                 - dir->i_op->tmpfile
>             - finish_open
>                 - do_dentry_open
>                     - f->f_op->open
>
> and I didn't see O_TMPFILE being removed anywhere in there.

Ah, indeed.

The reason I missed this is because IMO the way it *should* work is
that FUSE_TMPFILE creates and opens the file in one go.  We shouldn't
need two separate request.

Not sure how we should go about this... The ->atomic_open() API is
sufficient, but maybe we want a new ->atomic_tmpfile().

Al?

Thanks,
Miklos
