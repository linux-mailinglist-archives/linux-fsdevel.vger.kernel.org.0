Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15A466BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 23:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349201AbhLBWDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 17:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242771AbhLBWDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638482411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2/cmwaY9f0QivmoRz+sPsa8YR0c9lqKjOdege3PjTY=;
        b=UQUw8mguH6nwkxAtcx3mqbCwyZDi+Ogwh0W0Skg0Yx7mLLYH8Ol/nu9bV81EHF+Gb+oOzy
        nH6IymBoA9prS5xFr8c+L5ksL1phrkbXhC+oNBMVnQeLokucu9AEeHgtGiuFL3tjc17caN
        TA9Sch4xbIP+x0LK0LihtlUwFhWiaRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-YuyD8_emOKSWGR0r1mHmUQ-1; Thu, 02 Dec 2021 17:00:08 -0500
X-MC-Unique: YuyD8_emOKSWGR0r1mHmUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A6410168C4;
        Thu,  2 Dec 2021 22:00:06 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 966FC5FC22;
        Thu,  2 Dec 2021 22:00:05 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EC2E82233DF; Thu,  2 Dec 2021 17:00:04 -0500 (EST)
Date:   Thu, 2 Dec 2021 17:00:04 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>
Subject: Re: ovl_flush() behavior
Message-ID: <YalB5Fyoc/3mg5MY@redhat.com>
References: <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz>
 <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
 <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
 <17d78e95c35.ceeffaaf22655.2727336036618811041@mykernel.net>
 <YajkQUpxWQI1N64l@redhat.com>
 <CAOQ4uxj4Gh=hjoXgq-=c+JStKnK=iY4R+CZqEfb8eBd95218Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj4Gh=hjoXgq-=c+JStKnK=iY4R+CZqEfb8eBd95218Mg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 05:59:56PM +0200, Amir Goldstein wrote:
> On Thu, Dec 2, 2021 at 5:20 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, Dec 02, 2021 at 10:11:39AM +0800, Chengguang Xu wrote:
> > >
> > >  ---- 在 星期四, 2021-12-02 07:23:17 Amir Goldstein <amir73il@gmail.com> 撰写 ----
> > >  > > >
> > >  > > > To be honest I even don't fully understand what's the ->flush() logic in overlayfs.
> > >  > > > Why should we open new underlying file when calling ->flush()?
> > >  > > > Is it still correct in the case of opening lower layer first then copy-uped case?
> > >  > > >
> > >  > >
> > >  > > The semantics of flush() are far from being uniform across filesystems.
> > >  > > most local filesystems do nothing on close.
> > >  > > most network fs only flush dirty data when a writer closes a file
> > >  > > but not when a reader closes a file.
> > >  > > It is hard to imagine that applications rely on flush-on-close of
> > >  > > rdonly fd behavior and I agree that flushing only if original fd was upper
> > >  > > makes more sense, so I am not sure if it is really essential for
> > >  > > overlayfs to open an upper rdonly fd just to do whatever the upper fs
> > >  > > would have done on close of rdonly fd, but maybe there is no good
> > >  > > reason to change this behavior either.
> > >  > >
> > >  >
> > >  > On second thought, I think there may be a good reason to change
> > >  > ovl_flush() otherwise I wouldn't have submitted commit
> > >  > a390ccb316be ("fuse: add FOPEN_NOFLUSH") - I did observe
> > >  > applications that frequently open short lived rdonly fds and suffered
> > >  > undesired latencies on close().
> > >  >
> > >  > As for "changing existing behavior", I think that most fs used as
> > >  > upper do not implement flush at all.
> > >  > Using fuse/virtiofs as overlayfs upper is quite new, so maybe that
> > >  > is not a problem and maybe the new behavior would be preferred
> > >  > for those users?
> > >  >
> > >
> > > So is that mean simply redirect the ->flush request to original underlying realfile?
> >
> > If the file has been copied up since open(), then flush should go on upper
> > file, right?
> >
> > I think Amir is talking about that can we optimize flush in overlay and
> > not call ->flush at all if file was opened read-only, IIUC.
> >
> 
> Maybe that's what I wrote, but what I meant was if file was open as
> lower read-only and later copied up, not sure we should bother with
> ovl_open_realfile() for flushing upper.

I am not sure either. Miklos might have thoughts on this.

> 
> > In case of fuse he left it to server. If that's the case, then in case
> > of overlayfs, it should be left to underlyng filesystem as well?
> > Otherwise, it might happen underlying filesystem (like virtiofs) might
> > be expecting ->flush() and overlayfs decided not to call it because
> > file was read only.
> >
> 
> Certainly, if upper wants flush on rdonly file we must call flush on
> close of rdonly file *that was opened on upper*.
> 
> But if we opened rdonly file on lower, even if lower is virtiofs, does
> virtiosfd needs this flush?

Right now virtiofsd seems to care about flush for read only files for
remote posix locks.  Given overlayfs is not registering f_op->lock() handler,
my understaning is that all locking will be done by VFS on overlayfs inode
and it will never reach to the level of virtiofs (lower or upper). If that's
the case, then atleast from locking perspective we don't need flush on
lower for virtiofs.

> that same file on the server was not supposed
> to be written by anyone.
> If virtiofsd really needs this flush then it is a problem already today,
> because if lower file was copied up since open rdonly, virtiofsd
> is not going to get the flushes for the lower file (only the release).

So virtiofs will not get flushes on lower only if file got copied-up
after opening on lower, right? So far nobody has complained. But if
there is a use case somewhere, we might have to issue a flush on lower
as well.

> 
> However, I now realize that if we opened file rdonly on lower,
> we may have later opened a short lived realfile on upper for read post
> copy up and we never issued a flush for this short live rdonly upper fd.
> So actually, unless we store a flag or something that says that
> we never opened upper realfile, we should keep current behavior.

I am assuming you are referring to ovl_read_iter() where it will open
upper file for read and then call fdput(real). So why should we issue
flush on upper in this case?

I thought flush will need to be issued only when overlay "fd" as seen
by user space is closed (and not when inernal fds opened by overlay are
closed).

So real question is, do we need to issue flush when fd is opened read
only. If yes, then we probably need to issue flush both on lower and
upper (and not only on upper). But if flush is to be issued only for
the case of fd which was writable, then issuing it on upper makes
sense.

> 
> > So I will lean towards continue to call ->flush in overlay and try to
> > optimize virtiofsd to set FOPEN_NOFLUSH when not required.
> >
> 
> Makes sense.
> Calling flush() on fs that does nothing with it doesn't hurt.

This probably is safest right now given virtiofs expects flush to be
issued even for read only fd (in case of remote posix locks). Though
that's a different thing that when overlayfs is sitting on top, we
will not be using remote posix lock functionality of virtiofs, IIUC.

Vivek

