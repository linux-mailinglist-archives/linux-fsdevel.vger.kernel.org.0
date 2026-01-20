Return-Path: <linux-fsdevel+bounces-74579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A234ED3C061
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDB7F405DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DE2EAB6B;
	Tue, 20 Jan 2026 07:18:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA039341D;
	Tue, 20 Jan 2026 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893520; cv=none; b=tg0PDQBaHpVAxltHrKoCk9Poq5schE3GapKBRKpmz2aVLAVgKWPwsymXz1jphiCVA61NbhWOd1LIdPUymZWI7EYP8E+GFGhOELe2wXUP3yEFJVBmLO97gQApkgus5SE3UWkWWaDeExfDUGQSk0UuKEw2vQ+05EaCtLsaJk/eBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893520; c=relaxed/simple;
	bh=hv09CHIBC9gs4dH9W7BQqLWQWslMmCwqp89ezO3Ehgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgO4ldrrIkFF1HUIyUyFVIH6Q3Kho6fIWvWHIibv1+1pXnMpJp+9xQnPOpdI8ZHao3/RdaibEpjDxPwRl3AeFDehKypR9cgLG7DjBXUdPDKMouzHS8H6XY+urcbwyPb2jqA1GNOIs7mOfJD0FZy64zI3Am625RmSzl79pt06L1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FDA7227AA8; Tue, 20 Jan 2026 08:18:30 +0100 (CET)
Date: Tue, 20 Jan 2026 08:18:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6.1 11/11] xfs: add media verification ioctl
Message-ID: <20260120071830.GA5686@lst.de>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs> <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs> <20260120041226.GJ15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120041226.GJ15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)


> +		unsigned int	bio_bbcount;
> +		blk_status_t	bio_status;
> +
> +		bio_reset(bio, btp->bt_bdev, REQ_OP_READ);
> +		bio->bi_iter.bi_sector = daddr;
> +		bio_add_folio_nofail(bio, folio,
> +				min(bbcount << SECTOR_SHIFT, folio_size(folio)),
> +				0);

You could actually use bio_reuse as you implied in the previous mail here
and save the bio_add_folio_nofail call.  Not really going to make much
of a difference, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>


