Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601D5227FF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgGUMdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 08:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgGUMdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:33:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5EC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 05:33:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a21so21450008ejj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRx+GMkPyl0Ni2dtSicn9mHxtuGv25ioZ7oSYzWdlcQ=;
        b=VVxelUJaM932HGLeNAIVlZgYjbIQExZz/pke7j3ErdzGi70cdf+9AltDQwMJp4RW2c
         Dnd1MOfhIFkebEflMP7Aedy29CB4pmZWaUVs7Gs1D2RLpyNptdBk8QdHwy2Xc+eBEZua
         XPkh9KvCxw/VfeyL+Wpu+VLR937eXIFhmSbn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRx+GMkPyl0Ni2dtSicn9mHxtuGv25ioZ7oSYzWdlcQ=;
        b=M/agADTwDKvJcO2yuD+rNf+wnvmBYzMnI5kO7yvYcZdXwBhAjWK/lzb+74j2SBE/9V
         g4J1Z9E0ZDzgQUMghh8krhjw895FcZpUrCaHWf3PXGIXz3+DJ9EWAQFicyk/ItDdmZKd
         dcV+LNTp6mu2XVZI1TwbnA9nbABhE9BqoaarzLcTG6voSWEHEjLs8+Ehoy2KIJgr+HSS
         QlNnwqRQoxXMGrsD6iThn4YaxcmUjFvFsyOKMJvGlDZfF2myjt/9e0N9f1umBacyWWnx
         YgthFeTDt/d8/e5dn5iRY/wsQGvAIoh8L+yKIFQho6p+JDyzyngwoAQuTfjGuEJjxyjf
         cm7g==
X-Gm-Message-State: AOAM530fg9l629/JfcvZI60Wre3lyMDRXw+F1F72Dx00/jhm7Lk2fTH7
        Z9bRTiusaiELAON88OJXKX2qPkHFwJnZN4mVz5R3inX1mxu84A==
X-Google-Smtp-Source: ABdhPJzEVPeBOF/5G87M0mUj0FyLSRO1bdeJ/sMciM5FNneoz+SM0e+vlbCJh78tN/qOwaUA750sB0VzzediMYNGts4=
X-Received: by 2002:a17:906:3c42:: with SMTP id i2mr26893516ejg.14.1595334832605;
 Tue, 21 Jul 2020 05:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200716144032.GC422759@redhat.com> <20200716181828.GE422759@redhat.com>
 <CAJfpegt-v6sjm2WyjXMWkObqLdL6TSAi=rjra4KK5sNy6hhhmA@mail.gmail.com> <20200720154112.GC502563@redhat.com>
In-Reply-To: <20200720154112.GC502563@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 21 Jul 2020 14:33:41 +0200
Message-ID: <CAJfpegtked-aUq0zbTQjmspG04LG3ar-j_BRsb88kR+cnHNO_w@mail.gmail.com>
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

On Mon, Jul 20, 2020 at 5:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jul 17, 2020 at 10:53:07AM +0200, Miklos Szeredi wrote:

> I see in VFS that chown() always kills suid/sgid. While truncate() and
> write(), will suid/sgid only if caller does not have CAP_FSETID.
>
> How does this work with FUSE_HANDLE_KILLPRIV. IIUC, file server does not
> know if caller has CAP_FSETID or not. That means file server will be
> forced to kill suid/sgid on every write and truncate. And that will fail
> some of the tests.
>
> For WRITE requests now we do have the notion of setting
> FUSE_WRITE_KILL_PRIV flag to tell server explicitly to kill suid/sgid.
> Probably we could use that in cached write path as well to figure out
> whether to kill suid/sgid or not. But truncate() will still continue
> to be an issue.

Yes, not doing the same for truncate seems to be an oversight.
Unfortunate, since we'll need another INIT flag to enable selective
clearing of suid/sgid on truncate.

>
> >
> > Even writeback_cache could be handled by this addition, since we call
> > fuse_update_attributes() before generic_file_write_iter() :
> >
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -985,6 +985,7 @@ static int fuse_update_get_attr(struct inode
> > *inode, struct file *file,
> >
> >         if (sync) {
> >                 forget_all_cached_acls(inode);
> > +               inode->i_flags &= ~S_NOSEC;
>
> Ok, So I was clearing S_NOSEC only if server reports that file has
> suid/sgid bit set. This change will clear S_NOSEC whenever we fetch
> attrs from host and will force getxattr() when we call file_remove_privs()
> and will increase overhead for non cache writeback mode. We probably
> could keep both. For cache writeback mode, clear it undonditionally
> otherwise not.

We clear S_NOSEC because the attribute timeout has expired.  This
means we need to refresh all metadata, including cached xattr (which
is what S_NOSEC effectively is).

> What I don't understand is though that how this change will clear
> suid/sgid on host in cache=writeback mode. I see fuse_setattr()
> will not set ATTR_MODE and clear S_ISUID and S_ISGID if
> fc->handle_killpriv is set. So when server receives setattr request
> (if it does), then how will it know it is supposed to kill suid/sgid
> bit. (its not chown, truncate and its not write).

Depends.  If the attribute timeout is infinity, then that means the
cache is always up to date.  In that case we only need to clear
suid/sgid if set in i_mode.  Similarly, the security.capability will
only be cleared if it was set in the first place (which would clear
S_NOSEC).

If the timeout is finite, then that means we need to check if the
metadata changed after a timeout.  That's the purpose of the
fuse_update_attributes() call before generic_file_write_iter().

Does that make it clear?

Thanks,
Miklos
