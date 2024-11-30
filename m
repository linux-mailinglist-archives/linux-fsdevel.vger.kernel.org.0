Return-Path: <linux-fsdevel+bounces-36188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B729B9DF2FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 21:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AEA162D42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F71AAE00;
	Sat, 30 Nov 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqK9O5j4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FC2F2A;
	Sat, 30 Nov 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732998518; cv=none; b=j9TlqGcQLbcuq6dJFrzywaTU7ZWhpug68gVAHv5P5l0WWYmYyI74JnZmNrvxt7NpaU06ykXsMpAxNnUJ3oaxF6MltPxFrot/aKLrrMuCeQAlL3VlHoLy74C7sPizXJ7DqB3U4Nn013FLHzdBWW3K7vZPBDYz6L2JkF5/ELjdYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732998518; c=relaxed/simple;
	bh=0r1qCaNQ8896psz/23Amr/8t26Zd2P1fIR7fO/MWjKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz9qcs7J8D0FYg+47kwdibv4bjaLg57sFAEIaOXCOzNpkfgVhxAkBjdVd/PAAFH7ufpgHaBNxXrzaR1wDQ5S/b/14qqauyfspmh/z6a26qzTGVag96MYzM/wgaPvr9taH8mdNFL2oEqqKSbRogY3MJy4sD6+myCYQxQosWo1aHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqK9O5j4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0bd12374cso916627a12.3;
        Sat, 30 Nov 2024 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732998515; x=1733603315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WyuIvPsDL28UptMe7uSjLO9ElhKUA/RSz9Xy4L6BC4E=;
        b=lqK9O5j4stJp6qfvAnk1cQnvJzO2qMMTGGaPcxkenociS08w4P6z0dQUHYK4ElAkZy
         Lbl4PkoPDCrAb91AwPdwrBkykvEj50QIVG1iVpto1xviyRe9Jw9cNe0FkN+TWlUuAxjf
         EdMIuTG173SMnXSYIBz42oZzJ58K5CbtxtXLW8Rm8EIdJlA5fraUxSRdPm/4+XTN7zGY
         5JGBY8CurNuh19wruZDDuCq9NA3/jCvGvqe8a2QWGjAhanLr7j5XDiZArGprulEUPO92
         UAuYYModXA64eOZBXOWHZTzECqg4e6s8vjIQbiYtWNJ0Xt/dztQb4NwUD7otyQ0YvLcW
         bhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732998515; x=1733603315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyuIvPsDL28UptMe7uSjLO9ElhKUA/RSz9Xy4L6BC4E=;
        b=CyoBpMOlHAcW0X2JsYtz0qBN4qXmFfJqOibFYWZvNEeg0CJ0UaWjpcvjJC2sWSB0Q+
         4RDcMYJQ1NqR4R8JYgmGkqRQr/kjrneL7Rh1N8J0IOEwJ+wrEFk3HkcWu0+hfDbbuBWZ
         ZyajXTiKLweOSknYrXpSTvT3hznGw7QLTzFzxo6RdwsskaeDWKaKDvgCSQTPKo9QGU0j
         Mky0FOs0XwTKGdM/CjcFtmzFM1xaPCl9rDSHgXI/wRRbIVRVrHfMY4qZJ6UmVUl5Qqwu
         s63zKYBDyOG5olxuWaKg5xy23FO41vfnOa5thBrcIluwbSl1ClOqyHfudjRUcHOLB+02
         s7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmJt4hbXlO3C55+H7rkwc55+3W8QBtjDLB4P0INMatQk5ZoDesntU+Ck3bDmK5e8Ek9jwJXzD2rL6FxvT8S9bz@vger.kernel.org, AJvYcCVCvuLEC+lyVnVY1WGo47TuFuAFjG5hEXlhQREWZk3qvFPe5tzx8umuAt7+gjVCQ7M8UXZbJLSz/3xYIbOf@vger.kernel.org, AJvYcCXe2qPdn1jPZD+qsbrt8wDYY/bRZOgaIX+UxjYnDnAdNvXq2Qo13X6HtcWQ4nxvRxbdoEZTRIMQ0oKuS7rW@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrdekGjwCyAE8V9GeGR50Mr75/mfOmHZmeZbJgwMMsNXYf3Y0
	oxJzh/yGP4hIeiRsKE2PZjX/FvjZMj9+glie2R66ZPg6GD7cgcgu
