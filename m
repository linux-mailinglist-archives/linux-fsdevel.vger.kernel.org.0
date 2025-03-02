Return-Path: <linux-fsdevel+bounces-42910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC23A4B4A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 21:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BD8169F64
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C101EB9EF;
	Sun,  2 Mar 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwjANItR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C701E32BE
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740947114; cv=none; b=iv8MiuSGp7u3LmY4h2TKvE3zvnWIclO+Lo+GwoEtKPvSNkUoXEEQmDHbpqQY5pcWj3PkPxO9u0Q/0u7fHC/vd1Wq9jeYBKWiNKD1OyTTPxYKsPfmbSi326vtFA4tkD4qlRjf6zt1Das7Q2gXry0nS2Q7DGJ7LJOpwanV2ktGjXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740947114; c=relaxed/simple;
	bh=6P4m3bodjPeZxbNjq6sZCyEUPq7doJDUun+J/nuVrkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrFPYYrHEy61W+zlU5q2b+JfZoe7UEJclCv+nrKw+ToRLSftnigy7NCSIC1tvEPtsyQGNKAFfcVN1K0veVM9c52jkvn8eBy03BhU/FBQRzXNQ6y2ge3FlH4lBTFzZSOFyRB/yMV4Gga9iEyyFWYYic1zrpp0+2KRJPEquq9qo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwjANItR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740947111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7Rw29ypgjciZFPjzu+TaXDNBRLR1o7KTD/40v+2+Go=;
	b=WwjANItRMmWUX9le6JSz19CJqqsDA5fnZnorpeMI2mIlyAmGWqBqyZu/VHuN6BY10nU+ZM
	m1iPdgn81CywvEFwA1La8NKJcaPhp2BFEVy+GyQiNREBC7yK7psIlnTVluZXGxmOreIMX6
	t1UI+hxILKcqTaxh2wd8T0LyIoHlMXg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-Oc61JS8pPxyX4VmdFShsCQ-1; Sun,
 02 Mar 2025 15:25:04 -0500
X-MC-Unique: Oc61JS8pPxyX4VmdFShsCQ-1
X-Mimecast-MFC-AGG-ID: Oc61JS8pPxyX4VmdFShsCQ_1740947103
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 138271800876;
	Sun,  2 Mar 2025 20:25:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4C93319560AB;
	Sun,  2 Mar 2025 20:25:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Mar 2025 21:24:32 +0100 (CET)
Date: Sun, 2 Mar 2025 21:24:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <20250302202428.GG2664@redhat.com>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
 <20250302155346.GD2664@redhat.com>
 <20250302-sperling-tagebuch-49c1b4996c5f@brauner>
 <20250302172149.GF2664@redhat.com>
 <20250302-eilzug-inkognito-b5c8447a7f34@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302-eilzug-inkognito-b5c8447a7f34@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Christian,

I am already sleeping. I'll try to reply right now, but quite possibly
I will need to correct myself tomorrow ;)

On 03/02, Christian Brauner wrote:
>
> Ok, so:
>
> release_task()
> -> __exit_signal()
>    -> detach_pid()
>       -> __change_pid()
>
> That sounds good. So could we do something like:

Yes, this is what I meant, except...

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -127,8 +127,10 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
>  {
>         nr_threads--;
>         detach_pid(p, PIDTYPE_PID);
> +       pidfs_exit(p); // record exit information for individual thread

To me it would be better to do this in the caller, release_task().
But this is minor and I won't insist. Please see below.

>         if (group_dead) {
>                 detach_pid(p, PIDTYPE_TGID);
> +               pidfs_exit(p); // record exit information for thread-group leader

This looks pointless, task_pid(p) is the same.

> I know, as written this won't work but I'm just trying to get the idea
> across of recording exit information for both the individual thread and
> the thread-group leader in __unhash_process().
>
> That should tackle both problems, i.e., recording exit information for
> both thread and thread-group leader as well as exec?

This will fix the problem with mt-exec, but this won't help to discriminate
the leader-exit and the-whole-group-exit cases...

With this this (or something like this) change pidfd_info() can only report
the exit code of the already reaped thread/process, leader or not.

I mean... If the leader L exits using sys_exit() and it has the live sub-
threads, release_task(L) / __unhash_process(L) will be only called when
the last sub-thread exits and it (or debugger) does "goto repeat;" in
release_task() to finally reap the leader.

IOW. If someone does sys_pidfd_create(group-leader-pid, PIDFD_THREAD),
pidfd_info() won't report PIDFD_INFO_EXIT if the leader has exited using
sys_exit() before other threads.

But perhaps this is fine?

Let me repeat, I have no idea how and why people use pidfd ;)

Oleg.


