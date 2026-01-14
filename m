Return-Path: <linux-fsdevel+bounces-73780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF0BD2040B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DAA83072E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63073A4F28;
	Wed, 14 Jan 2026 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX3NXa+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBF3A1E66;
	Wed, 14 Jan 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408731; cv=none; b=rMf1vW6i2jYUWYNYa733bzP6Qw+S0psSNcYl0ybMr4GrZbJ6WSG1T7iAJSXxeQdv9LmKIUsixDh8ovAi5/oDdXgATuSjAYTxgukwHht/o3sSZCIuq35gGOmLrxiWKJT6Z4TKmJ6bjJUiw3OVn8pTRVmMqo9IhFKpgAU/ZgyCdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408731; c=relaxed/simple;
	bh=3O46Pj7m8kkRm5o6FCiKeQjNffkaPKNOyTPfHDTuyTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5hEBzqDtt1U8oUVdYPvxTikb4nXM3C4ZdF42WdUK9KtSXqV+lbzD9wdsLOWxUdFqvEsbTqK17oG+Ib0qmiv87KMoKukXdG9oXH5fyNWHwsOmTCLIe5UR0PM8ElvZ/9z/fYBI95e3vwp/MHJKQdnzzHQFg5sFJniJJzHBPaLejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX3NXa+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80489C4CEF7;
	Wed, 14 Jan 2026 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408730;
	bh=3O46Pj7m8kkRm5o6FCiKeQjNffkaPKNOyTPfHDTuyTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rX3NXa+ZIaH3nFwhK4UUCK7Tl+BkdrM7lAWylErEBVX8n4+UiQ4G9G3ZhsgmdM3kk
	 vN8PXFoQ+O9dscO4bKZ3M3QWmyyXJXre63JLVYqnzZ2NTakKl+OU0g0oj8iEefzjr3
	 mgengyjgYNSq8vnqi/nIcJdbHx722ODGLyY8W8WF4jD1J44QYJo3q7W39OBPor2Wnp
	 mtMB1YriAKD7oAMO5DENXpRw1aefTtMKh3nXtSKTmIbbZIhuLzX4/xt9jCGtUk6R4U
	 0bsnyWbYeo3xcvSjczR5clmShq482fExnV7dzxGfD2Q4FGvs3AgYwtJ9KizIe5aoQq
	 liWKl6bOegsTQ==
Date: Wed, 14 Jan 2026 16:38:39 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Daniel Thompson <daniel@riscstar.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aWfGj1eQhj2fAWB-@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
 <aVvF2hivCm0vIlfE@aspen.lan>
 <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
 <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>

On Tue, Jan 13, 2026 at 09:32:33PM -0300, Marcos Paulo de Souza wrote:
> I talked with Petr Mladek and it would need to rework the way that we
> register a console, and he's already working on it. For now I believe
> that we could take a look in all the patches besides the last one that
> currently breaks the earlycon with kgdb and maybe other usecases.
>
> Sorry for not catching this issue before. I'll use kgdb next time to
> make sure that it keeps working :)

As I understood things the bug was in earlycon rather then kgdb.

It was picked up by the kgdbtest suite since kgdb does some cool things
with earlycon (thanks to Doug Anderson) so I added a few earlycon tests
to the kgdbtest suite. However it wasn't kgdb itself that failed here.

So... if you want to run https://gitlab.com/daniel-thompson/kgdbtest
then certainly feel free but its probably less effort just to include
a couple of earlycon checks in your testing.


Daniel.

