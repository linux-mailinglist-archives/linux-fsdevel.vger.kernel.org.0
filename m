Return-Path: <linux-fsdevel+bounces-41685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C386A34E21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BC67A362D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D97245AEC;
	Thu, 13 Feb 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J18r+3rD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746628A2D4;
	Thu, 13 Feb 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473126; cv=none; b=D+wUuHelPIhdvOWvGUMp+vJj4E3BOt4De4SJVsv1f74r9vbmzAzGFiikguZNMGAxVTjdA5HPgsAICdwkuGN94QsfNlqJCFw1o1rHYC8Iz6vbL1kq3Nx0LLwIdMV/6lFAA2sd5UJbLxZRrsxCDTRS3aMeyQRxdjlldnQrBqt9W4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473126; c=relaxed/simple;
	bh=6sDJlSoSB6OyOTz8Dgjk0vu48VK/T6MJQoAk7124MpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwPgGpvAxC6Ivh53gllznnfpIfl4XVFzbzBHNU042Qd8438gdVZ1cAKTWmq4bC9J0pngm/h9nDGcsRlKZNIil/dfeyv1ZmPSoHT/3Nt2MJnMuN5aN1ncgi4WLi3FV1aPPEt06NEBUr9+D7bcWPW+artoDyT57dJ+zKARbpnZ+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J18r+3rD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R4b0h7FqmJlvC2DizuTBY26FKGSe4gJx/CxHPTGlIA0=; b=J18r+3rDuIvgjOP9k+dgrPziY/
	tWwmhY+Ftoj2pveta1KauLFh6NkUhNTVW0hR0YE3MygusiN5n//X6P4fjQnU3lYVFkkvKkNfTx8gm
	D4pDbg7+BIZd19SVULDjiX7MZTnhAX9GrX6ggoEDr3Ty53VG8VE0nPczQIBJSt0A8y25UbR1WC22T
	o5eIP+hULg4gAYgILHvLZeYPQP8+neqHpcdmp/p7RkUeVsijXnrrOhy1bQfQIqQhQSmqiEgvA/bYE
	5ggJkyNP6ouUKleDy9451Xw7SxIiBggYNtL2KNzTWMx0hxrTsY5/CEmnl0+lnriZSokxIcfo+TWub
	u12ZJH0w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tieQ3-000000091eS-3FDp;
	Thu, 13 Feb 2025 18:58:39 +0000
Date: Thu, 13 Feb 2025 18:58:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Tinguely <mark.tinguely@oracle.com>, ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] ocfs2: Use b_folio in ocfs2_symlink_get_block()
Message-ID: <Z65A3yJ_40TtsGko@casper.infradead.org>
References: <20250213183730.2141556-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213183730.2141556-1-willy@infradead.org>

On Thu, Feb 13, 2025 at 06:37:27PM +0000, Matthew Wilcox (Oracle) wrote:
>  		 * copy, the data is still good. */
> -		if (buffer_jbd(buffer_cache_bh)
> -		    && ocfs2_inode_is_new(inode)) {
> -			kaddr = kmap_atomic(bh_result->b_page);
> -			if (!kaddr) {
> -				mlog(ML_ERROR, "couldn't kmap!\n");
> -				goto bail;
> -			}
> -			memcpy(kaddr + (bh_result->b_size * iblock),
> -			       buffer_cache_bh->b_data,
> -			       bh_result->b_size);
> -			kunmap_atomic(kaddr);
> +		if (buffer_jbd(buffer_cache_bh) && ocfs2_inode_is_new(inode)) {
> +			kaddr = kmap_local_folio(bh_result->b_folio,
> +					bh_result->b_size * iblock);
> +			memcpy(kaddr, buffer_cache_bh->b_data,
> +					bh_result->b_size);
> +			kunmap_local(kaddr);
>  			set_buffer_uptodate(bh_result);

hm, now that I look at this again, I think this should actually be:

                if (buffer_jbd(buffer_cache_bh) && ocfs2_inode_is_new(inode)) {
-                       kaddr = kmap_local_folio(bh_result->b_folio,
-                                       bh_result->b_size * iblock);
-                       memcpy(kaddr, buffer_cache_bh->b_data,
+                       memcpy_to_folio(bh_result->b_folio,
+                                       bh_result->b_size * iblock,
+                                       buffer_cache_bh->b_data,
                                        bh_result->b_size);
-                       kunmap_local(kaddr);
                        set_buffer_uptodate(bh_result);

ie use the helper instead of open-coding it.  I'll send a replacement
patch.

