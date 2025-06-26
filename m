Return-Path: <linux-fsdevel+bounces-53066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFFEAE98B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73887173DF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54C2957A9;
	Thu, 26 Jun 2025 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tjA/Rnk+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zstK+Uwb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170F19D087;
	Thu, 26 Jun 2025 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927393; cv=none; b=gYGiEBljcYARq8OJNiOs/HaAxu8yxvcXGnSF2kIHuLXkcHF2A+yn+ij+cOksewZG4jrucimYgRXdF3LUXVlyGlDi5nbaACfasEluSpcOHIpJc+5/1O+kfKC5LpcGyKqNRi4XHpUg2nWnt5oyZBXUUU1dYDF/EpsQiqeoLXbUfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927393; c=relaxed/simple;
	bh=DKrElHS/l9lkSY/LdvJgsJ229eH3cP1Pn2QsP3Kt0Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f9bePWy6UYhwh7zGcpcQwlCQE9NemvrexjpW5C23Mpa45n+hmFQFvQ+5DVCD5TAABJ3uRXMzbI+KUYejg8WGsMpEteYMf8sS41++sOcfPtDGh2KMCmTOfSxITEdirth85f9+jYvsp41pqu1kgO4mQLxF+721OmlO6yQ/ff2M5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjA/Rnk+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zstK+Uwb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750927384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIEWFzd10izeW8NDAm48DU86YG8FHDrpuX4aNPjS3Jo=;
	b=tjA/Rnk+7n4pUaOf3T/JaUV5OHu1PRc7GDWWXg+J1EyHmKjzmI1gEpTO1a7KpvtqQw5Ngh
	eVLHzXA55XrWSxKkP1ESQMxAQ0+nb+G2M5bzeeUBwG5YKvfXF8jXGOX2BAn/Ln6HgbsctT
	WHZIgftYRVJXnz0SdgxbfkVxMoxHTL5mVnhtBCfcvjrJrawUIPCo9nsUqbnBo3iYTRw0tB
	cJvODXpp1ZWeMi7GHRQFRAChsSTWNMJOuDUe9vAvnliv9u8wvybWW5sNuKFWOtq6+QmeGH
	BC8soDXGTlVyocY6ybkwsHHR/JKWQ9fFRwlBRvFDR28fwbOPFb3M3q5q5XCyyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750927384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIEWFzd10izeW8NDAm48DU86YG8FHDrpuX4aNPjS3Jo=;
	b=zstK+UwbcYeqabnmHcHIqX8YuOVYAcK6vi7cltYuSxry4c+lorPwei2yXB1bmLGacEeBnx
	hM2RyTRUrOy58kDw==
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@gentwo.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Ulf
 Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Uladzislau Rezki
 <urezki@gmail.com>, Matthew Wilcox <willy@infradead.org>, Kuan-Ying Lee
 <kuan-ying.lee@canonical.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Etienne Buira <etienne.buira@free.fr>, Antonio Quartulli
 <antonio@mandelbit.com>, Illia Ostapyshyn <illia@yshyn.com>, "open
 list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, "open list:PER-CPU
 MEMORY ALLOCATOR" <linux-mm@kvack.org>, "open list:GENERIC PM DOMAINS"
 <linux-pm@vger.kernel.org>, "open list:KASAN"
 <kasan-dev@googlegroups.com>, "open list:MAPLE TREE"
 <maple-tree@lists.infradead.org>, "open list:MODULE SUPPORT"
 <linux-modules@vger.kernel.org>, "open list:PROC FILESYSTEM"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 12/16] MAINTAINERS: Include dmesg.py under PRINTK entry
In-Reply-To: <20250625231053.1134589-13-florian.fainelli@broadcom.com>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
 <20250625231053.1134589-13-florian.fainelli@broadcom.com>
Date: Thu, 26 Jun 2025 10:49:02 +0206
Message-ID: <84v7oic2qx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-25, Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> Include the GDB scripts file under scripts/gdb/linux/dmesg.py under the
> PRINTK subsystem since it parses internal data structures that depend
> upon that subsystem.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 224825ddea83..0931440c890b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19982,6 +19982,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>  F:	include/linux/printk.h
>  F:	kernel/printk/
> +F:	scripts/gdb/linux/dmesg.py

Note that Documentation/admin-guide/kdump/gdbmacros.txt also contains a
similar macro (dmesg). If something needs fixing in
scripts/gdb/linux/dmesg.py, it usually needs fixing in
Documentation/admin-guide/kdump/gdbmacros.txt as well.

So perhaps while at it, we can also add here:

F:	Documentation/admin-guide/kdump/gdbmacros.txt

John Ogness

