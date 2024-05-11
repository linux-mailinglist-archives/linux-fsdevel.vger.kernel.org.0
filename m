Return-Path: <linux-fsdevel+bounces-19297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCDB8C2F68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76ED1C21192
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 03:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0852C3BB32;
	Sat, 11 May 2024 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOhZIMiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F661843;
	Sat, 11 May 2024 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715398968; cv=none; b=NNjTQkBck8giUg6yppmlxK2+tH4LewRmtC+VyGtef+frR4862B2lUbWnHP169r+JYsbTiYD/z/aPXfdlVEZ1CvDsHPboAB6Bdic/8KC+XwKUXhjWY0+MRxasij8kbCHiNliMit1+M9lQ98DRc7uJmd2Yn62WYKcz74v0DLyUSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715398968; c=relaxed/simple;
	bh=5RBPaYqcgbMTvo83mnVNrHazxn1LC+THVRiz93bfQcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ps7jOJ9aO0cnqeENLNYxx0kzeO0XEOrxNVAqhxYmF9Zg5WL86D4zGdG50LMUVrBbjo6Fa973qkGhxfTAZCaC+71oBxsAr/03cZjGYzFckTNgmUmoIRM/k/HWcPiz3+BoUZ99ZZfwPWovQpl4wPdu9ThnoO+HdscNzmEYAZYsmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOhZIMiC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792b8bca915so219846985a.2;
        Fri, 10 May 2024 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715398966; x=1716003766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf95gvKfqdQwvRWi4ct7+6exb7i4hQQ3hGupiWKjZHs=;
        b=QOhZIMiCAVtHRR2U6WYUEcj6bY/5AhMQ/rDS5zXBYsE+FijqZx9TeuaZYmzvQnHNaO
         cV9Rc701J613rXCznPGiIfG0h6wnySoS6qUki8AeIfdJcnqm4g5lqCs2ta/HmYESv7wo
         ZLQ1czKYYwx803T7rJ+iL9hfFCOVHzQq4itU9k2c94Yl+pqdDaVoeMegH+BZIwrxdo9L
         dWPfyx4QH5gSYaWRQODnxl/132UCY0uYEemD2mBh/bv8ePJvOfia5PL11VDQXRaYSxSc
         /rUce2Gbj27il6HXSvtYmfL31lx+Pj23hUAcdujUEfQNveTGy4HoKi66rw0RmOoKATb/
         KmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715398966; x=1716003766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf95gvKfqdQwvRWi4ct7+6exb7i4hQQ3hGupiWKjZHs=;
        b=Ko48YWbf2ijwZwFHzLRBeeEKeGmP4j4F889V5Cyn2WaN61jmBDkk/E49tIbvXBgOKj
         zs0pgmhT8DO7wSDsyr/JFVzMJnkwk1EApgjJdF5z0pCwfP1cDxj0ykgzmoHrWQHSIcTm
         j0+wfZ+Du2Pha4r/X54NgnlAy+KqfIW7CuDpQS5lUWPo0efYLCW7PKYlbck6HCw85y/d
         Zr9x8l+j9b3nS8vfFenqk4tqa4x4zQlqlGUAS1h/gQw1eHyCYo/i4mU22ibD4KDDp+Bp
         cd5Zw2EFI2fmuBTJUk/DZVNW+F9Pgzzl1i9FJZ7qvFkgEeYu3UDAHFK6cXAkGOomugQd
         y6ww==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9X66WtKakvf1wPXu+wV2cNHWPeENnNqOv9I0LIQ4Lb9oApg4tCGkdiTOxc4IzHJOMhZs21cVunIOg/yux98/zYoMbv4Eib+hQuDrYBiUc6AiOUWSMlVh34Cy0RgZPJnK9HlCYHuCj1g7rA==
X-Gm-Message-State: AOJu0YwAM+Wt5QfAd731Lt5L/p1zJgqWXRvmh5y4cet8lWOSUuvwvpuT
	dac+VxlGdjSbzFPe1Ysg4NIhepLqdYg+RVHOmP6L9V4i8iJVIKAXw6JJ5K8eAdqrmH7QzPfO01n
	DdoeX/AGSoVCqV5d5W7LpYiwQd3M=
