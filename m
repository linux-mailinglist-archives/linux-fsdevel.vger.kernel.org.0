Return-Path: <linux-fsdevel+bounces-75272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKyGIT9mc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:14:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DE1759EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFD323006459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0A9329386;
	Fri, 23 Jan 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DWqqPd2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF63242B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170492; cv=none; b=IwOWt3twoY0P8B4R6LHSqfCswz1HW26ADhZeF6N6MMDcfUwSuZMfMc+Odf+Gwzep+s2N+GRhOFEFfTNHvd9dO/Td0IOrlGkkjbQ/lul//hAyw5Dsmt/qrV/v9dKjYVMGuS43xlMs5l62dUlzBDt7va/t/BISj944y4ypde6T4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170492; c=relaxed/simple;
	bh=7Fge6Fmkgld7YLUrywNY+EJQXw+yVu+zB01EPx2KCOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Z2sGawXXXJGPQ5RFm66gnrXYwCvX14tZbPHMGoq5EtTIgy1h4EfGPgLhSWuNsiQ/t4gVahtrP6blXDPHO9EvaKW592SWJkMcrYAQTcEheAd562GwLokqQOv7zn5pzeQFin+ZAS7/+TeuPKLSMEdwpw0xK1tIXe04+EWIqJlVHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DWqqPd2z; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260123121447epoutp04c8fb0313632c407fe262c96c96b1856d~NWy90A5dK0395203952epoutp042
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:14:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260123121447epoutp04c8fb0313632c407fe262c96c96b1856d~NWy90A5dK0395203952epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769170488;
	bh=WjQNuY/LaNwimN1LsMDCa88dG7mBi2PdVExVV3Yfqn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DWqqPd2z7EUAQMCM5Hs8H0gWCd+Gl4LMbQzF+RABtsbmBSLFlSAmcS3FVwLoL18Dh
	 tkJW+NhBdXdaEmhQiYM41CceLySsACw7ZPIbAP+mDI0eSO3v2ybVxTPVG4xjLnKE8d
	 gJrXcGEd6pbBbEOeWG6Ki+RHkvMwPPQ6jABfxyOI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260123121446epcas5p38aff88f320af62074288f7e4ac6f9f13~NWy8i-g8u1610816108epcas5p3f;
	Fri, 23 Jan 2026 12:14:46 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dyH1K4xfKz3hhT7; Fri, 23 Jan
	2026 12:14:45 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260123121444epcas5p4e729259011e031a28be8379ea3b9b749~NWy6fJ6rc1107511075epcas5p4I;
	Fri, 23 Jan 2026 12:14:44 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260123121441epsmtip193ddadcef38cfbeda2b4fb04a9163535~NWy4CX07A0851408514epsmtip1x;
	Fri, 23 Jan 2026 12:14:41 +0000 (GMT)
Date: Fri, 23 Jan 2026 17:40:26 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu
	Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: bounce buffer direct I/O when stable pages are required v2
Message-ID: <20260123121026.tujkvhxixr6pgz7c@green245.gost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
X-CMS-MailID: 20260123121444epcas5p4e729259011e031a28be8379ea3b9b749
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_11f367_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260123121444epcas5p4e729259011e031a28be8379ea3b9b749
References: <20260119074425.4005867-1-hch@lst.de>
	<CGME20260123121444epcas5p4e729259011e031a28be8379ea3b9b749@epcas5p4.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75272-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj20.g@samsung.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 80DE1759EF
X-Rspamd-Action: no action

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_11f367_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

I ran experiments[1] on two devices - Samsung PM1733 and Intel Optane
with PI enabled (4K + 8b format). On my setup, I didn't observe any
noticeable difference for sequential write workloads. Sequential reads,
however, show a clear performance drop while using bounce buffering,
which is expected.
Used these fio commands listed below[2]

Feel free to add:
Tested-by: Anuj Gupta <anuj20.g@samsung.com

[1]
Intel Optane:

Sequential write
   | size | zero copy  |  bounce    | 
   +------+------------+------------+
   |   4k | 158MiB/s   | 161MiB/s   |
   |  64K | 4522MiB/s  | 4506MiB/s  |
   |   1M | 4573MiB/s  | 4571MiB/s  |
   +------+-------------------------+

Sequential read
   | size | zero copy  |  bounce    | 
   +------+------------+------------+
   |   4k | 1693MiB/s  | 1245MiB/s  |
   |  64K | 6518MiB/s  | 4763MiB/s  |
   |   1M | 6731MiB/s  | 5475MiB/s  |
   +------+-------------------------+
   
   
For Samsung PM1733:

Sequential write
   | size | zero copy  |  bounce    | 
   +------+------------+------------+
   |   4k | 155MiB/s   | 153MiB/s   |
   |  64K | 3899MiB/s  | 3868MiB/s  |
   |   1M | 4117MiB/s  | 4116MiB/s  |
   +------+-------------------------+

Sequential read
   | size | zero copy  |  bounce    | 
   +------+------------+------------+
   |   4k | 602MiB/s   | 244MiB/s  |
   |  64K | 4613MiB/s  | 2141MiB/s  |
   |   1M | 5868MiB/s  | 5162MiB/s  |
   +------+-------------------------+
   

[2]
Write benchmark -
fio --name=write_new_4k --filename=/mnt/writefile --rw=write --bs=4k --size=20G --ioengine=io_uring --direct=1 --iodepth=16 --numjobs=1 --time_based=1 --runtime=30 --group_reporting

Read benchmark -
Prepare the file:
fio --name=prep_create_prepfile --filename=/mnt/prepfile --rw=write --bs=1M --size=20G --ioengine=io_uring --direct=1 --iodepth=16 --numjobs=1 --group_reporting

Then run the read workload:
fio --name=read_4k --filename=/mnt/prepfile --rw=read --bs=4k --size=20G --ioengine=io_uring --direct=1 --iodepth=16 --numjobs=1 --time_based=1 --runtime=30 --group_reporting

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_11f367_
Content-Type: text/plain; charset="utf-8"


------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_11f367_--

