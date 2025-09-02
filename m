Return-Path: <linux-fsdevel+bounces-59925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5FB3F284
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 04:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5304822BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 02:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95C2E03FE;
	Tue,  2 Sep 2025 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YWKGCc76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D678F2B;
	Tue,  2 Sep 2025 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756781434; cv=none; b=JVTldOx/4Z0Yo1zPm7uE1Fsnn6TjRyK1++we8Lx7gNtbCdlKX6/ukX46rNVTuVKGIUFyIheRB887Tc0RznipQ7RgKUFZe53YLgth0fPDT81DH2dShyXHkNh3kyOCLfCmqJTjeH2SSczf84N/sZfbdYTmykdm+rMa6Lbz7lsdBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756781434; c=relaxed/simple;
	bh=3yRKUPS5SkIJBkquRCWSfardWr0wvLtWolRjXUGBsoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6Gzn5KStySuVaiimyRRq7TToK98DhoTSGddZzzf4PyFhrz8yZJpyPD3TVeDBeJrFgi7gYr/0njUs9dO/OVHsSH8Apn0j8G9IZTjgr1RUU0/2hbqI6XjlCFaPhMvWK7FhohVMm3EoTobdM6gBnpVh0wg5XoQUHynNH7eQbhWd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YWKGCc76; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hf6Da6Iq95ZbXZKuGgj/YV9gGgv/dEeEFT9XrC4vfVs=; b=YWKGCc76MDqwdQGQ+YNvxvBkE7
	LOtsZ/0qAhffBjWu2LlUUNNOwjLMqqeegxqzD84CwosaGVQPg3tYgm2N7OBQVwIKzyUITZLtL/Yce
	RTiKplKHrXU88mi+OFSDvF6nVFL17jqSkRmJ+SaxTvUL16Kpb7ukadvFSbeQC3zGTfvoj8cVCf49F
	O4ns7Vm5RaRFlO4WDOwnTREHtTe6+GdlFzFfU8lWr03F1EBbv6ITczdHk5xcuqUrCwivrKjxXNfyE
	buBpYx7MRb5+QPg3NMDAnd0muprWfiSDnR67Hw1+LsSBpzsd21TiroQj+2Xhy9iw2N9BUGc7mpDFh
	bb0u+gbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utH68-0000000H6f5-3MNh;
	Tue, 02 Sep 2025 02:50:16 +0000
Date: Tue, 2 Sep 2025 03:50:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, hughd@google.com, mhocko@suse.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
	linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
	rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
	broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
	mpe@ellerman.id.au, nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <aLZbaHf-euLQ0isT@casper.infradead.org>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>

On Mon, Sep 01, 2025 at 02:30:16PM +0200, Max Kellermann wrote:
> For improved const-correctness.

SLOW DOWN.

This series is unimportant churn.  There's no way it should be up to v5
already.  Wait a freaking week before you send another version.

