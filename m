Return-Path: <linux-fsdevel+bounces-30336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94359989F36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E81F23100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C4188714;
	Mon, 30 Sep 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J619gNM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157F558BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691319; cv=none; b=Fc4iSTOJLpWLmmFTP3tmxLtQXfYHEj7afGoalmJ+FPC6cSqpI6P5SzLCEq1dbkym6xHdLyCHQ3F7dh9n3yw3wQtalxy1H3QmGAjzv+9Q5EEcTQtJ1d4509OCoMeXgWMnun0IGlmw7AKlmqioUh0TyYxH2THyM1b7WRKKCdoYi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691319; c=relaxed/simple;
	bh=OEc8dFLInS0OAS2YX51LHZxpz80U77z8iK4+AQjCYII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjs008MnPlvEW44DXrZa7jbGimOVM9EEJbn2mnI+1nUViEcOAf8ZEIBbp/4EbEucNuPvDvd7u5VUqs/TFSBThRDzF9CHBvETBz36TPYryQs3WwpnjZG71r9cU6bUGZC7NajgB54HOdGFiig5AuGcWueyRGB/8/VAumC9Utu+wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J619gNM2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727691316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCUdNikGJCngAq5rrc4vcaoiBZukIDMXIdCY4aEjVyM=;
	b=J619gNM2fK2YL1OzAl0mG5rs4JxT/gB+IOfJ8mn7Y/t+H+1/AwoALprTeP6uNkjtdBNnk2
	RVSzX1Cju0GkBpqt5/F9ec/mav/4PLNpg0DlZDL8U/gsrl7w4vZ5ry2biWub6ixvYvtKrH
	LLF200cWTUvogm7a9XeJ22vvh4SGH0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-mp2pTtkXPHGuhrwATCC2Jg-1; Mon, 30 Sep 2024 06:15:15 -0400
X-MC-Unique: mp2pTtkXPHGuhrwATCC2Jg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb998fd32so27886045e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 03:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691314; x=1728296114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCUdNikGJCngAq5rrc4vcaoiBZukIDMXIdCY4aEjVyM=;
        b=aYaZaS6n2sr5Udg3yUwi8izoBSLJKnI5JWmN/1qE3Hn4Ivb0vbhD6l73E16bz0BJx/
         J2jXhdRgESQBaC1mcC8nULIxPeEOj+axxPHNzA1gq7nIR99sKym85c/72UyVsCpfOaUq
         Ws37HCfTeq24v4VSSnSebiabQw9FaR+1y3QC1faRiCiyNYFCTYasGHvnR4icZBnpqL7M
         U4krAwINCJZDUAm/AWxDiBZzxDWbl2nwXUCTtns1/524j9hM2idZVeZN9TrjUEsoPYN5
         ivPgsUNsIQnQltJVXOMzt4v0mvbxSWrFtPH+lT/GoGrTfKm/8utS2jFJuwslKnBUeC3W
         Gsrw==
X-Forwarded-Encrypted: i=1; AJvYcCXb0Ag1CxdS2L6VPv+NWWQdAx78qNic7KhkBlpjCHHG1RrPnrI6nnb3SuuXJjRHo+njMoR/nVPz5slUEnSh@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFj38EVduOTgRdOeqgEGokn5e/MFRA0tllEN8PCWcvfUfxhl/
	andvALZEIEVROUeCkoxTyFVrHzgRd1Ga2y6J0FUd9SYba0rtPo39g9ZxWFPzpoEOxF52rpHTQwQ
	spUV8vaquiP/+ug+B0krFQOlGzKZOu3ZPbYnD5XYxXN+MrVOHjCXGIQJLlK3ppg8=
X-Received: by 2002:a5d:5258:0:b0:37c:cc54:ea72 with SMTP id ffacd0b85a97d-37cd5a687c8mr6230528f8f.4.1727691314537;
        Mon, 30 Sep 2024 03:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAmQ9keNL/1ukB9mMF7yp8J5+HTw3AMKd/GNMHUzlXqNxxyeInkNU+WTVYZxy9eRgobMCc5w==
X-Received: by 2002:a5d:5258:0:b0:37c:cc54:ea72 with SMTP id ffacd0b85a97d-37cd5a687c8mr6230519f8f.4.1727691314158;
        Mon, 30 Sep 2024 03:15:14 -0700 (PDT)
Received: from t14s (109-81-84-73.rct.o2.cz. [109.81.84.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d0a3sm8797984f8f.15.2024.09.30.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:15:13 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:15:11 +0200
From: Jan Stancek <jstancek@redhat.com>
To: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <Zvp6L+oFnfASaoHl@t14s>
References: <20240805201241.27286-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240805201241.27286-1-jack@suse.cz>

On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
>When the filesystem is mounted with errors=remount-ro, we were setting
>SB_RDONLY flag to stop all filesystem modifications. We knew this misses
>proper locking (sb->s_umount) and does not go through proper filesystem
>remount procedure but it has been the way this worked since early ext2
>days and it was good enough for catastrophic situation damage
>mitigation. Recently, syzbot has found a way (see link) to trigger
>warnings in filesystem freezing because the code got confused by
>SB_RDONLY changing under its hands. Since these days we set
>EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
>filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
>stop doing that.
>
>Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
>Reported-by: Christian Brauner <brauner@kernel.org>
>Signed-off-by: Jan Kara <jack@suse.cz>
>---
> fs/ext4/super.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>Note that this patch introduces fstests failure with generic/459 test because
>it assumes that either freezing succeeds or 'ro' is among mount options. But
>we fail the freeze with EFSCORRUPTED. This needs fixing in the test but at this
>point I'm not sure how exactly.
>
>diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>index e72145c4ae5a..93c016b186c0 100644
>--- a/fs/ext4/super.c
>+++ b/fs/ext4/super.c
>@@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>
> 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> 	/*
>-	 * Make sure updated value of ->s_mount_flags will be visible before
>-	 * ->s_flags update
>+	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
>+	 * modifications. We don't set SB_RDONLY because that requires
>+	 * sb->s_umount semaphore and setting it without proper remount
>+	 * procedure is confusing code such as freeze_super() leading to
>+	 * deadlocks and other problems.
> 	 */
>-	smp_wmb();
>-	sb->s_flags |= SB_RDONLY;

Hi,

shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
when user triggers the abort with mount(.., "abort")? Because now we seem
to always hit the condition that returns EROFS to user-space.

I'm seeing LTP's fanotify22 failing for a about week (roughly since
commit de5cb0dcb74c) on:

   fanotify22.c:59: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanqgL299/test_mnt fstyp=ext4 flags=21
   fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 33, 0x4211ed) failed: EROFS (30)

	static void trigger_fs_abort(void)
	{
		SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
			   MS_REMOUNT|MS_RDONLY, "abort");
	}

Thanks,
Jan


