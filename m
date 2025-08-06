Return-Path: <linux-fsdevel+bounces-56844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16414B1C7EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872AF17289F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AD1259CA1;
	Wed,  6 Aug 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Keyo+QW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC4944F;
	Wed,  6 Aug 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491903; cv=none; b=uzSd4gMQGidYxI22kcbP5yXWKqo4bRvs/JftEKUzPP02rv/9IiAqmdoKp3JxmDoHNt6fmrKsV0bmOo7JiHlWYBG+Mt4h+M4NWYByIG5yhrDoxbCiM/vxMPChrgyk8RF/Rp3RFaQLe9fF119+uYjln62vx87EQYWLaKQ1/u6CFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491903; c=relaxed/simple;
	bh=uvBDByLweRe4L0+0bNxfGe3e9GlYbMP9yIrYw/RwM24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZeyW6W5kXIRiswQjUxUluuX7cyp8VdrdVV/V5OJzJVFOHcfLJ3ni7PdioE4dWL4g8imdH+g4YnlhUJAIy8QUm+ZVnrpUyzOUJRHcGlStl6oFAMJuzQBmFMA4LgT4mfwMt6f2Wp20bCBTi+0XX9dLVWMiaMoFNeJwZbvZ84V3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Keyo+QW4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S3wdBIOLGEb/dP4L+k9B4Zn54dlvDvbbF5Vrp6IEWAE=; b=Keyo+QW4qD4sSKo5MwOJ7rpWON
	AzJ8xbNru1fyVHVJV2lDT/G3tmHeYXHQzk63MQDCl8JO/TkJVTarNd5KHWeDuQGez9IAsTQj6AdkA
	mEg88q7La1upTIhV+/PHr7WqceDh6/fxq57CdNZKlIZdUHX3PAoDHL74NqCtpxUeeDI/pfKM8YDBz
	jVk3cFqde6eNnnVRCZS519HiUTynHZBfgrneKVlba9R7jsF1+HMRP44a1wjsBRofqx6WCo5PfMaU+
	J+0Q8P9OP4Tf19hJvpr/hr0xv0YY89Yc++Cie1o4KuVwOYnHCImZ7hNaf+iSX+aKGCqGYPEEPbJZZ
	bQiRZMsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfUM-0000000FUPY-0hUG;
	Wed, 06 Aug 2025 14:51:34 +0000
Date: Wed, 6 Aug 2025 07:51:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/7] direct-io: even more flexible io vectors
Message-ID: <aJNr9svJav0DgZ-E@infradead.org>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Just jumping in while travelling with almost time available:  I like the
idea, but you have to be really, really careful for writes through file
systems with this.  Deferred errors happening after bio submission are
nasty and we tend to get things wrong there too often.

So this needs to come with an xfstests to actually hit the alignment
errors, including something that is not the first bio submitted.

Even with that it will change behavior quite a bit, e.g. for file
systems that can do direct I/O write without the exclusive i_rwsem will
leak newly allocated space on errors asynchronously reported through bio
completions, so you'll need to get fs maintainer buy in for that.

Given all that I'm not sure converting the legacy fs/direct-io.c path
is such a good idea as the only file systems left using it are those
that are more less unmaintained (or at least severely undermaintained).

