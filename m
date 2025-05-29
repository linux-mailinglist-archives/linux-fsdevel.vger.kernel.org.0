Return-Path: <linux-fsdevel+bounces-50025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F7AC787B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 07:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255343B6553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 05:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF412522A8;
	Thu, 29 May 2025 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9n1hi8R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160916EB7C;
	Thu, 29 May 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498147; cv=none; b=qUuPB8GO5Kc6WPm4sX9FMbm73ojCLOWOEo331i+w3rDcp+sHr6ql6QeOgNRCi7Alp5a+ISQLz7XLzX8CL4gjdDDt0jD54WSdf35GK21yW0cz/Q4eiQUwhdnNg3xJyZ46r+PDyqx6Vf2KjuFQFIxXphpTAQHR5l07tuBfKNWeUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498147; c=relaxed/simple;
	bh=YWlvmPX7PHfsrzXiE/B8HHZfXYpguDiw0mElGmGNUa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlVzULwx4Qq91TARcrE1WaTX16n3EgCJ38c5Eu9WmCV2LmWf1LhAncDxJuvBQ8mqHlbDx/kBxNA8jAPZB5cU6eLz9h1FMSQOOllGNJp8Bcb66NlftWAfmTuyVq7JUoh047h4niTJaKgZk2QgDzA/xTvN6u4guOIRlIsqkkA7VRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9n1hi8R; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c559b3eb0bso35441285a.1;
        Wed, 28 May 2025 22:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748498145; x=1749102945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWlvmPX7PHfsrzXiE/B8HHZfXYpguDiw0mElGmGNUa0=;
        b=P9n1hi8R2DyzWaGej2kjaC7RSfk93mVo4LVUwDFfB8ZK8BCkO8WP2vZ6enj4BeVfG6
         ANvPlp/+vy+bxgNYZYbbIDsxMH0vdSgufYk492kaat6wbsdR/cX/qf1zUKzzdiWkvbZC
         mHJRPPdRUiOcJK2oId6sh2IWb/qxoMZJJoro5C7j7GM1sL+W6ChwH4N3+VU2XsbWfm4b
         8Ddj2E+9OIbYoo3l6mtE50KqJnsk3FU6qwzgZFLxu9vs6VYhBeR8N4fmKTmkzopMSSXS
         jt6li53sy9kbMah0wLIamxW5M8VsblgjoLUIzCCauh0NMcMQCgQ73huus9Hx8+EFqyBs
         LPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748498145; x=1749102945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWlvmPX7PHfsrzXiE/B8HHZfXYpguDiw0mElGmGNUa0=;
        b=K010Px08jIxgql5tr6nqUclNAPuLK1h7gZUn+DSOl2uiiQgFtPdcUqMhOnsCKRqhYj
         mk+B78JDNkW22qPUbAadnpBNhK5fsfJmSOs9KbHezaL2NtZM7uBQL76+D20P2FE7SICD
         0y8oVOoBQgpdB864fYC4kccAbrjh9FYXaqX98PaCnBplbAdra2kPF0BWI+dFxe5WdSek
         oBsnyhxJCV5zgafWyTF1WoherB4/9wqa8xh3ORkO3GCBRfAeB1rCorZMd5f2UpqO2s2T
         pZ5O72mioor6SEA+ga0s216fIXWHtimgek/T4iTZQht5uxFnwuGbFtdkX68v4JsvB0jP
         qo6A==
X-Forwarded-Encrypted: i=1; AJvYcCVIwTArcayGSg1lhz3PR1ZTq1MNEFCe18hCJk1Le9l1sI7zt7fUq7g63Q/eyZChjYyVOBYKHFar8WY1H2Dw@vger.kernel.org, AJvYcCXfmquTyIXXtkjoU23M7Px9YlGh4KqlTmgc1mWMFSMukNHKIssVsKxAYhlszN3jD1Rw277vrNCOoBFY@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/hmZjSHvRW0qEewI4LHWMSqlhYRVQkDaFXsnyHvscGABTlpm
	Yqgymiw93M7dkwxVXRzBt9z1Y68Lord0eMj9OT6G0eh9fF72MnhIOF8z9+vcDGmoltLUHZsxf/9
	3o5qDnjBrPz2OOIBF4LhFD0ZSenl1r50=
