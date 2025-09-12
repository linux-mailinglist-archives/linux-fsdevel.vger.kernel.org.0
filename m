Return-Path: <linux-fsdevel+bounces-61002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81258B543A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3A21C22D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815682BF3CA;
	Fri, 12 Sep 2025 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSZ3Ukb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D3216E26;
	Fri, 12 Sep 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661378; cv=none; b=hTWVWBmRDEJPmE+tYy1I+E/Mj73oMCVvX8xJOhcdN3dh/PLe9nQOVJVW1Hs+qvmqXlMQWHjP7sIpwC4MJ8hsV6m+dzwj7eDWzAEecLfPI1wqRQiZIqhZ0CxXdwnA52zluMXNJkMV++hQSEgYSq6mmkg3uOymBgQN8xvEmOufaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661378; c=relaxed/simple;
	bh=nRtRtZUy4LOKsfJRX95+9X9K8rOd3+uvG44lD87yO68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWFibYFJHB9VYRDMwHShu1U98lIcjHWH7WHTzStgjoWZBDF9O7hiRdflinB7zK9pSFiU0HsEfKD8CDywMOJ73NbpBj/RHKIhKebj1dvIvw+CVSflxanaBlgAiwdU/iBXr2ZVojgnKicDcdfLJ+HlFcV9ZnuPqZ4ZgrYiAPSs/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSZ3Ukb7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3/n9SGc6OsjPKesM5H3ouqWipf+GF/dcMnurs7h8nT0=; b=WSZ3Ukb7JOM/0gb6iMeOJRkdr/
	IkuTP5lHusFQtNtQ0tluCnGQZJguY8M7zMgHH93eJjZ7EFn3R2M2z50roAbrXvk57e/nHr3EvBNIF
	PKIMZvCEPJlkwi9pgJUEvuhQa9cgbjOxZYAY0EAyq0TSUfUhCIvFKQ7Oc3ENOFpc+Y4+3jUarbCGl
	+Iz9s65qDwsrqylXpY6tMryEDyAJruobQVZMDP1BJoidL+vIXXeQ6tKZbPVqiVYqcoe8MboMPYc/g
	6GlrIFhTokNZjCWMvdfv9yxdFh0bDayDRyZKIO4fP4NJj/HMWEwu39YdRQlSHfqLPxbff8wF+Uj/i
	NamH8QxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwy13-00000007b2z-0fAC;
	Fri, 12 Sep 2025 07:16:17 +0000
Date: Fri, 12 Sep 2025 00:16:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com,
	ojaswin@linux.ibm.com, linux-xfs@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [linux-next20250911]Kernel OOPs while running generic/256 on
 Pmem device
Message-ID: <aMPIwdleUCUMFPh2@infradead.org>
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 12, 2025 at 10:51:18AM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> IBM CI has reported a kernel crash, while running generic/256 test case on
> pmem device from xfstests suite on linux-next20250911 kernel.

Given that this in memcg code you probably want to send this to linux-mm
and the cgroups list.

