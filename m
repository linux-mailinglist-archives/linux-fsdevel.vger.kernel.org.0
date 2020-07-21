Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3EB228415
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgGUPo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUPo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:44:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FC9C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 08:44:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so15609511edv.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCxkwsJkWtRVRzgtC3ppLWjEUz2hvwZMSQvoeHvaXcs=;
        b=Giywa30LnkhqMljkusS5lC5SzKMDpQWMuAnLZfNuLtKJm0IwkhXKWLaq07sHSEKHwN
         GGLaAzzKaDjw9kXCV9ti5So2YirVsYfeYJLCTk2WZF4G1GwRUlagRWZCOVZJIghLTD3U
         fomjSdI88VhTAfMzvEskyWyGOs5RPudewhmyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCxkwsJkWtRVRzgtC3ppLWjEUz2hvwZMSQvoeHvaXcs=;
        b=iJ68XNZ/5Xr6F8mrRBTSXjF6xD8mKyyn28nnvt48eAgiT4e+PYTLOb5BFwADSspyna
         ARlm+XuCMrc/wwuBNU0j7wci0woP9vhmociUhEoKRqpVBxTvxRIw0E1zrN+vz3fIrask
         TTzKSV4IbDq/RBl0OpL0PHqLhfzy42x5KK2fyL8HByk4/GPU/unuu1KU2Nu1I7kdiii4
         gFQSNR/m5bcyH0Xy98mHL693AOtWKPPpJ6OtgzL2J2oomk15WsNClzv6otiIjoELPBQi
         if2AvqY7guWiHCWo0NUbJathJ3o9jOuAPvcBKm6Pp0wjMZ6D+o2t8ZBJCIsobUOwC92x
         oltQ==
X-Gm-Message-State: AOAM533HFc49Wq1ml/eASTIf9FNpJuYt6TXUA7v66t4ttBcpSY/C0g9o
        s+qWwNAHJGypilUAvTUE4Ji5nQhaHJbjiIEpXR80iQ==
X-Google-Smtp-Source: ABdhPJxYc5oSNBeAxuXsSwNUkFB7FUW6ItHb5P7XAdqgmB2PMxX3WI2py92gufxgD4larouhhEcyxfcMR8yRTg7MhFo=
X-Received: by 2002:a50:cd1e:: with SMTP id z30mr25589709edi.364.1595346265312;
 Tue, 21 Jul 2020 08:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200716144032.GC422759@redhat.com> <20200716181828.GE422759@redhat.com>
 <CAJfpegt-v6sjm2WyjXMWkObqLdL6TSAi=rjra4KK5sNy6hhhmA@mail.gmail.com>
 <20200720154112.GC502563@redhat.com> <CAJfpegtked-aUq0zbTQjmspG04LG3ar-j_BRsb88kR+cnHNO_w@mail.gmail.com>
 <20200721151655.GB551452@redhat.com>
In-Reply-To: <20200721151655.GB551452@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 21 Jul 2020 17:44:14 +0200
Message-ID: <CAJfpegtiSNVhnH_FF8qyd2+NO8EJyXoJhPzRVsus8qm4d6UABQ@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Enable SB_NOSEC flag to improve small write performance
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        ganesh.mahalingam@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 5:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jul 21, 2020 at 02:33:41PM +0200, Miklos Szeredi wrote:
> > On Mon, Jul 20, 2020 at 5:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Fri, Jul 17, 2020 at 10:53:07AM +0200, Miklos Szeredi wrote:
> >
> > > I see in VFS that chown() always kills suid/sgid. While truncate() and
> > > write(), will suid/sgid only if caller does not have CAP_FSETID.
> > >
> > > How does this work with FUSE_HANDLE_KILLPRIV. IIUC, file server does not
> > > know if caller has CAP_FSETID or not. That means file server will be
> > > forced to kill suid/sgid on every write and truncate. And that will fail
> > > some of the tests.
> > >
> > > For WRITE requests now we do have the notion of setting
> > > FUSE_WRITE_KILL_PRIV flag to tell server explicitly to kill suid/sgid.
> > > Probably we could use that in cached write path as well to figure out
> > > whether to kill suid/sgid or not. But truncate() will still continue
> > > to be an issue.
> >
> > Yes, not doing the same for truncate seems to be an oversight.
> > Unfortunate, since we'll need another INIT flag to enable selective
> > clearing of suid/sgid on truncate.
> >
> > >
> > > >
> > > > Even writeback_cache could be handled by this addition, since we call
> > > > fuse_update_attributes() before generic_file_write_iter() :
> > > >
> > > > --- a/fs/fuse/dir.c
> > > > +++ b/fs/fuse/dir.c
> > > > @@ -985,6 +985,7 @@ static int fuse_update_get_attr(struct inode
> > > > *inode, struct file *file,
> > > >
> > > >         if (sync) {
> > > >                 forget_all_cached_acls(inode);
> > > > +               inode->i_flags &= ~S_NOSEC;
> > >
> > > Ok, So I was clearing S_NOSEC only if server reports that file has
> > > suid/sgid bit set. This change will clear S_NOSEC whenever we fetch
> > > attrs from host and will force getxattr() when we call file_remove_privs()
> > > and will increase overhead for non cache writeback mode. We probably
> > > could keep both. For cache writeback mode, clear it undonditionally
> > > otherwise not.
> >
> > We clear S_NOSEC because the attribute timeout has expired.  This
> > means we need to refresh all metadata, including cached xattr (which
> > is what S_NOSEC effectively is).
> >
> > > What I don't understand is though that how this change will clear
> > > suid/sgid on host in cache=writeback mode. I see fuse_setattr()
> > > will not set ATTR_MODE and clear S_ISUID and S_ISGID if
> > > fc->handle_killpriv is set. So when server receives setattr request
> > > (if it does), then how will it know it is supposed to kill suid/sgid
> > > bit. (its not chown, truncate and its not write).
> >
> > Depends.  If the attribute timeout is infinity, then that means the
> > cache is always up to date.  In that case we only need to clear
> > suid/sgid if set in i_mode.  Similarly, the security.capability will
> > only be cleared if it was set in the first place (which would clear
> > S_NOSEC).
> >
> > If the timeout is finite, then that means we need to check if the
> > metadata changed after a timeout.  That's the purpose of the
> > fuse_update_attributes() call before generic_file_write_iter().
> >
> > Does that make it clear?
>
> I understood it partly but one thing is still bothering me. What
> happens when cache writeback is set as well as fc->handle_killpriv=1.
>
> When handle_killpriv is set, how suid/sgid will be cleared by
> server. Given cache=writeback, write probably got cached in
> guest and server probably will not not see a WRITE immideately.
> (I am assuming we are relying on a WRITE to clear setuid/setgid when
>  handle_killpriv is set). And that means server will not clear
>  setuid/setgid till inode is written back at some point of time
>  later.
>
> IOW, cache=writeback and fc->handle_killpriv don't seem to go
> together (atleast given the current code).

fuse_cache_write_iter()
  -> fuse_update_attributes()   * this will refresh i_mode
  -> generic_file_write_iter()
      ->__generic_file_write_iter()
          ->file_remove_privs()    * this will check i_mode
              ->__remove_privs()
                  -> notify_change()
                     -> fuse_setattr()   * this will clear suid/sgit bits

Thanks,
Miklos



>
> Thanks
> Vivek
>
