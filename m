Return-Path: <linux-fsdevel+bounces-42921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2B0A4BA77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 10:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9C21890D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FEF1F03EA;
	Mon,  3 Mar 2025 09:12:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4071EF09B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993124; cv=none; b=kMIUi5qawxhnG7bwE/eFXf1/Iiwhvzz/D5p2ZmVfrNJ/CHEVd1YiyeNVjMXoLJsRjNp7ROVH17Gj7CPxHhRVzbdxe1m1vHecVyrqT4V0P8NppCiWO5sJzD5cAoDM/hUpBDm5difW59Xy9HMSi/nY+u9Qllmib0RhVjeDxQ7xDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993124; c=relaxed/simple;
	bh=dRcjIfM0qR9DtPmlI94iG1OoXhO6vM9+TOG2CPp/tl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE+Drx09mG1FzmwAnluq259fqE9QK4rLfDRIuVd5XDoLPbCT8gos4wuQx/WJFsaO1g7HhtTOhB0kN0LOjqveD7c6NhD9rbMhYbJUXP7quINm4BqJKdMqe8rpHBSkyj8V+iSVCJRLat9eeVSqGhWi4PGS5sxgLRa4afausNU2T2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id BA31BE801B7;
	Mon,  3 Mar 2025 10:06:32 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id A3CE51601CE; Mon,  3 Mar 2025 10:06:31 +0100 (CET)
Date: Mon, 3 Mar 2025 10:06:31 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <Z8VxF1N7G1XZOTQy@gardel-login>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
 <20250302155346.GD2664@redhat.com>
 <20250302-sperling-tagebuch-49c1b4996c5f@brauner>
 <20250302172149.GF2664@redhat.com>
 <20250302-eilzug-inkognito-b5c8447a7f34@brauner>
 <20250302202428.GG2664@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302202428.GG2664@redhat.com>

On So, 02.03.25 21:24, Oleg Nesterov (oleg@redhat.com) wrote:

> This will fix the problem with mt-exec, but this won't help to discriminate
> the leader-exit and the-whole-group-exit cases...
>
> With this this (or something like this) change pidfd_info() can only report
> the exit code of the already reaped thread/process, leader or not.
>
> I mean... If the leader L exits using sys_exit() and it has the live sub-
> threads, release_task(L) / __unhash_process(L) will be only called when
> the last sub-thread exits and it (or debugger) does "goto repeat;" in
> release_task() to finally reap the leader.
>
> IOW. If someone does sys_pidfd_create(group-leader-pid, PIDFD_THREAD),
> pidfd_info() won't report PIDFD_INFO_EXIT if the leader has exited using
> sys_exit() before other threads.
>
> But perhaps this is fine?

I think this is fine, but I'd really like a way how userspace can
determine this state reliably. i.e. a zombie state where the exit
status is not available yet is a bit strange by classic UNIX
standards on some level, no?

But I guess that might not be a pidfd specific issue. i.e. I figure
classic waitid() with WNOHANG failing on a zombie process that is set
up like that is a bit weird too, no? Or how does that work there?
(pretty sure some userspace might not be expecting that...)

Lennart

--
Lennart Poettering, Berlin

