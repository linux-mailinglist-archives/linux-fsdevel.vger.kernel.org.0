Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC35F2ED31E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 16:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbhAGO7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 09:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbhAGO7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610031462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5VRFgXzQJ18TxiRsL/3LBkOTLH+uHfHXz0nxqBUw4U=;
        b=druhUg+EXx6iDsgWfv+8meVO0OFDm3JfvbAxsFJkgjtVCzzIabA2Pmu3jWyVzzz0YqPwa4
        VyHdWrh94GbRrn6d7WrfDTntxe8dWUWDGA5XER0c+ZH0Gh3Hqs2Z3vl1AsHgx1qcrpKyQV
        qUKAi1U2v4qe327RnpCEE066sG9bYWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-GuJ3wKGCNKGzqBwf6HLFhQ-1; Thu, 07 Jan 2021 09:57:41 -0500
X-MC-Unique: GuJ3wKGCNKGzqBwf6HLFhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77CD3801A9E;
        Thu,  7 Jan 2021 14:57:39 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-86.rdu2.redhat.com [10.10.116.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03366062F;
        Thu,  7 Jan 2021 14:57:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 57D6122054F; Thu,  7 Jan 2021 09:57:38 -0500 (EST)
Date:   Thu, 7 Jan 2021 09:57:38 -0500
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
Message-ID: <20210107145738.GB3439@redhat.com>
References: <20210106083546.4392-1-sargun@sargun.me>
 <20210106194658.GA3290@redhat.com>
 <CAOQ4uxgR_gybovg6t4+=MbeMXS6jm5ov1ULDGZgzg7yCxETsDw@mail.gmail.com>
 <20210107134456.GA3439@redhat.com>
 <CAOQ4uxjdPkO1OEOFBdgS1ps0GzBrN1jCF5zFkAoLeCJEtkALwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjdPkO1OEOFBdgS1ps0GzBrN1jCF5zFkAoLeCJEtkALwg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 04:44:19PM +0200, Amir Goldstein wrote:
> On Thu, Jan 7, 2021 at 3:45 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, Jan 07, 2021 at 09:02:00AM +0200, Amir Goldstein wrote:
> > > On Wed, Jan 6, 2021 at 9:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Wed, Jan 06, 2021 at 12:35:46AM -0800, Sargun Dhillon wrote:
> > > > > Overlayfs's volatile option allows the user to bypass all forced sync calls
> > > > > to the upperdir filesystem. This comes at the cost of safety. We can never
> > > > > ensure that the user's data is intact, but we can make a best effort to
> > > > > expose whether or not the data is likely to be in a bad state.
> > > > >
> > > > > The best way to handle this in the time being is that if an overlayfs's
> > > > > upperdir experiences an error after a volatile mount occurs, that error
> > > > > will be returned on fsync, fdatasync, sync, and syncfs. This is
> > > > > contradictory to the traditional behaviour of VFS which fails the call
> > > > > once, and only raises an error if a subsequent fsync error has occurred,
> > > > > and been raised by the filesystem.
> > > > >
> > > > > One awkward aspect of the patch is that we have to manually set the
> > > > > superblock's errseq_t after the sync_fs callback as opposed to just
> > > > > returning an error from syncfs. This is because the call chain looks
> > > > > something like this:
> > > > >
> > > > > sys_syncfs ->
> > > > >       sync_filesystem ->
> > > > >               __sync_filesystem ->
> > > > >                       /* The return value is ignored here
> > > > >                       sb->s_op->sync_fs(sb)
> > > > >                       _sync_blockdev
> > > > >               /* Where the VFS fetches the error to raise to userspace */
> > > > >               errseq_check_and_advance
> > > > >
> > > > > Because of this we call errseq_set every time the sync_fs callback occurs.
> > > >
> > > > Why not start capturing return code of ->sync_fs and then return error
> > > > from ovl->sync_fs. And then you don't have to do errseq_set(ovl_sb).
> > > >
> > > > I already posted a patch to capture retrun code from ->sync_fs.
> > > >
> > > > https://lore.kernel.org/linux-fsdevel/20201221195055.35295-2-vgoyal@redhat.com/
> > > >
> > > >
> > >
> > > Vivek,
> > >
> > > IMO the more important question is "Why not?".
> > >
> > > Your patches will undoubtedly get to mainline in the near future and they do
> > > make the errseq_set(ovl_sb) in this patch a bit redundant,
> >
> > I thought my patch of capturing ->sync_fs is really simple (just few
> > lines), so backportability should not be an issue. That's why I
> > asked for it.
> >
> 
> Apologies. I thought you meant your entire patch set.
> I do agree to that. In fact, I think I suggested it myself at one
> point or another.
> 
> > > but I really see no
> > > harm in it. It is very simple for you to remove this line in your patch.
> > > I do see the big benefit of an independent patch that is easy to apply to fix
> > > a fresh v5.10 feature.
> > >
> > > I think it is easy for people to dismiss the importance of "syncfs on volatile"
> > > which sounds like a contradiction, but it is not.
> > > The fact that the current behavior is documented doesn't make it right either.
> > > It just makes our review wrong.
> > > The durability guarantee (that volatile does not provide) is very different
> > > from the "reliability" guarantee that it CAN provide.
> > > We do not want to have to explain to people that "volatile" provided different
> > > guarantees depending on the kernel they are running.
> > > Fixing syncfs/fsync of volatile is much more important IMO than erroring
> > > on other fs ops post writeback error, because other fs ops are equally
> > > unreliable on any filesystem in case application did not do fsync.
> > >
> > > Ignoring the factor of "backporting cost" when there is no engineering
> > > justification to do so is just ignoring the pain of others.
> > > Do you have an engineering argument for objecting this patch is
> > > applied before your fixes to syncfs vfs API?
> >
> > Carrying ->sync_fs return code patch is definitely not a blocker. It
> > is just nice to have. Anyway, I you don't want to carry that ->sync_fs
> > return patch in stable, I am fine with this patch. I will follow up
> > on that fix separately.
> >
> 
> Please collaborate with Sargun.
> I think it is best if one of you will post those two patches in the same
> series. I think you had a few minor comments to address, so many
> send the final patch version to Sargun to he can test the two patches
> together and post them?

Hi Amir,

I was thinking more about that patch. That patch will start returning
error on syncfs() in cases where it did not return errors in the past and 
somebody might complain. So it probably is safer to carry that patch
in mainline first and once it gets good testing, push it to stable later.

So for now, I am fine with this patch as it is. Will follow on ->sync_fs
error capture patch separately. And once that is upstream, I can post
another overlay patch to remove errseq_set().

> 
> Sorry for the confusion.
> Too many "the syncfs patch" to juggle.

No worries. I agree, too many mail threads on this topic.

Thanks
Vivek

