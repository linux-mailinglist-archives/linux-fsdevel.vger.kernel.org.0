Return-Path: <linux-fsdevel+bounces-70971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE068CAD371
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 14:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2B73031CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFB31329B;
	Mon,  8 Dec 2025 13:10:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01032F5A35;
	Mon,  8 Dec 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199448; cv=none; b=TiuPc36tAdWgDd9JSdUUml2sjxuP978aPPdIIDMf8X2RnLnW7GedAeNaxYm3QmjHp9w/lqcL63lmG/ZbbMUfWJggaklHf+mjMQYJTd+Feh5gNVmCKApjXEhrKmMS3tuCRa3N1tNAzEoGB0UihYWPrw18EYE9ozgcMNfDPwaq5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199448; c=relaxed/simple;
	bh=cPSxFzQtsvz8m6yLZIFIvVbiq16oXybRti3XbdfSxKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK7gZp5aVgr+N1Esn6dyp0ebl6T2CJuRuGa8WrHyNrDbLbrV3jy14Vl72NrIPFlT8X+xrbIHTesBna8Cmr22obGSLmoyYWA/rxK0+XYzaxdjT1rdyJ3EPAP5SRVnS0oyFeAacQzf8PhFvR89wES1vQx0pNDMJe5nsLFVGS3169A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80BA968AFE; Mon,  8 Dec 2025 14:10:41 +0100 (CET)
Date: Mon, 8 Dec 2025 14:10:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 REPOST] iomap: replace folio_batch allocation with
 stack allocation
Message-ID: <20251208131041.GA18331@lst.de>
References: <20251208124018.362848-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208124018.362848-1-bfoster@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 08, 2025 at 07:40:18AM -0500, Brian Foster wrote:
> Any chance we can get this one pulled in soon? It looks like XFS is
> still getting syzbot lockdep noise for the alloc this patch removes.
> Thanks.

Maybe add a:

Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")

to make that more clear?


