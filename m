Return-Path: <linux-fsdevel+bounces-46603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C50A9120F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 05:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2307117CB87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D11D5AA0;
	Thu, 17 Apr 2025 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnKDWUqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B03D994;
	Thu, 17 Apr 2025 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744861448; cv=none; b=ePuRofKEGW24UNJmsbGVgSnd2rQ0AJo0x5UaqIvBd9eZUebMAiFY734lrQf9aqcLC+/Ah/T86QHnZYf3bi++HqVOMMrrahk0WVrSQLnBLH2m4+5xUbFb1hxdRFk+lWaJB3zNPBXKHigrauxn5Dgzn/Mrs5eLl6/GJfuyOBpLaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744861448; c=relaxed/simple;
	bh=R7qsYUeUd1iUm6G89HG5YRgfHabJRXn5qvLM8WYzZhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQZ4JIqFpqFZCaTAXQ13UJu4R1ZajbNELf01GIj4eDVlRXEYQGDzdf7g9l1Ea7kWongUS2XA/ipMv9qCcJUUy3aoVe0R0Jrfvt2/CvkIbypUxuU860b2AM34MZAqAP34sSIMD7fV0sTOlaBhLSrpzArdgeKB4kD5+Z+vPiOTQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnKDWUqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C24C4CEE7;
	Thu, 17 Apr 2025 03:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744861447;
	bh=R7qsYUeUd1iUm6G89HG5YRgfHabJRXn5qvLM8WYzZhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnKDWUqFijN2IvXTjfo+QFPvyIILLzxLzDEEIWN6/pdVSsmzJywTV2LVI1STdLoiT
	 phdnrBLo/4VPhkkuJgqDc1wms+HF0yu23CJeOG7X7HESMnA6mqP+QKw/Xvp63VG1sU
	 A1qNMPRpONC4dgOvCu+gOnbS40N6a1InPw4qeMZs0sQNbIjY9oBZpkRR2lMFZdt4vz
	 NG49+2U6mCaJLYiZi5vIyaMGVXdpFfOR0flmKXSva090mLrQFQ4A0OlALio+EoU3/M
	 FPlOCCsZZg2W0Q34QsGvqOjEZAR3wc4Qr6bbxu92ebF4hPZ0ntALS6Km9Z+Jymk82a
	 QC4QXj3JmM7sA==
Date: Wed, 16 Apr 2025 20:44:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
Message-ID: <20250417034406.GF25659@frogsfrogsfrogs>
References: <20250410091020.119116-1-david@redhat.com>
 <Z_gYIU7Nq-YDYnc7@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_gYIU7Nq-YDYnc7@aschofie-mobl2.lan>

On Thu, Apr 10, 2025 at 12:12:33PM -0700, Alison Schofield wrote:
> On Thu, Apr 10, 2025 at 11:10:20AM +0200, David Hildenbrand wrote:
> > Alison reports an issue with fsdax when large extends end up using
> > large ZONE_DEVICE folios:
> >
> 
> Passes the ndctl/dax unit tests.
> 
> Tested-by: Alison Schofield <alison.schofield@intel.com>

This fixes the crash I complained about here:
https://lore.kernel.org/linux-fsdevel/20250417030143.GO25675@frogsfrogsfrogs/T/

Can we get a fix queued up for -rc3 if it hasn't been already, please?

Tested-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> snip
> 
> 

