Return-Path: <linux-fsdevel+bounces-39675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB3A16E60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5753A85E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584971E32CA;
	Mon, 20 Jan 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btF4+XTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07F13D531;
	Mon, 20 Jan 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382941; cv=none; b=tDECKvTrEwCPE1F0zqdu+B8li7yjYo2oh0A6qjfIEWi4UW8kuy8znYQg756uM1cdMz3LGrXeOVuzBoHWfxJnFuvcGC7/l68mF3a9AaCP9o9MpBgjCh6lWT9HCTIFRE7PmUkYtSN/GkRz0FHwhaPO0x9kJ7JBaR2a7w3C5SALG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382941; c=relaxed/simple;
	bh=Q/ah7Xad9Pkqp3TtguBsx5XKqUkR2Fz8GupvOx/hv9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjYov7FU33SR04Bi6AxjqKa+1bXiugrKAwEohvOk1dZCt+zNLJUjWzloJIdUmaZ4clExck/V53EgDF0ThV9FmK49IO46B/prmKzMDDfbCHkp8N6f8ZdHVklsROgl6WjUa8BGJUE4026k2VxB+2alaHL9qQ+Df5r7hRkPWWwbBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btF4+XTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5B3C4CEDD;
	Mon, 20 Jan 2025 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737382941;
	bh=Q/ah7Xad9Pkqp3TtguBsx5XKqUkR2Fz8GupvOx/hv9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btF4+XTFOp0ga6T7d+3J8b/geuEwFuwnlTi+lf83vRcdKRoTVfYz+j7wryq5Tg4lu
	 ZK3w9rFFY3hmH8PuksePlIqesvWZnTUqA5jg6XYq0s3ob+luFv7MtS9OMUIw9Fb+d1
	 PpTguh1N6eFf7/CK1jWbCTnY1iq78Zvb3ZoUwJ2J9PeBxfNfaTQ1fh/lj/8M8/iUgY
	 EHdLjEY/Swkp03kzxyfecr+1HAz3x7k6EHPdayAGuGa01d6bD/g5yKqk6R2xDjIVze
	 ItO6SThpO9X9ifELiuv6JUqG2086TJNksTrRHaJ2VUjnGiHZkb8ogNz+vmlMHbJNkL
	 Sy6xKQupyurPQ==
Date: Mon, 20 Jan 2025 16:22:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, John Hubbard <jhubbard@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>, brauner@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving iov_iter - and replacing
 scatterlists
Message-ID: <20250120142217.GA153811@unreal>
References: <886959.1737148612@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886959.1737148612@warthog.procyon.org.uk>

On Fri, Jan 17, 2025 at 09:16:52PM +0000, David Howells wrote:
> Hi,
> 
> I'd like to propose a discussion of two things: firstly, how might we improve
> iov_iter and, secondly, would it be possible to replace scatterlists.

<...>

> Rumour has it that John Hubbard may be working along similar lines, possibly
> just in the area of bio_vecs and ITER_BVEC.
> 
> 
> [*] Second: Can we replace the uses of scatterlist with iov_iter and reduce
> the number of iterator classes we have?

<...>

I would say yes to the questions.

Regarding rumors, I don't know, but Christoph, Jason and I are working towards
this goal. We proposed new DMA API which doesn't need scatterlists and allows
callers to implement their own data-structures.

See this "[PATCH v6 00/17] Provide a new two step DMA mapping API" series
https://lore.kernel.org/all/cover.1737106761.git.leon@kernel.org
and its block layer followup "[RFC PATCH 0/7] Block and NMMe PCI use of
new DMA mapping API"
https://lore.kernel.org/all/cover.1730037261.git.leon@kernel.org

Thanks

