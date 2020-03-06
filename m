Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2661217C76B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCFU43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:56:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39290 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFU43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:56:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAK14-006Uhe-Ur; Fri, 06 Mar 2020 20:56:19 +0000
Date:   Fri, 6 Mar 2020 20:56:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200306205618.GF23230@ZenIV.linux.org.uk>
References: <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com>
 <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk>
 <20200306200522.GA23230@ZenIV.linux.org.uk>
 <20200306203705.GB23230@ZenIV.linux.org.uk>
 <20200306203844.GC23230@ZenIV.linux.org.uk>
 <20200306204523.GD23230@ZenIV.linux.org.uk>
 <20200306204926.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306204926.GE23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:49:26PM +0000, Al Viro wrote:
> On Fri, Mar 06, 2020 at 08:45:23PM +0000, Al Viro wrote:
> > On Fri, Mar 06, 2020 at 08:38:44PM +0000, Al Viro wrote:
> > > On Fri, Mar 06, 2020 at 08:37:05PM +0000, Al Viro wrote:
> > > 
> > > > You are misreading mntput_no_expire(), BTW - your get_mount() can
> > > > bloody well race with umount(2), hitting the moment when we are done
> > > > figuring out whether it's busy but hadn't cleaned ->mnt_ns (let alone
> > > > set MNT_DOOMED) yet.  If somebody calls umount(2) on a filesystem that
> > > > is not mounted anywhere else, they are not supposed to see the sucker
> > > > return 0 until the filesystem is shut down.  You break that.
> > > 
> > > While we are at it, d_alloc_parallel() requires i_rwsem on parent held
> > > at least shared.
> > 
> > Egads...  Let me see if I got it right - you are providing procfs symlinks
> > to objects on the internal mount of that thing.  And those objects happen
> > to be directories, so one can get to their parent that way.  Or am I misreading
> > that thing?
> 
> IDGI.  You have (in your lookup) kstrtoul, followed by snprintf, followed
> by strcmp and WARN_ON() in case of mismatch?  Is there any point in having
> stat(2) on "00" spew into syslog?  Confused...

AFAICS, refcounting in there cannot be right:
+static struct dentry *mountfs_lookup(struct inode *dir, struct dentry *dentry,
+                                    unsigned int flags)
+{
+       struct mountfs_entry *entry = dir->i_private;
+       int i = 0;
+               
+       if (entry) {
+               for (i = 0; i < ARRAY_SIZE(mountfs_attrs); i++)
+                       if (strcmp(mountfs_attrs[i], dentry->d_name.name) == 0)
+                               break;
+               if (i == ARRAY_SIZE(mountfs_attrs))
+                       return ERR_PTR(-ENOMEM);
+               i++;
+       } else {
+               entry = mountfs_get_entry(dentry->d_name.name);
+               if (!entry)
+                       return ERR_PTR(-ENOENT);
+       }
+                          
+       return mountfs_lookup_entry(dentry, entry, i);
+}
ends up consuming a reference in mountfs_lookup_entry() (at the very least,
drops it in case of inode allocation hitting OOM) and nothing in the
that loop in mountfs_lookup() appears to do a matching reference grab.
