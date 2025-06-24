Return-Path: <linux-fsdevel+bounces-52747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C33AE6317
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A444029E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143B28689C;
	Tue, 24 Jun 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEoN6U56"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56E27AC21;
	Tue, 24 Jun 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762642; cv=none; b=QW5U+bkf1+qeuQEjpo09EqZqBskex6C1/qc94J8RI/2HUzb06D7Lvo2Q+TRFttLCvoVUdbxeQc3810il48V9TCsjc+huqwZ/0z3/rrmeXaQwErLreQke4G2TZimruyY5MvXBu36TaN1FqJ0L0ojNGn5SLC7X8V00Be6ydE6r/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762642; c=relaxed/simple;
	bh=zPSKwoum7a6hQTTc/ADw+Y9+hrLT3Y2gJRrsfEeQU0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nO0d9u2EsySINB8al1phGneWTpHTxOee3T+JlfLcvnIrhyKV6KEWBW1hzP/VOV6CRI3MPxpIsrM8pcYPc4MaVC14T6JN8jz6xl7dbgBZH13S7yJ1fWCT/bpLaGveYU8tBWQXGgxUA1Hm5u9g5MPA0NFZgvQSwLW6OoHVBBFiB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEoN6U56; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-addcea380eeso852423666b.0;
        Tue, 24 Jun 2025 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750762639; x=1751367439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLq1L0EWWU7GtpochT1z4J5eWTxXJCSIvQ/2JaOs7Og=;
        b=aEoN6U56LK+34gglgm4po+n670nr8A6G7hWQFdaCTKC/6Ti6izTY2Ea/gneMOkD6AS
         ryfKcPgEPowPX8a0WORz3RdopkNp6VmGGDE3P6iLRQgEyZbwQC1UpX7FWnP2tUyyiiaN
         6nAlDvFiI+sklKW2NI60es/BtTrep6dzArsJgjDmXELzrzCVowfItxTw23Y1hYFkbLgp
         IQeFaY+BfKAjMxi81odO7DZJ03JhF1gOasNfbvyAuc+zDP+0R56ifhm5QkaNUjE6aXPs
         gVGTip2n7l5NoIrROgoeDDVJ5nnCRbih5Ifkzav+XbR8glXV/6xi51wqYS/6SivY0dse
         Z+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762639; x=1751367439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLq1L0EWWU7GtpochT1z4J5eWTxXJCSIvQ/2JaOs7Og=;
        b=win1hoGFYHgFDosPUTS/jt2E7pts8+PmIovBaFiv2nY3KeY6KxG4WzxXb/b7Jkuia/
         5OD5jVr9a4FiVgJMBFsJ/vZGEB2rDPnmbnHQUl/Arw2Xj6zNdqfHNwJytYCZ8HFtQInF
         zuJ9KPZCIyrlOpLABSUuGwRyWoO4SMnO2+iZC3FxclO0UYhZP8sXR1X3GhqBGF3kP+c2
         9gblTxl2bowW0/B1Grg9U80u5ioAmf6B6gHSrtwNR28IlfGBbEHB6Ei4C6S8PEKfngon
         wupfekvvM9hbWQT4JHFcb7Bq+JhdEzo8R+PWS25FteHYKOqWELOGHIMVPvrVQtZMchdc
         GMIA==
X-Forwarded-Encrypted: i=1; AJvYcCU5PwisixG7bXtZMWrwBBm3NnvrFxLJt2s7Jf//VuEiVzZVVOWcYjukRBbRT2J1/h/7lJABMJO1DLWe@vger.kernel.org, AJvYcCW/SxURnSZG5J5uQUi6Vxhd3eBNXGyVpRA8q6gS8cTjRHKhBEs3QhkYqsVE0TXdHmVRezSjw07ghkC9SbzE@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtLazAqVkTjIi/OEgFDt3m2mnpwLoHaD38HcuDLFISbxtEjhs
	iAvJsEDtwGw8agJpIPLvb2t65RKsmplCcHO+B9z8EI8g5ip/6gzUtz6QQLpbG2bcO/3IoncS3AY
	TtYu3FOhaYjRRKWtu0ql7ScvljvctbyU=
X-Gm-Gg: ASbGncuQsmVZ5wgwen1hqYD+lS2i99XlbmOthheXJxT5JbVXAgXpOBtAhbNx+P8R61K
	ogSJavTqQSxk22okqE+XgKJCr0bjYEB2rMBHvqPFzDEsIrwiT9Ede9Ps36g/nh+eDkiqtTS7DWA
	rj6MSqTFNYfJHcnBtgY5Hq2TvM6omPfWSbJeBakUcuTtg=
