Return-Path: <linux-fsdevel+bounces-52472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF16AE34BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98CD16A165
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 05:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF071CCB40;
	Mon, 23 Jun 2025 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejJRgmOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F8E111BF;
	Mon, 23 Jun 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656580; cv=none; b=nuI+7Dj6+xO3LuMov9DJn9UQQfjMQZS5hr8W3uKqJi7q6NTRATM6LP6aB3V8oStQ920zPWjMdH3i7AMHA4eIJDp0KoN/n7Mc4wpPCDfTfEFvYlwUFBZhp6fKzc8q6+D+tSl7g1+on+IAF5vnyLpgg4DFjzDYhypJd2GfJlVoB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656580; c=relaxed/simple;
	bh=F6BRBeuSR1TeFsMTMq1pEcye1ArudEGY1QZ6DuiFeZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKBg56XQas07ZxXce0DF0gFsw6Px732xaFBRckDciLPcIq1YjjqciHlMQfQnf8xqUGhBsHqiLkiMXpL5y2+9i9viX7qM3NAyN7AEblWwrFktRTSKFkZDmwzXfVeJCnteaJxrjvlh2iqaS2CN0pz9h/r42oFWz2ZqrXvTYRXQh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejJRgmOx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N40QC5So83rB/6WLXPMiNJLeHTV9mbB3EpCgLUC629U=; b=ejJRgmOxh7AAULZXaPok1qmFLW
	MWRE/meLeOwqkSuWukpx1nUSXSCj8yx8UPZPNXvOxw1LOjufiyTMhiU9ad01QqwJjGEACtYIus+vP
	NwNS+WCNDZzyeo5S8JRf6Cj4iGJeI1kN1azTlkr38udsqhMtv10HlIpkcn7qEhRVs6dhxZzBUt8zw
	7ly2ugGaJWgBOGkTrRq/chMHN/LYmaYvmk4tlxrWD8Nh1OrXyKPs/V0+qWw9EUgWhZn6BYRU8M3KR
	sEk53FDH0Is3gyLCccZjZ/wE1Ch5IkKWYFKaLyAGtRMX6DlYsq1bE1E7bvnyF6YyCJJOtuam5h5JU
	sDJ5CN7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZkL-00000001cZS-19uQ;
	Mon, 23 Jun 2025 05:29:33 +0000
Date: Sun, 22 Jun 2025 22:29:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v4 1/4] block: rename tuple_size field in
 blk_integrity to metadata_size
Message-ID: <aFjmPan6bmE8Vh1b@infradead.org>
References: <20250618055153.48823-1-anuj20.g@samsung.com>
 <CGME20250618055213epcas5p32ccbe13f8ed11ffa0beddaddb9a51595@epcas5p3.samsung.com>
 <20250618055153.48823-2-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618055153.48823-2-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 18, 2025 at 11:21:50AM +0530, Anuj Gupta wrote:
> @@ -299,7 +299,7 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
>  static void ext_pi_type1_prepare(struct request *rq)
>  {
>  	struct blk_integrity *bi = &rq->q->limits.integrity;
> -	const int tuple_sz = bi->tuple_size;
> +	const int tuple_sz = bi->metadata_size;

I guess keeping tuple here is fine because we're deep into PI code.

The rest looks good as well:

Reviewed-by: Christoph Hellwig <hch@lst.de>

