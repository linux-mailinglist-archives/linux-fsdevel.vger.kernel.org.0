Return-Path: <linux-fsdevel+bounces-43605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD00A59688
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFE6188CC06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8A22A801;
	Mon, 10 Mar 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEkU6G3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BA221729;
	Mon, 10 Mar 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614124; cv=none; b=OPcx9q75B0Zf00x9N51rmZKZpfjjS6FQ6eSQHd6aRhvfjMmWj8MnR6Z5CSc+FYkP5hf6vBQpoycEDPFC3ryoxeHJX+OjYiOUDq5fB4we6zuxAFUKL/3sl0lMMg5Uca2nJdyp5ghtqOIs4kY8IRzLfnf6PtBnUsB6hskPXdqQ4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614124; c=relaxed/simple;
	bh=YseASnTCb4kJt65uee0yzPI779rItNm4h9T31KLhRjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHzmlp4K5brtTn82ghDvwAmaAxPN/pDUzD9o0rt/Ki4AZ0c9s+wQQ6ab6d3mpB8ssts2lqX+DMZYKBiew42Yk5JhOZiB1egqkRHyZqH0KTGTv0ah2LECTRTFSW8AySYBEaa5xBZzlr1Mh2Ake0xJXFmNRKOuAqFDuq3Q9vH3iug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEkU6G3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF5DC4CEE5;
	Mon, 10 Mar 2025 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741614124;
	bh=YseASnTCb4kJt65uee0yzPI779rItNm4h9T31KLhRjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEkU6G3eAlqAtIwRrw13bpL0WHsyI6ESgyEcZW/5gWXnKG9Yu0xxgq6NYRYu6k9/7
	 82jeC5iEvmMbik+xKl05RQVfCLuREzkQhSEnVhMwbG8PULXMKdLvL36AXARGUM9lID
	 214ovhePlm1eRVoH2HkYH1ug+yeYzgcDiqNr9F2DXVJCCk2lgcRh5PmgLccCjuI0zS
	 WthRbQ+ldEPuNjCnHIhkZlq8h77WCfRc9wh9g5DGf7mSE2uU+0DVY80GfW2FoKFLRA
	 cuPzevocXdHPBmH3lseH3ejBzHomsnZ2+BL22Xv95YK/0i6VkB9AxVtnNAwPWV4+e3
	 VFucZ9yfbxEOg==
Date: Mon, 10 Mar 2025 14:41:59 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 6/6] s390: mv s390 sysctls into their own file under
 arch/s390 dir
Message-ID: <r73ph4ht5ejeeuj65nxocmqp7pury2mekz2lz3r6fs264s24c4@ransymcrzk2h>
References: <20250306-jag-mv_ctltables-v2-0-71b243c8d3f8@kernel.org>
 <20250306-jag-mv_ctltables-v2-6-71b243c8d3f8@kernel.org>
 <20250307152620.9880F75-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307152620.9880F75-hca@linux.ibm.com>

On Fri, Mar 07, 2025 at 04:26:20PM +0100, Heiko Carstens wrote:
> On Thu, Mar 06, 2025 at 12:29:46PM +0100, joel granados wrote:
> > Move s390 sysctls (spin_retry and userprocess_debug) into their own
> > files under arch/s390. We create two new sysctl tables
> > (2390_{fault,spin}_sysctl_table) which will be initialized with
> > arch_initcall placing them after their original place in proc_root_init.
> > 
> > This is part of a greater effort to move ctl tables into their
> > respective subsystems which will reduce the merge conflicts in
> > kernel/sysctl.c.
> > 
> > Signed-off-by: joel granados <joel.granados@kernel.org>
> > ---
> >  arch/s390/lib/spinlock.c | 18 ++++++++++++++++++
> >  arch/s390/mm/fault.c     | 17 +++++++++++++++++
> >  kernel/sysctl.c          | 18 ------------------
> >  3 files changed, 35 insertions(+), 18 deletions(-)
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> 
> How should this go upstream? Will you take care of this, or should
> this go via the s390 tree?

thx for the review

It would be great if you can push it through the s390 tree. However, if
it is not possible to do so, please let me know and I'll add it to the
sysctl-next changes.

Best

-- 

Joel Granados

