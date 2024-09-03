Return-Path: <linux-fsdevel+bounces-28441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607A96A49E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A600B1F24662
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062EB18BC1D;
	Tue,  3 Sep 2024 16:38:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896121E492;
	Tue,  3 Sep 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381508; cv=none; b=T++WO783FrpPY2vc9wHmTyuQ9vTv7Gg6qYWIK8ebms8lxNym3DKtIVpMI6tBKTx79U5XvzA98yl228oWt7tIUUqtPjYokc3c232Nk+DrfsLoEtcO/xTTJu3duuvM/hvdUOnLQLEhXQYgt7jBBwsAEyiAlr1YtciKr58VSHEKYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381508; c=relaxed/simple;
	bh=Ch4EB9z7SxI24U7kqiSf5J+jgI5aAF15vq3HqTETrBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icu5rb78oz2n6lVIP1F409yDGst5OIkMCOLc87ztgcnepa51hvYzlLCqrEo3RPqGoXHscQh3OBDu3TQQnb4zrsXgPhJuktx4xM5LIcGxEUX+HheLpIg39gCEn94qGxKpLYvKMfeG4roj3Gq3lh+iUTBuYzMIU5bttOqcr3tkXv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697ECC4CEC4;
	Tue,  3 Sep 2024 16:38:22 +0000 (UTC)
Date: Tue, 3 Sep 2024 17:38:20 +0100
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
Subject: Re: [PATCH v12 26/39] arm64/ptrace: Expose GCS via ptrace and core
 files
Message-ID: <Ztc7fIneIhCEmesI@arm.com>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
 <20240829-arm64-gcs-v12-26-42fec947436a@kernel.org>
 <ZtYKYMWjApRxFO_-@arm.com>
 <3f190f54-477e-48dd-8a57-8d61ea20413b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f190f54-477e-48dd-8a57-8d61ea20413b@sirena.org.uk>

On Mon, Sep 02, 2024 at 07:58:28PM +0100, Mark Brown wrote:
> On Mon, Sep 02, 2024 at 07:56:32PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 29, 2024 at 12:27:42AM +0100, Mark Brown wrote:
> 
> > > +static int gcs_get(struct task_struct *target,
> > > +		   const struct user_regset *regset,
> > > +		   struct membuf to)
> 
> > > +	if (target == current)
> > > +		gcs_preserve_current_state();
> 
> > What's the use-case where target == current and do we need something
> > similar for gcs_set()?
> 
> IIRC core file generation so no.

Ah, true. Makes sense.

-- 
Catalin

