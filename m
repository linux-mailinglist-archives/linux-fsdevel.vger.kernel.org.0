Return-Path: <linux-fsdevel+bounces-32624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D342C9ABA28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 01:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A50B225EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 23:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FCA1CEAAB;
	Tue, 22 Oct 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+nL3zhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22395126C05;
	Tue, 22 Oct 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640736; cv=none; b=E7pXGP7pwM+GsnXaEfBvOKlI6SuO9Kp0xsX2tdiMEdO9ZezywX4WUbrRDO3LsIF6D8waAoDUYDrVrmksrtxrqZd6m4ZikiuzejlN+veUzn2QAt7Pm3MTTxM2eOX/KyUUneQUy/9+rfSZmQtKtcj7yyIV+4PkZik0GbtCfwTh4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640736; c=relaxed/simple;
	bh=FsNa0rY+97sZWfMfUvrwVGGHvKuO14aRfQ/UP02SLV0=;
	h=Message-ID:Subject:From:To:Cc:Date:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SjrLnA4YRJk2FNqof2dQzanyjnlYC/aOAdz0pPaOD8hxpbwBAuvYr3jCml/jcX8HlmK54ko0XACSoujFWyPfJUHkUGl2oQQuSquwNGAqXNB6mv/f2gAK8YsvFrm+t01StABMAqbpYn/mhsszXvqLtm+2bitOj+AT+/CtAZ46zHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+nL3zhr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so63627585e9.1;
        Tue, 22 Oct 2024 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729640733; x=1730245533; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to
         :references:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I0tIfA2sU5ByEjOFtzmpRLrhRDpAKXDbsxmXWLszvyU=;
        b=T+nL3zhrWNq/f/jxcyP7CWz0nFACziCDpMQmFCTDzWgrQf71uBOyWjJkZmsaOebiSo
         KY4y2ju2/EHIeIRWZZ6Y/q5FoIrsej8BZat2kzTocyicaOu+WcM/d9MhiDkIK7L38NoC
         QxtnfrI1AujqkkeA3uNaSwrKl8vw18xGo705I7wdjv/1k2K8CoZ4l8FUSMnbE/T/YL/2
         WMECMOulruxk1WkALL88cgmeZ9Xff4JIXEITSxRE/IDYoHqGk1jGHk1vy8aIy21GjMLs
         teFlaxbF0/Y3BePwrCPugFY9aOtP+438hGWPhdw/62UG/j6INeI56ShdxGkemtPq0UdL
         IOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729640733; x=1730245533;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to
         :references:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0tIfA2sU5ByEjOFtzmpRLrhRDpAKXDbsxmXWLszvyU=;
        b=t0H0zaeAwZeXmxbzN93caY1uxAp32o77FZvLwJdYFnAsb23Npdxn/UOCHAEBaigdic
         ShP8oDBlc4zWU6wumKFzFbzwqZz8s548DQoyA1OGVGtURt3Kul8EV/DXXzsdS149SCvc
         Gsvya0zavfWMJE4lavkBQNV6LHHDtZFF6P/3zCs61CQA35Y16mkciqOHd7Ce3bhl6Z4g
         k/aLXADZpfzlg0CbbntPK4RorYHH8DlHxPCxOyf9+YdddjM3e47QbXgWesm2Wf8B0+VB
         PuWv9u52rMsnhwQ5S/JbSfZSyNqpKlCCa7aC6DKTHgwXl3azjzBNCPVJonvt/AM8Iw4/
         UXNg==
X-Forwarded-Encrypted: i=1; AJvYcCUw7d1zZydh7GjsSXRkn3jZDj0DgKTs6hAyu9tXq0nVO0D8qN+0vHTmlf1EgsecQbBTeNOmn3T3CyMc+gtB@vger.kernel.org, AJvYcCVlHWmIuWYgF60DIqHLYLqDvsmeiq7gnSvaRwX5iAZ7Pn0DVZOHK6wIVcUN66/xdEHXr5Hz6GNQIbNpAXgzNj0RFHQH/JGs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jOpMis92A/bAveKYqMButH/3K7R3ZWXnrZUqeaqZLC9w/SFk
	9x7jWYm1uB/SCBxAIZclf1QTRfUcM0UsaScOcM+H2q6Yn+DxDd4e
