Return-Path: <linux-fsdevel+bounces-45421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99572A777DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096B43A6936
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3101EF081;
	Tue,  1 Apr 2025 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlWn7NVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775E1EDA2A;
	Tue,  1 Apr 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500163; cv=none; b=iumd72t14IpLHbHYS8IMXjgT1KhgDLtvkLM79y8VZKW2yviFFZ4w6lNGfqy1cEFIbB3KmJzoSFdbaW654lTDuAJb3CPOfcL0959WPUgtctFNBX3dV7t1x7LdYktcE1hZiM0t4r57VSWx1N7BM6YsaQ5KS4eOQV+jGSgG6LRQlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500163; c=relaxed/simple;
	bh=DFQ7HshH4QnM8dvmnRm+NA4ujqJ40ylcRNKNzB5QSfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSUhweemf/2NmdXiVxzqx+A6Gd/usfYaFFYla7ItFs3oNZF1awyGeB4tBeI4zm8scnFyNEY4OP4x0OdSIR/Tsu7V+Hj6cUwCTycjTgMEfoKRf5qv/6N+1ETt8kr+8DOUj8HPCiLhojtWNvZf4LGhwnFOOVAczrhYSiFE0yHPq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlWn7NVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7064DC4CEE4;
	Tue,  1 Apr 2025 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743500163;
	bh=DFQ7HshH4QnM8dvmnRm+NA4ujqJ40ylcRNKNzB5QSfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlWn7NVt6JvAN31lUXeKKjwIRzmyUuqlfMNqvmRVcMgsGBHgr7yUbGQJraOVgUxLo
	 eu1GDIKt7uODK+cqJkBXXoIEu/L+CqaC23SCz9V9Sd1gcxiU4lOvm500GohqQNFW+Y
	 PG68zgXebuDoSuxxaDeX03Bqt0T+5Js0LzKXXWbFVsYTs4DKJ2zXTCUyYk7oo5uTTi
	 OmjLDwFc6fYWvCnl8tLPe1hXlX0pk9nN6BVNRF0XoPWiQqT5ZKOqQmVnC0FdASnfWR
	 WnPLQiKGXTtu9yFqiit9Kme2g8BninIAH/szdOPZrQI4BGllS277JOD6UUKoOSu1dz
	 6mB3kZlb/H3jg==
Date: Tue, 1 Apr 2025 11:35:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 1/6] ext4: replace kthread freezing with auto fs freezing
Message-ID: <20250401-konsens-nahebringen-fa1c80956371@brauner>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-1-d000611d4ab0@kernel.org>
 <z3zqumhqgzq3agjps4ufdcqqrgip7t7xtr6v5kymchkdjfnwhp@i76pwshkydig>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <z3zqumhqgzq3agjps4ufdcqqrgip7t7xtr6v5kymchkdjfnwhp@i76pwshkydig>

