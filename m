Return-Path: <linux-fsdevel+bounces-49485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B7ABD16B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00382179C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 08:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD125DD1E;
	Tue, 20 May 2025 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deabvDB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738CF212FB8;
	Tue, 20 May 2025 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728330; cv=none; b=KN+POlaI4I5OBk8IqyHbZC8LPSRsIHQG3WyUZKehEH/kmgDIe0ilHXrrN1PH/OMEo3LMssLEhOFJknfHABAzmKU3PpsEch6fVaNTqfHsg3kiH33g/1lO7Vf+Tpn8Z8uYOoawraMfazeitCAKyeyes7uJ89uiVCnTp81+FR5iyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728330; c=relaxed/simple;
	bh=JR57pZ1HByRrhf92K1jrgg2JNrFtpgD4QQI5ZYZgONk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDATCfLkvJgyE/rFukl/y2tc1S0fIMGYysiAqM7tPLb7fPcWPHVnggrtsBjtSx844ZnaavTftZ+Oe2Z1mY7cfOwEnADsscINF5DuIOD0T8YvcOeMzOHRnll32uv1fRZnkZ0hLe1szWci1ABroMdr+uMVanDjnIByZJeZk5lVc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deabvDB2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6021d01298cso67914a12.3;
        Tue, 20 May 2025 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747728327; x=1748333127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9I7rP4M4yCmXtCFSSopzacSCExCy5zEsmTeQ8DMKvQ=;
        b=deabvDB2zwj6fFO/mVfZdbNTA9Lq1tK47ouwzFD8Q1d2lDjTX1Lx0X87u52yHFsY3q
         owEErFr4qU6+BRFt4+LP9I2xlyLCrqsgwWJGbhqPPgF/sjosYl5MmZuv+GRTl3NsZ0yD
         8eappmIAXS19QM/WFkvIBxTfmskHY3VvcxYT2MDtRWePR8ESQgtfV39riEufwQ78aQWy
         M+ZNyeHU0ymhwhM+Pj9lAdNmS8G473r/3yC0qvuvFttFvrFNf0DMzEJgQvirGvdk4BRK
         UtubT+NgTk7wGKkAvMrQlY9kxNMvXEZ1meEeqWbkF5hiP4LeBU8X0PujQWxTsD6eaNt1
         MN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747728327; x=1748333127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9I7rP4M4yCmXtCFSSopzacSCExCy5zEsmTeQ8DMKvQ=;
        b=amiU6q5usvamAe73/MDnsHFx56UvZ6/j4gi8izfqj0pOBMOWzU0ZA3RxNNkn420ppI
         Xl/QOpwlCQ2NVoOd1q2q2yBoPTMLp1wlOfdjzgq+rmINPWHgBb2ujrzJFm5HzM/JnPK0
         uBbCn95XwIVpdvASOPUuGhl7ffb+Z8OBIAVKsXhYGWx9hFNUQukYm+xEJu6Y7395LOVJ
         riRu5WAL6tPUkOUHmUapRetGUyUhQcLbNqZl63baXlObXntcnl2xggfI9Z4l0cn7ruro
         Fhr4xBf3oVOXbIE+skeE0+w7zAX3FvrVkwr6EzEeUaYL54c7+K0I1lU+eNU87PIfCxZ4
         UEMA==
X-Forwarded-Encrypted: i=1; AJvYcCVQVikStRwhXUNEU3Mle4EqbDv2IM55Id+Q9ufSpzPgj4/Jy3AIRS2aLh37/EfAc850IaFcJJNes9F0nzPF/A==@vger.kernel.org, AJvYcCXTIvctBzIwtX2Rqrr1ix5ocaDamay/FCQWDl3Qm7FErJ1oXCfP/M6y2X6HwTupr0w9L2UvErhPCPqN2DOW@vger.kernel.org, AJvYcCXgNT4+cgB+JZoFhA0Lk5jYYAd3OXz9dIhSQum7KJrrxx/LgHWd7ThIh9RX/KqZ2L8jjwB6vMyH6dT7cEPnsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYC8+uqtVMzTccb3leXzJQCznlnfT1EXQkBA9HYbgnJJ62GLx
	YLns8aN3nBPxEhds3d1zc6T/d3WBtgJxiQiCjTEyBwiwYYcPI3buFkybxvjhH0Gbi533De+8L8V
	tF7uondBdrCsvabaT/tHYC9MPCUQuIj8=
