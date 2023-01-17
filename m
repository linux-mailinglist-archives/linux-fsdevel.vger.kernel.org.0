Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714EE66E224
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 16:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjAQP2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 10:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjAQP2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:28:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D248242BE4;
        Tue, 17 Jan 2023 07:28:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53AECB81647;
        Tue, 17 Jan 2023 15:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF791C433EF;
        Tue, 17 Jan 2023 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673969282;
        bh=lCZm8XhoDY0udwyMbywwbvfNCtyFHHnSrLicTZX52oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8aJBdnLdpKouGzKv3XhlQPRrT0bU39WIwppFamg2jxwpQ847UpxvUEGnd2moZtxX
         x9iIGv/88nR81lRSSYgYMk6wsXhVJzwg+AdfYZZKsLm089aOPcvHGw+2L3ekTvMk5O
         LLmaesfsygH6K1Qs8uapA2U8BtwK5Xp+QV9Os4Ou+S8+MhXPahBE8MK7vkYcO0EFK2
         Dexir2iVQfZ9VpSj0vLWh6AWV6SYCkBsyV2y9P21lLbXetEXFA7GVxTtY8FHnbINNi
         5rZb+b3Dcza+ijTfwjhHQmFn5hJBHHRQhQyP6W7/n8zobP5pamGPs9W/Vjzp4XZYvc
         xuEv0NZJjozxQ==
Date:   Tue, 17 Jan 2023 16:27:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Message-ID: <20230117152756.jbwmeq724potyzju@wittgenstein>
References: <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
 <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
 <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
 <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
 <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
 <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
 <87fsc9gt7b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsc9gt7b.fsf@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:56:56PM +0100, Giuseppe Scrivano wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Tue, Jan 17, 2023 at 09:05:53AM +0200, Amir Goldstein wrote:
> >> > It seems rather another an incomplete EROFS from several points
> >> > of view.  Also see:
> >> > https://lore.kernel.org/all/1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com/T/#u
> >> >
> >> 
> >> Ironically, ZUFS is one of two new filesystems that were discussed in LSFMM19,
> >> where the community reactions rhyme with the reactions to composefs.
> >> The discussion on Incremental FS resembles composefs case even more [1].
> >> AFAIK, Android is still maintaining Incremental FS out-of-tree.
> >> 
> >> Alexander and Giuseppe,
> >> 
> >> I'd like to join Gao is saying that I think it is in the best interest
> >> of everyone,
> >> composefs developers and prospect users included,
> >> if the composefs requirements would drive improvement to existing
> >> kernel subsystems rather than adding a custom filesystem driver
> >> that partly duplicates other subsystems.
> >> 
> >> Especially so, when the modifications to existing components
> >> (erofs and overlayfs) appear to be relatively minor and the maintainer
> >> of erofs is receptive to new features and happy to collaborate with you.
> >> 
> >> w.r.t overlayfs, I am not even sure that anything needs to be modified
> >> in the driver.
> >> overlayfs already supports "metacopy" feature which means that an upper layer
> >> could be composed in a way that the file content would be read from an arbitrary
> >> path in lower fs, e.g. objects/cc/XXX.
> >> 
> >> I gave a talk on LPC a few years back about overlayfs and container images [2].
> >> The emphasis was that overlayfs driver supports many new features, but userland
> >> tools for building advanced overlayfs images based on those new features are
> >> nowhere to be found.
> >> 
> >> I may be wrong, but it looks to me like composefs could potentially
> >> fill this void,
> >> without having to modify the overlayfs driver at all, or maybe just a
> >> little bit.
> >> Please start a discussion with overlayfs developers about missing driver
> >> features if you have any.
> >
> > Surprising that I and others weren't Cced on this given that we had a
> > meeting with the main developers and a few others where we had said the
> > same thing. I hadn't followed this. 
> 
> well that wasn't done on purpose, sorry for that.

I understand. I was just surprised given that I very much work on the
vfs on a day to day basis.

> 
> After our meeting, I thought it was clear that we have different needs
> for our use cases and that we were going to submit composefs upstream,
> as we did, to gather some feedbacks from the wider community.
> 
> Of course we looked at overlay before we decided to upstream composefs.
> 
> Some of the use cases we have in mind are not easily doable, some others
> are not possible at all.  metacopy is a good starting point, but from
> user space it works quite differently than what we can do with
> composefs.
> 
> Let's assume we have a git like repository with a bunch of files stored
> by their checksum and that they can be shared among different containers.
> 
> Using the overlayfs model:
> 
> 1) We need to create the final image layout, either using reflinks or
> hardlinks:
> 
> - reflinks: we can reflect a correct st_nlink value for the inode but we
>   lose page cache sharing.
> 
> - hardlinks: make the st_nlink bogus.  Another problem is that overlay
>   expects the lower layer to never change and now st_nlink can change
>   for files in other lower layers.
> 
> These operations have a cost.  Even if we all the files are already
> available locally, we still need at least one operation per file to
> create it, and more than one if we start tweaking the inode metadata.

Which you now encode in a manifest file which changes properties on a
per file basis without any vfs involvement which makes me pretty uneasy.

If you combine overlayfs with idmapped mounts you can already change
ownership on a fairly granular basis.

If you need additional per file ownership use overlayfs which gives you
the ability to change file attributes on a per file per container basis.

> 
> 2) no multi repo support:
> 
> Both reflinks and hardlinks do not work across mount points, so we

Just fwiw, afaict reflinks work across mount points since at least 5.18.

> cannot have images that span multiple file systems; one common use case
> is to have a network file system to share some images/files and be able
> to use files from there when they are available.
> 
> At the moment we deduplicate entire layers, and with overlay we can do
> something like the following without problems:
> 
> # mount overlay -t overlay -olowerdir=/first/disk/layer1:/second/disk/layer2
> 
> but this won't work with the files granularity we are looking at.  So in
> this case we need to do a full copy of the files that are not on the
> same file system.
> 
> 3) no support for fs-verity.  No idea how overlay could ever support it,
> it doesn't fit there.  If we want this feature we need to look at
> another RO file system.
> 
> We looked at EROFS since it is already upstream but it is quite
> different than what we are doing as Alex already pointed out.
> 
> Sure we could bloat EROFS and add all the new features there, after all
> composefs is quite simple, but I don't see how this is any cleaner than
> having a simple file system that does just one thing.
> 
> On top of what was already said: I wish at some point we can do all of
> this from a user namespace.  That is the main reason for having an easy
> on-disk format for composefs.  This seems much more difficult to achieve

I'm pretty skeptical of this plan whether we should add more filesystems
that are mountable by unprivileged users. FUSE and Overlayfs are
adventurous enough and they don't have their own on-disk format. The
track record of bugs exploitable due to userns isn't making this
very attractive.
