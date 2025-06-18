Return-Path: <linux-fsdevel+bounces-52042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BB8ADECE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B2D169F20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AAF28A1F5;
	Wed, 18 Jun 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dWl+VCJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FB881E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250490; cv=none; b=bBC1DI5YQhGPzNu9vxBXKlZRLWZrTBcpb6q6N7pXC5UhRT4DZLgd3MOrsXevZa4z1Tu7MlMaSaCPaZFqHeCUy++l7NKWH6bCSEZkUO+V9bO+mIl8AS+y1g6iT61ZYpLfw2qT9DZ0tiS8oyVFHPoQH7JP97riUIVcJcKTZp/8JLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250490; c=relaxed/simple;
	bh=mTeeJrGp2O4RrG81X2NW3bq/Hi+IHW1Tfz8RkMcWtJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=X0mXDaUedAIxTH8yyz+WuPjx7U0Fh0UwGORqrJKEoH7oBWqIGhFvMdOzdv3MCWkaQXWFU/vG1Q7Z54lF1h5Eq4QnVyhXurNysSxGOu7c2uiwlD8YDrtFl5kYJURhPDVAQpoTqgjEhvzqhVC6HwcnkcQ4SORLNlC2aHyqdgXjw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dWl+VCJP; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250618124119epoutp0193778b87b60c416c1067452014e3b9c1~KI4m27AQg1064010640epoutp01L
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250618124119epoutp0193778b87b60c416c1067452014e3b9c1~KI4m27AQg1064010640epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750250479;
	bh=5s/wZN1rEqOyc/F0BTVCU7qZZbNewaPLTjEMmE1a5p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWl+VCJP2z368ScbcgZuj1T+h9jV4ErlytICmQmfg3nd9HElQ6VrBbxKsv7iKRkmP
	 fyxvvSZnLbPN+kg9LKjhqmGyQzgwd9n0m9XG4Vbp+ax1SKwYZOwCZLzn4aRrfqMs8K
	 LFaN5h9cSInJ63j3TP+H1OEtaA4hlOrDKisWHJs0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250618124118epcas5p112697c263b6a190b0c1172b85b53ab9b~KI4mPnvoL0145101451epcas5p1V;
	Wed, 18 Jun 2025 12:41:18 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.178]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bMjz03XLhz6B9mC; Wed, 18 Jun
	2025 12:41:16 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250618105918epcas5p472b61890ece3e8044e7172785f469cc0~KHfiQhMR02744127441epcas5p4C;
	Wed, 18 Jun 2025 10:59:18 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250618105916epsmtip1c25225a98fe4c26c5ed7e60d66c64c1e~KHfgqodKj1704417044epsmtip1i;
	Wed, 18 Jun 2025 10:59:16 +0000 (GMT)
From: "xiaobing.li" <xiaobing.li@samsung.com>
To: bschubert@ddn.com
Cc: amir73il@gmail.com, asml.silence@gmail.com, axboe@kernel.dk,
	io-uring@vger.kernel.org, joannelkoong@gmail.com, josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, tom.leiming@gmail.com,
	kun.dou@samsung.com, peiwei.li@samsung.com, xue01.he@samsung.com,
	cliang01.li@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v9 00/17] fuse: fuse-over-io-uring.
Date: Wed, 18 Jun 2025 10:54:35 +0000
Message-Id: <20250618105435.148458-1-xiaobing.li@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016-fuse-uring-for-6-10-rfc4-v4-0-9739c753666e@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618105918epcas5p472b61890ece3e8044e7172785f469cc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618105918epcas5p472b61890ece3e8044e7172785f469cc0
References: <20241016-fuse-uring-for-6-10-rfc4-v4-0-9739c753666e@ddn.com>
	<CGME20250618105918epcas5p472b61890ece3e8044e7172785f469cc0@epcas5p4.samsung.com>

On Tue, Jan 07, 2025 at 01:25:05AM +0100, Bernd Schubert wrote:
> The corresponding libfuse patches are on my uring branch, but needs
> cleanup for submission - that will be done once the kernel design
> will not change anymore
> https://github.com/bsbernd/libfuse/tree/uring
> 
> Testing with that libfuse branch is possible by running something
> like:
> 
> example/passthrough_hp -o allow_other --debug-fuse --nopassthrough \
> --uring  --uring-q-depth=128 /scratch/source /scratch/dest
> 
> With the --debug-fuse option one should see CQE in the request type,
> if requests are received via io-uring:
> 
> cqe unique: 4, opcode: GETATTR (3), nodeid: 1, insize: 16, pid: 7060
>     unique: 4, result=104
> 
> Without the --uring option "cqe" is replaced by the default "dev"
> 
> dev unique: 4, opcode: GETATTR (3), nodeid: 1, insize: 56, pid: 7117
>    unique: 4, success, outsize: 120
> 
> Future work
> - different payload sizes per ring
> - zero copy

Hi Bernd,

Do you have any plans to add zero copy solution? We are interested in 
FUSE's zero copy solution and conducting research in code.
If you have no plans in this regard for the time being, we intend to
 submit our solution.
 
Best regards
--
Xiaobing Li

