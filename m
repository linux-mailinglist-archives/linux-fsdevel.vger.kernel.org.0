Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3387ABF5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjIWJcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjIWJcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:32:43 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD33CD7;
        Sat, 23 Sep 2023 02:32:25 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-452527dded1so1404978137.0;
        Sat, 23 Sep 2023 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695461544; x=1696066344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpZsOS03aAKQZkOqSWH4EjIkbO0+M63ypG5RcznWiS8=;
        b=mDBsrhiQHdn3omVLmLFot59/xqXCTnR6v2AzdDasaVJXoJeuMEL1lVdnvLpAZsr1OM
         3V67FowEPQMRuEGAXASgOvBPyHgc5EZryI94W/+Aco2FpHlEXE4WcNWK3khZ3hq7Eqqh
         5Xmc+2xLJgplXrUZzUEFjmLtkVxcpr5D2u0UzvS7J2nr37D3uHjhj5TpRcVpmMBPGoyt
         Edh924j+Gc98nOksf22eVtq+s0kxeirxRXeo4MCN4uPvAKIY1r/N/cjh2rW6UMA9QUjx
         VYNO9VxvO771oF1RzjKQ0UqwtqeAP/HJEIUW72yJsZSqlDhzDkldwVuxHdB9vHTJRQ8f
         wA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695461544; x=1696066344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpZsOS03aAKQZkOqSWH4EjIkbO0+M63ypG5RcznWiS8=;
        b=Kyr0dQ9QQ1e6r9VWTkeOHdidrs0MmbBRu3B5Cs7x+ZzP/0p2BcuaCmf3fbqWYqlZ2N
         oYCjK6Oj8v3SPIn11TDOpfLiKmEfTx2o5+0HN8w2wz9sIIej3R/uFy/leLVzKLqCIv8Q
         nZmPgive5yJ461kHUDhXO3WUVmk433sLhGWlj+58VV3/z+cFomoFtKEQMXg6PtpO7xNp
         dgsRtcIX3Y3NfOutwyqroEyI0oQExyDkmT/3kkzB0Hz4GtaruTAoZpJ46It8oAlE0ucJ
         IJ3RAEhKbbN/YMtczeLa7p4GyhKIN9Ej72PD/fCwYe/bNLhV6BUcvIvvB/zzLPFKUhGv
         nk5A==
X-Gm-Message-State: AOJu0YwR10oYGksRgZJhUN6u4vysD7Hk1BfxvU/LJDTx4CkHGGI7Up/k
        YJEELA2FM17kIYDo3nOGgXrgyAFyggagz8byapG3+qSX
X-Google-Smtp-Source: AGHT+IGxww4b9/gMghYYi/fbiMD4mWv0T13WkRzxToCctmMyGPqvM1sqjCzhE6SAljHGX8spDxRTUlQRcR304F+tDzc=
X-Received: by 2002:a67:fc48:0:b0:44d:5053:11ce with SMTP id
 p8-20020a67fc48000000b0044d505311cemr1200255vsq.19.1695461544481; Sat, 23 Sep
 2023 02:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org> <20230914-hautarzt-bangen-f9ed9a2a3152@brauner>
 <d188250d3feb3926843f76ef3ca49e9d5baa97a7.camel@kernel.org>
In-Reply-To: <d188250d3feb3926843f76ef3ca49e9d5baa97a7.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 12:32:13 +0300
Message-ID: <CAOQ4uxiKLKjPbOYZvJX7gE_z9bmJGc2XFsvrGiCHCd+i=zrZQw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 4:52=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2023-09-14 at 10:39 +0200, Christian Brauner wrote:
> > On Wed, 13 Sep 2023 09:33:12 -0400, Jeff Layton wrote:
> > > Nathan reported that he was seeing the new warning in
> > > setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> > > trying to set the atime and mtime via notify_change without also
> > > setting the ctime.
> > >
> > > POSIX states that when the atime and mtime are updated via utimes() t=
hat
> > > we must also update the ctime to the current time. The situation with
> > > overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
> > > notify_change will fill in the value.
> > >
> > > [...]
> >
> > Applied to the vfs.ctime branch of the vfs/vfs.git tree.
> > Patches in the vfs.ctime branch should appear in linux-next soon.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase=
,
> > trailer updates or similar. If in doubt, please check the listed branch=
.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.ctime
> >
> > [1/1] overlayfs: set ctime when setting mtime and atime
> >       https://git.kernel.org/vfs/vfs/c/f8edd3368615
>
> Christian, are you still planning to pick up this patch? I saw that it
> was dropped from linux-next. Since the mgtime patches have been reverted
> for now, it may be best for this to go in via the overlayfs tree ?

I think this is a long standing overlayfs bug fix, so it should go into 6.6
and not wait for 6.7 anyway.
Also need to add CC stable (don't think we need to bother with Fixes).

I do not have any overlayfs fixes queued ATM.
Christian, if you have any pening VFS fixes, you may send it along with the=
m
or we could just ask Linus to apply this one directly, so that any mgtime
changes that may still happen for 6.7 will already have this fluke fixed.

Thanks,
Amir.
