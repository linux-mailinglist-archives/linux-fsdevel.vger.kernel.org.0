Return-Path: <linux-fsdevel+bounces-46587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53CA90D00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E005A4CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038CA22A4D8;
	Wed, 16 Apr 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEck2/tA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53739229B1F;
	Wed, 16 Apr 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834868; cv=none; b=JgZ/b65CMdhncXpWJI02qqKnUFhv4eGpPQXjptEk25iuIJ36n9czrp7jOK3jgDAN4RmwyP+nopxnxFjmpPMCennxRPE1zae6YK3cfLaupJ2vE0AJ25WVjkUncSri+t2sGQylQaPJxy0CvtyGcTWY/OK9VcLyxBr4ufdp57hSgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834868; c=relaxed/simple;
	bh=o12B9jiKPCZpgpZG+XV8CP3qdHtrhZnzNoMdZWjkWSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLikamRe1MXEofq8+pPUU8chbSlrbNYHaSeyMeegMi3yWKptVgqD2w3pSHq2nddtmdNTIYQ9nGuoAxMJcvjJDN9cocUa8vs6wsQgFfBrZe0JGeFli7HbsF18cT+/Ck6gpOF2VmICE6F6KezmzieIE6Wv5jEEccNHXDvgnZQTHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEck2/tA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697E7C4CEE2;
	Wed, 16 Apr 2025 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744834867;
	bh=o12B9jiKPCZpgpZG+XV8CP3qdHtrhZnzNoMdZWjkWSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEck2/tAti8lHNlAM4n4//zHmGg2oQByYtAHEP2j+RgY2U1V8Qu/jyCwKTIt7ucJn
	 1bg7zP3hiIWdW7EEakI1FGOUZbzqm4T35uxfpiIGErOEMclKcx1F1r5nRzVVQJKg2l
	 GA2Hb9xLLM11Ioa/UzJIn2NEFeVGhAM1Pbj+RXlaBmuAPaIihdCx5fgMJg0wv9Bcph
	 StJK9Nt+FcxW8QyB0pXFKqEft0wX8CP3XxQI/xrWBzMSY7SeLRfWXj4njIPpinRuGk
	 qdpyCvqpKyOaq/yqZHHiXPVja4XPzpnjbaEdZJYKIeeoZF1H4OgHBEIuJNBTcJC7uz
	 /fWCebX/xqA8A==
Date: Wed, 16 Apr 2025 22:21:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Rheinsberg <david@readahead.eu>, Oleg Nesterov <oleg@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250416-gegriffen-tiefbau-70cfecb80ac8@brauner>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
 <20250415223454.GA1852104@ax162>
 <20250416-befugnis-seemeilen-4622c753525b@brauner>
 <20250416-tonlage-gesund-160868ceccc1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uecgayr66qpjv7ew"
Content-Disposition: inline
In-Reply-To: <20250416-tonlage-gesund-160868ceccc1@brauner>