X-Google-Smtp-Source: AGHT+IFMW/1UdqP9wdNRX8wg6K/79HM35/5Mrje26SXpJ4+agrOp1OcVxTCgNhpKUzYij37LvC2YaTr0SaWlconA1tM=
X-Received: by 2002:a05:6214:3993:b0:6a0:991b:ecf1 with SMTP id
 6a1803df08f44-6a168142dcfmr47596236d6.5.1715398965893; Fri, 10 May 2024
 20:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 May 2024 23:42:34 -0400
Message-ID: <CAOQ4uxjKdkXLi6w2az9a3dnEkX1-w771ZUz1Lr2ToFFUGvf8Ng@mail.gmail.com>
Subject: Re: [PATCH 0/1] fsnotify: clear PARENT_WATCHED flags lazily
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 6:21=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hi Amir, Jan, et al,

Hi Stephen,

>
> It's been a while since I worked with you on the patch series[1] that aim=
ed to
> make __fsnotify_update_child_dentry_flags() a sleepable function. That wo=
rk got
> to a point that it was close to ready, but there were some locking issues=
 which
> Jan found, and the kernel test robot reported, and I didn't find myself a=
ble to
> tackle them in the amount of time I had.
>
> But looking back on that series, I think I threw out the baby with the
> bathwater. While I may not have resolved the locking issues associated wi=
th the
> larger change, there was one patch which Amir shared, that probably resol=
ves
> more than 90% of the issues that people may see. I'm sending that here, s=
ince it
> still applies to the latest master branch, and I think it's a very good i=
dea.
>
> To refresh you, the underlying issue I was trying to resolve was when
> directories have many dentries (frequently, a ton of negative dentries), =
the
> __fsnotify_update_child_dentry_flags() operation can take a while, and it
> happens under spinlock.
>
> Case #1 - if the directory has tens of millions of dentries, then you cou=
ld get
> a soft lockup from a single call to this function. I have seen some cases=
 where
> a single directory had this many dentries, but it's pretty rare.
>
> Case #2 - suppose you have a system with many CPUs and a busy directory. =
Suppose
> the directory watch is removed. The caller will begin executing
> __fsnotify_update_child_dentry_flags() to clear the PARENT_WATCHED flag, =
but in
> parallel, many other CPUs could wind up in __fsnotify_parent() and decide=
 that
> they, too, must call __fsnotify_update_child_dentry_flags() to clear the =
flags.
> These CPUs will all spin waiting their turn, at which point they'll re-do=
 the
> long (and likely, useless) call. Even if the original call only took a se=
cond or
> two, if you have a dozen or so CPUs that end up in that call, some CPUs w=
ill
> spin a long time.
>
> Amir's patch to clear PARENT_WATCHED flags lazily resolves that easily. I=
n
> __fsnotify_parent(), if callers notice that the parent is no longer watch=
ing,
> they merely update the flags for the current dentry (not all the other
> children). The __fsnotify_recalc_mask() function further avoids excess ca=
lls by
> only updating children if the parent started watching. This easily handle=
s case
> #2 above. Perhaps case #1 could still cause issues, for the cases of trul=
y huge
> dentry counts, but we shouldn't let "perfect" get in the way of "good eno=
ugh" :)
>

The story sounds good :)
Only thing I am worried about is: was case #2 tested to prove that
the patch really imploves in practice and not only in theory?

I am not asking that you write a test for this or even a reproducer
just evidence that you collected from a case where improvement is observed
and measurable.

Thanks,
Amir.

> [1]: https://lore.kernel.org/all/20221013222719.277923-1-stephen.s.brenna=
n@oracle.com/
>
> Amir Goldstein (1):
>   fsnotify: clear PARENT_WATCHED flags lazily
>
>  fs/notify/fsnotify.c             | 26 ++++++++++++++++++++------
>  fs/notify/fsnotify.h             |  3 ++-
>  fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
>  include/linux/fsnotify_backend.h |  8 +++++---
>  4 files changed, 56 insertions(+), 13 deletions(-)
>
> --
> 2.43.0
>

