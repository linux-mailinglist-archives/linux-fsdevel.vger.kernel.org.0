Return-Path: <linux-fsdevel+bounces-36686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A329E7BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 23:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5508916C7AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 22:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D21EE014;
	Fri,  6 Dec 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QiYYNh5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936222C6D9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524443; cv=none; b=WnQfPajpg5XrzrNQe56alYwztiPgsgB1ou1THUzzMQb3gXAmXBwI6E8SpYg4H+ZkAj5F+h5Oek99682Eh5AbZIUAbZK8Lc1vqfAsSYEUYqN7fC9Zv9gTNq963h+CJfshL2YhfWSUbPLJJizHgf5TYRpgddjzAIrzNVaAHG37RTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524443; c=relaxed/simple;
	bh=ODAwEGKODz2xw4URm2ZO6oZmSWV8hC3FI3pP3buLL5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvI9BjO2lcRSqZgDzU4+jYKSWrU0LYVYCjWzXb+wGqId/Q5inpBvAHBPGEbPi0Q7DQO7VQoIIbmFE5h1taUrJJ1Zf8UwFeqgdUpJZn/R9xjxDk7kudlZFsUiPMcQOcGI1UuuFTLZWF7kgzHLeClqwMUpZO9CfChFQo9fB/UuuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QiYYNh5b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/rjGpD+k9YWGImQOvoS0TB18MkVWD4Yf3GNVMcT1eKc=; b=QiYYNh5bEfu9snHKV49OykliSD
	Dxk6y0ep4jKLydm1xzqmQFNx+8CU9lfHQtxK0woO5XkQBsjOEf2n0213h5+SU7MAyztNNdPQS31G7
	vWOiQd+2OIL2lQm9fDdT7MtLdOjf8TkfkqPf9NF7ANCfKDN+ONk0Zxac2KsijYgzErRbtm3XYDhap
	bKaIceaEqmYxby+e86BtkcuYfHjyysJ64ZyhrY4VCJUBHKoqSbM5PW2zTqx/Ym8WzmsIdBw6grKF4
	20tNfoQ786H29OmNyd4SEP6eHxBpALhNYcmqmYRGl8OUbbMy6MS0iywqnQC/QaPHBKvn4Yq3RrL56
	6e3mnLsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJgtY-0000000F5Dc-3wFG;
	Fri, 06 Dec 2024 22:33:56 +0000
Date: Fri, 6 Dec 2024 22:33:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v2 00/12] fuse: support large folios
Message-ID: <Z1N71FJYYIqF0P8_@casper.infradead.org>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com>
 <CAJnrk1bwat_r4+pmhaWH-ThAi+zoAJFwmJG65ANj1Zv0O0s4_A@mail.gmail.com>
 <spdqvmxyzzbb6rajv6lvsztbf5xojtxfwu343jlihnq466u7ah@znmv7b6aj44x>
 <CAJnrk1ZLHwAcbTO-1W=Uvb25w9+4y+1RFXCQTxw_SQYv=+Q6vA@mail.gmail.com>
 <k5r4wheqx4bwbtnorrzath2n6pg22ginkyha4vuw342tvn4uah@tjy5j2kvbuxk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k5r4wheqx4bwbtnorrzath2n6pg22ginkyha4vuw342tvn4uah@tjy5j2kvbuxk>

On Fri, Dec 06, 2024 at 02:27:36PM -0800, Shakeel Butt wrote:
> For anon memory or specifically THPs allocation, we can tune though
> sysctls to be less aggressive but there is infrastructure like
> khugepaged which in background converts small pages into THPs. I can
> imagine that we might want something similar for filesystem as well.

khugepaged also works on files.  Where Somebody Needs To Do Something
is that right now it gives up if it sees large folios (because it was
written when there were two sizes of folio -- order 0 and PMD_ORDER).
Nobody has yet taken on making it turn order-N folios into PMD_ORDER
folios.  Perhaps you'd like to do that?

