Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B967B5D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjAYPY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjAYPY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:24:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B154F367CF;
        Wed, 25 Jan 2023 07:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C3B960AC5;
        Wed, 25 Jan 2023 15:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C136C433EF;
        Wed, 25 Jan 2023 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674660294;
        bh=vGZxLL8Kih6ZUvnJ1PgCoWGLMY6Q40QpFdxprKkMVTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHso1wUkswmNaGpjHPAtxxcEkXz9RCf0XqjugaVcr7vh65WBNm3LDsHGQWuNd88ai
         LJ3HZCLaU4V+64cG1/85k6wSSHpIHpqUPBmOKzwXK70zyHhANxugrCJCdcB8PErZCy
         LxRoT2objV8jHNJk3xgTIHR45S6B/mG8lmySUcEcEzgnGEItoMsqd04QbY+TMhsWnp
         g4zAaK3sRZ96/mNgUOJgVn38q9p71nAX0xwu9uKz6aDTJ42TdE+3RU1YUC7+Uzjt7T
         qOjt/dbAWwJx3F5qMJM9WU90FYkox3HG5WI8ibloyxxGTmsS9i4q+vYcPtVl/Cj+Hn
         cRFuiMf0AjgdA==
Date:   Wed, 25 Jan 2023 16:24:49 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Message-ID: <20230125152449.s6sa2tl5sbtofw3t@wittgenstein>
References: <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <20230125041835.GD937597@dread.disaster.area>
 <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <87wn5ac2z6.fsf@redhat.com>
 <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
 <87o7qmbxv4.fsf@redhat.com>
 <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:46:59PM +0200, Amir Goldstein wrote:
> > >
> > > Based on Alexander's explanation about the differences between overlayfs
> > > lookup vs. composefs lookup of a regular "metacopy" file, I just need to
> > > point out that the same optimization (lazy lookup of the lower data
> > > file on open)
> > > can be done in overlayfs as well.
> > > (*) currently, overlayfs needs to lookup the lower file also for st_blocks.
> > >
> > > I am not saying that it should be done or that Miklos will agree to make
> > > this change in overlayfs, but that seems to be the major difference.
> > > getxattr may have some extra cost depending on in-inode xattr format
> > > of erofs, but specifically, the metacopy getxattr can be avoided if this
> > > is a special overlayfs RO mount that is marked as EVERYTHING IS
> > > METACOPY.
> > >
> > > I don't expect you guys to now try to hack overlayfs and explore
> > > this path to completion.
> > > My expectation is that this information will be clearly visible to anyone
> > > reviewing future submission, e.g.:
> > >
> > > - This is the comparison we ran...
> > > - This is the reason that composefs gives better results...
> > > - It MAY be possible to optimize erofs/overlayfs to get to similar results,
> > >   but we did not try to do that
> > >
> > > It is especially important IMO to get the ACK of both Gao and Miklos
> > > on your analysis, because remember than when this thread started,
> > > you did not know about the metacopy option and your main argument
> > > was saving the time it takes to create the overlayfs layer files in the
> > > filesystem, because you were missing some technical background on overlayfs.
> >
> > we knew about metacopy, which we already use in our tools to create
> > mapped image copies when idmapped mounts are not available, and also
> > knew about the other new features in overlayfs.  For example, the
> > "volatile" feature which was mentioned in your
> > Overlayfs-containers-lpc-2020 talk, was only submitted upstream after
> > begging Miklos and Vivek for months.  I had a PoC that I used and tested
> > locally and asked for their help to get it integrated at the file
> > system layer, using seccomp for the same purpose would have been more
> > complex and prone to errors when dealing with external bind mounts
> > containing persistent data.
> >
> > The only missing bit, at least from my side, was to consider an image
> > that contains only overlay metadata as something we could distribute.
> >
> 
> I'm glad that I was able to point this out to you, because now the comparison
> between the overlayfs and composefs options is more fair.
> 
> > I previously mentioned my wish of using it from a user namespace, the
> > goal seems more challenging with EROFS or any other block devices.  I
> > don't know about the difficulty of getting overlay metacopy working in a
> > user namespace, even though it would be helpful for other use cases as
> > well.
>

If you decide to try and make this work with overlayfs I can to cut out
time and help with both review and patches. Because I can see this being
beneficial for use-cases we have with systemd as well and actually being
used by us as we do make heavy use of overlayfs already and probably
will do even more so in the future on top of erofs.

(As a sidenote, in the future, idmapped mounts can be made useable from
userns and there's a todo and ideas for this on
https://uapi-group.org/kernel-features.

Additionally, I want users to have the ability to use them without any
userns in the mix at all. Not just because there are legitimate users
that don't need to allocate a userns at all but also because then we can
do stuff like map down a range of ids to a single id (what probably nfs
would call "squashing") and other stuff.)

Christian
