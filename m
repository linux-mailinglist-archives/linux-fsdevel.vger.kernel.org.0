Return-Path: <linux-fsdevel+bounces-20498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC28D42C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 03:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99C8B23902
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 01:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760BFC0C;
	Thu, 30 May 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pmoEqwa4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA67EAC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031688; cv=none; b=hr1c2yJY36A0NZfLFsF3MZ9S3E+vqteoKmViiF0k/HzyBDs2xz8i1yKAr5CY8CGHGKlEMYeRpdIXN5pcPLb8vK63vwpeD44HiXA72lvlR3/IBpHSAYWaf3PuPPWBsnWJuvo2OO7cgbw8vrhSbPtuX2AW8uV7SGtewyiEZ1eOoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031688; c=relaxed/simple;
	bh=TfJPpQ3Gsme1VqFNcUpnWX7HqyzfY54KmLQazYMuib0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgh2QS67jl6uF+V9NSp7qviqq6dmDL4TanytH/geS57XHLbh6SozYw25gOY3M8xgWvuLVeS8hcj5Bn4jflQrg4RjpXKNwTjQGbOocfENhe5jF24DM0potxsKUBMeRZZflHVn69tas/S0ooBxGQ/Xztl54+6JFMT2YoZ3WUym8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pmoEqwa4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g74BOnEM5NWtgiU58LtR+BHyV4qd/59nrWf/OPI/7DQ=; b=pmoEqwa4dsCF5UA9FgGx2ILWBB
	eYWWIeJq36OKAYmbP6x+wwcUBLOnHwNFNiOUnYeH8evDJId/hqf9XR00/CpzEgJ4gzqIHGJUeHLLj
	C+mcYbdC1aTXdhrEWY7fWQyn1K4oqoyjgBJliYz8zCWwwF9VsCm1H7Ge7tdZHzGliZc/MpFcPN4Nx
	XOuW+qKCl8bhZtj11E/ef2i2PL5FUWOJtFzLII5OYGogzj6/k5ep6iPbHEet6D8Q0v6ByFxGCJSm3
	DRIS8yHd7NjU3svmi0z7v8SCbARVXCHrRJCXdInNXYOK5KWoZQQgmvznt1L9EsjJbi/neXxLFPiJS
	IZ4w0YEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCUNO-0000000AKNg-3U6F;
	Thu, 30 May 2024 01:14:42 +0000
Date: Thu, 30 May 2024 02:14:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com,
	amir73il@gmail.com, hch@lst.de
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <ZlfTApvagV6SeJMh@casper.infradead.org>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>

On Wed, May 29, 2024 at 04:41:32PM -0400, Josef Bacik wrote:
> +++ b/drivers/md/md.c
> @@ -7231,7 +7231,7 @@ static int set_bitmap_file(struct mddev *mddev, int fd)
>  			pr_warn("%s: error: bitmap file must open for write\n",
>  				mdname(mddev));
>  			err = -EBADF;
> -		} else if (atomic_read(&inode->i_writecount) != 1) {
> +		} else if (atomic_read(&inode->i_writecount[INODE_DENY_WRITE_ALL]) != 1) {

I think this needs an abstraction because I have no idea what this
means.

		} else if (!write_access_ok(inode, INODE_DENY_WRITE_ALL)) {

perhaps?


