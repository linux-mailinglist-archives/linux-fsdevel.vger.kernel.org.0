Return-Path: <linux-fsdevel+bounces-30963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4038A9901F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA036281B3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57413B792;
	Fri,  4 Oct 2024 11:18:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF1224D1;
	Fri,  4 Oct 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040736; cv=none; b=VW7Knnu9G5xdq2hOvPhZdf5wFpQ4ZYtiqqW7ZsXreZgFgUvmvUIJ3OneaVbGXkGbba8VE7IN9F12Q26vQvtXyOzbO42ATL2Y9X2gIgl1+4WCUnBegCChwcT6FiUo5Hker+iekPhxAM8zkQk4Ct9jTQXnV1JzQxSe++lXdGKUPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040736; c=relaxed/simple;
	bh=pZHox8K1Nmvgt3lxsApWtJFu8tZf+W8GEvc4spiFT0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3kjrljMSxvGGSKBmubQjma5vGj/0PH5b2OTKTPnb38LSrJXXp1rzelLuNM4O4KLwDJ1xbO5VoKcbuhTq0IBgtgfEqfZOHXuzG6M8SHwOJqxuZHNMDGUglk95mEY79PInsCOd+UDFA6B9EauP/xyLSDavspP6vyDyioJ5sToypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DEE0339;
	Fri,  4 Oct 2024 04:19:23 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DE1F3F640;
	Fri,  4 Oct 2024 04:18:47 -0700 (PDT)
Date: Fri, 4 Oct 2024 14:18:45 +0300
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 22/40] arm64/gcs: Ensure that new threads have a GCS
Message-ID: <Zv_PFVffwIkKevzE@arm.com>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-22-222b78d87eee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-arm64-gcs-v13-22-222b78d87eee@kernel.org>

On Tue, Oct 01, 2024 at 11:59:01PM +0100, Mark Brown wrote:
> When a new thread is created by a thread with GCS enabled the GCS needs
> to be specified along with the regular stack.
> 
> Unfortunately plain clone() is not extensible and existing clone3()
> users will not specify a stack so all existing code would be broken if
> we mandated specifying the stack explicitly.  For compatibility with
> these cases and also x86 (which did not initially implement clone3()
> support for shadow stacks) if no GCS is specified we will allocate one
> so when a thread is created which has GCS enabled allocate one for it.
> We follow the extensively discussed x86 implementation and allocate
> min(RLIMIT_STACK/2, 2G).  Since the GCS only stores the call stack and not
> any variables this should be more than sufficient for most applications.
> 
> GCSs allocated via this mechanism will be freed when the thread exits.

I think Szabolcs mentioned a GCS leak with v12:

https://lore.kernel.org/r/ZtrihWQFyb2/XrQV@arm.com

(and in some private messages IIRC)

Has this been identified? The changelog only mentions a leak in v8.

-- 
Catalin

