Return-Path: <linux-fsdevel+bounces-55651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C3BB0D44E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A558C7A4D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825CD2D3202;
	Tue, 22 Jul 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mTIn/bwS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533912D1901
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172359; cv=none; b=CPeO7rdB0oAviCfE2LgfhHJM/v1/go59mdhZJMDHcEtGLhnx3q0V6mRhlysMS++b/wtlBmQ2WlgiM8leeaW0BZfT474pa+T5Ze5KoaY5zFaHspWLFucsDVLi1zlPjQYDgkIx/0pug0I0s0XXO7zKUK7jUQ9W4oNWJhdKYWTO/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172359; c=relaxed/simple;
	bh=2np78owCtY0zXiGio/2IvH6pWtbfqh7vq32px6BlLpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=igZqePPGKPvNC8vWzos+exkeY4nNsM+lIWDW18ZOvysDelAln+ElNYgQy2HXsQY8959U3y8LWFz3XLVgpworrr6zYkJxFVfwkHkbiuozauSSuEkr3V+YpH5+BRbJApcTVrdL0ES/9+/rtZvJc/bR/z3zSbjnYUWdrwKA/WQcYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mTIn/bwS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250722081911epoutp02442e28fc2ef6154b64248ae301a6fae4~UhPbw-vD_1452414524epoutp02p
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 08:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250722081911epoutp02442e28fc2ef6154b64248ae301a6fae4~UhPbw-vD_1452414524epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753172351;
	bh=AxUcsZm5yZiXaI15ZeDb0qU35ud3so0yBE1NGQ4Ni+U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mTIn/bwSlLWIwrUN5ufEHb0NRKcXvjBKHPRzPYXNYNzoUjm2fEPF88YQIsj/MRSBk
	 mtzPEgapuDCYAWsto1mGPtHk1JKXnMLjmSI5PDNt2Sxh+wcNPmNce+RB5Ht8d8iIKm
	 l1VbUPQFzrNZy7Ptpvk40sZkzLl9l/Dhg6CqPGOo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250722081910epcas5p442aa60e9967bf401c7041948a9ef0f58~UhPbKjWI00169401694epcas5p4A;
	Tue, 22 Jul 2025 08:19:10 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bmVXs4xG9z3hhT3; Tue, 22 Jul
	2025 08:19:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250722081729epcas5p12dc547bda002c28435d83dc7e972c105~UhN86SA4s1721417214epcas5p1z;
	Tue, 22 Jul 2025 08:17:29 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250722081727epsmtip1d6ed31e2cf992237114606f812d63623~UhN636tdp2238122381epsmtip1Z;
	Tue, 22 Jul 2025 08:17:26 +0000 (GMT)
Message-ID: <8072a659-0cab-43fc-bff7-618942346646@samsung.com>
Date: Tue, 22 Jul 2025 13:47:22 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v5 0/4] add ioctl to query metadata and
 protection info capabilities
To: Christoph Hellwig <hch@infradead.org>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	martin.petersen@oracle.com, ebiggers@kernel.org, adilger@dilger.ca,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <aH8xY3PyejzGdUp7@infradead.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250722081729epcas5p12dc547bda002c28435d83dc7e972c105
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f
References: <CGME20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f@epcas5p4.samsung.com>
	<20250630090548.3317-1-anuj20.g@samsung.com>
	<aH8xY3PyejzGdUp7@infradead.org>

On 7/22/2025 12:06 PM, Christoph Hellwig wrote:
> What's the status of the fio patches to support PI now that this
> has landed?
> 
Hi Christoph,
Vincent and I have been working on the corresponding fio support - its
nearly ready. We plan to post the patches soon. ITMT, here's the WIP
branch for reference:
https://github.com/vincentkfu/fio/tree/pi-block


