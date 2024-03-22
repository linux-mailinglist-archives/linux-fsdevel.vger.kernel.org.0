Return-Path: <linux-fsdevel+bounces-15072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF43886C1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E974B225C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06531A8F;
	Fri, 22 Mar 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH1mD2q5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D216FAE;
	Fri, 22 Mar 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110689; cv=none; b=Lxi7wHjH90ramnFMoIeJRgJPekBPcbPo7T/JechOy89eqCOLmjexNaADdrPDYrW1pLGN6Fc+jSG8j2GhmB/spLdK5ytl7+P0YaNeQRkgjRDgeJOU7AazYywPxzM8ZFZ3J2SYygkJ1Qt9FiLirMuPgj8XTHCCXAIsEDjkpFsAJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110689; c=relaxed/simple;
	bh=QOcW4ovC8AZaHtxZCTB4zvzspShAC9FthA2wgg11tF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/JwEUt1xwj3ypfCWuQYJtjqH0+c7hpj+1Mx1VzEET5RJGH4WyEcnBRYr4yKLk4GixSyLg02xZxc2oEIntY2TE49RYVL2e86cV2T3DKR7n442Z303l35vvTgUKyjsxwNCC+oJqJUWrIzi5NbdworgNeBuQx5h0PnnaxtgpFj/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH1mD2q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE4C433F1;
	Fri, 22 Mar 2024 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711110688;
	bh=QOcW4ovC8AZaHtxZCTB4zvzspShAC9FthA2wgg11tF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DH1mD2q5mlVi1cG7I9CnXr567BLrFJViCJ6850FUJpbchnDmnjbCiQ8h/LP6B3bj2
	 i2aHjp+oOSZHEpy1N7qdQEKHcHbzV+Jtx7/GG/2ALfoSSHHEkoAN/MF4kUrLDN1bhe
	 X8Sf0SJcI4Kobh9O3SWN9HM0krd3m48fyALGVW5cnUWUmloLkn5+kFuVJmVYK7D8yQ
	 uTD7RLFVyWesft51NDCGwgwDXuHlaDbo6255HCeoFzZQp4C8ZzyVlzmgL8jtd55Twr
	 iXqd0M2AMjJlDx/Sd7rn2KHAQJXFtZoZG//3rAn2sdVgpxxUvFfLGk/S+Ou0pa5beb
	 qutph5cbqITvA==
Date: Fri, 22 Mar 2024 13:31:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240322-subsumieren-dennoch-647522c899e7@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <ZfyyEwu9Uq5Pgb94@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfyyEwu9Uq5Pgb94@casper.infradead.org>

> ** mkfs failed with extra mkfs options added to "-m reflink=1,rmapbt=1 -i sparse=1,nrext64=1" by test 015 **
> ** attempting to mkfs using only test 015 options: -d size=268435456 -b size=4096 **
> mkfs.xfs: cannot open /dev/vdc: Device or resource busy
> mkfs failed
> 
> About half the xfstests fail this way (722 of 1387 tests)

Thanks for the report. Can you please show me the kernel config and the
xfstests config that was used for this?

