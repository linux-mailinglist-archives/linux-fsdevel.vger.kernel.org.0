Return-Path: <linux-fsdevel+bounces-59944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712CB3F667
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 09:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41DB3B2272
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C6469D;
	Tue,  2 Sep 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="X921ENld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27918DB0D;
	Tue,  2 Sep 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797327; cv=none; b=VvNEulg7vZYy63HUGUoXi046kUdpYQlVpX7tVffT01ujcNhBmwaDpq6IMdmU8ObLZ16y08rBA3QkIARm/Dvz7e23gxyk1JVIxphKDhBytz8KI+BaX+LqDag6LehQdkev+E/TOO23Ik3j/+U1Ixf+J+Yo889cj8wIJN7vCf7IXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797327; c=relaxed/simple;
	bh=63Ypg42QVZ06s8ykliKTqwl+/W5CTIpV8b7Xr3N12cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFzdm5jLr0zocw9nsdSeklYN9QCW5WlBCGwGIRGLJbtE4459FkhidLnjrPoU62//Ik7IrBoPd2u14/qY4WRFDLvUJu1DDz6L9QEOt3BSMJWWC2QTcHbK1gNF7DGkzzNNZGMcEHYLn5T4roLrNbXzHhYXUb9I+65/43b/0IyDtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=X921ENld; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=75QsosR73EP7Bhx5dXwnnBiSrQlTSAdKIHehZonw/2s=; t=1756797323;
	x=1757402123; b=X921ENldUxkTG2iEalnRJczAydGr+60jnSCemShmum7owLYveZD+utCqGKrDy
	JxsQx+SR98LaDjqI5miAet79XGeKpnPG7pU3BPd3n7/p7jj0zED8JzynlUkYCEXmxO1C+S2YqjUVS
	V5R+cn5H4MJ8GQ5lESC0XBVCeQWyJDgTJO6mH8pHWkK2Ql2ysaeO0po59wRj2FP9QgbfCVp5rkRUo
	QrFBccBSWRKwxSgXOohUG2j8ZgCj04hDsSPMblP/7B1bUN6leCRxM1sThlrpmLA6s9V+5QZfZYVck
	/wq/gloVjZWpqTUN4PorQGEzcaw3hEsFw6JDm7DJLVzjE57ybw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1utLEY-00000000Jm5-12co; Tue, 02 Sep 2025 09:15:14 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1utLEX-00000002jxi-2pMt; Tue, 02 Sep 2025 09:15:13 +0200
Message-ID: <11a4d0a953e3a9405177d67f287c69379a2b2f8f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>,
 schuster.simon@siemens-energy.com,  Dinh Nguyen <dinguyen@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes	 <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka	 <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan	 <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Ingo Molnar	 <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli	 <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>,  Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti	 <alex@ghiti.fr>, Guo
 Ren <guoren@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Jens Axboe
 <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=	 <mkoutny@suse.com>,
 Paul Moore <paul@paul-moore.com>, Serge Hallyn	 <sergeh@kernel.org>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn"	 <serge@hallyn.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mathieu
 Desnoyers	 <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin	
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers	 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, John
 Johansen	 <john.johansen@canonical.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>,  Ondrej Mosnacek <omosnace@redhat.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa	
 <penguin-kernel@I-love.SAKURA.ne.jp>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta	 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian
 Cain	 <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui	
 <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal
 Simek	 <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jonas Bonn	 <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>,  Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller	 <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger	
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Richard
 Weinberger	 <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  Chris Zankel <chris@zankel.net>, Max Filippov
 <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Date: Tue, 02 Sep 2025 09:15:08 +0200
In-Reply-To: <f2371539-cd4e-4d70-9576-4bb1c677104c@gaisler.com>
References: 
	<20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
	 <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
	 <f2371539-cd4e-4d70-9576-4bb1c677104c@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Andreas,

On Tue, 2025-09-02 at 09:02 +0200, Andreas Larsson wrote:
> On 2025-09-01 15:09, Simon Schuster via B4 Relay wrote:
> > From: Simon Schuster <schuster.simon@siemens-energy.com>
> >=20
> > With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> > clone3") the effective bit width of clone_flags on all architectures wa=
s
> > increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> > However, for most consumers of clone_flags the interface was not
> > changed from the previous type of unsigned long.
> >=20
> > While this works fine as long as none of the new 64-bit flag bits
> > (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is stil=
l
> > undesirable in terms of the principle of least surprise.
> >=20
> > Thus, this commit fixes all relevant interfaces of the copy_thread
> > function that is called from copy_process to consistently pass
> > clone_flags as u64, so that no truncation to 32-bit integers occurs on
> > 32-bit architectures.
> >=20
> > Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> > ---
>=20
> Thanks for this and for the whole series! Needed foundation for a
> sparc32 clone3 implementation as well.

Can you implement clone3 for sparc64 as well?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

