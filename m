Return-Path: <linux-fsdevel+bounces-24891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC1946153
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 18:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07D81C20E2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BFE1A34BA;
	Fri,  2 Aug 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIHRQVJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78261A34A3
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614637; cv=none; b=DmYnvwYCa9r8lzF82YHOBliclx7LtGHXoifIILEAangNWAL2gZ18NCc2tQ+juzNwj6fpgmSt+KAjQilm/vkPf1Ktjblc15OfzMiRG9nJ26tCyafRThiYJI8YxIxJZ9oc4D2fPxvJVWCvnrA4ShJ82F8mnH61p8KI36+lId/gPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614637; c=relaxed/simple;
	bh=D5cezDh4A5XyfwFkC2BlahwYraXx3RdiYvjPIXTBfDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVMYbsCMaG5MODsvN5HWs7D/XqdeMHiFEreZSPrizDci9eO18LK8VWH8cBdyKhTncaDVqv37L5/ZHtgh8ivbXOkmdhlNLnpYa6LHXPbbjyoM9Qj9O3h1Lq99VSidc4E7lamF1I1j+359bWkOXogpW4exYQgJIurEexgi6dmgvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KIHRQVJe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso9972872e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2024 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722614634; x=1723219434; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaYp+4ySrYqox0C2LwNhC4Vws80twAVdjJbOgnZz/S0=;
        b=KIHRQVJe6Y/MjOKVb2whdHIVWcldHEUXi2MJeyXvjM4BHLaYUig0jy1s7X2FkuHKSY
         p1YBW9iggKrlP0ONUk6twLdFR8BzPW8lX5v3z9gYbk0dbi5xtlXcc8mfxCMgvxgfWW30
         2gJjuMpjnPFtW3id7aK7XakxTF6uD+b/lCp8BEsKsXe/YCUastne6o8wzHi5hbeBkzro
         DvVWPl9FjX3W3JxYk+aM8WoJlpG0+5WJHShAjylf9wW9awbubLcPEDWSJ8ey6v/r3Ude
         FagQ6FBlfm9ub0v2nYoS9RKYyc6yiBmxmuwO21Tm0NOMTSFGycV/lJUxr2UOp5sq16/K
         yfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614634; x=1723219434;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaYp+4ySrYqox0C2LwNhC4Vws80twAVdjJbOgnZz/S0=;
        b=aVVgHaSNSILtiONo6Cjle+KcR0gwBxQgYnIEMynb3ctQyUOgNg3cIh5cYR2I/BW5tJ
         FV9LJr5/cuO2KATImV1LFhjXIvk/cAT8ZpQNEaXoT4N5j/y24ipLeXIBn+E9LnDdieIw
         saCr5DA4OtHqolWf1jU0B+f+n5IOUqXZBFNFo7eaDbZSe0M22b6HQXWHfeeh9pSw8lrF
         4ai/V7LtFKes8KP78/ZQBw0U8By/LG/yP5h3nEnzp/SxCBDayVvlD6/D0fW0PvZBO8Sf
         VlVeIVymyW0NJSp+wFxrnRpAAkFJHVOA3SudepDkOCwam2yNO8hAAdoId0n+J+zC8sji
         wOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsK7aY9FkEMLiItbvymfiQzudAMaDV/LNpwmYrI+VH7bmDfVQJ/njcBYqrhYyiq2EYsdIC14jaicljAwRPScx2OGshtgRFVmBHER1O+Q==
X-Gm-Message-State: AOJu0YyLifIDkDm1AdUcyNUkOKCIOxYM3OeEFUoejNKFTNnG8Yp2zVFY
	UplO38/VfR+TMgjPhko61cV/QLQ37wPnwdggmdaUBa673h6vNMUTbMUKM7JwzcI=
X-Google-Smtp-Source: AGHT+IHar+PPGcrxDNcjSr1um3g+3xRCfTrmLOXPeIhwAHJBP67s3XLeWwHx6hWOKLC6el1844qAfg==
X-Received: by 2002:a05:6512:3ba0:b0:52f:c14e:2533 with SMTP id 2adb3069b0e04-530bb3c79e9mr2525031e87.48.1722614633808;
        Fri, 02 Aug 2024 09:03:53 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07dc7sm266293e87.16.2024.08.02.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:03:44 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:03:27 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v10 00/40] arm64/gcs: Provide support for GCS in userspace
