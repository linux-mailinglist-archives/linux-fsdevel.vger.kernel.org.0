Return-Path: <linux-fsdevel+bounces-68292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2344C591EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0443F5614FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31253587C6;
	Thu, 13 Nov 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrGC9Z1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB1340A79;
	Thu, 13 Nov 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051543; cv=none; b=VAaNYfwilOneNi4K9QS/BoP8kZPZKNtpoxIPEsX5KYUqheS/gnCI9T6bWJXqHlf8CMMsDbs9/XhfBS1TRHAKC1s2rMRvqdbtvjrm18oDQL0mIa70UfC24Y64/oAz2va3QVXlkZO9vqVP00bKiT+tW3CS/NZvpTHHImCvMPwfXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051543; c=relaxed/simple;
	bh=48cU/r2mCuhBi2o3QbLq7X+wCorzdfK7kjE/pbyUoys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzwWJ5DEPbUs1jnz9I6UJ0rb8FSffGq+po83UanJndQ+ZIZZZapR/y5c5lrIYRJKfxELfkvy9TbKPiHcjg0QvSjsjvq8+AARU4CP6l6HPpsou1lgNjJ0dBPl3jP8bXJqmIsUTekyAbQ6fAGtozAY0LMfIHEnamQaMew8+iT6bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrGC9Z1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B42EC4CEF1;
	Thu, 13 Nov 2025 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051542;
	bh=48cU/r2mCuhBi2o3QbLq7X+wCorzdfK7kjE/pbyUoys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrGC9Z1HvTGjTjRL3xw+mZ4VRxFvPWujkCi0vHliqnjQPxgDj5Iq1rshZmt6ySeMc
	 HGMSMKVh9VgMIzXnB8CNP7DemQTXKeUC8H36kD7XXCJ8kj8oUOWtKFtV5JfCVlNMUH
	 vV2Wz9lpEeXMW2vqdMbjTqxar0BcgazuH6zXzm6BsqIwtOVpVA7LeQFXB8qnOtRmO6
	 ydVLEDH5JNfCnMadYTtk2Srvhd9ymPG9C691mZ4GV2PRr0Iwvc9aecAiVDEwcWPZYX
	 IzqR46Q59HdXyVhnv/UTfIsTjQPSNCKfiaL+IDedKXACddxrDzR6Q4dn3sl1d1gn/I
	 R2sYn55yOR5pQ==
Date: Thu, 13 Nov 2025 18:31:57 +0200
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
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aRYH_Ugp1IiUQdlM@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com>
 <aRHiCxoJnEGmj17q@kernel.org>
 <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com>
 <aROZi043lxtegqWE@kernel.org>
 <CA+CK2bAsrEqpt9d3s0KXpjcO9WPTJjymdwtiiyWVS6uq5KKNgA@mail.gmail.com>
 <aRSKrxfAb_GG_2Mw@kernel.org>
 <CA+CK2bAq-0Vz4jSRWnb_ut9AqG3RcH67JQj76GhoH0BaspWs2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAq-0Vz4jSRWnb_ut9AqG3RcH67JQj76GhoH0BaspWs2A@mail.gmail.com>

On Wed, Nov 12, 2025 at 09:58:27AM -0500, Pasha Tatashin wrote:
> On Wed, Nov 12, 2025 at 8:25 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Pasha,
> >
> > On Tue, Nov 11, 2025 at 03:57:39PM -0500, Pasha Tatashin wrote:
> > > Hi Mike,
> > >
> > > Thank you for review, my comments below:
> > >
> > > > > This is why this call is placed first in reboot(), before any
> > > > > irreversible reboot notifiers or shutdown callbacks are performed. If
> > > > > an allocation problem occurs in KHO, the error is simply reported back
> > > > > to userspace, and the live update update is safely aborted.
> >
> > The call to liveupdate_reboot() is just before kernel_kexec(). Why we don't
> > move it there?
> 
> Yes, I can move that call into kernel_kexec().
> 
> > And all the liveupdate_reboot() does if kho_finalize() fails it's massaging
> > the error value before returning it to userspace. Why kernel_kexec() can't
> > do the same?
> 
> We could do that. It would look something like this:
> 
> if (liveupdate_enabled())
>    kho_finalize();
> 
> Because we want to do kho_finalize() from kernel_kexec only when we do
> live update.
> 
> > > > This is fine. But what I don't like is that we can't use kho without
> > > > liveupdate. We are making debugfs optional, we have a way to call
> 
> This is exactly the fix I proposed:
> 
> 1. When live-update is enabled, always disable "finalize" debugfs API.
> 2. When live-update is disabled, always enable "finalize" debugfs API.

I don't mind the concept, what I do mind is sprinkling liveupdate_enabled()
in KHO.

How about we kill debugfs/kho/out/abort and make kho_finalize() overwrite
an existing FDT if there was any? 

Abort was required to allow rollback for subsystems that had kho notifiers,
but now notifiers are gone and kho_abort() only frees the memory
serialization data. I don't see an issue with kho_finalize() from debugfs
being a tad slower because of a call to kho_abort() and the liveupdate path
anyway won't incur that penalty.

> > KHO should not call into liveupdate. That's layering violation.
> > And "stateless KHO" does not really make it stateless, it only removes the
> > memory serialization from kho_finalize(), but it's still required to pack
> > the FDT.
> 
> This touches on a point I've raised in the KHO sync meetings: to be
> effective, the "stateless KHO" work must also make subtree add/remove
> stateless. There should not be a separate "finalize" state just to
> finish the FDT. The KHO FDT is tiny (only one page), and there are
> only a handful of subtrees. Adding and removing subtrees is cheap; we
> should be able to open FDT, modify it, and finish FDT on every
> operation. There's no need for a special finalization state at kexec
> time. KHO should be totally stateless.

And as the first step we can drop 'if (!kho_out.finalized)' from
kho_fill_kimage(). We might need to massage the check for valid FDT in
kho_populate() to avoid unnecessary noise, but largely there's no issue
with always passing KHO data in kimage.
 
> Thanks,
> Pasha

-- 
Sincerely yours,
Mike.

