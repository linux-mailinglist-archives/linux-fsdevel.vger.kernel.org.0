Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42F35FAECA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJKI51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKI50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126672FC38;
        Tue, 11 Oct 2022 01:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8276113B;
        Tue, 11 Oct 2022 08:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F3DC433D7;
        Tue, 11 Oct 2022 08:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665478645;
        bh=9gdCBzWlK+ZqCxvUx45/nQSD0ewWfJNJAY6A4AYorO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLlJfFmSmqze9nA0WrnSA3+f1/tWA08jLIKu7qbugr72+FcJPL03wP9AqJRF7PJNY
         AbSEdSyAaA3pjb/SakpbYcu0gZUhyjmDMH38tny8/UfErjiGJOdPwOCmoJYn23XWeh
         SoYyiGz38yAm6LkMt8euqHsfhFzJXFXhnKWPq2mgA7lkGAe9aU45EcOMjTIGAv86CX
         yWUrxMS0OzzrCuiyfz80UZ883OBja6qGEAuWKFaWP34ivnxKAR8hInBvRrZm10ieDC
         ooi1jWh1LBvVgK1T6QM4RiFCrlxzkPA/iccIKEKT3jvVp1LzUFuxt855Pk0lOIj8k6
         8g/gU5XJa/Cfg==
Date:   Tue, 11 Oct 2022 10:57:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] attr: add setattr_drop_sgid()
Message-ID: <20221011085716.5zp463yim2kl7j2e@wittgenstein>
References: <20221007140543.1039983-1-brauner@kernel.org>
 <20221007140543.1039983-2-brauner@kernel.org>
 <CAOQ4uxhapYW7nQUEK1b=GQ_E_z_n8d495mSnNo-pC-LuM4GK-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhapYW7nQUEK1b=GQ_E_z_n8d495mSnNo-pC-LuM4GK-w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 11:11:37AM +0300, Amir Goldstein wrote:
> On Fri, Oct 7, 2022 at 5:06 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > In setattr_{copy,prepare}() we need to perform the same permission
> > checks to determine whether we need to drop the setgid bit or not.
> > Instead of open-coding it twice add a simple helper the encapsulates the
> > logic. We will reuse this helpers to make dropping the setgid bit during
> > write operations more consistent in a follow up patch.
> >
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> Looks good.
> Some suggestions below - not  a must.
> 
> Thanks,
> Amir.
> 
> > ---
> >
> > Notes:
> >     /* v2 */
> >     patch added
> >
> >  fs/attr.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/attr.c b/fs/attr.c
> > index 1552a5f23d6b..b1cff6f5b715 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -18,6 +18,27 @@
> >  #include <linux/evm.h>
> >  #include <linux/ima.h>
> >
> > +/**
> > + * setattr_drop_sgid - check generic setgid permissions
> 
> Helper name sounds like a directive, where it should sound like a question.
> e.g. setattr_should_remove_sgid()

sounds good

> 
> > + * @mnt_userns:        User namespace of the mount the inode was created from
> > + * @inode: inode to check
> > + * @vfsgid: the new/current vfsgid of @inode
> > + *
> > + * This function determines whether the setgid bit needs to be removed because
> > + * the caller lacks privileges over the inode.
> > + *
> > + * Return: true if the setgid bit needs to be removed, false if not.
> 
> You may want to consider matching the return value to that of
> should_remove_sgid(), that is 0 or ATTR_KILL_SGID to make all the family of
> those helpers behave similarly.

fine by me