On Tue, Apr 01, 2025 at 11:16:18AM +0200, Jan Kara wrote:
> On Tue 01-04-25 02:32:46, Christian Brauner wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > The kernel power management now supports allowing the VFS
> > to handle filesystem freezing freezes and thawing. Take advantage
> > of that and remove the kthread freezing. This is needed so that we
> > properly really stop IO in flight without races after userspace
> > has been frozen. Without this we rely on kthread freezing and
> > its semantics are loose and error prone.
> > 
> > The filesystem therefore is in charge of properly dealing with
> > quiescing of the filesystem through its callbacks if it thinks
> > it knows better than how the VFS handles it.
> > 
> > The following Coccinelle rule was used as to remove the now superfluous
> > freezer calls:
> > 
> > make coccicheck MODE=patch SPFLAGS="--in-place --no-show-diff" COCCI=./fs-freeze-cleanup.cocci M=fs/ext4
> > 
> > virtual patch
> > 
> > @ remove_set_freezable @
> > expression time;
> > statement S, S2;
> > expression task, current;
> > @@
> > 
> > (
> > -       set_freezable();
> > |
> > -       if (try_to_freeze())
> > -               continue;
> > |
> > -       try_to_freeze();
> > |
> > -       freezable_schedule();
> > +       schedule();
> > |
> > -       freezable_schedule_timeout(time);
> > +       schedule_timeout(time);
> > |
> > -       if (freezing(task)) { S }
> > |
> > -       if (freezing(task)) { S }
> > -       else
> > 	    { S2 }
> > |
> > -       freezing(current)
> > )
> > 
> > @ remove_wq_freezable @
> > expression WQ_E, WQ_ARG1, WQ_ARG2, WQ_ARG3, WQ_ARG4;
> > identifier fs_wq_fn;
> > @@
> > 
> > (
> >     WQ_E = alloc_workqueue(WQ_ARG1,
> > -                              WQ_ARG2 | WQ_FREEZABLE,
> > +                              WQ_ARG2,
> > 			   ...);
> > |
> >     WQ_E = alloc_workqueue(WQ_ARG1,
> > -                              WQ_ARG2 | WQ_FREEZABLE | WQ_ARG3,
> > +                              WQ_ARG2 | WQ_ARG3,
> > 			   ...);
> > |
> >     WQ_E = alloc_workqueue(WQ_ARG1,
> > -                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE,
> > +                              WQ_ARG2 | WQ_ARG3,
> > 			   ...);
> > |
> >     WQ_E = alloc_workqueue(WQ_ARG1,
> > -                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE | WQ_ARG4,
> > +                              WQ_ARG2 | WQ_ARG3 | WQ_ARG4,
> > 			   ...);
> > |
> > 	    WQ_E =
> > -               WQ_ARG1 | WQ_FREEZABLE
> > +               WQ_ARG1
> > |
> > 	    WQ_E =
> > -               WQ_ARG1 | WQ_FREEZABLE | WQ_ARG3
> > +               WQ_ARG1 | WQ_ARG3
> > |
> >     fs_wq_fn(
> > -               WQ_FREEZABLE | WQ_ARG2 | WQ_ARG3
> > +               WQ_ARG2 | WQ_ARG3
> >     )
> > |
> >     fs_wq_fn(
> > -               WQ_FREEZABLE | WQ_ARG2
> > +               WQ_ARG2
> >     )
> > |
> >     fs_wq_fn(
> > -               WQ_FREEZABLE
> > +               0
> >     )
> > )
> > 
> > @ add_auto_flag @
> > expression E1;
> > identifier fs_type;
> > @@
> > 
> > struct file_system_type fs_type = {
> > 	.fs_flags = E1
> > +                   | FS_AUTOFREEZE
> > 	,
> > };
> > 
> > Generated-by: Coccinelle SmPL
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Link: https://lore.kernel.org/r/20250326112220.1988619-5-mcgrof@kernel.org
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/ext4/mballoc.c | 2 +-
> >  fs/ext4/super.c   | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 0d523e9fb3d5..ae235ec5ff3a 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -6782,7 +6782,7 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
> >  
> >  static bool ext4_trim_interrupted(void)
> >  {
> > -	return fatal_signal_pending(current) || freezing(current);
> > +	return fatal_signal_pending(current);
> >  }
> 
> This change should not happen. ext4_trim_interrupted() makes sure FITRIM
> ioctl doesn't cause hibernation failures and has nothing to do with kthread
> freezing...
> 
> Otherwise the patch looks good.

Afaict, we don't have to do these changes now. Yes, once fsfreeze
reliably works in the suspend/resume codepaths then we can switch all
that off and remove the old freezer. But we should only do that once we
have some experience with the new filesystem freezing during
suspend/hibernate. So we should place this under a
/sys/power/freeze_filesystems knob and wait a few kernel releases to see
whether we see significant problems. How does that sound to you?

