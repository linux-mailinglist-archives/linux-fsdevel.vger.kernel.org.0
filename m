Return-Path: <linux-fsdevel+bounces-64803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F93BF4505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 03:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F583ABC20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F0220F5D;
	Tue, 21 Oct 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBNXdF2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E922FDEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011402; cv=none; b=R/O12JlZOA4Jt/x9fqXmlrcIHb9WP247piq6IHH/x/V+zveAus9w0txAay2ZKBixI2o+vl2+1m6D9d4pvDCHeHt2kZlhRCgQw7WUfFukLnizR5sfZwogDYRQPId9JFemFybCY6tJHihnjisVHySGhUGA3wQ/W5gDi3zULfhBlfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011402; c=relaxed/simple;
	bh=htcS7Ohbflq3HUTJuNNJeirXMdxoa+XlP8nG/tkLPa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf0VBx0Ex3xyT++IrGrO8WOYOh4sVcFwY/gkhJEUM8ZIQW1EZEA2tJb8cW6FVz6qcqMuE/Mn+JllwrDkVoRrDjmAX3anifCZ3JXba7KgO57FmK7hXAoQpWAVNlpWGRUDTa/Br3msH3U195XDykpLyuSI9G6NdYjP81KL0sRH/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBNXdF2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1789C19424
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 01:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761011401;
	bh=htcS7Ohbflq3HUTJuNNJeirXMdxoa+XlP8nG/tkLPa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XBNXdF2Ilcc9YulgsFPiGbG7wjz17utEaFxsMV71iiMOH/tIjhRSipEg5FwDIH+SP
	 i6idyg19BXwo/vdLQaCOuwQ724BpbVF5906dEu9Bm7wYdhNROduWZlyfes0Ndw/oRy
	 qTfBuxJMT/Oq2zRUVnA67x+aWu2S1X6hfNAOaxhHC/iUEpoP1fKX3W3xvh3cSqsyGD
	 zDXUXpvhz6sf8KZaQoRxqiSCzXj2p/d5LGcbQccHLwFxADFl8QYc3UC2Yk40FKHsdW
	 t++BeEUZYS7TBIQgJ2A2+qX80wgAcZqWhe/y/TGs0OD6Az7hIoG2A6pfZwB603mcA1
	 t0hGNrfvsNUOQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b463f986f80so972948766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 18:50:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPna2m9XpdTArH3Xs8t7dH4HYbKKM+6oYaPF5kVwzMPIddmYppdCltwdg5CQGHq5NAgJ/yYWlB0T+YlUsL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh14SwGs4b5jSauY7Nqtqn2fpFUlEaOJkrmOPQyHkPptXt9sMu
	N7k9sJw8/vkozVaFbL7wRrjGwJINqvuS8nq6d5ShaGUQh2aAa19yU0FZg9lUjpQe1KNlXsNgPMP
	qgM+5YOSizkNcAa2xt07slLyeljESk3Q=
X-Google-Smtp-Source: AGHT+IEzzb+tmcQzG2Fm+h+6do+wmWZd/xd0gS43UlshdlRbK/t6x0HY5waSa9V02ECCBr00hHlFk8aDTkjzJEqTYw8=
X-Received: by 2002:a17:906:7f93:b0:b5b:3ab0:a5b4 with SMTP id
 a640c23a62f3a-b6474f18313mr1312614166b.49.1761011400289; Mon, 20 Oct 2025
 18:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020749.5522-1-linkinjeon@kernel.org> <20251020183304.umtx46whqu4awijj@pali>
In-Reply-To: <20251020183304.umtx46whqu4awijj@pali>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Oct 2025 10:49:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-EZ1i9CeQ3vUCXgzQ7HTJdd-eeXRq3=iUaSTkPLbJLCg@mail.gmail.com>
X-Gm-Features: AS18NWAiuswYJeAln1hUra1uPeRZcQXi-vK-HcyFwpUVUqXqdEfbnYt4Niiowak
Message-ID: <CAKYAXd-EZ1i9CeQ3vUCXgzQ7HTJdd-eeXRq3=iUaSTkPLbJLCg@mail.gmail.com>
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, ebiggers@kernel.org, neil@brown.name, 
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:33=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> Hello,
Hi Pali,
>
> Do you have a plan, what should be the future of the NTFS support in
> Linux? Because basically this is a third NTFS driver in recent years
> and I think it is not a good idea to replace NTFS driver every decade by
> a new different implementation.
Our product is currently using ntfsplus without any issues, but we plan to
provide support for the various issues that are reported from users or
developers once it is merged into the mainline kernel.
This is very basic, but the current ntfs3 has not provided this support
for the last four years.
After ntfsplus was merged, our next step will be to implement full journal
support. Our ultimate goal is to provide stable NTFS support in Linux,
utilities support included fsck(ntfsprogs-plus) and journaling.
>
> Is this new driver going to replace existing ntfs3 driver? Or should it
> live side-by-side together with ntfs3?
Currently, it is the latter. I think the two drivers should compete.
A ntfs driver that users can reliably use for ntfs in their
products is what should be the one that remains.
Four years ago, ntfs3 promised to soon release the full journal and
public utilities support that were in their commercial version.
That promise hasn't been kept yet, Probably, It would not be easy for
a company that sells a ntfs driver commercially to open some or all sources=
.
That's why I think we need at least competition.
>
> If this new driver is going to replace ntfs3 then it should provide same
> API/ABI to userspace. For this case at least same/compatible mount
> options, ioctl interface and/or attribute features (not sure what is
> already supported).
Sure, If ntfsplus replace ntfs3, it will support them.
>
> You wrote that ntfsplus is based on the old ntfs driver. How big is the
> diff between old ntfs and new ntfsplus driver? If the code is still
> same, maybe it would be better to call it ntfs as before and construct
> commits in a way which will first "revert the old ntfs driver" and then
> apply your changes on top of it (like write feature, etc..)?
I thought this patch-set was better because a lot of code clean-up
was done, resulting in a large diff, and the old ntfs was removed.
I would like to proceed with the current set of patches rather than
restructuring the patchset again.

>
> For mount options, for example I see that new driver does not use
> de-facto standard iocharset=3D mount option like all other fs driver but
> instead has nls=3D mount option. This should be fixed.
Okay, I will fix it on the next version.
>
> Pali
Thank you for your review:)

