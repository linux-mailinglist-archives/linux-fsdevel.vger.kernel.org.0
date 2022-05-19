Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15A52CED1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiESI7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiESI73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 04:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD80A5033
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 01:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DB7618A9
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 08:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1E9C385AA;
        Thu, 19 May 2022 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652950766;
        bh=GY6SZbFS5otLT8yQYUe0RJ2U4Gc+ZzIdcfkzMQBRkUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKCJPlaPNPSgBq0s9Zvs7qdaq5CSuiDYo5NEUhPXsm3wlviVWctQoiQASKGoT2KcA
         1bQ0H7/L2FstEYx3JxbvFnhDfhRvoGyqQI3OsSh5aCYX4XuawhAeY5/ad1rro7iR57
         jMCLgjK1E9GrFUBFyS27uO4wZ/dnAeuOnBAt+TN2KneTggt7EFtNHcNJmjAcgdWnzr
         24CW70/MT+L0sPSIATFzs3g5arNwpeoJUk/Z4VYd6aAr3yrza+6ngfgPMwO2485SNU
         nznbphTp/3we6cl/MT9QZZIiIv2sOgLeFJ1YZ7iY1MjoR0lwX7bSX0i8n+0iqwU+Wo
         M9YSbsKxXIcpg==
Date:   Thu, 19 May 2022 10:59:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, clm@fb.com
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
Message-ID: <20220519085919.yqj2hvlzg7gpzby3@wittgenstein>
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
 <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
 <d6f632bc-c321-488d-f50e-749d641786d6@fb.com>
 <20220518112229.s5nalbyd523nxxru@wittgenstein>
 <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
 <CAEf4BzaNjPMgBWuRH_me=+Gp6_nmuwyY7L-wiGFs6G=5A=fQ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzaNjPMgBWuRH_me=+Gp6_nmuwyY7L-wiGFs6G=5A=fQ4g@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 09:56:26PM -0700, Andrii Nakryiko wrote:
> On Wed, May 18, 2022 at 4:26 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, 18 May 2022 at 13:22, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, May 17, 2022 at 12:50:32PM -0400, Dave Marchevsky wrote:
> >
> > > > Sorry to ressurect this old thread. My proposed alternate approach of "special
> > > > ioctl to grant exception to descendant userns check" proved unnecessarily
> > > > complex: ioctls also go through fuse_allow_current_process check, so a special
> > > > carve-out would be necessary for in both ioctl and fuse_permission check in
> > > > order to make it possible for non-descendant-userns user to opt in to exception.
> > > >
> > > > How about a version of this patch with CAP_DAC_READ_SEARCH check? This way
> > > > there's more of a clear opt-in vs CAP_SYS_ADMIN.
> > >
> > > I still think this isn't needed given that especially for the use-cases
> > > listed here you have a workable userspace solution to this problem.
> 
> Unfortunately such userspace solution isn't that great in practice.
> It's both very cumbersome to implement and integrate into existing
> profiling solutions and causes undesired inefficiencies when
> processing (typically for stack trace symbolization) lots of profiled
> processes.
> 
> > >
> > > If the CAP_SYS_ADMIN/CAP_DAC_READ_SEARCH check were really just about
> > > giving a privileged task access then it'd be fine imho. But given that
> > > this means the privileged task is open to a DoS attack it seems we're
> > > building a trap into the fuse code.
> 
> Running under root presumably means that the application knows what
> it's doing (and it can do a lot of dangerous and harmful things
> outside of FUSE already), so why should there be any more opt in for
> it to access file contents? CAP_SYS_ADMIN can do pretty much anything
> in the system, it seems a bit asymmetric to have extra FUSE-specific
> restrictions for it.

Processes trying to access a fuse filesystem that is not in the same
userns or a descendant userns are open to DoS attacks. This specifically
includes processes capable in the initial userns.

If it suddenly becomes possible that an initial userns capable process
can access fuse filesystems in any userns than any such process
accessing a fuse filesystem unintentionally will be susceptible to DoS
attacks.

Iow, the problem isn't that an initial userns capable process is doing
something harmful and we're overly careful trying to prevent this and
thereby going against standard CAP_SYS_ADMIN assumptions; it's that an
initial userns capable process can unintentionally have something
harmful done to it simply by accessing a fuse filesystem.

This is even more concerning since rn this isn't possible so this patch
is removing a protection/security mechanism. The performance argument
isn't enough to justify this imho.
