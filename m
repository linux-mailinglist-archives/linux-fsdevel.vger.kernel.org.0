Return-Path: <linux-fsdevel+bounces-66676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E4C2832A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 17:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC0C3A861B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B492673AF;
	Sat,  1 Nov 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyfkrC+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E234D3A7;
	Sat,  1 Nov 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015114; cv=none; b=jGQoC+U6/WSMqEog7JAxJ/NWPdRv2RnTkRwIkAQV7OyU2vaeCsO+dJiBuTXA20sTMwzLwchCqY+1zGBP15FS8wadNKdMtGVyXDPOOBNY5cA75zYShjJSbKNptO9UJb4yCuTFUZ5clypctKrYrmlLtfWjVUaQbx6PvUt2b04u9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015114; c=relaxed/simple;
	bh=TbYkopGyFIENuHFLTsV1V/jcgq4zG4Ty8C4XMJb33II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFl4kNMZFDu98GGZpNoPr8VAf6XaxMBK05kXYNY9zZj+o8+b0oDt6MNL4OS6E9FoFLHMtOHvneoIy7R7VN16XRC+W0YatbO7Nuzu5g2nxxgGWjjqQuQGJf0bNp4x3kxzk30wIWNjQBpVSI9fhMbzkgJdej/MPSdUlKIfOVRG7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyfkrC+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF3BC4CEF1;
	Sat,  1 Nov 2025 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762015114;
	bh=TbYkopGyFIENuHFLTsV1V/jcgq4zG4Ty8C4XMJb33II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyfkrC+ikQeJH77i4aH47bJY6O3wr3xTa3lr2CYFhGR7l14ZHoYW4hmzOE/Ua9SXb
	 Q8t6WH5YISEsddmO/udRldPCV+t/UOjkDDVyaqy59DaKS4EYTSEpiYYmAMf47XAx7d
	 NO7bUVzL1Q8LpxBsJY6c3lX2q3WsG5LSac+riEZXekvOtCT58FJtGP8oJmfD+hF7LH
	 N2U5KF3Ehcq0lQpBMgHbpw842nj6dfnFb7vRf352FMN8H4Likmowl5t0b/5zjxPJ5z
	 Cxw1c2184KlmI1aUU06U5WP5xKCkeM4D1lTvo8mVizx9nducIm2DmwsV3sAMlhAC3n
	 TAZWgjkHiwOeg==
Date: Sat, 1 Nov 2025 12:38:28 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: fms extension (Was: [PATCH] fs/pipe: stop duplicating union
 pipe_index declaration)
Message-ID: <20251101163828.GA3243548@ax162>
References: <20251029-wobei-rezept-bd53e76bb05b@brauner>
 <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
 <20251030-zuruf-linken-d20795719609@brauner>
 <20251029233057.GA3441561@ax162>
 <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
 <CAMj1kXHP14_F1xUYHfUzvtoNJjPEQM9yLaoKQX=v4j3-YyAn=A@mail.gmail.com>
 <20251030172918.GA417112@ax162>
 <20251030-zukunft-reduzieren-323e5f33dca6@brauner>
 <20251031013457.GA2650519@ax162>
 <20251101-bugsieren-gemocht-0e6115014a45@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-bugsieren-gemocht-0e6115014a45@brauner>

On Sat, Nov 01, 2025 at 02:10:42PM +0100, Christian Brauner wrote:
> I'd like a stable branch before -rc5, please.

Sure thing. I have sent the change out for Acks now:

  https://lore.kernel.org/20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org/

I will finalize the branch by Thursday at the latest and ping you when
it is ready.

Cheers,
Nathan

