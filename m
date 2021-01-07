Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD62ED11C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 14:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbhAGNq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 08:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728088AbhAGNq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610027101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D52G95pEfQcjTOfA+HqwOJkz9BoqmXBTifvDL2eir00=;
        b=Pea4XcftPTEw5QKbwOn7qon1UXmXi00NTaMC6mLlvUQQUlVAo4Ia2w6/Ra2cNFqptoCDGe
        N9Ioq40JjNnrobyrWngWxDynBUoqzSWyiBkc6dtN6zBJ/d+cXkJn0fkUAAzPUVDWdBpzi+
        scb2O4aS6VI9zQxglgULd5X5UP0Bcas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-FRzcgvvdNr6IJbE3MgO-4Q-1; Thu, 07 Jan 2021 08:44:59 -0500
X-MC-Unique: FRzcgvvdNr6IJbE3MgO-4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DE14107ACFA;
        Thu,  7 Jan 2021 13:44:57 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-86.rdu2.redhat.com [10.10.116.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABD0E60C0F;
        Thu,  7 Jan 2021 13:44:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3DD0822054F; Thu,  7 Jan 2021 08:44:56 -0500 (EST)
Date:   Thu, 7 Jan 2021 08:44:56 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@suse.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20210107134456.GA3439@redhat.com>
References: <20210106083546.4392-1-sargun@sargun.me>
 <20210106194658.GA3290@redhat.com>
 <CAOQ4uxgR_gybovg6t4+=MbeMXS6jm5ov1ULDGZgzg7yCxETsDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgR_gybovg6t4+=MbeMXS6jm5ov1ULDGZgzg7yCxETsDw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:02:00AM +0200, Amir Goldstein wrote:
> On Wed, Jan 6, 2021 at 9:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jan 06, 2021 at 12:35:46AM -0800, Sargun Dhillon wrote:
> > > Overlayfs's volatile option allows the user to bypass all forced sync calls
> > > to the upperdir filesystem. This comes at the cost of safety. We can never
> > > ensure that the user's data is intact, but we can make a best effort to
> > > expose whether or not the data is likely to be in a bad state.
> > >
> > > The best way to handle this in the time being is that if an overlayfs's
> > > upperdir experiences an error after a volatile mount occurs, that error
> > > will be returned on fsync, fdatasync, sync, and syncfs. This is
> > > contradictory to the traditional behaviour of VFS which fails the call
> > > once, and only raises an error if a subsequent fsync error has occurred,
> > > and been raised by the filesystem.
> > >
> > > One awkward aspect of the patch is that we have to manually set the
> > > superblock's errseq_t after the sync_fs callback as opposed to just
> > > returning an error from syncfs. This is because the call chain looks
> > > something like this:
> > >
> > > sys_syncfs ->
> > >       sync_filesystem ->
> > >               __sync_filesystem ->
> > >                       /* The return value is ignored here
> > >                       sb->s_op->sync_fs(sb)
> > >                       _sync_blockdev
> > >               /* Where the VFS fetches the error to raise to userspace */
> > >               errseq_check_and_advance
> > >
> > > Because of this we call errseq_set every time the sync_fs callback occurs.
> >
> > Why not start capturing return code of ->sync_fs and then return error
> > from ovl->sync_fs. And then you don't have to do errseq_set(ovl_sb).
> >
> > I already posted a patch to capture retrun code from ->sync_fs.
> >
> > https://lore.kernel.org/linux-fsdevel/20201221195055.35295-2-vgoyal@redhat.com/
> >
> >
> 
> Vivek,
> 
> IMO the more important question is "Why not?".
> 
> Your patches will undoubtedly get to mainline in the near future and they do
> make the errseq_set(ovl_sb) in this patch a bit redundant,

I thought my patch of capturing ->sync_fs is really simple (just few
lines), so backportability should not be an issue. That's why I
asked for it. 

> but I really see no
> harm in it. It is very simple for you to remove this line in your patch.
> I do see the big benefit of an independent patch that is easy to apply to fix
> a fresh v5.10 feature.
> 
> I think it is easy for people to dismiss the importance of "syncfs on volatile"
> which sounds like a contradiction, but it is not.
> The fact that the current behavior is documented doesn't make it right either.
> It just makes our review wrong.
> The durability guarantee (that volatile does not provide) is very different
> from the "reliability" guarantee that it CAN provide.
> We do not want to have to explain to people that "volatile" provided different
> guarantees depending on the kernel they are running.
> Fixing syncfs/fsync of volatile is much more important IMO than erroring
> on other fs ops post writeback error, because other fs ops are equally
> unreliable on any filesystem in case application did not do fsync.
> 
> Ignoring the factor of "backporting cost" when there is no engineering
> justification to do so is just ignoring the pain of others.
> Do you have an engineering argument for objecting this patch is
> applied before your fixes to syncfs vfs API?

Carrying ->sync_fs return code patch is definitely not a blocker. It
is just nice to have. Anyway, I you don't want to carry that ->sync_fs
return patch in stable, I am fine with this patch. I will follow up
on that fix separately.

Vivek

> 
> Sargun,
> 
> Please add Fixes/Stable #v5.10 tags.
> 
> Thanks,
> Amir.
> 

