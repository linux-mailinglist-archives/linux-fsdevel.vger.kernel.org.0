Return-Path: <linux-fsdevel+bounces-53764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2EAF6951
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 07:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A113B94D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 05:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270728EA62;
	Thu,  3 Jul 2025 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJR6vGz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D82DE6FC;
	Thu,  3 Jul 2025 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519098; cv=none; b=G4fwl3zGTJaT6JqTn6Ply8+FOBtQZO4cXJYVKxgBVslar4L4Rfgfa0Kk37eISG0iuqpSBO3NHXHhU5ZRvBN8hRsGpF3K+kFZRgvODvNQUHjzKr/m1WjCABZkHydjfbxD5ZeTILdh9agIsQwdUs1PmiHu5w3ujt0BppSflEj7vgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519098; c=relaxed/simple;
	bh=7Y52CS4Sendh9bM4VJVMhnz0UCov0PgAIUIVYcJ32BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2DuVYyXpj8F9wVcf2Ml1y/Cbku1qQ9DWS6EQkOsTFDLAEwiETHgQbQtd2TASSOFSn2jKh6kFhTgL8+pPyp1WRcRNz9dZdX03UMMXbICRPo69Veypkxgao1BSKTNtjuHoOEJr5mAioWsgvB3JTEVIoLf9eXwiBEF8sqrsP3vh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJR6vGz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F13CC4CEE3;
	Thu,  3 Jul 2025 05:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751519098;
	bh=7Y52CS4Sendh9bM4VJVMhnz0UCov0PgAIUIVYcJ32BI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AJR6vGz7kEpMb2l+dQl1iyWFZ2eHeSJcRvXCVES22QhnvFBDsDf0zUUhQDwpvM5i8
	 XRn7xU/Thx4d1CgHtl0UjvRmyVUEH3SF8mWEeNkzkrR4nul9LQcgjDc/Inec1U1NGj
	 QB21/iH/40ODBihxHMoo5DCNIVksZdsVVowAbxmZA8iurbp2t2dor0gOfyM66nwLpD
	 jUws3juXFUkiLQCaQAhD8y1mFq6Sp8/gjRnLmyprFlY70gMfOT4ljqvgKS79mbQuU6
	 DZHZH1S68AwDgCZI/xhKN9ncuGeGWhSB3u7deLGt4Esf6TzA5TpQ6TuKPES1qPoNIc
	 Yt7XdOzbQr+7g==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f0bcdf45so65204491cf.0;
        Wed, 02 Jul 2025 22:04:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDlQ25Gib/TQga1JE844AsNlCxC4pRh4bliDE+uUCSquefZpkcuAXwFLWoN6h0cBJ79xBgT+bOt8nmSYQLHs0UzkkmVxqX@vger.kernel.org, AJvYcCV6jTyhPsso/so91hqNXS/qCUsT2g+k2A8rbvd4O5dUj98MQ8cUAK2TKVXxcYBQp2CuXX9dZkzqD/NlCQ8g@vger.kernel.org, AJvYcCVWjf6fiNnaAVYWP2atFDm9qyH9fSoLzw4wEAZCgcFPq6HuV+x4kp2XT5KzHYIyaMaIAFTdbAE9mGRQwy7J@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYYcO6tiN2Kw33ax61K9QhDQNtdLvBvXmp5i4gA/Q4GL7D0+V
	XlWWMnCz5rNSxfM0g0z9s8SaNYMPcHwpzF5b1vgp6APeo88Xn1HuVQ6ZpKRRM7Dk3TFzk2Y0sgn
	mUZdyzr8tbtYlSt91rMb8SEYZl/KrsZA=
X-Google-Smtp-Source: AGHT+IHchTb2tT5cDJShXd/0VF6AyMX97c9t70vPAkrlFvFZ8cTiloHlW0K7A6g2Bm/75obbRCoiyLOwZCkSvmeCIFA=
X-Received: by 2002:a05:622a:5a0d:b0:4a4:2ffb:5482 with SMTP id
 d75a77b69052e-4a987a43c68mr38617851cf.38.1751519097321; Wed, 02 Jul 2025
 22:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617061116.3681325-1-song@kernel.org> <CAPhsuW5uu8cOYJWJ3Gne+ixpiWVAby1hZOnUgsXcFASEhV4Xhg@mail.gmail.com>
 <20250624.xahShi0iCh7t@digikod.net>
In-Reply-To: <20250624.xahShi0iCh7t@digikod.net>
From: Song Liu <song@kernel.org>
Date: Wed, 2 Jul 2025 22:04:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7EyTTh-qkrA86ERfSUUJK0o1Jz1UKH+o6rMY1-QioJRA@mail.gmail.com>
X-Gm-Features: Ac12FXx3mCaq13l3a5Zpqb-icNQ9vwHconECRRuC3pcVzdEwJmFf6y41opiBE94
Message-ID: <CAPhsuW7EyTTh-qkrA86ERfSUUJK0o1Jz1UKH+o6rMY1-QioJRA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, m@maowtm.org, 
	neil@brown.name, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Jun 24, 2025 at 11:46=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> On Fri, Jun 20, 2025 at 02:59:17PM -0700, Song Liu wrote:
> > Hi Christian, Micka=C3=ABl, and folks,
> >
> > Could you please share your comments on this version? Does this
> > look sane?
>
> This looks good to me but we need to know what is the acceptable next
> step to support RCU.  If we can go with another _rcu helper, I'm good
> with the current approach, otherwise we need to figure out a way to
> leverage the current helper to make it compatible with callers being in
> a RCU read-side critical section while leveraging safe path walk (i.e.
> several calls to path_walk_parent).

Could you please share your suggestions on this topic? RCU
protected path walk out of fs/ seems controversial in multiple
ways. Do we have to let this set wait indefinitely for a solution
of RCU protected path walk? I would like to highlight that this
set doesn't add any persistent APIs. path_walk_parent() is not
in the UAPI, nor exported. If a newer and better API is created,
we can refactor bpf and landlock code and deprecate
path_walk_parent().

Thanks,
Song

