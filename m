Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA6E31CCB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhBPPMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 10:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBPPMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:12:13 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBCC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 07:11:32 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id o186so5048254vso.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkpfzd4aYSlLQT9wHF53AZoEikZ81xJA6Jh0FUGLl58=;
        b=in8FJsq9M/08Gi+KYE9en1xmf52ShDXnTfNlyqBKVHuIgUzZrEjssCvLHi7SQgkurR
         Deh59jNn233u0zhuj4LBUT/13GFXCL39JlPuUIro6D2SuBeleeAwjaMmWEDqwvPS5Sgb
         mxreSaiDrsrpJO5MN9k/OYAJGc97lq07oPbGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkpfzd4aYSlLQT9wHF53AZoEikZ81xJA6Jh0FUGLl58=;
        b=oxO/um5MgbkmRmDpcaLrWqezUKk9DChuKLidIzDmcKXwjVxrVbpbh/6EfYPycfmOOt
         nFmqVkSMlqj9H1pojtNPkk52HGnYH8JlsLRgCLs7vM2WuhDrV+Cuvc52rYD+PY5CvYyO
         ObPheckdv+Q0x/wZmr3/m4qmXaMd179dbQPZk5dkpgXP015m4BbK8y6nhW+N8Hg8bK5z
         4SrK5BpKPCMPdOh6a22vSxmg8sflaN73GduTLf0YN2qk43e6MWY5LS7FrSuoyfTdPoje
         m/DGZqYv1uvSxpJlVeXRho9qAi6gjJLJvhLEePKCkEsjawrStLq111okn85S8+0323vH
         R2yA==
X-Gm-Message-State: AOAM5308t45VSsrNJJQe9gWW0SLY7fh7QZdd/6khxxxjq4USATyC2/xZ
        D29h62qDH+uvCXsT+GBfHA0IapqcQj0CXV6xJKX2Hw==
X-Google-Smtp-Source: ABdhPJz8XHYLl9xWxE9FW2sw/LYweHxQ10eZ1m42HxvwDt0dPvQON4VFcmEsfuo30e0nQtCAGB3mPMVishAxQUXRepg=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr11216338vso.47.1613488291562;
 Tue, 16 Feb 2021 07:11:31 -0800 (PST)
MIME-Version: 1.0
References: <87r1llk28a.fsf@suse.de> <20210215205221.GB3331@redhat.com>
In-Reply-To: <20210215205221.GB3331@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 Feb 2021 16:11:20 +0100
Message-ID: <CAJfpegsEa6ZCXBFUpER6Fiagp3TEpxa82qBo0a4NydjC3ucnTw@mail.gmail.com>
Subject: Re: [Virtio-fs] Question on ACLs support in virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 9:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Feb 12, 2021 at 10:30:13AM +0000, Luis Henriques wrote:
> > Hi!
> >
> > I've recently executed the generic fstests on virtiofs and decided to have
> > a closer look at generic/099 failure.  In a nutshell, here's the sequence
> > of commands that reproduce that failure:
> >
> > # umask 0
> > # mkdir acldir
> > # chacl -b "u::rwx,g::rwx,o::rwx" "u::r-x,g::r--,o::---" acldir
> > # touch acldir/file1
> > # umask 722
> > # touch acldir/file2
> > # ls -l acldir
> > total 0
> > -r--r----- 1 root root 0 Feb 12 10:04 file1
> > ----r----- 1 root root 0 Feb 12 10:05 file2
> >
> > The failure is that setting umask to 722 shouldn't affect the new file2
> > because acldir has a default ACL (from umask(2): "... if the parent
> > directory has a default ACL (see acl(5)), the umask is ignored...").
> >
> > So... I tried to have look at the code, and initially I thought that the
> > problem was in (kernel) function fuse_create_open(), where we have this:
> >
> >       if (!fm->fc->dont_mask)
> >               mode &= ~current_umask();
> >
> > but then I went down the rabbit hole, into the user-space code, and
> > couldn't reach a conclusion.  Maybe the issue is that there's in fact no
> > support for this POSIX ACLs in virtiofs/FUSE?  Any ideas?
>
> Hi,
>
> [ CC Miklos and linux-fsdevel ]
>
> I debugged into this a little. There are many knobs and it is little
> confusing that what are right set of fixes.
>
> So what's happening in this case is that fc->dont_mask is not set. That
> means fuse client is modifying mode using umask. First time you
> touch file, umask is 0, so there is no modification. But next time,
> you set umask to 722, and fuse modifies mode before sending file
> create request to server. virtiofs server is already running with
> umask 0, so it does not touch the mode.
>
> So that means, that in case of default acl, fuse client should not
> be modifying mode using umask. But question is when should fuse
> skip applying umask.
>
> I see that fuse always sets SB_POSIXACL. That means VFS is not
> going to apply umask and all the umask handling is with-in fuse.
>
> sb->s_flags |= SB_POSIXACL;
>
> Currently fuse sets fc->dont_mask in two conditions.
>
> - If the caller mounted with flag MS_POSIXACL, then fc->dont_mask is set.
> - If fuse server opted in for option FUSE_DONT_MASK, then fc->dont_mask
>   is set.
>
> I see that for virtiofs, both the conditions are not true out of the
> box. In fact looks like ACL support is not fully enabled, because
> I don't see fuse server opting in for FUSE_POSIX_ACL.
>
> I suspect that we probably should provide an option in virtiofsd to
> enable/disable acl support.

Sounds good.

> Setting FUSE_DONT_MASK is tricky. If we leave it to fuse, that means
> fuse will have to query acl to figure out if default acl is set or
> not on parent dir. And that data could be stale and there could be
> races w.r.t setting acls from other client.
>
> If we do set FUSE_DONT_MASK, that means in file creation path virtiofsd
> server will have to switch its umask to one provided in request. Given
> its a per process property, we will have to have some locks to make
> sure other create requests are not progressing in parallel. And that
> hope host does the right thing. That is apply umask if parent dir does
> not have default acl otherwise apply umask (as set by virtiofsd process).
>
> Miklos, does above sound reasonable. You might have more thoughts on
> how to handle this best in fuse/virtiofs.

fv_queue_worker() does unshare(CLONE_FS) for the fchdir() call in
xattr ops, which means that umask is now a per-thread propery in
virtiofsd.

So setting umask before create ops sounds like a good solution.

Thanks,
Miklos

>
> Vivek
>
