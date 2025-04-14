Return-Path: <linux-fsdevel+bounces-46357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBEA87DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6821893767
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61526A0C1;
	Mon, 14 Apr 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CnC+IOYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABF1A0739
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627202; cv=none; b=gfRjePeH9WgEFZDuLqWUiAfV4y/fNdFqeitwI81+yaUvgk/R3XdXo6mT/LoW7P7DI2rtFL8LCcdvUpIhBX+9muPtXqnclgTISL/XQDJThg8iQOyEwqsMQhzgUhuvMbb/MEz68f5YFgbW4GRp0x670C/M5Tt8GjzK85znor2EcnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627202; c=relaxed/simple;
	bh=L5UUm7eLoKfIKFtfBCpjodwXOraefBecA0hzSrjO4Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=MwJqGUrOX9w18+oScJq7lKMpp2g1O6y3dbdvjsLXkhPB0Nk4BR44nlqFoiC7QnDMjhF6pZeK9+9Dec9OCLiFpzvMBMyCIXh25WFcJKPAWf4zrFrI+NVeZb0fSikLxa6c7BhkSn9nDA9oR7JWD0F3NqtJ8lvRBzUKq6eTNcmxaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CnC+IOYU; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250414103951epoutp02b9c297d11fe61e7bef2fc24af478f608~2KTALoCyD0551605516epoutp02D
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 10:39:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250414103951epoutp02b9c297d11fe61e7bef2fc24af478f608~2KTALoCyD0551605516epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744627192;
	bh=Ij2jlfdBmad02S/FYcNq2O5ecmEzUAcgUlv7kTwtyok=;
	h=From:To:Cc:Subject:Date:References:From;
	b=CnC+IOYUf40QB1RctsGANUbb8ax8LixYuZ7OEbvk9qpOZiEvrdWFIOLZdFAkIw9QV
	 3k6pBubDhBHw5dd1gEbnFkXeKJmJ9aTw9NFemVLWBbUiROfKzMbh/uss/t2sYdo5uq
	 hmYTO7uSTSyVIVFfjcZX//EFQZCD2f09mge6efqo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250414103951epcas5p31496150fa235bd584b0ae93d0785f765~2KS-oP2m62932629326epcas5p3Q;
	Mon, 14 Apr 2025 10:39:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ZbkLt0cXZz6B9m9; Mon, 14 Apr
	2025 10:39:50 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.8F.09842.5F5ECF76; Mon, 14 Apr 2025 19:39:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250414103656epcas5p29c741b0a7cc539f8f84de34c1c816dd8~2KQczFVfP0044900449epcas5p2R;
	Mon, 14 Apr 2025 10:36:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250414103656epsmtrp14e59549ef5ae250d4454bbede974f382~2KQcx6BoC1187911879epsmtrp1h;
	Mon, 14 Apr 2025 10:36:56 +0000 (GMT)
X-AuditID: b6c32a4b-33ffe70000002672-72-67fce5f5f841
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.C6.07818.845ECF76; Mon, 14 Apr 2025 19:36:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250414103654epsmtip2e23fe417842a28998408baafa53633a8~2KQa9-wXE0745107451epsmtip2P;
	Mon, 14 Apr 2025 10:36:54 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: linux-fsdevel@vger.kernel.org
Cc: anuj20.g@samsung.com, mcgrof@kernel.org, clm@meta.com, jack@suse.cz,
	david@fromorbit.com, amir73il@gmail.com, brauner@kernel.org,
	axboe@kernel.dk, hch@lst.de, willy@infradead.org, gost.dev@samsung.com,
	Kundan Kumar <kundan.kumar@samsung.com>
