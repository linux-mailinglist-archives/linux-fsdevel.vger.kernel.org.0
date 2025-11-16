Return-Path: <linux-fsdevel+bounces-68620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFCC61B9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 20:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29DCD4E4F9C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 19:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3926253939;
	Sun, 16 Nov 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuRRXeF9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120EC1991CB;
	Sun, 16 Nov 2025 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320592; cv=none; b=hm5ytrPtN7PwGhLHN+8eRaWmJcVWUtJkP2MHYrkzGlqERbpkyJMDXXnhK4aLhsYVsxi96KAlJ7bWnY5quWUw0j4ZsqZ8fPr1M21/3me2n9vaX82++eMJ71WQFvpYATS69I+S/yfnUycmdHVYcccT3eCZmnwSSwMPgy14FCqkPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320592; c=relaxed/simple;
	bh=2AWiSTOjjCImKxID+jJqasB/YHLkwC84gjIC/il/6NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA4uabyktWkxPPfMPi9t2rVLypMldhH9gkJu4MBQkAAgwy/kb+nNOOQY03zft9bYMz7bmR+lRYxNlRfEtr0ggNPkeohVEI4WnQ7wWdBz4O8Or1ucS+Lv5YzybeipyKZSCTRxmH6GHLTjw6O0OAT8dW59PHfNTaPCUV6yVp358p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuRRXeF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2A5C4CEF1;
	Sun, 16 Nov 2025 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763320591;
	bh=2AWiSTOjjCImKxID+jJqasB/YHLkwC84gjIC/il/6NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuRRXeF904tsvw3xJPns3FlZX+NotASwA1V6gZiqZ2bHO+P8u/xsR51KVjXrZJXqP
	 G7bib6qzdztDPLbkPoasGFTg3O4dua/5tQpc4gWVf1wk6p/OmAi9ifT0WNIUUR5bNf
	 2XX7A/8rtYbxfMu/72wq/3g9PIyusYihlSkZntAhXSDyHz1Ee/gC7odyz2qWMLnVE1
	 t9LO5wu9HVY5aqHtvmRSF10unM22VnrNZdbUvRcdH5lcjWI1LtLiXUX+Iu4Owu3jAg
	 kS5h/KkX1VqvtSmX9Xh6KckCByA07I3oqKnB/cewzRMOd1oEtoTfr70o2ZwcsGuYAW
	 QDEvmdptTN+OA==
Date: Sun, 16 Nov 2025 21:16:08 +0200
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
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
Message-ID: <aRoi-Pb8jnjaZp0X@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com>
 <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>

On Sun, Nov 16, 2025 at 09:55:30AM -0500, Pasha Tatashin wrote:
> On Sun, Nov 16, 2025 at 7:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > > +static int __init liveupdate_early_init(void)
> > > +{
> > > +     int err;
> > > +
> > > +     err = luo_early_startup();
> > > +     if (err) {
> > > +             pr_err("The incoming tree failed to initialize properly [%pe], disabling live update\n",
> > > +                    ERR_PTR(err));
> >
> > How do we report this to the userspace?
> > I think the decision what to do in this case belongs there. Even if it's
> > down to choosing between plain kexec and full reboot, it's still a policy
> > that should be implemented in userspace.
> 
> I agree that policy belongs in userspace, and that is how we designed
> it. In this specific failure case (ABI mismatch or corrupt FDT), the
> preserved state is unrecoverable by the kernel. We cannot parse the
> incoming data, so we cannot offer it to userspace.
> 
> We report this state by not registering the /dev/liveupdate device.
> When the userspace agent attempts to initialize, it receives ENOENT.
> At that point, the agent exercises its policy:
> 
> - Check dmesg for the specific error and report the failure to the
> fleet control plane.

Hmm, this is not nice. I think we still should register /dev/liveupdate and
let userspace discover this error via /dev/liveupdate ABIs.

> - Trigger a fresh (kexec or cold) reboot to reset unreclaimable resources.
> 
> Pasha
> 

-- 
Sincerely yours,
Mike.

