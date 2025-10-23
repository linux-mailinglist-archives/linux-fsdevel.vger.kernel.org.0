Return-Path: <linux-fsdevel+bounces-65405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE8C04783
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71E5E352DCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5B26ED4D;
	Fri, 24 Oct 2025 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I8CQH+HV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D582638BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286623; cv=none; b=N98kLjDWgV2wvtShsaOS0zxHYqXeL/+FxktALaaTiUWr1lYMqDrqZlFFbwkV0pbYARHEbQDJN6uVhhS3fiSf4E+t5J5SVrG2UbawscuyfrvIZuWHJWYFAEP3QrCsap5Ap5E29lEtfyPYtocAT03Twtvp/42urMZXYmauormwx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286623; c=relaxed/simple;
	bh=YPnA93Wh1bBBzKEPIdaJjQJvHgUFqdhAPskl/v9c75Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sekdqatXjQFAyCoRIUz3S6SPpJIimJqpY657l8qLYcGKmdYtENfmzGsyehGNqVMIuuTmep2l+4n/UUa0BXEt6r/yo+70Bii4N3CUpq+rdqkLKrhnvmHvlBSPs0IadZ7vN3gx2ssP5SjFUDycR2WlvgTWT1hO2si9Gen0gFPjnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I8CQH+HV; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251024061659epoutp023f36646e5ec6619dbf992c54901ff625~xWNkpkI8Q0061500615epoutp02G
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 06:16:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251024061659epoutp023f36646e5ec6619dbf992c54901ff625~xWNkpkI8Q0061500615epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761286619;
	bh=FcWXJ7UtwImvTyidf8i1hfurTHqyVZnZBDqTbC3WeBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8CQH+HVEcXekYfDFmoADfdQko+Ca3MZLlg7VinnMgEkcCfciLDvZJcki6hIpNKWT
	 oCKIGne1ZFIIjQh2BqlTEyzed50LiDs2qW9+jNPTlM+T6LEZy6DyTQxxY3RbOTw2JE
	 WvGJAFEJIqZnmL3fXEgU0dRmP3vb7PPNBfeYU6uI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251024061658epcas5p14ae50183664551188b2a424bcb76d59d~xWNkCq5z61911919119epcas5p1D;
	Fri, 24 Oct 2025 06:16:58 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ctCNT4SFfz2SSKY; Fri, 24 Oct
	2025 06:16:57 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251023114956epcas5p33a9384d06985dc5936fd355f1d580fb2~xHHAMFpP01949719497epcas5p3A;
	Thu, 23 Oct 2025 11:49:56 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251023114955epsmtip282df6d2b9dc7d901448bca0aa19a36ae~xHG-MMKnc1364213642epsmtip2O;
	Thu, 23 Oct 2025 11:49:55 +0000 (GMT)
From: Xiaobing Li <xiaobing.li@samsung.com>
To: joannelkoong@gmail.com
Cc: asml.silence@gmail.com, axboe@kernel.dk, bschubert@ddn.com,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	joshi.k@samsung.com, kun.dou@samsung.com, peiwei.li@samsung.com,
	xue01.he@samsung.com
Subject: Re: [PATCH v1 0/2] fuse io_uring: support registered buffers
Date: Thu, 23 Oct 2025 11:45:24 +0000
Message-Id: <20251023114524.1052805-1-xiaobing.li@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022202021.3649586-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251023114956epcas5p33a9384d06985dc5936fd355f1d580fb2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251023114956epcas5p33a9384d06985dc5936fd355f1d580fb2
References: <20251022202021.3649586-1-joannelkoong@gmail.com>
	<CGME20251023114956epcas5p33a9384d06985dc5936fd355f1d580fb2@epcas5p3.samsung.com>

On 10/22/25 22:20, Joanne Koong wrote:
> This adds support for daemons who preregister buffers to minimize the overhead
> of pinning/unpinning user pages and translating virtual addresses. Registered
> buffers pay the cost once during registration then reuse the pre-pinned pages,
> which helps reduce the per-op overhead.
> 
> This is on top of commit 211ddde0823f in the iouring tree.

Do you have any test data? How does the benefit compare?
By the way, how were the changes made to libfuse?

Thanks,
Xiaobing Li