X-Google-Smtp-Source: AGHT+IF4zKwKtgUMfJxfj4AdEvqHzih9vm1ZJ/MHTuIUOVpA0hjSXD40LPY+UrakkNzyIP5Mi0mEx+1OMGgw0Gh6pJI=
X-Received: by 2002:a17:907:bd13:b0:ad8:a41a:3cc5 with SMTP id
 a640c23a62f3a-ae057c81dacmr1495392166b.6.1750762638528; Tue, 24 Jun 2025
 03:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org> <20250624-work-pidfs-fhandle-v2-6-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-6-d02a04858fe3@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 12:57:06 +0200
X-Gm-Features: Ac12FXxmm3Kdx6wDCNrQJ5oXhv1Dfi4W95I-yKPcfzc5MOJki3O3kl-B06v8-o8
Message-ID: <CAOQ4uxjiys1gHWy5eOMzwRqWzNJ-Tb8t+g3F0FFkmhVM3=ju0w@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] uapi/fcntl: mark range as reserved
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:29=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Mark the range from -10000 to -40000 as a range reserved for special
> in-kernel values. Move the PIDFD_SELF_*/PIDFD_THREAD_* sentinels over so
> all the special values are in one place.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/uapi/linux/fcntl.h            | 16 ++++++++++++++++
>  include/uapi/linux/pidfd.h            | 15 ---------------
>  tools/testing/selftests/pidfd/pidfd.h |  2 +-
>  3 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index a15ac2fa4b20..ba4a698d2f33 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -90,10 +90,26 @@
>  #define DN_ATTRIB      0x00000020      /* File changed attibutes */
>  #define DN_MULTISHOT   0x80000000      /* Don't remove notifier */
>
> +/* Reserved kernel ranges [-100], [-10000, -40000]. */
>  #define AT_FDCWD               -100    /* Special value for dirfd used t=
o
>                                            indicate openat should use the
>                                            current working directory. */
>
> +/*
> + * The concept of process and threads in userland and the kernel is a co=
nfusing
> + * one - within the kernel every thread is a 'task' with its own individ=
ual PID,
> + * however from userland's point of view threads are grouped by a single=
 PID,
> + * which is that of the 'thread group leader', typically the first threa=
d
> + * spawned.
> + *
> + * To cut the Gideon knot, for internal kernel usage, we refer to
> + * PIDFD_SELF_THREAD to refer to the current thread (or task from a kern=
el
> + * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thr=
ead
> + * group leader...
> + */
> +#define PIDFD_SELF_THREAD              -10000 /* Current thread. */
> +#define PIDFD_SELF_THREAD_GROUP                -10001 /* Current thread =
group leader. */
> +
>
>  /* Generic flags for the *at(2) family of syscalls. */
>
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index c27a4e238e4b..957db425d459 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -42,21 +42,6 @@
>  #define PIDFD_COREDUMP_USER    (1U << 2) /* coredump was done as the use=
r. */
>  #define PIDFD_COREDUMP_ROOT    (1U << 3) /* coredump was done as root. *=
/
>
> -/*
> - * The concept of process and threads in userland and the kernel is a co=
nfusing
> - * one - within the kernel every thread is a 'task' with its own individ=
ual PID,
> - * however from userland's point of view threads are grouped by a single=
 PID,
> - * which is that of the 'thread group leader', typically the first threa=
d
> - * spawned.
> - *
> - * To cut the Gideon knot, for internal kernel usage, we refer to
> - * PIDFD_SELF_THREAD to refer to the current thread (or task from a kern=
el
> - * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thr=
ead
> - * group leader...
> - */
> -#define PIDFD_SELF_THREAD              -10000 /* Current thread. */
> -#define PIDFD_SELF_THREAD_GROUP                -20000 /* Current thread =
group leader. */
> -
>  /*
>   * ...and for userland we make life simpler - PIDFD_SELF refers to the c=
urrent
>   * thread, PIDFD_SELF_PROCESS refers to the process thread group leader.
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selfte=
sts/pidfd/pidfd.h
> index efd74063126e..5dfeb1bdf399 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -56,7 +56,7 @@
>  #endif
>
>  #ifndef PIDFD_SELF_THREAD_GROUP
> -#define PIDFD_SELF_THREAD_GROUP                -20000 /* Current thread =
group leader. */
> +#define PIDFD_SELF_THREAD_GROUP                -10001 /* Current thread =
group leader. */

The commit message claims to move definions between header files,
but the value of PIDFD_SELF_THREAD_GROUP was changed.

What am I missing?

Thanks,
Amir.

