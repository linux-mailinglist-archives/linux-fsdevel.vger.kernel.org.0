Return-Path: <linux-fsdevel+bounces-61929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05636B7F1CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE524E30D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC734323402;
	Wed, 17 Sep 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxMcTppA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1431BC88
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114843; cv=none; b=aqRz4gCD04+2vz6FwplZA9rDpETH2BsL9sX3U7mgkmYFpVrtUMdk/1GaMjsy36Ypmo/swdYZHgAwlh98MiBAokFMJcF9LoopqC+tjvQHw59+L3/NKvRnmpB5G79MJNFxciuSZHf1AwVdZ6htLTUonIIibPN4GCb9hAowhSEfFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114843; c=relaxed/simple;
	bh=HfiXVahdmKU9llTpUf4nFKXL5fsS+NIMrnVM7WxbQ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCY3/xjNgJeMKrzhJlaZ4adjsnQdtbba3TaeegZ1hYG8nM9g9n/F4L07MXklKRX5tGlNKtQbm7YsApKNmN3JymD11QA7qRSD/tntMwteHkRRk+1cUpU69Pvw/usYHGTF7LlxvmEjZZfihwG9DtOvyrpR+TCWwvd6aJViwEGSVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxMcTppA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso4174611a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114840; x=1758719640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5H63/AUiRra8BoZW6vXEUzxV1wo5MwGIxUp9c3IcVo=;
        b=FxMcTppA2m9EJYMUyH6eXSiv7TJuwxLwsolHBG+iDiRfIF+wx96PM3Q40XArdlyrHn
         ccxdcbkyPdj8GlcZcWJswrF+vHFOfAVm4IQAIt6BZo+Q/MRxaee6n59phIZ8Mg7e/E7f
         tUS3gWqcDuqsMng84h52zYvpp2OOEMAOw3dAIBTA550pemVr7aXgMtJx8Cl5SxYO3qTY
         Xc0z0633NjtcFs+crC/egv9JbPYHqmftSxyoEL5hTSzQQnGX2uc2mrArHQnKHmM1ndiK
         wDTyvEJSGKNYSlY8zVZJK/gQs0QO4jf6FTvHROBDqSVKeI4tQA0VhZcfwtZwsvOwMebe
         CFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114840; x=1758719640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5H63/AUiRra8BoZW6vXEUzxV1wo5MwGIxUp9c3IcVo=;
        b=eoi3Cf28utA57NDZgrWVirZkFNp1OEGFk6AgVnh3f7X8ng8aqHG92fHtJzOa0DLQC+
         WfVcSCd+7q4++UHKmx/4whI24IYLJEs+WwMx+9zPhE4m/aQwB+KmFdv9UoUeiaPt+zmB
         K+bZOi2PjOojAxoRPjlGNaOSNKOnE5WnL7GzjRTvWMsAx5fUNo9eV4qNwyoaebdPIrjG
         Y5VGaIHkDqh9j/cKUKvrDkGgsyzQpqHmyRy8g18p/vu5ZiIYu1mSPQyp+8MQ22bHsNhh
         MQcp/jY1CcQ02ZFZs/WhtEJBZ7bLROMF4LEysgQR07iFeL06tH4Y1v44mZuxtfWwLjvi
         v4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIZduHstTFZqolvLdKQQoo0bwPo/kiDx7Bm72a/6L6BZ2fi/iZIS6tYvU7zJk9XVuXeXaOT3+uQ8DwMAMr@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7L2GhxSqjSF2dULlsLaed1U0cVtbtk896u8tYNYfgt8dIiTd
	f2Sux2uNqchPSNF0DUnqi7Nb6CxR4aGEwLYovdnTDx7ONCtO3wg6k+7uE7TmCQXMxwyZ36hnxMA
	3c25XmHn0+Hw1UscsyCU+eJ/azhA1GFc=
