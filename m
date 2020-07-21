Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27909228447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgGUPzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:55:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbgGUPzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595346912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XU2KlFmxoaRSSLSNlW5R1k7uon9KSmk8HhOfo5+I89I=;
        b=Dk9VXrU2l3eGvzFFXnF4s+yOolyy0rpBqjTWRr5Z8stdup5PBfro6MiVJB7qfqojCY82eJ
        NakinNeFVo6Fhp4L8CVuiIaJjgB1myHR9j7w7g0I32ro1uj4SBG7SorNUfjXSqSi9S584b
        iMxc3PTdjIMaeLsb82S/AGKj2iN3HGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-m_OZkfUPPH-LOnr3EVCSkA-1; Tue, 21 Jul 2020 11:55:08 -0400
X-MC-Unique: m_OZkfUPPH-LOnr3EVCSkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E1ECE918;
        Tue, 21 Jul 2020 15:55:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-14.rdu2.redhat.com [10.10.116.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9BA52B580;
        Tue, 21 Jul 2020 15:55:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 68ACD223C1E; Tue, 21 Jul 2020 11:55:03 -0400 (EDT)
Date:   Tue, 21 Jul 2020 11:55:03 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        ganesh.mahalingam@intel.com
Subject: Re: [PATCH] virtiofs: Enable SB_NOSEC flag to improve small write
 performance
Message-ID: <20200721155503.GC551452@redhat.com>
References: <20200716144032.GC422759@redhat.com>
 <20200716181828.GE422759@redhat.com>
 <CAJfpegt-v6sjm2WyjXMWkObqLdL6TSAi=rjra4KK5sNy6hhhmA@mail.gmail.com>
 <20200720154112.GC502563@redhat.com>
 <CAJfpegtked-aUq0zbTQjmspG04LG3ar-j_BRsb88kR+cnHNO_w@mail.gmail.com>
 <20200721151655.GB551452@redhat.com>
 <CAJfpegtiSNVhnH_FF8qyd2+NO8EJyXoJhPzRVsus8qm4d6UABQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtiSNVhnH_FF8qyd2+NO8EJyXoJhPzRVsus8qm4d6UABQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:44:14PM +0200, Miklos Szeredi wrote:
> On Tue, Jul 21, 2020 at 5:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jul 21, 2020 at 02:33:41PM +0200, Miklos Szeredi wrote:
> > > On Mon, Jul 20, 2020 at 5:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Fri, Jul 17, 2020 at 10:53:07AM +0200, Miklos Szeredi wrote:
> > >
> > > > I see in VFS that chown() always kills suid/sgid. While truncate() and
> > > > write(), will suid/sgid only if caller does not have CAP_FSETID.
> > > >
> > > > How does this work with FUSE_HANDLE_KILLPRIV. IIUC, file server does not
> > > > know if caller has CAP_FSETID or not. That means file server will be
> > > > forced to kill suid/sgid on every write and truncate. And that will fail
> > > > some of the tests.
> > > >
> > > > For WRITE requests now we do have the notion of setting
> > > > FUSE_WRITE_KILL_PRIV flag to tell server explicitly to kill suid/sgid.
> > > > Probably we could use that in cached write path as well to figure out
> > > > whether to kill suid/sgid or not. But truncate() will still continue
> > > > to be an issue.
> > >
> > > Yes, not doing the same for truncate seems to be an oversight.
> > > Unfortunate, since we'll need another INIT flag to enable selective
> > > clearing of suid/sgid on truncate.
> > >
> > > >
> > > > >
> > > > > Even writeback_cache could be handled by this addition, since we call
> > > > > fuse_update_attributes() before generic_file_write_iter() :
> > > > >
> > > > > --- a/fs/fuse/dir.c
> > > > > +++ b/fs/fuse/dir.c
> > > > > @@ -985,6 +985,7 @@ static int fuse_update_get_attr(struct inode
> > > > > *inode, struct file *file,
> > > > >
> > > > >         if (sync) {
> > > > >                 forget_all_cached_acls(inode);
> > > > > +               inode->i_flags &= ~S_NOSEC;
> > > >
> > > > Ok, So I was clearing S_NOSEC only if server reports that file has
> > > > suid/sgid bit set. This change will clear S_NOSEC whenever we fetch
> > > > attrs from host and will force getxattr() when we call file_remove_privs()
> > > > and will increase overhead for non cache writeback mode. We probably
> > > > could keep both. For cache writeback mode, clear it undonditionally
> > > > otherwise not.
> > >
> > > We clear S_NOSEC because the attribute timeout has expired.  This
> > > means we need to refresh all metadata, including cached xattr (which
> > > is what S_NOSEC effectively is).
> > >
> > > > What I don't understand is though that how this change will clear
> > > > suid/sgid on host in cache=writeback mode. I see fuse_setattr()
> > > > will not set ATTR_MODE and clear S_ISUID and S_ISGID if
> > > > fc->handle_killpriv is set. So when server receives setattr request
> > > > (if it does), then how will it know it is supposed to kill suid/sgid
> > > > bit. (its not chown, truncate and its not write).
> > >
> > > Depends.  If the attribute timeout is infinity, then that means the
> > > cache is always up to date.  In that case we only need to clear
> > > suid/sgid if set in i_mode.  Similarly, the security.capability will
> > > only be cleared if it was set in the first place (which would clear
> > > S_NOSEC).
> > >
> > > If the timeout is finite, then that means we need to check if the
> > > metadata changed after a timeout.  That's the purpose of the
> > > fuse_update_attributes() call before generic_file_write_iter().
> > >
> > > Does that make it clear?
> >
> > I understood it partly but one thing is still bothering me. What
> > happens when cache writeback is set as well as fc->handle_killpriv=1.
> >
> > When handle_killpriv is set, how suid/sgid will be cleared by
> > server. Given cache=writeback, write probably got cached in
> > guest and server probably will not not see a WRITE immideately.
> > (I am assuming we are relying on a WRITE to clear setuid/setgid when
> >  handle_killpriv is set). And that means server will not clear
> >  setuid/setgid till inode is written back at some point of time
> >  later.
> >
> > IOW, cache=writeback and fc->handle_killpriv don't seem to go
> > together (atleast given the current code).
> 
> fuse_cache_write_iter()
>   -> fuse_update_attributes()   * this will refresh i_mode
>   -> generic_file_write_iter()
>       ->__generic_file_write_iter()
>           ->file_remove_privs()    * this will check i_mode
>               ->__remove_privs()
>                   -> notify_change()
>                      -> fuse_setattr()   * this will clear suid/sgit bits

And fuse_setattr() has following.

                if (!fc->handle_killpriv) {
                        /*
                         * ia_mode calculation may have used stale i_mode.
                         * Refresh and recalculate.
                         */
                        ret = fuse_do_getattr(inode, NULL, file);
                        if (ret)
                                return ret;

                        attr->ia_mode = inode->i_mode;
                        if (inode->i_mode & S_ISUID) {
                                attr->ia_valid |= ATTR_MODE;
                                attr->ia_mode &= ~S_ISUID;
                        }
                        if ((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
                                attr->ia_valid |= ATTR_MODE;
                                attr->ia_mode &= ~S_ISGID;
                        }
                }
        }
        if (!attr->ia_valid)
                return 0;

So if fc->handle_killpriv is set, we might not even send setattr
request if attr->ia_valid turns out to be zero.

I did a quick instrumentation and noticed that we are sending
setattr with attr->ia_valid=0x200 (ATTR_FORCE) set. And file
server is not required to kill suid/sgid in this case?

Thanks
Vivek

