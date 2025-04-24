Return-Path: <linux-fsdevel+bounces-47305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB4A9B9ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFCE9A1D04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016C214A7A;
	Thu, 24 Apr 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5/DWZ6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B72701AC;
	Thu, 24 Apr 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530291; cv=none; b=e8eN83rIiqdqe4Z7FVqoBESPXimZwEbvTUVQimu+fTJPH+QhUCv41DL8Ox4QprA5xGGpDrtmZ+tL8KtrBOM3z4IZC9fT7r2sAyZ/z3jucOdkyPXS2kqUmhbc+49U2K0rX9N8OHKx9mwANoUXwpSkhYItxNBw0NDRrtf7lnSWgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530291; c=relaxed/simple;
	bh=6NpWWj3GUEAM3z5cbBZ771+ojouQt/ZxsmtkejH7N1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsCb/4svPdwAE33fUkOyKVVIEUnkdKQLJtLE+eJx5T37TVTRtvjr4kPzOedDNmz0Esqj3WPKamrNV3FsBoTHGOTE5CY5S2HmtBDeaNRj53LZeRiV4B3P6Gq64MIZNk4H2FVSphUqBDcDp4flwNs1e14RWunJ7f6wlO77ZhDVM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5/DWZ6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C5AC4CEE3;
	Thu, 24 Apr 2025 21:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530290;
	bh=6NpWWj3GUEAM3z5cbBZ771+ojouQt/ZxsmtkejH7N1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5/DWZ6cdFR9yvU4JXIO8vIXtAQfmLHZRzC8CcHW0N2zNyZ66zdj4I/2TLog2rsQb
	 eZKi9F1Fk4b6kKQdPtxgrmaTLtZQhIVbOzt/LnfMdLiBwQrrsk5j2qhlRpLhd0D+ZS
	 W/TaL7YadZ2Ar19rRqNwqaKwYvwuYSq0PbuFEtMpQOqfY+Nk7pfYA50Gt7HKodm+3L
	 rt3NW1dm2cBqUtlWvSpFee3pGnzECQY4CZepgsTv+N7HiVVEKK3M7OlTwOBfxdf3z9
	 Z4w+k39Iea06TVhW3qNlbttCIZ9S5LzrngeQ1f/JaUx6iOsNfpGKwEZ1Mo6ahTemfT
	 MDE1Dt3in1O6Q==
Date: Thu, 24 Apr 2025 17:31:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] NFS: Enable the RWF_DONTCACHE flag for the NFS
 client
Message-ID: <aAqtsdSDsoSAN9nl@kernel.org>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
 <ec165b304a7b56d1fa4c6c2b1ad1c04d4dcbd3f6.1745381692.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec165b304a7b56d1fa4c6c2b1ad1c04d4dcbd3f6.1745381692.git.trond.myklebust@hammerspace.com>

On Wed, Apr 23, 2025 at 12:25:32AM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> While the NFS readahead code has no problems using the generic code to
> manage the dropbehind behaviour enabled by RWF_DONTCACHE, the write code
> needs to deal with the fact that NFS writeback uses a 2 step process
> (UNSTABLE write followed by COMMIT).
> This commit replaces the use of the folio dropbehind flag with a local
> NFS request flag that triggers the dropbehind behaviour once the data
> has been written to stable storage.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

