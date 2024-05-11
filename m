Return-Path: <linux-fsdevel+bounces-19310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04AC8C3074
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ACA1F21679
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494755783;
	Sat, 11 May 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="k56XE3N3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4881537F5;
	Sat, 11 May 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715421082; cv=none; b=hLo1qT7TB6M1I8MXvU4U+q0teDCMTaCT99oP1yXheShClDSEGn2rV4ifefhv/3YO/abP38hBCCzsrcUyArpwKnQONTKXI+RKoIC5VnIahkTw2jq+NK27hcZa61JpOAkVP9bVP1kkw5WYYrGcgCI9k/9+0OPBDERqK0u0+BHgsmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715421082; c=relaxed/simple;
	bh=0cJX+ofKilB0YeAddG2Rk34Tcb84daQhOHXhdzx0r3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1Emcb0fYYhIyfj4HDg32a0cLUnd3pWmx0p1eqTDOa+K/dtsGx99nPG6i9Fnxbq0yaMHPghGHN9HnmxE2ySH1nZngEn/mRlDZzJNH3K/XDH5c5MvQZU32BFzpay9cqLlH3U8f6hk+0mwpcNA7zgH/xGNpjc1jvhT2QfLm9mOL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=k56XE3N3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715421078;
	bh=0cJX+ofKilB0YeAddG2Rk34Tcb84daQhOHXhdzx0r3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k56XE3N3d4pgs8RXOwLSnRLB27sLWUfITEgcvrDMjZdmJPa/Ir6S6oi9PpE553jPt
	 sb7k+FxSLFp8Odclpb2t4vqVdgVnPhAwWUDBH9QwI80jAM7LA7gxjkMhJ80aDoR2yw
	 DUA3ugAMpnt1Nr9pHpMHzjCRdAMZeTMxIBsCjZb8=
Date: Sat, 11 May 2024 11:51:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, Eric Dumazet <edumazet@google.com>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <8d1daa64-3746-46a3-b696-127a70cdf7e7@t-8ch.de>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
 <202405080959.104A73A914@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202405080959.104A73A914@keescook>

Hi Kees,

On 2024-05-08 10:11:35+0000, Kees Cook wrote:
> On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Weißschuh wrote:
> > > The series was split from my larger series sysctl-const series [0].
> > > It only focusses on the proc_handlers but is an important step to be
> > > able to move all static definitions of ctl_table into .rodata.
> > 
> > Split this per subsystem, please.
> 
> I've done a few painful API transitions before, and I don't think the
> complexity of these changes needs a per-subsystem constification pass. I
> think this series is the right approach, but that patch 11 will need
> coordination with Linus. We regularly do system-wide prototype changes
> like this right at the end of the merge window before -rc1 comes out.

That sounds good.

> The requirements are pretty simple: it needs to be a obvious changes
> (this certainly is) and as close to 100% mechanical as possible. I think
> patch 11 easily qualifies. Linus should be able to run the same Coccinelle
> script and get nearly the same results, etc. And all the other changes
> need to have landed. This change also has no "silent failure" conditions:
> anything mismatched will immediately stand out.

Unfortunately coccinelle alone is not sufficient, as some helpers with
different prototypes are called by handlers and themselves are calling
handler and therefore need to change in the same commit.
But if I add a diff for those on top of the coccinelle script to the
changelog it should be obvious.

> So, have patches 1-10 go via their respective subsystems, and once all
> of those are in Linus's tree, send patch 11 as a stand-alone PR.

Ack, I'll do that with the cover letter information requested by Joel.

> (From patch 11, it looks like the seccomp read/write function changes
> could be split out? I'll do that now...)

Thanks!

Thomas

