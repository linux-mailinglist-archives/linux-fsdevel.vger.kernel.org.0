Return-Path: <linux-fsdevel+bounces-69520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F2C7E33B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4433A759A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26762D7DEE;
	Sun, 23 Nov 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEj7LDNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC701D5154;
	Sun, 23 Nov 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913930; cv=none; b=dDybDrmR9myI2lGc1+zcZ6eg5T3voY2ACL5b8CkoycJDtq+Pi2BOCG8x9GbW4JAC2wdpSP6+K1D4y72R8S5Fdbmx4+witpOA+GUHsLwFoedZrVt+wRA72aH3ZCJWz/2fFF/jCKBBfAl5HWVYHgFZ5aGT75mBKgpYmCu5B7zAi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913930; c=relaxed/simple;
	bh=iVWayNIJ4hSH3Fqh4iv5N9nJbnfnFx1jKHx44lnHwXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpnEzcD3Uvs1UaA1gmY/ppmdH9hRjXgQmmdhkNrlkGzK50brVH+mrNjswhjGqat4JUgCGZ2DlGgsIJY8dDww0vJbrNm7HA+2wn89LgP52zNd0hZPhzRI6SUH67UuomjgAJJs49O19m9+UamT1gTsN9Whqxfxhd4neEq7XjzDBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEj7LDNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38118C113D0;
	Sun, 23 Nov 2025 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913929;
	bh=iVWayNIJ4hSH3Fqh4iv5N9nJbnfnFx1jKHx44lnHwXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEj7LDNRFeKh3Brh5+Tnr8ys08Au6/iNifFEu4npSUjlpEkRYtPbFWkAjmIarvG8o
	 mEzqiU89wuYLBYXVGdOOOAk8rx0Dazs0GlcpSaYsgNGo5lwL5m2Jf7CBz0vNZ+4wqz
	 +z5CncVvHnb/uxJJcDP6+g3aw8zEFJbufD0NkRidmC1MmbAfTQHK3+qGpE2iZYHImm
	 2SQQG4LklKSH6FB+hsmnVgb9xIEjTOlGc1BRau9nScUKdf2XVH0eOEYomBOlHHJwME
	 Ar/tB4blesu7ifnYesL6JbhCDzsdhbiEJAcWwDtaXpVLrgYFZGAydc4FmD5GjGcEzi
	 qrOWnGFWJObLA==
Date: Sun, 23 Nov 2025 18:05:04 +0200
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
Subject: Re: [PATCH v7 08/22] docs: add luo documentation
Message-ID: <aSMwsLstAutayHbC@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-9-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:35PM -0500, Pasha Tatashin wrote:
> Add the documentation files for the Live Update Orchestrator
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

> +Public API
> +==========
> +.. kernel-doc:: include/linux/liveupdate.h
> +
> +.. kernel-doc:: include/linux/kho/abi/luo.h

Please add 

   :functions:

here, otherwise "DOC: Live Update Orchestrator ABI" is repeated here as
well in the generated html.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

