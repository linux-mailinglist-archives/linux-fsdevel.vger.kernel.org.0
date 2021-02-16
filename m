Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1F31CA65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 13:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhBPMJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 07:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhBPMJV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:09:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D4FD64DEC;
        Tue, 16 Feb 2021 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613477319;
        bh=N6IPz8XGOy0RF1NT74Z7eRigRqaB8x6X5g527PxF5RQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ue+XGyHFzpeClX9mdf4W19RMMHxIBgpWc3l2p8ZY+Miiixo5HvUv2TgXfsJDH3hix
         rUzDtieqzYLWFVkOub4X2EO1pFXRRxQ6Aawh6BGDbZCrdurRSxGvJUmBmWXVRwiCSZ
         3xyfXFRIQMeWuBHdZQGk3mY8kK9tUcNlVd+55GC0=
Date:   Tue, 16 Feb 2021 13:08:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Message-ID: <YCu1xe9PLVhmFMEM@kroah.com>
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de>
 <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
 <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
 <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
 <CAOQ4uxjUf15fDjz11pCzT3GkFmw=2ySXR_6XF-Bf-TfUwpj77Q@mail.gmail.com>
 <87r1lgjm7l.fsf@suse.de>
 <YCuseTMyjL+9sWum@kroah.com>
 <87k0r8jk6r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0r8jk6r.fsf@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:01:16PM +0000, Luis Henriques wrote:
