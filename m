Return-Path: <linux-fsdevel+bounces-10422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C384AF29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 08:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1D9284343
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CFC1292EE;
	Tue,  6 Feb 2024 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXfwOnSQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9013128818
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205483; cv=none; b=mZ2DjhdwpugmNnv4q/TECRCS2PzGZuT+aAGpvgrD91EPrVEq+CL7KCbvQZNNn5uMCa84g6EwMGuz86Vbkd3adAWAKdVDUE9D74XSus4gQ6F0BhPOv0Vz4xQcx/842E1Z81sCS+m2TCPLlG1GcLpHr6L8JKogcGsdmuxD0LOL+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205483; c=relaxed/simple;
	bh=SjqyPW0p6kbtGqVzx61CrTliBT2lzzuWXPGjWoMYuPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrlH8FjghPgv+130QuoHGUYVXKWywGHVNaO+5YzApSO3Axxk3gwkOTdOEYaiOUGhSAS9rymNMJyLEqxyy47tgnOoqzGKJBkTboiMu3QFSqHZoN5qc171Kb3kLxd5Y7I32UPJ2VydAD2ALSxib1DP0K2qyh6DQ3t6Wj+qxWKGhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXfwOnSQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68c3ac1fdb9so2811776d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 23:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707205481; x=1707810281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjqyPW0p6kbtGqVzx61CrTliBT2lzzuWXPGjWoMYuPQ=;
        b=jXfwOnSQw+FLFCoW0CxSHdpfkhXWsDW3QNTAIV1RKppvTS6Zj1d+QIzFJ4W28SjSxh
         yn8Hsqbzd+lBSRjKq9samgFXbzG2u8U61Wcy4/Winl0Q8ANgP8J/mCqchihpgdTNW9kz
         RhN0hUXMFW/2kz8orSYT7yHtp60p1jltifzQKOBPgmhoeqoDdYl1qdyMu/nh8DTBWdpz
         JoV/Qd80wCiqpH4VFUbG3SoYfd+tyFEyv8oG5KrVSuKA20Pgk81x72Hhp8VFuu2MdAoh
         pqlFZx5Prp4DvYmICgbieYUIw2mJmMTfYf/uV91wDdRvgHJ7csxGRjIVOxS5V2DsqIcs
         2Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205481; x=1707810281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqyPW0p6kbtGqVzx61CrTliBT2lzzuWXPGjWoMYuPQ=;
        b=R3Cv0d6TFWQ8s5dgXPDGKOYSxTLZFouZ4elKXxIPGSJUXiEJIr4tEbl+s10Xc9sohH
         mpfXJYK6wv79bFHEQh8axOz8mTYrtjNNHqxfI291rSxiMStnsfn2BRWpKjlnBz7K4cSg
         6QxeHGf42qf3nhwOd/2F7vRwpb5TYcgpfhtkWXCmdUz3mkR84zEiGC5JWN7MdegD00i0
         rbuwlWvDzrMhe44MFHxf7/glAOk6FaN/oMxz3C4/gVhdekf8ckZ7EAyun8RCsRNnCk4q
         5ouZQzAXA91S1HhFwv0/NiqYcW2d9xI7G4oVCfJvAGYbbIICYvMYuua0rnkt0cR9AFvT
         WjUA==
X-Gm-Message-State: AOJu0Yy4cSKmBkM9T3MkO2yn4hVVHrRz4byw4o2D3+z5KixYXPSpAWym
	ZVWmTgd00Ep7zt0WNKwW5/ju4MeG7aKtY5E7EvGLZ2KTPS9mxyGBMPjBeT421KABDYfOoJEewAi
	9empsZUJ2FP7wd2aKHSSFuZqim50zCL7LEFg=
