Return-Path: <linux-fsdevel+bounces-57823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA58B2595A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 04:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DA06835CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089301E98FB;
	Thu, 14 Aug 2025 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rHEOnAos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94E2BD03
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755137041; cv=none; b=CgRmLX2dXINPTOT51F28o6hp0b8m2AcIxCQH69wCS4tWteHd/87DA4A7c05qccdsIf9iFKpEwBemfTA+xR2mvD+WzVKNQPIrAeRNZ4pxDNQAykNIVzfqrBS+qJwImT43LX2iJ6HENgLQa8YWAjAE8vqWVkuWekU5HLN4Je+5TNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755137041; c=relaxed/simple;
	bh=Nlz2zq+7Ed1oxv/zl2MmRt9rZOeRRzzFyTyLnzpBAss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=krrsV3ut091PCCuj7+xr388iGW6SNxzqcLr6WF6DchHBvzvBXmwjO1ej1pwAhMOXjLJ9oAv5jkUvbt7iTI0urFlGxQbpj1AcpBM36S1M+RKPaJHGWRvKgSFPU2CuT8+/Fm/Y2WpQjjKBwKve6WO73e/+TiSbXvEbMfwxC/9Hq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rHEOnAos; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250814020355epoutp01e45374b29896f8c8cc92dcf2e7d1da85~bf9W99Mf_1881918819epoutp012
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 02:03:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250814020355epoutp01e45374b29896f8c8cc92dcf2e7d1da85~bf9W99Mf_1881918819epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755137035;
	bh=jCwzQcziGQJPaS2z0W7Ec6m88sdVgyGM9pwy5hDfB/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHEOnAosJAz9WkzIxc2kdDT4qGpwbruIiNXCf4+Kp1RDhMR4G4nVsT1nQosT8PX07
	 uIK8ILaXyf8IGmLXfB5dLkt6OCxjt5XinpKo7WA4XsQorEmuVP+3ILSKR/AmQvM+p2
	 9s647ZfjIHKhN9ORGY7rbz0ScZQVF38TsOJ+LZfQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250814020354epcas5p443628be2d093d33846543cb9a91d616b~bf9WGmhzT0113101131epcas5p48;
	Thu, 14 Aug 2025 02:03:54 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c2T7F68J3z6B9m6; Thu, 14 Aug
	2025 02:03:53 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814020034epcas5p47c78b2cf41ab9776a2eb5a4face4ff77~bf6br0Phk0553705537epcas5p4J;
	Thu, 14 Aug 2025 02:00:34 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250814020033epsmtip2116a4fd9e0165b67aa12dbb0e1e0c009~bf6aTxWhy2557625576epsmtip2N;
	Thu, 14 Aug 2025 02:00:33 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: dw@davidwei.uk
Cc: kbusch@kernel.org, amir73il@gmail.com, asml.silence@gmail.com,
	axboe@kernel.dk, io-uring@vger.kernel.org, joannelkoong@gmail.com,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	tom.leiming@gmail.com, kun.dou@samsung.com, peiwei.li@samsung.com,
	xue01.he@samsung.com, cliang01.li@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v9 00/17] fuse: fuse-over-io-uring.
Date: Thu, 14 Aug 2025 01:55:57 +0000
Message-Id: <20250814015557.510174-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f966d568-f47d-499a-b10e-5e3bf0ed9647@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250814020034epcas5p47c78b2cf41ab9776a2eb5a4face4ff77
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250814020034epcas5p47c78b2cf41ab9776a2eb5a4face4ff77
References: <f966d568-f47d-499a-b10e-5e3bf0ed9647@davidwei.uk>
	<CGME20250814020034epcas5p47c78b2cf41ab9776a2eb5a4face4ff77@epcas5p4.samsung.com>

On Mon, Jun 23, 2025 at 14:55:32PM -0700, David Wei wrote:
>Similar for us at Meta.
>
>I have been toying with an idea of a solution that does not need (major)
>client change and does not depend on FUSE io_uring. I think if it works
>then it will be more broadly applicable and useful.
>
>I'll have something to share soon.
>
>David

Hi David,

Is there any progress in the plan you said before, can you share your 
thoughts? our plan is currently encountering bottlenecks, so I look 
forward to whether there is a better solution on your side.

Best regards
--
Xiaobing Li

