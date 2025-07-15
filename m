Return-Path: <linux-fsdevel+bounces-54903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA0B04D00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 02:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562C61AA3141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46631D516C;
	Tue, 15 Jul 2025 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BiyNIZbI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6019343B;
	Tue, 15 Jul 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539472; cv=none; b=gTxzr+2uHNgyPG+KPzggivulUZNKt9H8h7f9z9rDIdpYU1J1MZhT6kZZhh4pfgm6c+NhbiyXy7bR6hRPki4z6Em/QYsJi2288fP19MJS93YfU1+taOWbcMztr70hwsER4Cq0sPf1A1q0bTG7kajTGJKBmCd9WLqln5yJphMgACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539472; c=relaxed/simple;
	bh=AmsDUkdWp+D2t1MNpQN905rUeQWgnBNIiuKOAQBsbnY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QQEje4D5eBZMKujgo7MXZwaitfvBbEhcKpcdK8AXNeVEITdZhUA+fNvYIUh4C2xp2bRu3Nn905w4wpaD0pY83uHap6e/+8ife7BZENAYVIBpb1nAltNw+VMM9DSmcAL232Gt8+IHohN4X5M7u5XZz6Npbid+YydOkBvHH+X1UMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BiyNIZbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC19C4CEF0;
	Tue, 15 Jul 2025 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752539470;
	bh=AmsDUkdWp+D2t1MNpQN905rUeQWgnBNIiuKOAQBsbnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BiyNIZbIhI81BH5kvc3pxIN4vczjERj5q7uQi3I+U4ljGTnuTerwVbUVigGrpSFpC
	 MoCTw9QY8OtZzzVMkMmhnQ2bJiG1tfOatf+XrDVBsdemRGr6j3KuR/xhvu9dbzUkm0
	 QSq7uz3kVbgkEwgjl2V2NCquwQcLtqQa6kM4E7oM=
Date: Mon, 14 Jul 2025 17:31:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 "David S. Miller" <davem@davemloft.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/Kconfig: Enable HUGETLBFS only if
 ARCH_SUPPORTS_HUGETLBFS
Message-Id: <20250714173109.265d1fbfa9884cd22c3a6975@linux-foundation.org>
In-Reply-To: <20250714094909.GBaHTSlW8nkuINON9p@fat_crate.local>
References: <20250711102934.2399533-1-anshuman.khandual@arm.com>
	<20250712161549.499ec62de664904bd86ffa90@linux-foundation.org>
	<f86c9ec6-d82d-4d0c-80b2-504f7c6da22e@arm.com>
	<20250714094909.GBaHTSlW8nkuINON9p@fat_crate.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 11:49:09 +0200 Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Jul 14, 2025 at 08:05:31AM +0530, Anshuman Khandual wrote:
> > The original first commit had added 'BROKEN', although currently there
> > are no explanations about it in the tree.
> 
> commit c0dde7404aff064bff46ae1d5f1584d38e30c3bf
> Author: Linus Torvalds <torvalds@home.osdl.org>
> Date:   Sun Aug 17 21:23:57 2003 -0700
> 
>     Add CONFIG_BROKEN (default 'n') to hide known-broken drivers.

Thanks.  That was unkind of someone.  How's this?


From: Andrew Morton <akpm@linux-foundation.org>
Subject: init/Kconfig: restore CONFIG_BROKEN help text
Date: Mon Jul 14 05:20:02 PM PDT 2025

Linus added it in 2003, it later was removed.  Put it back.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 init/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- a/init/Kconfig~a
+++ a/init/Kconfig
@@ -169,6 +169,10 @@ menu "General setup"
 
 config BROKEN
 	bool
+	help
+	  This option allows you to choose whether you want to try to
+	  compile (and fix) old drivers that haven't been updated to
+	  new infrastructure.
 
 config BROKEN_ON_SMP
 	bool
_


