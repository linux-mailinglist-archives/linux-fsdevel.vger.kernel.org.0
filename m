Return-Path: <linux-fsdevel+bounces-59332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974EB37547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 01:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7588681C67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 23:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF42FF67F;
	Tue, 26 Aug 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crSZhsTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A392FE598;
	Tue, 26 Aug 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249888; cv=none; b=fjehw6S89Vi35jX5PAfLt/22iOVbITzrSW1VidDVUrcytbUWcUJ44+VBx9ZD4E4iWx4kBkWwhi0m4K/DLBiUZd4fYrdmXoJJJiwk4wcj33y5gVKQYLp9+DQbULxCQZ5j0tIftgy9T/ckx0bX/pqhT/XfKP4NOZZYuReB7+++fmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249888; c=relaxed/simple;
	bh=sGMWLjp5FHkDT8CA0fmK2D7DNtmFNB7Fq4mFCeJK7ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmuUaLum7UPIx7FBm8yiblxyl3RMclTo0XKl/qIPl8y0geCVllvQcG+2bD9vmtLZagH5OQuZYUxnxdHAVqU/GBCCfoDCPGOd7UmRdRsBFNMTbyjNhpz/lYNB0GODnhzijKiWz8+oVmSG054BhdElctt2jPkpq/lcy1G2ClIkNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crSZhsTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B8C4CEF1;
	Tue, 26 Aug 2025 23:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756249887;
	bh=sGMWLjp5FHkDT8CA0fmK2D7DNtmFNB7Fq4mFCeJK7ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crSZhsTbza9I/Iqyd6AeV7zsyHoUsmZK2f8dzFizxT8mh+fSyaAG/g5M/VEtqCjm0
	 jGAyioFCWwZNN2uCP4Rl37gN/n1AtWUHQW9Q3zkMPCFL810f6wj+lx2S1xDQUbZ4Gl
	 N0zMI3qwLa4wEvyFqqmbmCwLZejDqzy3O6iT7vTMHXbGFcZiySvfPNOJ9ziZiCRLm1
	 CKrKHVjTkzRzl6fwg/kS9gkqDlyLqBQuZPO+JwvL6fYB3Fy2mYeblMoJW2SfqRCqoc
	 cEa5UXEO2no196AQEWpm6c6yZBdyRCeA/nwVYEqYOmTV++UCUEnMAtIWpIc6YdUWNb
	 IqcI9w/FfcqKA==
Date: Tue, 26 Aug 2025 17:11:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCHv3 3/8] block: align the bio after building it
Message-ID: <aK4_HMksxi1HEMZF@kbusch-mbp>
References: <20250819164922.640964-1-kbusch@meta.com>
 <20250819164922.640964-4-kbusch@meta.com>
 <20250825074744.GF20853@lst.de>
 <aK0Bsf6AKL8a0wFy@kbusch-mbp>
 <20250826080200.GA23095@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826080200.GA23095@lst.de>

On Tue, Aug 26, 2025 at 10:02:00AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 25, 2025 at 06:37:05PM -0600, Keith Busch wrote:
> > bio_iov_iter_get_pages() might submit the segments as separate IO's
> > anyway for other reasons. I am not sure why the alignment conditions are
> > handled specifically here.
> 
> I'll take another look.  Basically what this wants to prevent is
> bio_iov_iter_get_pages creating bios not aligned to file system
> block size.

Got it, I think we're okay in that case. You should only need to
consider the ki_pos and the iov_iter_count to align to the filesystem
block size. This patch will dispatch appropriately sized IO as long as
the hw limits allow it, and you'll get an error (same as before) if it
doesn't.

