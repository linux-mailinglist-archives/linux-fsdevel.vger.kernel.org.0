Return-Path: <linux-fsdevel+bounces-16170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074DC899AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56091B21653
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CED41552F9;
	Fri,  5 Apr 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+yEvri7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145F28E34;
	Fri,  5 Apr 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313266; cv=none; b=aqpbVBqskHJ6duEyp5ua2Lk5l+MgaSK8+7ge4TCJW6CWjJNJVVCJXT62uHcz09YEN3iT0YUgm+O+ClqWi9gWNQZKPUaoBh0ytpBxIoU/oSDshvDCWnloTcJcHyV6+3XXj133RMemzBYpR8yM/G1hbB3glS5uUFPvBhTIQSKwkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313266; c=relaxed/simple;
	bh=IM8yRnLoNZO3t73cB9oQMGDYuOL8b1mn3L19YyINA0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIkelC6ivxqW9SdkISFZbaFnVwyy/HKAOAYpDZAPGunLM3zfdVF5R51LHw4BPin+BcdbxBG063EknWMCdkl9Mcdiz9A7Gu6SVVSMM7iaLlg7DaXtvnQoBuVcu0PuWLcQB5pb0FYQ1CU58xF74CVkmDuwBTlMet/f64LcBMRm4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+yEvri7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6992d93c146so8206266d6.0;
        Fri, 05 Apr 2024 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712313263; x=1712918063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J67Sjl5xWX+e5LsxQMjjIEZZQweXsXHadZoDWiJQYvc=;
        b=R+yEvri7w+YubIw2Mc09v2IXNBpfRxeMsD9mJMV8DxN89R4ZCU0QGtpafyA/nkfEIE
         yIM8CyOy6MMgYaxr9hLnvi9yqFQAW1wWrzsE+ZKV/+np/x3kaInI0dcmujWaiBUoDwCF
         NMlav4MkTbUpIt0sEhywb/VCesWz2U6MqEc57yXM5DH77nMVDcuvGEiLAhS/BIvdU15v
         3sT6xHlIGs+zYUsbdk8eScnS1CqAcFW+Rx4jLl01FbqKJ/1FNaV35BWjkOmqtw3NeykY
         gMyASGqkiYA4JSQhxm1Uhthv5U0JBMm5UmBKQNyROJY66QvhwIHddSvHuq3LYErvdMQb
         BUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313263; x=1712918063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J67Sjl5xWX+e5LsxQMjjIEZZQweXsXHadZoDWiJQYvc=;
        b=wLA/iezQ/gO9HtjpWZXbuJH3/Qbghn6K583xZR8SW/GuVGIKPDKdpQfytq6x3IxaJe
         d7QNA0gLYACmZNjARKfAAQcqKAIure3YvYFl6r5zoX2b/M0cK8JthTvANXdg3RoORmK+
         1NGszHyiDzbUC0pnAvk1sjwxQVlfQeSrp4JLVf3a1Hiv22iJXKQE8jDZNuYF8E/+gTTh
         8CETTQ1DFZXyXsWhTfeKz56lxeGuPvTpPPaqy3+LXNqm5Z/VKhNJ4M1B85TtBP3ioHji
         4h5a/Vxpkeia42iOikoyF0SNWmX3l2tzffS7188luQuLQ1+xZBVcyJWipLKD+dN/0a92
         oVjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6y4PmRdxo7RQjXFXeR0zHgX/VYLoKMYCx9e2MvHMi/UIanuO10OcvCCJF9GZhsRwEOxidcfLn+tF+VBlsOHCtrvvCreJh8rPKHbBLui9YDo1n4lK/2Gj+jQE76OOs1jHV3+5YBJ1SyOpO8Q==
X-Gm-Message-State: AOJu0YwIReQoeB25fduVgBsgr+aMvY0msukFDaxNTW4/LfyCgQzQHgIb
	wAXArv5nC3wSyFPxCrAqsAAgbRzYe4tuIy45DgM1zxVdAnGVXoq3yF/FaeGLu5D+V2jADT2BJa6
	S6BUKQKlEtwMmCcR5FU1hRoX58jI=
X-Google-Smtp-Source: AGHT+IHVzDcoIfAw3OpbW/JPOAWic54HXrUx4a5XEjIt1iGR9oc12tTYK37+DyC5xFw7NjGv2i6q0jy74WPZB9vZyqY=
X-Received: by 2002:ad4:5dec:0:b0:696:4086:5e1 with SMTP id
 jn12-20020ad45dec000000b00696408605e1mr1660367qvb.2.1712313263642; Fri, 05
 Apr 2024 03:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV> <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com> <20240404220108.GT538574@ZenIV>
In-Reply-To: <20240404220108.GT538574@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Apr 2024 13:34:11 +0300
Message-ID: <CAOQ4uxiAvWbEGavQuukzTf9JFkMKRL7T_1t8-YHUpYPuifmyHg@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, 
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:01=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
>
> > This specifically cannot happen because sysfs is not allowed as an
> > upper layer only as a lower layer, so overlayfs itself will not be writ=
ing to
> > /sys/power/resume.
>
> Then how could you possibly get a deadlock there?  What would your minima=
l
> deadlocked set look like?
>
> 1.  Something is blocked in lookup_bdev() called from resume_store(), cal=
led
> from sysfs_kf_write(), called from kernfs_write_iter(), which has acquire=
d
> ->mutex of struct kernfs_open_file that had been allocated by
> kernfs_fop_open() back when the file had been opened.  Note that each
> struct file instance gets a separate struct kernfs_open_file.  Since we a=
re
> calling ->write_iter(), the file *MUST* have been opened for write.
>
> 2.  Something is blocked in kernfs_fop_llseek() on the same of->mutex,
> i.e. using the same struct file as (1).  That something is holding an
> overlayfs inode lock, which is what the next thread is blocked on.
>
> + at least one more thread, to complete the cycle.
>
> Right?  How could that possibly happen without overlayfs opening /sys/pow=
er/resume
> for write?  Again, each struct file instance gets a separate of->mutex;
> for a deadlock you need a cycle of threads and a cycle of locks, such
> that each thread is holding the corresponding lock and is blocked on
> attempt to get the lock that comes next in the cyclic order.

Absolutely right.
I had it in my mind that this was a node lock. Did not look closely.

>
> If overlayfs never writes to that sucker, it can't participate in that
> cycle.  Sure, you can get overlayfs llseek grabbing of->mutex of *ANOTHER=
*
> struct file opened for the same sysfs file.  Since it's not the same
> struct file and since each struct file there gets a separate kernfs_open_=
file
> instance, the mutex won't be the same.
>
> Unless I'm missing something else, that can't deadlock.  For a quick and
> dirty experiment, try to give of->mutex on r/o opens a class separate fro=
m
> that on r/w and w/o opens (mutex_init() in kernfs_fop_open()) and see
> if lockdep warnings persist.
>
> Something like
>
>         if (has_mmap)
>                 mutex_init(&of->mutex);
>         else if (file->f_mode & FMODE_WRITE)
>                 mutex_init(&of->mutex);
>         else
>                 mutex_init(&of->mutex);

Why a quick experiment?
Why not a permanent kludge?

It is not any better or worse than the already existing has_mmap
subclass annotation. huh?

Thanks,
Amir.

