Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6301A10DCB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 06:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfK3Fer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 00:34:47 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34543 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3Feq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:34:46 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so34548974iof.1;
        Fri, 29 Nov 2019 21:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=expuErTDLV7kYKDvwrUyVz/OvBmHSSvA+J1XVJvaACE=;
        b=C7nZIyE/OPXd5iYmWUU4RNdRFFn278tbUtXnJULGNurVvBQhznWYArkSIiIXCxYuXk
         fDhvb6flf+FFTkOGH09YcqzPqFykRr6cmIssudxauJ+HefllAjjDv/V7jnGF5AGCweHw
         YzWpA0QhiPtQFwdSURfDNzE3hRMPfWxxiz+pzdlvDdymck02YwLRd5KbWudj9AajmIud
         ER/ayWvQluoy1ZpKzNwQy9jgIIpXL99YGg5eucxc2PhotAFTXm6868okFz8Qv7fvxfa0
         VDOmUliJ2OFro/vMim7NOY2R5c7UtHT9iUKZy+gU+33vSCxHP2jswpV31EownMfDi9PI
         XWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=expuErTDLV7kYKDvwrUyVz/OvBmHSSvA+J1XVJvaACE=;
        b=ZNYXjZQeB4vIZcs356HwdOl1Ag/FAh42bxID7IkQ1HUKDpKXF6VC85cv17Qg/h3dTI
         Et5c/Ny0ToHH08eDAM20Ee2fiGPQFT8z3CMsizUTcZ6A8e/5qVyEoBTfUThCUcJCtfdt
         hopSOJWN/hT23WWeAtaGwMTIbAscOPiBila9EqkaCSnwqUCYopWcPbrtBkRoO6qy+yjq
         NFrYgvzCMPIe27S9uMh30eHv9GaSrjIPXx7s4j7yfixVlKWeCfn+0u52iR2fkgVI8Amy
         G+431k6VN+8Mt+as/29bGpJwPaMfzoc6yj8KT27st+kFgtsKB3Z4hhvbfqnOeyFjN1SP
         Tvcw==
X-Gm-Message-State: APjAAAUBDT63UR4xDe5ynTHRb+TSN6bWfrKJR+S9v0M6VG1QSHaumA8y
        SukTVfn0AE3iSvEd30Gcn+1olvdpdD0KGJw3p4hJM6mx
X-Google-Smtp-Source: APXvYqzuYyBumFJ/+HshpZz/AqvaKK4R+QRQm+GQDwwiCKIKRl4/m61BP3dwzpU4isz2Sm/L9bRdQV/VBksitZtkzN0=
X-Received: by 2002:a02:9307:: with SMTP id d7mr4360196jah.103.1575092086087;
 Fri, 29 Nov 2019 21:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20191124193145.22945-1-amir73il@gmail.com> <20191124194934.GB4203@ZenIV.linux.org.uk>
 <CABeXuvqZUK4UMLA=hU5i9r0k6G7E+RCi58Om-KVeZuA3OjL4fA@mail.gmail.com> <20191124213415.GD4203@ZenIV.linux.org.uk>
In-Reply-To: <20191124213415.GD4203@ZenIV.linux.org.uk>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 29 Nov 2019 21:34:35 -0800
Message-ID: <CABeXuvouvniNnxPwZbejPgZPUVgShvmPnRiGFPF8-0Z6AmmvQA@mail.gmail.com>
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 24, 2019 at 1:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Nov 24, 2019 at 01:13:50PM -0800, Deepa Dinamani wrote:
>
> > We also want to replace all uses of timespec64_trunc() with
> > timestamp_truncate() for all fs cases.
> >
> > In that case we have a few more:
> >
> > fs/ceph/mds_client.c:   req->r_stamp = timespec64_trunc(ts,
> > mdsc->fsc->sb->s_time_gran);
>
> Umm... That comes from ktime_get_coarse_real_ts64(&ts);
>
> > fs/cifs/inode.c:        fattr->cf_mtime =
> > timespec64_trunc(fattr->cf_mtime, sb->s_time_gran);
> ktime_get_real_ts64(&fattr->cf_mtime) here
>
> > fs/cifs/inode.c:                fattr->cf_atime =
> > timespec64_trunc(fattr->cf_atime, sb->s_time_gran);
> ditto
>
> > fs/fat/misc.c:                  inode->i_ctime =
> > timespec64_trunc(*now, 10000000);
>
> I wonder... some are from setattr, some (with NULL passed to fat_truncate_time())
> from current_time()...  Wouldn't it make more sense to move the truncation into
> the few callers that really need it (if any)?  Quite a few of those are *also*
> getting the value from current_time(), after all.  fat_fill_inode() looks like
> the only case that doesn't fall into these classes; does it need truncation?

I've posted a series at
https://lore.kernel.org/lkml/20191130053030.7868-1-deepa.kernel@gmail.com/
I was able to get rid of all instances but it seemed like it would be
easier for cifs to use timestamp_truncate() directly.
If you really don't want it exported, I could find some other way of doing it.

> BTW, could we *please* do something about fs/inode.c:update_time()?  I mean,
> sure, local variable shadows file-scope function, so it's legitimate C, but
> this is not IOCCC and having a function called 'update_time' end with
>         return update_time(inode, time, flags);
> is actively hostile towards casual readers...

Added this to the series as well.

-Deepa
