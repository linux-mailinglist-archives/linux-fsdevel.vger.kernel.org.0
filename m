Return-Path: <linux-fsdevel+bounces-17544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E278AF699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 20:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7365A1F25B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD813F459;
	Tue, 23 Apr 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WfiCVzYk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA751DDC5;
	Tue, 23 Apr 2024 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897108; cv=none; b=na4g+41QcKKUfAUVIVfgS47Xqo5jjlr+WdTFRhS9vKR6s+5mQb7nBMLxbUPDiyj1X604PH0Vh9cxVnLkBSuH6OceENWw5B7DCxC7fxEsRhL7/x0cB+QCvMHW3y7I5V/XNtj+ySeyhr0cf2xY2Oen+mjYV9nH9mrTZQjPtxonWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897108; c=relaxed/simple;
	bh=zCEHlyKJhhK4MvhJVSRGGSCDG0oxF0tC8ADUk82NkVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfRq5v77AOHR8aaGY6eV8O+t4obBkrmNNQ7UZr5mkx1KRud0on5EW8Th/1x6gZNv4CIsmrcPxMemhMvacMK0q4VuGTyc0tyiFQ6k3WkB1jtv5bpJZZWCSoec0Z418b+IwL4cLm2rxS+fXaHMUM/K6XuSCnm8GJ3Tp8SKroRPu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WfiCVzYk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=Rogg05ztOu4aP2/pn8CD75vsgL5H5uwqaxXujjk6r6E=; b=WfiCVzYkyj37KGe/1NcuIa1Hgk
	I9gAfHu6MCMw7NSXSor84TLrOU+mUG0ndyfzjVt0moZbaiRHo/8L+p3QYdcySteGNhcAPGJCKkoWj
	g/687Hepcmtf5PZKpuZ7znbxvUnMDD43qnPnbu67zfXVJS8SML5AtXvgw73tSyJkv3Nhg5awIIQnq
	1JNMkoOZN3LoUHS53IUhOaxE7wP++2K6T0ediCLJbAhO11cNq5v9xJzhveqww2JPt0aKNdvm5A/Y5
	rB55b5NewsYDat/UO4lQuhE8Q3txZ3JjdTGVGjV+Hgo05PhOwNnuMGRbC0LVs1cOtEcnZeCVZdr0F
	79Ap4ebA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKvd-000000018V6-22Td;
	Tue, 23 Apr 2024 18:31:41 +0000
Date: Tue, 23 Apr 2024 11:31:41 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Joel Granados <j.granados@samsung.com>,
	Kees Cook <keescook@chromium.org>,
	Eric Dumazet <edumazet@google.com>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <Zif-jf8Takojtq7x@bombadil.infradead.org>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Apr 23, 2024 at 09:54:35AM +0200, Thomas Weiﬂschuh wrote:
> * Patch 1 is a bugfix for the stack_erasing sysctl handler
> * Patches 2-10 change various helper functions throughout the kernel to
>   be able to handle 'const ctl_table'.
> * Patch 11 changes the signatures of all proc handlers through the tree.
>   Some other signatures are also adapted, for details see the commit
>   message.
> 
> Only patch 1 changes any code at all.
> 
> The series was compile-tested on top of next-20230423 for
> i386, x86_64, arm, arm64, riscv, loongarch, s390 and m68k.
> 
> The series was split from my larger series sysctl-const series [0].
> It only focusses on the proc_handlers but is an important step to be
> able to move all static definitions of ctl_table into .rodata.
> 
> [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net/
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Cover letters don't need SOBS we only use them for patches.

But anyway:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

