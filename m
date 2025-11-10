Return-Path: <linux-fsdevel+bounces-67691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4FC470F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44872349719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD5C31280C;
	Mon, 10 Nov 2025 13:59:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342030F920;
	Mon, 10 Nov 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783180; cv=none; b=fVw3GcoVR+Fd64QWU5b8xiZjADEWXpmPv3XL+jCiNRNLFiTpBU8G74PSUjpRaifvqRjQPdRDoTL2cA+PiqykLJvCsQqPTbcDlO90FkkrIA14LjRZmLBGGNQ1Lz0ylZ+3cDovaI5gLKEIZt2EjDNMHhi+V4LJHNEPngQlaJPH0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783180; c=relaxed/simple;
	bh=LHgTI8rX1LYSebgZj4/PNUhQVDu1ubb0/HpapmPkXKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX3/0vPLjFXsmOoJK/Qs5SCXhkZ0ATQHYD3JV47cWPiytwojem1b/QbE9Oq1VGRgMzEICduM9K//UiFU9hVzKClwJtwhk9e7r24U/af+LkPw5c6xYccn3qshae/9YJ9ymAwvA0JSl8K2ktO/ouednqHLm063ygpyRvLN5wGlJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B31B4227A87; Mon, 10 Nov 2025 14:59:32 +0100 (CET)
Date: Mon, 10 Nov 2025 14:59:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Message-ID: <20251110135932.GA11277@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-5-hch@lst.de> <7f7163d79dc89ae8c8d1157ce969b369acbcfb5d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7163d79dc89ae8c8d1157ce969b369acbcfb5d.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 07:08:05PM +0530, Nirjhar Roy (IBM) wrote:
> Minor: Let us say that an user opens a file in O_DIRECT in an atomic
> write enabled device(requiring stable writes), we get this warning
> once. Now the same/different user/application opens another file
> with O_DIRECT in the same atomic write enabled device and expects
> atomic write to be enabled - but it will not be enabled (since the
> kernel has falled back to the uncached buffered write path)
> without any warning message. Won't that be a bit confusing for the
> user (of course unless the user is totally aware of the kernel's exact
> behavior)?

The kernel with this patch should reject IOCB_ATOMIC writes because
the FMODE_CAN_ATOMIC_WRITE is not set when we need to fallback.

But anyway, based on the feedback in this thread I plan to revisit the
approach so that the I/O issuer can declare I/O stable (initially just
for buffered I/O, but things like nvmet and nfsd might be able to
guarantee that for direct I/O as well), and then bounce buffer in lower
layers.  This should then also support parallel writes, async I/O and
atomic writes.


