Return-Path: <linux-fsdevel+bounces-53160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9400EAEB161
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D9F6409A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3723E32E;
	Fri, 27 Jun 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVFWeBEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC614A82;
	Fri, 27 Jun 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012985; cv=none; b=Zjgeb3e8ojj24DKJtqwUOhl44zFvv23tzUna3OR1Deh9BqEVmJz4g09sbqXi+mytw8nWJ1Qd9/Kx/EgSl1DYmaVA6uIgTiBWnX2Z7P/FiPWxAvtVyh56DnRFaIyFZTay0NrmBtmB5NIIlmf/hU8hPoTYAimV8APz3aUIdfmJgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012985; c=relaxed/simple;
	bh=S+0b6RBp5G0qxNe663dMVIN5ss+FqxgnHIgtbU+oHNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ur/B28eU8CH+2hvMTy3hkwZx+SMPrKnqWXxQz03AWcoX7+tBkNNBpZAlq0M/5O2qMOzmWPTdPF+R8HXriW592WHnwqNwYT4XRVYTQGdEUbPeTyO2D3lhcxC/66VydBe0uPDf3Vu1SFdUuNhzYqnGX90z0MH1m++9/6FhP9ePGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVFWeBEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0508C4CEE3;
	Fri, 27 Jun 2025 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751012985;
	bh=S+0b6RBp5G0qxNe663dMVIN5ss+FqxgnHIgtbU+oHNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hVFWeBECPOImrvSE4B/jZTZ8hCfORPxnmPocap+XkdS42dMlPAu3cMJWN8ArLwHlV
	 8qHk37W/kLJ9U4DcO8BMApOGk9VVbdL/RyNY6Wz/4K16oidde2YqqCR5X8kk92eUnN
	 w0QGHhsFDubsVzr8zt5Y9Wt9cORKRJsumIfi3AMh3+G/TbotVYzY4p7nMfqnkR2WYt
	 t3QjWwVKbiRhRsvJ2XaaBUIdgXkbP4ZImC+/GuRw9tzalQGiLmrvPP2hsJN8WE8L6n
	 0nN4EbriPkkGTcVoFXdFYlmLf95ujwkJge3qZlT7vHre/gbH3JOxYUPA3knd/ogqvg
	 9+BoKvviFXpXw==
Message-ID: <df3ba688-2b76-4cb8-b47d-abbfbbd29e68@kernel.org>
Date: Fri, 27 Jun 2025 17:29:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] iomap: replace iomap_folio_ops with iomap_write_ops
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-block@vger.kernel.org, gfs2@lists.linux.dev
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-11-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250627070328.975394-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 16:02, Christoph Hellwig wrote:
> The iomap_folio_ops are only used for buffered writes, including
> the zero and unshare variants.  Rename them to iomap_write_ops
> to better describe the usage, and pass them through the callchain
> like the other operation specific methods instead of through the
> iomap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

