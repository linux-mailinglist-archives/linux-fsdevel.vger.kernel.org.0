Return-Path: <linux-fsdevel+bounces-35401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A939D4A2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E65280D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD41CEAAF;
	Thu, 21 Nov 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvQbRRj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130331CB528;
	Thu, 21 Nov 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182328; cv=none; b=DjNR03pSLU9JNToNFxdgKMp0+7KrD/BcAUry/WsC8u+P/Oy5dGoraoV38AUafJjgBd12C+b0D1qnsuge7L6TaXVmh5GXdr5iypUaed2BoMQSUkAFhJDuNytXqpA18tS6M5FQ4iEzIKsBMAU/VYHsSKuaX6PnEtLuzR+BM6XXxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182328; c=relaxed/simple;
	bh=nR6Fy8BGli1AlLmlleeK5DC+YwdhxCJdaekFYFy9zek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZriyM8DirJkrN2CCKITsr4zpsdauDthvsbpFvwz5PUqzgOGZ6cdVxt1GtYQwRt6uX5dzC4sCDIKa1+tOJx2XEGxvKBjeKwqfqCHIaVOS9/NB4s7Z89knGrIcK4Xk3mx7SooMtHUR5ShKPKIeF3xReIrJFWo2FxLa56S7uUK7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvQbRRj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE788C4CECC;
	Thu, 21 Nov 2024 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732182326;
	bh=nR6Fy8BGli1AlLmlleeK5DC+YwdhxCJdaekFYFy9zek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvQbRRj4sm/HAswLm+uEPJpFCHenM3QhEJpdW/zRcI2UtBZ7xvMagK560XlqTAZs6
	 dwBJuxyD3zv0hZfM5Gfv1/rDiqxZjiIwzPe9upYWy5q3puSJlkr+zVXtY0HTQ03HL/
	 vO9kHutmP/K0tAjySseSOeJuW9lkoKW2heaaBct7nGk/F9LGX0g0Js6vc3vNmlu+BB
	 oPW8edpmXZUElFXTLG4qI6feF+rU5Ma9h3Ls+6tGVGS62b0HzNFZCuIS/X3f9bzo4P
	 N0NW2nNRz4DAq3gguneCMkCe0sqmNB01G8CDSBezQX9CUDqlHmY2h0wtXBtiCIYtCT
	 PhdRicjOZ55ng==
Date: Thu, 21 Nov 2024 10:45:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
Message-ID: <20241121-boxring-abhandeln-c2095863da2d@brauner>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120155309.lecjqqhohgcgyrkf@quack3>

On Wed, Nov 20, 2024 at 04:53:09PM +0100, Jan Kara wrote:
> On Fri 15-11-24 10:30:15, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> > 
> > Legacy inotify/fanotify listeners can add watches for events on inode,
> > parent or mount and expect to get events (e.g. FS_MODIFY) on files that
> > were already open at the time of setting up the watches.
> > 
> > fanotify permission events are typically used by Anti-malware sofware,
> > that is watching the entire mount and it is not common to have more that
> > one Anti-malware engine installed on a system.
> > 
> > To reduce the overhead of the fsnotify_file_perm() hooks on every file
> > access, relax the semantics of the legacy FAN_ACCESS_PERM event to generate
> > events only if there were *any* permission event listeners on the
> > filesystem at the time that the file was opened.
> > 
> > The new semantic is implemented by extending the FMODE_NONOTIFY bit into
> > two FMODE_NONOTIFY_* bits, that are used to store a mode for which of the
> > events types to report.
> > 
> > This is going to apply to the new fanotify pre-content events in order
> > to reduce the cost of the new pre-content event vfs hooks.
> > 
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> FWIW I've ended up somewhat massaging this patch (see below).
> 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 23bd058576b1..8e5c783013d2 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -173,13 +173,14 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> >  
> >  #define	FMODE_NOREUSE		((__force fmode_t)(1 << 23))
> >  
> > -/* FMODE_* bit 24 */
> > -
> >  /* File is embedded in backing_file object */
> > -#define FMODE_BACKING		((__force fmode_t)(1 << 25))
> > +#define FMODE_BACKING		((__force fmode_t)(1 << 24))
> >  
> > -/* File was opened by fanotify and shouldn't generate fanotify events */
> > -#define FMODE_NONOTIFY		((__force fmode_t)(1 << 26))
> > +/* File shouldn't generate fanotify pre-content events */
> > +#define FMODE_NONOTIFY_HSM	((__force fmode_t)(1 << 25))
> > +
> > +/* File shouldn't generate fanotify permission events */
> > +#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))
> 
> Firstly, I've kept FMODE_NONOTIFY to stay a single bit instead of two bit
> constant. I've seen too many bugs caused by people expecting the constant
> has a single bit set when it actually had more in my life. So I've ended up
> with:
> 
> +/*
> + * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shouldn't be
> + * generated (see below)
> + */
> +#define FMODE_NONOTIFY         ((__force fmode_t)(1 << 25))
> + 
> +/*
> + * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't be
> + * generated (see below)
> + */
> +#define FMODE_NONOTIFY_PERM    ((__force fmode_t)(1 << 26))
> 
> and
> 
> +/*
> + * The two FMODE_NONOTIFY* define which fsnotify events should not be generated
> + * for a file. These are the possible values of (f->f_mode &
> + * FMODE_FSNOTIFY_MASK) and their meaning:
> + *
> + * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
> + * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
> + * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
> + */
> +#define FMODE_FSNOTIFY_MASK \
> +       (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)

This is fine by me. But I want to preemptively caution to please not
spread the disease of further defines based on such multi-bit defines
like fanotify does. I'm specifically worried about stuff like:

#define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
                                  FS_OPEN_EXEC_PERM)

#define FS_EVENTS_POSS_ON_CHILD   (ALL_FSNOTIFY_PERM_EVENTS | \
                                   FS_ACCESS | FS_MODIFY | FS_ATTRIB | \
                                   FS_CLOSE_WRITE | FS_CLOSE_NOWRITE | \
                                   FS_OPEN | FS_OPEN_EXEC)