X-Gm-Gg: ASbGncs21UuXBwH710/WSySMRIG2sqOZKR3aKsI2KnSjiW2A+EA/jFcA796YRvkY5WR
	9bPEz9AL/cHj06YU9CWbj75SKWfFcH1vNQiTWuY64+XX8C+oYqLnPJoazC3cf4bd8HFGVGiPm91
	EVBcrqp0sQv6kXPWc18Vc1Lckmiv8rmsDMpes5P+sxflMW+C7NlD+wO077OPjug234p/Q7Hvv4/
	3QcE3tKZbVLdUv9QW4qe7/Lv8ZaWdhw9xNvAV/MmSzR8FwnmMjMc2RBhraO6e4cgw==
X-Google-Smtp-Source: AGHT+IH71PGkxMLJ3V53CD3l5A9uWkt1XBSzU+Pr2sONfbSmaJosGfTGrGB9uADN9NjOgAmOY2YJyw==
X-Received: by 2002:aa7:d889:0:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5d0c6971f0dmr6845571a12.17.1732998514576;
        Sat, 30 Nov 2024 12:28:34 -0800 (PST)
Received: from f (cst-prg-87-214.cust.vodafone.cz. [46.135.87.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd685csm3129447a12.44.2024.11.30.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 12:28:33 -0800 (PST)
Date: Sat, 30 Nov 2024 21:28:07 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Tycho Andersen <tandersen@netflix.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <ej5vp7iifyy4s2faxsh72dytcfjmpktembvgw6n65sucyf77ze@gmbn2bjvdoau>
References: <20241130045437.work.390-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241130045437.work.390-kees@kernel.org>

On Fri, Nov 29, 2024 at 08:54:38PM -0800, Kees Cook wrote:
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
> 
> When the filename passed in is empty (e.g. with AT_EMPTY_PATH), use the
> dentry's filename for "comm" instead of using the useless numeral from
> the synthetic fdpath construction. This way the actual exec machinery
> is unchanged, but cosmetically the comm looks reasonable to admins
> investigating things.
> 
> Instead of adding TASK_COMM_LEN more bytes to bprm, use one of the unused
> flag bits to indicate that we need to set "comm" from the dentry.
> 
> Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
> Suggested-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> 
> Here's what I've put together from the various suggestions. I didn't
> want to needlessly grow bprm, so I just added a flag instead. Otherwise,
> this is very similar to what Linus and Al suggested.
> ---
>  fs/exec.c               | 22 +++++++++++++++++++---
>  include/linux/binfmts.h |  4 +++-
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 5f16500ac325..d897d60ca5c2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1347,7 +1347,21 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		set_dumpable(current->mm, SUID_DUMP_USER);
>  
>  	perf_event_exec();
> -	__set_task_comm(me, kbasename(bprm->filename), true);
> +
> +	/*
> +	 * If the original filename was empty, alloc_bprm() made up a path
> +	 * that will probably not be useful to admins running ps or similar.
> +	 * Let's fix it up to be something reasonable.
> +	 */
> +	if (bprm->comm_from_dentry) {
> +		rcu_read_lock();
> +		/* The dentry name won't change while we hold the rcu read lock. */
> +		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
> +				true);

This does not sound legit whatsoever as it would indicate all renames
wait for rcu grace periods to end, which would be prettye weird.

Even commentary above dentry_cmp states:
         * Be careful about RCU walk racing with rename:
         * use 'READ_ONCE' to fetch the name pointer.
         *
         * NOTE! Even if a rename will mean that the length
         * was not loaded atomically, we don't care.

It may be this is considered tolerable, but there should be no
difficulty getting a real name there?

Regardless, the comment looks bogus.

