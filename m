Return-Path: <linux-fsdevel+bounces-68787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31680C66320
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8C9335B12F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8E34C141;
	Mon, 17 Nov 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIbGksYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BB25BF18;
	Mon, 17 Nov 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413543; cv=none; b=HX8Ua0IeNa/czgfa6Ls2MO8Ny/jo9Ju/JC4LxoGjuDE+f8+G2T5JwfFWFLtwW+waD5DG5I/seeED+Mn62NDbN+BvpoaoFrPIxSCp+gH1p+ZE6SFs/p3a/F+1TlX+JRMywFGrQexppBs7oQK5fGd8nQS8tGWotjsMiJ+HM+MVbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413543; c=relaxed/simple;
	bh=vX0RgenvtHRJqNATnowFhh/xzwC45LGhd8zfOW/YcSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz3Xj9whaLOubtuRVBYKYzoBJpE6zfaScBABYib4Gp4aWxgglIQtlKtS7L4PlKLsmH811MPK2M0K+kUwzz85M1y/RUZyRWPHg9L2OleKoGW/Q56Tw6pYCfcdoVSFTfbVJOVJioHELK1ZPIPVuNEJWOYRTZPQ29Hi/meCiUO9bF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIbGksYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C9CC19421;
	Mon, 17 Nov 2025 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413543;
	bh=vX0RgenvtHRJqNATnowFhh/xzwC45LGhd8zfOW/YcSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIbGksYJvNHHKqcnEkxP8edGCkFvrR3zIlacYJ/GfH25Vv7qTIVyrFKH5sk31x0yZ
	 xei+n4/cKhC86cLFzgajOHFrRuzy9Cf4NfBHjUYYpp0CoA35nA6AulbEH6m9QsaiRP
	 j1DTCkXcSjm7izViODv57OuwLXGHry7hOOLvnIWve8ZFi70kPLjCwoPZn/T+iS3iMV
	 rB8SMgpHVZ70/BTPln3obMUZOvsm2vNDyY6atz57c34ZQGgRN69rzy70cjVuaXdMHV
	 Jz6kL5EugQncLiwGz7CwcyM4akaYfMZrA7Dh6fmt85JSxwEixmrs1XXvoRl3A8eWzO
	 2HUdgkejx4kxg==
Date: Mon, 17 Nov 2025 23:05:16 +0200
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
Message-ID: <aRuODFfqP-qsxa-j@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com>
 <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org>
 <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>

On Mon, Nov 17, 2025 at 01:29:47PM -0500, Pasha Tatashin wrote:
> On Sun, Nov 16, 2025 at 2:16 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sun, Nov 16, 2025 at 09:55:30AM -0500, Pasha Tatashin wrote:
> > > On Sun, Nov 16, 2025 at 7:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > > +static int __init liveupdate_early_init(void)
> > > > > +{
> > > > > +     int err;
> > > > > +
> > > > > +     err = luo_early_startup();
> > > > > +     if (err) {
> > > > > +             pr_err("The incoming tree failed to initialize properly [%pe], disabling live update\n",
> > > > > +                    ERR_PTR(err));
> > > >
> > > > How do we report this to the userspace?
> > > > I think the decision what to do in this case belongs there. Even if it's
> > > > down to choosing between plain kexec and full reboot, it's still a policy
> > > > that should be implemented in userspace.
> > >
> > > I agree that policy belongs in userspace, and that is how we designed
> > > it. In this specific failure case (ABI mismatch or corrupt FDT), the
> > > preserved state is unrecoverable by the kernel. We cannot parse the
> > > incoming data, so we cannot offer it to userspace.
> > >
> > > We report this state by not registering the /dev/liveupdate device.
> > > When the userspace agent attempts to initialize, it receives ENOENT.
> > > At that point, the agent exercises its policy:
> > >
> > > - Check dmesg for the specific error and report the failure to the
> > > fleet control plane.
> >
> > Hmm, this is not nice. I think we still should register /dev/liveupdate and
> > let userspace discover this error via /dev/liveupdate ABIs.
> 
> Not registering the device is the correct approach here for two reasons:
> 
> 1. This follows the standard Linux driver pattern. If a driver fails
> to initialize its underlying resources (hardware, firmware, or in this
> case, the incoming FDT), it does not register a character device.
> 2. Registering a "zombie" device that exists solely to return errors
> adds significant complexity. We would need to introduce a specific
> "broken" state to the state machine and add checks to IOCTLs to reject
> commands with a specific error code.

You can avoid that complexity if you register the device with a different
fops, but that's technicality.

Your point about treating the incoming FDT as an underlying resource that
failed to initialize makes sense, but nevertheless userspace needs a
reliable way to detect it and parsing dmesg is not something we should rely
on.

> Pasha

-- 
Sincerely yours,
Mike.