X-Gm-Gg: ASbGncu6zQ/vGLEnDHXY1/KW/cK7R8FAvs2f86LN2XWYfralrAr7ZvW6ah6ZIocdtVZ
	hGfnXqfW5HtwBLwMW9oEzIuW7rmu9PffhHhSl+ICpMlxvoq7GIrnYIQREAMfUIT/nptvA7mSRNR
	NMXkYMBJ8/tCVKJNppYpu7xlvsfnS1HI47
X-Google-Smtp-Source: AGHT+IFY1jN0nUINWAznHYhlgE6xZL8U6IPHM8alhc3DwvleXkkArjDV4AZFltkqlyZckqPQ5oIx2qZoC2UmUisZ2ow=
X-Received: by 2002:a17:907:268a:b0:ad5:eff:db32 with SMTP id
 a640c23a62f3a-ad536de9517mr1261607666b.48.1747728326074; Tue, 20 May 2025
 01:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
In-Reply-To: <20250520051600.1903319-1-kent.overstreet@linux.dev>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 May 2025 10:05:14 +0200
X-Gm-Features: AX0GCFuFQrDONvSfR8Y_Mf2EsqWLcTxhUjONRoK8I3nNLmrI5PDpEqDCnwJHZpI
Message-ID: <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:16=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> This series allows overlayfs and casefolding to safely be used on the
> same filesystem by providing exclusion to ensure that overlayfs never
> has to deal with casefolded directories.
>
> Currently, overlayfs can't be used _at all_ if a filesystem even
> supports casefolding, which is really nasty for users.
>
> Components:
>
> - filesystem has to track, for each directory, "does any _descendent_
>   have casefolding enabled"
>
> - new inode flag to pass this to VFS layer
>
> - new dcache methods for providing refs for overlayfs, and filesystem
>   methods for safely clearing this flag
>
> - new superblock flag for indicating to overlayfs & dcache "filesystem
>   supports casefolding, it's safe to use provided new dcache methods are
>   used"
>

I don't think that this is really needed.

Too bad you did not ask before going through the trouble of this implementa=
tion.

I think it is enough for overlayfs to know the THIS directory has no
casefolding.

in ovl_lookup() that returns a merged directory, ovl_dentry_weird() would
result in -EIO if any of the real directories have casefolding and we can a=
dd
another sanotify in ovl_lookup_single() that the 'base' dentry is not weird=
()
to cover the case of casefolder changed on an underlying reference director=
y.

Obviously, if any of the overlayfs layer root dirs have casefolding enabled=
 the
mount would fail.

w.r.t enabling casefolding underneath overlayfs, overlayfs documentation sa=
ys:

"Changes to underlying filesystems
---------------------------------

Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed.  If the underlying filesystem is changed,
the behavior of the overlay is undefined, though it will not result in
a crash or deadlock."

So why is enabling casefolding on underlying layers so special that we
should have specific protection for that?

From what I remember in ext4, enabling casefolding is only allowed
on empty directories.

Is this also the case for bcachefs?

If that is the case, then the situation is even simpler -
If filesystem can singal to vfs/ovl that directory is empty (i.e. S_EMPTYDI=
R)
then overlayfs can ignore this dir altogether when composing
the merged directory.

But again, I don't think there is a good reason to treat this case
of changing the underlying layer specially.

Please explain if I missed anything.

Thanks,
Amir.

