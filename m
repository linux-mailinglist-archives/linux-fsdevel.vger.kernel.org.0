Return-Path: <linux-fsdevel+bounces-63916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C2BD1B4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D896E1894745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 06:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AE2E5B13;
	Mon, 13 Oct 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g52eOs+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB22E2F1A;
	Mon, 13 Oct 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760337904; cv=none; b=rRcNJybkAkdHfQ31Luc1m/SpzBUYlZuoPFHMTaIsrOZ82zuFKrSMJGXsNA7VcJoz9nMxSecqGK3MUvC6N5ABfgTKXZR+3qu4cVhQumIXtqiOJ93poBSWQDSy4UYY38WstGkJwaXK/4P9IDm8kECnTsFSBte9KaIi419b7gJZ9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760337904; c=relaxed/simple;
	bh=FgRFBbP8P5fV8E314WVTZ5BzxJCmZ5LLaCDYigU4+TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mujny9BDxMcetNGN/orpMlZbmIugtZRM72qN0DvmNK7iKfB9kIfZSMU76KA5FuQ848dZ/kQLZvI2qBzV8zcFZcKWB2Ktx+Y5N/aJQ1vuYjWDAg/rolQHj/bSFVIUaAXIRWYeCL9A8oMb5B7JDk6+kXN1tacQbGaJZyg/v4kOxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g52eOs+T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CK6xCOG1HC+zooaL67URetqqCyoarWjYFpW68lZJ0Jg=; b=g52eOs+TJooN70t73Ap5LaWvb/
	tDW2aFYo1hCGOfJNG56k9V76XHyv8t9sdwaVxNXaIjgUWyTSWXRyihXJNsYgIhrSdF0r7F8n2mf48
	KyKVu9Xd29YJFNTqgMkLBFOt96lGLeP0TLf1DNGQ4Ke6fUUEMO8tGmt6uCiU154rphKsXG7zMIrTq
	y1ctylhYAgkk4jxJSpagC+OOngT90ufONdearUKda+EaFjmd7kAjf64XDCou3dQHP37VbApXtYZPw
	663yF/gmCorKESypTCX50kkSPDGtlr361yfhYYr9aLEmfBXX5g+9ocAZzLwu7a3yC1RUqEpEYApXC
	0krra5gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8CIe-0000000CQN3-19Sa;
	Mon, 13 Oct 2025 06:44:52 +0000
Date: Sun, 12 Oct 2025 23:44:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com,
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com,
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, jack@suse.cz,
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, minchan@kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev,
	Minchan Kim <minchan@google.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
Message-ID: <aOyf5FxH8rXmCxLX@infradead.org>
References: <20251010011951.2136980-1-surenb@google.com>
 <20251010011951.2136980-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010011951.2136980-2-surenb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please don't add abstractions just because you can.  Just call directly
into your gcma code instead of adding a costly abstraction with a single
user.  That'll also make it much eaiser to review what GCMA actually
does.


