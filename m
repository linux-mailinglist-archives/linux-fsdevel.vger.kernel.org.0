Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A0315B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhBJAdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 19:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234328AbhBJAXI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:23:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E6F964E2F;
        Wed, 10 Feb 2021 00:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612916542;
        bh=XnK0uCf6XntTLSMEpv5s8Jm6HGo1F5EQr5IHHNgFHy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL5ZUhovQ8dV5fZagE9hDlMqxjFZgAQfbDKp9ayBQObeEhMhysRj2Q4ph6DrqViY1
         EKdLm2KmBsQgxBPExJAtmnktm6Mt709X5gIHxTK70+HZa6xY07roVOgFSFA54qfO7b
         FVAhaPSpfhud4RqvecWlGZBeQDgFm/xEVgZt49RdtmUiflntpeF4+A5GQ0k8Ih5lpm
         oOUvbAMwU2W3mcoMBYjNYmNB8vV8ZRS6OL4DHKFkjWVNuBo+T9/fOV8GlIUm6fKjqp
         RdUeEot8JNOQVu8fLxFzMjZXQw0Fam3xzDeQRx1F5VP5ThSnu/A+Ty6cc6JMGFK2UV
         LGaIhrqFWrL+g==
Date:   Tue, 9 Feb 2021 16:22:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Theodore Ts'o <tytso@mit.edu>, jack@suse.com,
        viro@zeniv.linux.org.uk, amir73il@gmail.com, dhowells@redhat.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210210002220.GC7187@magnolia>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
 <20210209173543.GE19070@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209173543.GE19070@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 06:35:43PM +0100, Jan Kara wrote:
