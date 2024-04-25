Return-Path: <linux-fsdevel+bounces-17720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC568B1B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F9828631F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 07:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24E6EB4B;
	Thu, 25 Apr 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MmasBUph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FC6CDA5;
	Thu, 25 Apr 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029040; cv=none; b=uZlhU/LfITufdr6wUyubmn7V68w/ZlTtzgNBBFxXy8bUwO01JD1et/nSI0mp7VLDgueIne3fITim+YnlqFAhs+pEgdNN6rxk/Zj2zxO9lJq1zbr3218wWdisDtRsno2+CyirAzvAvpVOwdFPn2Nmhvjdz3kt18Hz7V5BGdSQI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029040; c=relaxed/simple;
	bh=rmNCwj/QZXocvFu/SV+UsAbq1yc1Onrw5e/MM6tpI4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gieOt1pLr+D0qMK4OYcfBKCyFuFyZJ7Do7RWMt3ayutKnlctUSr2Giaov9NdiRm4Za70PQzA3qkWCBKWf1/H9AA4Nu5ldrBgQ/XdgGVcB+r1Ht+ee3gDsTp/K9jbn607DyqrWZKqMU3wvsVD4YOAM1Fwrm2yuESrIdV3F2KqHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MmasBUph; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714029027;
	bh=rmNCwj/QZXocvFu/SV+UsAbq1yc1Onrw5e/MM6tpI4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmasBUphC0hDmcDselWsqNDchcFNLbtyyIXYaTEfQv4BLOsVbY80KeyHb5BvHn9uV
	 mXfX+53b9fklgAHnv4JHOlIL0SSIIXm5AmCALLJVlcCrmQacW/Cc+9xB5aBl8A7Dwb
	 B9LRLV8RKBn3hp3tvoCofURazzoY7NMe3hrGTd84=
Date: Thu, 25 Apr 2024 09:10:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>, 
	Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <9e657181-866a-4626-82d0-e0030051b003@t-8ch.de>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424201234.3cc2b509@kernel.org>

On 2024-04-24 20:12:34+0000, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Weißschuh wrote:
> > The series was split from my larger series sysctl-const series [0].
> > It only focusses on the proc_handlers but is an important step to be
> > able to move all static definitions of ctl_table into .rodata.
> 
> Split this per subsystem, please.

Unfortunately this would introduce an enormous amount of code churn.

The function prototypes for each callback have to stay consistent.
So a another callback member ("proc_handler_new") is needed and users
would be migrated to it gradually.

But then *all* definitions of "struct ctl_table" throughout the tree need to
be touched.
In contrast, the proposed series only needs to change the handler
implementations, not their usage sites.

There are many, many more usage sites than handler implementations.

Especially, as the majority of sysctl tables use the standard handlers
(proc_dostring, proc_dobool, ...) and are not affected by the proposed
aproach at all.

And then we would have introduced a new handler name "proc_handler_new"
and maybe have to do the whole thing again to rename it back to
the original and well-known "proc_handler".


Of course if somebody has a better aproach, I'm all ears.


Thomas