Subject: [RFC 0/1] Parallelizing filesystem writeback
Date: Mon, 14 Apr 2025 15:58:23 +0530
Message-Id: <20250414102824.9901-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmpu7Xp3/SDToum1tcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLGxOeMlr8
	/jGHzYHX49QiCY+ds+6ye2xeoeVx+Wypx6ZVnWweu282sHmcu1jh0bdlFaPHmQVH2D0+b5IL
	4IrKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlxJ
	oSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSY
	kJ3x/tcStoLjnBWr391mamC8zd7FyMkhIWAi8WPSNmYQW0hgN6PE1InSXYxcQPYnRonpzcvZ
	IBLfGCWuHsmEaXi6/iobRNFeRontty+wQjifGSU+TvkD5HBwsAnoSvxoCgUxRQQUJS6/dwIp
	YRb4zShxbuNeJpBBwgKmErMOLGEFsVkEVCWubX/GAmLzCthIdJ/+yAqxTF5i5qXv7BBxQYmT
	M5+A1TADxZu3zmYGGSohsJJDonHnWmaIBheJ1q2rGCFsYYlXx7dAvSkl8bK/DcrOljjUuIEJ
	wi6R2HmkASpuL9F6qp8Z5GhmAU2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SOeTC2msScd1NZ
	IGwZiYWXZkDFPSQ2nT7ACgnEWImerrXMExjlZyF5ZxaSd2YhbF7AyLyKUTK1oDg3PbXYtMA4
	L7UcHq3J+bmbGMGpV8t7B+OjBx/0DjEycTAeYpTgYFYS4eVy/pUuxJuSWFmVWpQfX1Sak1p8
	iNEUGMYTmaVEk/OByT+vJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBAemJJanZqakFqEUwfEwen
	VAPT3spdy2qPHwiYd+vHshmJJreeN0d3G6RN07Ny2cnDyzZ74YKf1sznA7umHPv6WaDuh9q3
	JxKrG798ZA3WWHCZRd12+v+Aw9NEpN6+ntDl5qBl/6It/RGzeMWTTv2eeAlxO7eZRVuy8sKn
	WTj2H1qZ0+l5nm2+ZFnHnYnXg+339tWrf2QR13i6O/T2wvK6qQ1b/27ex5E0PYQxnvlgfi0X
	y4+HavtVq//vuf+gcE9HR+f/kH7/UpOHupf5WuQ7DbZzuNyU4VzKtkztgtOh6kSFhux5Fy2O
	cxjdCkq/kVGxXtTt86PACP1HbzwfpMxoc82YFS+TumS92MRZp+TtvgvOFAj4o2s4dXHKV22z
	9FNKLMUZiYZazEXFiQB2kMk3RgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvK7H0z/pBmu/S1tcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLGxOeMlr8
	/jGHzYHX49QiCY+ds+6ye2xeoeVx+Wypx6ZVnWweu282sHmcu1jh0bdlFaPHmQVH2D0+b5IL
	4IrisklJzcksSy3St0vgynj/awlbwXHOitXvbjM1MN5m72Lk5JAQMJF4uv4qWxcjF4eQwG5G
	iWOP37NCJGQkdt/dCWULS6z895wdougjo8RzoBO6GDk42AR0JX40hYKYIgKKEpffO4GUMAt0
	M0k8O/YcbIGwgKnErANLwOawCKhKXNv+jAXE5hWwkeg+/RFqvrzEzEvf2SHighInZz5hAZnJ
	LKAusX6eEEiYGaikeets5gmM/LOQVM1CqJqFpGoBI/MqRsnUguLc9NxkwwLDvNRyveLE3OLS
	vHS95PzcTYzgqNHS2MH47luT/iFGJg7GQ4wSHMxKIrxczr/ShXhTEiurUovy44tKc1KLDzFK
	c7AoifOuNIxIFxJITyxJzU5NLUgtgskycXBKNTC1ihruZ+IPzspf9SSwqmX1Z2vRHQqnt8Qc
	Klp0cteNsNKf8196/bxaLHDZze/X6VUdxxZvmdV1X6qEa2lnm+rT4OMCAXt0L7LliJR5lDzf
	JVbivvXBzAXqnC8y7mmbnbk7+3ON0DJGDSnmbA696tpVdabPTm7b+e7/4fMZEm36pWx7vr4/
	rWPT8/uY1v3+XW9EbrD9l5CWs1Q7v3pmhVyht/TB44emdAlf/Nqgp8cRPlWyfP3pjxubgxV9
	Ct0ru+cyvrsXx54c/inO3tpQfyZft1NvzwcWpzTPw1POXqpjPZglW2iQF75tb+qKBrXjgeJf
	PokHOzCevxVkxf7eyf3G+dV7214/mFGysHbhqmNKLMUZiYZazEXFiQB3euuBCQMAAA==
X-CMS-MailID: 20250414103656epcas5p29c741b0a7cc539f8f84de34c1c816dd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250414103656epcas5p29c741b0a7cc539f8f84de34c1c816dd8
References: <CGME20250414103656epcas5p29c741b0a7cc539f8f84de34c1c816dd8@epcas5p2.samsung.com>

Based on feedback received during LSFMM 2025 discussions, we have
implemented a version that parallelizes writeback using N writeback
threads (N=4 in this version).

We create four delay work instances (dwork) per bdi_writeback. The
scheduling of writeback work is done in a round-robin manner across
these workers. We continue to use a **single set of b_* inode lists
and a unified dirty throttling mechanism**, while achieving parallelism
through multiple workers processing the same list concurrently. This
avoids any inode list sharding or dirty throttling duplication at this
stage, keeping the design simple.

In our internal evaluation on a PMEM device, we observed a **120%
improvement in IOPS**, demonstrating clear benefits from enabling
parallel submission even with the current global structures.

We look forward to feedback and ideas for further improvements.

Kundan Kumar (1):
  writeback: enable parallel writeback using multiple work items

 fs/fs-writeback.c                | 49 ++++++++++++++++++++++++++------
 include/linux/backing-dev-defs.h | 10 ++++++-
 mm/backing-dev.c                 | 16 ++++++++---
 3 files changed, 62 insertions(+), 13 deletions(-)

-- 
2.25.1


