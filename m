Return-Path: <linux-fsdevel+bounces-22238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9C914DC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A49B23B78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95913D526;
	Mon, 24 Jun 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hj8g+3Oo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCi/NfA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4E1E868;
	Mon, 24 Jun 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233591; cv=none; b=rh7WCkuRvxT1sXT14/zKzJYs+ND4uE0/MhrwKEZCj6R7pMjEuAQr6w+cyVIHyzCeTmh9Q1PH3NzCP5GJ5BfDzQ4oFwWC4NyMLMA62VjdxIrkwAYGB9zT3S+xXFEYojb5xxYjM6TXZBSJt87ODagm509Y0bfbWmLF9N1tSCzSrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233591; c=relaxed/simple;
	bh=gkOCJdJk+yKTW4RqeE1LxGsDvjSflGa8F/6v/0JODbY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=F1bLJsyUCvUJDZYviBF19UzMOkleWyLVIZGnhLXnyYeBxXPxoMZAgp3VxixgLxqcyZMG3pXyFK+aUUbsCkH/cq2KdLkUQ1kets2TvWwURsHlDVnM1TdtA+TzxnWlZ5CZiEDQq+erlWQT75g5RJv6nadLDpRy8MrP+kPS8uo9tOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hj8g+3Oo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCi/NfA7; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F9E313801B5;
	Mon, 24 Jun 2024 08:53:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 24 Jun 2024 08:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719233588; x=1719319988; bh=xWKRucLiTm
	pWwmmRX8FZ+pQR2gzXCPeFFp5WbUeFfbU=; b=hj8g+3OooVka8gNBjbWNY0qyAL
	Z6vhvHJoz9J9I0++1woXG7Ge7EifFpbLdlmvrkBZicJ0Vuzhe4E65yfemaw0dpnz
	ezbi2d09aLDF7ImuAp7ePDjUCcxqHHTdYBm1BZek/TB0JoKaPQYXQIQoZ6Ju8mOB
	wJHI0OVjjjp4u23oFnNEB7nzInWRR+TgaFrQTVv59rGbcP+I49knsJba70p5D5dX
	Q5dWWoC06j/c71Hvbmvv7UXEBlX1BHogMWVK0cFu3TYfKqxJtX6AOJv/ZHj8k8Wz
	mczS6v5JUo7LbjeTVmLp9rK2m7s3ayQKBQJwHt4h6ceJB75BnOFzmPxvTpcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719233588; x=1719319988; bh=xWKRucLiTmpWwmmRX8FZ+pQR2gzX
	CPeFFp5WbUeFfbU=; b=ZCi/NfA7A/RQ9uffYWdnOth3zq0Nr7nYZ6oyyv9JWPOj
	xm28gfJIalTQ9/Kdb3z5NDEv5ViTQHpwDzh6N2EeBHUDTVkRXgciUBMMS7AkgJUj
	m/mZbf+ejaW10hmpd2gpqA98HnK/cBDtPVX3x7KTkifmry6qtJLpqiIaPkXjblZ4
	K7U1Q9y0NRupMUuTkp76UIKEdKjVDI2+kJz8w5XDLyPvrBl9f3pDL8siN6LnFZYc
	NHOsGh9Hg19uIehl2i3Z+NCBcSIcICMOlvBqO5de2EYJe0DcK20O5S+BIXOjPhfU
	Ags7pPfYnlnunrnOo2Ffj4stHt2oG0X14wweQw4qyQ==
X-ME-Sender: <xms:NGx5ZiVg1gGRlt9ve2AaCtdW00-4mkL4YYmnOlzPKKmgIemKoVjYew>
    <xme:NGx5ZulJumI0JaGXmMii6JT6fzQIe9Qzlss726rjLTBIdsG1udtt43SlcJaGFmM4z
    _U7v720kyBtwitGg-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:NGx5ZmYm5Y8_qZxXMutSnpZE-wAmIMkn8Co-Mc0N0PmSj90GZrpw9g>
    <xmx:NGx5ZpVp_EN-CxgbfK-hH9-RsnW40Aj5LDE45CtCcZJj11OxT0IahQ>
    <xmx:NGx5ZsmW9IB7O6E2KjShAvsf5qyGRubEB8ghp8lTi4rt0SC82Pq-OQ>
    <xmx:NGx5Zudlz3chAaIISEKXN8oIN5P3itL3KhonJd_OA7jWYnsbt1Oh_g>
    <xmx:NGx5ZnCn48KYTyY9DzCFIK7ydsxiaLAQcCK1tdYkGjcqKFPdDXZkeYYz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 47B3CB6008D; Mon, 24 Jun 2024 08:53:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b31072d5-865b-4cda-be37-d93c36397d39@app.fastmail.com>
In-Reply-To: <20240620162316.3674955-3-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-3-arnd@kernel.org>
Date: Mon, 24 Jun 2024 14:52:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, "Helge Deller" <deller@gmx.de>,
 linux-parisc@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "Brian Cain" <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org, guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Xi Ruoyao" <libc-alpha@sourceware.org>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 "LTP List" <ltp@lists.linux.it>, stable@vger.kernel.org
Subject: Re: [PATCH 02/15] syscalls: fix compat_sys_io_pgetevents_time64 usage
Content-Type: text/plain

On Thu, Jun 20, 2024, at 18:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Using sys_io_pgetevents() as the entry point for compat mode tasks
> works almost correctly, but misses the sign extension for the min_nr
> and nr arguments.
>
> This was addressed on parisc by switching to
> compat_sys_io_pgetevents_time64() in commit 6431e92fc827 ("parisc:
> io_pgetevents_time64() needs compat syscall in 32-bit compat mode"),
> as well as by using more sophisticated system call wrappers on x86 and
> s390. However, arm64, mips, powerpc, sparc and riscv still have the
> same bug.
>
> Changes all of them over to use compat_sys_io_pgetevents_time64()
> like parisc already does. This was clearly the intention when the
> function was originally added, but it got hooked up incorrectly in
> the tables.
>
> Cc: stable@vger.kernel.org
> Fixes: 48166e6ea47d ("y2038: add 64-bit time_t syscalls to all 32-bit 
> architectures")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/unistd32.h         | 2 +-
>  arch/mips/kernel/syscalls/syscall_n32.tbl | 2 +-
>  arch/mips/kernel/syscalls/syscall_o32.tbl | 2 +-
>  arch/powerpc/kernel/syscalls/syscall.tbl  | 2 +-
>  arch/s390/kernel/syscalls/syscall.tbl     | 2 +-
>  arch/sparc/kernel/syscalls/syscall.tbl    | 2 +-
>  arch/x86/entry/syscalls/syscall_32.tbl    | 2 +-
>  include/uapi/asm-generic/unistd.h         | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

The build bot reported a randconfig regressions with this
patch, which I've now fixed up like this:

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d7eee421d4bc..b696b85ac63e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -46,8 +46,8 @@ COND_SYSCALL(io_getevents_time32);
 COND_SYSCALL(io_getevents);
 COND_SYSCALL(io_pgetevents_time32);
 COND_SYSCALL(io_pgetevents);
-COND_SYSCALL_COMPAT(io_pgetevents_time32);
 COND_SYSCALL_COMPAT(io_pgetevents);
+COND_SYSCALL_COMPAT(io_pgetevents_time64);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);

This was already broken on parisc the same way, but the
mistake in sys_ni.c turned into a link failure for every
compat architecture after my patch.

      Arnd

