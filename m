Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCEA1805E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 19:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCJSKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 14:10:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33412 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCJSKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:10:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id f13so15285889ljp.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAmrLSm94M3atxor6m3MBGNU1T3aJwAms1a60E3OcKQ=;
        b=E4Gh5FebxbswQObtHkMKLa0I1vxP38Xyu9we0WSALKU9brqcmL7dmgK5DPgBi0vtGt
         OCLEcIv+wlGiaPr/aZzGWrh3C2GCorpWLWvzGmTExo1WIkd5cOXbmEz/PNc1Nce2bWNb
         MO1ty0KtN9jj98dselZJN/RU3YxMNgohQiTzVr0ujRZdljdUfPEMa86uPKlKMgmqEjd7
         7puKGvXBmhiuGcL0ITpKvmrRv1gCP6RcvRMvm2Rp5JZUvGM5UjUAdTpQUbo2QI6Pnsj+
         7i7kQRLJXarHpzmGH7INlZlEHEfpWE1zujmaiianXg7IXVsEvq/5l8bcP+9wdmtziTPi
         NK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAmrLSm94M3atxor6m3MBGNU1T3aJwAms1a60E3OcKQ=;
        b=t36DUfRxPqcDqesWzZB+5faLvDPaEOUJ0eIASn8mH8qv2tQAtgHZyqkXWw+aEKn+5L
         UwhceX+jmcbypq+OL5zEmOszJJm/O7+CrxLKrWzwVJJFu+4gEeS4KoiiBwPSzOH1Ucv4
         jYth+gBK//I+8akV69KCGWh6QbeOuIS+1mUbIDPYIpxzzml0MK/bzjqCWYSnOgAJXzYr
         MDmGgNfMtW3vBik8rpyAzyQzqHlQkoTdP/+w5ykGTF0KQcx7zUYoDLbthKVygKKN4w+e
         f08b4cey6Ig0kQntxBqDgJApbmYW8L6zbQdHKSavXHwgbNp/wXZFH0sm32IsRwlkue3J
         SjCg==
X-Gm-Message-State: ANhLgQ3p96oIDYZ1jd4Vik3rpfYoSub/IheY7kzo8CBY9Mwwb2/HqI3q
        Uh5QIiYyQ5OtJBQ80qcZB/HilTumeRRiAjj6m9cj5w==
X-Google-Smtp-Source: ADFU+vv0bRCpZ9upS082ADo1baaiIcsgHRiEr/NQ/XsGlkb1/DnYR7EmtbYbw4Q/00elQBj/MZtk5RGryisNcNPLl5A=
X-Received: by 2002:a2e:800a:: with SMTP id j10mr10367065ljg.23.1583863810659;
 Tue, 10 Mar 2020 11:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200213194157.5877-1-sds@tycho.nsa.gov> <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
 <eb2dbe22-91af-17c6-3dfb-d9ec619a4d7a@schaufler-ca.com> <CAKOZueuus6fVqrKsfNgSYGo-kXJ3f6Mv_NJZStY1Uo934=SjDw@mail.gmail.com>
In-Reply-To: <CAKOZueuus6fVqrKsfNgSYGo-kXJ3f6Mv_NJZStY1Uo934=SjDw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 10 Mar 2020 11:09:34 -0700
Message-ID: <CAKOZuetUvu=maOmHXjCqkHaYEN5Sf+pKBc3BZ+qpy1tE1NJ9xQ@mail.gmail.com>
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Sandeep Patil <sspatil@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        SElinux list <selinux@vger.kernel.org>, kvm@vger.kernel.org,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:50 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Thu, Feb 20, 2020 at 10:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 2/17/2020 4:14 PM, Paul Moore wrote:
> > > On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >> Add support for labeling and controlling access to files attached to anon
> > >> inodes. Introduce extended interfaces for creating such files to permit
> > >> passing a related file as an input to decide how to label the anon
> > >> inode. Define a security hook for initializing the anon inode security
> > >> attributes. Security attributes are either inherited from a related file
> > >> or determined based on some combination of the creating task and policy
> > >> (in the case of SELinux, using type_transition rules).  As an
> > >> example user of the inheritance support, convert kvm to use the new
> > >> interface for passing the related file so that the anon inode can inherit
> > >> the security attributes of /dev/kvm and provide consistent access control
> > >> for subsequent ioctl operations.  Other users of anon inodes, including
> > >> userfaultfd, will default to the transition-based mechanism instead.
> > >>
> > >> Compared to the series in
> > >> https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.com/,
> > >> this approach differs in that it does not require creation of a separate
> > >> anonymous inode for each file (instead storing the per-instance security
> > >> information in the file security blob), it applies labeling and control
> > >> to all users of anonymous inodes rather than requiring opt-in via a new
> > >> flag, it supports labeling based on a related inode if provided,
> > >> it relies on type transitions to compute the label of the anon inode
> > >> when there is no related inode, and it does not require introducing a new
> > >> security class for each user of anonymous inodes.
> > >>
> > >> On the other hand, the approach in this patch does expose the name passed
> > >> by the creator of the anon inode to the policy (an indirect mapping could
> > >> be provided within SELinux if these names aren't considered to be stable),
> > >> requires the definition of type_transition rules to distinguish userfaultfd
> > >> inodes from proc inodes based on type since they share the same class,
> > >> doesn't support denying the creation of anonymous inodes (making the hook
> > >> added by this patch return something other than void is problematic due to
> > >> it being called after the file is already allocated and error handling in
> > >> the callers can't presently account for this scenario and end up calling
> > >> release methods multiple times), and may be more expensive
> > >> (security_transition_sid overhead on each anon inode allocation).
> > >>
> > >> We are primarily posting this RFC patch now so that the two different
> > >> approaches can be concretely compared.  We anticipate a hybrid of the
> > >> two approaches being the likely outcome in the end.  In particular
> > >> if support for allocating a separate inode for each of these files
> > >> is acceptable, then we would favor storing the security information
> > >> in the inode security blob and using it instead of the file security
> > >> blob.
> > > Bringing this back up in hopes of attracting some attention from the
> > > fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
> > > perspective we would prefer to attach the security blob to the inode
> > > as opposed to the file struct; does anyone have any objections to
> > > that?
> >
> > Sorry for the delay - been sick the past few days.
> >
> > I agree that the inode is a better place than the file for information
> > about the inode. This is especially true for Smack, which uses
> > multiple extended attributes in some cases. I don't believe that any
> > except the access label will be relevant to anonymous inodes, but
> > I can imagine security modules with policies that would.
> >
> > I am always an advocate of full xattr support. It goes a long
> > way in reducing the number and complexity of special case interfaces.
>
> It sounds like we have broad consensus on using the inode to hold
> security information, implying that anon_inodes should create new
> inodes. Do any of the VFS people want to object?

Ping?
