Return-Path: <linux-fsdevel+bounces-69515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDCCC7E1DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69743AC04D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5DA2D838C;
	Sun, 23 Nov 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbj1LkgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD72D7D3A;
	Sun, 23 Nov 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763907606; cv=none; b=IImqneco6G7+1DzSUOeWnfEsiwHl5N67KzqXWo6vONpgVffXXE6bj1orhTZ72/sTwB9ee+iA1czsz2x/eakIskiyBCAWZV1Vd4X89K+NeXlbllG4OAgX/4pm62hffEcKbYH+/v3cNxynM00oFMSUJoMOHbddZ5KCFoUcde/HjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763907606; c=relaxed/simple;
	bh=64qKRjSfixLK9vi0MfPfl4EUkAb/R9lG3NziOFUwlpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwGcK1w8JQNW9mw++8NnVPUN7+xRfR/bnBfaLxCDiAiTdj55ps3xfDibRE/HL0oycXcVs2Zng1TM1lO3G3Ltw5myWJZbxOOzfOM71rePNo+TZafehjGBsC4jCtkHKwQ3Rxd3dUvy3bns0kxRJVSW+nj2b2XAA3mPyaozFm6sHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbj1LkgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6C9C19421;
	Sun, 23 Nov 2025 14:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763907606;
	bh=64qKRjSfixLK9vi0MfPfl4EUkAb/R9lG3NziOFUwlpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbj1LkgM3jpINAAlPHZASq9E3rN1aUM0DEUqlztUnBTcbaIhVD5eucAidAB4gfABc
	 Ib/eR9Q8tzeGw6sDgEvkL2B2/zkTWfjhmqk+7ZyH68Xbb1DS+tynJuS9mqdEBbbf4v
	 av9ekCTiogcXBDCTmLSZPjlqmBa4qJFxmIprQYnor2Dfd/5TFyU9KRunnRPopVmGeG
	 gpb1oBc8XkSK+NB6gJ+nJP8Gdawd4HCTlf+VbyUAsMpmj9ASWyh46Zc3etlr+NodPZ
	 l0wLWZ7K50Y+YCRxWSjcr3VMVTEDGNMIUiWFXJGScmfzRyWPEnqc1rEJTmIEt++v8u
	 nNVmbuEVxqR+A==
Date: Sun, 23 Nov 2025 16:19:42 +0200
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
Subject: Re: [PATCH v7 05/22] liveupdate: luo_core: add user interface
Message-ID: <aSMX_pnUShilO_sj@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-6-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-6-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:32PM -0500, Pasha Tatashin wrote:
> Introduce the user-space interface for the Live Update Orchestrator
> via ioctl commands, enabling external control over the live update
> process and management of preserved resources.
> 
> The idea is that there is going to be a single userspace agent driving
> the live update, therefore, only a single process can ever hold this
> device opened at a time.
> 
> The following ioctl commands are introduced:
> 
> LIVEUPDATE_IOCTL_CREATE_SESSION
> Provides a way for userspace to create a named session for grouping file
> descriptors that need to be preserved. It returns a new file descriptor
> representing the session.
> 
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION
> Allows the userspace agent in the new kernel to reclaim a preserved
> session by its name, receiving a new file descriptor to manage the
> restored resources.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/uapi/linux/liveupdate.h  |  64 +++++++++++
>  kernel/liveupdate/luo_core.c     | 179 ++++++++++++++++++++++++++++++-
>  kernel/liveupdate/luo_internal.h |  21 ++++
>  3 files changed, 263 insertions(+), 1 deletion(-)

-- 
Sincerely yours,
Mike.

