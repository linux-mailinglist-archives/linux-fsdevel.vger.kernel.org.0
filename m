Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86C45085A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhKOPdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 10:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKOPcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:05 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4CEC061766
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 07:29:07 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id a129so9336437vkb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dgHzfkVcFAxYDtgQGFlqu5UCBZS7M219M/9rdrkBQo=;
        b=H6zxkiTPSbz547Ci2Q3tsygU1rXKfV8gcamkmydpCHcVKu9aMhLfTPQevaOC5eHne3
         cc/Al+R8Uz0QrSdm92lsBaDw2IfEETpX2HFnDjSHsFOnnVRTWkISli2h3lYY3rnVgug2
         8cTxWqk2vtx22VRjF6bUUb9zoRXEI8ulF4MDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dgHzfkVcFAxYDtgQGFlqu5UCBZS7M219M/9rdrkBQo=;
        b=oQ/G4iby3ymrM2ECWoGUJg06HrNGnBenW52efrDRCJHTLWgLYgV637hlRWau92kcxN
         u2huKRKinNfBMQTSQz/KVf4LFC6pY3Y21TIiX6tG943+W0rIftqUEO4IedK6a9dV4LS7
         1EQSup8VmVQ5QAIhJHmPPFU1S1IqmxuI5ma/IqEy1NE3HUECE2ULmLGBXpN7E5Z6+atQ
         avIkf99lODOueeN/mEyYkSac14tvH/z/iypYdhCzWpoVlp07Q3qbrgwYwZKnPahKlZ4S
         IZ9Dnqg53mNQLOsC6OpWbF13sxVSwKV4Ajj/Z2tFk/Lin8f3JFI+iyP/zU43+dq6aIRY
         b8xQ==
X-Gm-Message-State: AOAM530uQ6LKALrZJoCYY+V97VG6WtOkBw7Fm6+oEs4KAaVhx8txF3iP
        Eslbs83jRsdnWyUMKjWLJsaVV7w/2BwBXI8fr9hRbQ==
X-Google-Smtp-Source: ABdhPJztvJRvXR+fu+ooeldAg2Ig3YPVJsSzb5qU6zqFwAzUbNbZkdOreUSfzDNiB4bpA8dWeYp8kGbeCgTboQmGg4E=
X-Received: by 2002:a05:6122:ca6:: with SMTP id ba38mr61082870vkb.14.1636990146942;
 Mon, 15 Nov 2021 07:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein> <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
In-Reply-To: <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Nov 2021 16:28:55 +0100
Message-ID: <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 13 Nov 2021 at 00:29, Dave Marchevsky <davemarchevsky@fb.com> wrote:

> > If your tracing daemon runs in init_user_ns with CAP_SYS_ADMIN why can't
> > it simply use a helper process/thread to
> > setns(userns_fd/pidfd, CLONE_NEWUSER)
> > to the target userns? This way we don't need to special-case
> > init_user_ns at all.
>
> helper process + setns could work for my usecase. But the fact that there's no
> way to say "I know what I am about to do is potentially stupid and dangerous,
> but I am root so let me do it", without spawning a helper process in this case,
> feels like it'll result in special-case userspace workarounds for anyone doing
> symbolication of backtraces.

Note: any mechanism that grants filesystem access to users that have
higher privileges than the daemon serving the filesystem will
potentially open DoS attacks against the higher privilege task.  This
would be somewhat mitigated if the filesystem is only mounted in a
private mount namespace, but AFAICS that's not guaranteed.

The above obviously applies to your original patch but it also applies
to any other mechanism where the high privilege user doesn't
explicitly acknowledge and accept the consequences.   IOW granting the
exception has to be initiated by the high privleged user.

Thanks,
Miklos



>
> e.g. perf will have to add some logic: "did I fail
> to grab this exe that some process had mapped? Is it in a FUSE mounted by some
> descendant userns? let's fork a helper process..." Not the end of the world,
> but unnecessary complexity nonetheless.
>
> That being said, I agree that this patch's special-casing of init_user_ns is
> hacky. What do you think about a more explicit and general "let me do this
> stupid and dangerous thing" mechanism - perhaps a new struct fuse_conn field
> containing a set of exception userns', populated with ioctl or similar.



>
> >
> >>
> >> Note: I was unsure whether CAP_SYS_ADMIN or CAP_SYS_PTRACE was the best
> >> choice of capability here. Went with the former as it's checked
> >> elsewhere in fs/fuse while CAP_SYS_PTRACE isn't.
> >>
> >>  fs/fuse/dir.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> >> index 0654bfedcbb0..2524eeb0f35d 100644
> >> --- a/fs/fuse/dir.c
> >> +++ b/fs/fuse/dir.c
> >> @@ -1134,7 +1134,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
> >>      const struct cred *cred;
> >>
> >>      if (fc->allow_other)
> >> -            return current_in_userns(fc->user_ns);
> >> +            return current_in_userns(fc->user_ns) || capable(CAP_SYS_ADMIN);
> >>
> >>      cred = current_cred();
> >>      if (uid_eq(cred->euid, fc->user_id) &&
> >> --
> >> 2.30.2
> >>
> >>
>
