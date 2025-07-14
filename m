Return-Path: <linux-fsdevel+bounces-54853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C0B03FF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE057AD9A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7915E248F5A;
	Mon, 14 Jul 2025 13:30:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74B3C17;
	Mon, 14 Jul 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499821; cv=none; b=TndToLaSh6+zm7NEzRkeuxt6tr4rbM5i56Y8PydEzjItAwX5e1UgRESUIOPtcjR5drKFUEdbYyRcZgat/XMBtzFQyJ9B4lSUAd0cLDogo0n/MA+6Ms2lwxK9xNudCaUdOEldlT/f9iWTpWIXESvs+Aus4U655wTIoYAMSpPop/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499821; c=relaxed/simple;
	bh=i22J/7FW+COyJ0dcmC8XZkSWHPfzPF82io/TvVoAwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDixyA+ARd7k78uxhFegj0Z3r3QLwqY04+YEhpiHR1LVIEkwX+2bk8ZJbToKgTB41hESr8vU+u4k0jl+3tXIsZGIHep0R4Yn1qsqCjQJKaa8VlTGKu8TFMnEBhHYJxDiDZ6gVOleNn2ssk5tCNHVr+Q2e7ZpOcpvDy62mfdvvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A1C8227A88; Mon, 14 Jul 2025 15:30:14 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:30:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714133014.GA10090@lst.de>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714132407.GC41071@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 09:24:07AM -0400, Theodore Ts'o wrote:
> > Is is just me, or would it be a good idea to require an explicit
> > opt-in to user hardware atomics?
> 
> How common do we think broken atomics implementations; is this
> something that we could solve using a blacklist of broken devices?

I don't know.  But cheap consumer SSDs can basically exhibit any
brokenness you can imagine.  And claiming to support atomics basically
just means filling out a single field in identify with a non-zero
value.  So my hopes of only seeing it in a few devices is low,
moreover we will only notice it was broken when people lost data.


