Return-Path: <linux-fsdevel+bounces-67990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C7C4FB07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 21:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F9BD4E98B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9CA33D6CE;
	Tue, 11 Nov 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1r2Y3/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8E33D6CB;
	Tue, 11 Nov 2025 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892351; cv=none; b=MfyPUfwfd0HBAnal0ezgGyhs7LVJTH5HqkqDNeTW7Ea8vhl3wYYHtn/C6G9VTxggo3RLpZlYN2QOzUFzBMF/ovBKTdLPXHJCWuxubX7Yl7bnrSO+SQ5ywXfb77FyuZDbdDVGaPibYL6gdT6kVWUKrojO/z9lVpd73rV/ZctOKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892351; c=relaxed/simple;
	bh=fu6s4/xojeZgX7aNEWJfig73AGlXvP+znZlBg9agON0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDHk+l0dyB5hqby9muCsA6DOy16m23etkAdWNczARJm1XNoMdhOQXH7EoiCTfkoKNKOkeRTB8fsq32UrZWtOuS/TGdyZEp7FN0P/bp4JMFRSNdg22rrVapJRlq67sWgB2Ef5Qpeq56+Y4jUU38ZEXRDJrV7pYQwLf4vfgSIOJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1r2Y3/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D978C16AAE;
	Tue, 11 Nov 2025 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762892351;
	bh=fu6s4/xojeZgX7aNEWJfig73AGlXvP+znZlBg9agON0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1r2Y3/eCL0Xa1MPNF0IPCxP2xdKudBp6EZ4cRQgfP4VdypOsH81FEZotsSfUiHgF
	 cxTKhhYY6VoiwxWk49M2q1Dd5X7DrOaUYN6CD31pg6hRhseCY9+7TPbwl+fE6WDY3J
	 31yszZrpQjppaORB+oPZZPM+0RE4xt4NeYgT4dYAT0rxBTI4o1+5oOfU6U6A4lRZ0g
	 a8AJUZGlBDEH/REX282Zj/V/0p3VxdI1WknGoEoxhbzATEVAhgaclM9Tv1CxfsmQUz
	 JaYcvB8j8Yuz9n5SbCpWwKnjk1cA3nIn+JhfYLvi3YqQ2SQ/CMl3wbK5nMn9PQC8tS
	 jBOR9zCSUendA==
Date: Tue, 11 Nov 2025 22:18:45 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v5 05/22] liveupdate: kho: when live update add KHO image
 during kexec load
Message-ID: <aROaJUjyyZqJ19Wo@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-6-pasha.tatashin@soleen.com>
 <aRHe3syRvOrCYC9u@kernel.org>
 <CA+CK2bA=cQkibx4dSxJQTVxVxqkAsZPfFoPJip6rx8DqX62aEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bA=cQkibx4dSxJQTVxVxqkAsZPfFoPJip6rx8DqX62aEA@mail.gmail.com>

On Mon, Nov 10, 2025 at 10:31:23AM -0500, Pasha Tatashin wrote:
> On Mon, Nov 10, 2025 at 7:47 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Nov 07, 2025 at 04:03:03PM -0500, Pasha Tatashin wrote:
> > > In case KHO is driven from within kernel via live update, finalize will
> > > always happen during reboot, so add the KHO image unconditionally.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  kernel/liveupdate/kexec_handover.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > > index 9f0913e101be..b54ca665e005 100644
> > > --- a/kernel/liveupdate/kexec_handover.c
> > > +++ b/kernel/liveupdate/kexec_handover.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/kexec_handover.h>
> > >  #include <linux/libfdt.h>
> > >  #include <linux/list.h>
> > > +#include <linux/liveupdate.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/page-isolation.h>
> > >  #include <linux/vmalloc.h>
> > > @@ -1489,7 +1490,7 @@ int kho_fill_kimage(struct kimage *image)
> > >       int err = 0;
> > >       struct kexec_buf scratch;
> > >
> > > -     if (!kho_out.finalized)
> > > +     if (!kho_out.finalized && !liveupdate_enabled())
> > >               return 0;
> >
> > This feels backwards, I don't think KHO should call liveupdate methods.
> 
> It is backward, but it is a requirement until KHO becomes stateless.
> LUO does not have dependencies on userspace state of when kexec is
> loaded. In fact the next kernel must be loaded before the brownout as
> it is an expensive operation. The sequence of events should:
> 
> 1. Load the next kernel in memory
> 2. Preserve resources via LUO
> 3. Do Kexec reboot

I believe that when my concerns about "[PATCH v5 02/22] liveupdate:
luo_core: integrate with KHO" [1] are resolved this patch won't be needed.

[1] https://lore.kernel.org/all/aROZi043lxtegqWE@kernel.org/
 
> Pasha

-- 
Sincerely yours,
Mike.

