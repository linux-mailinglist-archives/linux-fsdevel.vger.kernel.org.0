Return-Path: <linux-fsdevel+bounces-64793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0C3BF4048
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023D618C476F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E802FB0B2;
	Mon, 20 Oct 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxUpoPKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B492356A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002743; cv=none; b=e4E2iIw36WP0MEJ0dZvPJeuoIjw/YGM18jHLPjc5cYnMjB5Q9vF7kH/V2SLpb3HcKMlcNR2hKHHpZemmza7Yk5N+AzNcuyybk3ITOP651M7MDh5pReNa+/QY6jH+0JqYPr01z7cCkDGIrsvU8sfPOo/XYzS8Jc4fM3qZqWugmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002743; c=relaxed/simple;
	bh=+gLipy4yex2p4PWvmxYub5JHQmLCnp/6eSFk0A+6ocY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA51tlDX/60aMp3Cv5uXn95zY3695XPTsTAWtz9eLdmYaE3gx5fEF7v9nxb/cxwWjEpqpvTN7Hb99eNomX4R7kVICoVEAir0wTTtK2f6kAxFaRiq8ZnJzLVINsxg7VOT2mj7bY5lRDuV0dFwC0nz/xZjlLFAH0obsIeeCyZbbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxUpoPKQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87c167c0389so79836956d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761002740; x=1761607540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN+ffqWEJPzPT6negWyE8KVdrVBZV5jjr7/2WSxvqAc=;
        b=SxUpoPKQuE2d5Mp/wMwYtPDiLVkFOumxMwyhigIx3JWpl1wLC9fE3BWHgLjK6BZ+7F
         Mn9MnDubxlhrud7J5FaLq7TJvQx8/JXw+WsG8W7hM9CzeTx21vvPGRVcnUqiGQhtYyXI
         kT0ZndcHqMCYNi5HpYohQzqebvUIDC0s3CvN5XmNbnpmmEBuoeNqDmwC4Fm2Veem2ujR
         JlessdQ7IWp9m8Fj9qhEz89DmOfYjDN3CVJOJS5zkvpYEKV4mqODbDa3CWwlHFkcchnO
         Nea4vg0WJgQv+NZc6W6NIKGmGYeWwl1LCiTH7oaxnTKnoW1xOqq6vJLa0B0V4Z306koS
         FMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761002740; x=1761607540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN+ffqWEJPzPT6negWyE8KVdrVBZV5jjr7/2WSxvqAc=;
        b=JuHIRQbiwKQz6EWH5XcRIi5JwqHwHlPeq5T8btFw/0uKjC3iLof3WSsOMSkLEp5boK
         Cb8x27VJtrvKQm40iUhmroZmViR5XZYf50kdq8SGwXqtPmQRga1YSWV2WEuoGlLMyRka
         FmkSf6VkF+APBzohrGxKKE/NKftMsmWVijEYkAnVeqXHkbWrcB9Eo4MdNW4mPzfrzlmL
         0WKiBkb/pNYsBe4ApcaGPEc4sJm1yyd2KfzFec8TwknLrkhznwbKRIEwTwKplzWLBEYK
         d5/H8f++JoGzlD9gPFzIlNKwmbsB/Awg9bWfKJJRKfY93cPJtTeoX+fRMmdvuEN0KJiY
         QNng==
X-Forwarded-Encrypted: i=1; AJvYcCWogRWeBTQSOkgCUhVP6RQrMq/27yRyPIK5Ma7aOqydMiwleQApppeWp0MmHwVLI3E1x8lgG/DBfuoeR9iT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lADlP3LdcUT7KlgVT58ZXt+qIDVSoDxtUR3RkaIS23mX4OKy
	CpYek/V4GJ6W8EqUf5hOKgBQPdVsT/6AJQdUdF8Hwzn9yPm1kxEsXmYsee0G15ynPpOi41BNk+6
	S/36ZoSbsQlPXQLO+NPOqg961rgQd/yI=
