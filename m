Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407A0184C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMQdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 12:33:14 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:46679 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:33:14 -0400
Received: by mail-ua1-f51.google.com with SMTP id b2so3744739uas.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02lwFBCLBcb4bzvU/oIWzhKPfBjQLcn82ZsnxwE2cWA=;
        b=KE7MohrwsXcWc+ugG2vXw416yi53NBTu1mN+sgRnlmsoSa1m5XWNGRMi05YVqhU+7X
         fLlKN/XYUPPONpc0UgOJ5NpxrGP7uTml9+QXjkk90pC5iAYsZsCDkAYdPRZY6AyPtRJ1
         RvFSLK/0nWSHeg/mkshyl7lYQVB4SOVQgBiq62kkTnBsu8eE9cJKkiAXI1MJCFf9sAlu
         yrw4TPQhbTyKO+feddsbrEcc4w3K8rT2R5CUgE+877QCYp0dqpDTPsJSdM+m2vUIi97V
         /OHCQpEwnGrmjPNrDBXPy/riC/VO4+w4ZnimIRci6/DaagzFHJIYZ2NB4cwsq4O4lVBS
         7qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02lwFBCLBcb4bzvU/oIWzhKPfBjQLcn82ZsnxwE2cWA=;
        b=clVTnWCUdfWobGMJYk6BC5DAbbph5QYk3hHmOX005uelzx8pKTijMte+9jXMwDN95P
         Q8662Mf/vkqN+jJ5xPP8CTw6iITjjE0g3iY3r/kjgA+jGt3bBVJ/Hj7qvpvGLIPlwQpB
         acJB8UVsSHZv/2WLWXC4s5LT9g0KCmW5MCdpyeVOYsDW5rgd2J3mEcYM8af3VMZOgaol
         9Rtj7nXtTTA+ZsmdkTBccCc8TGR65kDBU7P7JUjVqiR3oR7mSVkfmvFDQDoLLu6i1bCz
         xtEXqLb2HI0UrzeR0yDXTPG5vBM2ilM1/JVT9GrFgRC+KXXIkckTXAT194CMpG+NlELC
         lETA==
X-Gm-Message-State: ANhLgQ0W5GykFee4IDwwwuSsVW/9UHdHIu0o217XDrIKvt/q/udX0MKf
        08Hi3Uw0PC/SexXREXDFJalqo2wwngXtTWYBqR/n05e+5+sLuQ==
X-Google-Smtp-Source: ADFU+vupr5E63XsCaYXo8W5nb6d5fgOuV1xz0DHCr+5ZkFvki3Op9d+JYWFsGIBTOcaAI/TqU7tX11SdXRCzDMOlHuE=
X-Received: by 2002:ab0:758b:: with SMTP id q11mr9002341uap.12.1584117191479;
 Fri, 13 Mar 2020 09:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200201005639.GG23230@ZenIV.linux.org.uk>
In-Reply-To: <20200201005639.GG23230@ZenIV.linux.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 13 Mar 2020 12:33:00 -0400
Message-ID: <CAOg9mSTwD1HxU=autqFDan_dSCaPOMBed-SuzW=kYjGRjKuyXA@mail.gmail.com>
Subject: Re: [confused] can orangefs ACLs be removed at all?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been away from this for a while, but have been working on it
now for several days... by working on it, I mean I've been reading
the code back into fs and forward into the userspace part of orangefs,
and comparing what orangefs does with what ext4 and tmpfs do when I
set and unset acls...

I can observe that these acls are foldable into mode,
no acls are set, this asdf file is on ext4:

hubcap@vm1 ~]$ ls -l asdf
-rw-rw----. 1 hubcap hubcap 0 Mar  6 15:34 asdf
[hubcap@vm1 ~]$ setfacl -m u::rwx asdf
[hubcap@vm1 ~]$ ls -l asdf
-rwxrw----. 1 hubcap hubcap 0 Mar  6 15:34 asdf
[hubcap@vm1 ~]$ setfacl -m g::rwx asdf
[hubcap@vm1 ~]$ ls -l asdf
-rwxrwx---. 1 hubcap hubcap 0 Mar  6 15:34 asdf
[hubcap@vm1 ~]$ setfacl -m o::rwx asdf
[hubcap@vm1 ~]$ ls -l asdf
-rwxrwxrwx. 1 hubcap hubcap 0 Mar  6 15:34 asdf

There must be more, perhaps from the perspective of
root setting the acl, or...? What are some other
examples of acls that get folded into mode that I
could test with?

Al>> Moreover, if you change an existing ACL to something
Al>> that is expressible by pure mode,

Can you suggest an example here, too?

Finally (for today :-) ) what happened here? Orangefs
reacts differently than ext4... in both cases the acl
was set, but on ext4 the mode was also
changed...

hubcap@vm1 ~]$ touch /pvfsmnt/asdf /home/hubcap/asdf
[hubcap@vm1 ~]$ ls -l /pvfsmnt/asdf /home/hubcap/asdf
-rw-rw-r--. 1 hubcap hubcap 0 Mar 13 11:50 /home/hubcap/asdf
-rw-rw-r--. 1 hubcap hubcap 0 Mar 13 11:50 /pvfsmnt/asdf

root@vm1 hubcap]# chown root /home/hubcap/asdf /pvfsmnt/asdf
[root@vm1 hubcap]# ls -l /home/hubcap/asdf /pvfsmnt/asdf
-rw-rw-r--. 1 root hubcap 0 Mar 13 11:50 /home/hubcap/asdf
-rw-rw-r--. 1 root hubcap 0 Mar 13 11:50 /pvfsmnt/asdf
[root@vm1 hubcap]# setfacl -m u:hubcap:rwx /home/hubcap/asdf /pvfsmnt/asdf
[root@vm1 hubcap]# ls -l /home/hubcap/asdf /pvfsmnt/asdf
-rw-rwxr--+ 1 root hubcap 0 Mar 13 11:50 /home/hubcap/asdf
-rw-rw-r--+ 1 root hubcap 0 Mar 13 11:50 /pvfsmnt/asdf

-Mike

On Fri, Jan 31, 2020 at 7:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Prior to 4bef69000d93 (orangefs: react properly to
> posix_acl_update_mode's aftermath.) it used to be possible
> to do orangefs_set_acl(inode, NULL, ACL_TYPE_ACCESS) -
> it would've removed the corresponding xattr and that would
> be it.  Now it fails with -EINVAL without having done
> anything.  How is one supposed to remove ACLs there?
>
>         Moreover, if you change an existing ACL to something
> that is expressible by pure mode, you end up calling
> __orangefs_setattr(), which will call posix_acl_chmod().
> And AFAICS that will happen with *old* ACL still cached,
> so you'll get ACL_MASK/ACL_OTHER updated in the old ACL.
>
>         How can that possibly work?  Sure, you want to
> propagate the updated mode to server - after you've
> done the actual update (possibly removal) of ACL-encoding
> xattr there...
