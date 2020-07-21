Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27951228B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgGUVax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 17:30:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730654AbgGUVav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595367049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXOIW2tKcjVLnKfRcrpqQIxVJkDQFrSqbbXs9Ch/ijw=;
        b=L/64WBGQs7M3f2Tvc6RdZUmPY4eLSXJUiJhiZy35CjZ+Crde5OFT3kxjBSWyX2mIF5B7Gm
        yiVZAFYnCrwnDcKSI8id/WZJqGscSLCNQIqINGwfR6BS530v+4KGRxXNisKLodPPLemugs
        QL0zHsdrnoSGx8c+czPgtE3gDrQAU9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-TI-Juf5eMny5Lh2j3_oDGg-1; Tue, 21 Jul 2020 17:30:47 -0400
X-MC-Unique: TI-Juf5eMny5Lh2j3_oDGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33F1B800473;
        Tue, 21 Jul 2020 21:30:46 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-14.rdu2.redhat.com [10.10.116.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 420A68731A;
        Tue, 21 Jul 2020 21:30:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D0A13223C1E; Tue, 21 Jul 2020 17:30:42 -0400 (EDT)
Date:   Tue, 21 Jul 2020 17:30:42 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        ganesh.mahalingam@intel.com
Subject: Re: [PATCH] virtiofs: Enable SB_NOSEC flag to improve small write
 performance
Message-ID: <20200721213042.GE551452@redhat.com>
References: <20200716144032.GC422759@redhat.com>
 <20200716181828.GE422759@redhat.com>
 <CAJfpegt-v6sjm2WyjXMWkObqLdL6TSAi=rjra4KK5sNy6hhhmA@mail.gmail.com>
 <20200720154112.GC502563@redhat.com>
 <CAJfpegtked-aUq0zbTQjmspG04LG3ar-j_BRsb88kR+cnHNO_w@mail.gmail.com>
 <20200721151655.GB551452@redhat.com>
 <CAJfpegtiSNVhnH_FF8qyd2+NO8EJyXoJhPzRVsus8qm4d6UABQ@mail.gmail.com>
 <20200721155503.GC551452@redhat.com>
 <CAJfpegsUsZ1DLW6rzR4PQ=M2MxCY1r87eu2rP0Nac4Li_VEm7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsUsZ1DLW6rzR4PQ=M2MxCY1r87eu2rP0Nac4Li_VEm7Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:53:21PM +0200, Miklos Szeredi wrote:
> On Tue, Jul 21, 2020 at 5:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jul 21, 2020 at 05:44:14PM +0200, Miklos Szeredi wrote:
> > > On Tue, Jul 21, 2020 at 5:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Tue, Jul 21, 2020 at 02:33:41PM +0200, Miklos Szeredi wrote:
> > > > > On Mon, Jul 20, 2020 at 5:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Jul 17, 2020 at 10:53:07AM +0200, Miklos Szeredi wrote:
> > > > >
> > > > > > I see in VFS that chown() always kills suid/sgid. While truncate() and
> > > > > > write(), will suid/sgid only if caller does not have CAP_FSETID.
> > > > > >
> > > > > > How does this work with FUSE_HANDLE_KILLPRIV. IIUC, file server does not
> > > > > > know if caller has CAP_FSETID or not. That means file server will be
> > > > > > forced to kill suid/sgid on every write and truncate. And that will fail
> > > > > > some of the tests.
> > > > > >
> > > > > > For WRITE requests now we do have the notion of setting
> > > > > > FUSE_WRITE_KILL_PRIV flag to tell server explicitly to kill suid/sgid.
> > > > > > Probably we could use that in cached write path as well to figure out
> > > > > > whether to kill suid/sgid or not. But truncate() will still continue
> > > > > > to be an issue.
> > > > >
> > > > > Yes, not doing the same for truncate seems to be an oversight.
> > > > > Unfortunate, since we'll need another INIT flag to enable selective
> > > > > clearing of suid/sgid on truncate.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Even writeback_cache could be handled by this addition, since we call
> > > > > > > fuse_update_attributes() before generic_file_write_iter() :
> > > > > > >
> > > > > > > --- a/fs/fuse/dir.c
> > > > > > > +++ b/fs/fuse/dir.c
> > > > > > > @@ -985,6 +985,7 @@ static int fuse_update_get_attr(struct inode
> > > > > > > *inode, struct file *file,
> > > > > > >
> > > > > > >         if (sync) {
> > > > > > >                 forget_all_cached_acls(inode);
> > > > > > > +               inode->i_flags &= ~S_NOSEC;
> > > > > >
> > > > > > Ok, So I was clearing S_NOSEC only if server reports that file has
> > > > > > suid/sgid bit set. This change will clear S_NOSEC whenever we fetch
> > > > > > attrs from host and will force getxattr() when we call file_remove_privs()
> > > > > > and will increase overhead for non cache writeback mode. We probably
> > > > > > could keep both. For cache writeback mode, clear it undonditionally
> > > > > > otherwise not.
> > > > >
> > > > > We clear S_NOSEC because the attribute timeout has expired.  This
> > > > > means we need to refresh all metadata, including cached xattr (which
> > > > > is what S_NOSEC effectively is).
> > > > >
> > > > > > What I don't understand is though that how this change will clear
> > > > > > suid/sgid on host in cache=writeback mode. I see fuse_setattr()
> > > > > > will not set ATTR_MODE and clear S_ISUID and S_ISGID if
> > > > > > fc->handle_killpriv is set. So when server receives setattr request
> > > > > > (if it does), then how will it know it is supposed to kill suid/sgid
> > > > > > bit. (its not chown, truncate and its not write).
> > > > >
> > > > > Depends.  If the attribute timeout is infinity, then that means the
> > > > > cache is always up to date.  In that case we only need to clear
> > > > > suid/sgid if set in i_mode.  Similarly, the security.capability will
> > > > > only be cleared if it was set in the first place (which would clear
> > > > > S_NOSEC).
> > > > >
> > > > > If the timeout is finite, then that means we need to check if the
> > > > > metadata changed after a timeout.  That's the purpose of the
> > > > > fuse_update_attributes() call before generic_file_write_iter().
> > > > >
> > > > > Does that make it clear?
> > > >
> > > > I understood it partly but one thing is still bothering me. What
> > > > happens when cache writeback is set as well as fc->handle_killpriv=1.
> > > >
> > > > When handle_killpriv is set, how suid/sgid will be cleared by
> > > > server. Given cache=writeback, write probably got cached in
> > > > guest and server probably will not not see a WRITE immideately.
> > > > (I am assuming we are relying on a WRITE to clear setuid/setgid when
> > > >  handle_killpriv is set). And that means server will not clear
> > > >  setuid/setgid till inode is written back at some point of time
> > > >  later.
> > > >
> > > > IOW, cache=writeback and fc->handle_killpriv don't seem to go
> > > > together (atleast given the current code).
> > >
> > > fuse_cache_write_iter()
> > >   -> fuse_update_attributes()   * this will refresh i_mode
> > >   -> generic_file_write_iter()
> > >       ->__generic_file_write_iter()
> > >           ->file_remove_privs()    * this will check i_mode
> > >               ->__remove_privs()
> > >                   -> notify_change()
> > >                      -> fuse_setattr()   * this will clear suid/sgit bits
> >
> > And fuse_setattr() has following.
> >
> >                 if (!fc->handle_killpriv) {
> >                         /*
> >                          * ia_mode calculation may have used stale i_mode.
> >                          * Refresh and recalculate.
> >                          */
> >                         ret = fuse_do_getattr(inode, NULL, file);
> >                         if (ret)
> >                                 return ret;
> >
> >                         attr->ia_mode = inode->i_mode;
> >                         if (inode->i_mode & S_ISUID) {
> >                                 attr->ia_valid |= ATTR_MODE;
> >                                 attr->ia_mode &= ~S_ISUID;
> >                         }
> >                         if ((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
> >                                 attr->ia_valid |= ATTR_MODE;
> >                                 attr->ia_mode &= ~S_ISGID;
> >                         }
> >                 }
> >         }
> >         if (!attr->ia_valid)
> >                 return 0;
> >
> > So if fc->handle_killpriv is set, we might not even send setattr
> > request if attr->ia_valid turns out to be zero.
> 
> Ah, right you are.  The writeback_cache case is indeed special.
> 
> The way that can be properly solved, I think, is to check if any
> security bits need to be removed before calling into
> generic_file_write_iter() and if yes, fall back to unbuffered write.
> 
> Something like the attached?
> 
> Thanks,
> Miklos

> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 83d917f7e542..f67c6f46dae9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1245,16 +1245,21 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ssize_t written = 0;
>  	ssize_t written_buffered = 0;
>  	struct inode *inode = mapping->host;
> +	struct fuse_conn *fc = get_fuse_conn(inode);
>  	ssize_t err;
>  	loff_t endbyte = 0;
>  
> -	if (get_fuse_conn(inode)->writeback_cache) {
> +	if (fc->writeback_cache) {
>  		/* Update size (EOF optimization) and mode (SUID clearing) */
>  		err = fuse_update_attributes(mapping->host, file);
>  		if (err)
>  			return err;
>  
> -		return generic_file_write_iter(iocb, from);
> +		if (!fc->handle_killpriv ||
> +		    !should_remove_suid(file->f_path.dentry))
> +			return generic_file_write_iter(iocb, from);
> +
> +		/* Fall back to unbuffered write to remove SUID/SGID bits */

This should solve the issue with fc->writeback_cache.

What about following race. Assume a client has set suid/sgid/caps
and this client is doing write but cache metadata has not expired
yet. That means fuse_update_attributes() will not clear S_NOSEC
and that means file_remove_privs() will not clear suid/sgid/caps
as well as WRITE will be buffered so that also will not clear
suid/sgid/caps as well.

IOW, even after WRITE has completed, suid/sgid/security.capability will
still be there on file inode if inode metadata had not expired at the time
of WRITE. Is that acceptable from coherency requirements point of view.

I have a question. Does general fuse allow this use case where multiple
clients are distributed and not going through same VFS? virtiofs wants
to support that at some point of time but what about existing fuse
filesystems.

I also have concerns with being dependent on FUSE_HANDLE_KILLPRIV because
it clear suid/sgid on WRITE and truncate evn if caller has
CAP_SETID, breaking Linux behavior (Don't know what does POSIX say).

Shall we design FUSE_HANDLE_KILLPRIV2 instead which kills
security.capability always but kills suid/sgid on on WRITE/truncate
only if caller does not have CAP_FSETID. This also means that
we probably will have to send this information in fuse_setattr()
somehow.

Am I overthinking now? :-)

Thanks
Vivek

