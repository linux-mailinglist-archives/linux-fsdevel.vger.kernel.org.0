Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E45130954
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAERom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 12:44:42 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35116 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgAERom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 12:44:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F8368EE148;
        Sun,  5 Jan 2020 09:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578246281;
        bh=pfDZPxMteXgYQcTMRFiEL1bOy+FJZWdBqlqd4YdUZJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G3HAO4A9vSrZgFlbEn1Q5WTQZ6scOx8tvt3QMdOCGTOUKViD7GmCdniPB1MEU1sG5
         veUbIO56gPULqC5icox4wXfiBAgBq2C6JJEz7itzztdRpi42YGW5GJrWaGbCHAP16/
         BOIptH3X+izrhV7XMWp6mby/FsyqG1cHer4OZL7k=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wq06jtlsziun; Sun,  5 Jan 2020 09:44:40 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 305C28EE0D2;
        Sun,  5 Jan 2020 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578246280;
        bh=pfDZPxMteXgYQcTMRFiEL1bOy+FJZWdBqlqd4YdUZJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kK3uw9D5yvu0zqd/1xCNfdpQO79i3XbsNW7x4e8N9VSbl4+qCouUsuYgibpthx9TT
         jfwLf/NzLyHbttJmExepVPehNkTSWr1j9Q3qwm8zqNIvYoXe9NVOsPGvJRVgu+CtAb
         DSZqhRsJjtDUKLnl+3/JKMQKkyVVfdZIxoafoBbg=
Message-ID: <1578246278.3310.26.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        =?ISO-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Date:   Sun, 05 Jan 2020 09:44:38 -0800
In-Reply-To: <CAOQ4uxiMJePVaXFiLw88rnr4qxCPN0dLQcXq_KCC831hZzM7rA@mail.gmail.com>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
         <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
         <CAOQ4uxiMJePVaXFiLw88rnr4qxCPN0dLQcXq_KCC831hZzM7rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-01-05 at 01:09 +0200, Amir Goldstein wrote:
> On Sat, Jan 4, 2020 at 10:41 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > This implementation reverse shifts according to the user_ns
> > belonging to the mnt_ns.  So if the vfsmount has the newly
> > introduced flag MNT_SHIFT and the current user_ns is the same as
> > the mount_ns->user_ns then we shift back using the user_ns before
> > committing to the underlying filesystem.
> > 
> > For example, if a user_ns is created where interior (fake root, uid
> > 0) is mapped to kernel uid 100000 then writes from interior root
> > normally go to the filesystem at the kernel uid.  However, if
> > MNT_SHIFT is set, they will be shifted back to write at uid 0,
> > meaning we can bind mount real image filesystems to user_ns
> > protected faker root.
> > 
> > In essence there are several things which have to be done for this
> > to occur safely.  Firstly for all operations on the filesystem, new
> > credentials have to be installed where fsuid and fsgid are set to
> > the *interior* values.
> 
> Must we really install new creds?

Well, the reason for doing it is that for uid/gid changes that's the
way everything else does it, so principle of least surprise.

However, there are two other cases where this doesn't work:

   1. inode uid/gid changes, which are compared against the real uid/gid 
   2. execution, where we need to bring the filesystem uid/gid to the
      exterior representation of the interior values for unprivileged
      execution to work.
   3. the capable_wrt_inode checks where we're usually checking if the
      inode uid/gid has an interior mapping, but since for shiftfs we're
      assuming inode uid/gid are interior we need to see if anything maps
      to them.
   4. the in_group_p checks to see whether we're in a group that's
      capable.

1. could be fixed by shifting uid/gid ... I just didn't think this was
a good idea.  2,3. can't be fixed because the direction of the check
needs to be reversed and 4 has to be done separately because group_info
 is a pointer to something that lives outside the credential.  Taking
the pointer, creating a new one and shifting every group is possible, I
just also wasn't sure if it was a wise thing to do.

> Maybe we just need to set/clear a SHIFTED flag on current creds?
> 
> i.e. instead of change_userns_creds(path)/revert_userns_creds()
> how about start_shifted_creds(mnt)/end_shifted_creds().
> 
> and then cred_is_shifted() only checks the flag and no need for
> all the cached creds mechanism.
> 
> current_fsuid()/current_fsgid() will take care of the shifting based
> on the creds flag.

So it is true, if current_fsuid/fsgid did the mapping, it would be a
fifth case above, but we'd have to be sure no-one ever used the bare
current_cred()->fsuid.  Auditing filesystems, it looks like there's
only one current case of this in namei.c:may_follow_link(), so I think
it could work ... but it's still a danger for other places, like
security module checks and things.

> Also, you should consider placing a call to start_shifted/end_shifted
> inside __mnt_want_write()/__mnt_drop_write().
> This should automatically cover all writable fs ops  - including some
> that you missed (setxattr).

xattr handling wasn't really missed, I left it out because it was the
controversial case last time.  Should the interior root be able to set
xattrs?  I think the argument was tending towards the yes except
security. prefix ones last time so perhaps it is safe to reintroduce.

> Taking this a step further, perhaps it would make sense to wrap all
> readonly fs ops with mnt_want_read()/mnt_drop_read() flavors.
> Note that inode level already has a similar i_readcount access
> counter.

Unfortunately, read and write aren't the only operations where we need
a shift, there's also lookup (which doesn't require read or write). 
Now we could also go with mnt_want_lookup/mnt_drop_lookup or simply
keep the existing shift coding on the lookup path.

> This could be used, for example, to provide a facility that is
> stronger than MNT_DETACH, and weaker than filesystem "shutdown"
> ioctl, for blocking new file opens (with openat()) on a mounted
> filesystem.
> 
> The point is, you add gating to vfs that is generic and not for
> single use case (i.e. cred shifting).
> 
> Apologies in advance if  some of these ideas are ill advised.

Of the two ideas, I think using a generic gate point, if we can find
it, is a definite winner because it programmatically identifies the
shift points.  I'm less enthused about moving the shift into
current_fsuid/fsgid because of the potential for stuff to go wrong and
because it's counter to how everything else is currently done, but I'll
let the filesystem experts weigh in on this one.  The good news is that
the two ideas aren't dependent on each other so either can be
implemented without the other.

James

