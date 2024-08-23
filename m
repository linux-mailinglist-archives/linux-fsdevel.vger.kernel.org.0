Return-Path: <linux-fsdevel+bounces-26888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556695C8ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73C4B26155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AFB14A4FF;
	Fri, 23 Aug 2024 09:11:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD7149002;
	Fri, 23 Aug 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404314; cv=none; b=ozyTXUigKIq9RnHuQwyDlmjwM6GgKlQKvGHomc4NR0126UOon/SEmWwFmR/jvPjbKFqpGsz2qDFeSRb8PPjoqTGDptx4desMFST1iDuXc9t7XxlfBuxene+oNMHwQe9BZdjXJe+rNJrlcgZQ6V9D4niy6oV/im34fTBlDVT2l5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404314; c=relaxed/simple;
	bh=sBxjqPY90sA8th14z9PpmpXgc0D2hH/Ae9bcg6vUdp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYuRGyzQe6ar5thOz4+y+6uh9OH9OFFmwLBc0M412O7L3PsLxBWyha9Gs0B3+fttpE3IkvVls+LOI0N+ZO+z14WTQ4oFNpO0FJpcXmUuiPpNH2ytj0QPvuVG3hUcdArGfhLhaFhOOY4BXNSDVFtRw2mpvw5Lr9V+xvEpwKze5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A89C32786;
	Fri, 23 Aug 2024 09:11:47 +0000 (UTC)
Date: Fri, 23 Aug 2024 10:11:45 +0100
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
Subject: Re: [PATCH v11 24/39] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <ZshSUcVIsdeJKcc5@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-24-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-24-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:27AM +0100, Mark Brown wrote:
> When invoking a signal handler we use the GCS configuration and stack
> for the current thread.
> 
> Since we implement signal return by calling the signal handler with a
> return address set up pointing to a trampoline in the vDSO we need to
> also configure any active GCS for this by pushing a frame for the
> trampoline onto the GCS.  If we do not do this then signal return will
> generate a GCS protection fault.
> 
> In order to guard against attempts to bypass GCS protections via signal
> return we only allow returning with GCSPR_EL0 pointing to an address
> where it was previously preempted by a signal.  We do this by pushing a
> cap onto the GCS, this takes the form of an architectural GCS cap token
> with the top bit set and token type of 0 which we add on signal entry
> and validate and pop off on signal return.  The combination of the top
> bit being set and the token type mean that this can't be interpreted as
> a valid token or address.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

