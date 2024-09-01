Return-Path: <linux-fsdevel+bounces-28147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F027967622
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28A7B210B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58945168C20;
	Sun,  1 Sep 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oPxs4d9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F24D8AF;
	Sun,  1 Sep 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725189436; cv=none; b=r/n92oNEt+L9+E5b/QvKCdePOZM9yJ/Nl/8pjl4MaZCcVL09CP0EPMVWk2aDYSa01qYIb0OI8kmONDjHd2TMQ+jTbpaYz1/h2CuM4YQT+FXMXL1/bm7bPSCt3L666tBGopuWscQCIim3DJL2zOvEuEwRFsDFSVIx+nUyXWj9pRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725189436; c=relaxed/simple;
	bh=12cWuQ7mup9YTSiqwEKWyZdMv05ZO0xRLyuLQm0ks/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1EPX2z2Q3FuvDNbCb67DzZyN4RTD96X0UKu1l74ABgUz+UXZM7VBTR3ycjWuopHB0uWH+jIwUD+PLceypyFUJDPeIbk2M7J2LtiQpSwowpUgGMJKHpw7tVLBpOrFVIfBU7TNWLU0hIelhhC8K83dem7T+cixaEkkEO67zkTtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=oPxs4d9/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725189425;
	bh=12cWuQ7mup9YTSiqwEKWyZdMv05ZO0xRLyuLQm0ks/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oPxs4d9/PVThgd1vK3IHuP418JsvF/KuFs3uGnIiPI0SXxmT1DMemyoAckEdH3ccV
	 VYXU6v2evRZ8gsVzKQPhPhPQZXIChDv5R2rm2AwwD6kzu9/8N/PEtOeTYcHIdLrt8t
	 IXUukjkUMXx3Ni8RuqjJtU69mcoErckGRG2WkEdduYTDMVurBWlA7ROh3XXmoPgvtP
	 Q8UcO5zp2+RQNklj0buJqHJSvaPt5XpgK5osQoruTVDMaBCXWo5lDMJpQSRzuHY6Ri
	 gtBx6d0oRek5+QR+s3HXcKhq3+7x2+N+dOsu1cmp4MnUnJMY8fuhi2JSxpqLVv4B8w
	 7S8gWegPke53w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WxTqg3yTGz4wyR;
	Sun,  1 Sep 2024 21:17:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Morton
 <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Shuah Khan
 <shuah@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v3 1/5] mm: Define VM_DROPPABLE for powerpc/32
In-Reply-To: <a0454ec1a8ab3455abc8205357681eaa685cd49b.1725031952.git.christophe.leroy@csgroup.eu>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
 <a0454ec1a8ab3455abc8205357681eaa685cd49b.1725031952.git.christophe.leroy@csgroup.eu>
Date: Sun, 01 Sep 2024 21:17:02 +1000
Message-ID: <87bk17ei8h.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always
> lazily freeable mappings") only adds VM_DROPPABLE for 64 bits
> architectures.
>
> In order to also use the getrandom vDSO implementation on powerpc/32,
> use VM_ARCH_1 for VM_DROPPABLE on powerpc/32. This is possible because
> VM_ARCH_1 is used for VM_SAO on powerpc and VM_SAO is only for
> powerpc/64.

Also, there can't be any existing users of VM_SAO on 32-bit, because PROT_SAO
(which maps to VM_SAO) is only accepted on CPUs that support SAO, and
those CPUs are all 64-bit.

cheers

