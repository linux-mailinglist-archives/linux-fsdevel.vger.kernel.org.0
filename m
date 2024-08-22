Return-Path: <linux-fsdevel+bounces-26819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9B95BD0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D131DB2324C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504311CF28D;
	Thu, 22 Aug 2024 17:19:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43731CE6F9;
	Thu, 22 Aug 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347190; cv=none; b=W0qH3MchrLoyy3qjki2hEYSnYhYsYR2xadsAZgcHJRlhStVSLWFQk6AkHqIgL93uSIBptrPbWdwVxkwWBN7UK1FVG8lwTnHDGIFZAUrNzRcxg9n8Rc4esdZ2uOum85KD5CJDhz0Sxgzs0pZhHgz5hygFOVRimWauVHqazo4UWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347190; c=relaxed/simple;
	bh=Y9AE9hh59polEoeUWWiPw1U6I0GOY7hTVod5vDQs2Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6tJgFWdKxkXaKOfgiIBeCXHtzFbvEhucVpUhgCsHuK42JXfVCieO2slzf24kJkHld3pIjv9ULk8kRFTsDNyQCJOWDpeifSAVvY2fJgwc1WL20r7FwgeM1JDjJ4e5QVIJ1mDOHQy8qTrtTstdBpBOVAbdD9gttrFdAYAabuNDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D34C32782;
	Thu, 22 Aug 2024 17:19:44 +0000 (UTC)
Date: Thu, 22 Aug 2024 18:19:38 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 19/39] arm64/mm: Handle GCS data aborts
Message-ID: <ZsdzKrTbrolW0lHn@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-19-41b81947ecb5@kernel.org>
 <ZsdjbsDrMWgBU9Hj@arm.com>
 <Zsdq4ymaW0vQffH_@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsdq4ymaW0vQffH_@finisterre.sirena.org.uk>

On Thu, Aug 22, 2024 at 05:44:19PM +0100, Mark Brown wrote:
> On Thu, Aug 22, 2024 at 05:12:30PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 22, 2024 at 02:15:22AM +0100, Mark Brown wrote:
> 
> > > +static bool is_invalid_gcs_access(struct vm_area_struct *vma, u64 esr)
> 
> > > +	} else if (unlikely(vma->vm_flags & VM_SHADOW_STACK)) {
> > > +		/* Only GCS operations can write to a GCS page */
> > > +		return is_write_abort(esr);
> > > +	}
> 
> > I don't think that's right. The ESR on this path may not even indicate a
> > data abort and ESR.WnR bit check wouldn't make sense.
> 
> > I presume we want to avoid an infinite loop on a (writeable) GCS page
> > when the user does a normal STR but the CPU raises a permission fault. I
> > think this function needs to just return false if !esr_is_data_abort().
> 
> Yes, that should check for a data abort.  I think I'd formed the
> impression that is_write_abort() included that check somehow.  As you
> say it's to avoid spinning trying to resolve a permission fault for a
> write (non-GCS reads to a GCS page are valid), I do think we need the 
> is_write_abort() since non-GCS reads are valid so something like:
> 
> 	if (!esr_is_data_abort(esr))
> 		return false;
> 
> 	return is_write_abort(esr);

We do need the write abort check but not unconditionally, only if to a
GCS page (you can have other genuine write aborts).

-- 
Catalin

