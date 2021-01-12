Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776232F2B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 10:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbhALJn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 04:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbhALJn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:43:57 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D425C061795
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 01:43:17 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id x26so1121950vsq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 01:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8KTXZZOdpOWwMytCWHlaAOpcUYTe69I04JML7H0hG4=;
        b=GVvuYrEgA9sAgijOBvVQtrkUVxvX21VAJ/HOJKoOCjnLjgbBxuRRFyqyBj6mdoDtwx
         MblZLo0aV0kA3Y5xRg2IHa5TPh/JmmRaIMIXdpimKBRs5i2dMef/d/GKuF+PUPICMiyH
         Q7J7N2L+F36ehIRo0MHvikiW+UHHUtKD0KMzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8KTXZZOdpOWwMytCWHlaAOpcUYTe69I04JML7H0hG4=;
        b=GMqkc/rVBb5r1QgnH4/ZNmaNP8ckP7caebrhM9c8y7r++FCbahDSN2ehGYXywZjvCw
         CI86mDMommEKzyV5GabVLz0AfeEFvGQZknKtpH3D7+2T1LXKF+DzIaZ9B+3i3BLISN4V
         caROUzse5PVefDqJK1oANAUUsu8Jt2IbvQemyo+JzonFqGyUtv+eSgPWeixlPOJDvipD
         Q8XNrsFd6qw4+wVBBWEe1UrXtLm4Qe2duuWyuQKNwF+uZLqx4YiPxci755dTHXXFJ3Ys
         P6Pv5MNJDztJxMttO3C6FTWFWEpn+Q7O81fs2MRzQqcjJ+m8ewmhrfH1nEov3AD2t6ak
         GKFw==
X-Gm-Message-State: AOAM531ikRlaaVoO1eul/2cc/2MY9JKlZlo80jplgfcDmgeck75XYQrh
        6IYLDbmHF/M2XS/ASslepf7buJBXM4P3w0HT/snvgw==
X-Google-Smtp-Source: ABdhPJxpwQa1FNKaf4h67iHm+CypgL2VHALPf8lPbgkbnj8As0D5XiZeWka0RFF9jMbBWHAzsWd0sPyom6NvQtKHvsk=
X-Received: by 2002:a67:fa50:: with SMTP id j16mr2837868vsq.9.1610444596217;
 Tue, 12 Jan 2021 01:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-2-mszeredi@redhat.com>
 <87czyoimqz.fsf@x220.int.ebiederm.org> <20210111134916.GC1236412@miu.piliscsaba.redhat.com>
 <874kjnm2p2.fsf@x220.int.ebiederm.org>
In-Reply-To: <874kjnm2p2.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Jan 2021 10:43:05 +0100
Message-ID: <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:15 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Fri, Jan 01, 2021 at 11:35:16AM -0600, Eric W. Biederman wrote:

> > For one: a v2 fscap is supposed to be equivalent to a v3 fscap with a rootid of
> > zero, right?
>
> Yes.  This assumes that everything is translated into the uids of the
> target filesystem.
>
> > If so, why does cap_inode_getsecurity() treat them differently (v2 fscap
> > succeeding unconditionally while v3 one being either converted to v2, rejected
> > or left as v3 depending on current_user_ns())?
>
> As I understand it v2 fscaps have always succeeded unconditionally.  The
> only case I can see for a v2 fscap might not succeed when read is if the
> filesystem is outside of the initial user namespace.

Looking again, it's rather confusing.  cap_inode_getsecurity()
currently handles the following cases:

v1: -> fails with -EINVAL

v2: -> returns unconverted xattr

v3:
 a) rootid is mapped in the current namespace to non-zero:
     -> convert rootid

 b) rootid owns the current or ancerstor namespace:
     -> convert to v2

 c) rootid is not mapped and is not owner:
     -> return -EOPNOTSUPP -> falls back to unconverted v3

So lets take the example, where a tmpfs is created in a private user
namespace and one file has a v2 cap and the other an equivalent v3 cap
with a zero rootid.  This is the result when looking at it from

1) the namespace of the fs:
---------------------------------------
t = cap_dac_override+eip
tt = cap_dac_override+eip

2) the initial namespace:
---------------------------------------
t = cap_dac_override+eip
tt = cap_dac_override+eip [rootid=1000]

3) an unrelated namespace:
---------------------------------------
t = cap_dac_override+eip
tt = cap_dac_override+eip

Note: in this last case getxattr will actually return a v3 cap with
zero rootid for "tt" which getcap does not display due to being zero.
I could do a setup with a nested namespaces that better demonstrate
the confusing nature of this, but I think this also proves the point.

At this point userspace simply cannot determine whether the returned
cap is in any way valid or not.

The following semantics would make a ton more sense, since getting a
v2 would indicate that rootid is unknown:

- if cap is v2 convert to v3 with zero rootid
- after this, check if rootid needs to be translated, if not return v3
- if yes, try to translate to current ns, if succeeds return translated v3
- if not mappable, return v2

Hmm?

> > Anyway, here's a patch that I think fixes getxattr() layering for
> > security.capability.  Does basically what you suggested.  Slight change of
> > semantics vs. v1 caps, not sure if that is still needed, getxattr()/setxattr()
> > hasn't worked for these since the introduction of v3 in 4.14.
> > Untested.
>
> Taking a look.  The goal of change how these operate is to make it so
> that layered filesystems can just pass through the data if they don't
> want to change anything (even with the user namespaces of the
> filesystems in question are different).
>
> Feedback on the code below:
> - cap_get should be in inode_operations like get_acl and set_acl.

So it's not clear to me why xattr ops are per-sb and acl ops are per-inode.

> - cap_get should return a cpu_vfs_cap_data.
>
>   Which means that only make_kuid is needed when reading the cap from
>   disk.

It also means translating the cap bits back and forth between disk and
cpu endian.  Not a big deal, but...

>   Which means that except for the rootid_owns_currentns check (which
>   needs to happen elsewhere) default_cap_get should be today's
>   get_vfs_cap_from_disk.

That's true.   So what's the deal with v1 caps?  Support was silently
dropped for getxattr/setxattr but remained in get_vfs_caps_from_disk()
(I guess to not break legacy disk images), but maybe it's time to
deprecate v1 caps completely?

> - With the introduction of cap_get I believe commoncap should stop
>   implementing the security_inode_getsecurity hook, and rather have
>   getxattr observe is the file capability xatter and call the new
>   vfs_cap_get then translate to a v2 or v3 cap as appropriate when
>   returning the cap to userspace.

Confused.  vfs_cap_get() is the one the layered filesystem will
recurse with, so it must not translate the cap.   The one to do that
would be __vfs_getxattr(), right?

Thanks,
Miklos
