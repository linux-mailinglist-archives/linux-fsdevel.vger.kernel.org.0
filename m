Return-Path: <linux-fsdevel+bounces-69213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C3C72EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 09:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6CD0C28D5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD213309EF5;
	Thu, 20 Nov 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="soGEu9R6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8E1F237A
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628094; cv=none; b=dUllt02mwCnrt9LMOCFb+l+grd/5tLoy6T+fBpudLzrnWi8Qbmeo5EoEnjiUBlB/ClXLaS5A5ZUK1SuyiEIDncq9+PKtzGYOYTghjNWtwWdhjVh+7Zg2CcpGvWAqWmjKNFZtRaJiPbhqqmbX2+n3pp77XKc3wWMoV3S9nQxOcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628094; c=relaxed/simple;
	bh=a+Ko+9/6hNYV6lTw4ktbfpvFHlUUFwDMtHOyMZhYLyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QniuWt0gG46sp3/HhstaI79Kxss2ubdPr7LK9NqsIFB27LsgX5qOuKXwIzUf0EFdspCws/uReFhZexnTrf1pUugExsTkat3vPtRseBjn2mrJpbj+aN2T5kI+tO1iGOZ7b3PLIzuDrPsDHsIbI8Sb0GERfeNWodhZyZ54oNm3IqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=soGEu9R6; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 65E4A26;
	Thu, 20 Nov 2025 08:38:03 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=soGEu9R6;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CF9681FA3;
	Thu, 20 Nov 2025 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763628090;
	bh=j7/Fec3HDKEwL1U2vsxaErjjsgD3NAnE3XHdDoxgk08=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=soGEu9R63km8Fn+1H/XUpEstJJJGz5S6eTXlF84ruQxE0TM3ZCUW5A6qnCcJ8K7kX
	 4vNOR8IpiE2kUGnOOu+Q4QOd0s8TmWhXk5Q1DZ3nKNPRZ+77EcAIlFn2YjvMRYOUsl
	 2qWbexugdGlb94Y01KCEwLhU8yUcA/BExEvG49Yw=
Received: from [192.168.95.128] (172.30.20.202) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 20 Nov 2025 11:41:29 +0300
Message-ID: <d41f1c70-32d6-40ed-963a-888916176906@paragon-software.com>
Date: Thu, 20 Nov 2025 09:41:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Compression fixes for ntfs3
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
References: <20250718195400.1966070-1-willy@infradead.org>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20250718195400.1966070-1-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/18/25 21:53, Matthew Wilcox (Oracle) wrote:

> Hi Konstantin,
>
> I found three problems with the NTFS (de)compression code.  The
> first two are simple inefficiencies; there's no need to kmap these
> pages.  The third looks like a potential data corruption (description
> in the patch).  I've marked the third one for backport.
>
> I haven't tested any of this; it could be that my analysis is wrong.
>
> Matthew Wilcox (Oracle) (3):
>    ntfs: Do not kmap pages used for reading from disk
>    ntfs: Do not kmap page cache pages for compression
>    ntfs: Do not overwrite uptodate pages
>
>   fs/ntfs3/frecord.c | 50 +++++++++++++++++++++++++++-------------------
>   1 file changed, 29 insertions(+), 21 deletions(-)
>
Hello,

Thanks for the patches. They have been applied and will go out with the
next pull request.

Regards,
Konstantin


