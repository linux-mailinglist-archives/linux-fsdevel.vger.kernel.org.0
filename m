Return-Path: <linux-fsdevel+bounces-12783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF098671B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502D81F27F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924F12D029;
	Mon, 26 Feb 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfutgURm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759A1CD2B;
	Mon, 26 Feb 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943975; cv=none; b=RHWKNao42Eex6DNqYe/MxZZQ9DRLIboxXwomMlt4UT42M6HiEalI71922XBQNCFDEunA9VB407tWeKZiJPPrFusP1F3QUR9TmO+x7Uyct6/U3PyGdy+5ggU3OBxOGw579jIMLtf7KEbv2MfgZk3PprP6bEIIXL0UgWMRMGaCVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943975; c=relaxed/simple;
	bh=ymjcFen8c3Su6bcKnRhsOkKT7wLiavklUN50no/AaHQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KPZOGPSybuNR9XQ68t/q6tA/xJexzc+0ma4dcJNSTh8sWSMmj8jz1ElP1EgnIsX9DguwOZRCa8T15FdNSHyXR15tHW6AmKwlBDDuYDqIv43dQnPwQFU8ZYsod/SIbVUcsiD8bMdiGES6kqroGJ+GSNIDOlM4ml/3a83G+EDAjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfutgURm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C3DC433C7;
	Mon, 26 Feb 2024 10:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708943974;
	bh=ymjcFen8c3Su6bcKnRhsOkKT7wLiavklUN50no/AaHQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WfutgURm5TLAIvDzJD7MQrGOiOzovl+SSrWQDpL4BQZXqKXSlQ2C9l6cELAoAMBEq
	 vdMEAelQUFi/VxzMO6RrmQAmEQK39mArk2ZgicrtiN7neDkvZI8bBAbAiOiXh9rn5v
	 YRvqot7ee5G9BMdNI//SqP2QdML0e7tUw6dL1dQ2UbtHd4V0JqbCAca/IoBvMG3E7A
	 q4l+a4VZS9iqKGPq5Hox7Ql+vxXdi8fiT6iUksgDB77c1408r/w2On0Q6QUCktvl6P
	 umNGMDfpge25hvRiJ/pqUHobDyJpqvIhSyUKPC9rdtULwBYLJTcd/68H75Kv1+g69e
	 mKgW5FtuQO6mw==
Date: Mon, 26 Feb 2024 11:39:35 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Kees Cook <keescook@chromium.org>
cc: y0un9n132@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <zhengqi.arch@bytedance.com>, 
    Alexandre Ghiti <alexghiti@rivosinc.com>, x86@kernel.org, 
    Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
    Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Josh Poimboeuf <jpoimboe@kernel.org>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Rick Edgecombe <rick.p.edgecombe@intel.com>, 
    Brian Gerst <brgerst@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Tony Battersby <tonyb@cybernetics.com>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Increase brk randomness entropy on x86_64
In-Reply-To: <20240217062545.1631668-1-keescook@chromium.org>
Message-ID: <nycvar.YFH.7.76.2402261138370.21798@cbobk.fhfr.pm>
References: <20240217062035.work.493-kees@kernel.org> <20240217062545.1631668-1-keescook@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Feb 2024, Kees Cook wrote:

> In commit c1d171a00294 ("x86: randomize brk"), arch_randomize_brk() was
> defined to use a 32MB range (13 bits of entropy), but was never increased
> when moving to 64-bit. The default arch_randomize_brk() uses 32MB for
> 32-bit tasks, and 1GB (18 bits of entropy) for 64-bit tasks. Update
> x86_64 to match the entropy used by arm64 and other 64-bit architectures.
> 
> Reported-by: y0un9n132@gmail.com
> Closes: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Wow, this is a pretty aged code indeed.

	Acked-by: Jiri Kosina <jkosina@suse.com>

Thanks,

-- 
Jiri Kosina
SUSE Labs


