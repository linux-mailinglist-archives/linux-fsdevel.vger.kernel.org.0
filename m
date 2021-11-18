Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170EA4558EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 11:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244770AbhKRKY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 05:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbhKRKX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:23:26 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B085C061570;
        Thu, 18 Nov 2021 02:20:26 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e144so7241138iof.3;
        Thu, 18 Nov 2021 02:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itCVI2ENrhkTTYHps6m3XQ5oUYvCnNOBSzEcX1dRLm4=;
        b=Dfmb6C0k8WZPBVmY/ibFGC9rxZ8Lhy/SquLt0Xv9ML0bvrlyblnx0IRCmS7VXCwSWF
         15jAMM45IjpeyO/OR4aFw2sBHxN4+6BZkLlr+TXB9zXFrFYdsi8Kt06cBlaqUQSIdJlC
         Yn7uSyCD2rHKVyxC0tut7kil37wW8m9Ca/5kPpsMd/Kzf8MJP3sJqtazQU3ovX+muOmH
         jcTRqAgCMqO6F72HLARp4oCvnzzrJDHbyJt+3cbR1WRfiY72/19/jIGSNU1Jnwn8RyXi
         E585sJ2ZIEa2PncDfKNtXisgSaBz0PxJ5MwdFnvnwHiKQtFIAVnWsH65G0fc4N68QzD3
         +zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itCVI2ENrhkTTYHps6m3XQ5oUYvCnNOBSzEcX1dRLm4=;
        b=K95j6+Ogx3IsNIzdtp3vFauJOVMKqjHtJOsZDu0qYXwQRH0Ol6TG1jTwrPHK6FSkaC
         NJ05bIwjgIEVewMmM6QTz8DDUGAwkPxqK5rdlFqa00JLnMPqFgmlm197xUovB2RXC71j
         AUs6HVavv3jaqYhKwCccbtxgjUg7Bhu7VDqawjN7oI2xS6CpHyP7XRLV91E4IM/ZlCtt
         ODcmf+ZGyU+iH9YrvbPCi1gD+j8e62sxLIqArHMuN5gkInqZj74mLOvSmdAmItNIgKVG
         b2JPLM81WVCWnYgIdUG/V9Wr4EAfUkaVyZ97oKLnSt3Xh4jHIc/ql5mCD/ruiccVEgSN
         FHXQ==
X-Gm-Message-State: AOAM5314RQ3OevGeCYea7RJBX/Qgcf7eNSqZSS924o7X6JPPI83F+ZyK
        lQMxg9UkEovLj+wjqZK1T7r2iQhaXhwmvc+R3i0=
X-Google-Smtp-Source: ABdhPJyQnM3LkZ5uLvVCdeDBR0vhPZV82yI4Jj+q18fa+DAtlhzwEUs8WdW+WEH39xQX7jtO0ruQA6/9ugBzYLOm0yk=
X-Received: by 2002:a05:6638:2727:: with SMTP id m39mr19361551jav.75.1637230825580;
 Thu, 18 Nov 2021 02:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <CA+FmFJBDwt52Z-dVGfuUcnRMiMtGPhK4cCQJ=J_fg0r3x-b6ng@mail.gmail.com>
