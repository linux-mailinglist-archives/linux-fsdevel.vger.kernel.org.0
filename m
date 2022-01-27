Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6503849D821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 03:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiA0CjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 21:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiA0CjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:39:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D6EC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 18:39:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so2562516ejc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 18:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRO+5iU1xnIh2oUFe8LZrtEMc8A8eJi0lDGLCjiGCg4=;
        b=a7KbSb0Nm/tF9qVySBCoyUn3pGajjq+Ct7Yrb0lEVpkMVGTd+37B89K7Llng3VhTg7
         FPBlMtJdpB3VBkRldNXktuzL2BZP0PhGdTqpbjArdD+4YSOd33QIM7+clo/iopUmVyda
         IEfV9oSPgGJEj1W6xhsTE+1F5u9rw+PFvng2Tg9f+0i8hqEXRsiUC3QQ2jNFbj5w2lX3
         kYC/CZJT38VOZy2+uu0htF2bnewGAOhjE3eH22NyqP5WSrHRGrQezseUm+B7hvRt029S
         jUVTs/k6w4FZieO8XWXso3V6e97OULBw7qIvwZGXdb/0UERgvuagyPulMw1cp7DUT4oy
         Lu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRO+5iU1xnIh2oUFe8LZrtEMc8A8eJi0lDGLCjiGCg4=;
        b=Jr9obLNHBCVfz6DTPy170YQHuHoaEaiLUzTI1XcpYV9wLhy9e8xXnisdBNsaz5iAxa
         OrnFKsJLUvNscrIq3XFdtAlIuZXYM/OPP22pUyWkvIBFsyxZ+pmDQYLNaU46S+9XsB2k
         t28tz3UV9rV24L0V7HpKbcrjYOqCvN1JfgW2A8Xtsle15OZzcfBjlFdcz1obChGspA8m
         mUJUF9KGtoTpRgiDMfy895fCUKpgMl97QeZLWqcJYzzOoxhLyrmZ+VAG0kKiTL3CXDbX
         oAtG/n/cTzD35yvvLxJFsCUHWZBiEJ08g8MSK2hQcFl1QUAcoD7fPGv9n1bHamNV2RHO
         V/vQ==
X-Gm-Message-State: AOAM531r1yA30YuXwCzxs5m7Tkyc3KGPKxvnD9j+SmTlFU2hIZfGjaV5
        qvln186PPnthYO1mp1bjCjJmLPQP3DnKTSZVS15WHV9zXzTAag==
X-Google-Smtp-Source: ABdhPJwtLX62XVk9zvsoBbFgzeiudo53AV8B5E3OB8xIzH9Vj7lZl38Zi4HTp9aTXW00Q3ZH/uYtmohJY+0DHGZvotI=
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr1299748ejw.682.1643251149999;
 Wed, 26 Jan 2022 18:39:09 -0800 (PST)
MIME-Version: 1.0
References: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
 <YfC5vuwQyxoMfWLP@casper.infradead.org>
In-Reply-To: <YfC5vuwQyxoMfWLP@casper.infradead.org>
From:   Daniel Black <daniel@mariadb.org>
Date:   Thu, 27 Jan 2022 13:38:58 +1100
Message-ID: <CABVffEM4KhSNywBVg06XN5JpsDaONKf7wQiKvrTvqGXosssXLg@mail.gmail.com>
Subject: Re: fcntl(fd, F_SETFL, O_DIRECT) succeeds followed by EINVAL in write
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 26, 2022 at 09:05:48AM +1100, Daniel Black wrote:
> > The kernel code in setfl seems to want to return EINVAL for
> > filesystems without a direct_IO structure member assigned,
> >
> > A noop_direct_IO seems to be used frequently to just return EINVAL
> > (like cifs_direct_io).
>
> Sorry for the confusion.  You've caught us mid-transition.  Eventually,
> ->direct_IO will be deleted, but for now it signifies whether or not the
> filesystem supports O_DIRECT, even though it's not used (except in some
> scenarios you don't care about).

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3e2de5..ff55a904bb4e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -58,7 +58,8 @@ static int setfl(int fd, struct file * filp,
unsigned long arg)
        /* Pipe packetized mode is controlled by O_DIRECT flag */
        if (!S_ISFIFO(inode->i_mode) && (arg & O_DIRECT)) {
                if (!filp->f_mapping || !filp->f_mapping->a_ops ||
-                       !filp->f_mapping->a_ops->direct_IO)
+                       !filp->f_mapping->a_ops->direct_IO ||
+                       filp->f_mapping->a_ops->direct_IO == noop_direct_IO)
                                return -EINVAL;
        }

The above patch prevents:

  filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);

being executed at the bottom of setfl which keeps the file descriptor
out of O_DIRECT mode when
the filesystem (like CIFS doesn't support it). In the original strace

So while you are mid-transition, the relatively simple flag of
direct_IO is good enough a protection
for a file descriptor entering a mode that isn't supported.

Is this an acceptable stop gap concept and/or stable backport?

>.., but I'm not quite sure what limitations cifs imposes.

Given cifs_direct_io is equivalent to the noop_direct_IO return
-EINVAL now, there's no direct io
there as I discovered testing the bug report
https://jira.mariadb.org/browse/MDEV-26970.

My patch two of the series would be to replace cifs_direct_io with
noop_direct_IO.