X-Gm-Gg: ASbGncvhmwcBxDdS0Jw4NDkMu+ujRXGwCQMrUGPK4T4vpnagde7A/13FhNPZzQ1Q0d1
	b1q50jYGw4fyPe8YC3boRQ2cWkAHKXcDDKYvHOQw5fmWWHVlcPnp/3nn5T2/Q9xr4GXbzToPImw
	eGMUJQVtHMazQrA4mX5rYo3PJt2Vfdb7cg16457srfleaSO1BATz7x9MqeYhiKUB1RX01rgNf4y
	oqxZAyBT1ouN0peyvCz9PR14MsZ6E10Ipe//U8=
X-Google-Smtp-Source: AGHT+IHZqG7bIkkgFnNnamLc+d2ib1zkjvzaCKTtDXUUOD25WDP7oC1jkuiVQ7lPHR9J6yOsbhbl9bqd49wGef5FN+U=
X-Received: by 2002:a05:6402:5c8:b0:62b:63f8:cdbb with SMTP id
 4fb4d7f45d1cf-62f8444b4ecmr2100800a12.25.1758114839438; Wed, 17 Sep 2025
 06:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
In-Reply-To: <20250917124404.2207918-1-max.kellermann@ionos.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:13:47 +0200
X-Gm-Features: AS18NWAAFc83ppVkA4fnw2IGGyxvDdDuE0G3TJ0kjzGRSMkmIKZ5yfl7jNQoS8Q
Message-ID: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:44=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:

I don't know about ceph internals, so no comment on that front.

> +/**
> + * Queue an asynchronous iput() call in a worker thread.  Use this
> + * instead of iput() in contexts where evicting the inode is unsafe.
> + * For example, inode eviction may cause deadlocks in
> + * inode_wait_for_writeback() (when called from within writeback) or
> + * in netfs_wait_for_outstanding_io() (when called from within the
> + * Ceph messenger).
> + *
> + * @n: how many references to put
> + */
> +void ceph_iput_n_async(struct inode *inode, int n)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_sub_return(n, &inode->i_count) > 0))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +
> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* the reference counter is now 0, i.e. nobody else is holding
> +        * a reference to this inode; restore it to 1 and donate it to
> +        * ceph_inode_work() which will call iput() at the end
> +        */
> +       atomic_set(&inode->i_count, 1);
> +

That loop over iput() indeed asks for a variant which grabs an
explicit count to subtract.

However, you cannot legally transition to 0 without ->i_lock held. By
API contract the ->drop_inode routine needs to be called when you get
here and other CPUs are prevented from refing the inode.

While it is true nobody *refs* the inode, it is still hanging out on
the superblock list where it can get picked up by forced unmount and
on the inode hash where it can get picked up by lookup. With a
refcount of 0, ->i_lock not held and no flags added, from their POV
this is a legally cached inode they can do whatever they want with.

So that force setting of refcount to 1 might be a use-after-free if
this raced against another iput or it might be losing a reference
picked up by someone else.

If you got the idea to bring back one frem from iput() in the stock kernel:

        if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
                if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
                        atomic_inc(&inode->i_count);

Note this guy still makes sure to take the lock first. As a side note
this weird deref to 0 + ref back to 1 business is going away [1].

I don't know what's the handy Linux way to sub an arbitrary amount as
long as the target is not x, I guess worst case one can just write a
cmpxchg loop by hand.

Given that this is a reliability fix I would forego optimizations of the so=
rt.

Does the patch convert literally all iput calls within ceph into the
async variant? I would be worried that mandatory deferral of literally
all final iputs may be a regression from perf standpoint.

I see you are mentioning another deadlock, perhaps being in danger of
deadlocking is something you could track with a flag within ceph (just
like it happens for writeback)? Then the local iput variant could
check on both. I have no idea if this is feasible at all for the netfs
thing.

No matter what though, it looks like the way forward concerning
->i_count is to make sure it does not drop to 0 within the new
primitive.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries&id=3D9e70e985bdc2[1[1c6fe7a160e4d5=
9ddd7c0a39bc077

> +       /* simply queue a ceph_inode_work() without setting
> +        * i_work_mask bit; other than putting the reference, there is
> +        * nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}
> +

