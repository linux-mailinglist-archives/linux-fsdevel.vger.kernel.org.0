Return-Path: <linux-fsdevel+bounces-68109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15800C5474E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 21:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7F4F1DEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF052D3A9E;
	Wed, 12 Nov 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQbgQLw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C72266568;
	Wed, 12 Nov 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979063; cv=none; b=FOO+fuiOme8NrdUYwnLz6SQJe17YCiKpB013d34j7Jf7IGwJ8mFHYXuRbxvJM/eepf+CPWkNu4Uwvu7I725R+plkERxdorxixJpV/4awmoXbS6T+kjmhsjAa2PpyRxONpvASv1IPjP/REo77pxvIMLuypq9FlbYIFNxW1O8RE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979063; c=relaxed/simple;
	bh=mwcUjonCzzMfZYdyYUdmDpwyU/fnuOYn/CICWev1Wls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nq4gWjVU1CiP/6+6Chta92qmLhqUE7utDac0falTSQPUR0TzKs7c+j35w5Rvl+G/mnyAaBo1eqQKAJCRNa+oKltnimm9uEWm2/1JnUL0fSUgggRPQMSAXBDwpj2v9MLY4cMNTKiTjUDtsBbyNF6nR0lSGEspOaGFsOHPOiFjj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQbgQLw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09228C4CEF1;
	Wed, 12 Nov 2025 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762979062;
	bh=mwcUjonCzzMfZYdyYUdmDpwyU/fnuOYn/CICWev1Wls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQbgQLw9P6lFKBibAUmbYpSG8Kc0wXxdq6DEPV4fot9A8Q1oC6lf/tQLmW3FpXmzf
	 qPCka0jwkKlO0iXyomcWRkBkvtD8Vbh6IeUouYmzxc4zjLlXFrIDKw+zN9TcibDmA3
	 kKrDOOClHAVnPGzZD8sm2BtDGLYh6R8Ah/qLCCyr4KqWYmJNVn+BTx7p58HNu7zK+u
	 osS1a4WSO0TQ/dDij7iWmGThiI+x15CS5wutDKmEuCHdJVOaHz0R9BWvwqk/W/34C2
	 YF+3vFzxZBtnxFH1djMCfeY6S+cWfnL61EpWx0F2ygcbKJEmGW2ZqapHGLcxWwkLsa
	 yrAZl3wZLOt7w==
Date: Wed, 12 Nov 2025 22:23:57 +0200
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
Subject: Re: [PATCH v5 22/22] tests/liveupdate: Add in-kernel liveupdate test
Message-ID: <aRTs3ZouoL1CGHst@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-23-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-23-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:20PM -0500, Pasha Tatashin wrote:
> Introduce an in-kernel test module to validate the core logic of the
> Live Update Orchestrator's File-Lifecycle-Bound feature. This
> provides a low-level, controlled environment to test FLB registration
> and callback invocation without requiring userspace interaction or
> actual kexec reboots.
> 
> The test is enabled by the CONFIG_LIVEUPDATE_TEST Kconfig option.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_file.c     |   2 +
>  kernel/liveupdate/luo_internal.h |   8 ++
>  lib/Kconfig.debug                |  23 ++++++
>  lib/tests/Makefile               |   1 +
>  lib/tests/liveupdate.c           | 130 +++++++++++++++++++++++++++++++
>  5 files changed, 164 insertions(+)
>  create mode 100644 lib/tests/liveupdate.c
> 
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 713069b96278..4c0a75918f3d 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -829,6 +829,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
>  	INIT_LIST_HEAD(&fh->flb_list);
>  	list_add_tail(&fh->list, &luo_file_handler_list);
>  
> +	liveupdate_test_register(fh);
> +

Do it mean that every flb user will be added here?

>  	return 0;
>  }
>  

-- 
Sincerely yours,
Mike.

