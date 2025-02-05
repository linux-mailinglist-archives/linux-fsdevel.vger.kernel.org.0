Return-Path: <linux-fsdevel+bounces-40992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7345A29C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 23:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310571887BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55D82153D5;
	Wed,  5 Feb 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GvIpSU9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF31DD526;
	Wed,  5 Feb 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792995; cv=none; b=dAiabX3p0xFmRdy3WOf730xb6IKUQE0iDY55KWzxjQ/1p+nSf737lN5NQygz2ncTtyeOTEdN37E4hVic3qIrygXsoGtS5TbzuqMRJkFaM681a3FophDTSZoVbPYTKb0IdInmzAKi7HpebcodyO1fVADXn2HQYqHLo8GxW+jE7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792995; c=relaxed/simple;
	bh=ZKg4hPFtzZMgBZRAUmKo58MUV2/XOMJypO5dCzp10D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AN7J1FPH91xQeAB1YD05TE1HhRMjW5XzxYIebXATw4Ya/Hr2wkHdZ4j3nFAOUQncWFgIknhFn51CXRQUXL084I6yj5d8Ge+6ihDNCwW/7Z1RLrzXnYvoUGmgFNMFmYNbyABv6eIG5IcpZNsFwe/32T48guu9pS4IXgjFSu09oG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GvIpSU9/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZKg4hPFtzZMgBZRAUmKo58MUV2/XOMJypO5dCzp10D4=; b=GvIpSU9/+Miz3nHeqZF/S/6qUu
	U0klbnDfNsHAUsoN4/TwJybYRzHUMHgTWh3qjS/JgaLJPOJMYToid5s5M7AEU7nzN0OSwgt+cpRS9
	wh0fMEhHWd1KO1Ti5LTUsA1IOHVzQhjTO759tN7yOqcbwGW01dq4JKLaYPZS/LjZX1ZuHNNJoLt3v
	bUFj1ZwIUa1aWPNsOmZ5YkNcgO8b4V1uih+NWjjRfOV8sUQnGcnlNRVaSMmDA4GiB8VYX7Lue///Y
	qCsya8jkc0UOH5xNxAgTOpx0JeywFgxMUr0KEJwBAhphY9ntVPas0Urv47zLLqk/IOvF9VgdLo0lR
	EP4EclSA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfnU9-000000054RU-2K3m;
	Wed, 05 Feb 2025 22:03:05 +0000
Date: Wed, 5 Feb 2025 22:03:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, dave@stgolabs.net,
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
	john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH v2 1/8] fs/buffer: simplify block_read_full_folio() with
 bh_offset()
Message-ID: <Z6PgGccx6Uz-Jum6@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-2-mcgrof@kernel.org>
 <1b211dd3-a45d-4a2e-aa2a-e0d3e302d4ca@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b211dd3-a45d-4a2e-aa2a-e0d3e302d4ca@suse.de>

On Wed, Feb 05, 2025 at 05:18:20PM +0100, Hannes Reinecke wrote:
> One wonders: shouldn't we use plugging here to make I/O more efficient?

Should we plug at a higher level?

Opposite question: What if getblk() needs to do a read (ie ext2 indirect
block)?

