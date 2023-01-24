Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4A679BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjAXOaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjAXOaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:30:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187C45BCF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:29:58 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v13so18451351eda.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G+1uN7nq3s2nCk2RmiJVxc4p/e+Kd0LQT9IpuBK+5j4=;
        b=hkG2SveTRqeD4m08EmDe66HkyxewYoVSGM8mjpcKbXn0SKTfYh4vx8ssExcm/GwNYy
         Mcr8iEujLASchLU/PQu9ydk3gWjja6sv9y1V4NCSubnWnQr7Krqn1O7Z85WELTcUNg3q
         ttnS698gv1eIaEyLS31G8959jHddO/U4lGA1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+1uN7nq3s2nCk2RmiJVxc4p/e+Kd0LQT9IpuBK+5j4=;
        b=C3NH2l4qYhvuGhw15RnNh+6RfqwWtX+KQPfU5HLxQrIFdQj/zU8wjLQi8vbMJpzoRG
         vUoSLbaUnk/TVs3+yRiu2enP/gGfBaAIjpLPyvljca7AjsuJ19sG/0zRkk/638GIlHsV
         sOhOT0QlQm82PoxaRgeoJjrNk7cLu7tKRu49K6a0OiW0h+EdrXvNbxORCkoAj+1MPlke
         ooYpHCffhgrIK/WL6oA7+20ixKc7o8+EPjfduF1DO4Y3DWtyaiJY/2I1NhwRv6Haqb/j
         7VrYJq137GMGk2HLEIvUfyoI78IqT8fz+mFb/ObSZVS0z8HgxbUqu603JIvkHz3fdnop
         Ww6Q==
X-Gm-Message-State: AO0yUKXXuPYHOIvIhDhkvZVBloXc4kGUecWz2+GA8bP5hmYFw4RlmCT4
        tQsy3SsOpJnpPmnHaeLjT9UATtnlz3ix80KyLEJLyJ0ZkCMk4w==
X-Google-Smtp-Source: AK7set/1kE1gXtTietMYZ8jKiinifzvbbOZPIU0Ca/OLqUsC9L4LZlPmA63B9j/MvtLYaOeyp5G+HyfRG9RRc1D94JA=
X-Received: by 2002:aa7:ca42:0:b0:4a0:8fd6:34c2 with SMTP id
 j2-20020aa7ca42000000b004a08fd634c2mr200352edt.67.1674570597462; Tue, 24 Jan
 2023 06:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20230118-fs-fuse-acl-v1-1-a628a9bb55ef@kernel.org>
 <CAJfpegsNZ1F1hhEaBH2Lw20CsqYm-nEFEUAH0k46_ua=5Gp2zw@mail.gmail.com> <20230124142535.dmc2k2mrqcvj66k5@wittgenstein>
In-Reply-To: <20230124142535.dmc2k2mrqcvj66k5@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Jan 2023 15:29:46 +0100
Message-ID: <CAJfpegt82Zxpi=JjmNj3AWCDYhACrYQzECD=eU1YsZKC6+eCDg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fixes after adapting to new posix acl api
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Jan 2023 at 15:25, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Jan 24, 2023 at 03:07:18PM +0100, Miklos Szeredi wrote:
> > On Fri, 20 Jan 2023 at 12:55, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > This cycle we ported all filesystems to the new posix acl api. While
> > > looking at further simplifications in this area to remove the last
> > > remnants of the generic dummy posix acl handlers we realized that we
> > > regressed fuse daemons that don't set FUSE_POSIX_ACL but still make use
> > > of posix acls.
> > >
> > > With the change to a dedicated posix acl api interacting with posix acls
> > > doesn't go through the old xattr codepaths anymore and instead only
> > > relies the get acl and set acl inode operations.
> > >
> > > Before this change fuse daemons that don't set FUSE_POSIX_ACL were able
> > > to get and set posix acl albeit with two caveats. First, that posix acls
> > > aren't cached. And second, that they aren't used for permission checking
> > > in the vfs.
> > >
> > > We regressed that use-case as we currently refuse to retrieve any posix
> > > acls if they aren't enabled via FUSE_POSIX_ACL. So older fuse daemons
> > > would see a change in behavior.
> >
> > This originates commit e45b2546e23c ("fuse: Ensure posix acls are
> > translated outside of init_user_ns") which, disables set/get acl in
> > the problematic case instead of translating them.
> >
> > Not sure if there's a real use case or it's completely theoretical.
> > Does anyone know?
>
> After 4+ years without anyone screaming for non-FUSE_POSIX_ACL daemons
> to be able set/get posix acls without permission checking in the vfs
> inside a userns we can continue not enabling this. Even if we now
> actually can.

Yes, that's my thinking as well.

> >
> > > If you're fine with this approach then could you please route this to
> > > Linus during v6.2 still? If you prefer I do it I'm happy to as well.
> >
> > I don't think I have anything pending for v6.2 in fuse, but if you
> > don't either I can handle the routing.
>
> I don't but if you'd be fine with me taking it it would make my life
> easier for another series.

Feel free to take it if that's better for you.

Thanks,
Miklos
