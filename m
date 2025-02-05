Return-Path: <linux-fsdevel+bounces-40904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F6A28616
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 10:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7141886809
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9122A4D0;
	Wed,  5 Feb 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcouUFqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39679FE;
	Wed,  5 Feb 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746218; cv=none; b=OmX/QzUo84vnhQXxIJVYSOVDVFak/RCP0ApNW85ncxH4ehHzXOBnUqKjyX+Y5VZfrK5mn5sj+8eorHGePQY7k7d+rNVzV3jonXKY9rO5Wq443LhWXLQAZXZmVI8YkrYvaoe5ZpuSxte5GDfzPME+xtSW581hmdPkzpj8KTNqU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746218; c=relaxed/simple;
	bh=odrvl/ADLlE3OrvpCHrvqcIe/wV28jyuJRNCa6Hv8Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nV/Hqp3Nd78lz+mTl9k1u0SjGY+xqzDHHRl+ojoWfw/gHBl3mHtQp9lV3MURmb6CQgLTVNBqsq5jFqETMbhtiW/WPF5sB/aUEqEXPWMjsCX+CA81LR05FysCY2ZHwjPd/gjccBeYwttGO5gtZc/1qviMwcaEbL6457N02gFXqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcouUFqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F70CC4CED1;
	Wed,  5 Feb 2025 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738746217;
	bh=odrvl/ADLlE3OrvpCHrvqcIe/wV28jyuJRNCa6Hv8Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcouUFqSydEDvu0EP/6CYZJrsCw0Mzoz8NrCFV2ylQpmjanhNzZrcJQ2C9E7EgWFt
	 zc6NzfbUp8O/AYZwsOrYqJr8Hw5kSiZvyZ8QbXpPC1uGGFdbX4jtRK0UqrJmUamGuK
	 wteT+GTQsRK1AAVoIx6jxdkEY9RzHbJDPiq/CqImI2xzrJIkgPhmuGe7gUcVaabqtp
	 fFtpXaHIrjVgInPxTJ3JNSJXDYCaUOsMB6ggu/M62umCiIfwPCB2XkcHQqzIscWAiv
	 LqOJDw/mNYfj9VxTY9MSQFeEued1TtKshVJImHsO72RbcpSvf7h2FjqD1zwORZFp0w
	 8qz/w5wvnbyiw==
Date: Wed, 5 Feb 2025 10:03:32 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, 
	Baoquan He <bhe@redhat.com>, Bill O'Donnell <bodonnel@redhat.com>, 
	Corey Minyard <cminyard@mvista.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] sysctl constification changes for v6.14-rc1
Message-ID: <ba4qmufdwy4w73aiiopxpgozo2bklnzqigxdcvcf7xuvomvalk@rm7evxixij5k>
References: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
 <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>
 <iay2bmkotede6c5xkxnfvxwgxg2drmcc6az3eeiijkkz3ftie7@co4cir66ksz2>
 <202501311203.D6FDB314@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501311203.D6FDB314@keescook>

On Fri, Jan 31, 2025 at 12:03:39PM -0800, Kees Cook wrote:
> On Fri, Jan 31, 2025 at 02:57:40PM +0100, Joel Granados wrote:
> > From 431abf6c9c11a8b7321842ed0747b3200d43ef34 Mon Sep 17 00:00:00 2001
> > From: Joel Granados <joel.granados@kernel.org>
> > Date: Fri, 31 Jan 2025 14:10:57 +0100
> > Subject: [PATCH] csky: Remove the size from alignment_tbl declaration
> > 
> > Having to synchronize the number of ctl_table array elements with the
> > size in the declaration can lead to discrepancies between the two
> > values. Since commit d7a76ec87195 ("sysctl: Remove check for sentinel
> > element in ctl_table arrays"), the calculation of the ctl_table array
> > size is done solely by the ARRAY_SIZE macro removing the need for the
> > size in the declaration.
> > 
> > Remove the size for the aligment_tbl declaration and const qualify the
> > array for good measure.
> > 
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> 
> FWIW, this looks correct to me.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
Thx, I'll queue this up in sysctl-next unless it is already there.

Best

-- 

Joel Granados

