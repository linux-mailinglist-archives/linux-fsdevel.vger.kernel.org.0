Return-Path: <linux-fsdevel+bounces-42914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14140A4B669
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 04:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CE91890BF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 03:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61E19ADA4;
	Mon,  3 Mar 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbzSZBJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2327156237
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740971747; cv=none; b=L//bOyw2gQVdjfIK1MAbB9OW99+dvnMCMbafS+Cj03BSYoT0n3A9sirvl6TaN6gyCdHFR/PCTEiiDSn/owVSdnaXhHYTiROu6JHGz9UWznKXwAUWbyTJ+eSjZuva42JTwtV8QcxOM0V1GeVsas7HHlOzPOCYb3egwzF45dUXAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740971747; c=relaxed/simple;
	bh=5M/kwU8mFCcQDQ71TdlsVXaQJdVcyUzLgfKCSWf6PZc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uxDYfYqtJ37DnWkZ927er0hnUcKzYzAH8C+1oWsxN/36dNTsOvT7vrCvqVQYQRnSPWlcd/6MAGLde6pwEBhBJpw56YfT4EIjkq80RPuaimrfnIaOO3tZC6B2alLIG7wsmm6RW0FwIW2F8cqTkmT6rMTsJf/d6Dc4aIKW9mFBA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbzSZBJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B5FC4CED6;
	Mon,  3 Mar 2025 03:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740971747;
	bh=5M/kwU8mFCcQDQ71TdlsVXaQJdVcyUzLgfKCSWf6PZc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KbzSZBJqN6E30b7AjA7koMSrqH1JdCVxLVZWT/v2TbYGvHvLxMklNhGpkMCy4R0xk
	 /HMsZB69cwCoSEHcPSli+YBnmIzIutoEraG/+yKOssVD4WYNjEvRnkfPXzGj/h3FC6
	 Qpdm+qB3/nGS+EeuAjC9Uncwn22wq29LKX94cs+n3On6sDqibptNCYeyLnTt2AN60g
	 HR7KRMrE+NKI1wvtTXrB0CQAO+vBTaMwNBQTSSjsr+JABXbGmHCM56vuSe6JwIRKyz
	 mFj7I1Qp7XtRpMplGG33WLLp145A5icUWXMzeewFmBOSnT4uZAR4xeyfJRQKZV0XAn
	 ZcU8wC/p85v+Q==
Message-ID: <152da38e-ecb1-4333-8c86-b0fc343d7de7@kernel.org>
Date: Mon, 3 Mar 2025 11:15:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/27] f2fs: Add f2fs_get_node_folio()
To: Matthew Wilcox <willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-18-willy@infradead.org>
 <39268c84-f514-48b7-92f6-b298d55dfc62@kernel.org>
 <Z8Jq7PQNRDu_zmGq@casper.infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z8Jq7PQNRDu_zmGq@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/25 10:03, Matthew Wilcox wrote:
> On Sat, Mar 01, 2025 at 09:15:53AM +0800, Chao Yu wrote:
>>>   struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
>>>   {
>>> -	return __get_node_page(sbi, nid, NULL, 0);
>>> +	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0);
>>> +
>>
>> 	if (IS_ERR(folio))
>> 		return ERR_CAST(folio));
>>
>>> +	return &folio->page;
> 
> No need.  It'll probably generate the saame code (or if not, it'll
> generate worse code) and this wrapper function has to be deleted in
> the next six to nine months anyway.  We use this idiom extensively.

Oh, correct, seems return value '&folio->page' is equal to value of folio
as I checked.

Thanks,


