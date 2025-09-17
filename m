Return-Path: <linux-fsdevel+bounces-61891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E13B7F8F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76FC3284A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8332EA727;
	Wed, 17 Sep 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="d52FgUFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264CE2D7DF2
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100848; cv=none; b=LssCw7hDIWZJYFNhMu9pkx9vbjZ84Yuj7HOhXm797kR4QW+S3xlkfzLx4VmLWI5JjNmnsPmnEZ3VruNAmrEtSzCE0dwu7xauUmQbvBWgsxos1niNhw45s/LwOx5jZkCDdTrb/PUjSNkzmZrOickRWjRO40EJ6F+SNWcjmt0pIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100848; c=relaxed/simple;
	bh=tbSJkIij2c0zcGKXfLRJg+LHmV+4oS0vVsJc36lMj/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3rrr7FPa+excRCrojE44DRPp0LxAw4ceVm2F1GOb6QKGmuEl9uNvH/WI2MuJaxSSdUduEqfUBWegF23u9qKb37GqJ5mOQkXzhDmlrfFV6TBhOLBFmitU68Eo/SOOnfH38xJPxJN6sJYykl02PT1+GzNaPgMXwCSWBdgi4kRAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=d52FgUFz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b04770a25f2so890910166b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758100844; x=1758705644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfy72Mb7ZknB0z0xXbtqc/r/yzrvqlFzmLASJN5p7Tc=;
        b=d52FgUFztRr/4cxBj/gphtly4pye/j68ubyHKwV5Mqr7Q8QWzQMTrPt7cflhYtY+Gc
         nptEPaWNdMSQtYm+XFi6oDXK1+1gQAMbaG/iuAhEFEh8gcaNET8uQ60MJ7qXnfdhLBal
         /hi7YAi2NNwQ6vbIjl8kFhjilXCIjTLVnNy2cwiw+brRpWQJfJsvuh19BENxV09dTOJu
         UIlwHIm2abEYfAWxx6YtTKB9QcC+RCv5ZhXMXSbjXt22TvP5kUNOfIT5mkzMEB2B7ZZ3
         +UCHT3nvFHNyuMXc+/I/UcAvCdQz+Ne0dZVBbqsM2hky/NTeBQ20fRJY1Tk8I3Tzd4VN
         7XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100844; x=1758705644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mfy72Mb7ZknB0z0xXbtqc/r/yzrvqlFzmLASJN5p7Tc=;
        b=V3pKyDTXEMqnjSLYb8rpUKjNpfxP6CeMM8Nj6OVhZWajHnzIOvOpSl6usJABoS0mb7
         69smLjMupM18zkIIy2rV3CupEO/SvOcECElX3OQuMEXdsQVklSjtQoxAyfeNB8RtyIw+
         4s/AHmwn4TEdYAt84VbXrixASbP4SrkEydClH0lS2c9Oad4iovgJQgQlA3Zr8kdTf8Qg
         aFNQPA0IebVqrQzXfNuyjpbW37swELwY7ffUrNcTRWi8PyJ9D852Q49SI7Vx/v+mCHQs
         H+qfKhiRNO2QZBGW2y3US6mWSX55Ey8U2+vewT3DaHQ4Vrn4gNim6uTZysVen+SAdUBF
         4XAA==
X-Gm-Message-State: AOJu0YzrA84QGnQpGcZTwvZ+k339RRmSGVMhq6Q2AU7LcvGMIkU2iOKo
	03Z57bWLT1bQs4obkfNryG6qurjSKRAo1WbOdHK+BlcALMSa0rMDQibYFlIYpH5oHKdZhDHi0i/
	JLE7hb2btgqlliK4xEZdMdvk73ibcqd6ClOaSEw5JOHig/P5Se2SH
X-Gm-Gg: ASbGncv0yES25Y5IML4dwlH3JDU5tXcxsL3w/tZe0wnImMvDZ4B9dCgTk12DY/bDu2+
	Kj5ek6XitJHiny/wRclzedJvuNMqNN+gBxyf/iLkvbkS/qVHkYrJ23uf8TO+8PVFnb8SSs9q5Gj
	eaDs/SdnS9RJEskHovV453IUpmuWYk7eKNRxJ+ks+GV0XMEhUeTH+1k4l8iA6+etbwW7NKnDL5m
	nM637/dHm4LZSVlgAkK4NPh3v31aHP1/GVO2RBsdIOeQAA=
X-Google-Smtp-Source: AGHT+IEuwtAHMUHjO1x3ENSlxdOmbju+xnSnCyHh4cRztllkF7bNH5RwzXT8gyIuvTUrZr4/rmjjgYdEHERK/tIiwXE=
X-Received: by 2002:a17:907:94c3:b0:b14:53a0:5c61 with SMTP id
 a640c23a62f3a-b1bb4337342mr176847366b.12.1758100844320; Wed, 17 Sep 2025
 02:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com> <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
In-Reply-To: <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 11:20:33 +0200
X-Gm-Features: AS18NWB7XvnaQ-WcvFZZGW6kOLpaf69Y5rLJa_6Q1pxrO9zJ4eZ1OfMv2xVqu3c
Message-ID: <CAKPOu+_B=0G-csXEw2OshD6ZJm0+Ex9dRNf6bHpVuQFgBB7-Zw@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:59=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> There happens to be a temporarily inactive discussion related to it, see:
> https://lore.kernel.org/linux-fsdevel/cover.1756222464.git.josef@toxicpan=
da.com/
>
> but also the followup:
> https://lore.kernel.org/linux-fsdevel/eeu47pjcaxkfol2o2bltigfjvrz6eecdjwt=
ilnmnprqh7dhdn7@rqi35ya5ilmv/
>
> The patchset posted there retains inode_wait_for_writeback().

That is indeed a very interesting thread tackling a very similar
problem. I guess I can learn a bit from the discussion.

> > My idea was something like iput_safe() and that function would defer
> > the actual iput() call if the reference counter is 1 (i.e. the caller
> > is holding the last reference).
> >
>
> That's the same as my proposal.

The real difference (aside from naming) is that I wanted to change
only callers in unsafe contexts to the new function. But I guess most
people calling iput() are not aware of its dangers and if we look
closer, more existing bugs may be revealed.

For example, the Ceph bugs only occur under memory pressure (via
memcg) - only when the dcache happens to be flushed and the process
doing the writes had already exited, thus nobody else was still
holding a reference to the inode. These are rare circumstances for
normal people, but on our servers, that happens all the time.

> Note  that vast majority of real-world calls to iput already come with
> a count of 1, but it may be this is not true for ceph.

Not my experience - I traced iput() and found that this was very rare
- because the dcache is almost always holding a reference and inodes
are only ever evicted if the dcache decides to drop them.

> I suspect the best short-term fix is to implement ceph-private async
> iput with linkage coming from struct ceph_inode_info or whatever other
> struct applicable.

I had already started writing exactly this, very similar to your
sketch. That's what I'm going to finish now - and it will produce a
patch that will hopefully be appropriate for a stable backport. This
Ceph deadlock bug appears to affect all Linux versions.

>         if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
>                 init_task_work(&ci->async_task_work, __ceph_iput_async);
>                 if (!task_work_add(task, &ci->async_task_work, TWA_RESUME=
))
>                         return;
>         }

This part isn't useful for inodes, is it? I suppose this code exists
in fput() only to guarantee that all file handles are really closed
before returning to userspace, right? And we don't need that for
inodes?

Thanks for your helpful advice, Mateusz!

Max

