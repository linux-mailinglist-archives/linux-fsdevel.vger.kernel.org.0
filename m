Return-Path: <linux-fsdevel+bounces-68112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C83C547EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 21:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B04E22CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628CC2D63E8;
	Wed, 12 Nov 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW9YbLhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2D2D193F;
	Wed, 12 Nov 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979965; cv=none; b=J1dcFmfK+CSkgz9p6LnJXUcosZ5IQg32Il9j/fbuGT4i49DC/ZiYxAWQ6n31X5Z4Kw03PNjcrVUdZH/88KYp4LCerLRdBFxBNmnIgPLpRLoy9y88g0gLaWxOtwuNivsxEN+CBZFcw9sqr5wRXtf8Phn3RKQwwdwdt1B70H7jXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979965; c=relaxed/simple;
	bh=OxUaOMJTFxWjdG6kL/CBz/1/5fyiG64oUzuOScdyhFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA/O9TW4w44iu67WOyJVvgJ9wdJGyz0F0TiTWJ6ceCkUw9D76L5QViNwCWJUZSkVx6OfI1/2+oMoJLJCx6oq5ahR+My8b64jHsh2y7VYJnlXNv3rZX+YfQARUwGptQGgfHUqRYn7XtnI2Ai6BtwpQ6CMyHrlNH+nBqYisF45yLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW9YbLhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BFBC4CEF1;
	Wed, 12 Nov 2025 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762979965;
	bh=OxUaOMJTFxWjdG6kL/CBz/1/5fyiG64oUzuOScdyhFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kW9YbLhrr+3qw/niJQupZPlXdIbDjOQ+zg42uQ/qSVCuE5BBw8o68+t4AYVjo0MMU
	 4HdNLuNuHPxg98rjv5h+Rkzelkj7XGGas5FtTYS4Mf75HIboXJOoOs/7JgFRj0O/CL
	 QCBsyuYoNRyAGNSsj/6W1a2Fy8YEdCa1T23w73DVN2IBUSMSVb2lVLr72QdkT06DX5
	 osBB13IJSUKI/kecG4aMG0gNW8fb55KQJ3kpXNLDUHZ68q6junN1CDcxZg4f8LtYVf
	 +oYz4K/X8Gtn3oTOmRzdU4qbjKswNSsMNnJzK84ynxT42vrU5YjQxvS/8iR/zg5Lb8
	 cUkwPcqYI/WNQ==
Date: Wed, 12 Nov 2025 22:39:00 +0200
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
Subject: Re: [PATCH v5 06/22] liveupdate: luo_session: add sessions support
Message-ID: <aRTwZNKFvDqb1NG5@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-7-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107210526.257742-7-pasha.tatashin@soleen.com>

On Fri, Nov 07, 2025 at 04:03:04PM -0500, Pasha Tatashin wrote:
> Introduce concept of "Live Update Sessions" within the LUO framework.
> LUO sessions provide a mechanism to group and manage `struct file *`
> instances (representing file descriptors) that need to be preserved
> across a kexec-based live update.
> 
> Each session is identified by a unique name and acts as a container
> for file objects whose state is critical to a userspace workload, such
> as a virtual machine or a high-performance database, aiming to maintain
> their functionality across a kernel transition.
> 
> This groundwork establishes the framework for preserving file-backed
> state across kernel updates, with the actual file data preservation
> mechanisms to be implemented in subsequent patches.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/liveupdate/abi/luo.h |  81 ++++++
>  include/uapi/linux/liveupdate.h    |   3 +
>  kernel/liveupdate/Makefile         |   3 +-
>  kernel/liveupdate/luo_core.c       |   9 +
>  kernel/liveupdate/luo_internal.h   |  39 +++
>  kernel/liveupdate/luo_session.c    | 405 +++++++++++++++++++++++++++++
>  6 files changed, 539 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/liveupdate/luo_session.c
> 
> diff --git a/include/linux/liveupdate/abi/luo.h b/include/linux/liveupdate/abi/luo.h
> index 9483a294287f..37b9fecef3f7 100644
> --- a/include/linux/liveupdate/abi/luo.h
> +++ b/include/linux/liveupdate/abi/luo.h
> @@ -28,6 +28,11 @@
>   *     / {
>   *         compatible = "luo-v1";
>   *         liveupdate-number = <...>;
> + *
> + *         luo-session {
> + *             compatible = "luo-session-v1";
> + *             luo-session-head = <phys_addr_of_session_head_ser>;

'head' reads to me as list head rather than a header. I'd use 'hdr' for the
latter.

-- 
Sincerely yours,
Mike.

