Return-Path: <linux-fsdevel+bounces-29214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7E9772B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4A1C23D1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD01BFDE5;
	Thu, 12 Sep 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hH6eRhNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AC13CFB7;
	Thu, 12 Sep 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173028; cv=none; b=lNgkw33PGhcN/DWr/+FuQLUWQX2Rg+4jT8jw6f0RKat0QcVmgnehYfDhGn7dg3livgaZ2fK7tvvDbAZrmBqnC4HB3uNoJ7wnXgc5w64LR0746Pz37IQ3BRkQI0getOwurO/8mUrio4M2oA9SVOpw3NXvMtLeRUTh3PjdOKd0hUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173028; c=relaxed/simple;
	bh=JoPUxbKNemTOQj/Zcm/S7ujkVqb72FxciPCp7L8rpDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbvfW0pj9AMMXuSmocpBgLbIxfe1PpYwoa+d4eHbrFJ48OtJrfptsoppMI0omNGYHdmk51sxQ+7V9Qr7xcpZ2qVbGEzkw14jCz9GL/XZzj19uiNhDfrv6qJE+4rXBLfyzT/CTk0GK5M1LO8BiMxcaUzTdcHeanPPHYOYOyt/u4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hH6eRhNt; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4X4Tb03tzXz6ClSpy;
	Thu, 12 Sep 2024 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1726173015; x=1728765016; bh=JoPUxbKNemTOQj/Zcm/S7ujk
	Vqb72FxciPCp7L8rpDU=; b=hH6eRhNtR22x34qVLVhBhAs9zKC5jX5xUull0HKd
	cmgxk/UNnJpKcxNkOIS17H1Xfp7QcWx2voAJSOzuTvSJx0cgMJUC5tX1dK1gEy8z
	OO778DUdPMTBViGFqSys0NpdDVtclnF1VD2ZjcqJ/sC+92pEzv8dNzsIIFFLdykd
	+xsBSJnXpae75RDkwsn423y6Ahy4jNvODjnLhKsJElbcD9NhsXuH84irg2/gNejC
	siDnbqIQQn/WkqYdUhuq6eP+mdkDv0OeISTR+4Y5SC0wGgqhUMLgcun2Yzv9kmuy
	kzYxWZsFBAFm5IdevMHuC93m7imVwEcbPuTSBVuc/lFBvg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WSfMN2Lf5--p; Thu, 12 Sep 2024 20:30:15 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4X4TZq34P1z6ClY9y;
	Thu, 12 Sep 2024 20:30:11 +0000 (UTC)
Message-ID: <fe2ae1b7-7c77-49e1-ace0-50e937f2c32c@acm.org>
Date: Thu, 12 Sep 2024 13:30:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] fs, block: refactor enum rw_hint
To: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51@epcas5p3.samsung.com>
 <20240910150200.6589-2-joshi.k@samsung.com> <20240912125347.GA28068@lst.de>
 <0baddb91-b292-db90-8110-37fa5a19af01@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0baddb91-b292-db90-8110-37fa5a19af01@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 8:50 AM, Kanchan Joshi wrote:
> Wherever hint is being used in generic way, u8 data type is being used.

Has it been considered to introduce a new union and to use that as the
type of 'hint' instead of 'u8'?

Thanks,

Bart.

