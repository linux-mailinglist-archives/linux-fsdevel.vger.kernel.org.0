Return-Path: <linux-fsdevel+bounces-26520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F4D95A49D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8FAB215B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1036C1B3B33;
	Wed, 21 Aug 2024 18:18:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731A16B725;
	Wed, 21 Aug 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264294; cv=none; b=GLRnxZ/DVl6natvV6rlWysiUMKLKDVwswN/NZLJoFF9aU0qjxR+JsjBH9QhtGiPjVEaulitwRChtX83kYIJRmfp3t6rz4vbonejFPKQei4wc7Wjhi30wA+UopF7b9GIvc5RQM0XuCICHZLZiKrZSr0K37Yu9vHRGlx3BwnS1ZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264294; c=relaxed/simple;
	bh=HqXiHUM8OuS/yxYEycv5YsMMoXgklwoDD8UywEZmmnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsLFtkN40Oboc/ZIWpqgWTB3YZ2OjaC6L7ZdmHCq/ziMjWsO9Fg2x5C+4bCljOaGfw8/qfiRI26Ckra2nLRESflgDML82NCqdniez730YLjPZpO03B7Y7hIU0BoQpT4Ue8kOmGporT7vYJhgtijU1nV9JuOIlB4dSYzUSOlB2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C128C32781;
	Wed, 21 Aug 2024 18:18:08 +0000 (UTC)
Date: Wed, 21 Aug 2024 19:18:06 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <ZsYvXqYEMYvIar28@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
 <ZsYj0YYMuX1YRBZT@arm.com>
 <d5473c27-167f-46c3-9368-487ed4b657cf@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5473c27-167f-46c3-9368-487ed4b657cf@sirena.org.uk>

On Wed, Aug 21, 2024 at 07:03:13PM +0100, Mark Brown wrote:
> On Wed, Aug 21, 2024 at 06:28:49PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 01, 2024 at 01:06:50PM +0100, Mark Brown wrote:
> > > +	/*
> > > +	 * Push a cap and the GCS entry for the trampoline onto the GCS.
> > > +	 */
> > > +	put_user_gcs((unsigned long)sigtramp, gcspr_el0 - 2, &ret);
> > > +	put_user_gcs(GCS_SIGNAL_CAP(gcspr_el0 - 1), gcspr_el0 - 1, &ret);
> > > +	if (ret != 0)
> > > +		return ret;
> 
> > Doesn't the second put_user_gcs() override the previous ret?
> 
> No, we only set ret on error - if the first one faults it'll set ret
> then the second one will either leave it unchanged or write the same
> error code depending on if it fails.  This idiom is used quite a lot in
> the signal code.

You are right, I missed that it's called 'err' in put_user_gcs(),
thought it's overridden.

-- 
Catalin

