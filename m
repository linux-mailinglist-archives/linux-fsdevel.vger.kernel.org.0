Return-Path: <linux-fsdevel+bounces-61890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BADDB7DE54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59051738CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69196314A8D;
	Wed, 17 Sep 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz5kPIdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3D313E31
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099580; cv=none; b=fgSWAEDv9Q27BoNeO/Tk8W2yMe7MRHVs4eGm1c08Y5uh/bd8CMZBav1tEJQd6kSbD5hwqKz+huwl0Te72ylu37UkTfTPFx+ZxMl38iwg1NLD3bfs4W56dGLnaEhRkvFZtpPnIoMeahwm7rpq+PVs7er7n6DsAedx7++wjKBu0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099580; c=relaxed/simple;
	bh=Ld1LnQhXB0QKpjLGe6k9t5ouZ791PHsD8Yn+V6ZL4wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmKB1yH++YFH78qmA4KHjns+XcIo/mN2x8wr+DFdsf/rxnrjpXDfEUkBWlccyaV7S4WLCpotUrEN1WIAnDf2aUWOlVOYg5c7csS/StZ2d++dvGiC+Z9PnVJ7VJ49jpf4kXtjpAJJ3oyVYVJFYD5xWGjiQpsW3oGNry5AtrcsMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz5kPIdj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b00a9989633so153222066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758099577; x=1758704377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOKz7P4HEtYH+i5ElgrU7Bp4EAn43MTUmnEdpQptHBs=;
        b=bz5kPIdjxLizdK0+wwEZXW/t8GqL5hVh5yjejJxY2Gswt3XeRyVQtBgG9YtVOGkwsB
         pHxDFi2iu6Ero4hSqmnWlSN6LhW0BMSmGWLB3kI0Nbmksv8H332wjAoSjZogbZW3kfLj
         tAgBxYIV6+Tmotkw4KTlf9n3UTiQoq40stulWGtqX2lClvI2+7ZYy0FpMI76mP2EL2vD
         yjI/BTsP1Q96zHNzDWS1oKjzJ6ao6VwjKkdi79C0kdsr5ICxfYzkU6JtqHRkmj9iSuQm
         rgK1TwK5Wk1zwDy3HRrTzSiO+bNSU6eHwKgje/Mi6b2ldbe82FxSS2blso7euJgIET4s
         vWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099577; x=1758704377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOKz7P4HEtYH+i5ElgrU7Bp4EAn43MTUmnEdpQptHBs=;
        b=xFB7rkjrh2jbuRUyXI9e8PS+rh4/uUPK68LQQ+75Tubu3AFq49xmHmaMNAIMuDK4zI
         A4jigwo+zuxbJfNNfTn8u8Klnm6TU1JpaCLLop4hR70KVMOATRQRTThNZ4+1tik6zpQZ
         MoT3nYiX09vjXySntt8vMneSMtvM6Dp9RAd8d2rRGM9RqK3tpbx1LGhR+ueu8DWO08aD
         u20mAPcMjLUzf4TvBbrB0EHKNOCMPyiI+IE6khrETQYJYlb/048QJheu8UrCJmup3YSp
         qpaXpXBdSXncHlnV3IXyEqNVSoOLEP+OVAcH3GgatNoMMovS+rVjApb+On/2CV8fKO6j
         iXUw==
X-Gm-Message-State: AOJu0Yw5rH7uA63xCUYb/FBleQORMlQYGCjP9wf2sOXkpzwHlZFBYbuj
	WeudBaUddfLA4DtmehTfIb4bLTPhJWYigqwNlXgMAoTIz7YE0Z5wZxKuHYmBzj0Y8SfXbKLIdx7
	+RC29RMUzjWzBEbtL5kGjwNIYQFwbtaQ=
X-Gm-Gg: ASbGnctzR/x3n16jj2uDkhzEYrG7JniZzPMxqv0zaEHoSJ1dAq9H5CUgGHHzluaU2G/
	qCbOi465gb+9LXL+YbotAIz9d4YwuedwhjvWyoki/j/Fb6x7kZmoRoBJaQmgYcfcvP39ldvh0sj
	mxexaWwkdFJIZ6v/K5KWwkI4VUFM34AS5mCKsDikpexo9t9QHzqRdvEjSKgI5fsbOMfh0ZbNkTB
	AM21JbINn8sTvixQNm6d7SoLOLEHXBpGc1UCYUZRKisciWbNg==
