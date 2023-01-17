Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6682666DFC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 15:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjAQOAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 09:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjAQN6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:58:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D93BDAA
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673963821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVBr2Cidkx4v0I4jPYPiOoWQJw+d7RIYVwcketrmLM0=;
        b=VDTk3N3noLPDy2Pbhe+O8lnvdv7rjNgJR8VPEuJuwarx2qiN7MPeBMxLWyAonb+xzQH86u
        KPhvoimajFgkLAm1AOfde9KozmzBjHkv4QTnb8IUhsBV/ar6sX4HjBMJeeUQzxJX2RpI5w
        YcGvcxuI9u2UC/n8P39mck9p9nWTULw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-bswSNEOYNl27J6hAAov-_Q-1; Tue, 17 Jan 2023 08:57:00 -0500
X-MC-Unique: bswSNEOYNl27J6hAAov-_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79D6418A0702;
        Tue, 17 Jan 2023 13:56:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3AC67AE5;
        Tue, 17 Jan 2023 13:56:58 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
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
References: <cover.1673623253.git.alexl@redhat.com>
        <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
        <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
        <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
        <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
        <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
        <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
        <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
        <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
        <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
Date:   Tue, 17 Jan 2023 14:56:56 +0100
In-Reply-To: <20230117101202.4v4zxuj2tbljogbx@wittgenstein> (Christian
        Brauner's message of "Tue, 17 Jan 2023 11:12:02 +0100")
Message-ID: <87fsc9gt7b.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Jan 17, 2023 at 09:05:53AM +0200, Amir Goldstein wrote:
>> > It seems rather another an incomplete EROFS from several points
>> > of view.  Also see:
>> > https://lore.kernel.org/all/1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com/T/#u
>> >
>> 
>> Ironically, ZUFS is one of two new filesystems that were discussed in LSFMM19,
>> where the community reactions rhyme with the reactions to composefs.
>> The discussion on Incremental FS resembles composefs case even more [1].
>> AFAIK, Android is still maintaining Incremental FS out-of-tree.
>> 
>> Alexander and Giuseppe,
>> 
>> I'd like to join Gao is saying that I think it is in the best interest
>> of everyone,
>> composefs developers and prospect users included,
>> if the composefs requirements would drive improvement to existing
>> kernel subsystems rather than adding a custom filesystem driver
>> that partly duplicates other subsystems.
>> 
>> Especially so, when the modifications to existing components
>> (erofs and overlayfs) appear to be relatively minor and the maintainer
>> of erofs is receptive to new features and happy to collaborate with you.
>> 
>> w.r.t overlayfs, I am not even sure that anything needs to be modified
>> in the driver.
>> overlayfs already supports "metacopy" feature which means that an upper layer
>> could be composed in a way that the file content would be read from an arbitrary
>> path in lower fs, e.g. objects/cc/XXX.
>> 
>> I gave a talk on LPC a few years back about overlayfs and container images [2].
>> The emphasis was that overlayfs driver supports many new features, but userland
>> tools for building advanced overlayfs images based on those new features are
>> nowhere to be found.
>> 
>> I may be wrong, but it looks to me like composefs could potentially
>> fill this void,
>> without having to modify the overlayfs driver at all, or maybe just a
>> little bit.
>> Please start a discussion with overlayfs developers about missing driver
>> features if you have any.
>
> Surprising that I and others weren't Cced on this given that we had a
> meeting with the main developers and a few others where we had said the
> same thing. I hadn't followed this. 

well that wasn't done on purpose, sorry for that.

After our meeting, I thought it was clear that we have different needs
for our use cases and that we were going to submit composefs upstream,
as we did, to gather some feedbacks from the wider community.

Of course we looked at overlay before we decided to upstream composefs.

Some of the use cases we have in mind are not easily doable, some others
are not possible at all.  metacopy is a good starting point, but from
user space it works quite differently than what we can do with
composefs.

Let's assume we have a git like repository with a bunch of files stored
by their checksum and that they can be shared among different containers.

Using the overlayfs model:

1) We need to create the final image layout, either using reflinks or
hardlinks:

- reflinks: we can reflect a correct st_nlink value for the inode but we
  lose page cache sharing.

- hardlinks: make the st_nlink bogus.  Another problem is that overlay
  expects the lower layer to never change and now st_nlink can change
  for files in other lower layers.

These operations have a cost.  Even if we all the files are already
available locally, we still need at least one operation per file to
create it, and more than one if we start tweaking the inode metadata.

2) no multi repo support:

Both reflinks and hardlinks do not work across mount points, so we
cannot have images that span multiple file systems; one common use case
is to have a network file system to share some images/files and be able
to use files from there when they are available.

At the moment we deduplicate entire layers, and with overlay we can do
something like the following without problems:

# mount overlay -t overlay -olowerdir=/first/disk/layer1:/second/disk/layer2

but this won't work with the files granularity we are looking at.  So in
this case we need to do a full copy of the files that are not on the
same file system.

3) no support for fs-verity.  No idea how overlay could ever support it,
it doesn't fit there.  If we want this feature we need to look at
another RO file system.

We looked at EROFS since it is already upstream but it is quite
different than what we are doing as Alex already pointed out.

Sure we could bloat EROFS and add all the new features there, after all
composefs is quite simple, but I don't see how this is any cleaner than
having a simple file system that does just one thing.

On top of what was already said: I wish at some point we can do all of
this from a user namespace.  That is the main reason for having an easy
on-disk format for composefs.  This seems much more difficult to achieve
with EROFS given its complexity.

> We have at least 58 filesystems currently in the kernel (and that's a
> conservative count just based on going by obvious directories and
> ignoring most virtual filesystems).
>
> A non-insignificant portion is probably slowly rotting away with little
> fixes coming in, with few users, and not much attention is being paid to
> syzkaller reports for them if they show up. I haven't quantified this of
> course.
>
> Taking in a new filesystems into kernel in the worst case means that
> it's being dumped there once and will slowly become unmaintained. Then
> we'll have a few users for the next 20 years and we can't reasonably
> deprecate it (Maybe that's another good topic: How should we fade out
> filesystems.).
>
> Of course, for most fs developers it probably doesn't matter how many
> other filesystems there are in the kernel (aside from maybe competing
> for the same users).
>
> But for developers who touch the vfs every new filesystems may increase
> the cost of maintaining and reworking existing functionality, or adding
> new functionality. Making it more likely to accumulate hacks, adding
> workarounds, or flatout being unable to kill off infrastructure that
> should reasonably go away. Maybe this is an unfair complaint but just
> from experience a new filesystem potentially means one or two weeks to
> make a larger vfs change.
>
> I want to stress that I'm not at all saying "no more new fs" but we
> should be hesitant before we merge new filesystems into the kernel.
>
> Especially for filesystems that are tailored to special use-cases.
> Every few years another filesystem tailored to container use-cases shows
> up. And frankly, a good portion of the issues that they are trying to
> solve are caused by design choices in userspace.

Having a way to deprecate file systems seem like a good idea in general,
and IMHO seems to make more sense than blocking new components that
can be useful to some users.

We are aware the bar for a new file system is high, and we were
expecting criticism and push back, but so far it doesn't seem there is a
way to achieve what we are trying to do.

> And I have to say I'm especially NAK-friendly about anything that comes
> even close to yet another stacking filesystems or anything that layers
> on top of a lower filesystem/mount such as ecryptfs, ksmbd, and
> overlayfs. They are hard to get right, with lots of corner cases and
> they cause the most headaches when making vfs changes.

