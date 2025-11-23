Return-Path: <linux-fsdevel+bounces-69521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1636C7E347
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A87F3481F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0362D8371;
	Sun, 23 Nov 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2mg2s8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764D27472;
	Sun, 23 Nov 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914066; cv=none; b=MjLCzJeY+nhn9shkNRMXwvAjyhuV6l/wFqpe4HvcBxQ1e8chvbyynGsSdN6zAy6mNm5xrdgIHjTwCw0y/nnpPxvrzOsUN9aUR6raBqeg0aXIj/o1PORs3RP+HJukpHbr/5PbWj4W1gG/WjOLg6G9/PIi1/bTQMmAJEvKIT+oGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914066; c=relaxed/simple;
	bh=7gBCeai/PYLWlQyJ7zmnTaLwRvHr9b0Er9v8ly4gDBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyXWvj8kKBRlSy9U9ZtbnEu0X5HvA6mg6ZrudhmkOAynwXFyignbobZDXvc0ZfLUePcOPdYpQkE+j46np36wynoM5EuCAtelVmGftdkjVo0SXpKxFQlxbElF28shj29lfzsWWemBzsRa7JPNn8C3rxbC3W2h6nwAZJ7Wq3d73FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2mg2s8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0A4C113D0;
	Sun, 23 Nov 2025 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763914065;
	bh=7gBCeai/PYLWlQyJ7zmnTaLwRvHr9b0Er9v8ly4gDBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2mg2s8U6qfDREC8jiXuiUV+BZWRjfeaUtQywQBP3iD96fEacOZ+FJboHt9MAkrvR
	 djGJ84TvCoRsIAuf6EVYZmNGLurfJ7ecHvZl86uB4kQgXEgdVQyOP89B4TpCJVej8l
	 HBGje5ja6ujFE7hwA7S6dGQdct+B5PSVdfJ8QkY6m7zsv0w9l+SpMgNtchkAZFhRFz
	 UoPg1Gpovm3ehI3zg+eLlyDCqspqUjfSStZe6lK62R+oHfJyDelX/Rye0Ze656xxtz
	 7U4L3G3sC0TPxgM+aaPvMbCO2WFtRzEIX2uvE/Oh7G/GFXvX73gbS4zBFIRx4QyOgS
	 008nHEbqU116w==
Date: Sun, 23 Nov 2025 18:07:21 +0200
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
Subject: Re: [PATCH v7 15/22] docs: add documentation for memfd preservation
 via LUO
Message-ID: <aSMxOTnxKuQ4bce9@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-16-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-16-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:42PM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> Add the documentation under the "Preserving file descriptors" section of
> LUO's documentation.
> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/core-api/liveupdate.rst   |  7 +++++++
>  Documentation/mm/index.rst              |  1 +
>  Documentation/mm/memfd_preservation.rst | 23 +++++++++++++++++++++++
>  MAINTAINERS                             |  1 +
>  4 files changed, 32 insertions(+)
>  create mode 100644 Documentation/mm/memfd_preservation.rst

-- 
Sincerely yours,
Mike.

