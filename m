Return-Path: <linux-fsdevel+bounces-62010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E34B81BF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1923A4A1CEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AC82C11C6;
	Wed, 17 Sep 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT/ZGqXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1827E049
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140596; cv=none; b=eYtgZ1ORDIGVpyo3UpWTgCY0JD50VUlRmiX/48Ogh6G7W268V4p8OJw82PZzECTLv3kVEceUb/plGReX81qrpFqHXVSiQHXjKs2FlKzJ1YAxy1/LfJEoB8E3IoxMWkyXZmR99vH2A33FdR/RdH+t9kqGKPYwpmgKXcyG+2OkCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140596; c=relaxed/simple;
	bh=/DINvktItkrVyCy+/DbG63bv8UKOnSJsd6RXd7PJOtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AihZcrBwkgakFqlZw7ebZvv7gd5O4RgoBLdz2rBaUZI5+r9GJQttLaeuiboqfY/VU5o5jvmFGDsL9iXQ43pmatMHhXLRMwaKqzwRylyKQp9KndN2CGdsemVDM3kd3fPqQUtsEXjO1ZX8HEeWhSuBy5tWYG5zyn16e+bzwr08ncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT/ZGqXP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso317673a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758140593; x=1758745393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQYyUFKyIMwcbN0Oi1nix7mefhyosUBnMaKUMp/0Uhw=;
        b=dT/ZGqXPjLWFjfXucdmAD0qFEjYXdHvRPPoNhNh8PBFANRa2dHcAoOKvVxKCJYbHzC
         u12e8b3Rqi5T+a5MAEY5cUqkIT8CQMu1gDRFVxjw+TVp+fVS6oJ6eIIX6MZst7x+e6dD
         YKe7JXIt8UyYINQ4yyg9xGTTzqGSE7ovCOZM21dInfPxjWqQqcSrJ7JgUtw0+e/vsNiJ
         0+Ok5tnWr8Zf3AzyvehyU0rRIgIH0gq3SK7LAQs5y32tmePUaDnx87PKmgZBtX6QXZPb
         3pYGO4617bfzw7EVxQal9Hz2jhr1Z40WqYhYGtHzRgi4cOdrKOjjPDx2qAVdxA5ZdF9p
         D9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140593; x=1758745393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQYyUFKyIMwcbN0Oi1nix7mefhyosUBnMaKUMp/0Uhw=;
        b=o1A5Jl2PJdE+kmjPfJasbjoEUthYdkR7PByD2/6G0BiTgcWL3V3OM3i7WLTBx0DJQd
         xqzEc5bvO5zntuc/q0kwRw2PzlYXIYcJ2YazpJinkikfwmvjKS4DJE2KdikVqeQOgAbK
         M4teKtavTcZPqnL44LScsQ1OxFlNU4jXv5ujMn38irzVLRwbRmpERVTx28lbXmaL2i1B
         ldQHQ2myEdKVIMoc+DYRgpjyvNniWoOl79h1Nt57FKFuS9zBmHuSXKY7WdjzTkhG7CFJ
         uFxILadwZ7+U6pSLPiHxrlS762uavKbg05sf3iSTtI7up9rUSWp5H9LzqmKidEIWcgQ2
         l37Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkssPFZMS6gD3xS+oxil8fM01tvV6VEgXPIx19Z91jPV9kahYl3DXDVL1MhDwsM8JGgiU8mGDAoRI/pQVW@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOXzorY10LHYEpnVEhzPpiLfaylGpGbmiq7OWIVob6sxsGHK9
	nEsbzaPRGngLbF6xnEIbh8NUZP50WE+AIDbxrA5nzAHaJ3+ihwz9+ORaYrON/Hq3yScSYwgHo+0
	hLiRdvAndMFQ8cUWYd59HcTFG+vOB2i4=
X-Gm-Gg: ASbGncuH35UkjnK5GswntDMZfKcJZxErmpwhMFjWyn6O2tUZGtMl2mtLEsMXzeNiuHw
	wJYsydkvDUr2iJr+rTppZBzVnEJqYUVD1ZuH4GWxu4yK3oky6Ozc0iO/vf0hdNt6897EGUYZvJt
	YeI2KHgZIltNIYwC0HtzpG1bMJEfMeOGxPbwzXr6vhAO0m4aGdRKssiBFi0uqUZIBipMFfn93Gt
	cSXBw2kULVWsPyPldQzMGnh/BqrT9aOEE/yJleglE94qun2XZlQ3cepSC+lz1gEnuJU
X-Google-Smtp-Source: AGHT+IGbnxJUuKMIoax9837vUOwFa3uC5z5C8iuy02lVnujR8xNtpFbaO7bRafNJUiDUa0Pb4Cm8O1H0fKv6jLIS6Z0=
X-Received: by 2002:a05:6402:23cc:b0:61d:2096:1e92 with SMTP id
 4fb4d7f45d1cf-62f842255b5mr3411840a12.15.1758140592771; Wed, 17 Sep 2025
 13:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com> <20250917201408.GX39973@ZenIV>
In-Reply-To: <20250917201408.GX39973@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 22:23:00 +0200
X-Gm-Features: AS18NWAwEK0xFf7I_pMfTz6YWIzdztaknH-Q6eCKdbOqKCEVDU2t6psEcsI1304
Message-ID: <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Max Kellermann <max.kellermann@ionos.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:14=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Sep 17, 2025 at 10:59:23AM +0200, Mateusz Guzik wrote:
>
> > A sketch, incomplete:
> > static DECLARE_DELAYED_WORK(delayed_ceph_iput_work, delayed_ceph_iput);
> >
> > static void __ceph_iput_async(struct callback_head *work)
> > {
> >         struct ceph_inode_info *ci =3D container_of(work, struct
> > ceph_inode_info, async_task_work);
> >         iput(&ci->netfs.inode);
> > }
> >
> > void ceph_iput_async(struct ceph_inode_info *ci)
> > {
> >         struct inode *inode =3D &ci->netfs.inode;
> >
> >         if (atomic_add_unless(&inode->i_count, -1, 1))
> >                 return;
> >
> >         if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> >                 init_task_work(&ci->async_task_work, __ceph_iput_async)=
;
> >                 if (!task_work_add(task, &ci->async_task_work, TWA_RESU=
ME))
> >                         return;
> >         }
> >
> >         if (llist_add(&ci->async_llist, &delayed_ceph_iput_list))
> >                 schedule_delayed_work(&delayed_ceph_iput_work, 1);
> > }
>
> Looks rather dangerous - what do you do on fs shutdown?

Can you elaborate?

This should be equivalent to some random piece of code holding onto a
reference for a time.

I would expect whatever unmount/other teardown would proceed after it
gets rid of it.

Although for the queue at hand something can force flush it.