In-Reply-To: <CA+FmFJBDwt52Z-dVGfuUcnRMiMtGPhK4cCQJ=J_fg0r3x-b6ng@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Nov 2021 12:20:14 +0200
Message-ID: <CAOQ4uxjTRfwGrXuWjACZyEQTozxUHTabJsN7yH5wCJcAapm-6g@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     David Anderson <dvander@google.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 11:53 AM David Anderson <dvander@google.com> wrote:
>
> On Tue, Nov 16, 2021 at 11:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > Hi David,
> >
> > I see that the patch set has changed hands (presumably to Android upstreaming
> > team), but you just rebased v18 without addressing the maintainers concerns [1].
>
> Indeed I'm carrying this forward as Mark is no longer working on it.
> My apologies for
> missing those comments!
>
> > Specifically, the patch 2/4 is very wrong for unprivileged mount and
> > I think that the very noisy patch 1/4 could be completely avoided:
> > Can't you use -o userxattr mount option for Android use case and limit
> > the manipulation of user.ovrelay.* xattr based on sepolicy for actors
> > that are allowed
> > to make changes in overlayfs mount? or not limit at all?
> > The access to those xattr is forbidden via "incoming" xattr ops on
> > overlay inodes.
>
> Can you clarify a bit more? The patch is definitely super noisy and I'd love
> to have a better solution. The problem it's trying to solve is:
>  1. Kernel-privileged init mounts /mnt/blah-lower and /mnt/blah-upper.
>  2. Kernel-privileged init mounts /blah with overlayfs using the above dirs.
>  2. Kernel-privileged init loads sepolicy off /blah/policy. Enforcing begins.
>  3. Kernel-privileged init tries to execute /blah/init to initiate a
> domain transition.
>  4. exec() fails because the overlayfs mounter creds (kernel domain) does
>      not have getxattr permission to /blah/init.
>
> Eg, we're hitting this problem without even making changes to the mount, and
> without anything being written to /mnt/blah-upper.
>

So what is your solution?
Remove the security check from overlayfs setting xattr?
How does that work for the person who composed the security policy?
You will need to grant some basic privileges to the mounter.
If you do not want to grant the mounter privileges to set trusted.overlay xattr
you may use mount option -o userxattr and grant it permissions to set
user.overlay xattrs.

> > Can an unprivileged user create an overlay over a directory that they have
> > access to and redirect an innocent looking file name to an underlying file that
> > said the mounting user has no access to and by doing that, tricking a privileged
> > user to modify the innocent looking file on the  mounter's behalf?
> > Of course this could be avoided by forbidding unprivileged mount with
> > override_creds=off, but there could be other scenarios, so a clear model
> > would help to understand the risks.
> >
> > For example:
> > If user 1 was able to read in lower dir A, now the content of overlay dir A
> > is cached and user 2, that has permissions to read upper dir A and does
> > not have read permissions on lower dir A will see the content of lower dir A.
>
> I'll need to think about this more and test to verify. It's not a scenario that
> would come up in our use case (both dirs effectively have the same permissions).
>

Your argument is taking the wrong POV.
The reason that previous posts of this patch set have been rejected
is not because it doesn't work for your use case.
It is because other players can exploit the feature to bypass security
policies, so the feature cannot be merged as is.

> If the answer is "yes, that can happen" - do you see this as a problem of
> clarifying the model, or a problem of fixing that loophole?
>

It is something that is not at all easy to fix.
In the example above, instead of checking permissions against the
overlay inode (on "incoming" readdir) will need to check permissions of every
accessing user against all layers, before allowing access to the merged
directory content (which is cached).
A lot more work - and this is just for this one example.

> >> I think that the core problem with the approach is using Non-uniform
> > credentials to access underlying layers. I don't see a simple way around
> > a big audit that checks all those cases, but maybe I'm missing some quick
> > shortcut or maybe your use case can add some restrictions about the
> > users that could access this overlay that would simplify the generic problem.
>
> In a security model like ours, I think there's no way around it, that
> we really need
> accesses to be from the caller's credentials and not the mounter's. It's even
> worse than earlier iterations of this patch perhaps let on: we mount
> before sepolicy
> is loaded (so we can overlay the policy itself), and thus the
> mounter's creds are
> effectively "the kernel". This domain is highly restricted in our
> sepolicy for obvious
> reasons. There's no way our security team will let us unrestrict it.
>

Not sure what that means or what I can do with this information.
If I had a simple suggestion on how to solve your problem I would have
suggested it, but I cannot think of any right now.
The best I can do is to try to make you understand the problems that your
patch causes to others, so you can figure out a way that meets your goals
without breaking other use cases.

Thanks,
Amir.
