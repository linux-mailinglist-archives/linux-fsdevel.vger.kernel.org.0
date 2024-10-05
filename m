Return-Path: <linux-fsdevel+bounces-31047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EB9913E4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 04:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CCE1C22215
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 02:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A81BC4E;
	Sat,  5 Oct 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i2c78nuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228F3FD4;
	Sat,  5 Oct 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728094675; cv=none; b=ecnQBSlL6gjfDlpQDIIi1TQI7EzAVICANPsPAC84DWJw7Ai2pCOz8SKEOV2SAGalTTUh6lhuw4XLbM4mgX6FFrioFYsY48FuBaFXeM8aWlhfTDoK/rc6r5o75/vwlXjWVqBXmOL8jpYBZsUrZ3U8+wsLfT09Mifrm6n/jb4amz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728094675; c=relaxed/simple;
	bh=llarmdj6ikwpqkMLDMVaMIULmsQSU44HnQd/F5OOyK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG2lFAHBPZIWMVSSfiBOh0GSaKkHokDMkGdhxbnEcgVSIk6MfrZblHtftXGkcHifCaUdFKnJYg7fxjDS/UeGmI7qyEDxcAaRgMr+Y0cRcjl9BWTx7NReilrZ3fah16RwXYDwrcrzMlkTa05s0Cd/XNgd+mzgVmqyrw3yMzMGbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i2c78nuK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TJZLywaEXXk9Wbf2xmTBbddeyJfpodwKVcFimh5NwYA=; b=i2c78nuKzKNwx/E2ZH+McwsXiY
	JfGtMjer5s/AvnHv8ymj9jwD76o1NdsFidA+b7/SkOkC+p8Lo0YVaKFLXrjVHKkrJTkjKpOjZ2zDw
	PIqWqPT2sf61+oQHoRzufJPvuVV/+NDJpWriemwJ9mkoyLGA7GXN+Jrndui3UdDdTZ0aWi0xd5ZD4
	ooYFZ27fZG5rlCmQAl/JdFeHMz1iB6YbYCXA3BfknY+gm2OZps2+f/V7Lu65LYvCCwSjiWyBVub3n
	KGD6Qnnyl5pI9AdUCgaZf1qLQ4X1LtzNO3WmfiRoXTzesCLJ68DNNydL8wEuKtXjdqLuf411NovNU
	JpZpN9KA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swuMd-0000000Bqqw-2lRd;
	Sat, 05 Oct 2024 02:17:47 +0000
Date: Sat, 5 Oct 2024 03:17:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/12] iomap: check if folio size is equal to FS block
 size
Message-ID: <ZwChy4jNCP6gJNJ0@casper.infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <b25b678264d02e411cb2c956207e2acd95188e4c.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25b678264d02e411cb2c956207e2acd95188e4c.1728071257.git.rgoldwyn@suse.com>

On Fri, Oct 04, 2024 at 04:04:28PM -0400, Goldwyn Rodrigues wrote:
> Filesystems such as BTRFS use folio->private so that they receive a
> callback while releasing folios. Add check if folio size is same as
> filesystem block size while evaluating iomap_folio_state from
> folio->private.
> 
> I am hoping this will be removed when all of btrfs code has moved to
> iomap and BTRFS uses iomap's subpage.

This seems like a terrible explanation for why you need this patch.

As I understand it, what you're really doing is saying that iomap only
uses folio->private for block size < folio size.  So if you add this
hack, iomap won't look at folio->private for block size == folio size
and that means that btrfs can continue to use it.

I don't think this is a good way to start the conversion.  I appreciate
that it's a long, complex procedure, and you can't do the whole
conversion in a single patchset.

Also, please stop calling this "subpage".  That's btrfs terminology,
it's confusing as hell, and it should be deleted from your brain.

But I don't understand why you need it at all.  btrfs doesn't attach
private data to folios unless block size < page size.  Which is precisely
the case that you're not using.  So it seems like you could just drop
this patch and everything would still work.

