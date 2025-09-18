Return-Path: <linux-fsdevel+bounces-62150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B4B85C87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC1F7A11D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB42313D47;
	Thu, 18 Sep 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAxccBgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B3314D13;
	Thu, 18 Sep 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210677; cv=none; b=NWhNupRl+9BBIZ+pdOOUQOTqUjiMUoq+mQ+HbPJgntjPA069sf9lMnIOiOUpgJohdB6CvolhyJusNnqMu9A5ryQmEXPLX/vQTx9QZg8KK2gx0BOtm+TAVSVq9cMgdXNaFpZ61CeLDhwjCzY/sTXftmj52d85q7sk+9GRI4v7XHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210677; c=relaxed/simple;
	bh=e6XJbeklgFNXwruDywAZe7vowNbZUbwBKpZS63m54og=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YSXPJ3tti4lzkiCYhxc0Ef9l4a45T2AaiS3YIu3rV2l6gSZjk2hbT3NWkxesZyTWif7TcAG9xmzoUmtbJY53E1lshvud4Q0H5VZlWgUqqa5VJuzutYgXiLZoWAhu6axDN3LmWCi8F76DOdapIAdSeYxB/bLyd+PxM6opRJaE4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAxccBgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77DBC4CEE7;
	Thu, 18 Sep 2025 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210677;
	bh=e6XJbeklgFNXwruDywAZe7vowNbZUbwBKpZS63m54og=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lAxccBgHQJMGKL6W5XO/kIBHMi2AladIz8qPWx4MBG7gpBrzHZckIimBwgkALGSoK
	 RTpLe7661eFC5B/7BhfypSLu8ciNLbjbhnW0/Uiw7F9qtuf/K/hOn+NGzmTK4Elius
	 Puw/h1XtP570vHRTCm/o6CmMUjRekyChiJ42E7YZlGDJw6uFwLqKV4izLQfNVxc+1W
	 3GgwOdBMEpO6bPhXxyYgbuGAlwFII7VeYUA20OL3bsW1JzfLATB4CEE7Um16odYOB9
	 O8FOQqOy+9iE5VgV50GipK6qrDd5viCwdSnAqnhpyMVlV7VT8suWp23kcrZWa2l0BA
	 qFbk69uCk7f8g==
Date: Thu, 18 Sep 2025 09:51:07 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Simon Schuster <schuster.simon@siemens-energy.com>
cc: Dinh Nguyen <dinguyen@kernel.org>, Christian Brauner <brauner@kernel.org>, 
    Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
    Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
    Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
    Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
    Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
    =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>, 
    Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
    James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
    Anna-Maria Behnsen <anna-maria@linutronix.de>, 
    Frederic Weisbecker <frederic@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    John Johansen <john.johansen@canonical.com>, 
    Stephen Smalley <stephen.smalley.work@gmail.com>, 
    Ondrej Mosnacek <omosnace@redhat.com>, 
    Kentaro Takeda <takedakn@nttdata.co.jp>, 
    Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
    Russell King <linux@armlinux.org.uk>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
    WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Michal Simek <monstr@monstr.eu>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Jonas Bonn <jonas@southpole.se>, 
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
    Stafford Horne <shorne@gmail.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
    Max Filippov <jcmvbkbc@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
    linux-csky@vger.kernel.org, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, 
    linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    apparmor@lists.ubuntu.com, selinux@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
    linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, 
    loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
    linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
    sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
In-Reply-To: <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
Message-ID: <ffb22e54-6b7d-5b88-4217-e67870051c6e@kernel.org>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com> <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Sep 2025, Simon Schuster via B4 Relay wrote:

> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> However, for most consumers of clone_flags the interface was not
> changed from the previous type of unsigned long.
> 
> While this works fine as long as none of the new 64-bit flag bits
> (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is still
> undesirable in terms of the principle of least surprise.
> 
> Thus, this commit fixes all relevant interfaces of the copy_thread
> function that is called from copy_process to consistently pass
> clone_flags as u64, so that no truncation to 32-bit integers occurs on
> 32-bit architectures.
> 
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>

Acked-by: Paul Walmsley <pjw@kernel.org> # for RISC-V

Thanks!


- Paul

