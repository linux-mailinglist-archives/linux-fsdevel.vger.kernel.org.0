Return-Path: <linux-fsdevel+bounces-65267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C23BFEC24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 069234E7C0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4F91B4156;
	Thu, 23 Oct 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8kpsJdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7535971;
	Thu, 23 Oct 2025 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761180464; cv=none; b=sXP+DUQmNf6poApR+Ui5V4w5gNlGyyBK1L8mynlDSiCx+giZDJ4U8wm+vecXf/M3tLH+HKzx39B04U3vUFZklhfPVRfokRVwd0NHzGAlx7ginMmFMLtfPPQ08G2+6tnrNpsUMtPcTe+zthnaPcT9+dUQOVlMJjqpsPP0ZI+Y/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761180464; c=relaxed/simple;
	bh=x9rSFwmVcc1dqviTA6H/hsJMHWMdaIFdGDx7xFW94uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFmXG/uZfg2RvoZznKZHqLUMsmQHX8ENqd+PHVUrJ/A6Wj2g3407zEbePuMQmZ+Jie4XAvGog5AJ2SF/xF6m+Q4Oz4bQ71pgWtiZ1IRCZ+OZReenVFg7K/C8tNrfSueXiU2eP3N7LM1nJfk3yXz0O2UscMJfjcppTINmU/tMmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8kpsJdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DA9C4CEE7;
	Thu, 23 Oct 2025 00:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761180464;
	bh=x9rSFwmVcc1dqviTA6H/hsJMHWMdaIFdGDx7xFW94uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8kpsJdF4vUC1ysDarElbHTVBNPhQ4Os5dHN8IFNM36jK6EYrm0/27DnzrFm6FqBw
	 ICkkcf2X0ed/Ch5CddqCNMblqtvRvRvRJd0vNiz7aNjcGZroYxm0qt2vFydOLoL14c
	 oztNEWWSPZLJYjhMG6SAepWYWAnBGXgX9BXpuFikHw1lF5HpFLXgB3Pc0fnpyjQPH5
	 OacjHZ1jODozGTrtkFMPjlTE1WfmdfqtrTpjEwst8ncCRH2KClWMwCQ+pE3Pj4V7zb
	 /f6kL8pWuUcYyvSkDIYiQo48r2CY2oQOlgg7dqLuoU2IWC7k1mH28oxtPkrVR746ME
	 F7hdchGd36MgA==
Date: Wed, 22 Oct 2025 17:47:43 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Tamir Duberstein <tamird@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	kernel test robot <lkp@intel.com>,
	Heiko Carstens <hca@linux.ibm.com>, Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Yafang Shao <laoar.shao@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Christopher Ferris <cferris@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] compiler_types: Introduce __counted_by_ptr()
Message-ID: <202510221746.7C09BBE@keescook>
References: <20251020220005.work.095-kees@kernel.org>
 <20251020220118.1226740-1-kees@kernel.org>
 <20251021095447.GL3245006@noisy.programming.kicks-ass.net>
 <202510211210.84D670D1C@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510211210.84D670D1C@keescook>

On Tue, Oct 21, 2025 at 12:24:05PM -0700, Kees Cook wrote:
> On Tue, Oct 21, 2025 at 11:54:47AM +0200, Peter Zijlstra wrote:
> > > [...]
> > > Unfortunately, this annotation cannot be used for "void *" members
> > > (since such a member is considered a pointer to an incomplete type,
> > > and neither Clang nor GCC developers could be convinced otherwise[1],
> > > even in the face of the GNU extension that "void *" has size "1 byte"
> > > for pointer arithmetic). For "void *" members, we must use the coming
> > > "sized_by" attribute.
> > 
> > So why do we need both __counted_by_ptr() and this __sized_by(), won't
> > one be good enough?
> [...]
> Let me take another stab at it...

It seems this will be acceptable as long as it is gated by GNU
extensions. GCC patch in progress. Clang PR here:
https://github.com/llvm/llvm-project/pull/163698

-- 
Kees Cook

