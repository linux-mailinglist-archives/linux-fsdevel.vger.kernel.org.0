Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A8A38C518
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhEUKmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 06:42:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhEUKmU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 06:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8929AC3E;
        Fri, 21 May 2021 10:40:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6FF601F2C73; Fri, 21 May 2021 12:40:56 +0200 (CEST)
Date:   Fri, 21 May 2021 12:40:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        christian.brauner@ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <20210521104056.GG18952@quack2.suse.cz>
References: <cover.1621473846.git.repnop@google.com>
 <20210520135527.GD18952@quack2.suse.cz>
 <YKeIR+LiSXqUHL8Q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKeIR+LiSXqUHL8Q@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> Hey Jan!
> 
> On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > On Thu 20-05-21 12:09:45, Matthew Bobrowski wrote:
> > > Hey Jan/Amir/Christian,
> > > 
> > > This is the updated patch series for adding pidfd support to the
> > > fanotify API. It incorporates all the suggestions that had come out of
> > > the initial RFC patch series [0].
> > > 
> > > The main difference with this patch series is that FAN_REPORT_PIDFD
> > > results in an additional info record object supplied alongside the
> > > generic event metadata object instead of overloading metadata->pid. If
> > > any of the fid flavoured init flags are specified, then the pidfd info
> > > record object will follow any fid info record objects.
> > > 
> > > [0] https://www.spinics.net/lists/linux-fsdevel/msg193296.html
> > 
> > Overall the series looks fine to me - modulo the problems Christian & Amir
> > found. Do you have any tests for this? Preferably for LTP so that we can
> > extend the coverage there?
> 
> Cool and thanks for glancing over this series.
> 
> I've written some simple programs to verify this functionality works in
> FID and non-FID modes. I definitely plan on writing LTP tests,
> although it's something I'll do once we've agreed on the approach and
> I've received an ACK from yourself, Amir and Christian. This series
> passes all current LTP regressions. Also, I guess I'll need to write
> some patches for man-pages given this is an ABI change.

Yes, manpage update will be necessary as well.

> There's one thing that I'd like to mention, and it's something in
> regards to the overall approach we've taken that I'm not particularly
> happy about and I'd like to hear all your thoughts. Basically, with
> this approach the pidfd creation is done only once an event has been
> queued and the notification worker wakes up and picks up the event
> from the queue processes it. There's a subtle latency introduced when
> taking such an approach which at times leads to pidfd creation
> failures. As in, by the time pidfd_create() is called the struct pid
> has already been reaped, which then results in FAN_NOPIDFD being
> returned in the pidfd info record.
> 
> Having said that, I'm wondering what the thoughts are on doing pidfd
> creation earlier on i.e. in the event allocation stages? This way, the
> struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> returned in the pidfd info record because the struct pid has been
> already reaped, userspace application will atleast receive a valid
> pidfd which can be used to check whether the process still exists or
> not. I think it'll just set the expectation better from an API
> perspective.

Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
be sure the original process doesn't exist anymore. So is it useful to
still receive pidfd of the dead process? Also opening pidfd in the context
of event generation is problematic for two reasons:

1) Technically, the context under which events are generated can be rather
constrained (various locks held etc.). Adding relatively complex operations
such as pidfd creation is going to introduce strange lock dependencies,
possibly deadlocks.

2) Doing pidfd generation in the context of the process generating event is
problematic - you don't know in which fd_table the fd will live. Also that
process is unfairly penalized (performance wise) because someone else is
listening. We try to keep overhead of event generation as low as possible
for this reason.

								Honza

> 
> /M
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
