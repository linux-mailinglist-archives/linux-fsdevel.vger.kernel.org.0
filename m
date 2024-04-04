Return-Path: <linux-fsdevel+bounces-16096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D514B8981AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 08:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD081F2771B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 06:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48655789F;
	Thu,  4 Apr 2024 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq9a3GkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC656740;
	Thu,  4 Apr 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213689; cv=none; b=NpTZhEzyOCTceyysJnBlhgsaarzzE2kbaQgXDNSmDvhuStjalNoB/haF5bAvgIbmM+QKhFSPNfiDASTaVc2bXYZu72SgLmbHWibc8XcBGArEZJQghXK/vHMe+WJRpMLbtWAJuoZXpyo5jP0Q2jjMcPmsV/TkepeCgu487ZZUNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213689; c=relaxed/simple;
	bh=P4HRQlK3gIOZhynu3iitqpwrtMPK33V9qTle66OO+mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgV2q2e58UAslJ8AmyhkKbzsBDSQbSRgxZakYIRss4UYlx17KcUQ0u8XdLYYms4Z6SiYQ93Y2WKTuYuNeaQe0np23vD/mIxpiMkPkXaSKaOqrEFlHk5Kp9M8uTUGlCjqcNJzNCKJl8q0R840Bn3rTtbugwbp5YBN9jmRjPwQbfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq9a3GkC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6992f97ec8eso3709366d6.3;
        Wed, 03 Apr 2024 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712213686; x=1712818486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw65dET69SWIl1E/XYAbpA7W4BYrqXaCQ0IUnLjWA9A=;
        b=Hq9a3GkCAhGD4Y+Y9Xdamz1qsCdP6VQFiMhsH2VsXzbP5AuUuAoGSQh0HVTNBse8k5
         YZ2BI7xUcc98xhhMt0riIGK7E5+NHQF73FyipwTeZrU6aBcq5jp52JCprjXVnsGauIgk
         GP+Wkd+6Sea+Y0DJ9kq8LNJztfu+9dWO61eZ+To4mM+mNMs4ZshDFiQKyHLYUQKoiJw5
         M7zbotJGSf/rZqG/7UT6ZSFdka27eTVwWxfM0DfBP6opYqOFwCo+UkirDGQB9ALX3h/l
         te/aZRWnOY0lJJLnap6L+V8nAXhwPLJdRlEAX642NHxp2CFV9vM97c4b9VScM4cSRqNA
         yobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712213686; x=1712818486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw65dET69SWIl1E/XYAbpA7W4BYrqXaCQ0IUnLjWA9A=;
        b=HfdLag7n7HNADxhCJ486YllJx98gzWzCn2+Bo8NXd/2Qc6YdlijczWQbDZF6k+AXZw
         jceTMTNd2mjn/P5JuSZXVtTMvFWKYX7FMRyw1k5ceirRGNwtjAw5KGq6htvkQQvieCQ/
         pGjcynSLtpNIO+9hjCUiAW4HW6Z7PhTn3slyWLiMlSigqe+S6EKkQQ57/KJeG2hm7zYV
         +VKQONA3vNKXsGdmov3nezPjmG5cxRrnkQ6QkFZb03v7uhcif8Z+W5gQR3Vw3eRgJEyH
         pnl3tsl9ZkYkuAEkKCpSHkzJM4MHDk/8MxwOU7iHlQWrlOKJ5zQ2v76wYvjltzDM4j4b
         PoUw==
X-Forwarded-Encrypted: i=1; AJvYcCW5gKYJkiQ5PFPd25TAotd6kPCleSpMqY4TxHCYOPuDGA3oxp7h3EFN45HEJbdGiLOau0h1trE/dzgpH6bCUoD0KiG88czSIuNchF4j8mUCHDo7XXw/A6u6Wd/+8FmHnbTykIY8CvWsetT48g==
X-Gm-Message-State: AOJu0YxORKVDSQdz651WMgE0OAbO6Awlp+ezLYHZx3vacC/1N5Z0uAtF
	WDBH3P+AXc6LNd2XSy7re7l3Sg6ii0dI7803IOrQIcDpQnmJ+mYnNRHBcKcQGp0PYy/YDbJIVwe
	R8dcHIoPT1bE4kNBPqwCH9zSA4Zo=
X-Google-Smtp-Source: AGHT+IGC2+AfF1pywBGs2k+kBcpPpK4UcRei87wZYI1X7piC3TmIlAxmVD6isSsFawmYGgoVAIr5ySEJgzrtr/c57Co=
X-Received: by 2002:ad4:5ecc:0:b0:699:197e:f689 with SMTP id
 jm12-20020ad45ecc000000b00699197ef689mr1552673qvb.35.1712213686467; Wed, 03
 Apr 2024 23:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com>
In-Reply-To: <0000000000002f2066061539e54b@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Apr 2024 09:54:35 +0300
Message-ID: <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:51=E2=80=AFAM syzbot
<syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 0fedefd4c4e33dd24f726b13b5d7c143e2b483be
> Author: Valentine Sinitsyn <valesini@yandex-team.ru>
> Date:   Mon Sep 25 08:40:12 2023 +0000
>
>     kernfs: sysfs: support custom llseek method for sysfs entries
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17cb5e0318=
0000
> start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kerne=
l..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D142b5e0318=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D102b5e0318000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36f0cab4=
95a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9a5b0ced8b1bfb2=
38b56
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17f1d93d180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c3813918000=
0
>
> Reported-by: syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com
> Fixes: 0fedefd4c4e3 ("kernfs: sysfs: support custom llseek method for sys=
fs entries")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

I think this commit is only the trigger for lockdep warning in this
specific scenario, but the conceptual issue existed before that
for example, with read from sysfs, which also can take of->mutex.

I think (not sure) that the potential deadlock is real, not a false
positive. OTOH, hibernation code may be crawling with potential
and more likely deadlocks...

The conceptual issue (I think) is this:

Overlayfs is a stacked filesystem which regularly calls vfs helpers
such as path lookup on other filesystems.
This specialized behavior is accompanied with a declaration of
s_stack_depth > 0, annotating ovl inode locks per stack depth
(ovl_lockdep_annotate_inode_mutex_key) and restricting the
types of filesystems that are allowed for writable upper layer.

In the lockdep dependency chain, overlayfs inode lock is taken
before kernfs internal of->mutex, where kernfs (sysfs) is the lower
layer of overlayfs, which is sane.

With /sys/power/resume (and probably other files), sysfs also
behaves as a stacking filesystem, calling vfs helpers, such as
lookup_bdev() -> kern_path(), which is a behavior of a stacked
filesystem, without all the precautions that comes with behaving
as a stacked filesystem.

If an overlayfs path is written into /sys/power/resume and that
overlayfs has sysfs as its lower layer, then there may be a small
chance of hitting the ABBA deadlock, but there could very well
be some conditions that prevent it.

It's a shame that converting blockdev path to major:minor is
not always done as a separate step by usersapce, but not much
to do about it now...

I don't think that Christoph's refactoring to blockdev interfaces
have changed anything in this regard, but I wasn't sure so CCed
the developers involved.

A relatively easy way to avert this use case is to define a lookup
flag LOOKUP_NO_STACKED, which does not traverse into any
stacked fs (s_stack_depth > 0) and use this flag for looking up
the hibernation blockdev.

I suppose writing the hibernation blockdev from inside containers
is not a common thing to do, so this mitigation could be good enough.

Thoughts?
Amir.

