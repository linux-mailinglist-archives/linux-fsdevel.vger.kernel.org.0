Return-Path: <linux-fsdevel+bounces-63500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81262BBE59E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101183B107B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30142D5C91;
	Mon,  6 Oct 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyayRvWM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FB137923;
	Mon,  6 Oct 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761023; cv=none; b=fUUEoDFWjMph29akdWy3MDQulSxRraPXcvHWwSdRt7nHj1QgygO+fgrTvfSEmGMyJlYjWUw5NSOLtxBhk+M9xkoylJv+mrjQmVIudcLMtcTw+XBNzPAVnMmXx01xkgRGse1U3aOfpYbVxpTD0J8CSwJhmPijkaDFdG498YS2t/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761023; c=relaxed/simple;
	bh=Z0Xk1zutYNK5fdV7Q90ItmYTFXFrXh0MnKPjPEQpcec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3OKUAqKLoJGjxlTIe4Zykw2vf9sIGyqTigTcXzQS6gxsdBif2WKIafm/sWL/GXZo/mbUzwAMM7Jxksxn+fNTpWbj/SCyr8Fi7G6wKEIlXePsoi0yuYCCZgkX0gXzRu3IY22ayf/pqq3fOTcVdOtu+KKMs07cwbBGW+WkzE3UMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyayRvWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E25C4CEF5;
	Mon,  6 Oct 2025 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759761022;
	bh=Z0Xk1zutYNK5fdV7Q90ItmYTFXFrXh0MnKPjPEQpcec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CyayRvWM7fCrhPL8SVjOSeWTov06Ps1dORhh0sl9klxAwOkyK7ONJ6lZE2eVvrvFl
	 mgInnab3z3wKW99UU9pD8ZuQf2Bw0/9ib8mfYNQzjTW3DmCxEx1RFB6nGo4lOu7CzF
	 hMtJn3RZ+OrtUP8mFaUi86/tZi35QjBlQuR8RYrgWneX3WVmBbg7jndHayNovJMUuC
	 uWpOU/jICq82izj2NxgEyPAjvZkgJ46SG/GvvA3u4cxkkQStzdUHi0wkPwMa6lcX/i
	 BRde4WsDzdeDSTTrafTTHcRA7U22BRlDcJusZ5J9SnjMbh+SfAH3bGkkt4WKFEKf5i
	 HSZ5diknL9v6g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org,
  steven.sistare@oracle.com
Subject: Re: [PATCH v4 03/30] kho: drop notifiers
In-Reply-To: <20250929010321.3462457-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 29 Sep 2025 01:02:54 +0000")
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
	<20250929010321.3462457-4-pasha.tatashin@soleen.com>
Date: Mon, 06 Oct 2025 16:30:12 +0200
Message-ID: <mafs0bjmkp0gb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pasha,

On Mon, Sep 29 2025, Pasha Tatashin wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> The KHO framework uses a notifier chain as the mechanism for clients to
> participate in the finalization process. While this works for a single,
> central state machine, it is too restrictive for kernel-internal
> components like pstore/reserve_mem or IMA. These components need a
> simpler, direct way to register their state for preservation (e.g.,
> during their initcall) without being part of a complex,
> shutdown-time notifier sequence. The notifier model forces all
> participants into a single finalization flow and makes direct
> preservation from an arbitrary context difficult.
> This patch refactors the client participation model by removing the
> notifier chain and introducing a direct API for managing FDT subtrees.
>
> The core kho_finalize() and kho_abort() state machine remains, but
> clients now register their data with KHO beforehand.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

This patch breaks build of test_kho.c (under CONFIG_TEST_KEXEC_HANDOVER):

	lib/test_kho.c:49:14: error: =E2=80=98KEXEC_KHO_ABORT=E2=80=99 undeclared =
(first use in this function)
	   49 |         case KEXEC_KHO_ABORT:
	      |              ^~~~~~~~~~~~~~~
	[...]
	lib/test_kho.c:51:14: error: =E2=80=98KEXEC_KHO_FINALIZE=E2=80=99 undeclar=
ed (first use in this function)
	   51 |         case KEXEC_KHO_FINALIZE:
	      |              ^~~~~~~~~~~~~~~~~~
	[...]

I think you need to update it as well to drop notifier usage.

[...]

--=20
Regards,
Pratyush Yadav

