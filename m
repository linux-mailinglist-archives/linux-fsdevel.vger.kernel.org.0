Return-Path: <linux-fsdevel+bounces-64328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EDABE11D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 02:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6925B34B22B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 00:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D317187332;
	Thu, 16 Oct 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUEydbtw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A3146D45
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574994; cv=none; b=HywsvYVEtNbEqGhRKRlN3ku8W1jRvGdDvsXW37Jc3OZSPoNAq1qvaMYl28TDeS1jBzoc96INVmTPiF6SMGIwbimdmWfDcI8skH665mfmrM4Dty1PUAMk7NWB2MkbsaBIcfKWIADwCEa8w9t7iZcmv/TZj51GZO8X1xpENoFBgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574994; c=relaxed/simple;
	bh=YeeymcSn9GE5euQEeuGH39wYjtEBSZ/Nvea0SybK0P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIxMKoWC4lSl+l1F0GQCpjPP6k6GOn9x1EEfhk+3RMQFXf6ybc5jgGsw5W/B7r+lY9B2hwyzW5javnFlEIxUa698opz5y7RW0cAwJoJLSLSVRFL9kb9vb8P7OYy6t02L6dHjnoLdBVC4I00yT0xz7MzMCsTW3G30onC4O+uvq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUEydbtw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87499a3cd37so1879716d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760574992; x=1761179792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeeymcSn9GE5euQEeuGH39wYjtEBSZ/Nvea0SybK0P4=;
        b=dUEydbtwbOrSgk8KvWGW2tBTXMtOKhGfgZpwwrHz+yQUra+B49fRpe5Q7Z/ZNwvoas
         kJFpFLdCFw8t8ewnghlDIxnMp+SzEIRVzTP3DuXuBIBDny1EQe0MUvai36XzAja7RxUA
         Hr/Z5bp9PH8HTNf9NW6N5OgulGdNI5ajkzWWgZXW2DSaz3LmEeH8ANU2b6dGS85y1e5h
         ZrjZTdr800N+jwh9YXXWTSPsLXhFE2jih0avgA06iux3X7iWAWU+gavyDGMsLdYAVaY6
         GRYxwCK0MtHLZHnej9tA4baLo40l937345OKbRSWramrNqZ2hK5tkiQ85b2XYbA7jX6y
         DJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760574992; x=1761179792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeeymcSn9GE5euQEeuGH39wYjtEBSZ/Nvea0SybK0P4=;
        b=skL58JO3dkIomP0KE5NP9OtD6wF4m+Fw3MZLvd60uVeZ9GB8o6FiHIJ11xCeqivVx+
         Cl9DO5w1NRYg96Y6VgFp1QO4FIzYWJ+/8ViCMrh6mHkO+npzLTWzS+rMeyb5oZT4ogrR
         bDSTq5tTsfv6eGM8VhhezQjGv9sRPvhI+WiSw5tdtOMFNT8XEDRYkA8EOFG9L06xxk53
         /NwkmfqAh6dZaRSdHDcGHjan01ZwS+dox47UkcFJ7Xs2KPL/JJZb/0UrK3PshvZTFrJ4
         mftQ4ZY69rX5hKxImPJUCQ0NxdxyUXgiXr/oLbds7YaOyQ0mAzhV/iFpGfnIIO50YyIs
         VR4A==
X-Forwarded-Encrypted: i=1; AJvYcCWAFbFE2uFzTR8FCgD7UriBr3JleBYZgzRrWEcyuNO6GrQzxXfBkb9raM746Juq+ERvBgMAoPwWRVMaKq5t@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdXftcWXFHDTmc0bY7flwbNPiPCOEJ5BrJLpFxd5pVEcET5UX
	oVXOf2C6+zdR2BC1S0+O2NlFny4+wg80+P3Ey3VFnVxWe3jvjxib+aSBhtihNjjHLtT4IiGuj35
	r5jdy7lx65FztdyaVXpT6m53b/ruvF1M=
