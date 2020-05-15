Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B861D4D25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 13:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgEOL60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 07:58:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52914 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgEOL60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 07:58:26 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZYys-0000GF-HN; Fri, 15 May 2020 11:58:22 +0000
Date:   Fri, 15 May 2020 13:58:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200515115821.5qvkaeuxzklhikuo@wittgenstein>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
 <20200124180332.GA4151@cisco>
 <CAMp4zn_WXwxJ6Md4rgFzdAY_xea4TmVDdQc1iJDObEMm5Yc79g@mail.gmail.com>
 <20200126054256.GB4151@cisco>
 <CAMp4zn_Xv2iicmH2Nc4-EZceD7T8AFe9PQRNX4bNEiAuoKs+vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn_Xv2iicmH2Nc4-EZceD7T8AFe9PQRNX4bNEiAuoKs+vA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 04:49:14AM -0700, Sargun Dhillon wrote:
> On Sat, Jan 25, 2020 at 9:42 PM Tycho Andersen <tycho@tycho.ws> wrote:
> 
> > On Fri, Jan 24, 2020 at 12:09:37PM -0800, Sargun Dhillon wrote:
> > > On Fri, Jan 24, 2020 at 10:03 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > > >
> > > > On Fri, Jan 24, 2020 at 01:17:42AM -0800, Sargun Dhillon wrote:
> > > > > Currently, this just opens the group leader of the thread that
> > triggere
> > > > > the event, as pidfds (currently) are limited to group leaders.
> > > >
> > > > I don't love the semantics of this; when they're not limited to thread
> > > > group leaders any more, we won't be able to change this. Is that work
> > > > far off?
> > > >
> > > > Tycho
> > >
> > > We would be able to change this in the future if we introduced a flag
> > like
> > > SECCOMP_USER_NOTIF_FLAG_PIDFD_THREAD which would send a
> > > pidfd that's for the thread, and not just the group leader. The flag
> > could
> > > either be XOR with SECCOMP_USER_NOTIF_FLAG_PIDFD, or
> > > could require both. Alternatively, we can rename
> > > SECCOMP_USER_NOTIF_FLAG_PIDFD to
> > > SECCOMP_USER_NOTIF_FLAG_GROUP_LEADER_PIDFD.
> >
> > Ok, but then isn't this just another temporary API? Seems like it's
> > worth waiting until the Right Way exists.
> >
> > Tycho
> >
> 
> It's been a few months. It does not appear like much progress has been made
> moving away from
> pidfd being only useful for leaders.
> 
> I would either like to respin this patch, or at a minimum, include the
> process group leader pid number
> in the seccomp notification, to simplify things for tracers.

I'd prefer if you went with the second option where you include the
process group leader pid number.
I'm against adding countless ways of producing pidfds through various
unrelated apis. The api is still quite fresh so I'd like to not overdo
it.

Christian
