Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92828A55C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHLSIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:08:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48853 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLSIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:08:13 -0400
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hxELt-0001w2-Ar; Mon, 12 Aug 2019 18:43:25 +0100
Message-ID: <7edb5c85c29a46cf5edb6fe5033b07884fd068ae.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Date:   Mon, 12 Aug 2019 18:43:24 +0100
In-Reply-To: <CABeXuvoa4VUQp3QxsEfq6PBKNv4Q2icp++5_EP=1e_72KLk_9w@mail.gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
         <20190730014924.2193-5-deepa.kernel@gmail.com>
         <c508fe0116b77ff0496ebb17a69f756c47be62b7.camel@codethink.co.uk>
         <CABeXuvruROn7j1DiCDbP6MLBt9SB4Pp3HoKqcQbUNPDJgGWLgw@mail.gmail.com>
         <53df9d81bfb4ee7ec64fabf1089f91d80dceb491.camel@codethink.co.uk>
         <CAK8P3a0CADLUeXvsBHNAC8ekLoo0o0uYz2arBqZ=1N+Xp8HNvA@mail.gmail.com>
         <CABeXuvpAPp98G2gCczB3n=izv4aM7vacdbPONiELrw-1ZOrd=g@mail.gmail.com>
         <CABeXuvoa4VUQp3QxsEfq6PBKNv4Q2icp++5_EP=1e_72KLk_9w@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-08-12 at 09:15 -0700, Deepa Dinamani wrote:
> On Mon, Aug 12, 2019 at 9:09 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > On Mon, Aug 12, 2019 at 7:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Aug 12, 2019 at 3:25 PM Ben Hutchings
> > > <ben.hutchings@codethink.co.uk> wrote:
> > > > On Sat, 2019-08-10 at 13:44 -0700, Deepa Dinamani wrote:
> > > > > On Mon, Aug 5, 2019 at 7:14 AM Ben Hutchings
> > > > > <ben.hutchings@codethink.co.uk> wrote:
> > > > > > On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> > > > > > > The warning reuses the uptime max of 30 years used by the
> > > > > > > setitimeofday().
> > > > > > > 
> > > > > > > Note that the warning is only added for new filesystem mounts
> > > > > > > through the mount syscall. Automounts do not have the same warning.
> > > > > > [...]
> > > > > > 
> > > > > > Another thing - perhaps this warning should be suppressed for read-only
> > > > > > mounts?
> > > > > 
> > > > > Many filesystems support read only mounts only. We do fill in right
> > > > > granularities and limits for these filesystems as well. In keeping
> > > > > with the trend, I have added the warning accordingly. I don't think I
> > > > > have a preference either way. But, not warning for the red only mounts
> > > > > adds another if case. If you have a strong preference, I could add it
> > > > > in.
> > > > 
> > > > It seems to me that the warning is needed if there is a possibility of
> > > > data loss (incorrect timestamps, potentially leading to incorrect
> > > > decisions about which files are newer).  This can happen only when a
> > > > filesystem is mounted read-write, or when a filesystem image is
> > > > created.
> > > > 
> > > > I think that warning for read-only mounts would be an annoyance to
> > > > users retrieving files from old filesystems.
> > > 
> > > I agree, the warning is not helpful for read-only mounts. An earlier
> > > plan was to completely disallow writable mounts that might risk an
> > > overflow (in some configurations at least). The warning replaces that
> > > now, and I think it should also just warn for the cases that would
> > > otherwise have been dangerous.
> > 
> > Ok, I will make the change to exclude new read only mounts. I will use
> > __mnt_is_readonly() so that it also exculdes filesystems that are
> > readonly also.
> > The diff looks like below:
> > 
> > -       if (!error && sb->s_time_max &&
> > +       if (!error && !__mnt_is_readonly(mnt) &&
> >             (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
> > 
> > Note that we can get rid of checking for non zero sb->s_time_max now.
> 
> One more thing, we will probably have to add a second warning for when
> the filesystem is re-mounted rw after the initial readonly mount.

Indeed, there would need to be a check for remount-read-write.  I
didn't check whether remount uses this same code path.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

