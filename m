Return-Path: <linux-fsdevel+bounces-63502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18EBBE715
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 17:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5A4B4EEC96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D12D77ED;
	Mon,  6 Oct 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTZY2sAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5B2D73B9;
	Mon,  6 Oct 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763256; cv=none; b=uy1wqVYyJaorRb10SJEdNkhxxawBRFE1LoympKX1pbn7GIQMihvSELO8HyCbOtzJ4MSIhtESwZymgFl+v/l5RaG+JSEyOmrzKfaIi9HvwchufbHkmkN8A+1zaLX59PspE3LHFxNF2MCfgPkDdBYIXC8BS1V5NRMr19VhUnGNO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763256; c=relaxed/simple;
	bh=6tbN8X6Sh0OQHviqMhA/n/2iU6jpNAiB9XinEHb3VlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEYUrnBtV3J6q8nT3vrDoYOEl7ogJKzv7aJbWoUGrdVHboJUcP5zrzsIeAFWCC4yXeZ+VJy9GAg7HfEjTJHk+v8W6V0kDtE1kC7HxbQi7rKdD2pYo5usEBZmWFdum7vM1ZqrNYfkRXwAKoWKYCP2EcHywyGkyHPzLfHM+Agk8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HTZY2sAT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wG4YAut9yk4+pp+RtBmTG3gIVoqnu9o9Ktcrqzwuvyk=; b=HTZY2sATM0kH/f7MpLPXX1UCdP
	69NakvRQtc7P9+NtxPz1MrZAitJmSACfumzGen3AhLAtHubXkgirD61qSVgF+IU0/UdosLQ9Qrzr1
	FCnd3Ey9ZJvvgE/4zdwS40z1UkIeQ5CTv3uVwkD7GTCrJqm10lLwALOxo2qyaJ+stOZheAnLZ+tQo
	SlBiNdFnpT0t0o0fFJV+lQXzDnxr+ssbESf++MhF71B/Q+hO2umvXl/NfxS5sjWt2LxfAx7c0WBrZ
	iDuqffIgLw3iu2OQ9pac+XQZ//MzwSWPUWyGxd2+Em+5MWSw677u/0hG6GmXp5uFZqXzxfTn5Y7ML
	yHcDnbrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5moE-0000000EEfu-4069;
	Mon, 06 Oct 2025 15:07:30 +0000
Date: Mon, 6 Oct 2025 16:07:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: Direct IO reads being split unexpected at page boundary, but in
 the middle of a fs block (bs > ps cases)
Message-ID: <aOPbMs4_wML4qxUg@casper.infradead.org>
References: <048c3d9c-6cba-438a-a3a9-d24ac14feb62@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048c3d9c-6cba-438a-a3a9-d24ac14feb62@gmx.com>

On Wed, Oct 01, 2025 at 10:59:18AM +0930, Qu Wenruo wrote:
> Recently during the btrfs bs > ps direct IO enablement, I'm hitting a case
> where:
> 
> - The direct IO iov is properly aligned to fs block size (8K, 2 pages)
>   They do not need to be large folio backed, regular incontiguous pages
>   are supported.
> 
> - The btrfs now can handle sub-block pages
>   But still require the bi_size and (bi_sector << 9) to be block size
>   aligned.
> 
> - The bio passed into iomap_dio_ops::submit_io is not block size
>   aligned
>   The bio only contains one page, not 2.

That seems like a bug in the VFS/iomap somewhere.  Maybe try cc'ing the
people who know this code?

