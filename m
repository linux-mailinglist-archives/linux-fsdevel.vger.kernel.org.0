Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8551C14F33A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 21:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgAaUdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 15:33:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39938 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgAaUdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:33:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so3360920pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 12:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YOlDQusEZRYYJZagYlnPmgqjsuja9P5+CW/pcDOnaiE=;
        b=auurNIhIFt4MqptxOyvEWAcPwqB0CvcWo/4HP/aAfkUNfRYFvWUFFhS866YBSUqdHe
         gtmK/XKLNn70SVZRvOXkD3c1nenhwL7SW+/AIFK28ewKteYrGnIaOpu5KHy6AQAZM9ux
         stj78mYNvhPwuVPnjAiZAax5Rular7XkhsUDabNbS6AAmhndzCS+OI7OHyWEGVF7jlzF
         E0Ux5qUZHQMkanpJN/oEWPNypVpmdIqhZ+xut3lbjEkQ2xd/xKlrh2TN0lfH9Wdfg5Sq
         eGPKd1hxSQZly9ogFv9Uoj66+3N/W4wSRM327yh3ciXVX65XVm5su862pXUpCLdOfUO+
         TGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YOlDQusEZRYYJZagYlnPmgqjsuja9P5+CW/pcDOnaiE=;
        b=MMn+exm7lIfI5LshQwlNyKN4nNrDuP5c+RvZzly1k/oZ544gIkQPiI8YWzN/Nc9+zy
         ovR/LmHkY0RpWvtKqVDRmWdBVybrvoj/5Yl6qvTiGcOjwVAKLf1b993qwu3hRXvzfkw2
         oyu1++udifTdd0dDhTu6HaYfQBFfk/0KL2yoE+HVVRDQUbBXsAVb9wXN5Uyl4qS/b0af
         8tUl8uzUrd2afKoMd4RQAQv9zZTwsbLYYXZ/q5G+wSkwrhnPx6+yUtrqjQoUDqFF8gb3
         jUyUB+4HRzgU/QF/BplFRm52CDbA6vnGm4msk/5Z9+Yvz5O0B+ccz25qXVmWu4N/ScpE
         smsA==
X-Gm-Message-State: APjAAAVkoyBevLfQUhBRwSfFOEKzJ7bNopyTuRSQ5OpIOtEMcGcNo6tw
        Zu/rO3HmIJpqv0RehyQU+D4pSt4L6wo=
X-Google-Smtp-Source: APXvYqz7AKkTmrpOzLJ3V980r/Rt72TdztRxkecXaNX687RWcc2SGdsCL80GzkhMERnMtGuDFOkYzQ==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr12120175plo.282.1580502825631;
        Fri, 31 Jan 2020 12:33:45 -0800 (PST)
Received: from vader ([2620:10d:c090:200::2d88])
        by smtp.gmail.com with ESMTPSA id o6sm10692142pgg.37.2020.01.31.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:33:45 -0800 (PST)
Date:   Fri, 31 Jan 2020 12:33:44 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200131203344.GB787405@vader>
References: <20200118022032.GR8904@ZenIV.linux.org.uk>
 <20200121230521.GA394361@vader>
 <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader>
 <20200123034745.GI23230@ZenIV.linux.org.uk>
 <20200123071639.GA7216@dread.disaster.area>
 <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com>
 <20200124212546.GC7216@dread.disaster.area>
 <20200131052454.GA6868@magnolia>
 <CAOQ4uxj5ZWLALArKLE3eJLK_QmLdFpHNgP_etRpbK-Tn8-O+AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj5ZWLALArKLE3eJLK_QmLdFpHNgP_etRpbK-Tn8-O+AQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:00:47AM +0200, Amir Goldstein wrote:
> On Fri, Jan 31, 2020 at 7:27 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Sat, Jan 25, 2020 at 08:25:46AM +1100, Dave Chinner wrote:
> > > On Thu, Jan 23, 2020 at 09:47:30AM +0200, Amir Goldstein wrote:
> > > > On Thu, Jan 23, 2020 at 9:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> > > > > > On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> > > > > >
> > > > > > > > Sorry for not reading all the thread again, some API questions:
> > > > > > > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > > > > > >
> > > > > > > I wasn't planning on having that restriction. It's not too much effort
> > > > > > > for filesystems to support it for normal files, so I wouldn't want to
> > > > > > > place an artificial restriction on a useful primitive.
> > > > > >
> > > >
> > > > I have too many gray hairs each one for implementing a "useful primitive"
> > > > that nobody asked for and bare the consequences.
> > > > Your introduction to AT_REPLACE uses O_TMPFILE.
> > > > I see no other sane use of the interface.
> > > >
> > > > > > I'm not sure; that's how we ended up with the unspeakable APIs like
> > > > > > rename(2), after all...
> > > > >
> > > > > Yet it is just rename(2) with the serial numbers filed off -
> > > > > complete with all the same data vs metadata ordering problems that
> > > > > rename(2) comes along with. i.e. it needs fsync to guarantee data
> > > > > integrity of the source file before the linkat() call is made.
> > > > >
> > > > > If we can forsee that users are going to complain that
> > > > > linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> > > > > leaves zero length files behind after a crash just like rename()
> > > > > does, then we haven't really improved anything at all...
> > > > >
> > > > > And, really, I don't think anyone wants another API that requires
> > > > > multiple fsync calls to use correctly for crash-safe file
> > > > > replacement, let alone try to teach people who still cant rename a
> > > > > file safely how to use it....
> > > > >
> > > >
> > > > Are you suggesting that AT_LINK_REPLACE should have some of
> > > > the semantics I posted in this RFC  for AT_ATOMIC_xxx:
> > > > https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/
> > >
> > > Not directly.
> > >
> > > All I'm pointing out is that data integrity guarantees of
> > > AT_LINK_REPLACE are yet another aspect of this new feature that
> > > has not yet been specified or documented at all.
> > >
> > > And in pointing this out, I'm making an observation that the
> > > rename(2) behaviour which everyone seems to be assuming this
> > > function will replicate is a terrible model to copy/reinvent.
> > >
> > > Addressing this problem is something for the people pushing for
> > > AT_LINK_REPLACE to solve, not me....
> >
> > Or the grumpy maintainer who will have to digest all of this.
> >
> > Can we update the documentation to admit that many people will probably
> > want to use this (and rename) as atomic swap operations?
> >
> > "The filesystem will commit the data and metadata of all files and
> > directories involved in the link operation to stable storage before the
> > call returns."
> >
> > And finally add a flag:
> >
> > "AT_LINK_EATMYDATA: If specified, the filesystem may opt out of
> > committing anything to disk."
> >
> 
> I agree with Christoph that this anomaly is not a good idea, but I also
> agree with you and Dave that if an operation is meant to be used for
> atomic swap, we should make it much harder for users to get it wrong.
> 
> To that end, we can define both flags AT_LINK_REPLACE and
> AT_ATOMIC in uapi, but also define the combo
> AT_LINK_ATOMIC_REPLACE and let the documentation be
> very much focused on this usage.
> 
> I would like to stress a point, which some who haven't followed [1]
> closely might have missed - the purpose of AT_ATOMIC is
> *not* to make the new link durable - it is *not* a replacement for fsync
> on parent dir. It's purpose is *only* to create a dependency between the
> durability of the new link and the new data it can expose.

At the risk of spawning another bikeshed subthread, the naming could be
improved to make that more clear. AT_BARRIER? AT_DEPENDENCY?

> AFAICT, this means that AT_ATOMIC would be implemented
> as filemap_write_and_wait() in xfs/ext4 and probably fdatasync in btrfs.
> 
> Really, there is no chance that any user is interested in a non-atomic
> replace in that respect, so I am not even sure that we need an explicit
> flag for it. As it is, the AT_REPLACE API design would rank poorly as
> "The obvious use is wrong."
> 
> An explicit AT_ATOMIC flag would help is that we could make the same
> semantics also apply to rename(2) with the same flag.
> 
> Omar,
> 
> I do understand why you say that you want to implement AT_REPLACE
> and let someone else take care of (bike shedding) AT_ATOMIC later.

I'm not in much of a rush to get AT_LINK_REPLACE in, so I'd be okay
getting it in together with AT_ATOMIC. I don't think I have the
bandwidth to get yet another VFS interface in, though (since I still
have to get back to RWF_ENCODED, which is a higher priority for me). Are
you planning on picking up AT_ATOMIC any time soon?

> The problem with that approach is that man page will have the
> AT_REPLACE documentation spread out without the mention of
> AT_ATOMIC_REPLACE and that can generate damage long into the future.

On the other hand, I believe I made this fairly clear in my man-page
patch:

+This does not guarantee data integrity;
+see EXAMPLE below for how to use this for crash-safe file replacement with
+.BR O_TMPFILE .

With the fsync() calls in the example.

Thanks!
