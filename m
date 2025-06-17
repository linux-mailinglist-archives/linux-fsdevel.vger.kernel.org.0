Return-Path: <linux-fsdevel+bounces-51991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5976ADDFBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 01:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EA73B9C1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 23:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD94294A0B;
	Tue, 17 Jun 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F8Kzyfy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A872F5326;
	Tue, 17 Jun 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203300; cv=none; b=LeburJsaiM+ClaImQuDMFmvGba9o1TiCE89HGSTcvcuYvXcQGDZBvUNz/TTVX0XyZkkZnVft4JXN6pBqLCAC1ONKY9VVRiuQXyZ/lAKnxceWKPY0CDgDwkMyMCv4x8p4lbhrgserAZkmhi0fZAoJyldOeDUajcWzM12NBT9C86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203300; c=relaxed/simple;
	bh=sC4PjFXnrul5dZVI0fMfyCQpQA1apYIfhFJlTLPwiyI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mjqxsDefefWz3h/chSgmm1tCskNs4nVZCxZLd/oGV6mndM0gr2iBJXQPlyFiOPZy1JXu95R08vO+cQ+HKs3lNdLDsEuYzOn7NYhD4QiwsgbesLxog0N8iFpeQKViovxeyaljVBcRGs9dnAi5clNcw2pq1B3NFcxOWw2ZhbCY/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F8Kzyfy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53737C4CEED;
	Tue, 17 Jun 2025 23:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750203299;
	bh=sC4PjFXnrul5dZVI0fMfyCQpQA1apYIfhFJlTLPwiyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F8Kzyfy6v59bFcIYQ9edZ6OPAXXgihpMRvduiLoo1pz3y8Y0yWyCVhWvOWydOeAAF
	 73QBnSSS5SR6N4Ep5dlGhObFvvW6ZBlxx5CXkwjZ2cfXhxrvlrElKCTbaHIwiAZa1n
	 dJeU0kY/wETuxiMZQkznhcqAhoscjh7oPav7hBlo=
Date: Tue, 17 Jun 2025 16:34:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Muhammad
 Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v1] fs/proc/task_mmu: fix PAGE_IS_PFNZERO detection for
 the huge zero folio
Message-Id: <20250617163458.a414a62e49f029a41710c7ae@linux-foundation.org>
In-Reply-To: <20250617143532.2375383-1-david@redhat.com>
References: <20250617143532.2375383-1-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 16:35:32 +0200 David Hildenbrand <david@redhat.com> wrote:

> is_zero_pfn() does not work for the huge zero folio. Fix it by using
> is_huge_zero_pmd().
> 
> Found by code inspection.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Probably we should Cc stable, thoughts?

Depends on the userspace effects.  I'm thinking these are "This can
cause the PAGEMAP_SCAN ioctl against /proc/pid/pagemap to omit pages"
so yup, cc:stable.


