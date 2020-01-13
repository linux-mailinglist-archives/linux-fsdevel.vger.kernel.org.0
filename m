Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD51389D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 04:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbgAMDlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 22:41:51 -0500
Received: from mail.hallyn.com ([178.63.66.53]:45798 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbgAMDlv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:41:51 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 94577C13; Sun, 12 Jan 2020 21:41:49 -0600 (CST)
Date:   Sun, 12 Jan 2020 21:41:49 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        containers@lists.linux-foundation.org,
        linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>, serge@hallyn.com
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
Message-ID: <20200113034149.GA27228@mail.hallyn.com>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
 <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 04, 2020 at 12:39:45PM -0800, James Bottomley wrote:
> This implementation reverse shifts according to the user_ns belonging
> to the mnt_ns.  So if the vfsmount has the newly introduced flag
> MNT_SHIFT and the current user_ns is the same as the mount_ns->user_ns
> then we shift back using the user_ns before committing to the
> underlying filesystem.
> 
> For example, if a user_ns is created where interior (fake root, uid 0)
> is mapped to kernel uid 100000 then writes from interior root normally
> go to the filesystem at the kernel uid.  However, if MNT_SHIFT is set,
> they will be shifted back to write at uid 0, meaning we can bind mount
> real image filesystems to user_ns protected faker root.

Thanks, James, I definately would like to see shifting in the VFS
api.

I have a few practical concerns about this implementation, but my biggest
concern is more fundemental:  this again by design leaves littered about
the filesystem uid-0 owned files which were written by an untrusted user.

I would feel much better if you institutionalized having the origin
shifted.  For instance, take a squashfs for a container fs, shift it
so that fsuid 0 == hostuid 100000.  Mount that, with a marker saying
how it is shifted, then set 'shiftable'.  Now use that as a base for
allowing an unpriv user to shift.  If that user has subuid 200000 as
container uid 0, then its root will write files as uid 100000 in the
fs.  This isn't perfect, but I think something along these lines would
be far safer.

Two namespaces with different uid maps can share the filesystem as though
they both had the same uidmap.  (This currently is to me the most
interesting use case for shifing bind mounts)

If the user wants to tar up the result, they can do do in their own
namespace, resulting in uid 0 shown as uid 0.  If host root wants to
do so, they can umount it everywhere and use something like fuidshift.
Or, they can also create a namespace to do the shifting to uid 0 in tar.

My more practical concerns include: (1) once a userns has set a shiftable
bind mount to shift, if it then creates a new child userns, that ns
will not see (iiuc) see the fs as shifted.  (2) there seems to be no
good reason to stick to caching the cred for only one mnt, versus
having a per-userns hashtable of creds for shifted mnts.  Was that just
a temporary shortcut or did you intend it to stay that way?

