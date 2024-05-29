Return-Path: <linux-fsdevel+bounces-20398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F78D2C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949C72875C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 05:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7115B980;
	Wed, 29 May 2024 05:20:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07113A412;
	Wed, 29 May 2024 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960024; cv=none; b=rxV3+iZfoA7C7rHDEAsE+Hi0DzCxWnhgJAsSd+mbNlLDcGseOIjBDB1iZNC1pgWkHJvRQQqKLx2hvGZgejLJPR40TWkRzoAHYRG5MmzlTtwADsRePB33Rh1H0c+KbCxWsTPudwK+ns4eoWgPr9W7sj4MhV8p0O+nxlpMREODlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960024; c=relaxed/simple;
	bh=1UF5wLDZH52kQQrtLtl5zDihegHq2jfGPBVOxdLdhIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGU1S5KC2tYG97JfDaZMPo65y492s3SgOKMZFRtkpW7xDNpQAhQucKWe7uiinPavTPiCfRJRoCRarfNE8tsXwzbPqRFZVgoK9n+LDiRR+F+rfoskdik5l9UVPpj6++iDkodg0JOb4ctZUtt0S/tQPCrtV/c4IzLnsP3r9kLoJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7E6968AFE; Wed, 29 May 2024 07:20:18 +0200 (CEST)
Date: Wed, 29 May 2024 07:20:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/7] Start moving write_begin/write_end out of aops
Message-ID: <20240529052018.GA15312@lst.de>
References: <20240528164829.2105447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164829.2105447-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 28, 2024 at 05:48:21PM +0100, Matthew Wilcox (Oracle) wrote:
> Christoph wants to remove write_begin/write_end from aops and pass them
> to filemap as callback functions.  Here's one possible route to do this.
> I combined it with the folio conversion (because why touch the same code
> twice?) and tweaked some of the other things (support for ridiculously
> large folios with size_t lengths, remove the need to initialise fsdata
> by passing only a pointer to the fsdata pointer).  And then I converted
> ext4, which is probably the worst filesystem to convert because it needs
> three different bwops.  Most fs will only need one.

Hopefully ext4 will get convert to iomap before we need this.. :)

More seriously, there is an ext4 iomap conversion in progress and a
ext2 one, which is a really good copy & paste model for a lot of the
simple file systems.  Maybe just wait for some of this to settle
to avoid a lot of duplicate work?


