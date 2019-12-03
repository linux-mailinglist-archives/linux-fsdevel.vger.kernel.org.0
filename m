Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E310F6D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfLCFM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:12:57 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55056 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbfLCFM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:12:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 631728EE180;
        Mon,  2 Dec 2019 21:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575349976;
        bh=IpOZTUY4+3g7VaXxosMa/0FaXgPeCEDiC0Yew7/7PnE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AZ1ual4vte1KqON/lZQs3qiBvpkqwQeA05PKVsWYPIggHILnNaL39Glns5feUKRW+
         yggCSWriolWRUE6x2KQHL4vMXvMcJF0pOBYqWKnGsKa+7k6osiQ6VkJk0yZDQksFxG
         tV3czrKOXo4L4iwn0SfzAhzn4LIMM6m9hP2k9VOo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O4Pj0WFsGk1G; Mon,  2 Dec 2019 21:12:56 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C5E1C8EE11D;
        Mon,  2 Dec 2019 21:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575349976;
        bh=IpOZTUY4+3g7VaXxosMa/0FaXgPeCEDiC0Yew7/7PnE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AZ1ual4vte1KqON/lZQs3qiBvpkqwQeA05PKVsWYPIggHILnNaL39Glns5feUKRW+
         yggCSWriolWRUE6x2KQHL4vMXvMcJF0pOBYqWKnGsKa+7k6osiQ6VkJk0yZDQksFxG
         tV3czrKOXo4L4iwn0SfzAhzn4LIMM6m9hP2k9VOo=
Message-ID: <1575349974.31937.11.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/2] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 02 Dec 2019 21:12:54 -0800
In-Reply-To: <CAOQ4uxiqc_bsa88kZG2PNLPcTqFojJU_24qL32qw-VVLG+rRFw@mail.gmail.com>
References: <1575335637.24227.26.camel@HansenPartnership.com>
         <1575335700.24227.27.camel@HansenPartnership.com>
         <CAOQ4uxiqc_bsa88kZG2PNLPcTqFojJU_24qL32qw-VVLG+rRFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-03 at 06:51 +0200, Amir Goldstein wrote:
> [cc: ebiederman]
> 
> On Tue, Dec 3, 2019 at 3:15 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > This implementation reverse shifts according to the user_ns
> > belonging
> > to the mnt_ns.  So if the vfsmount has the newly introduced flag
> > MNT_SHIFT and the current user_ns is the same as the mount_ns-
> > >user_ns
> > then we shift back using the user_ns before committing to the
> > underlying filesystem.
> > 
> > For example, if a user_ns is created where interior (fake root, uid
> > 0)
> > is mapped to kernel uid 100000 then writes from interior root
> > normally
> > go to the filesystem at the kernel uid.  However, if MNT_SHIFT is
> > set,
> > they will be shifted back to write at uid 0, meaning we can bind
> > mount
> > real image filesystems to user_ns protected faker root.
> > 
> > In essence there are several things which have to be done for this
> > to
> > occur safely.  Firstly for all operations on the filesystem, new
> > credentials have to be installed where fsuid and fsgid are set to
> > the
> > *interior* values. Next all inodes used from the filesystem have to
> > have i_uid and i_gid shifted back to the kernel values and
> > attributes
> > set from user space have to have ia_uid and ia_gid shifted from the
> > kernel values to the interior values.  The capability checks have
> > to
> > be done using ns_capable against the kernel values, but the inode
> > capability checks have to be done against the shifted ids.
> > 
> > Since creating a new credential is a reasonably expensive
> > proposition
> > and we have to shift and unshift many times during path walking, a
> > cached copy of the shifted credential is saved to a newly created
> > place in the task structure.  This serves the dual purpose of
> > allowing
> > us to use a pre-prepared copy of the shifted credentials and also
> > allows us to recognise whenever the shift is actually in effect
> > (the
> > cached shifted credential pointer being equal to the current_cred()
> > pointer).
> > 
> > To get this all to work, we have a check for the vfsmount flag and
> > the
> > user_ns gating a shifting of the credentials over all user space
> > entries to filesystem functions.  In theory the path has to be
> > present
> > everywhere we do this, so we can check the vfsmount
> > flags.  However,
> > for lower level functions we can cheat this path check of vfsmount
> > simply to check whether a shifted credential is in effect or not to
> > gate things like the inode permission check, which means the path
> > doesn't have to be threaded all the way through the permission
> > checking functions.  if the credential is shifted check passes, we
> > can
> > also be sure that the current user_ns is the same as the mnt-
> > >user_ns,
> > so we can use it and thus have no need of the struct mount at the
> > point of the shift.
> > 
> 
> 1. Smart

Heh, thanks.

> 2. Needs serious vetting by Eric (cc'ed)
> 3. A lot of people have been asking me for filtering of "dirent"
> fsnotify events (i.e. create/delete) by path, which is not available
> in those vfs functions, so ifthe concept of current->mnt flies,
> fsnotify is going to want to use it as well.

Just a caveat: current->mnt is used in this patch simply as a tag,
which means it doesn't need to be refcounted.  I think I can prove that
it is absolutely valid if the cred is shifted because the reference is
held by the code that shifted the cred, but it's definitely not valid
except for a tag comparison outside of that.  Thus, if it is useful for
fsnotify, more thought will have to be given to refcounting it.

> 4. This is currently not overlayfs (stacked fs) nor nfsd friendly.
> Those modules do not call the path based vfs APIs, but they do have
> the mnt stored internally.

OK, so I've got to confess that I've only tested it with my container
use case, which doesn't involve overlay or nfs.  However, as long as we
thread path down to the API that nfds and overlayfs use, it should
easily be made compatible with them ... do we have any documentation of
what API this is?

> I suppose you do want to be able to mount overlays and export nfs out
> of those shifted mounts, as they are merely the foundation for
> unprivileged container storage stack. right?

If the plan of doing this as a bind mount holds, then certainly because
any underlying filesystem has to work with it.

> For overlayfs, you should at least look at ovl_override_creds() for
> incorporating shift mount logic - or more likely at the creation of
> ofs->creator_cred.

Well, we had this discussion when I proposed shiftfs as a superblock
based stackable filesytem, I think: the way the shift needs to use
creds is fundamentally different from the way overlayfs uses them.  The
ovl_override_creds is overriding with the creator's creds but the
shifting bind mound needs to backshift through the user namespace
currently in effect.  Since uid shifts can stack, we can make them work
together, but they are fundamentally different things.

James