X-Gm-Gg: ASbGnctOPLLtKGYaTagciWH13kZuKytHb38fUMttN71gz7CTPsS+kKZ5R3BobK8GBI/
	+FYZDAr5rzH3aILQ3XQnAMcTPcZDKIJvYt1/1FyLSnGHtzg3u6PQPKH8uPtVwAniXlvOUmU735B
	kJBgDXsRKtze4bXh+dY6fzomsVUbOADVgxAxpN+02NFn0FoBeshnY1P1hqGJwWrEYcDPP+LcTdN
	D545O2VL4UfSLfAZUjmvnCAED0ZKSnE+KRmW1fB7Xp087F/MEda1Ptculer0dVVLII8OfjG4doF
	0FPBXzRyQl/F/mYPb5fCyy4bop3ZW9ESyEbk7g==
X-Google-Smtp-Source: AGHT+IGTpD9hPc664sQSKEb1VpZEkbSsBGuHXvax9cafuQpP0iDrj//MfPO1FUmzGL4N+cYGkmOfo92GyBSx0C9OWaE=
X-Received: by 2002:ac8:5d0d:0:b0:4e8:aee7:c55a with SMTP id
 d75a77b69052e-4e8aee7c7f4mr117321331cf.26.1761002740360; Mon, 20 Oct 2025
 16:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <aOxrXWkq8iwU5ns_@infradead.org> <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com> <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com> <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com> <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
 <01f687f6-9e6d-4fb0-9245-577a842b8290@linux.alibaba.com> <CAJnrk1aB4BwDNwex1NimiQ_9duUQ93HMp+ATsqo4QcGStMbzWQ@mail.gmail.com>
 <b494b498-e32d-4e2c-aba5-11dee196bd6f@linux.alibaba.com> <CAJnrk1Z-0YY35wR97uvTRaOuAzsq8NgUXRxa7h00OwYVpuVS8w@mail.gmail.com>
 <9f800c6d-1dc5-42eb-9764-ea7b6830f701@linux.alibaba.com> <CAJnrk1Ydr2uHvjLy6dMGwZj40vYet6h+f=d0WAotoj9ZMSMB=A@mail.gmail.com>
 <b508ecfe-9bf3-440e-9b50-9624a60b36dd@linux.alibaba.com>
In-Reply-To: <b508ecfe-9bf3-440e-9b50-9624a60b36dd@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 20 Oct 2025 16:25:29 -0700
X-Gm-Features: AS18NWCkHY8KZoDE_PjiSY4vqlAt-cR2PeHot4qUhEx1YIo6lkH6gadhsxtMSHI
Message-ID: <CAJnrk1aj30PebLo7q4BMDoTU5Pyn25U7dZRK6=MvJcFSfb-4XA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:13=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2025/10/18 07:22, Joanne Koong wrote:
> > On Fri, Oct 17, 2025 at 3:07=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>
> >>
> >> On 2025/10/18 02:41, Joanne Koong wrote:
> >>> On Thu, Oct 16, 2025 at 5:03=E2=80=AFPM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> >>>>
> >>>> On 2025/10/17 06:03, Joanne Koong wrote:
> >>>>> On Wed, Oct 15, 2025 at 6:58=E2=80=AFPM Gao Xiang <hsiangkao@linux.=
alibaba.com> wrote:
> >>>>
> >>>> ...
> >>>>
> >>>>>>
> >>>>>>>
> >>>>>>> So I don't think this patch should have a fixes: tag for that com=
mit.
> >>>>>>> It seems to me like no one was hitting this path before with a
> >>>>>>> non-block-aligned position and offset. Though now there will be a=
 use