> "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Feb 16, 2021 at 11:17:34AM +0000, Luis Henriques wrote:
> >> Amir Goldstein <amir73il@gmail.com> writes:
> >> 
> >> > On Mon, Feb 15, 2021 at 8:57 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >> >>
> >> >> On Mon, 2021-02-15 at 19:24 +0200, Amir Goldstein wrote:
> >> >> > On Mon, Feb 15, 2021 at 6:53 PM Trond Myklebust <
> >> >> > trondmy@hammerspace.com> wrote:
> >> >> > >
> >> >> > > On Mon, 2021-02-15 at 18:34 +0200, Amir Goldstein wrote:
> >> >> > > > On Mon, Feb 15, 2021 at 5:42 PM Luis Henriques <
> >> >> > > > lhenriques@suse.de>
> >> >> > > > wrote:
> >> >> > > > >
> >> >> > > > > Nicolas Boichat reported an issue when trying to use the
> >> >> > > > > copy_file_range
> >> >> > > > > syscall on a tracefs file.  It failed silently because the file
> >> >> > > > > content is
> >> >> > > > > generated on-the-fly (reporting a size of zero) and
> >> >> > > > > copy_file_range
> >> >> > > > > needs
> >> >> > > > > to know in advance how much data is present.
> >> >> > > > >
> >> >> > > > > This commit restores the cross-fs restrictions that existed
> >> >> > > > > prior
> >> >> > > > > to
> >> >> > > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> >> >> > > > > devices")
> >> >> > > > > and
> >> >> > > > > removes generic_copy_file_range() calls from ceph, cifs, fuse,
> >> >> > > > > and
> >> >> > > > > nfs.
> >> >> > > > >
> >> >> > > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> >> >> > > > > devices")
> >> >> > > > > Link:
> >> >> > > > > https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> >> >> > > > > Cc: Nicolas Boichat <drinkcat@chromium.org>
> >> >> > > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> >> > > >
> >> >> > > > Code looks ok.
> >> >> > > > You may add:
> >> >> > > >
> >> >> > > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >> >> > > >
> >> >> > > > I agree with Trond that the first paragraph of the commit message
> >> >> > > > could
> >> >> > > > be improved.
> >> >> > > > The purpose of this change is to fix the change of behavior that
> >> >> > > > caused the regression.
> >> >> > > >
> >> >> > > > Before v5.3, behavior was -EXDEV and userspace could fallback to
> >> >> > > > read.
> >> >> > > > After v5.3, behavior is zero size copy.
> >> >> > > >
> >> >> > > > It does not matter so much what makes sense for CFR to do in this
> >> >> > > > case (generic cross-fs copy).  What matters is that nobody asked
> >> >> > > > for
> >> >> > > > this change and that it caused problems.
> >> >> > > >
> >> >> > >
> >> >> > > No. I'm saying that this patch should be NACKed unless there is a
> >> >> > > real
> >> >> > > explanation for why we give crap about this tracefs corner case and
> >> >> > > why
> >> >> > > it can't be fixed.
> >> >> > >
> >> >> > > There are plenty of reasons why copy offload across filesystems
> >> >> > > makes
> >> >> > > sense, and particularly when you're doing NAS. Clone just doesn't
> >> >> > > cut
> >> >> > > it when it comes to disaster recovery (whereas backup to a
> >> >> > > different
> >> >> > > storage unit does). If the client has to do the copy, then you're
> >> >> > > effectively doubling the load on the server, and you're adding
> >> >> > > potentially unnecessary network traffic (or at the very least you
> >> >> > > are
> >> >> > > doubling that traffic).
> >> >> > >
> >> >> >
> >> >> > I don't understand the use case you are describing.
> >> >> >
> >> >> > Which filesystem types are you talking about for source and target
> >> >> > of copy_file_range()?
> >> >> >
> >> >> > To be clear, the original change was done to support NFS/CIFS server-
> >> >> > side
> >> >> > copy and those should not be affected by this change.
> >> >> >
> >> >>
> >> >> That is incorrect:
> >> >>
> >> >> ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file
> >> >> *dst,
> >> >>  u64 dst_pos, u64 count)
> >> >> {
> >> >>
> >> >>  /*
> >> >>  * Limit copy to 4MB to prevent indefinitely blocking an nfsd
> >> >>  * thread and client rpc slot. The choice of 4MB is somewhat
> >> >>  * arbitrary. We might instead base this on r/wsize, or make it
> >> >>  * tunable, or use a time instead of a byte limit, or implement
> >> >>  * asynchronous copy. In theory a client could also recognize a
> >> >>  * limit like this and pipeline multiple COPY requests.
> >> >>  */
> >> >>  count = min_t(u64, count, 1 << 22);
> >> >>  return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
> >> >> }
> >> >>
> >> >> You are now explicitly changing the behaviour of knfsd when the source
> >> >> and destination filesystem differ.
> >> >>
> >> >> For one thing, you are disallowing the NFSv4.2 copy offload use case of
> >> >> copying from a local filesystem to a remote NFS server. However you are
> >> >> also disallowing the copy from, say, an XFS formatted partition to an
> >> >> ext4 partition.
> >> >>
> >> >
> >> > Got it.
> >> 
> >> Ugh.  And I guess overlayfs may have a similar problem.
> >> 
> >> > This is easy to solve with a flag COPY_FILE_SPLICE (or something) that
> >> > is internal to kernel users.
> >> >
> >> > FWIW, you may want to look at the loop in ovl_copy_up_data()
> >> > for improvements to nfsd_copy_file_range().
> >> >
> >> > We can move the check out to copy_file_range syscall:
> >> >
> >> >         if (flags != 0)
> >> >                 return -EINVAL;
> >> >
> >> > Leave the fallback from all filesystems and check for the
> >> > COPY_FILE_SPLICE flag inside generic_copy_file_range().
> >> 
> >> Ok, the diff bellow is just to make sure I understood your suggestion.
> >> 
> >> The patch will also need to:
> >> 
> >>  - change nfs and overlayfs calls to vfs_copy_file_range() so that they
> >>    use the new flag.
> >> 
> >>  - check flags in generic_copy_file_checks() to make sure only valid flags
> >>    are used (COPY_FILE_SPLICE at the moment).
> >> 
> >> Also, where should this flag be defined?  include/uapi/linux/fs.h?
> >
> > Why would userspace want/need this flag?
> 
> In fact, my question sort of implied yours :-)
> 
> What I wanted to know was whether we would like to allow userspace to
> _explicitly_ revert to the current behaviour (i.e. use the flag to allow
> cross-fs copies) or to continue to return -EINVAL to userspace if flags
> are != 0 (in which case this check would need to move to the syscall
> definition).

No, don't try to mess with userspace that way, the kernel should "just
work".  Well, in this case "work as best as it can, not always
successful...", it's an odd syscall.

thanks,

greg k-h
