Return-Path: <linux-fsdevel+bounces-69694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD4C8148B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 290524E5F0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7F313E0B;
	Mon, 24 Nov 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2liEfUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE47313548;
	Mon, 24 Nov 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997524; cv=none; b=Zo3wQH54XJmiuBJida+5kY1N7VObRFtxSYBD1IUa6bJehwzqdFkq8Nk4KpG1RXrdaBTTmaxem14ka2U0aQNY6+AZXoJI7WMSXXguJXJrgdTxacY5UZMgYL5uFf+DopGTzyroladS+CrU1EjT5fqEZJMbg1XNINqMvvagXzExTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997524; c=relaxed/simple;
	bh=vdaVyZMAiIluQBulvS0o8xmpluVa2GUlqU3Na3bO7RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TAmKUldB4O9Of4Y2nMH3A59Wbn2+MKICcwdwGXkrAXuugIw6WcmqQZW/v/cf1RTeBmh8GcEZn2QGwbXDbW4EKlww1or1OJYuV7y4B/FiooL/e0ie9jr1+pg1HtAat86RQF0RspJrAA0VmHIaRmDedw/KrVAiJ14/ntZLLNfnNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2liEfUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACCFC4CEF1;
	Mon, 24 Nov 2025 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763997523;
	bh=vdaVyZMAiIluQBulvS0o8xmpluVa2GUlqU3Na3bO7RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u2liEfUnaoAHwjJ2YtNML+mD+vnHhy8eX+Pr8pZMLZwwnqMe2KGe36hyrljDmxttb
	 ekftnjQgkCblI1/2l/fw/F/M1Bs01N2Roen+57dPUoQIlseF46svsdt+BmoyjgTKfO
	 IKeFOzfpR4BT7NGIvmVhKQf6DtKYV5w/8Z8MG8tJLhGMGzOuUPS3vLNNvRDG/zxghZ
	 GtJVgrl+25KN4uKX9BfqaCnUogie2T522IK6RG/GWtDuhSNTmYBcGcQjyIjUtFS0/H
	 r8omuK+D/KcKRTpre8t9ovp3/owsEN1zmTzR++WEpxZGZzW+kVFAgfZYjPjCJMv4gX
	 grd/9IJVkNw8Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
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
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v7 09/22] MAINTAINERS: add liveupdate entry
In-Reply-To: <20251122222351.1059049-10-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 22 Nov 2025 17:23:36 -0500")
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
	<20251122222351.1059049-10-pasha.tatashin@soleen.com>
Date: Mon, 24 Nov 2025 16:18:33 +0100
Message-ID: <mafs0y0nvxxva.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 22 2025, Pasha Tatashin wrote:

> Add a MAINTAINERS file entry for the new Live Update Orchestrator
> introduced in previous patches.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

