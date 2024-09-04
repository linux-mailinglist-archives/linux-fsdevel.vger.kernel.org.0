Return-Path: <linux-fsdevel+bounces-28559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22D96BFDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2895C1F2646B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BB91DC041;
	Wed,  4 Sep 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ltEJ6AK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724A1DB53F;
	Wed,  4 Sep 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459426; cv=none; b=hnqdskidRVaqFC2WgsXiDL4bcrg50ERngI8wEE0JpEWvxx8uGWiTx8hX26SzkeWI6vT/VD2dkDj5q4GPXE+wcSCSTWXImGFYvvc86JTfyuL5by1PqnDI+3S3DoOq4Is284np0lBQlQO8YAKhEH/7JavsYkLHd+Cr8+lRL04lBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459426; c=relaxed/simple;
	bh=PxUHbQeEumoCJfWHHMr56fEbNumjfbwbEqTpDJ0QTYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOTXwka+syQ+/nELKbL0L6mIG5QxUCuJBvCZi5PijHBdELNKiRIdOIlJVT+8rNbpVAWdXJ2QWYGNNaM34G949HpBJrUva+91DnuiIgsbzTDfTBUniiWMIW/Qzi7wB1HbJDpJAsVMJIB8SY4jBM3Yhe9m0aj+VME9CnTSEW1uR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ltEJ6AK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D7BC4CEC2;
	Wed,  4 Sep 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ltEJ6AK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725459422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0gX4iKFO2d6giGBiJdj/U8E7BIuEXsYx2gfWhptxDWU=;
	b=ltEJ6AK0bHrwJ9RXlZ516PTeVUtSiUL7yGEtQLnYEjyD1A1U1r0m+mgYrevZkKv2SDRcnb
	YkcfwwvWKQHO67NklnaO03mC/TAAJUP+XqDWQ00JUD/4WMIVCqL7ugAMEJq23lFeUZtWsB
	GaTlLQGomeGWPBvK1KOIbdDK5n9Hp3Y=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19554c25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:17:02 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:16:54 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v5 0/5] Wire up getrandom() vDSO implementation on powerpc
Message-ID: <Zthr1nB_RJ56YD3O@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725304404.git.christophe.leroy@csgroup.eu>

Hi Christophe, Michael,

On Mon, Sep 02, 2024 at 09:17:17PM +0200, Christophe Leroy wrote:
> This series wires up getrandom() vDSO implementation on powerpc.
> 
> Tested on PPC32 on real hardware.
> Tested on PPC64 (both BE and LE) on QEMU:
> 
> Performance on powerpc 885:
> 	~# ./vdso_test_getrandom bench-single
> 	   vdso: 25000000 times in 62.938002291 seconds
> 	   libc: 25000000 times in 535.581916866 seconds
> 	syscall: 25000000 times in 531.525042806 seconds
> 
> Performance on powerpc 8321:
> 	~# ./vdso_test_getrandom bench-single
> 	   vdso: 25000000 times in 16.899318858 seconds
> 	   libc: 25000000 times in 131.050596522 seconds
> 	syscall: 25000000 times in 129.794790389 seconds
> 
> Performance on QEMU pseries:
> 	~ # ./vdso_test_getrandom bench-single
> 	   vdso: 25000000 times in 4.977777162 seconds
> 	   libc: 25000000 times in 75.516749981 seconds
> 	syscall: 25000000 times in 86.842242014 seconds

Looking good. I have no remaining nits on this patchset; it looks good
to me.

A review from Michael would be nice though (in addition to the necessary
"Ack" I need to commit this to my tree), because there are a lot of PPC
particulars that I don't know enough about to review properly. For
example, you use -ffixed-r30 on PPC64. I'm sure there's a good reason
for this, but I don't know enough to assess it. And cvdso_call I have no
idea what's going on. Etc.

But anyway, awesome work, and I look forward to the final stretches.

Jason

