Return-Path: <linux-fsdevel+bounces-74118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D505FD318DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CA4630BFFC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556782505AA;
	Fri, 16 Jan 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIw3NNgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024223F294;
	Fri, 16 Jan 2026 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568706; cv=none; b=tl8xYpsxiEbZfW4R2AY0Q12vm+kTBXtENioq2nVaD1keXOATAtg27NeCg5oD317MPhWAGMDO98Ulafu9KQX70yss6Mjr2IYnVy4apCs5az6fvWem7q48zV+TkRqGi+3zNJlUaqmAxU2eUXMCL7Y4TRSnW0lQf+anQGbTb8NzmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568706; c=relaxed/simple;
	bh=CbAFMWQxaWN4gPfzGHNuSzDAtPQQxKBaf65k7R7yp5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqxwUOFsaQfPyCNUN+MiJN2vl2gauFOw+72xYsxFlK/TdR7k7imAufGk1i9AEOToDwdzMRH2ASfJA9Uo3TnJH3luKKAZPOcog0YBEz65EdytFe7CaHCAGoeTZFDd7xuLIRgEINxMYPPtdcV+5DznxMnigEGMpSBo9EUfjkz4hX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIw3NNgy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768568704; x=1800104704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CbAFMWQxaWN4gPfzGHNuSzDAtPQQxKBaf65k7R7yp5g=;
  b=oIw3NNgyrYDGL/Gh/uR/PwXo5VXPxySRb7c3t/1Lx8wq2g9/wPERDNtN
   OqXu4HHckkI/pmIQ5xkvXp+33KTmmXQZn+TgWDaunIY22E4qF0ZrPS953
   vWXtokY0+eAJKKu0+9SYOXk+nM594hKOv573funM7FL3Tp1l8TIa4vfGU
   5SijnhqxuAa0OsN0vgdbmDN5m6szz+gh/UZI2pqOAXOuka7ryBZJcWsDU
   EKC1zz2bADt1VZPZN3SodcpSI/1SviuvaimvcBh3ASZV6Wzx2ni/i/N9C
   FugtDzeBvxVh6fiGBwSbHYC1CbTzY1f1AjjQodshNeu7uUTaulXI4Phum
   g==;
X-CSE-ConnectionGUID: 63JjSda5R0yFI0sap0wxbw==
X-CSE-MsgGUID: +Sil+aEkR7OwdbpG4+iEnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="68892453"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="68892453"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 05:04:56 -0800
X-CSE-ConnectionGUID: KQRblK2aQjW0DOA9Jboafg==
X-CSE-MsgGUID: pX6S6faKQwuORaUhAmfo+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209733228"
Received: from black.igk.intel.com (HELO black) ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 05:04:48 -0800
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Laurentiu
 Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Marcos Paulo de Souza <mpdesouza@suse.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
In-Reply-To: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
Date: Fri, 16 Jan 2026 14:04:45 +0100
Message-ID: <83zf6daetu.fsf@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcos Paulo de Souza <mpdesouza@suse.com> writes:

> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Should I pick this up or will you send this with the rest of the series?

Cheers,
--
Alex

