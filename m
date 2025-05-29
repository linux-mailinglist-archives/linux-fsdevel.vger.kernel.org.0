Return-Path: <linux-fsdevel+bounces-50109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F490AC83EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 00:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D541BC0C37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56521D3FB;
	Thu, 29 May 2025 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQOec9eJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E71AF0C8;
	Thu, 29 May 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748556803; cv=none; b=nUtP9lo/4vJspBDNqboqj2+fdNoZLCDkS4XR0u7Ra4LsMhs9S8lp/s0n50WFsS+GHCVT595kMVn78D21O0jeUUhOMpTVY/kAJcpf37+MorfrTh7cXhVK8cWs9BjcWiZpQUEpj8iC/FXnNmmhh6o0w1xot1GOslwTxN2nA+7WoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748556803; c=relaxed/simple;
	bh=xxY0mcJQ2sbFaJYuTeLbn9Sqey4KIEkshMfxBVexDuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOX3KM4AGXbrcg7gVEi+JtfgS5cBevdx/nrw33ur7ZDp3delvJziLlQ4er1ngKdlb4eBcARfvbSeJLvTksrJ32ujAVlg1nPLZMbwy/NgCTbHexQE8RpEtzkoyjjn6kiADrtxeqY+sPyO7/Ov60AaR8RnsIPKiZ3tGlI//3EETa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQOec9eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8D9C4AF0B;
	Thu, 29 May 2025 22:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748556802;
	bh=xxY0mcJQ2sbFaJYuTeLbn9Sqey4KIEkshMfxBVexDuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oQOec9eJ4w9Xuu+A5DX+SmBouTwXEqtwvVGPIEsvAQG6DcJKIxLx2+tUpNB4D6PEY
	 +qfUOnfwwcbtt91YZlx+GAytlQHKcnirzIoJo8bISebN3p0N8rc1uZp4oZv5qNqpJ5
	 hzhd4YBZGCOj5oGY1allWqh7NFiPITw8jQJYYuhzmj324DSAz0eGNqPU434/yI3LMU
	 Be3uAg44Vxglt8inR+iTBCyBNYM23T6U1fAquDtLO4qX+aRL3ti7JwPViIz4nCA/gW
	 8zJMwd4yYZS9n4cakhRA5GYPcW5rDKlFmDewTGOquETm01nwQVddJUkYyEoN3CNOPf
	 K+1by/PRzYEFA==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8a87f0c0fso16064456d6.0;
        Thu, 29 May 2025 15:13:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8WI/1eJWEgGeBigLjPdLPg0SBY/s+n9E9tg1ko/QZVqD0abhYr/pv/hQFDwS0p1RteW0V0StGVxAGa7Y+CFB0ST8LcqGr@vger.kernel.org, AJvYcCX+x9BIhOuGEMiGhfrQKlkxy+BREPeJd8qpyOLYusofQFQ8WvFTeHXLVbtB02px45BbQI8=@vger.kernel.org, AJvYcCXprOPteDQhS7YeT1QbwyTvf5BIClsiv/6Rv5PPNN2OLuz+g9qO6XJsNz4esxslccdmDnM9SvzFl3QDIHvC@vger.kernel.org, AJvYcCXqojrPSdvDLQQA5MFi576tRtxm1i84niN5dGLL4muR+DTNSdwjfl3YWBzKyDUWwil9Ze0pwde0LWJkwvFTyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPE9U7Pi1PFLOBRirXaH3xrBRK1ZXnMKSKc269pLIpW8XIZb+
	N3zRHy6XOWXNfNi3j+h4TtVOwgX8eEf9w95MomVUQ7cg19JEeybCDYZfybkjg31Q/KLtsk/grVm
	bQoRCwwrnHJdlWrWYPYgv9+BEkHKpe78=
X-Google-Smtp-Source: AGHT+IFx/Rjj8wl+fEhyYFTmqqdXX4WjcWL3/wlDqc+AASjZ1F3EAsg9AtbK9ryGntD2sTCwzeCHdjrKPS6FPhMFZs0=
X-Received: by 2002:a05:6214:1bc6:b0:6e8:fcde:58d5 with SMTP id
 6a1803df08f44-6faced53c8bmr22037216d6.42.1748556801752; Thu, 29 May 2025
 15:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-4-song@kernel.org> <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV> <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV> <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV> <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV>
In-Reply-To: <20250529214544.GO2023217@ZenIV>
From: Song Liu <song@kernel.org>
Date: Thu, 29 May 2025 15:13:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
X-Gm-Features: AX0GCFvMB_asX2tV9a__ZYbs1_lQ1ls4xkVuw40QAjFRQukLvmEVfndQdfivv8o
Message-ID: <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 2:45=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, May 29, 2025 at 02:07:31PM -0700, Song Liu wrote:
>
> > We have made it very clear what is needed now: an iterator that iterate=
s
> > towards the root. This has been discussed in LPC [1] and
> > LSF/MM/BPF [2].
> >
> > We don't know what might be needed in the future. That's why nothing
> > is shared. If the problem is that this code looks extendible, we sure c=
an
> > remove it for now. But we cannot promise there will never be use cases
> > that could benefit from a slightly different path iterator.
>
> For the record, "use cases that could benefit from X" !=3D "sufficient re=
ason
> to accept X".

Agreed.

>
> > Either way, if we
> > are adding/changing anything to the path iterator, you will always be
> > CC'ed. You are always welcome to NAK anything if there is real issue
> > with the code being developed.
>
> Umm...  What about walking into the mountpoint of MNT_LOCKED mount?
> That, BTW, is an example of non-trivial implications - at the moment
> you *can* check that in path->mnt->mnt_flags before walking rootwards
> and repeat the step if you walked into the parent.  Clumsy and easy
> to get wrong, but it's doable.

Is it an issue if we only hold a reference to a MNT_LOCKED mount for
short period of time? "Short period" means it may get interrupted, page
faults, or wait for an IO (read xattr), but it won't hold a reference to th=
e
mount and sleep indefinitely.

>
> OTOH, there's a good cause for moving some of the flags, MNT_LOCKED
> included, out of ->mnt_flags and into a separate field in struct mount.
> However, that would conflict with any code using that to deal with
> your iterator safely.
>
> What's more, AFAICS in case of a stack of mounts each covering the root
> of parent mount, you stop in each of those.  The trouble is, umount(2)
> propagation logics assumes that intermediate mounts can be pulled out of
> such stack without causing trouble.  For pathname resolution that is
> true; it goes through the entire stack atomically wrt that stuff.
> For your API that's not the case; somebody who has no idea about an
> intermediate mount being there might get caught on it while it's getting
> pulled from the stack.
>
> What exactly do you need around the mountpoint crossing?

I thought about skipping intermediate mounts (that are hidden by
other mounts). AFAICT, not skipping them will not cause any issue.
So I got the API to also show these mounts.

Thanks,
Song

