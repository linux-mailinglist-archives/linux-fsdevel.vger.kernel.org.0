Return-Path: <linux-fsdevel+bounces-69792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3AC85207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045A43ABBBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12693233F4;
	Tue, 25 Nov 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4XhmBKV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB23320CC3;
	Tue, 25 Nov 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076123; cv=none; b=MVe/ZwjHsxRB49y6dGhFo7uU1Qnkp9b1vDWza3fj+nJu+F2QRnn1J5r5tGlxs8I738hwe+z/IMlP9PZO7RziNXoVj7+E9LZUoiwiJ6RcF+ZIK8XC0fF+s1kQRP0wCjeRXGaBSpOKjIJrqmX2ymo8vZ+M6lniuOfLuHfAvo5PcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076123; c=relaxed/simple;
	bh=dHFz6qR/I9ZFBforH40m7KtLMQ9NhVkinfXAsC6xU+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElNpVTHoxU5DCSdLxk7D1U/oBYO2FuhrqR791FM+N8/PizlCna5ZZEYrRQFt0K/tcOQb84eZSFxAtuRHPZwir4gTzeEVp24WE5ZQUrstoDKBpitqe3Tkp17ahr/E/3J0Ra5yTQ7oz5nA45d0+64fw2zsw7WueuOyw0htK+c+z7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4XhmBKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D386C4CEF1;
	Tue, 25 Nov 2025 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764076122;
	bh=dHFz6qR/I9ZFBforH40m7KtLMQ9NhVkinfXAsC6xU+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4XhmBKVuKkpuROmmK4pPwB4aDpmhsMmOBJu0LOA/wCbUltTpWw7lpfRbgXtkVoNK
	 id3bIy5xKOEFBIjmgEe1kTkRjxKMmiSGyf3rMaCLyRMTpTcAdCbogdS5qEflK5wDng
	 1wlg18Sz2+kvbgjdsfqXEa0bM2ewgVoK3lwH5++i1nTQNlXSpPCMtrTbAYhFzvEdpg
	 kUcWpe8KPiPktz3FzquYixQAHYMtN5A8B8O7sX3mC9jOBWm4vnIpt8UgASmK2MGA/h
	 Pod7dUxXsiKWhPvykeECGahNqYUv1GLFELSQV0UJlqclrmAzKqsR/VCIrBpv2WJ5hh
	 EiEs8aqGz5BLw==
Date: Tue, 25 Nov 2025 15:08:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v7 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aSWqQWbeijvruDqf@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-3-pasha.tatashin@soleen.com>
 <aSLvo0uXLOaE2JW6@kernel.org>
 <CA+CK2bCj2OAQjM-0rD+DP0t4v71j70A=HHdQ212ASxX=xoREXw@mail.gmail.com>
 <aSMXUKMhroThYrlU@kernel.org>
 <CA+CK2bABbDYfu8r4xG3n30HY4cKFe74_RJP5nYJeOtAOOj+OUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bABbDYfu8r4xG3n30HY4cKFe74_RJP5nYJeOtAOOj+OUQ@mail.gmail.com>

On Sun, Nov 23, 2025 at 01:23:51PM -0500, Pasha Tatashin wrote:
> On Sun, Nov 23, 2025 at 9:17 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > +static int __init liveupdate_early_init(void)
> > > > > +{
> > > > > +     int err;
> > > > > +
> > > > > +     err = luo_early_startup();
> > > > > +     if (err) {
> > > > > +             luo_global.enabled = false;
> > > > > +             luo_restore_fail("The incoming tree failed to initialize properly [%pe], disabling live update\n",
> > > > > +                              ERR_PTR(err));
> > > >
> > > > What's wrong with a plain panic()?
> > >
> > > Jason suggested using the luo_restore_fail() function instead of
> > > inserting panic() right in code somewhere in LUOv3 or earlier. It
> > > helps avoid sprinkling panics in different places, and also in case if
> > > we add the maintenance mode that we have discussed in LUOv6, we could
> > > update this function as a place where that mode would be switched on.
> >
> > I'd agree if we were to have a bunch of panic()s sprinkled in the code.
> > With a single one it's easier to parse panic() than lookup what
> > luo_restore_fail() means.
> 
> The issue is that removing luo_restore_fail() removes the only
> dependency on luo_internal.h in this patch. This would require me to
> move the introduction of that header file to a later patch in the
> series, which is difficult to handle via a simple fix-up.
> 
> Additionally, I still believe the abstraction is cleaner for future
> extensibility (like the maintenance mode), even if it currently wraps
> a single panic (which is actually a good thing, I have cleaned-up
> things substantially to have  a single point  of panic since v2).
> Therefore, it is my preference to keep it as is, unless a full series
> is needed to be re-sent.

Well, let's keep it. If we won't see new users or extensions to
luo_restore_fail() we can kill it later.
 
> Pasha

-- 
Sincerely yours,
Mike.

