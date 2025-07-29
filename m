Return-Path: <linux-fsdevel+bounces-56289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB45EB15553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5680918A5CDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEEE2853F9;
	Tue, 29 Jul 2025 22:36:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529D19066D;
	Tue, 29 Jul 2025 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828570; cv=none; b=rQm81iq8kk1/F7TNCZj4p33afJ8MhBMk1w0ZwJKBDGoQol57rO8HCkWFvMA3s+LPpv4iICxfSaDdMGRi/vCFVtNcf1WHVcIPks0KvTwD4168wZIVyBCMlT3vPf6N1cRyyhwIutBPOYW1+AaF0XSHDpbbJvryacsH8GmS+T3XXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828570; c=relaxed/simple;
	bh=g8GPfvhrR7jlhmr1UZtFief6T+T27wiLMRn9jVtYyR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axcJwzO0uEEkH3BXXkMl75rQgpS30qbhfeUvJChTAJ1DUPRUtAr+3jVCQvjLM8vJEOhrN58Nqb8lsW71HKaLjvx9v7itOfzbr5noDq31MSXg2XcsKnLx1O6wIPB2wLGyN9qecRyoo+VuJxZ6JvoSFSEyU0/91fXhduSTqWWLUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DDF7580144;
	Tue, 29 Jul 2025 22:35:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 0B5B020026;
	Tue, 29 Jul 2025 22:35:33 +0000 (UTC)
Date: Tue, 29 Jul 2025 18:35:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, pratyush@kernel.org, jasonmiu@google.com,
 graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
 dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
 yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
 chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
 jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
 dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org,
 anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
 linux@weissschuh.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
 bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
 myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
Message-ID: <20250729183548.49d6c2dc@gandalf.local.home>
In-Reply-To: <20250729222157.GT36037@nvidia.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
	<20250723144649.1696299-32-pasha.tatashin@soleen.com>
	<20250729161450.GM36037@nvidia.com>
	<877bzqkc38.ffs@tglx>
	<20250729222157.GT36037@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mbmeeobytwf41p4yzc1dpzpwpxe8yucf
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0B5B020026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+oxtVU63xhP93/SX7bTvd4Dc8QYczFFgk=
X-HE-Tag: 1753828533-748000
X-HE-Meta: U2FsdGVkX1+SVp31L1zEXDG37UVtXoqm70naJW/igIWLrqvmCMEotY5CNRw8dlWDmbUGblNWLe3J9LSKx3hR7L2bQHS5MLhDZ3emhsQZAH8j7he0OBxdHTorWq/tTuIqRvjhOa/pfZhAhrck9wMmroKYmqPDxhcpTqRWDwl3ysMHv7F9H46Msn44g621nxUht5mjN6sz+uKsXXe5sPbrM8NTysSEAUlypv2dGg+JNutKu9XUZ3I+Gxf2ECBE3SxAmB4Vt+rW88Ro0YDc/TOQ3u/BFhWkbWO5mlIrZN6SFp3smVSeUdWdFCHFOoEqQ490+r4zBLenTW7Tcba5bSWwe799mBO+144r

On Tue, 29 Jul 2025 19:21:57 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> > As this is an evolving mechanism, having the corresponding library in
> > the kernel similar to what we do with perf and other things makes a lot
> > of sense.  
> 
> If we did this everywhere we'd have hundreds of libraries in the
> kernel tree and I would feel bad for all the distros that have to deal
> with packaging such a thing :(
> 
> It is great for development but I'm not sure mono-repo directions are
> so good for the overall ecosystem.

I have to agree here. When libtraceevent was in the kernel, it was a pain
to orchestrate releases with distros. When it was moved out of the kernel,
it made it much easier to manage.

The main issue was versioning numbers. I know the kernel versioning is
simply just "hey we added more stuff" and the numbers are meaningless.

But a library usually has a different cycle than the kernel. If it doesn't
have any changes from one kernel release to the next, the distros will make
a new version anyway, as each kernel release means a new library release.

This luoctl.c isn't even a library, as it has a "main()" and looks to me
like an application. So my question is, why is it in tools/lib?

-- Steve

