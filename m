Return-Path: <linux-fsdevel+bounces-44600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED9A6A921
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636821695CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39631E25EB;
	Thu, 20 Mar 2025 14:55:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEF1E0DDC;
	Thu, 20 Mar 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482500; cv=none; b=tRmnFqmk46T21zK0Ps2t44iDr5KsFN4OTMU9NdpgpBXSSL4LCTOU6K3xJqDXoEVP6o1qaUWS/5JUi+tY3Hjsn4cE6IT2DwXPcX06lNA24knHgr14Dcm0mEDYzAzc5+nkWKUnMl9uE4Onw6Z6tDNz9dS9f7664mfik9HK7poOH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482500; c=relaxed/simple;
	bh=QpZoklcSe9c0cXug7ux+6BI0reRDb7pcy9sIxBjz2Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ1PzyKyPfGWho1zfBq2RezC0XFtGMBrlvtcBrMIxacOfcxw6gIT7w83xWf3A8EdpIi4zh9FkGpydDuFVCwoMu59rFDpnPf8uPw9v5MJaO081bia5SjN+c1CzuOEqDYSyviwpqo949bQy9LyXhzcoGh5ZLn/E+pPQFI1QCjRLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2AD9868BFE; Thu, 20 Mar 2025 15:54:50 +0100 (CET)
Date: Thu, 20 Mar 2025 15:54:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
	leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, p.raghav@samsung.com, gost.dev@samsung.com,
	da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250320145449.GA14191@lst.de>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org> <ijpsvpc5xgd52r3uu3ibkjcyqzl6edke6fbotj7zf2wbw5vrqb@zzr274ln4tjd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ijpsvpc5xgd52r3uu3ibkjcyqzl6edke6fbotj7zf2wbw5vrqb@zzr274ln4tjd>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 20, 2025 at 02:47:22PM +0100, Daniel Gomez wrote:
> On Thu, Mar 20, 2025 at 04:41:11AM +0100, Luis Chamberlain wrote:
> > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> > This is due to the number of DMA segments and the segment size. With LBS the
> > segments can be much bigger without using huge pages, and so on a 64 KiB
> > block size filesystem you can now see 2 MiB IOs when using buffered IO.
> 
> Actually up to 8 MiB I/O with 64k filesystem block size with buffered I/O
> as we can describe up to 128 segments at 64k size.

Block layer segments are in no way limited to the logical block size.

