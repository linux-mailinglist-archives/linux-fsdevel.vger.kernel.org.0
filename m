Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3652538C48C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 12:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhEUKZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 06:25:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232470AbhEUKZm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 06:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 875F4AACA;
        Fri, 21 May 2021 10:24:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B9CF1F2C73; Fri, 21 May 2021 12:24:18 +0200 (CEST)
Date:   Fri, 21 May 2021 12:24:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 5/5] fanotify: Add pidfd info record support to the
 fanotify API
Message-ID: <20210521102418.GF18952@quack2.suse.cz>
References: <cover.1621473846.git.repnop@google.com>
 <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein>
 <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
 <YKd7tqiVd9ny6+oD@google.com>
 <CAOQ4uxi6LceN+ETbF6XbbBqfAY3H+K5ZMuky1L-gh_g53TEN1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi6LceN+ETbF6XbbBqfAY3H+K5ZMuky1L-gh_g53TEN1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-05-21 12:41:51, Amir Goldstein wrote:
> On Fri, May 21, 2021 at 12:22 PM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Hey Amir/Christian,
> >
> > On Thu, May 20, 2021 at 04:43:48PM +0300, Amir Goldstein wrote:
> > > On Thu, May 20, 2021 at 11:17 AM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > > > +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > > > > +     sizeof(struct fanotify_event_info_pidfd)
> > > > >
> > > > >  static int fanotify_fid_info_len(int fh_len, int name_len)
> > > > >  {
> > > > > @@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
> > > > >       if (fh_len)
> > > > >               info_len += fanotify_fid_info_len(fh_len, dot_len);
> > > > >
> > > > > +     if (info_mode & FAN_REPORT_PIDFD)
> > > > > +             info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > +
> > > > >       return info_len;
> > > > >  }
> > > > >
> > > > > @@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
> > > > >       return info_len;
> > > > >  }
> > > > >
> > > > > +static int copy_pidfd_info_to_user(struct pid *pid,
> > > > > +                                char __user *buf,
> > > > > +                                size_t count)
> > > > > +{
> > > > > +     struct fanotify_event_info_pidfd info = { };
> > > > > +     size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > +
> > > > > +     if (WARN_ON_ONCE(info_len > count))
> > > > > +             return -EFAULT;
> > > > > +
> > > > > +     info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> > > > > +     info.hdr.len = info_len;
> > > > > +
> > > > > +     info.pidfd = pidfd_create(pid, 0);
> > > > > +     if (info.pidfd < 0)
> > > > > +             info.pidfd = FAN_NOPIDFD;
> > > > > +
> > > > > +     if (copy_to_user(buf, &info, info_len))
> > > > > +             return -EFAULT;
> > > >
> > > > Hm, well this kinda sucks. The caller can end up with a pidfd in their
> > > > fd table and when the copy_to_user() failed they won't know what fd it
> > >
> > > Good catch!
> >
> > Super awesome catch Christian, thanks pulling this up!
> >
> > > But I prefer to solve it differently, because moving fd_install() to the
> > > end of this function does not guarantee that copy_event_to_user()
> > > won't return an error one day with dangling pidfd in fd table.
> >
> > I can see the angle you're approaching this from...
> >
> > > It might be simpler to do pidfd_create() next to create_fd() in
> > > copy_event_to_user() and pass pidfd to copy_pidfd_info_to_user().
> > > pidfd can be closed on error along with fd on out_close_fd label.
> > >
> > > You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
> > > (even though fanotify_init() does check for that).
> >
> > I didn't really understand the need for this check here given that the
> > administrative bits are already being checked for in fanotify_init()
> > i.e. FAN_REPORT_PIDFD can never be set for an unprivileged listener;
> > thus never walking any of the pidfd_mode paths. Is this just a defense
> > in depth approach here, or is it something else that I'm missing?
> >
> 
> We want to be extra careful not to create privilege escalations,
> so even if the fanotify fd is leaked or intentionally passed to a less
> privileged user, it cannot get an open pidfd.
> 
> IOW, it is *much* easier to be defensive in this case than to prove
> that the change cannot introduce any privilege escalations.

I have no problems with being more defensive (it's certainly better than
being too lax) but does it really make sence here? I mean if CAP_SYS_ADMIN
task opens O_RDWR /etc/passwd and then passes this fd to unpriviledged
process, that process is also free to update all the passwords.
Traditionally permission checks in Unix are performed on open and then who
has fd can do whatever that fd allows... I've tried to follow similar
philosophy with fanotify as well and e.g. open happening as a result of
fanotify path events does not check permissions either.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
