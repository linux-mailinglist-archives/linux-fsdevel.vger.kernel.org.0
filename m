Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C41140820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 11:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAQKjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 05:39:04 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:41724 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgAQKjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:39:04 -0500
Received: by mail-io1-f54.google.com with SMTP id m25so9858414ioo.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 02:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXjqTiCPhVILgOmuUkCGMWxO2hhV3TEv9ctgmQ7IcjQ=;
        b=NA5lAv/jVzYYvuYe2mVlsRwP5uFYyCZSfqPJ6nN8nKrRrHv1ANCmG2vW/IqCD0Ghzr
         76xfgUGsQ6w2nuG+Ur/WHv5O8VwVaEI2rcjOXg4g5QJLr5gel1tsbQQssRALaHWL67Kh
         L/ZqMD5kDRS7qmWYC7jRjl7Oxc8ND2dHhMGXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXjqTiCPhVILgOmuUkCGMWxO2hhV3TEv9ctgmQ7IcjQ=;
        b=NyIVYl23fERAQQUp4dHF5AcAWWDKKW9625Erb+C6ZekkTNhWLrugYb3ct2ESZLBS0v
         2GNSqewMt1VEq89XvNNeLSGl6Kg58KBdF9zKX/G2QSJJGXR7lL9RDRkNOn0azbb7naiw
         fxut3XqB1bVeVcY5SPHMFTZl/GWsx0RWcwkD4Vtt/V5RcixGopbd4hAl/0nukQfYYkRe
         YaQqndadaMgG0JG2e87gZaX2mbigHkwMDczpM5wni7tDJHkH5w7U2OsOMlZc4KrAiWLn
         O5RXqfx/0eV3GCOUHznsR/3N8Gzb5jS66oxSLUf2JYnhCaMlkRrdhzSUf45+s0LzsgsB
         6omw==
X-Gm-Message-State: APjAAAXhTjsONI2fl/ckK8/78N0E/HJ8YdjTRcfAKmSitRHY9snE/JU/
        B7Uty8MBiOeE5Q/YEIQQj/TUS4SCSjnksksKNcwtD1ZcRys=
X-Google-Smtp-Source: APXvYqzwbnDcvwh8Y/I7rBbTJ3E0lT2AOOVZ9kLZZWKg4kHpeoMGALeUJD/OJGBI4+mgskXNyKTDGRKWMqydMRNtGKY=
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr30639320ioc.174.1579257543391;
 Fri, 17 Jan 2020 02:39:03 -0800 (PST)
MIME-Version: 1.0
References: <c137b88f142d5e13c80d7689513e2da9.squirrel@emailmg.dotster.com>
In-Reply-To: <c137b88f142d5e13c80d7689513e2da9.squirrel@emailmg.dotster.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 Jan 2020 11:38:52 +0100
Message-ID: <CAJfpegtzzkYaDDM7uRKbARB4eV_5SCw42-a+3Xhtuh2q9TAhog@mail.gmail.com>
Subject: Re: [fuse-devel] avoiding atime invalidation with mount -o noatime
 (instead of just -o ro)
To:     Robert Byrnes <byrnes@wildpumpkin.net>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:56 PM Robert Byrnes <byrnes@wildpumpkin.net> wrote:
>
> The fuse module invalidates the atime after any operation (like readlink)
> that might change it, using this function (in fs/fuse/dir.c) ...
>
> /**
>  * Mark the attributes as stale due to an atime change.  Avoid the
> invalidate if
>  * atime is not used.
>  */
> void fuse_invalidate_atime(struct inode *inode)
> {
>         if (!IS_RDONLY(inode))
>                 WRITE_ONCE(get_fuse_inode(inode)->inval_atime, 1);
> }
>
> Shouldn't that be IS_NOATIME instead of IS_RDONLY?

It would work if we also added an INIT flag (e.g. FUSE_NOATIME) which
would set SB_NOATIME on the fuse superblock.

The current per-mount "noatime" option doesn't work exactly because
it's per-mount and we cannot determine if all mounts of a given
superblock have this flag set.

Thanks,
Miklos
