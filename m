Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61673AFEE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 10:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVISB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 04:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhFVISB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:18:01 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E559C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 01:15:45 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 68so10746966vsu.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 01:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fBZ1Ev6GHxUQn3fBst0VOzSI+BUF9+aEPLLhXZ2LcI=;
        b=DW0ID9vluPv8bmvm0v8jbmNJLpJD/07sJktqHOnOpPK/aDDRNOw6xBZP+F3PV9af3K
         Kag1oduUDAxG1wpxqy7i9NuXUM6G8HFBukvL03BLFePdmhO/VhdADzp0K8/gl3DkEAMy
         q0Rr5ZmERlN+xZ+cxlrqKRwmFaYkeffMjBrhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fBZ1Ev6GHxUQn3fBst0VOzSI+BUF9+aEPLLhXZ2LcI=;
        b=iyNufNACU9jpt1clMVhRWbTLCdyB5DhHyrIJ1/Ga6ngOkXGXz5YVhJcUHTVDW2AjAP
         Lyir0a7mf3FSpeuKefKGi4gwh1Kr5Cfg8/M3reTEhYKvWVsPcWGGqnLS6GEZZ4Vl76ve
         4pd34RoP6vx1sy2i+hwa9WSFy4S0TeIBvuM8wGnCc5MOoWuSjmoSwM54RArV+76F+JKJ
         yVXeYwpo86meeyAf3mDZ5PJPp1qX1pVFYT9kFbjdB+bBeoh7nAcjDU5N9RX1NyjlixOA
         2FeMa/jRQ8YbtaxM9ESxNH5T2KdbW1D7dVCp40+iw1gqYKxVZojfd0XK8uL0dvj98pDp
         +q3Q==
X-Gm-Message-State: AOAM532qTvZpxQmZA//5dQXM4Et4HCS7hemkrdRsWpZWRmTsCXwerR6y
        EnJyIcqVsoO+NgQjVzNBAyC6JAIPHS534Fqv6yXzfQ==
X-Google-Smtp-Source: ABdhPJy6q/DecXMC0uNR5oE3AyqBtYu6bsUtD7LDlGEM4JyeKBujwTJ//Bsr0DjF6urOnNr+KxDlM3OKHlszgTDqhsE=
X-Received: by 2002:a05:6102:227c:: with SMTP id v28mr11281791vsd.7.1624349744284;
 Tue, 22 Jun 2021 01:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210621110353.1203828-1-amir73il@gmail.com>
In-Reply-To: <20210621110353.1203828-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Jun 2021 10:15:33 +0200
Message-ID: <CAJfpegtGKjeK8E5QsHKF0=re1J9wVHuGRVgg9NDJ_OOwQdCUNg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix illegal access to inode with reused nodeid
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Jun 2021 at 13:03, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
> with ourarg containing nodeid and generation.
>
> If a fuse inode is found in inode cache with the same nodeid but
> different generation, the existing fuse inode should be unhashed and
> marked "bad" and a new inode with the new generation should be hashed
> instead.
>
> This can happen, for example, with passhrough fuse filesystem that
> returns the real filesystem ino/generation on lookup and where real inode
> numbers can get recycled due to real files being unlinked not via the fuse
> passthrough filesystem.
>
> With current code, this situation will not be detected and an old fuse
> dentry that used to point to an older generation real inode, can be used
> to access a completely new inode, which should be accessed only via the
> new dentry.
>
> Note that because the FORGET message carries the nodeid w/o generation,
> the server should wait to get FORGET counts for the nlookup counts of
> the old and reused inodes combined, before it can free the resources
> associated to that nodeid.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Applied and pushed.

Thanks,
Miklos
