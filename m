Return-Path: <linux-fsdevel+bounces-48619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB35AB179F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5075CA20686
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AA229B35;
	Fri,  9 May 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Z5JLOcyB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B45464E;
	Fri,  9 May 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801839; cv=none; b=HxjTIfBaDUbuBQgzt61AyZCDGXn6xZgtEGKVaPWPCKdquGga/mKlh4f/8UjIHNMQD3Gh2dLZuXxpM0wFa7GgdboRZGPbc+lKbeZpeK3yNRH/e/BWJG4NFYk53gwK+Ez9fRpeLSabKjwkdHdWGeRYge53yEJqg2GUirHcDNBxl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801839; c=relaxed/simple;
	bh=+SIz8H2NryAeqiW+Pvle4ziVLRoZN3AApm4/wJUziX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+BcUwLqcoPX8qrTupXaNpPLax+ffBG5Sc3/MlJwFb6Yzv2NUWvRfxCzdXGycXGyxPfkG5/E0GO9Hj/Ih0C+0BIdKEwG2aIKNktkVtQDfNkr+8/RXQCBBVAifVTH3AlFUY5ALZe0jB8crrLXRIQWkYxt2igFQHmdnwI4vdVyf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Z5JLOcyB; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746801809;
	bh=AZaOjnIgSfimwpcl7ft9DucIfRJNVVD2JqcSo2sn4ac=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=Z5JLOcyBB8xEDWt+9/aBuTojKX6D4/dUYjsvQkmsABFwN2FZ+mjZsjdWRszmxdO2P
	 S5QyeNw8KMw0FzUHStjieRE1ricWIVR0kvXyLo/C02xhyQA78OYwaYpOqpoKIwqswG
	 W+tOeQ16/xXh8kSZL8OLUlqNBXcOCdmD7ohsLItM=