Message-ID: <20240802160326.GA36502@mutt>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On 2024-08-01 13:06, Mark Brown wrote:
> The arm64 Guarded Control Stack (GCS) feature provides support for
> hardware protected stacks of return addresses, intended to provide
> hardening against return oriented programming (ROP) attacks and to make
> it easier to gather call stacks for applications such as profiling.
> 
> When GCS is active a secondary stack called the Guarded Control Stack is
> maintained, protected with a memory attribute which means that it can
> only be written with specific GCS operations.  The current GCS pointer
> can not be directly written to by userspace.  When a BL is executed the
> value stored in LR is also pushed onto the GCS, and when a RET is
> executed the top of the GCS is popped and compared to LR with a fault
> being raised if the values do not match.  GCS operations may only be
> performed on GCS pages, a data abort is generated if they are not.
> 
> The combination of hardware enforcement and lack of extra instructions
> in the function entry and exit paths should result in something which
> has less overhead and is more difficult to attack than a purely software
> implementation like clang's shadow stacks.
> 
> This series implements support for use of GCS by userspace, along with
> support for use of GCS within KVM guests.  It does not enable use of GCS
> by either EL1 or EL2, this will be implemented separately.  Executables
> are started without GCS and must use a prctl() to enable it, it is
> expected that this will be done very early in application execution by
> the dynamic linker or other startup code.  For dynamic linking this will
> be done by checking that everything in the executable is marked as GCS
> compatible.
> 
> x86 has an equivalent feature called shadow stacks, this series depends
> on the x86 patches for generic memory management support for the new
> guarded/shadow stack page type and shares APIs as much as possible.  As
> there has been extensive discussion with the wider community around the
> ABI for shadow stacks I have as far as practical kept implementation
> decisions close to those for x86, anticipating that review would lead to
> similar conclusions in the absence of strong reasoning for divergence.
> 
> The main divergence I am concious of is that x86 allows shadow stack to
> be enabled and disabled repeatedly, freeing the shadow stack for the
> thread whenever disabled, while this implementation keeps the GCS
> allocated after disable but refuses to reenable it.  This is to avoid
> races with things actively walking the GCS during a disable, we do
> anticipate that some systems will wish to disable GCS at runtime but are
> not aware of any demand for subsequently reenabling it.
> 
> x86 uses an arch_prctl() to manage enable and disable, since only x86
> and S/390 use arch_prctl() a generic prctl() was proposed[1] as part of a
> patch set for the equivalent RISC-V Zicfiss feature which I initially
> adopted fairly directly but following review feedback has been revised
> quite a bit.
> 
> We currently maintain the x86 pattern of implicitly allocating a shadow
> stack for threads started with shadow stack enabled, there has been some
> discussion of removing this support and requiring the use of clone3()
> with explicit allocation of shadow stacks instead.  I have no strong
> feelings either way, implicit allocation is not really consistent with
> anything else we do and creates the potential for errors around thread
> exit but on the other hand it is existing ABI on x86 and minimises the
> changes needed in userspace code.
> 
> glibc and bionic changes using this ABI have been implemented and
> tested.  Headless Android systems have been validated and Ross Burton
> has used this code has been used to bring up a Yocto system with GCS
> enabed as standard, a test implementation of V8 support has also been
> done.
> 
> There is an open issue with support for CRIU, on x86 this required the
> ability to set the GCS mode via ptrace.  This series supports
> configuring mode bits other than enable/disable via ptrace but it needs
> to be confirmed if this is sufficient.
> 
> The series depends on support for shadow stacks in clone3(), that series
> includes the addition of ARCH_HAS_USER_SHADOW_STACK.
> 
>    https://lore.kernel.org/r/20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org
> 

Verified this patchset on a FVP.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


Cheers,
Anders