X-Google-Smtp-Source: AGHT+IEgFWlE+I5K0e8jqZS0fBe730rWwqBTs35SqG9TDE8VoP0pf9y42NVbh7cdFmlq+gxBxk6AZg==
X-Received: by 2002:a05:600c:1d87:b0:42f:8ac6:4f34 with SMTP id 5b1f17b1804b1-431841ab121mr4662565e9.35.1729640733093;
        Tue, 22 Oct 2024 16:45:33 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:d036:ae00:21cd:def0:a01d:d2aa? ([2a01:4b00:d036:ae00:21cd:def0:a01d:d2aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b4dsm7622709f8f.18.2024.10.22.16.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 16:45:31 -0700 (PDT)
Message-ID: <5fe2d1fea417a2b0a28193d5641ab8144a4df9a5.camel@gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
From: luca.boccassi@gmail.com
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Wed, 23 Oct 2024 00:45:30 +0100
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
		<CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com>
		<CAMw=ZnSkm1U-gBEy9MBbjo2gP2+WHV2LyCsKmwYu2cUJqSUeXg@mail.gmail.com>
		<CAHC9VhRY81Wp-=jC6-G=6y4e=TSe-dznO=j87i-i+t6GVq4m3w@mail.gmail.com>
In-Reply-To: <CAHC9VhRY81Wp-=jC6-G=6y4e=TSe-dznO=j87i-i+t6GVq4m3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 5 Oct 2024 at 17:06, Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Oct 4, 2024 at 2:48=E2=80=AFPM Luca Boccassi <luca.boccassi@gmail=
.com> wrote:
> > On Wed, 2 Oct 2024 at 15:48, Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Oct 2, 2024 at 10:25=E2=80=AFAM <luca.boccassi@gmail.com> wro=
te:
>
> ...
>
> > > [NOTE: please CC the LSM list on changes like this]
> > >
> > > Thanks Luca :)
> > >
> > > With the addition of the LSM syscalls we've created a lsm_ctx struct
> > > (see include/uapi/linux/lsm.h) that properly supports multiple LSMs.
> > > The original char ptr "secctx" approach worked back when only a singl=
e
> > > LSM was supported at any given time, but now that multiple LSMs are
> > > supported we need something richer, and it would be good to use this
> > > new struct in any new userspace API.
> > >
> > > See the lsm_get_self_attr(2) syscall for an example (defined in
> > > security/lsm_syscalls.c but effectively implemented via
> > > security_getselfattr() in security/security.c).
> >
> > Thanks for the review, makes sense to me - I had a look at those
> > examples but unfortunately it is getting a bit beyond my (very low)
> > kernel skills, so I've dropped the string-based security_context from
> > v2 but without adding something else, is there someone more familiar
> > with the LSM world that could help implementing that side?
>
> We are running a little short on devs/time in LSM land right now so I
> guess I'm the only real option (not that I have any time, but you know
> how it goes).  If you can put together the ioctl side of things I can
> likely put together the LSM side fairly quickly - sound good?

Here's a skeleton ioctl, needs lsm-specific fields to be added to the new s=
truct, and filled in the new function:

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 4eaf30873105..30310489f5e1 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -115,6 +115,35 @@ static __poll_t pidfd_poll(struct file *file, struct p=
oll_table_struct *pts)
        return poll_flags;
 }
=20
+static long pidfd_security(struct task_struct *task, unsigned int cmd, uns=
igned long arg)
+{
+       struct pidfd_security __user *usecurity =3D (struct pidfd_security =
__user *)arg;
+       size_t usize =3D _IOC_SIZE(cmd);
+       struct pidfd_security ksecurity =3D {};
+       __u64 mask;
+
+       if (!usecurity)
+               return -EINVAL;
+       if (usize < PIDFD_SECURITY_SIZE_VER0)
+               return -EINVAL; /* First version, no smaller struct possibl=
e */
+
+       if (copy_from_user(&mask, &usecurity->mask, sizeof(mask)))
+               return -EFAULT;
+
+       // TODO: fill in ksecurity
+
+       /*
+        * If userspace and the kernel have the same struct size it can jus=
t
+        * be copied. If userspace provides an older struct, only the bits =
that
+        * userspace knows about will be copied. If userspace provides a ne=
w
+        * struct, only the bits that the kernel knows about will be copied=
.
+        */
+       if (copy_to_user(usecurity, &ksecurity, min(usize, sizeof(ksecurity=
))))
+               return -EFAULT;
+
+       return 0;
+}
+
 static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigne=
d long arg)
 {
        struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg=
;
@@ -160,7 +189,7 @@ static long pidfd_info(struct task_struct *task, unsign=
ed int cmd, unsigned long
         * the flag only if we can still access it.
         */
        rcu_read_lock();
-       cgrp =3D task_dfl_cgroup(current);
+       cgrp =3D task_dfl_cgroup(task);
        if (cgrp) {
                kinfo.cgroupid =3D cgroup_id(cgrp);
                kinfo.mask |=3D PIDFD_INFO_CGROUPID;
@@ -209,9 +238,11 @@ static long pidfd_ioctl(struct file *file, unsigned in=
t cmd, unsigned long arg)
        if (!task)
                return -ESRCH;
=20
-       /* Extensible IOCTL that does not open namespace FDs, take a shortc=
ut */
+       /* Extensible IOCTLs that do not open namespace FDs, take a shortcu=
t */
        if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
                return pidfd_info(task, cmd, arg);
+       if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_SECURITY))
+               return pidfd_security(task, cmd, arg);
=20
        if (arg)
                return -EINVAL;
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 4540f6301b8c..0658880a9089 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -65,6 +65,14 @@ struct pidfd_info {
        __u32 spare0[1];
 };
=20
+#define PIDFD_SECURITY_SIZE_VER0               8 /* sizeof first published=
 struct */
+
+struct pidfd_security {
+       /* This mask follows the same rules as pidfd_info.mask. */
+       __u64 mask;
+       // TODO: add data fields and flags and increase size defined above
+};
+
 #define PIDFS_IOCTL_MAGIC 0xFF
=20
 #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
@@ -78,5 +86,6 @@ struct pidfd_info {
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
 #define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 11,=
 struct pidfd_info)
+#define PIDFD_GET_SECURITY                    _IOWR(PIDFS_IOCTL_MAGIC, 12,=
 struct pidfd_security)
=20
 #endif /* _UAPI_LINUX_PIDFD_H */