X-Gm-Gg: ASbGncvTMcbvV+oQvF5P9FfyM70m/kBtVNie6qyJ4/FMfjuqyqlQ10eUaYgLdRxqF3A
	cTehjKouyEYLxqgmyB+JKQN5XAw/vJs/yV+6Ricq5gu1/1WdJuNfujVO4F6v91GPbvJc6VAHyFN
	MjKa3MRBv2OeNQ4/EeAKVBbM3UxksHHNyRq3F1EALrMyuEXmF9Soyw+jGNZF/kjr64HyBXWsdtv
	b3qbzckgX2H00J6GmN+O4nAZmfIwV0mWhxBxj7Q3cYNBtCL1COEwl0EgQap9VW2JOPTmeVY8/E9
	CEtahQM2COwMrEXAgK0Lay/KGA4=
X-Google-Smtp-Source: AGHT+IGiwlgUceNMxDADJcjeRBufYOHtwfvRNUZQho8WVMFfuj6dQI+6+Z0167teQc2d4L7//FVME96waP8WBL2n7oc=
X-Received: by 2002:a05:622a:2514:b0:4c3:b7b0:3317 with SMTP id
 d75a77b69052e-4e6ead57fd0mr463192891cf.42.1760574991849; Wed, 15 Oct 2025
 17:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com> <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com> <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com> <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
In-Reply-To: <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 17:36:21 -0700
X-Gm-Features: AS18NWD20G-C0e4P_mTeWD4nAxxhd2JOD8DexSVzEOAozH2zP7jFT2HYIxT-EQE
Message-ID: <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> Hi Joanne,
>
> On 2025/10/16 02:21, Joanne Koong wrote:
> > On Wed, Oct 15, 2025 at 11:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
>
> ...
>
> >>>
> >>> This is where I encountered it in erofs: [1] for the "WARNING in
> >>> iomap_iter_advance" syz repro. (this syzbot report was generated in
> >>> response to this patchset version [2]).
> >>>
> >>> When I ran that syz program locally, I remember seeing pos=3D116 and =
length=3D3980.
> >>
> >> I just ran the C repro locally with the upstream codebase (but I
> >> didn't use the related Kconfig), and it doesn't show anything.
> >
> > Which upstream commit are you running it on? It needs to be run on top
> > of this patchset [1] but without this fix [2]. These changes are in
> > Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
> > that branch has been published publicly yet so maybe just patching it
> > in locally will work best.
> >
> > When I reproed it last month, I used the syz executor (not the C
> > repro, though that should probably work too?) directly with the
> > kconfig they had.
>
> I believe it's a regression somewhere since it's a valid
> IOMAP_INLINE extent (since it's inlined, the length is not
> block-aligned of course), you could add a print just before
> erofs_iomap_begin() returns.

Ok, so if erofs is strictly block-aligned except for tail inline data
(eg the IOMAP_INLINE extent), then I agree, there is a regression
somewhere as we shouldn't be running into the situation where erofs is
calling iomap_adjust_read_range() with a non-block-aligned position
and length. I'll track the offending commit down tomorrow.


Thanks,
Joanne

>
> Also see my reply:
> https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linux.alib=
aba.com
>
> I'm not sure if it caused user-visible regressions since
> erofs images work properly with upstream code (unlike a
> previous regression fixed by commit b26816b4e320 ("iomap:
> fix inline data on buffered read")).
>
> But a fixes tag is needed since it causes an unexpected
> WARNING at least.
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joan=
nelkoong@gmail.com/T/#t
> > [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joan=
nelkoong@gmail.com/
> > [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joan=
nelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
> >
> >>
> >> I feel strange why pos is unaligned, does this warning show
> >> without your patchset on your side?
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >>>
> >>> Thanks,
> >>> Joanne
> >>>
> >>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
> >>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04=
fc.GAE@google.com/
> >>>
> >>>>
> >>>> Thanks,
> >>>> Gao Xiang
> >>>>
> >>>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Joanne
> >>>>>
> >>>>>>
> >>>>>> Otherwise looks good:
> >>>>>>
> >>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>>
> >>
>

