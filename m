Return-Path: <linux-fsdevel+bounces-11931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655B8593BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 01:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891551C20C58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 00:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22B37B;
	Sun, 18 Feb 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="IUrb7Bkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84436E
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708217335; cv=none; b=bOFfQc9S8n8jwwPcRkgvxA6+A40p/2LWzXzArHXEJGbMM0FyizjlG589l2vuDlPgyNjVyzON9B1ND7GgpEOgqGARI5SfMBWlKtBhQHQ+rRw0//JXqJwb6E034i09OnLO1RSD++3wqm2I7F8zUXYrlNuMlRc62TFRDduKXxbpywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708217335; c=relaxed/simple;
	bh=q8jP+VeIZ0rH4HxfKAy5MOOxCXvew0uHPDIzX8+s1CE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Le9VmB/HSm2s74NhfS1aEgmDPmO11Fr1NjcxuzYy0oYUEn7sR+DXfZLCccxtWlFIs2vH1MUHpd7bb4UEFvtEH4LxEnUqyAscIX7uz/KDV1tvnWjQL6eaUO+TqveQu+MAHVxhUdesziwaSGUH0lEibilr9xcNktKYUnYc0dx6rCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=IUrb7Bkb; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail3; t=1708217324; x=1708476524;
	bh=q8jP+VeIZ0rH4HxfKAy5MOOxCXvew0uHPDIzX8+s1CE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IUrb7BkbzOYgsIl/Y5HOwXmgnsD66VOgLSrYS1jduBjNsjN5Ev24L89uLp8jl8ZEC
	 b0qbAYiIqRPIC1uHvRFRJlnyg+CrAM1kdkg1shEHKmiv27ljcWYUkhHkEUf2mnnxhY
	 V1TByrt5+++Kk1Bxw0YryOo2JZ3L8xPENWuWHjpTd3gf7PG4w9VJT32sqpDUQOIh4x
	 PwB+2vuBU+lyq1/q4/We+XzJn2I+Ag7bhAiK3NjeFhQ7ur++z1jKNopA+vzYmmO0zu
	 WTf9ojuxyClOlqpbTam0AHtbua4YW9ATFbq3W0sY5jDvg/UsodxnqgWNtmLYaIfak+
	 ygeesCQeLPj4Q==
Date: Sun, 18 Feb 2024 00:48:21 +0000
To: Amir Goldstein <amir73il@gmail.com>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Message-ID: <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link>
In-Reply-To: <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link> <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com> <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/24 01:04, Amir Goldstein wrote:
> On Wed, Feb 7, 2024 at 5:05=E2=80=AFAM Antonio SJ Musumeci <trapexit@spaw=
n.link> wrote:
>>
>> On 2/6/24 00:53, Amir Goldstein wrote:
> only for a specific inode object to which you have an open fd for.
> Certainly not at the sb/mount level.
>=20
> Thanks,
> Amir.

Thanks again Amir.

I've narrowed down the situation but I'm still struggling to pinpoint=20
the specifics. And I'm unfortunately currently unable to replicate using=20
any of the passthrough examples. Perhaps some feature I'm enabling (or=20
not). My next steps are looking at exactly what differences there are in=20
the INIT reply.

I'm seeing a FUSE_LOOKUP request coming in for ".." of nodeid 1.

I have my FUSE fs setup about as simply as I can. Single threaded. attr=20
and entry/neg-entry caching off. direct-io on. EXPORT_SUPPORT is=20
enabled. The mountpoint is exported via NFS. On the same host I mount=20
NFS. I mount it on another host as well.

On the local machine I loop reading a large file using dd=20
(if=3D/mnt/nfs/file, of=3D/dev/null). After it finished I echo 3 >=20
drop_caches. That alone will go forever. If on the second machine I=20
start issuing `ls -lh /mnt/nfs` repeatedly after a moment it will=20
trigger the issue.

`ls` will successfully statx /mnt/nfs and the following openat and=20
getdents also return successfully. As it iterates over the output of=20
getdents statx's for directories fail with EIO and files succeed as=20
normal. In my FUSE server for each EIO failure I'm seeing a lookup for=20
".." on nodeid 1. Afterwards all lookups fail on /mnt/nfs. The only=20
request that seems to work is statfs.

This was happening some time ago without me being able to reproduce it=20
so I put a check to see if that was happening and return -ENOENT.=20
However, looking over libfuse HLAPI it looks like fuse_lib_lookup=20
doesn't handle this situation. Perhaps a segv waiting to happen?

If I remove EXPORT_SUPPORT I'm no longer triggering the issue (which I=20
guess makes sense.)

Any ideas on how/why ".." for root node is coming in? Is that valid? It=20
only happens when using NFS? I know there is talk of adding the ability=20
of refusing export but what is the consequence of disabling=20
EXPORT_SUPPORT? Is there a performance or capability difference? If it=20
is a valid request what should I be returning?

Thanks in advance.


