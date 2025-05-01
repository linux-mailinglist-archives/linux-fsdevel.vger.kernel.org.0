Return-Path: <linux-fsdevel+bounces-47878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0034AA678A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 01:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A984C100D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 23:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECEB2609D3;
	Thu,  1 May 2025 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsr2AkHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BD26FD8B;
	Thu,  1 May 2025 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746143358; cv=none; b=nrBqlnmY76hVrmCFURosC08U5xAWqy0BET03N7aS6J2SN9HDI1zDqHzEaYQFJS0aHI0s4nORKIx6yXODivwxJGOMxCPHHE9iV6H4exwgD1NzXB9GnE++t8LHEbJYaz/vbUb/2VVDr/Hkg5MqRtyM+RnhuaZ+DwhC+/fQI0Dou7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746143358; c=relaxed/simple;
	bh=oBb30km4rgKn4We1YO6LEEYryPCsN9axqOjf65m6cV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxG2Hn4MQZgOxfr1eVGdkX7HgtfP3wHOEFXHlLcTU5Dr0IriLPn9Mq07NOTZTHeM+L6VR45Nz/+C67O8BSlj4R2D4AwC2smUi6xIBCgtvxyZnMPVdY+xaT11hb6vdRD+Z897xHDByw8BnJYSWfgp16A42uqNvhL+ksffKQB4s5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsr2AkHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83409C4CEED;
	Thu,  1 May 2025 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746143354;
	bh=oBb30km4rgKn4We1YO6LEEYryPCsN9axqOjf65m6cV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dsr2AkHaUNLtlqO3Grbv5Rh/u8s8h80+GON71LhmZjrpojXzovUSv4b4g+w6lBWkV
	 55V3QLUfZD2fcFYSza2TxHUFzJ5A0SiDS3j68+vyr7hh/Al3+z8sEDZunMNkdUghLQ
	 qdOgeTd8+w+aYvUthj9TTfBI/jE/cxMtZie9HgTeubAuC5FLsKZGVROANb6xuslCQ3
	 hF3qNtD65MwY5yAjZZOLaNo8PmRIsibLgWNLSeehpU43q10qbvTZHYT9qgnsfHTdsl
	 vajS7mk/6OjI4Ln5khTAIc9AXi9JwbuH04ztxwA97YFuaXbHv8Y5Egk0gyxxkpYCsN
	 c2iWSCDrsS60A==
Date: Thu, 1 May 2025 16:49:11 -0700
From: Kees Cook <kees@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Move brk for static PIE even if ASLR disabled
Message-ID: <202505011633.82A962A7@keescook>
References: <20250425224502.work.520-kees@kernel.org>
 <ad6b492c-cf5e-42ec-b772-52e74238483b@arm.com>
 <202504301207.BCE7A96@keescook>
 <a6696d0f-3c5a-46a8-8d38-321292dac83d@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6696d0f-3c5a-46a8-8d38-321292dac83d@arm.com>

On Thu, May 01, 2025 at 12:03:32PM +0100, Ryan Roberts wrote:
> I agree, as long as COMPAT_BRK is not set (which is the common case IFAICT).
> When COMPAT_BRK is enabled, I think you are breaking the purpose of that
> Kconfig? Perhaps it's not a real-world problem though...

When you turned off ASLR, what mechanism did you use? Personality or
randomize_va_space=0?

> > It's possible it could break running the loader directly against some
> > libc5-based binaries. If this turns out to be a real-world issue, we can
> > find a better solution (perhaps pre-allocating a large brk).
> 
> But how large is large enough...

Right -- Chrome has a 500MB brk on my laptop. :P Or with randomization
off, it could allocate to the top of the mmap space just to keep
"future" mmap allocations from landing in any holes...

> Perhaps it is safer to only move the brk if !IS_ENABLED(CONFIG_COMPAT_BRK) ?
> Then wait to see if there are any real-world COMPAT_BRK users that hit the issue?

Yeah, that might be the best middle-ground.

-- 
Kees Cook

