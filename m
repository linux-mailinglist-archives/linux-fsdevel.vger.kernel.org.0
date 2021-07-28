Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA253D8B7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhG1KNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhG1KNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:13:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA98C061757;
        Wed, 28 Jul 2021 03:13:21 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y9so2370494iox.2;
        Wed, 28 Jul 2021 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QmGiwadyrl2A+oRU9PREaFTgjxYnsl3jarNmUA0ccc=;
        b=kadjRfSLGIehVOh2FYcHRdTnMQ4rBvIIaauQ6SxaBbZAZkksYFzd9Ky5hPfxCW+LUr
         SkCWXABR9j/cqXd4tTUF/5vK+16xhzFBBo8gwG9Wu6bMJxe/R2a7QXtNp+L8QzJFtfNN
         IEs5BR7c/PT+jfCm6tvyeh6Kqsc/zHD1COgzWz4WGk/cTCnt4ffV90WYlV0Ot0MU/LJO
         Iz8GGSA/TqHDptPoTZ0SJcc6uU49FTIv7chd+HxCmRauHVCH/HvZy2Gp0kRmsHGEvoh/
         4tBwSrqboedPUjwITSi7J1su3Ir692IrfYGX9A6rVK7Tu3U6nre7rHZiC4+zSMle/xnh
         et2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QmGiwadyrl2A+oRU9PREaFTgjxYnsl3jarNmUA0ccc=;
        b=EJCPHfmfycqal2DmhCwQRkuJA+phYJkO/AjLmJUZEkFwdTQpwXf33Dfeu3FqlCHQFK
         /0EUOooQhuiunHCPpHc/mf4I9eYHA5GUlYNE8xBGvyeAGiAlALLm6KCh6YuibQ/MyVwh
         /ioQFh4ur8M/BXWGb5DfD5o7jx86TQXuFUFOZjf5xEJzKdttHwA8UuON0v239IGT7oG4
         2v57dIrNeiBNl8s7+SSYc/iTjrTM84TF8swmRjGlQUiZCfSgqWE+ycRlSG5TJTTQZxO3
         68eAMO8J/Cq5FiFCzudRxx6BaGEaBrzByDAFp0oRFLRgvws5ctfnz0Rk6zjRU0kcV6eK
         r9lA==
X-Gm-Message-State: AOAM533gFf3OiBtsLHVhr1suEKHM7tMp2xfScm+No+IsWSKvyHkcJ7aF
        CoyMMghWPuCTiqzOBTWjCodc3nLNcAFNFqikch4=
X-Google-Smtp-Source: ABdhPJyx8yGLAmnj+e5VNODQ+YpsxgcVgntTYM7sdQEtpN/zpo2PXyiYj8b+zHlkvjByjECZGxzk5U2VLr7h6nOk9Vs=
X-Received: by 2002:a05:6638:1907:: with SMTP id p7mr25944211jal.93.1627467201116;
 Wed, 28 Jul 2021 03:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown> <162742546554.32498.9309110546560807513.stgit@noble.brown>
In-Reply-To: <162742546554.32498.9309110546560807513.stgit@noble.brown>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Jul 2021 13:13:10 +0300
Message-ID: <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com>
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 1:44 AM NeilBrown <neilb@suse.de> wrote:
>
> When a filesystem has internal mounts, it controls the filehandles
> across all those mounts (subvols) in the filesystem.  So it is useful to
> be able to look up a filehandle again one mount, and get a result which
> is in a different mount (part of the same overall file system).
>
> This patch makes that possible by changing export_decode_fh() and
> export_decode_fh_raw() to take a vfsmount pointer by reference, and
> possibly change the vfsmount pointed to before returning.
>
> The core of the change is in reconnect_path() which now not only checks
> that the dentry is fully connected, but also that the vfsmnt reported
> has the same 'dev' (reported by vfs_getattr) as the dentry.
> If it doesn't, we walk up the dparent() chain to find the highest place
> where the dev changes without there being a mount point, and trigger an
> automount there.
>
> As no filesystems yet provide local-mounts, this does not yet change any
> behaviour.
>
> In exportfs_decode_fh_raw() we previously tested for DCACHE_DISCONNECT
> before calling reconnect_path().  That test is dropped.  It was only a
> minor optimisation and is now inconvenient.
>
> The change in overlayfs needs more careful thought than I have yet given
> it.

Just note that overlayfs does not support following auto mounts in layers.
See ovl_dentry_weird(). ovl_lookup() fails if it finds such a dentry.
So I think you need to make sure that the vfsmount was not crossed
when decoding an overlayfs real fh.

Apart from that, I think that your new feature should be opt-in w.r.t
the exportfs_decode_fh() vfs api and that overlayfs should not opt-in
for the cross mount decode.

Thanks,
Amir.