X-Gm-Gg: ASbGncvchNl1aImatSYiF7rYYrXjnSEc6ndTKjY9ivUuUasW02fUjYk4g4ONwkhUF1J
	+d8tnYVIoyzlWfVf5QZJdIDs/H1iUGhyMiy8yMzjit9v3At01d8cb5qQ3u2O/LBJ4cexEbMaPEK
	o/Inf0EPY7ThMbToGlziHZapxMF8bCHSaIgA==
X-Google-Smtp-Source: AGHT+IFV1TJ2zbp6OOG/bfbfwfzMLVL0wZ4xes6xgwUT3MlMCmih8S9lBhEGaR6ORDyxYarH+svpOwqfQJLRpVBcvIQ=
X-Received: by 2002:a05:6214:1805:b0:6fa:c0f8:4dff with SMTP id
 6a1803df08f44-6fac0f84fb3mr59004276d6.37.1748498144564; Wed, 28 May 2025
 22:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
In-Reply-To: <20250529042550.GB8328@frogsfrogsfrogs>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 May 2025 13:55:08 +0800
X-Gm-Features: AX0GCFvDkzSDxpXyKqzMqNqosxRnboXDIbXUX7NdS90M1pthmxVHEr4_d299puo
Message-ID: <CALOAHbBEPYFfHipioNcq2AyHWrj4PCQGH1wKLLsTAifNnd9LbQ@mail.gmail.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, cem@kernel.org, linux-xfs@vger.kernel.org, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 12:25=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > Hello,
> >
> > Recently, we encountered data loss when using XFS on an HDD with bad
> > blocks. After investigation, we determined that the issue was related
> > to writeback errors. The details are as follows:
> >
> > 1. Process-A writes data to a file using buffered I/O and completes
> > without errors.
> > 2. However, during the writeback of the dirtied pagecache pages, an
> > I/O error occurs, causing the data to fail to reach the disk.
> > 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> > since they are already clean pages.
> > 4. When Process-B reads the same file, it retrieves zeroed data from
> > the bad blocks, as the original data was never successfully written
> > (IOMAP_UNWRITTEN).
> >
> > We reviewed the related discussion [0] and confirmed that this is a
> > known writeback error issue. While using fsync() after buffered
> > write() could mitigate the problem, this approach is impractical for
> > our services.
> >
> > Instead, we propose introducing configurable options to notify users
> > of writeback errors immediately and prevent further operations on
> > affected files or disks. Possible solutions include:
> >
> > - Option A: Immediately shut down the filesystem upon writeback errors.
> > - Option B: Mark the affected file as inaccessible if a writeback error=
 occurs.
> >
> > These options could be controlled via mount options or sysfs
> > configurations. Both solutions would be preferable to silently
> > returning corrupted data, as they ensure users are aware of disk
> > issues and can take corrective action.
> >
> > Any suggestions ?
>
> Option C: report all those write errors (direct and buffered) to a
> daemon and let it figure out what it wants to do:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/=
?h=3Dhealth-monitoring_2025-05-21
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/l=
og/?h=3Dhealth-monitoring-rust_2025-05-21
>
> Yes this is a long term option since it involves adding upcalls from the
> pagecache/vfs into the filesystem and out through even more XFS code,
> which has to go through its usual rigorous reviews.
>
> But if there's interest then I could move up the timeline on submitting
> those since I wasn't going to do much with any of that until 2026.

This would be very helpful. While it might take some time, it's better
to address it now than never. Please proceed with this when you have
availability.

--=20
Regards
Yafang

