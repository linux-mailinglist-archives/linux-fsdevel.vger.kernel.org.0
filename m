Return-Path: <linux-fsdevel+bounces-69256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA7C75B1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5850234B602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD724377EAC;
	Thu, 20 Nov 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sap5ecG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6D334C27;
	Thu, 20 Nov 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659249; cv=none; b=qR8++v9h50IWFptlQGTaQfrXYn7oh+QtiIZkGjcx/sKuxiDokWZqllwGwTmEid2IRA2BzUdlR1m+P+SrLk8SRLdqe++sJKpPPyc/fO9YSfks9S5EnHYcSzyKINJEmgyM5SVl4PLIslRiWoQNCqS8dyH6blJtS83bTHVqlCxcvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659249; c=relaxed/simple;
	bh=fD6KjoGzF7YWD+p5+muskUl3aspahvddrqQqiF5E0oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIsntqcRgIlbS+G6ClOhGGqKajVbU+E+jXuuWRZPMJMNH1ypAfAaA0fZMBrBv/04SNACp3d733zSzCxt4boeH/Z8rWMLccy+dTkcPhG3wcvYDYUAnE2oll6XnNu8TSx4+8FRLjLD7GmfjO5kpod75dhQ2/b/CaWQYKxoZtutnSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sap5ecG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B32C4CEF1;
	Thu, 20 Nov 2025 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763659246;
	bh=fD6KjoGzF7YWD+p5+muskUl3aspahvddrqQqiF5E0oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sap5ecG9LGJ8wpTAYDVKAIMrPJKlHSE68WffXz2yNvUZnXdIBn7l8lIGbnotMc9qc
	 4UvFnri9+3qxNKGHl1DKfj1kfzW8tWjCrq0Wav7skSZi671Y+Xf3BWLH2EFS6gHBXG
	 uUEEe+2Dwp3dW/x64f0jRgjdsbxlTY8DsC3kGsqTj3QqbdbduJse9G9Z7WSNL0FsbB
	 asf3PkIfJ9IBdOPz2qY0QGN/6cAH7zMJK4iiliG2tCWB3F2jLmuZ8MrGZSMjJPqcmJ
	 YC8Sp0VH+4R5da77Tmu8lT9QmYW4efCZoC+vDVYT9qDRZBb1/fTjzStTuXldlhqgnJ
	 gMvfzGioMt3RA==
Date: Thu, 20 Nov 2025 19:20:23 +0200
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
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems
 callbacks
Message-ID: <aR9N14KWaz6SdFcw@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com>
 <aRoU1DSgVmplHr3E@kernel.org>
 <CA+CK2bBFS754hdPfNAkMp_PqNpOB2nY02OkWbhRdoUiZ+ah=jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBFS754hdPfNAkMp_PqNpOB2nY02OkWbhRdoUiZ+ah=jw@mail.gmail.com>

On Mon, Nov 17, 2025 at 12:50:56PM -0500, Pasha Tatashin wrote:
> > > +struct liveupdate_file_handler;
> > > +struct liveupdate_session;
> >
> > Why struct liveupdate_session is a part of public LUO API?
> 
> It is an obscure version of private "struct luo_session", in order to
> give subsystem access to:
> liveupdate_get_file_incoming(s, token, filep)
> liveupdate_get_token_outgoing(s, file, tokenp)
> 
> For example, if your FD depends on another FD within a session, you
> can check if another FD is already preserved via
> liveupdate_get_token_outgoing(), and during retrieval time you can
> retrieve the "struct file" for your dependency.
 
And it's essentially unused right now.

> > > +     }
> > > +
> > > +     return 0;
> > > +
> > > +exit_err:
> > > +     fput(file);
> > > +     luo_session_free_files_mem(session);
> >
> > The error handling in this function is a mess. Pasha, please, please, use
> > goto consistently.
> 
> How is this a mess? There is a single exit_err destination, no
> exception, no early returns except at the very top of the function
> where we do early returns before fget() which makes total sense.
> 
> Do you want to add a separate destination for
> luo_session_free_files_mem() ? But that is not necessary, in many
> places it is considered totally reasonable for free(NULL) to work
> correctly...

You have a mix of releasing resources with goto or inside if (err).
And while basic free() primitives like kfree() and vfree() work correctly
with NULL as a parameter, luo_session_free_files_mem() is already not a
basic primitive and it may grow with a time. It already has two conditions
that essentially prevent anything from freeing and this will grow with the
time.

So yes, I want a separate goto destination for freeing each resource and a
goto for 

	err = fh->ops->preserve(&args);
	if (err)

case.

> > > +             luo_file = kzalloc(sizeof(*luo_file), GFP_KERNEL);
> > > +             if (!luo_file)
> > > +                     return -ENOMEM;
> >
> > Shouldn't we free files allocated on the previous iterations?
> 
> No, for the same reason explained in luo_session.c :-)

A comment here as well please :)

> > > +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
> > > +                              struct file **filep)
> > > +{
> >
> > Ditto.
> 
> These two functions are part of the public API allowing dependency
> tracking for vfio->iommu->memfd during preservation.

So like with FLB, until we get actual users for them they are dead code. 
And until it's clear how exactly dependency tracking for vfio->iommu->memfd
will work, we won't know if this API is useful at all or we'll need
something else in the end.

-- 
Sincerely yours,
Mike.

