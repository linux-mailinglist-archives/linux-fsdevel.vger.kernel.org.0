Return-Path: <linux-fsdevel+bounces-49430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A19ABC2D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A940A189EC21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D22286401;
	Mon, 19 May 2025 15:48:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0528136F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669726; cv=none; b=hYzQg5WQS4CHU8qY2JUL7gDvzgD1VBFiMh6YzPwVDqOE6cNpvgwbK+Cm1PTWQNHYDlfrNX33xjUEvhzxomjBKXg+4YecSZOROCFNBWbwvM3SPUxPPd+XuoyrL0qsqBJ3wAfctsERZ4YzeFZg/3lmhyuIlho7qxxcPMME+/+rMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669726; c=relaxed/simple;
	bh=klVvXbaIjmuGu8aphGrhSlG+ZCqPc08r4LqnxM9k4xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHWD9td8lj7tGxFbsP/Cm5vLfBsJnSx2YxdpaFRVzdkISleycN7XtuFhsSHUzqCWHUBHH18Gah0NqmkIn5XZSHrPYN3xM3Oyuv2CjmiO4UMakX324EW9gl6fKRov7g6v4lU+slJ4I09hnnQwcYPVjNcIpPyRdEaGRGoMOs2BeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54JFm0AH016863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 11:48:00 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 328302E00DD; Mon, 19 May 2025 11:48:00 -0400 (EDT)
Date: Mon, 19 May 2025 11:48:00 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 5/8] ext4: correct the journal credits calculations of
 allocating blocks
Message-ID: <20250519154800.GD38098@mit.edu>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
 <2e127ed8-20a2-4610-8fd8-e2095bde0577@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e127ed8-20a2-4610-8fd8-e2095bde0577@huaweicloud.com>

On Mon, May 19, 2025 at 10:48:28AM +0800, Zhang Yi wrote:
> 
> This patch conflicts with Jan's patch e18d4f11d240 ("ext4: fix
> calculation of credits for extent tree modification") in
> ext4_ext_index_trans_blocks(), the conflict should be resolved when
> merging this patch. However, I checked the merged commit of this patch
> in your dev branch[1], and the changes in ext4_ext_index_trans_blocks()
> seem to be incorrect, which could result in insufficient credit
> reservations on 1K block size filesystems.

Thanks so much for noticing the mis-merge!  I've fixed it in my tree,
and will be pushing it out shortly.  If you could take a look and make
sure that it's correct, that would be great.

						- Ted

