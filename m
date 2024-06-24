Return-Path: <linux-fsdevel+bounces-22276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B182915A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 00:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DFE284B3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 22:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99821A2563;
	Mon, 24 Jun 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M+ii0MEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9847A64;
	Mon, 24 Jun 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269856; cv=none; b=kAIGuzyXaPHO8Si4fD2CB9hm8WbHxnFftBEcCr2DWY1i8HMRXf4K8SeN4fUZtPAJJHkkrdq1703cUlhBK8jXDWKeI8Z119ltUW5RYjerI2Bf7da3iZp5ELXNItp9afkzWRSwN9w64u0g3WZy6rVsCz6I71d/RtyZq9eQZbrVxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269856; c=relaxed/simple;
	bh=EoGCiuCUqCOahZlHGiZn0NU6mzQ3qIP8gF3nsrpABCc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F/erihp7MiPBnS2CeSSpo2QqCZRGh+b+m5/qcs28VY/jUpMPCG39AZHFRjN8E5knbtjzP5OoEMyOC7DpgLQIDb/am47usE1a7BKZWOw4BKvOcvY4/zk725j965ofWnkEmMdJoc1lAkMnoHUaVmlnTr26b2YVGbKpC2E72lueRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M+ii0MEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446C4C2BBFC;
	Mon, 24 Jun 2024 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719269855;
	bh=EoGCiuCUqCOahZlHGiZn0NU6mzQ3qIP8gF3nsrpABCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+ii0MEY3a4aLmXaLBAbJ+qg46e/jNWyjWXNNy6YZ2uredvUQaSOkk1hmlP1/8BXA
	 FJBhL55E22poQrelNPt27QnCIHjromd2chCYd/2oYoW1fqL5ojLpUWWXNDLDc0V5Gb
	 0IO8499jZ7gedxsciTP4QeUfRAzECbUVJRwKLHC0=
Date: Mon, 24 Jun 2024 15:57:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: Audra Mitchell <audra@redhat.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, aarcange@redhat.com,
 rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 1/3] Fix userfaultfd_api to return EINVAL as expected
Message-Id: <20240624155734.c93d8297922575a5b25797e1@linux-foundation.org>
In-Reply-To: <Zng-rfCPvSaGvL7p@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
	<20240621180330.6993d5fd0bda4da230e45f0d@linux-foundation.org>
	<Zng-rfCPvSaGvL7p@x1n>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 11:26:37 -0400 Peter Xu <peterx@redhat.com> wrote:

> > > Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
> > 
> > A userspace-triggerable WARN is bad.  I added cc:stable to this.
> 
> Andrew,
> 
> Note that this change may fix a WARN, but it may also start to break
> userspace which might be worse if it happens, IMHO.  I forgot to mention
> that here, but only mentioned that in v1, and from that POV not copying
> stable seems the right thing.
> 
> https://lore.kernel.org/all/ZjuIEH8TW2tWcqXQ@x1n/
> 
>         In summary: I think we can stick with Fixes on e06f1e1dd499, but we
>         don't copy stable.  The major reason we don't copy stable here is
>         not only about complexity of such backport, but also that there can
>         be apps trying to pass in unsupported bits (even if the kernel
>         didn't support it) but keep using MISSING mode only, then we
>         shouldn't fail them easily after a stable upgrade.  Just smells
>         dangerous to backport.

OK.  And I'll move it into the 6.11-rc1 queue, for the next merge window.