X-Google-Smtp-Source: AGHT+IF8FMgkRoO/NnsZ7DpY2fIfWx24GDJaOJTYMMvbCsE2nBH2lhvZ+nLWR7ImqMEp0F3hlSbxGlKaMDHdtZweEec=
X-Received: by 2002:a17:907:a08a:b0:b07:e348:8278 with SMTP id
 a640c23a62f3a-b168286b0a3mr607388666b.25.1758099577296; Wed, 17 Sep 2025
 01:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3> <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
In-Reply-To: <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 10:59:23 +0200
X-Gm-Features: AS18NWCmzvVAdt9cnGznBaPer5VswI6NuC9qGL-CKG8mFwH0Gs_2YwiI-pnnOec
Message-ID: <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:38=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:23=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> > One of the ways to stall inode teardown is to have writeback running. I=
t
> > does not need a reference because inode_wait_for_writeback() explicitly
> > waits for it like in the very deadlock you encountered.
>
> Ah, right. No UAF. But I wonder if that's the best way to do it - why
> not let writeback hold its own reference, and eliminate
> inode_wait_for_writeback()? (and its latency)
>

There happens to be a temporarily inactive discussion related to it, see:
https://lore.kernel.org/linux-fsdevel/cover.1756222464.git.josef@toxicpanda=
.com/

but also the followup:
https://lore.kernel.org/linux-fsdevel/eeu47pjcaxkfol2o2bltigfjvrz6eecdjwtil=
nmnprqh7dhdn7@rqi35ya5ilmv/

The patchset posted there retains inode_wait_for_writeback().

Suppose you are to get rid of it. In that case you have a corner case
where the writeback thread has to issue ->evict_inode() for arbitrary
filesystems, and that's quite a change and I'm not at all convinced
that's safe.

> > However, assuming that's not avoidable, iput_async() or whatever could
> > be added to sort this out in a similar way fput() is.
> >
> > As a temporary bandaid iput() itself could check if I_SYNC is set and i=
f
> > so roll with the iput_async() option.
> >
> > I can cook something up later.
>
> My idea was something like iput_safe() and that function would defer
> the actual iput() call if the reference counter is 1 (i.e. the caller
> is holding the last reference).
>

That's the same as my proposal.

> Almost all iput() calls are fine because they just do an atomic
> decrement, but all kinds of scary stuff can happen if the last
> reference is released. Callers that are not confident that this is
> safe shall then use my new iput_safe() instead of iput().
>

Note  that vast majority of real-world calls to iput already come with
a count of 1, but it may be this is not true for ceph.

> I can write such a patch, but I wanted you experts to first confirm
> that this is a good idea that would be acceptable for merging (or
> maybe Ceph is just weird and there's a simpler way to avoid this).
>

So the problem here is where to put linkage for the delegated work.

Another issue is that as is nobody knows who set I_SYNC and that
probably should change on kernel with CONFIG_DEBUG_VFS. As luck would
have it I posted a related patchset here:
https://lore.kernel.org/linux-fsdevel/20250916135900.2170346-1-mjguzik@gmai=
l.com/T/#t

with that in place and debug enabled we can panic early on the first
iput so you don't have to wait to trigger the problem

I suspect the best short-term fix is to implement ceph-private async
iput with linkage coming from struct ceph_inode_info or whatever other
struct applicable.

You can use __fput_deferred() as a reference (put intended). Note this
one assumes the obj is already unrefed, but for iput_async it would be
best to also postpone it to that routine.

A sketch, incomplete:
static DECLARE_DELAYED_WORK(delayed_ceph_iput_work, delayed_ceph_iput);

static void __ceph_iput_async(struct callback_head *work)
{
        struct ceph_inode_info *ci =3D container_of(work, struct
ceph_inode_info, async_task_work);
        iput(&ci->netfs.inode);
}

void ceph_iput_async(struct ceph_inode_info *ci)
{
        struct inode *inode =3D &ci->netfs.inode;

        if (atomic_add_unless(&inode->i_count, -1, 1))
                return;

        if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
                init_task_work(&ci->async_task_work, __ceph_iput_async);
                if (!task_work_add(task, &ci->async_task_work, TWA_RESUME))
                        return;
        }

        if (llist_add(&ci->async_llist, &delayed_ceph_iput_list))
                schedule_delayed_work(&delayed_ceph_iput_work, 1);
}

