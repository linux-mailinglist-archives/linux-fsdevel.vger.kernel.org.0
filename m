Return-Path: <linux-fsdevel+bounces-65741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094DC0F668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E2B1899E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5931355C;
	Mon, 27 Oct 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4gKZFAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146403081AF;
	Mon, 27 Oct 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583370; cv=none; b=TBs+3SZ4962NxSpeD5SPyiVl4yLxAzVGSaJQjWGTawI10cnUdO4KVTLVWRFQXh6Hk2lGokHSM5vIB1zLw1mL2dc3mzor2OgXTXbctaNQQ+Ye53HcpnIrp4qxBiigdmzrJHNdz7Jz/E/XG0asqaDdMEQC4OU66vMvJSogZRNQa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583370; c=relaxed/simple;
	bh=7KuIAIGuO2wSIDUcJW7UohH7Zeu7LKko0qrMiZx0fJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkoXuVyqNwAtgjapjt0W4lPGX+EVU/9bfyEv4f6TjDE8OVkLtTk41gFzHXvBFrRG2dxxDm9OOpLp71JKO6flkbm9ZppFu09Jnr4NHfQyXP3HmhPX+VQnln70ouRadBIikJ+siRD1kM1BhQgKjvrREFdlF39umQnp3afZGZ3uHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4gKZFAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FA3C4CEF1;
	Mon, 27 Oct 2025 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583369;
	bh=7KuIAIGuO2wSIDUcJW7UohH7Zeu7LKko0qrMiZx0fJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4gKZFAHZdaOjDIgvLa9XEriftggTEuBx7dagBcfcFYgFD+SypFBaO12AvdDer+2J
	 eDnitoACTlHv6w6Bn3ac47I6WG4U2VqMtJJoOf9MyFl43cZKBF4HfSDuV/yu/42b60
	 bAeWQOAXZGbN2D9vNkdcXYvnGcKuVqEMrp07augHrl/hIS36LuHSS2661Nr/O4RiIW
	 +7e9rPEiuSpp/G+LHX7Dcjv/aYOS5TOmlpOPjoIYiykiQEQ5SJUKv+d8tndp+9cOJf
	 Ru1NJoTesa7iRypBdfEJIa8njarDd+20aduE1cSG8Xjzl023cBCdCaNAjdM9XBguuK
	 mpPHxW2LnKF/g==
Date: Mon, 27 Oct 2025 10:42:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aP-hByAKuQ7ycNwM@kbusch-mbp>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-c5gPjrpsn0vJA@google.com>

On Mon, Oct 27, 2025 at 04:25:10PM +0000, Carlos Llamas wrote:
> Hey Keith, I'be bisected an LTP issue down to this patch. There is a
> O_DIRECT read test that expects EINVAL for a bad buffer alignment.
> However, if I understand the patchset correctly, this is intentional
> move which makes this LTP test obsolete, correct?
> 
> The broken test is "test 5" here:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c
> 
> ... and this is what I get now:
>   read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)

Yes, the changes are intentional. Your test should still see the read
fail since it looks like its attempting a byte aligned memory offset,
and most storage controllers don't advertise support for byte aligned
DMA. So the problem is that you got EIO instead of EINVAL? The block
layer that finds your misaligned address should have still failed with
EINVAL, but that check is deferred to pretty low in the stack rather
than preemptively checked as before. The filesystem may return a generic
EIO in that case, but not sure. What filesystem was this using?

