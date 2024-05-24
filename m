Return-Path: <linux-fsdevel+bounces-20083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F898CDF9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 05:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F29A1F21B0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C242E3E9;
	Fri, 24 May 2024 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mtzM/RNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379932C9A;
	Fri, 24 May 2024 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716519750; cv=none; b=psf4LWQgCoWLP1F46grxA5aAyS0xdv8dLrvu51bkVNx9gVEbOfW5573FvBD/JrWmDBmDY6KjmnzFLaUtdAt3EriwYGiHouVVGyy9rp5a/N0UOYCWZlaGh7k8Fz8WxSkIn5T7+ecGanoZqCRHjqeLDpfJLDSyO9j7WRLi09CEba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716519750; c=relaxed/simple;
	bh=UqaAqn/5AQ9qU6fVaXfOjyWzrKVks76At49JNqcdI3k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qL0oATGNu3gxDMQdrDJrkgLF4ZdFpjJotNi/0MAPblAahvwv6psBJUMDPzN35IMtSHXovUigPApmk2tn2Q7Z53NfyCtA1PglgS/M6O7nuE+xkzjcel5ig1Rem8jgu0OnbYDkCfKFt4CkzQZNkG8WiJuwtWr1iCJdjyhl5e8TI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mtzM/RNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829B3C32781;
	Fri, 24 May 2024 03:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716519749;
	bh=UqaAqn/5AQ9qU6fVaXfOjyWzrKVks76At49JNqcdI3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mtzM/RNC6LPlo6QwCZDa7BwE1zCNweNBrAIKwARlEo5khM2vdPDiikPmJCATKwcoV
	 edlxV/XwN8TFaHWmiOJxAFIYiuxdtUcixnFvZT9SDz50qGM/Cen/KPRVl3Ok9tWtYI
	 6LRWEAUjsg6sb9zjBJjRsO+R279HIsHvwsOvKUNI=
Date: Thu, 23 May 2024 20:02:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Mohamed Khalfella
 <mkhalfella@purestorage.com>
Subject: Re: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after
 getting mmap_lock again
Message-Id: <20240523200228.fdaa0319d3fd4bd7a62f7f8a@linux-foundation.org>
In-Reply-To: <CA+AMecHUo-sPy5wDszWgX5BWPAqMwrXqCWO1jGE5uMRq2U=BVw@mail.gmail.com>
References: <20240523183531.2535436-1-yzhong@purestorage.com>
	<20240523115624.d068dfb43afc067ed9307cfe@linux-foundation.org>
	<CA+AMecHUo-sPy5wDszWgX5BWPAqMwrXqCWO1jGE5uMRq2U=BVw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 23 May 2024 12:16:57 -0700 Yuanyuan Zhong <yzhong@purestorage.com> wrote:

> On Thu, May 23, 2024 at 11:56 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > Please describe the userspace-visible runtime effects of this bug.
> > This aids others in deciding which kernel version(s) need the patch.
> >
> Otherwise, with some VMAs skipped, userspace observed memory consumption
> from /proc/pid/smaps_rollup will be smaller than the sum of the
> corresponding fields from /proc/pid/smaps.
> 
> Please let me know if separate v2 is needed. Thanks

All is good, thanks.  I added the above text and the cc:stable tag.