--uecgayr66qpjv7ew
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 16, 2025 at 09:47:34PM +0200, Christian Brauner wrote:
> On Wed, Apr 16, 2025 at 03:55:48PM +0200, Christian Brauner wrote:
> > On Tue, Apr 15, 2025 at 03:34:54PM -0700, Nathan Chancellor wrote:
> > > Hi Christian,
> > > 
> > > On Fri, Apr 11, 2025 at 03:22:43PM +0200, Christian Brauner wrote:
> > > > In a prior patch series we tried to cleanly differentiate between:
> > > > 
> > > > (1) The task has already been reaped.
> > > > (2) The caller requested a pidfd for a thread-group leader but the pid
> > > > actually references a struct pid that isn't used as a thread-group
> > > > leader.
> > > > 
> > > > as this was causing issues for non-threaded workloads.
> > > > 
> > > > But there's cases where the current simple logic is wrong. Specifically,
> > > > if the pid was a leader pid and the check races with __unhash_process().
> > > > Stabilize this by using the pidfd waitqueue lock.
> > > 
> > > After the recent work in vfs-6.16.pidfs (I tested at
> > > a9d7de0f68b79e5e481967fc605698915a37ac13), I am seeing issues with using
> > > 'machinectl shell' to connect to a systemd-nspawn container on one of my
> > > machines running Fedora 41 (the container is using Rawhide).
> > > 
> > >   $ machinectl shell -q nathan@$DEV_IMG $SHELL -l
> > >   Failed to get shell PTY: Connection timed out
> > > 
> > > My initial bisect attempt landed on the merge of the first series
> > > (1e940fff9437), which does not make much sense because 4fc3f73c16d was
> > > allegedly good in my test, but I did not investigate that too hard since
> > > I have lost enough time on this as it is heh. It never reproduces at
> > > 6.15-rc1 and it consistently reproduces at a9d7de0f68b so I figured I
> > > would report it here since you mention this series is a fix for the
> > > first one. If there is any other information I can provide or patches I
> > > can test (either as fixes or for debugging), I am more than happy to do
> > > so.
> 
> I can't reproduce this issue at all with vfs-6.16.pidfs unfortunately.
> 
> > 
> > Does the following patch make a difference for you?:
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index f7403e1fb0d4..dd30f7e09917 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2118,7 +2118,7 @@ int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> >         scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
> >                 /* Task has already been reaped. */
> >                 if (!pid_has_task(pid, PIDTYPE_PID))
> > -                       return -ESRCH;
> > +                       return -EINVAL;
> >                 /*
> >                  * If this struct pid isn't used as a thread-group
> >                  * leader but the caller requested to create a
> > 
> > If it did it would be weird if the first merge is indeed marked as good.
> > What if you used a non-rawhide version of systemd? Because this might
> > also be a regression on their side.

Ok, I think I understand how this happens. dbus-broker assumes that
only EINVAL is reported by SO_PEERPIDFD when a process is reaped:

https://github.com/bus1/dbus-broker/blob/5d34d91b138fc802a016aa68c093eb81ea31139c/src/util/sockopt.c#L241

It would be great if it would also allow for ESRCH which is the correct
error code anyway. So hopefully we'll get that fixed in userspace. For
now we paper over this in the kernel in the SO_PEERPIDFD code.

Can you please test vfs-6.16.pidfs again. It has the patch I'm
appending.

--uecgayr66qpjv7ew
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-net-pidfd-report-EINVAL-for-ESRCH.patch"

From 3f662e72d51caea74370e07a3d5bad66f020423d Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 16 Apr 2025 22:05:40 +0200
Subject: [PATCH] net, pidfd: report EINVAL for ESRCH

dbus-broker relies -EINVAL being returned to indicate ESRCH in [1].
This causes issues for some workloads as reported in [2].
Paper over it until this is fixed in userspace.

Link: https://github.com/bus1/dbus-broker/blob/5d34d91b138fc802a016aa68c093eb81ea31139c/src/util/sockopt.c#L241 [1]
Link: https://lore.kernel.org/20250415223454.GA1852104@ax162 [2]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/sock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f67a3c5b0988..ed8e7fd36284 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1893,8 +1893,16 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 		pidfd = pidfd_prepare(peer_pid, 0, &pidfd_file);
 		put_pid(peer_pid);
-		if (pidfd < 0)
+		if (pidfd < 0) {
+			/*
+			 * dbus-broker relies -EINVAL being returned to
+			 * indicate ESRCH. Paper over it until this is
+			 * fixed in userspace.
+			 */
+			if (pidfd == -ESRCH)
+				pidfd = -EINVAL;
 			return pidfd;
+		}
 
 		if (copy_to_sockptr(optval, &pidfd, len) ||
 		    copy_to_sockptr(optlen, &len, sizeof(int))) {
-- 
2.47.2


--uecgayr66qpjv7ew--

