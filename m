Return-Path: <linux-fsdevel+bounces-70131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E66C91C12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D84E34252D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900130DECC;
	Fri, 28 Nov 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHu5ptfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6130506A
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764328107; cv=none; b=fJ8PVeOd0o/igfVlRoamYh9LYka9oXBHT2ZFOS9PRm0NaBiEHnce8otkZ6ZkESZwodasqykqRLBvsOsn07OFZfn4ilLIZup0tFQM/lIfHXWBfRqcnauwIcp8tnHS/dAZTcQD283N84m83gRiOzFpiJ2AiMo+N8kiGj3+mb1YFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764328107; c=relaxed/simple;
	bh=ImQCiNhbMfI8Myeskauw+fSlAzgOZon0tYrN0WCzTwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOwuyCAeWlAA/S6NzLHHB2j4MNVQsbOaHtDrirSpfHX6bIHX/+wY+hAgj7utbTSYphG3tMQFDPXeflw5DIssZtu7dMxfQOi7K0pdK3eHukIMNm/HJrzAQO5qlw9jg81/f7iCxkKZxoT2Um4zYLG5j+mr3a5uLjAVxAe1GaulyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHu5ptfF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so3410603a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 03:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764328103; x=1764932903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEL8/i4pOlfEnlx9u9I20MQ7Ac/jYGHBzDFoq+Q1QzQ=;
        b=MHu5ptfFuxd5p0kh0sv6NjMUp/QCfDGpAmbPEP+XU/COJXa4c+K8cy5qoRWT/8EfAE
         5RLLogywQipPW1rEm/u0C8kvklevQqE7o2TDZPQel1UFFt4Hx4q4IAYXoLMNPUMmmoJY
         7Tqvim9HLOhv750rdigtqnk6foNj7/l/Qs+IWvjxPNs4/D0Y34g+DalJHv89AD28mfCN
         E/2E1EcueScztfjsdf4/7KJKnhcdEr5JOYmmQsLY4VeC8uii8US1pVxUeVPlKk9XYYu+
         2P93Wf9O+dg+DMxnkP5CrAnw/iLlBDEFXuKmCAdO6V5Rk5bmcwnGrg7H0hmPPArmm6XA
         IdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764328103; x=1764932903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEL8/i4pOlfEnlx9u9I20MQ7Ac/jYGHBzDFoq+Q1QzQ=;
        b=obDieV04YYVJK2vaSULLmw+y5FyAsSaolg71QkrJLIEVzUYC9rPMRU7ss4Yx2okQVB
         +lciM0r0dQljBP2I6Nqg6RLZisT6awEu8uJsx3Y4VFLS1h/y7rvfkvLK5Qou2IE1RulJ
         G1Jfin9TES/35gI2T7SsBpAQ8lZKyRjySudqtbmmRCZY75tpTybTBtFEbgN1SN6qq1ox
         ImF6R7WzLdW6R67DNR99jiB5EJ8hEbgTVpJBbpsZWftF23zJcKwbIjmYbygoB/TtUZLL
         GlTvhvZGNU1mhzKuhCia+khE1n2fynt3ae8l4TxQh+7BtioXrgrrP/qCLxKX1vsvaFuu
         OF5A==
X-Gm-Message-State: AOJu0YwCC4uuxB2wmeXVYTlosRO8vEe33ru9dYFKoISynRSUQtUUdR0h
	9Ou2m+CIg4+ijJIttQCZ/gCda3XJ41z7XXq6pQnUzaeWYEEImHQIX8iUhrDJz2ZKNVm/7Jr4qj+
	fdcLUcXh/HqMfhB1cloCw+mimTAUgzpSREZHUa2I=
X-Gm-Gg: ASbGnctHvEpfSruPbrE7hBFPd0z6fLPZktXswnQrOPzxc1IKgd4aLytr0cIW3gihFLR
	6ODp22hRH4RvRsM6jj1+szLN7jTpfeismth6EWVajPGt+vKpbzIfiBHdZMfMedsldv2xQ3pVFjk
	FLdUZ8jzcBjeoWQKJU89Pk7R7IO8I5OwaHzVAkvqRGs3x2x4J3bYrOQCzij7a8bFopCfg9O7uEB
	8p3mhUiG+Z90QgFTHBrHDGitMINtlzt/89dy/v3lDooDQLIUMTtMiVatnu/GXgc9XJZQSHTwQrn
	wOyMH2izyZusSXRSwADhCA9NQv6PKg==
