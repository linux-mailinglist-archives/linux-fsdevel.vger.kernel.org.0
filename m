Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5101778E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgCCOaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgCCOaB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:30:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43EDD20838;
        Tue,  3 Mar 2020 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583245800;
        bh=TcPA+2mgGtrFwfhcuBqjUOhNVvQpXnWRqswktmXfAMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duZsmPCxeAc5VhRa0Yt6P9WfVSUnLBKf/3B/UANogYCOeSUPd8Uo99JWWas4fX3Ct
         bFsA4K6GVvXuLmrLjvy/eSQZxixIY1E4SvnF9XQPei/asikOPZlIcrsGdX84Zs3Sgq
         S5fk2IOfMPJ+86ehQE8QG+laU36tf2Ln3yx1WP54=
Date:   Tue, 3 Mar 2020 15:29:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303142958.GB47158@kroah.com>
References: <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com>
 <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:10:50PM +0100, Miklos Szeredi wrote:
> On Tue, Mar 3, 2020 at 2:43 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> 
> > > If buffer is too small to fit the whole file, return error.
> >
> > Why?  What's wrong with just returning the bytes asked for?  If someone
> > only wants 5 bytes from the front of a file, it should be fine to give
> > that to them, right?
> 
> I think we need to signal in some way to the caller that the result
> was truncated (see readlink(2), getxattr(2), getcwd(2)), otherwise the
> caller might be surprised.

But that's not the way a "normal" read works.  Short reads are fine, if
the file isn't big enough.  That's how char device nodes work all the
time as well, and this kind of is like that, or some kind of "stream" to
read from.

If you think the file is bigger, then you, as the caller, can just pass
in a bigger buffer if you want to (i.e. you can stat the thing and
determine the size beforehand.)

Think of the "normal" use case here, a sysfs read with a PAGE_SIZE
buffer.  That way userspace "knows" it will always read all of the data
it can from the file, we don't have to do any seeking or determining
real file size, or anything else like that.

We return the number of bytes read as well, so we "know" if we did a
short read, and also, you could imply, if the number of bytes read are
the exact same as the number of bytes of the buffer, maybe the file is
either that exact size, or bigger.

This should be "simple", let's not make it complex if we can help it :)

> > > Verify that the number of bytes read matches the file size, otherwise
> > > return error (may need to loop?).
> >
> > No, we can't "match file size" as sysfs files do not really have a sane
> > "size".  So I don't want to loop at all here, one-shot, that's all you
> > get :)
> 
> Hmm.  I understand the no-size thing.  But looping until EOF (i.e.
> until read return zero) might be a good idea regardless, because short
> reads are allowed.

If you want to loop, then do a userspace open/read-loop/close cycle.
That's not what this syscall should be for.

Should we call it: readfile-only-one-try-i-hope-my-buffer-is-big-enough()?  :)

thanks,

greg k-h