> >>>>>>> case for it, which is fuse.
> >>>>>>
> >>>>>> To make it simplified, the issue is that:
> >>>>>>      - Previously, before your fuse iomap read patchset (assuming =
Christian
> >>>>>>        is already applied), there was no WARNING out of there;
> >>>>>>
> >>>>>>      - A new WARNING should be considered as a kernel regression.
> >>>>>
> >>>>> No, the warning was always there. As shown in the syzbot report [1]=
,
> >>>>> the warning that triggers is this one in iomap_iter_advance()
> >>>>>
> >>>>> int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
> >>>>> {
> >>>>>            if (WARN_ON_ONCE(*count > iomap_length(iter)))
> >>>>>                    return -EIO;
> >>>>>            ...
> >>>>> }
> >>>>>
> >>>>> which was there even prior to the fuse iomap read patchset.
> >>>>>
> >>>>> Erofs could still trigger this warning even without the fuse iomap
> >>>>> read patchset changes. So I don't think this qualifies as a new
> >>>>> warning that's caused by the fuse iomap read changes.
> >>>>
> >>>> No, I'm pretty sure the current Linus upstream doesn't have this
> >>>> issue, because:
> >>>>
> >>>>     - I've checked it against v6.17 with the C repro and related
> >>>>       Kconfig (with make olddefconfig revised);
> >>>>
> >>>>     - IOMAP_INLINE is pretty common for directories and regular
> >>>>       inodes, if it has such warning syzbot should be reported
> >>>>       much earlier (d9dc477ff6a2 was commited at Feb 26, 2025;
> >>>>       and b26816b4e320 was commited at Mar 19, 2025) in the dashboar=
d
> >>>>       (https://syzkaller.appspot.com/upstream/s/erofs) rather
> >>>>       than triggered directly by your fuse read patchset.
> >>>>
> >>>> Could you also check with v6.17 codebase?
> >>>
> >>> I think we are talking about two different things. By "this issue"
> >>> what you're talking about is the syzbot read example program that
> >>> triggers the warning on erofs, but by "this issue", what I was talkin=
g
> >>> about is the iomap_iter_advance() warning being triggerable
> >>> generically without the fuse read patchset, not just by erofs.
> >>
> >> Ah, yes.  Sorry the subjects of those two patches are similar,
> >> I got them mixed up.  I thought you resent the previous patch
> >> in this patchset.
> >>
> >>>
> >>> If we're talking about the syzbot erofs warning being triggered, then
> >>> this patch is irrelevant to be talking about, because it is this othe=
r
> >>> patch [1] that fixes that issue. That patch got merged in before any
> >>> of the fuse iomap read changes. There is no regression to erofs.
> >>
> >> Can you confirm this since I can't open the link below:
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> >> branch: vfs-6.19.iomap
> >>
> >> [1/1] iomap: adjust read range correctly for non-block-aligned positio=
ns
> >>         https://git.kernel.org/vfs/vfs/c/94b11133d6f6
> >>
> >
> > I don't think the vfs-6.19.iomap branch is publicly available yet,
> > which is why the link doesn't work.
> >
> >  From the merge timestamps in [1] and [2], the fix was applied to the
> > branch 3 minutes before the fuse iomap changes were applied.
> > Additionally, in the cover letter of the fuse iomap read patchset [3],
> > it calls out that the patchset is rebased on top of that fix.
>
> Ok, make sense, thanks.

The vfs-6.19.iomap branch is now available. I just triple-checked and
can confirm that commit 7aa6bc3e8766 ("iomap: adjust read range
correctly for non-block-aligned positions") was merged into the tree
prior to commit e0c95d2290c1 ("iomap: set accurate iter->pos when
reading folio ranges").

Thanks,
Joanne

>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250929-gefochten-bergwacht-=
b43b132a78d9@brauner/
> > [2] https://lore.kernel.org/linux-fsdevel/20250929-salzbergwerk-ungnade=
-8a16d724415e@brauner/
> > [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joan=
nelkoong@gmail.com/
> >
> >> As you said, if this commit is prior to the iomap read patchset, that
> >> would be fine.  Otherwise it would be better to add a fixes tag to
> >> that commit to point out this patch should be ported together to avoid
> >> the new warning.
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >>
> >>>
> >>> Thanks,
> >>> Joanne
> >>>
> >>> [1] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-jo=
annelkoong@gmail.com/
> >>>
> >>>>
> >>>> Thanks,
> >>>> Gao Xiang
> >>>>
> >>
>