X-Google-Smtp-Source: AGHT+IEPlJWtB+CmyZ4uRBKrTQZITLxNOEUhF5ltnWzHMEYKH3BMPPqMdGjCW2PCWnu4D6X8ai6ahV6pct0DiZ5d9y0=
X-Received: by 2002:ad4:5d49:0:b0:68c:8525:a349 with SMTP id
 jk9-20020ad45d49000000b0068c8525a349mr2121028qvb.29.1707205480769; Mon, 05
 Feb 2024 23:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
In-Reply-To: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 09:44:29 +0200
Message-ID: <CAOQ4uxgPY_6oKZFmWitJ-FTuV1YUWHMcNqppiCiMMk46aURMUA@mail.gmail.com>
Subject: Re: Fanotify: concurrent work and handling files being executed
To: Sargun Dhillon <sargun@sargun.me>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Sweet Tea Dorminy <thesweettea@meta.com>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:24=E2=80=AFAM Sargun Dhillon <sargun@sargun.me> wr=
ote:
>
> One of the issues we've hit recently while using fanotify in an HSM is
> racing with files that are opened for execution.
>
> There is a race that can result in ETXTBUSY.
> Pid 1: You have a file marked with FAN_OPEN_EXEC_PERM.
> Pid 2: execve(file_by_path)
> Pid 1: gets notification, with file.fd
> Pid 2: blocked, waiting for notification to resolve
> Pid 1: Does work with FD (populates the file)
> Pid 1: writes FAN_ALLOW to the fanotify file descriptor allowing the even=
t.
> Pid 2: continues, and falls through to deny_write_access (and fails)
> Pid 1: closes fd
>
> Pid 1 can close the FD before responding, but this can result in a
> race if fanotify is being handled in a multi-threaded
> manner.
>
> I.e. if there are two threads operating on the same fanotify group,
> and an event's FD has been closed, that can be reused
> by another event. This is largely not a problem because the
> outstanding events are added in a FIFO manner to the outstanding
> event list, and as long as the earlier event is closed and responded
> to without interruption, it should be okay, but it's difficult
> to guarantee that this happens, unless event responses are serialized
> in some fashion, with strict ordering between
> responses.
>
> There are a couple of ways I see around this:
> 1. Have a flag in the fanotify response that's like FAN_CLOSE_FD,
> where fanotify_write closes the fd when
> it processes the response.

That seems doable and useful.

> 2. Make the response identifier separate from the FD. This can either
> be an IDR / xarray, or a 64-bit always
> incrementing number. The benefit of using an xarray is that responses
> can than be handled in O(1) speed
> whereas the current implementation is O(n) in relationship to the
> number of outstanding events.

The number of outstanding permission events is usually limited
by the number of events that are handled concurrently.

I think that a 64-bit event id is a worthy addition to a well designed
notifications API. I am pretty sure that both Windows and MacOS
filesystem notification events have a 64-bit event id.

If we ever implement filesystem support for persistent change
notification journals (as in Windows), those ids would be essential.

>
> This can be implemented by adding an additional piece of response
> metadata, and then that becomes the
> key vs. fd on response.
> ---
>
> An aside, ETXTBUSY / i_writecount is a real bummer. We want to be able
> to populate file content lazily,
> and I realize there are many steps between removing the write lock,
> and being able to do this, but given
> that you can achieve this with FUSE, NFS, EROFS / cachefilesd, it
> feels somewhat arbitrary to continue
> to have this in place for executable files only.

I think there are way too many security models built around this
behavior to be able to change it for the common case.

However, I will note that technically, the filesystem does not
need to require a file open for write to fill its content as long as the
file content is written directly to disk and as long as page cache
is not populated in that region and invalidate_lock is held.

Requiring FMODE_WRITE for btrfs_ioctl_encoded_write()
may make sense, but it is not a must.
A more fine grained page cache protection approach is also
an option, a bit like (or exactly like) exported pNFS layouts.

IOW, you could potentially implement lazy filling of executable
content with specific file systems that support an out of band
file filling API, but then we would also need notifications for
page faults, so let's leave that for the far future.

Thanks,
Amir.