X-QQ-mid: zesmtpsz8t1746801807tc8083172
X-QQ-Originating-IP: fs+WxjaPW35pn40BwlpPlYTMx6hs299q2xn28sMUofs=
Received: from mail-yb1-f178.google.com ( [209.85.219.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 22:43:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8849797088594148024
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e78e53cc349so2259215276.0;
        Fri, 09 May 2025 07:43:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxXNUOSO+Ht7AfLUQqUzemiJ1K6n8EvNIDD/ktyuYplYGJ3GhJDLFnxdwEmNo3BQf62U/GkHGqO2T+olmd@vger.kernel.org, AJvYcCWV33qZkx9TAbadIwZc2sWjkYJ9GqW1kBN+OXEFYxVMzvl/qPKeaifxMHgFU4wiEG0RhJBNYHJAEm0MtEBs@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrp1HPWu57bt/yPvFWRRTTHMgWW2QOFM8gYUIFBvCje8vC3qNb
	op8mcsXeuktfpHbVU2t+yiTjwQgHu5+8OHpKYk2bGJlZDBVMP6zJryWaP07EVVZemBvuloCmB33
	fdAsrsHYws8AcqzB0Z3BQOVtFyZY=
X-Google-Smtp-Source: AGHT+IHfoQts8z+QDV04IE/uben1D0MBZVdGsl/5fVHTBtvcf1ZyMa+FMHObBZnnrWrfdD1CXEoL/Dv0J18fQI6z1lo=
X-Received: by 2002:a05:6902:1148:b0:e73:2ec1:1e6d with SMTP id
 3f1490d57ef6-e78fdd3fefbmr4788165276.31.1746801804602; Fri, 09 May 2025
 07:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com> <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
In-Reply-To: <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Fri, 9 May 2025 22:43:13 +0800
X-Gmail-Original-Message-ID: <799D717770BE9E86+CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
X-Gm-Features: ATxdqUEjbUCx5yZizqHtrAM6CxVu3j0RuoIhxIIiP_hjidE0A3Y__reOs8hyV4s
Message-ID: <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: chenlinxuan@uniontech.com, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MVDv7UzTx0WWhfMOq8SSAtsLdAVaCETq6mDCSZYzWjekltMK/qcua4NK
	lKbUxB8ylqeMR6L/NYpk1ELvV7jgtd5qz4SyB+rfXRuvJ7mcJ2Wtg1lR+WfmYEIVuEQ0Bod
	O1qGda9o6ndBWO5JClIRAcQw9R6D+MM9X+QNj4n0AgvLSA3r1tUnAPi+j8Q6gkNeOI1auz5
	zAd7mgxJe8Rhy5pxWPy2+ypOSpBkBnI0lFmjoEZHMGtqYWw4dCVD3xtWeQU7Xyuxkk9YHtF
	N8ifi1bbNS+USiI33m9YUuBZcmEjIPNRoctpCEUTPK+A5F+FgiBR8XEtNtHjW7ceULsrewA
	mkb8GF9ch8mki7wMkzmemFnfz7osHLhCmHiAR4RUTz15vVaLVCfg54ZmlvsO3yIHVf/3N6f
	BsrxxCiFBqixVOg6DjrfeHLPfbzvMDm3mKlXAvIE/35IRwZSkxs9qc9ZsJ8rxWEBkUA95bl
	STN5bxGLJg/2Z2bYV/qTCswvXqBJVsCN/rrv55Jjx8gyeKJyNXZMA+CKZMK+GRFeS6x+45N
	7mNmvyWceT4B50vhzKFV9A1j0VVcrsTQEDcxryU2aHk9NaW3Y32wQ0NZ8VvudrD+bwpvN2u
	/Vyzj9lP/RbpuWmzIrZSFKlA+7ufDsRiOi1killRDeV+K8HP5xIrlZWYIlh1LmR7MMMomjb
	UAcFWggSrfyGbLtgvO/mhZ/Awk8nov9T7nGjOmrWA8+OFdPgOCjbt5hmRcUDpqwVStBzZZ7
	/crtA7COT1CXpRYLpFLcT/Nxl5Zsd7/VMpcA63ebHNsPSW6VIa5T/m2HaKqhxklvqCoWmmj
	U40Exo2OzkfHU383RhsOFsAbD1dQSB+EPVMpwGo8TKAdjsj3aS2zp71YTgi2Y2FL9SYdBJ8
	/jHyQ9lTG27CtOudN2r9l7V916ZlSZbzeiYUa8XWme+aeikVRDUPUx1ehf8qM5wWX3wsjBr
	dLRKhIdPasbGXeoc01a8hDf4fVXUv3aydZLeAdDW1ehTSiFFk4PzZAitbCs5nVAQEjuErbJ
	Lp1tdi4MJMWzSu0Sq/pJMkNmxBtKnRt0TtAwrfqhF/sW07gUwJ
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Fri, May 9, 2025 at 10:00=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 9 May 2025 at 08:34, Chen Linxuan via B4 Relay
> <devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
> >
> > From: Chen Linxuan <chenlinxuan@uniontech.com>
> >
> > Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
> > that exposes the paths of all backing files currently being used in
> > FUSE mount points. This is particularly valuable for tracking and
> > debugging files used in FUSE passthrough mode.
>
> This is good work, thanks.
>
> My concern is that this is a very fuse specific interface, even though
> the problem is more generic: list hidden open files belonging to a
> kernel object, but not installed in any fd:
>
>  - SCM_RIGHTS
>  - io_uring

Note that io_uring has already exposed information about fixed files
in its fdinfo.

>  - fuse
>
> So we could have a new syscall or set of syscalls for this purpose.
> But that again goes against my "this is not generic enough" pet peeve.
>
> So we had this idea of reusing getxattr and listxattr (or implementing
> a new set of syscalls with the same signature) to allow retrieving a
> hierarchical set of attributes belonging to a kernel object.  This one
> would also fit that pattern, so...
>
> Thoughts?

Using getxattr does make it more generalized, and I think reusing it
is a good choice.
However, I have some questions:
If we use getxattr,

For io_uring, the path could be the corresponding /proc/PID/fd/* of io_urin=
g.
For FUSE, the path could be /sys/fs/fuse/connections/*.
But for SCM_RIGHTS, what would the corresponding path be? Could it be
the fd under procfs of unix domain socket?

I am also uncertain whether there might be similar situations in the future=
.
Would we really be able to find a suitable path for all of them?

Thanks,
Chen Linxuan

>
> Thanks,
> Miklos
>
>