> On Tue 09-02-21 09:19:16, Dave Chinner wrote:
> > On Mon, Feb 08, 2021 at 01:49:41PM -0500, Gabriel Krisman Bertazi wrote:
> > > "Theodore Ts'o" <tytso@mit.edu> writes:
> > > > On Tue, Feb 02, 2021 at 03:26:35PM -0500, Gabriel Krisman Bertazi wrote:
> > > >> 
> > > >> Thanks for the explanation.  That makes sense to me.  For corruptions
> > > >> where it is impossible to map to a mountpoint, I thought they could be
> > > >> considered global filesystem errors, being exposed only to someone
> > > >> watching the entire filesystem (like FAN_MARK_FILESYSTEM).
> > > >
> > > > At least for ext4, there are only 3 ext4_error_*() that we could map
> > > > to a subtree without having to make changes to the call points:
> > > >
> > > > % grep -i ext4_error_file\( fs/ext4/*.c  | wc -l
> > > > 3
> > > > % grep -i ext4_error_inode\( fs/ext4/*.c  | wc -l
> > > > 79
> > > > % grep -i ext4_error\( fs/ext4/*.c  | wc -l
> > > > 42
> > > >
> > > > So in practice, unless we want to make a lot of changes to ext4, most
> > > > of them will be global file system errors....
> > > >
> > > >> But, as you mentioned regarding the google use case, the entire idea of
> > > >> watching a subtree is a bit beyond the scope of my use-case, and was
> > > >> only added given the feedback on the previous proposal of this feature.
> > > >> While nice to have, I don't have the need to watch different mountpoints
> > > >> for errors, only the entire filesystem.
> > > >
> > > > I suspect that for most use cases, the most interesting thing is the
> > > > first error.  We already record this in the ext4 superblock, because
> > > > unfortunately, I can't guarantee that system administrators have
> > > > correctly configured their system logs, so when handling upstream bug
> > > > reports, I can just ask them to run dumpe2fs -h on the file system:
> > > >
> > > > FS Error count:           2
> > > > First error time:         Tue Feb  2 16:27:42 2021
> > > > First error function:     ext4_lookup
> > > > First error line #:       1704
> > > > First error inode #:      12
> > > > First error err:          EFSCORRUPTED
> > > > Last error time:          Tue Feb  2 16:27:59 2021
> > > > Last error function:      ext4_lookup
> > > > Last error line #:        1704
> > > > Last error inode #:       12
> > > > Last error err:           EFSCORRUPTED
> > > >
> > > > So it's not just the Google case.  I'd argue for most system
> > > > administrator, one of the most useful things is when the file system
> > > > was first found to be corrupted, so they can try correlating file
> > > > system corruptions, with, say, reports of I/O errors, or OOM kils,
> > > > etc.  This can also be useful for correlating the start of file system
> > > > problems with problems at the application layer --- say, MongoDB,
> > > > MySQL, etc.
> > > >
> > > > The reason why a notification system useful is because if you are
> > > > using database some kind of high-availability replication system, and
> > > > if there are problems detected in the file system of the primary MySQL
> > > > server, you'd want to have the system fail over to the secondary MySQL
> > > > server.  Sure, you *could* do this by polling the superblock, but
> > > > that's not the most efficient way to do things.
> > > 
> > > Hi Ted,
> > > 
> > > I think this closes a full circle back to my original proposal.  It
> > > doesn't have the complexities of objects other than superblock
> > > notifications, doesn't require allocations.  I sent an RFC for that a
> > > while ago [1] which resulted in this discussion and the current
> > > implementation.
> > 
> > Yup, we're back to "Design for Google/ext4 requirements only", and
> > ignoring that other filesystems and users also have non-trivial
> > requirements for userspace error notifications.
> > 
> > > For the sake of a having a proposal and a way to move forward, I'm not
> > > sure what would be the next step here.  I could revive the previous
> > > implementation, addressing some issues like avoiding the superblock
> > > name, the way we refer to blocks and using CAP_SYS_ADMIN.  I think that
> > > implementation solves the usecase you explained with more simplicity.
> > > But I'm not sure Darrick and Dave (all in cc) will be convinced by this
> > > approach of global pipe where we send messages for the entire
> > > filesystem, as Dave described it in the previous implementation.
> > 
> > Nope, not convinced at all. As a generic interface, it cannot be
> > designed explicitly for the needs of a single filesystem, especially
> > when there are other filesystems needing to implement similar
> > functionality.
> > 
> > As Amir pointed up earlier in the thread, XFS already already has
> > extensive per-object verification and error reporting facilicities
> > that we would like to hook up to such a generic error reporting
> > mechanism. These use generic mechanisms within XFS, and we've
> > largely standardised the code interally to implement this (e.g. the
> > xfs_failaddr as a mechanism of efficiently encoding the exact check
> > that failed out of the hundreds of verification checks we do).
> > 
> > If we've already got largely standardised, efficient mechanisms for
> > doing all of this in a filesystem, then why would we want to throw
> > that all away when implementing a generic userspace notification
> > channel? We know exactly what we need to present with userspace, so
> > even if other filesystems don't need exactly the same detail of
> > information, they still need to supply a subset of that same
> > information to userspace.
> > 
> > The ext4-based proposals keep mentioning dumping text strings and
> > encoded structures that are ext4 error specific, instead of starting
> > from a generic notification structure that defines the object in the
> > filesystem and location within the object that the notification is
> > for. e.g the {bdev, object, offset, length} object ID tuple I
> > mention here:
> > 
> > https://lore.kernel.org/linux-ext4/20201210220914.GG4170059@dread.disaster.area/
> > 
> > For XFS, we want to be able to hook up the verifier error reports
> > to a notification. We want to be able to hook all our corruption
> > reports to a notification. We want to be able to hook all our
> > writeback errors to a notification. We want to be able to hook all
> > our ENOSPC and EDQUOT errors to a notification. And that's just the
> > obvious stuff that notifications are useful for.
> 
> I agree with you here but I'd like to get the usecases spelled out to be
> able to better evaluate the information we need to pass. I can imagine for
> ENOSPC errors this can be stuff like thin provisioning sending red alert to
> sysadmin - this would be fs-wide event. I have somewhat hard time coming up
> with a case where notification of ENOSPC / EDQUOT for a particular file /
> dir would be useful.

How about a container where you've set a project quota and the container
hits that quota?

> I can see a usecase where an application wishes to monitor all its files /
> dirs for any type for error fatal error (ENOSPC, EDQUOT, EIO). Here scoping
> makes a lot of sense from application POV. It may be somewhat tricky to
> reliably provide the notification though. If we say spot inconsistency in
> block allocation structure during page writeback (be it btree in XFS case
> or bitmap in ext4 case), we report the error there in the code for that
> structure but that is not necessarily aware of the inode so we need to make
> sure to generate another notification in upper layers where we can associate
> the error with the inode as well. Even worse if we spot some error e.g. during
> journal commit, we (at least in ext4 case) don't have enough information to
> trace back affected inodes anymore. So how do we handle such cases? Do we
> actively queue error notifications for all inodes? Or do we lazily wait for
> some operation associated with a particular inode to fail to queue
> notification? I can see pros and cons for both...

FWIW all the error notification consumers that I have in mind (based on
internal feedback anyway) stratify into two cases: (1) the app doesn't
care what the error is--upon any error it simply signals the cluster
manager that the node failed and offlines the whole node so that
recovery can begin.  (2) is where offlining the whole node is too
expensive or impactful so they want a detailed error message sent to the
appropriate xfs utility so that it can fix the problem.  The actual
message sent to the app doesn't have to be terribly specific aside from
which file(s) are impacted.

> 
> What usecases you had in mind?
> 
> > If you want an idea of all the different types of metadata objects
> > we need to have different notifications for, look at the GETFSMAP
> > ioctl man page. It lists all the different types of objects we are
> > likely to emit notifications for from XFS (e.g. free space
> > btree corruption at record index X to Y) because, well, that's the
> > sort of information we're already dumping to the kernel log....
> > 
> > Hence from a design perspective, we need to separate the contents of
> > the notification from the mechanism used to configure, filter and
> > emit notifications to userspace.  That is, it doesn't matter if we
> > add a magic new syscall or use fanotify to configure watches and
> > transfer messages to userspace, the contents of the message is going
> > to be the exactly the same, and the API that the filesystem
> > implementations are going to call to emit a notification to
> > userspace is exactly the same.
> > 
> > So a generic message structure looks something like this:
> > 
> > <notification type>		(msg structure type)
> > <notification location>		(encoded file/line info)
> > <object type>			(inode, dir, btree, bmap, block, etc)
> > <object ID>			{bdev, object}
> > <range>				{offset, length} (range in object)
> > <notification version>		(notification data version)
> > <notification data>		(filesystem specific data)
> 
> There's a caveat though that 'object type' is necessarily filesystem
> specific and with new filesystem wanting to support this we'll likely need
> to add more object types. So it is questionable how "generic error parser"
> would be able to use this type of information and whether this doesn't need
> to be in the fs-specific blob.

Agreed, so I split the two cases from each other completely in the reply
I sent upstream a little while ago.

> Also versioning fs specific blobs with 'notification version' tends to get
> somewhat cumbersome if you need to update the scheme, thus bump the
> version, which breaks all existing parsers (and I won't even speak about
> the percentage of parses that won't bother with checking the version and
> just blindly try to parse whatever they get assuming incorrect things ;).
> We've been there more than once... But this is more of a side remark - once
> other problems are settled I believe we can come up with reasonably
> extensible scheme for blob passing pretty easily.

A pity we can't just hurl a blob of json with whatever attributes
attached that we like, but maybe I shouldn't go there.  :)

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
