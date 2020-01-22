Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D550144C24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 07:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAVG5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 01:57:14 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:46165 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVG5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:57:13 -0500
Received: by mail-il1-f174.google.com with SMTP id t17so4347453ilm.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 22:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQKYih1RVrRUeW5moP9UR07Sqr5PJtHrjlo0D7q4oWI=;
        b=GqUxzNZO9MpCMP24ml+rX4mrgt3aKesiCbq0SMvItp4rgbQGQFLjCASSJ1AF3cWtOn
         +cY9a7EW8gd2IRCcxMma666O1plTPXBnsG8uA10sPQypN15drxr69yR4HX8nTtsCRBJ+
         OD4+Sj65StOWvywhYlSM6glW8+JkHpAW4xCyxObB29y+lrctYtvyNCgSmiqQK6/eMtbL
         cCZwujP5IVdfcZjW3Vso72vuJm8VM8vNEBM2O0izfamZvwDafu2fc4eieFVYXY/Cz+9U
         OVD/dFCiL9xgEKg07W7URh7Q0cXONDrDk5ZBJ6sT5FEz/4nDj12x+qJaE+t8ErcUJ2x4
         36Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQKYih1RVrRUeW5moP9UR07Sqr5PJtHrjlo0D7q4oWI=;
        b=Dt9Ut8764Pr4QbsTNnTagtVP2TKLnQ9SlWcUtD5nWhqRjXsyUs8+YrpXJ3BJzP4AUh
         3u8Y1u6iqU7rJSw2VvEHKJYAO4iASMToYkQ+6Mlf8oWwdRRwBe6nAoU3EW9t7jxTmesy
         TZSlqA8gKU7h7JYLbH1SfbVHg2U91jt8g94Kpn6fFkiCzuupLwa+vH5IY5OlVtZi3RGI
         XznY6giLGU/emwmE2Vq9k8BkP6HeH7C+oNIxwmaqzZwjSZhqFWQwEpLXrGpaCguPnvxs
         LZRgafqK/aI3ddtx0i0HrtVHR1MWEGN6RD1+Wfcwnkrmsw9KKFtsRYbJWZyxTYZ8fzgh
         uBQA==
X-Gm-Message-State: APjAAAUvUOdWJnA+mFtILam5yQ98w2OAnFenwHATH80r8XZr8OaGeiF/
        ztpVhkLp62gv8NhFeH7fXHUI9ZS1VSBFYFgcev8=
X-Google-Smtp-Source: APXvYqxjKwb7fOvS9U6mNGwgptP+GScDlMWz1ws3M6Xd6eGqwM78O45+RogeCEo644qKUnhKNPeaM18xly+SfbDjyFQ=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr7182543ilh.9.1579676232672;
 Tue, 21 Jan 2020 22:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20200117163616.GA282555@vader> <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader> <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader> <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader> <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader> <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader>
In-Reply-To: <20200121230521.GA394361@vader>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Jan 2020 08:57:01 +0200
Message-ID: <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 1:05 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Sat, Jan 18, 2020 at 02:20:32AM +0000, Al Viro wrote:
> > On Fri, Jan 17, 2020 at 05:17:34PM -0800, Omar Sandoval wrote:
> > > > No.  This is completely wrong; just make it ->link_replace() and be done
> > > > with that; no extra arguments and *always* the same conditions wrt
> > > > positive/negative.  One of the reasons why ->rename() tends to be
> > > > ugly (and a source of quite a few bugs over years) are those "if
> > > > target is positive/if target is negative" scattered over the instances.
> > > >
> > > > Make the choice conditional upon the positivity of target.
> > >
> > > Yup, you already convinced me that ->link_replace() is better in your
> > > last email.
> >
> > FWIW, that might be not so simple ;-/  Reason: NFS-like stuff.  Client
> > sees a negative in cache; the problem is how to decide whether to
> > tell the server "OK, I want normal link()" vs. "if it turns out that
> > someone has created it by the time you see the request, give do
> > a replacing link".  Sure, if could treat ->link() telling you -EEXIST
> > as "OK, repeat it with ->link_replace(), then", but that's an extra
> > roundtrip...
>
> So that's a point in favor of ->link(). But then if we overload ->link()
> instead of adding ->link_replace() and we want EOPNOTSUPP to fail fast,
> we need to add something like FMODE_SUPPORTS_AT_REPLACE.
>
> Some options I see are:
>
> 1. Go with ->link_replace() until network filesystem specs support
>    AT_REPLACE. That would be a bit of a mess down the line, though.
> 2. Stick with ->link(), let the filesystem implementations deal with the
>    positive targets, and add FMODE_SUPPORTS_AT_REPLACE so that feature
>    detection remains easy for userspace.

"detection remains easy..." why is this important?
Do you know of a userspace application that would have a problem checking
if AT_REPLACE works, fall back to whatever and never try it ever again?
Besides, when said application tried to open an O_TMPFILE and fail, it
will have already detected a lot of the unsupported cases.
Sorry for not reading all the thread again, some API questions:
- We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
- Does AT_REPLACE assert that destination is positive? and if so why?
The functionality that is complement to atomic rename would be atomic
link, destination could be positive or negative, but end results will be
that destination is positive with new inode.
With those semantics, ->link_replace() makes much less sense IMO.

> 3. Option 2, but don't bother with FMODE_SUPPORTS_AT_REPLACE.
>
> FWIW, there is precendent for option 3: RENAME_EXCHANGE. That has the
> same "files are the same" noop condition, and we don't know whether
> RENAME_EXCHANGE is supported until ->rename(). A cursory search shows
> that applications using RENAME_EXCHANGE try it and fall back to a
> non-atomic exchange on EINVAL. They could do the exact same thing for
> AT_REPLACE.
>

That sounds like the most reasonable approach to me. Let's not over complicate.
If you find that creates too much generic logic in ->link(), you can take
the approach Darrick employed with generic_remap_file_range_prep() for
filesystems that want to support AT_REPLACE. All other fs just need to check
for valid flags mask, like the ->rename() precedent.

Another side discussion about passing AT_ flags down to filesystems.
Traditionally, that was never done, until AT_STATX_ mixed vfs flags
with filesystem flags on the same AT_ namespace.
Now we have linkat() syscall that can take only AT_ vfs flags and
renameat2() syscall that can take only RENAME_ filesystem flags not
from the AT_ namespace.
I feel that the situation of having AT_REPLACE API along with
RENAME_EXCHANGE and RENAME_NOREPLACE is a bit awkward
and some standardization is in order.

According to include/uapi/linux/fcntl.h, there is no numeric collision
between the RENAME_ flag namepsace and AT_ flags namespace,
although I do find it suspicious that AT_ flags start at 0x100...
Could we define AT_RENAME_xxx RENAME_xxx flags and name the
new flag AT_LINK_REPLACE, so it is a bit more clear that the flag
is specific to link(2) syscall and not vfs generic AT_ flag.

Thanks,
Amir.
