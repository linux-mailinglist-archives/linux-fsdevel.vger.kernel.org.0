Return-Path: <linux-fsdevel+bounces-42901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91AAA4B2BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 16:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1A3188B21A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F01E8847;
	Sun,  2 Mar 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFqaWXVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBC1DDC11
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740930887; cv=none; b=D7FLyLGFqV+uOyi0y53IZVLzSq+41NX/SBfnkYZ+xxlf+zXJ7Crxdh3YYk/yL0IDK7wgVUIQMaHsdBXiwVh44WXhRermeoEBYWTxNEMRdaNumwGXAMx7WiflH6pBRQvl9ovWPNXP8+VjFGT3CJzYoJ0jt7KYvqquGs3P18PfWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740930887; c=relaxed/simple;
	bh=wPkgr59moO50aTmau/41oJYnQBKD65/FJ4HJuNe842c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB6AOf8h51ezP6k3uALqyHeId3eJdMZHwQ/+2IOUsLPDvlYscz/+4ZZIoxhppEc1hwyBkWMbAtCDkksDZdsPniupRlViF9A3rUblV4khzU5NJ3rGAVEHo9k0gmNd1XtkgEets7QJs+zzvbfmVY5LsrYZbbpobV+tp36sCwV908k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFqaWXVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740930880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4aKvK0NPt1IOXpGarOfpjayuqatUQZB6BXhMsXpI9o=;
	b=GFqaWXVd/QEwI+OEGAxuPnWBxiHooC+yljWwcVUEcC5sKS8CpC6YAWeK4YaKZjSOkUolP9
	scmT/1Ljr5893RrI3ae8a4S4kIdAW+djQzvdzoTJL8oZXU9LAtBBQFmmMM22SqemMq6jQF
	CrA4JQkAR/+wyPrljaYnCaJKB2zCp5s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-u7mmTaBfNg6KFTgS5ioBmg-1; Sun,
 02 Mar 2025 10:54:26 -0500
X-MC-Unique: u7mmTaBfNg6KFTgS5ioBmg-1
X-Mimecast-MFC-AGG-ID: u7mmTaBfNg6KFTgS5ioBmg_1740930861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A70D19560AF;
	Sun,  2 Mar 2025 15:54:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9139D19560AD;
	Sun,  2 Mar 2025 15:54:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Mar 2025 16:53:50 +0100 (CET)
Date: Sun, 2 Mar 2025 16:53:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <20250302155346.GD2664@redhat.com>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/28, Christian Brauner wrote:
>
> Some tools like systemd's jounral need to retrieve the exit and cgroup
> information after a process has already been reaped.
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

But unless I am totally confused do_exit() calls pidfd_exit() even
before exit_notify(), the exiting task is not even zombie yet. It
will reaped only when it passes exit_notify() and its parent does
wait().



And what about the multi-threaded case? Suppose the main thread
does sys_exit(0) and it has alive sub-threads.

In this case pidfd_info() will report kinfo.exit_code = 0.
And this is probably fine if (file->f_flags & PIDFD_THREAD) != 0.

But what if this file was created without PIDFD_THREAD? If another
thread does exit_group(1) after that, the process's exit code is
1 << 8, but it can't be retrieved.



Finally, sys_execve(). Suppose we have a main thread L and a
sub-thread T.

T execs and kill the leader L. L exits and populates
pidfs_i(inode)->exit_info.

T calls exchange_tids() in de_thread() and becomes the new leader
with the same (old) pid.

Now, T is very much alive, but pidfs_i(inode)->exit_info != NULL.

Or I am totally confused?



> +	exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
> +	if (exit_info) {
> +		/*
> +		 * TODO: Oleg, I didn't see a reason for putting
> +		 * retrieval of the exit status of a task behind some
> +		 * form of permission check.

Neither me.

Oleg.


