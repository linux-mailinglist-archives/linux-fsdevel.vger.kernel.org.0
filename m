Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7D35826D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhDHLpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhDHLpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:45:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266CC061760;
        Thu,  8 Apr 2021 04:44:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id x17so1894028iog.2;
        Thu, 08 Apr 2021 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBcMG+dV/7+95vKcKuoiPYoSG5DzpuFNtQO+n2Bns/o=;
        b=Qi1bT/IWDxI6zA/zoXi9Z9DnSpM4KJghPeUlP1IryoDhXaHlMDtiyw+YsgI0A31evm
         W7FON9oyIubLuBD3rMLudaIe48zVHfHNMIjZIjLVyLzYEqDGflM49BSZvszsIeaImBON
         FkWrEpnLEQaMaHrpYQuHs6IZsb/9q57uVu8B3/TWmrdFX7dFJqlDfueexlVP8X+P9xed
         RgUy7wx+m0QGYld0LuVwVJpORmhca/MeGgJG4deW4uKT17wTQLskSfdxK8lwNEbYGdGt
         M+AY72v6wm3BawvP6X7vV0VQuctfZmJHoUX1NCn/hrh/imZClCM8ZIHJd1koJY6hswr/
         +3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBcMG+dV/7+95vKcKuoiPYoSG5DzpuFNtQO+n2Bns/o=;
        b=GScEnzBKShtOJ/evxLGBCTUv0+iFqzc7JzlyLWSqaLGXoeaoZ8C0ICcPl6r0Q2TOns
         oWYGcre7TT2WQW9FRd2ZYC4dLDfWLhiVUuZxhaR+EGAvKFqtpd/RkhchL63HZe+L3wDP
         OpFNKBmEZjHyXv2KjCtnOMNc2nAv6d4vn1KyAi1oUkEdI91vnwy0AY9YHFKAVq6Ib/1N
         bTNVXAsbxfAGav/dsNVE0TVSehMD2Z6xGYD47XRai3RBXGLhWsxYHZatO79MmMbguqp6
         9NSS2TzFfscosjbd+Jgjr9LQaeUnXYuT2uAOBkx9vPJmEcrq9pZzL4ZUwK2ajuDUaIrL
         2yew==
X-Gm-Message-State: AOAM530UZZbolC6ui9Z58A47P9NCGAcPxKyCNBqCHFLPLfJVvNIhwATy
        r8G15OOSz4gPUI9KuskHhSCpUS+ejdKbiupGBFfDoQQBCwE=
X-Google-Smtp-Source: ABdhPJziG18OtJtOojNJhUmbh8ECPZy7NwUwithSHK0QoonoPEUgXM8AdPlzvYSsRRGH5vqUkFATXIOMaHxuOuZvjXc=
X-Received: by 2002:a5e:8d01:: with SMTP id m1mr6322958ioj.72.1617882298600;
 Thu, 08 Apr 2021 04:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
 <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com> <20210331100854.sdgtzma6ifj7w5yn@wittgenstein>
In-Reply-To: <20210331100854.sdgtzma6ifj7w5yn@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 8 Apr 2021 14:44:47 +0300
Message-ID: <CAOQ4uxjHsqZqLT-DOPS0Q0FiHZ2Ge=d3tP+3-qd+O2optq9rZg@mail.gmail.com>
Subject: Re: open_by_handle_at() in userns
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> One thing your patch
>
> commit ea31e84fda83c17b88851de399f76f5d9fc1abf4
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Sat Mar 20 12:58:12 2021 +0200
>
>     fs: allow open by file handle inside userns
>
>     open_by_handle_at(2) requires CAP_DAC_READ_SEARCH in init userns,
>     where most filesystems are mounted.
>
>     Relax the requirement to allow a user with CAP_DAC_READ_SEARCH
>     inside userns to open by file handle in filesystems that were
>     mounted inside that userns.
>
>     In addition, also allow open by handle in an idmapped mount, which is
>     mapped to the userns while verifying that the returned open file path
>     is under the root of the idmapped mount.
>
>     This is going to be needed for setting an fanotify mark on a filesystem
>     and watching events inside userns.
>
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Requires fs/exportfs/expfs.c to be made idmapped mounts aware.
> open_by_handle_at() uses exportfs_decode_fh() which e.g. has the
> following and other callchains:
>
> exportfs_decode_fh()
> -> exportfs_decode_fh_raw()
>    -> lookup_one_len()
>       -> inode_permission(mnt_userns, ...)
>
> That's not a huge problem though I did all these changes for the
> overlayfs support for idmapped mounts I have in a branch from an earlier
> version of the idmapped mounts patchset. Basically lookup_one_len(),
> lookup_one_len_unlocked(), and lookup_positive_unlocked() need to take
> the mnt_userns into account. I can rebase my change and send it for
> consideration next cycle. If you can live without the
> open_by_handle_at() support for now in this patchset (Which I think you
> said you could.) then it's not a blocker either. Sorry for the
> inconvenience.
>

Christian,

I think making exportfs_decode_fh() idmapped mount aware is not
enough, because when a dentry alias is found in dcache, none of
those lookup functions are called.

I think we will also need something like this:
https://github.com/amir73il/linux/commits/fhandle_userns

I factored-out a helper from nfsd_apcceptable() which implements
the "subtree_check" nfsd logic and uses it for open_by_handle_at().

I've also added a small patch to name_to_handle_at() with a UAPI
change that could make these changes usable by userspace nfs
server inside userns, but I have no demo nor tests for that and frankly,
I have little incentive to try and promote this UAPI change without
anybody asking for it...

Thanks,
Amir.
