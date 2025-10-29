Return-Path: <linux-fsdevel+bounces-66340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1746C1C321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19476188A06B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B134DB53;
	Wed, 29 Oct 2025 16:37:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE922F5307;
	Wed, 29 Oct 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755834; cv=none; b=D8JV/ARpRPXMinFhuikspuRJ0YsfeL7sON6iBTNYIWgUNoEp5LfZJsgJr5NyBn9j4mqzsdYN/KGsw2GXK2GTu2ObBAuKWaEZtUeBkrctHsJ8l3J6jzznB2FVL34WRYeMhe3LgLpO3XsoUx4S2QwgU8Ax783DEvwOEs8GNUeQVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755834; c=relaxed/simple;
	bh=544zncZ8JVr5/MwT4Yh6pgPM/1JKpGhS6xAaRmMInas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JteYZv3ftx0XFux1E8OPx4Ejxd4vYsKFWT2d8moXiGWoHfDrTXWDI8lrNCPP52uGlliqhz8zM3G9ykO2eyXzuGoSNIKMmKPPtdWhFabrgzXu2IDhR6ywzDyyqmPBCe/kIHiaP31W2JCz71nJ43vjtL1e+YA9qrFe6uHteWqQ1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA7B2227A8E; Wed, 29 Oct 2025 17:37:08 +0100 (CET)
Date: Wed, 29 Oct 2025 17:37:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in
 generic_write_sync
Message-ID: <20251029163708.GC26985@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-3-hch@lst.de> <20251029160101.GE3356773@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029160101.GE3356773@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 09:01:01AM -0700, Darrick J. Wong wrote:
> Hum.  So we kick writeback but don't wait for any of it to start, and
> immediately sample wberr.  Does that mean that in the "bdev died" case,
> the newly initiated writeback will have failed so quickly that
> file_check_and_advance_wb_err will see that?

Yes, this is primarily about catching errors in the submission path
before it reaches the device, which are returned synchronously.

> Or are we only reflecting
> past write failures back to userspace on the *second* write after the
> device dies?
> 
> It would be helpful to know which fstests break, btw.

generic/252 generic/329 xfs/237


