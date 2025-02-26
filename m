Return-Path: <linux-fsdevel+bounces-42709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DAA466C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE33188DC12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA921D5BB;
	Wed, 26 Feb 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb9L4/4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D721D599
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586909; cv=none; b=qGcptN0VRGmUmobjTy/LdcOFOGVx3xeGYRgq62+n1JEsnn8uoQCP5O6kREJ164MRq3RtIyfgueQRc8lmcD5VVJ1QXo4l70mHBb77sxfZ5C2iv/DKOM+2bJ7HO5L/kvnhcJ6GCSWFR7NpPdYiZAtbrtLsXkCHNDlso0Czusr+LtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586909; c=relaxed/simple;
	bh=joeQv285/J1l5VQPEP4BktUvhjdG3K+nqWq4ufXR1fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4mzCm4HuVTNm0cjqfuX90nHUhGOp2H1puWurNDoHeU74mtyP4p5a+aQKma1Tfihs0DYcx0RCp5kenf5hsog4H25o5AYWTmyn6rLBpxHNiw4fdcTvnBfszMuUSNK5zz9WRP6hm4qBgqHuqi1IENbYL7P7PrvtYHjVDprmLpGPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb9L4/4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E20BC4CED6;
	Wed, 26 Feb 2025 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740586909;
	bh=joeQv285/J1l5VQPEP4BktUvhjdG3K+nqWq4ufXR1fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eb9L4/4r+StwOmEAlbB2c3kZz68F3AWEZGDCgAP7NRRP9waAbBEtU/Xe56HyI41B8
	 AmqOhgnj4JR/5O1nJNgSjkMjjPhahFoOLiTnUgCLMO6jLCLGzKkNMBt9hw0v2u/q4z
	 o7e2QOsKYvdbP74994J/lf7JvHmH3hW6FwvqfW+rhGBSpidiRWBJKjC4MT8UISFxgJ
	 TfNDJNiwWHNiXF1QQbn765xX6kI/+jBahVNyVmw+Y+nqOvolDMxsC9R3SD9OCv9NbT
	 vA7tiTbiFJiBxe4+SAhmoEA9fZ40nkU8H7jbXHbnfETQPWhPWP+w53TTbZIHUxPBCF
	 bJh955hr0oWug==
Date: Wed, 26 Feb 2025 08:21:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: Assert the folio is locked in folio_start_writeback()
Message-ID: <20250226162148.GA6225@frogsfrogsfrogs>
References: <20250226153614.3774896-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226153614.3774896-1-willy@infradead.org>

On Wed, Feb 26, 2025 at 03:36:12PM +0000, Matthew Wilcox (Oracle) wrote:
> The folio must be locked when we start writeback in order to
> prevent writeback from being started twice on the same folio.
> I don't expect this to catch any problems, but it should be
> good documentation.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  mm/page-writeback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eb55ece39c56..8b325aa525eb 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -3109,6 +3109,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
>  	int access_ret;
>  
>  	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
>  	if (mapping && mapping_use_writeback_tags(mapping)) {
>  		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
> -- 
> 2.47.2
> 
> 

