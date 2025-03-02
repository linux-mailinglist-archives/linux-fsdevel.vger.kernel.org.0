Return-Path: <linux-fsdevel+bounces-42908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F0A4B3BF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112DD16CF24
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DA1E9B30;
	Sun,  2 Mar 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EddKBMlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F2322E
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740936152; cv=none; b=Q1f0+Z1Xru7AxZjk4uDeV3N/IOfAkq6ZjwgoQsB/316OtGfDP2s6/cnDez6nKMgi/eXizUALuLebyImdvYQOOXibdl33ropNw9Lr1v5XodKa2oo8U5EYG0rkkK+oCXuY4ioIDteTT7N4LsTvT8NPfbRPm84DGv8ip6m+1Jw3q5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740936152; c=relaxed/simple;
	bh=zlFeJZ6SAZwoAek8wKq2lzd5FDLL/J191zE/Fs67MYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxIvnWgmq3EkkAXs926bwPDOwK0gN3gFBJJysXHDh4F2Qtv+zRhr6rlvhmkrN9HBIxtUbdDU+wJ/ld8OIDFMBiwn9agfGZnjfqNGqU+LRjsPn0ITP8quYv0623H/DK8iRU5uBlCWwhz0+S1rVI4E80gWAEdpe+wcujWDiF69kUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EddKBMlA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740936149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZhATp+vnZ/dY6FqOexpKtG27wvkilz2hv0sICbJD1I=;
	b=EddKBMlAOaqPp5mPu3FxRBKSQdcAHOBTPV1hPu9lc8frZ42EUqVrWVpOP394ivU/eJ3UXF
	RqTNrw5hKIg78JJN5l5K17hPRyzJ62EyKQnVThfGztE6G1nTg84F0hvEFci2lfISLpbEZF
	qJ1xAJqMYFbAm6x5oXl8xDPibPjzvxg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-InHQLV6nNYuQTJVtzEYfsQ-1; Sun,
 02 Mar 2025 12:22:25 -0500
X-MC-Unique: InHQLV6nNYuQTJVtzEYfsQ-1
X-Mimecast-MFC-AGG-ID: InHQLV6nNYuQTJVtzEYfsQ_1740936144
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27D321800874;
	Sun,  2 Mar 2025 17:22:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6F37519560AD;
	Sun,  2 Mar 2025 17:22:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Mar 2025 18:21:53 +0100 (CET)
Date: Sun, 2 Mar 2025 18:21:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <20250302172149.GF2664@redhat.com>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
 <20250302155346.GD2664@redhat.com>
 <20250302-sperling-tagebuch-49c1b4996c5f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302-sperling-tagebuch-49c1b4996c5f@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/02, Christian Brauner wrote:
>
> On Sun, Mar 02, 2025 at 04:53:46PM +0100, Oleg Nesterov wrote:
> > On 02/28, Christian Brauner wrote:
> > >
> > > Some tools like systemd's jounral need to retrieve the exit and cgroup
> > > information after a process has already been reaped.
> >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > But unless I am totally confused do_exit() calls pidfd_exit() even
> > before exit_notify(), the exiting task is not even zombie yet. It
> > will reaped only when it passes exit_notify() and its parent does
> > wait().
>
> The overall goal is that it's possible to retrieve exit status and
> cgroupid even if the task has already been reaped.

OK, please see below...

> It's intentionally placed before exit_notify(), i.e., before the task is
> a zombie because exit_notify() wakes pidfd-pollers. Ideally, pidfd
> pollers would be woken and then could use the PIDFD_GET_INFO ioctl to
> retrieve the exit status.

This was more a less clear to me. But this doesn't match the "the task has
already been reaped" goal above...

> It would however be fine to place it into exit_notify() if it's a better
> fit there. If you have a preference let me know.
>
> I don't see a reason why seeing the exit status before that would be an
> issue.

The problem is that it is not clear how can we do this correctly.
Especialy considering the problem with exec...

> > But what if this file was created without PIDFD_THREAD? If another
> > thread does exit_group(1) after that, the process's exit code is
> > 1 << 8, but it can't be retrieved.
>
> Yes, I had raised that in an off-list discussion about this as well and
> was unsure what the cleanest way of dealing with this would be.

I am not sure too, but again, please see below.

> > Now, T is very much alive, but pidfs_i(inode)->exit_info != NULL.

...

> What's the best way of handling the de_thread() case? Would moving this
> into exit_notify() be enough where we also handle
> PIDFD_THREAD/~PIDFD_THREAD waking?

I don't think that moving pidfd_exit() into exit_notify() can solve any
problem.

But what if we move pidfd_exit() into release_task() paths? Called when
the task is reaped by the parent/debugger, or if a sub-thread auto-reaps.

Can the users of pidfd_info(PIDFD_INFO_EXIT) rely on POLLHUP from
release_task() -> detach_pid() -> __change_pid(new => NULL) ?

Oleg.