X-Google-Smtp-Source: AGHT+IF98JeOCfI02hTscLVmfp/I/YZlKT0lVy/hoHJYtfug0qnGmUxvCcskN0plEU2mEy6mccgC7ZVv6I5M202OxQQ=
X-Received: by 2002:a05:6402:5213:b0:643:8183:7912 with SMTP id
 4fb4d7f45d1cf-64555b9a93emr22438919a12.9.1764328103333; Fri, 28 Nov 2025
 03:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127170509.30139-1-jack@suse.cz>
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 28 Nov 2025 12:08:12 +0100
X-Gm-Features: AWmQ_bnMkw37EBy67NsYKBjZXO7Q8_ABuUD08-Te6CJx7anJvWV7ay1lgv_aF-U
Message-ID: <CAOQ4uxgOKH5_Nqu8wWCjPQ1Y0_40p76YrvLtOP-yOsYkHTDNNw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/13] fsnotify: Rework inode tracking
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> This patch set reworks how fsnotify subsystem tracks inodes.

I like the vision, but I think we need to break the problem into smaller
pieces and solve them one at a time.

The first and foremost problem is the nasty races like [1] and more
that are possible in upstream and stable kernels.

[1] https://lore.kernel.org/linux-unionfs/20250915101510.7994-1-acsjakub@am=
azon.de/

I think it is a worthy objective to be able to solve the race in stable
kernels, so I am suggesting a more conservative approach...


> So far we have
> held inode references from notification marks (connectors of list of
> notification marks to be more precise). This has three issues:
>
> 1) Placing a notification mark pins inode in memory. Since inodes are
> relatively big objects, users could pin significant amount of kernel memo=
ry
> by this. This then requires administrators to configure suitable limits o=
n
> maximum amount of notification marks each user can place which is cumbers=
ome.
>
> 2) During filesystem unmount we have walk a list of all inodes for the
> superblock to drop these inode references. This is either slow (when we d=
o
> it before evicting all other inodes) or opens nasty races (when fsnotify(=
)
> can run after dcache for the superblock has been evicted).
>

This can be solved by putting the inode connector on a list.
AFAICT, the hash table code (which is ~90% of this pathset) is not needed t=
o
solve the race vs. inode walk problem.

> 3) Since sb global inode list is a noticeable contention point we are try=
ing
> to transition its users to something else so that we can eventually get r=
id
> of it.
>
> In this patch set, fsnotify subsystem tracks notification marks attached =
to
> inodes in a specialrhashtable indexed by inode identifier. This way we ca=
n stop
> holding inode references and instead disconnect notification marks from t=
he
> inode on inode eviction (and reconnect them when inode gets loaded into m=
emory
> again). Credit for the original idea of this tracking actually goes to Da=
ve
> Chinner.
>
> The patches are so far incomplete - I still need to implement proper hand=
ling
> for filesystems where inode number isn't enough to identify the inode. is=
ofs
> is provided as a sample how such support will look like for these filesys=
tems.
>

If you accept the POV that the hash table is an optimization to solve the
pinned inodes situation, then when adding hash table code, I think it is
safer to have opt-in sb flag to participate in "independent inode marks"
and test the code first without having to implement all special filesystems
fsnotify operations.

Heck, if only for memory optimization and not for the end goal of getting
rid of global sb inode list, then there may be no reason at all for optimiz=
ing
those special filesystems for recursive inotify memory usage - a problem
that existed forever.

> Also we need to decide what to do with evictable notification marks. With=
 the
> patches as is they are now never evicted. This makes sense because the ma=
in
> reason behind evictable marks was to avoid pinning the inode. On the othe=
r
> hand this *might* surprise some userspace - definitely it breaks couple o=
f LTP
> tests we have for evictable marks.

Those tests were never super reliable, because as in real workloads,
users can't usually know, short of unmount, if inode was really evicted.

What we can do going forward is use this currently inval flag combo
#define FAN_MARK_EVICTABLE_INODE \
           (FAN_MARK_EVICTABLE | FAN_MARK_MOUNT)

to opt-in for not pinning the inode without loosing the mark
as an explicit test for a kernel that supports this improvement,
rather than users doing recursive inotify without knowing the consequences.

Thanks,
Amir.


>
> Overall the patches passed some basic testing with LTP so they shouldn't =
be
> completely wrong but there could be bugs lurking so handle with care ;).
> I'm sending the patches for comments to the approach and whether people f=
ind
> this approach acceptable.
>
>                                                                 Honza

