Return-Path: <linux-fsdevel+bounces-62735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2CB9FA19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8950A2E3B12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E2271A94;
	Thu, 25 Sep 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzgsiAoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD69273D77
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807750; cv=none; b=CPSwelkPtF+HmyZsZswTTeQqe5VAbHbqytKrxb9TBRx2ctOZeKJEaAt/kXmKzt5/hCOke635tf44bp2/IkO6Jgo3I2lmDyMBiZSQmEi0qot2cd6gx1urIavIl9NheTw9fIRNJ59bMnkm4LOjrz4ecY1PV8yHRcizGZHUxofofwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807750; c=relaxed/simple;
	bh=Y+Z5VweaxNo98sxze2uq71chnnEKKyIcAUcYSz2klsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGaAx2+jlr0f0rrFjhcHjrxkcFZenOLQ3Z1VDXL6uGMmXHkAZbfkj+suOV6WBdrJOoQhHTzd4BqjicMNlsfaHCgZ+WEePoZUZEj9lwCwRKZMX2AfocCGyPj443YIiqvXltdkxgcGMcVXfOSLvdx8heHMo1gbSbuSLAelfraWvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzgsiAoK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758807747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsqFl/Do4XNVgzaopDPTKMKOMfF8uLBrpBiM7b5J/1I=;
	b=hzgsiAoK3XwEnoOJyWrEzFDHfDyW+DOkR8IWNjf9R01xxznzbQHOeYA721zpQ0hWWznWh2
	qUXZ93Ozb+gFAvdDCfngBF4aYFYsQ0eWcGmd0+80gCzyjGPGLkW3AzEKBcmvgY3+jFWEQo
	iurQnKmsIrARlqBz/AqH54jFmGtbxGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-SJBbuv2-P8KTz3OtAFZ55Q-1; Thu,
 25 Sep 2025 09:42:23 -0400
X-MC-Unique: SJBbuv2-P8KTz3OtAFZ55Q-1
X-Mimecast-MFC-AGG-ID: SJBbuv2-P8KTz3OtAFZ55Q_1758807741
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 996D11955F18;
	Thu, 25 Sep 2025 13:42:21 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AED230002DA;
	Thu, 25 Sep 2025 13:42:20 +0000 (UTC)
Date: Thu, 25 Sep 2025 09:46:30 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: adjust read range correctly for non-block-aligned
 positions
Message-ID: <aNVHtoCIJOOG966b@bfoster>
References: <20250922180042.1775241-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922180042.1775241-1-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Sep 22, 2025 at 11:00:42AM -0700, Joanne Koong wrote:
> iomap_adjust_read_range() assumes that the position and length passed in
> are block-aligned. This is not always the case however, as shown in the
> syzbot generated case for erofs. This causes too many bytes to be
> skipped for uptodate blocks, which results in returning the incorrect
> position and length to read in. If all the blocks are uptodate, this
> underflows length and returns a position beyond the folio.
> 
> Fix the calculation to also take into account the block offset when
> calculating how many bytes can be skipped for uptodate blocks.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/buffered-io.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8b847a1e27f1..1c95a0a7b302 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -240,17 +240,24 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	 * to avoid reading in already uptodate ranges.
>  	 */
>  	if (ifs) {
> -		unsigned int i;
> +		unsigned int i, blocks_skipped;
>  
>  		/* move forward for each leading block marked uptodate */
> -		for (i = first; i <= last; i++) {
> +		for (i = first; i <= last; i++)
>  			if (!ifs_block_is_uptodate(ifs, i))
>  				break;
> -			*pos += block_size;
> -			poff += block_size;
> -			plen -= block_size;
> -			first++;
> +
> +		blocks_skipped = i - first;
> +		if (blocks_skipped) {
> +			unsigned long block_offset = *pos & (block_size - 1);
> +			unsigned bytes_skipped =
> +				(blocks_skipped << block_bits) - block_offset;
> +
> +			*pos += bytes_skipped;
> +			poff += bytes_skipped;
> +			plen -= bytes_skipped;
>  		}
> +		first = i;
>  
>  		/* truncate len if we find any trailing uptodate block(s) */
>  		while (++i <= last) {
> -- 
> 2.47.3
> 


