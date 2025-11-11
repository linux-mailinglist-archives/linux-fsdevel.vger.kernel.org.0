Return-Path: <linux-fsdevel+bounces-67989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2FDC4FADA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 21:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37661896D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AB3A9BF9;
	Tue, 11 Nov 2025 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjJixwN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA61E492A;
	Tue, 11 Nov 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892198; cv=none; b=Z4fSz0xwYUv4Zy1JtcGSc827RVbqFYUF+6UnOwWNrra6xBUZaISQ6fWKM9fV2LdsgZ2z4oxH80Z0Jwy2iHCH+osnJtLOFDZX9+f+BkI+pwg+drIeFDfPRfLa7vufAZ+c7CBmVxLDIjaQxU7nveL9uww6kuBRLHEZXMUfDeHH250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892198; c=relaxed/simple;
	bh=kr44aeOaJcNZMsy/DaB9H7WStxetNlT6LAhP4sVEKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNn/jfWS5ZTaG2S4j5wODNWT7RoPsBbzPcEEG14hlN2XbICtisOp6QJDKLiz0xPMlLvb1ljWivAGQmV0OpCQz2xY45I24Zt3lXs2AoFI1EkkRdcSrHi4zD7+Bvk0IOU67Dk9s0WhiNfn+jsqAIKqEvrsk4g+J75LKRvhXTZFM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjJixwN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ABBC19422;
	Tue, 11 Nov 2025 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762892197;
	bh=kr44aeOaJcNZMsy/DaB9H7WStxetNlT6LAhP4sVEKyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjJixwN8jecm/9/GvO0cxbi0cA4i0/F3OOFxCavC3pfVCzcrM6xh13VhMpEBg5kpe
	 qiuJAxt2cyCU/0jERoj6B2P9NqwUAMGgXsf7vX3BaapxNU9Vr4rDdIXx0ZMToDMRC+
	 q2B4ACkjZ//xGa696u6Zxm90CDPdm5CozrFKbJAo5eWCnByKEUZSENG6DlQbwRdLFL
	 VYu3N7OdenMS80rJSV3omvMaWHhbGIxbTglpinTKoiVm3YmrXRExxzWiYeKgIkDpUh
	 gL91xa/fbHmGSAD2ArgPXjtdFar+4b+qMpwAz4qR8lMZv7Vl6EXq4/E0VDCh/a2DxC
	 UO2ZuVGEXjSWg==
Date: Tue, 11 Nov 2025 22:16:11 +0200
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
Message-ID: <aROZi043lxtegqWE@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com>
 <aRHiCxoJnEGmj17q@kernel.org>
 <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com>

On Mon, Nov 10, 2025 at 10:43:43AM -0500, Pasha Tatashin wrote:
> >
> > kho_finalize() should be really called from kernel_kexec().
> >
> > We avoided it because of the concern that memory allocations that late in
> > reboot could be an issue. But I looked at hibernate() and it does
> > allocations on reboot->hibernate path, so adding kho_finalize() as the
> > first step of kernel_kexec() seems fine.
> 
> This isn't a regular reboot; it's a live update. The
> liveupdate_reboot() is designed to be reversible and allows us to
> return an error, undoing the freeze() operations via unfreeze() in
> case of failure.
> 
> This is why this call is placed first in reboot(), before any
> irreversible reboot notifiers or shutdown callbacks are performed. If
> an allocation problem occurs in KHO, the error is simply reported back
> to userspace, and the live update update is safely aborted.

This is fine. But what I don't like is that we can't use kho without
liveupdate. We are making debugfs optional, we have a way to call
kho_finalize() on the reboot path and it does not seem an issue to do it
even without liveupdate. But then we force kho_finalize() into
liveupdate_reboot() allowing weird configurations where kho is there but
it's unusable.

What I'd like to see is that we can finalize KHO on kexec reboot path even
when liveupdate is not compiled and until then the patch that makes KHO
debugfs optional should not go further IMO.

Another thing I didn't check in this series yet is how finalization driven
from debugfs interacts with liveupdate internal handling?
 
> > And if we prioritize stateless memory tracking in KHO, it won't be a
> > concern at all.
> 
> We are prioritizing stateless KHO work ;-) +Jason Miu
> Once KHO is stateless, the kho_finalize() is going to be removed.

There's still fdt_finish(), but it can't fail in practice. 

-- 
Sincerely yours,
Mike.

