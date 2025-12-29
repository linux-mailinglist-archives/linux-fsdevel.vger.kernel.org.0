Return-Path: <linux-fsdevel+bounces-72202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A477CE7A93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7011A300D927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC01B6D08;
	Mon, 29 Dec 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ppoEQqpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A65145B27;
	Mon, 29 Dec 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026475; cv=none; b=qQhjWB7DC0vf8VlrxYSZb1OSUlP1SGMmAa8eDe8zUWTHWiR7i/kTNPfIAWULV0SZDoHvsP8GwX6xBs2cwYFPwSeBCWRM/JBFWgsCltgx0y6ATyjyVfIhfLqchIBHJZZXB7Rkx9WbyX6DBAo60OP2vwymqpyU+9zxYKzzu7+NiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026475; c=relaxed/simple;
	bh=ueGi12HgAm5bz8nt66KCozYOWe0pu/ZwHB+CUOfz/2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYyjOJN/QqNLt0O3LvDTubyigmvZUYkfP/2qg9dWczZR4M0ZOnYL9WBfxeYLP47wdYpW/VjUP5htWJyh8j765ksQBWJVWt3wbmwcXmkd/LYitSiTFRel/N5ml9QtAdgNyZ4+L+irWQ8X6Rd0qoEuUCLv5LjyVjLLkxJ3bet1FrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ppoEQqpR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2C2rwaOdh/4Zgp6xLYidaPRT4GjvRGugo+oY841IDwQ=; b=ppoEQqpRehkm2DF7XrxzpJnQJo
	dZzwEtiVjNBHlt/n4cbdGmO2OpMreNeEOLlGpVVyrvW+0KLgR+pdKP9zv9s+xVjGC+lWWfycteU4M
	IPU0449EAA00jSepBJL5gEanrqO/kdGDIY2npVWdwUT8TEk/H5NPlqP5d4fOGqoHTKY984uOFqf6Y
	+smG5wIdfEiD9938ajDtsgYOFLxvDDffGiM9cg5OCZYnu/G6NXDNKSDP9vIHnFSfgCpD1SxyKQ+n1
	NgjLo0FvJ4TvK/zIiDJzex+S8/nWm9HsXqAFmK91uOZpIB5998uMkk63wA2JjNsUDSnY08s1HAUOy
	151fMgvg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaGIq-000000025vS-2kqk;
	Mon, 29 Dec 2025 16:41:04 +0000
Date: Mon, 29 Dec 2025 16:41:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v3 12/14] Revert: ntfs3: serve as alias for the legacy
 ntfs driver
Message-ID: <aVKvIENB3ihYo6dJ@casper.infradead.org>
References: <20251229105932.11360-1-linkinjeon@kernel.org>
 <20251229105932.11360-13-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229105932.11360-13-linkinjeon@kernel.org>

On Mon, Dec 29, 2025 at 07:59:30PM +0900, Namjae Jeon wrote:
> ntfs filesystem has been remade and is returning as a new implementation.
> ntfs3 no longer needs to be an alias for ntfs.

I don't think this is right.  If one has selected ntfs3 as built-in
then one still needs pieces of this to handle classic ntfs
configurations, no?


