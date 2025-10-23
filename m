Return-Path: <linux-fsdevel+bounces-65329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F146CC01879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75841881D51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318D315778;
	Thu, 23 Oct 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqry/oZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A2274B44;
	Thu, 23 Oct 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227134; cv=none; b=Cgp5gVp2i5SsHhJIficR8qHZgI1QS82yHlTZPqmBUzOLY3/BeRyLZP3Ql/YQfbKtCjzgXjOuVbNZRjAtyzOz9YTnw7yUcmxi/BX4zqcDav/muiov0bbOmcRPXSg1Gdr0XrsMeUXTNGad1LBO3coubvdEaaSRPqTOELjZS4T3dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227134; c=relaxed/simple;
	bh=Qt0yuLtw66ZCq3MNXemX3SqZ1fs/KSoTjGU3m7F/lGU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Nz1Nds7wH4uRAkB/Y2qvCCLnAgsRAXfbcKAVjQh04crOcGSsUHK+66DVjwNd5ugGBVu8VOmQcOeu4exVLc0jBjEO2S8XwPLdzZ6d49yHVmU3I1jNgM6pzv3Ci6CcTPPSi5lhq9HaVHa1aTYgHOfQnRf78o26nttrSQzOGc6pcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqry/oZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAE1C4CEE7;
	Thu, 23 Oct 2025 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227133;
	bh=Qt0yuLtw66ZCq3MNXemX3SqZ1fs/KSoTjGU3m7F/lGU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=aqry/oZOTZd9CJW0T1mbAjhDHMQymTpNckh+GWm7OhJL7taGKQO86I6R/hOMTvSLY
	 SLQwYmdq9UC6n9K9AkFm+Nvyzxi5b8e+9+osbpQX5BShUU9QdcQ+v8F6pSpG9PniuG
	 oUZk0Y+fHvu/ZNQFQ7nocyD6QlSowiSBs9S9N1g3hRNqx8RojGuIxfVNmm+geOuAr4
	 2O+c9VqjUcEZ7HLlt0a2npyasTsyO0GEn9wPHaJtwJXzedJENFwyp2ryhKgSO04KCY
	 OA+CjmtFBeClA+d+2GHP2VgmjDM0CFOQCgp2oFwtauWtxYiGPFgRl+dtL6VRkp9oMW
	 UZyY2aff/AhLg==
Date: Thu, 23 Oct 2025 06:45:31 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
CC: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Marco Elver <elver@google.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Johannes Weiner <hannes@cmpxchg.org>, llvm@lists.linux.dev,
 Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Nicolas Schier <nicolas.schier@linux.dev>, Shuah Khan <shuah@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tamir Duberstein <tamird@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
 kernel test robot <lkp@intel.com>, Heiko Carstens <hca@linux.ibm.com>,
 Uros Bizjak <ubizjak@gmail.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Yafang Shao <laoar.shao@gmail.com>,
 Marc Herbert <Marc.Herbert@linux.intel.com>,
 Christopher Ferris <cferris@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
 Jeff Xu <jeffxu@chromium.org>,
 =?ISO-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] compiler_types: Introduce __counted_by_ptr()
User-Agent: K-9 Mail for Android
In-Reply-To: <20251023080123.GU3245006@noisy.programming.kicks-ass.net>
References: <20251020220005.work.095-kees@kernel.org> <20251020220118.1226740-1-kees@kernel.org> <20251021095447.GL3245006@noisy.programming.kicks-ass.net> <202510211210.84D670D1C@keescook> <202510221746.7C09BBE@keescook> <20251023080123.GU3245006@noisy.programming.kicks-ass.net>
Message-ID: <1D53887A-B277-4813-A3E6-9367CCFC8759@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 23, 2025 1:01:23 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg=
> wrote:
>On Wed, Oct 22, 2025 at 05:47:43PM -0700, Kees Cook wrote:
>> On Tue, Oct 21, 2025 at 12:24:05PM -0700, Kees Cook wrote:
>> > On Tue, Oct 21, 2025 at 11:54:47AM +0200, Peter Zijlstra wrote:
>> > > > [=2E=2E=2E]
>> > > > Unfortunately, this annotation cannot be used for "void *" member=
s
>> > > > (since such a member is considered a pointer to an incomplete typ=
e,
>> > > > and neither Clang nor GCC developers could be convinced otherwise=
[1],
>> > > > even in the face of the GNU extension that "void *" has size "1 b=
yte"
>> > > > for pointer arithmetic)=2E For "void *" members, we must use the =
coming
>> > > > "sized_by" attribute=2E
>> > >=20
>> > > So why do we need both __counted_by_ptr() and this __sized_by(), wo=
n't
>> > > one be good enough?
>> > [=2E=2E=2E]
>> > Let me take another stab at it=2E=2E=2E
>>=20
>> It seems this will be acceptable as long as it is gated by GNU
>> extensions=2E
>
>Excellent!
>
>> GCC patch in progress=2E Clang PR here:
>> https://github=2Ecom/llvm/llvm-project/pull/163698
>
>I think you've got your link mixed up, this appears to be arm-kcfi (also
>good ofc)=2E Either that, or I need copy/paste lessons=2E
>
>This one?
>
>  https://github=2Ecom/llvm/llvm-project/pull/164737

Whoops, yes, that's the one! Seems I'm the one needing those lessons=2E ;)


--=20
Kees Cook

