Return-Path: <linux-fsdevel+bounces-17833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91C8B29F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09B8B24C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA35153BD7;
	Thu, 25 Apr 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Z+gqGa8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89C18EAB;
	Thu, 25 Apr 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077298; cv=none; b=YjbEIPA5ZQ3mGIn4jdMOZR4+KmHM+0oRUPUnWZlndMqz4cHzuTq4wbqEqyidD8Wo+gES6PwThNWpgy1vywzWZml8GTmNNOoDxpVeO54OF86YwWY8zYysI5rizDQGXGidhOtF2Tblp9A/ml/c+AENXNWw1WNowVwt/4NvLs+d6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077298; c=relaxed/simple;
	bh=bZqtcMhFx7TDPaIgrLqyfpl0/OfmMPAKopBgZDQprIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDTYRMm3ZJvyyo+JHX4346bHXwQk4zKH+Px/X2onJEJ5G1ZTJY86z5gwgO4Pk/C8HdqIMEKVQcbYl9VYu/L8H9xGbpqj2BAgVmHgk20Tn0rsKhomwQ+zr/X2wdCYjeJUrJTGjactRQqDGjQMSVbKVAG5nDnHLmEojx579uWTEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Z+gqGa8P; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714077293;
	bh=bZqtcMhFx7TDPaIgrLqyfpl0/OfmMPAKopBgZDQprIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+gqGa8PD+3BrRxF+Exe+s/+n1FrcsSYPFeQUrvoT2UUvEiGsEXMDYuXjYQJDYiRJ
	 9/0fJxtI2lDBLEHhkegO15rObvRhgIuWQMhE+D085PPIsVKHmI/z9Zz6qr7xUxUgOg
	 gdOVIytSYg1zquf83mxdxD8VyvGj7mHBMGjmlG8k=
Date: Thu, 25 Apr 2024 22:34:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Eric Dumazet <edumazet@google.com>, 
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
Message-ID: <d11f875e-4fb5-46dd-a412-84818208c575@t-8ch.de>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <CGME20240425031241eucas1p1fb0790e0d03ccbe4fca2b5f6da83d6db@eucas1p1.samsung.com>
 <20240424201234.3cc2b509@kernel.org>
 <20240425110412.2n5d27smecfncsfa@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425110412.2n5d27smecfncsfa@joelS2.panther.com>

Hi Joel,

On 2024-04-25 13:04:12+0000, Joel Granados wrote:
> On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Weißschuh wrote:
> > > The series was split from my larger series sysctl-const series [0].
> > > It only focusses on the proc_handlers but is an important step to be
> > > able to move all static definitions of ctl_table into .rodata.
> > 
> > Split this per subsystem, please.
> It is tricky to do that because it changes the first argument (ctl*) to
> const in the proc_handler function type defined in sysclt.h:
> "
> -typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
> +typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
>                 size_t *lenp, loff_t *ppos);
> "
> This means that all the proc_handlers need to change at the same time.
> 
> However, there is an alternative way to do this that allows chunking. We
> first define the proc_handler as a void pointer (casting it where it is
> being used) [1]. Then we could do the constification by subsystem (like
> Jakub proposes). Finally we can "revert the void pointer change so we
> don't have one size fit all pointer as our proc_handler [2].
> 
> Here are some comments about the alternative:
> 1. We would need to make the first argument const in all the derived
>    proc_handlers [3] 
> 2. There would be no undefined behavior for two reasons:
>    2.1. There is no case where we change the first argument. We know
>         this because there are no compile errors after we make it const.
>    2.2. We would always go from non-const to const. This is the case
>         because all the stuff that is unchanged in non-const.
> 3. If the idea sticks, it should go into mainline as one patchset. I
>    would not like to have a void* proc_handler in a kernel release.
> 4. I think this is a "win/win" solution were the constification goes
>    through and it is divided in such a way that it is reviewable.
> 
> I would really like to hear what ppl think about this "heretic"
> alternative. @Thomas, @Luis, @Kees @Jakub?

Thanks for that alternative, I'm not a big fan though.

Besides the wonky syntax, Control Flow Integrity should trap on
this construct. Functions are called through different pointers than
their actual types which is exactly what CFI is meant to prevent.

Maybe people find it easier to review when using
"--word-diff" and/or "-U0" with git diff/show.
There is really nothing going an besides adding a few "const"s.

But if the consensus prefers this solution, I'll be happy to adopt it.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/commit/?h=jag/constfy_treewide_alternative&id=4a383503b1ea650d4e12c1f5838974e879f5aa6f
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/commit/?h=jag/constfy_treewide_alternative&id=a3be65973d27ec2933b9e81e1bec60be3a9b460d
> [3] proc_dostring, proc_dobool, proc_dointvec....


Thomas

