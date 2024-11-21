Return-Path: <linux-fsdevel+bounces-35398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253059D497E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AC9B20F90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9971CC884;
	Thu, 21 Nov 2024 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkDwaxgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256B1C9ECE;
	Thu, 21 Nov 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179856; cv=none; b=XMVjmdk+QEage7mRs63wewIpI82uPRmRYHzsacFRQpU4rloBae7YVB4RZYIs4tHq2zIxmwK7Qj8EdA326Ah4WC4o0egGs7BvbinGJOdvZtez88hRuvCUIsrbM0wZZN6o18FT7M6M/Il5PFd3kclWkmEX5rRPFWneklXY/mH9vCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179856; c=relaxed/simple;
	bh=yb6ZXmGUVTsn8jk1XyiL4tSuEqp9cHwvmbK/CUpdlUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maQV6k5MXHYROjgYxTzRc04F+kSSfvek9zkKwxByqwFlptA4K0nqYizF9Sjyzkj35udPlL4DxMaus54NUsS9YL5ZrAwdzRtfErSiHZ+mU4VD3EyvDgmxi2A5gYgsW4m4XQWqUhG0YCwm/Fog6Uy5kpeBM7h/EWTJg/bCWaLKLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkDwaxgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFB6C4CECC;
	Thu, 21 Nov 2024 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732179855;
	bh=yb6ZXmGUVTsn8jk1XyiL4tSuEqp9cHwvmbK/CUpdlUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkDwaxgZQxFDtf7JUHhS4ih3vU31F5iuXE1KE94NSmUlz62+dl2ghBAQTdcToo6cK
	 IkxTvEBEGQsiykR1F1Fxv9eca3ksI9tzfhmv2FpLr3JcaCTnTRa1OoL0rZH6L0eQUs
	 sJ2lfIRh0OIijM7iOUaLzt8KqS7m8f4fX96V9ZQiFh80yg188KvUb/8HcJ1wWAFQDx
	 qPAunj8Rj3UT/zUpMl4k6aMPLrI+vnTcNzwcVwVZMknsTh0EdIhHsNkbdjSCR/k2gu
	 vztnO/m3we6qAxoVDIOXq19PcGBTV/vBQq/VugQE7mq84P1CCLh/jrGRy8UoVCVELx
	 gY+agx5+C9zIA==
Date: Thu, 21 Nov 2024 10:04:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Message-ID: <20241121-wahrsagung-kantholz-97d1717c78b1@brauner>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <2621E9B1-D3F7-47D5-A185-7EA47AF750B3@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2621E9B1-D3F7-47D5-A185-7EA47AF750B3@fb.com>

On Wed, Nov 13, 2024 at 02:15:20PM +0000, Song Liu wrote:
> Hi Christian, 
> 
> Thanks for your review. 
> 
> > On Nov 13, 2024, at 2:19 AM, Christian Brauner <brauner@kernel.org> wrote:
> [...]
> 
> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> index 3559446279c1..479097e4dd5b 100644
> >> --- a/include/linux/fs.h
> >> +++ b/include/linux/fs.h
> >> @@ -79,6 +79,7 @@ struct fs_context;
> >> struct fs_parameter_spec;
> >> struct fileattr;
> >> struct iomap_ops;
> >> +struct bpf_local_storage;
> >> 
> >> extern void __init inode_init(void);
> >> extern void __init inode_init_early(void);
> >> @@ -648,6 +649,9 @@ struct inode {
> >> #ifdef CONFIG_SECURITY
> >> void *i_security;
> >> #endif
> >> +#ifdef CONFIG_BPF_SYSCALL
> >> + struct bpf_local_storage __rcu *i_bpf_storage;
> >> +#endif
> > 
> > Sorry, we're not growing struct inode for this. It just keeps getting
> > bigger. Last cycle we freed up 8 bytes to shrink it and we're not going
> > to waste them on special-purpose stuff. We already NAKed someone else's
> > pet field here.
> 
> Would it be acceptable if we union i_bpf_storage with i_security?

I have no quarrels with this if this is acceptable to you.

