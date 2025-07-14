Return-Path: <linux-fsdevel+bounces-54869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE5BB04505
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ED71892202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31825E471;
	Mon, 14 Jul 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/0Zk/Dl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B41F94A;
	Mon, 14 Jul 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509041; cv=none; b=S/Hgn+XBeOmdUT6hlHlXuhInI/hYGYG9G/rTA5cfjjhDv1R3EFl6LRLz+cLEoaiBgnVZXXPpYSX/d4AFUd1rbSZf1xPvUQPbQFSVfs9fA19uavZ9nVkYxjeF6zOqJc2/NpKhryiGcacsqZ+NJKoACHSDF/9Q8I5jp3g+qGTTcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509041; c=relaxed/simple;
	bh=AHdmcwDk69P0bsuDXUAUbKZgYi6IjvT1mhl/qsg2pFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqHtHnqDefufDQS3NMCLuynGtjGVn7PorfXSL+DqiI1F1IG6DnT3eDU9FY8zgkAHMZqRR4iEcDmow53dfKhn6Xm2eIh+F8eSAE0QxtlFN65/T/qNkYAQ8xJI42MJFIqcXQuK3Q+A093jMU7vwHQTcJK8r702d923HlWZ1giXvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/0Zk/Dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AA6C4CEF0;
	Mon, 14 Jul 2025 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752509041;
	bh=AHdmcwDk69P0bsuDXUAUbKZgYi6IjvT1mhl/qsg2pFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/0Zk/DlO4/RGceMRxhdRCcVamfcty52cZZds5h1ZtTGD1N/s0qVnZzVVIKATF5ZN
	 fcnomUp7Nkq/zyNgKumD3M1G+Ba7iz7qM4ukSEeQB75MYfTZoKNX0vcb2QdXttFS2L
	 yEtEAIY1YMM8L4JsLctZ7G8gMSB5Wy1ElbNlTRaLV1zsdR5pwSWVatXFVbLKiEffB7
	 2avLGgmbKkY6WRDjGX5P50O45SlosYxfPpw8BB3BI3NPNRmirTrqANymHNgHm7sm7F
	 J44cYxkml4vMF/IHRcuS6CF2UwQF5rjPTCMuiXqUU9w7o5umLg8GnMKhjtrTJ9GzeW
	 RknHjdOMVGf4Q==
Date: Mon, 14 Jul 2025 09:04:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, John Garry <john.g.garry@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714160400.GK2672049@frogsfrogsfrogs>
References: <20250714131713.GA8742@lst.de>
 <20250714132407.GC41071@mit.edu>
 <20250714133014.GA10090@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714133014.GA10090@lst.de>

On Mon, Jul 14, 2025 at 03:30:14PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 09:24:07AM -0400, Theodore Ts'o wrote:
> > > Is is just me, or would it be a good idea to require an explicit
> > > opt-in to user hardware atomics?
> > 
> > How common do we think broken atomics implementations; is this
> > something that we could solve using a blacklist of broken devices?
> 
> I don't know.  But cheap consumer SSDs can basically exhibit any
> brokenness you can imagine.  And claiming to support atomics basically
> just means filling out a single field in identify with a non-zero
> value.  So my hopes of only seeing it in a few devices is low,
> moreover we will only notice it was broken when people lost data.

Do you want to handle it the same way as we do discard-zeroes-data and
have a quirks list of devices we trust?  Though I can hardly talk,
knowing the severe limitations of allowlists vs. product managers trying
to win benchmarks with custom firmware. :(

--D

