Return-Path: <linux-fsdevel+bounces-69060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B62C6DAFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAE654EDC06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD560335567;
	Wed, 19 Nov 2025 09:13:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F1333434;
	Wed, 19 Nov 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543582; cv=none; b=iEE4eOyid9jNLj6GKyHj5KtlJRM8LbNtSARXqk3xn7CoQOKeRxXMnc0QLolrP0a2kmjMdnwfkNUlYdqQTsyyni6Y7hkPaIhHKsYiZrtJU/G/HlUzVOvZYwB9Z0kf6nErB509TLLM2mk6zB5ykvvu5jFLiKQ1vCRraABCeGec1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543582; c=relaxed/simple;
	bh=begKkJiVe4YEQfd4EE6xA+vIrhMa4XIx8QHlQ+rkfW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+KYcumopNNw2jOYD4xSy+hfUYaA5TZD2nmDqVMgfrU+ku08nQzXAa0gHiAdJ74w34CtV/pTJ7/vaGoYT0AMJZhMb0SGtkbp2rbMYuqskvPut7MdKUw+Yq40JEZ5HBBjMvjmkc5r0EnzDtPeE00jzooY2WROyzJaub4ep801Y2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46EF8227A88; Wed, 19 Nov 2025 10:12:55 +0100 (CET)
Date: Wed, 19 Nov 2025 10:12:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
Message-ID: <20251119091254.GA24902@lst.de>
References: <20251117132537.227116-1-lihongbo22@huawei.com> <20251117132537.227116-2-lihongbo22@huawei.com> <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com> <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com> <20251119054946.GA20142@lst.de> <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 02:17:07PM +0800, Gao Xiang wrote:
> Hongbo didn't Cc you on this thread (I think he just added
> recipients according to MAINTAINERS), but I know you played
> a key role in iomap development, so I think you should be
> in the loop about the iomap change too.
>
> Could you give some comments (maybe review) on this patch
> if possible?  My own opinion is that if the first two
> patches can be applied in the next cycle (6.19) (I understand
> it will be too late for the whole feature into 6.19) , it
> would be very helpful to us so at least the vfs iomap branch
> won't be coupled anymore if the first two patch can be landed
> in advance.

The patch itself looks fine.  But as Darrick said we really need
to get our house in order for the iomap branch so that it actually
works this close to the merge window.


