Return-Path: <linux-fsdevel+bounces-27187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39695F46B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5080F1C21FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A79191F84;
	Mon, 26 Aug 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U9v2H9w7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EG2eisfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253541885AB;
	Mon, 26 Aug 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683911; cv=fail; b=juruwjLhtvYGEjMKRQofj8UgDPVOwxgO/W50lfOMF8sRj04gi10QpXIA4O9BUO+VCDzo/iOLr50gbbrIaIKsrU3sg45Gcknh0CbaysaIjMf06ZhKzqYq6uffd4Rkoe1sEFn4bIcUaPkX21faGwntB26f4oOgjiWEFbFnEYqR9rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683911; c=relaxed/simple;
	bh=Nu763bTBWLD3t+7Wwv3mAV6e8mfwBDSQOcDGd9IIdGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzMN4iaHA9xUR7yExPGOzWAf/oBSfK4q4xA3aSYOV34ICNF6RcOMXEVSX1pYvySNyt98+tozBlXH6ar29mVZ0SE1vNZ6J3aezgieiwakXKquQ7lXqpqM6MnGfzriAIuuHypHJx8x6N06lyj/1zz1byS0MLVmTKbWTp7cGqLaY5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U9v2H9w7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EG2eisfp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfVhY024089;
	Mon, 26 Aug 2024 14:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=b4HmjqzuegXuhv2
	G9jLzRlwDfyYCB2Ehg3vX4+gHf0w=; b=U9v2H9w7+zdU7fHLjDyz64QSL9GKlqp
	v45L/hCSQoaK3qI+GlpsZHSqdPeZOueRGbKSf5Rnys7ZVw926uPhyHxy0eI83tVP
	IUhLZqPdB2RLA4/xSbsSb8ypwlICniu7cbER9Le3dfcHcqktzE6aOa2Sd5rFQpl0
	QTwo/C1zrQYiCLxblLUglU9T0K+5809omlUxeCPxnMxdJfKsAM6icB5W0QUEzagk
	YdRW4EGvjkbf39cYJU5tLG/af1Rsa7DPA8wBJ6ItruNKrgJiUA1v6EWc6gmlJ0Vn
	a2IQPF3g74QzFAxC/rvFNt03vkSvVeEaVlHa+U50RhJD96RGY34/KcQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwk9xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:51:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEeA64036491;
	Mon, 26 Aug 2024 14:51:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jh4m12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/fbb668D1sXD2ipkjgmHwVKUWLBM+NXzWur6J0C+OSVrzCHh/UrdxFg4fclH7BlnPj8Rtx4A0I1oCuAKOWJPaaU5vPnKy/C4O1YSUcVcWkP0PQs9qZxROBah6xVaUP+4wj1dkx4pnu5A+lztJ2wQQn+QaMIwFs5j5QHdFAnyWoPbyEzo5pX9p6Lyj4kE/I3yZq3MF36XCslG8+/b/dioaERfenKZE9XKaD3Z9Cun/vuA5AaCe8zMEnuBZ7Uumt54r/7cyt8Zcbdo94ODKgyRLH8vd45XTldbnKa/AMHNAQYRDf7zGayU6FpOv/rH0LXMowMvNHW5iROG7HtYu1qIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4HmjqzuegXuhv2G9jLzRlwDfyYCB2Ehg3vX4+gHf0w=;
 b=ufkqcyigAmBZCGY9nwYrpkX0JdB8GJ/eVzovAmLyZNV4bx3BTOuleqkJ1sfT3qZhNRrKmBei/fdoS79vUuwZf7iuqJx3maCRhVrvAGM5WW5Y9BzRqEpuF0KgIa49Hw4aqlcaI6FOdFxSOXv+a5y6Hz4NdZxglr950UrjgRIeBLkUYuIhe1XLqXHHgwl2g0DatI5xvCHfOKgVIX0GhmpKh5vyr7byXlbiQf1D4VRsy6u6gulpTtpZ7v0sX+IP9nE1ts1pvwRvioq9wLRzlPUjsdFezU7d2Nvxz5NUw6AkZp2gxkj+EDif190W5Np5+k7yjkdlgXy2gqou5W27xqoiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4HmjqzuegXuhv2G9jLzRlwDfyYCB2Ehg3vX4+gHf0w=;
 b=EG2eisfpNImyulnorEflepBU93W9QQpPjH6/03V1mBPFIFyJ3JiM4DS5q5Uk1Ip/F3icqBjeXGXJ7hUV0j/6g54/daAzQ+Wf0y6QqZr1D0fMzcsI0wifi8h2euTJGAyQz9b0XAUsynmIHqMPm897lIO8U1gsMg0UhMkFLz15Rbo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6761.namprd10.prod.outlook.com (2603:10b6:610:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 14:51:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 14:51:36 +0000
Date: Mon, 26 Aug 2024 10:51:32 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
Message-ID: <ZsyWdI/bgf/x5BTe@tissot.1015granger.net>
References: <>
 <ZstOonct0HiaRCBM@tissot.1015granger.net>
 <172462948890.6062.12952329291740788286@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172462948890.6062.12952329291740788286@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:610:74::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 833752f0-4a88-40cd-f80c-08dcc5de950b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kQy69NRaSx74cWJD9yVQWpgSeKu8Og/bx6CAD1DVMu0zOeNScBbp901f0OGR?=
 =?us-ascii?Q?uZPIwJy3JelpVGXgRVCCSnXSqrRvw4qcnZ0gWpW0c8BrM3cyWS9xGy83CLFH?=
 =?us-ascii?Q?fXOkOZtKV/zZKY/eQmS2PbTLojN1C067/2God0of88CIa4IdQ9vKIkHLQKxU?=
 =?us-ascii?Q?+2AvPPEGvaLpsm+Rzn+mfXCid9VBAMvkJRRPhxtBgVHFzf5hDqfStXH48CeY?=
 =?us-ascii?Q?TnWeos3K6CA8nrLrTY2wvkB2TndMa8FCI0RGThR5CvHi/aI+QeKLDjBa4Q/n?=
 =?us-ascii?Q?1/lw6QVDRFozDcRxP7uOBVx4hkFCd4w3chZsqONNlE41KBa0RVmjp2JCoDe8?=
 =?us-ascii?Q?CbHiZVJdQs00yaDOh8ETiXoVYyIZSuidXdwDHhIh+VXpgGrIgjx7RVLfeLLk?=
 =?us-ascii?Q?1ueouZvafSyY18VmyJlUGPYh0bVykvpKPvaR70FYuuHdES7ldAPcIsIjYPbW?=
 =?us-ascii?Q?Q8CnV72eDXdYguxrwnLs7HlcoiKcfbqXryUf+5CGIBGJPyqpXR3Tygp/doxX?=
 =?us-ascii?Q?3oeN9To1gKH6OsW8n2lqjNmTSaN1iuAHy5REMvoyHIZRHlggmmDTmnNFf3Fg?=
 =?us-ascii?Q?tnV31H2obXGhnIeQZRULRizJm5Yvlf7khQFF6OHqx41GzObiLnQezgizbcVY?=
 =?us-ascii?Q?/fkvaHFXwJYloVQ0j6bmLd17P00ZcHboKpnQOmNX+4BLXerQjXlu5iN/eN8N?=
 =?us-ascii?Q?liPgmNFLdgYn7lMIZGeuLOO47DUHflap5NTmdKmNFB5HLPTSKnK1KUj61imU?=
 =?us-ascii?Q?s7GTaFeimSW1EoIbTSEBV/toMGV7s+D6yr8L1Vz8VolauCdKG8oXgPs2ZI9n?=
 =?us-ascii?Q?F3TdFa3XRwPkgPmyAhx+uVTAH04gb+bjAYsbJWYadKz/CtGfXMB9gzyq2R60?=
 =?us-ascii?Q?R6WPbBFPG85rtAsdEYELTqgO1uXEzpp+u+kdkXkLzpw5Ep5o0sxejQE/K/LP?=
 =?us-ascii?Q?CQ7PA1taxgaiQiPBoZS+MkQulnqGSwbyY2X11Dm4RUcOIlJ1+uP4P1oshkEk?=
 =?us-ascii?Q?3whij2+gjhrSWSTxxoEw+5xeuHBtEyzR/mT/aJhMAV32Ni42JHucDHbpNa92?=
 =?us-ascii?Q?4UaSMQXtjP4rsXV+5Ix8m5hikOUao//14UFU6dZIy4LJMg+7K0aBtUxAEwoy?=
 =?us-ascii?Q?l+ts5CAhJjyX4hdKAFN3oUgt3Z/KF7S33iXWZT7XRIGE9QcA+DroH9UROXod?=
 =?us-ascii?Q?jescwFvTCBskDxueayD5DtsBxRP3MEzTMm66RbTf6NdV1zqeo6y5ouQktR7T?=
 =?us-ascii?Q?Tk3lK9d7ExN/SrVF/NwBpjmHDVuXthgs++sCSFQJiUwkATSkv4P/+mPLcQs/?=
 =?us-ascii?Q?Ma06Z2nl9y1arESVhDcYddmggHKZj/kDaH/JKzllIQU+eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FCAQL/4RcYHSIikP/khQuXnrkTn6xde5fgkxyi+Yu/OcOd+qr8wKPAqmvqMi?=
 =?us-ascii?Q?3bTfJOe64jPy38wFRGvjqkVupnsIVulykeMRzhP9MPa6Q6Yk/xs3hR+TjGL8?=
 =?us-ascii?Q?oofsaV1KYbnySuQPOBvQCG4FSa0EyFS1OQHNQ/I2+U+RFjNyaBgi/0/lxbHc?=
 =?us-ascii?Q?r1KjJWmQoxHLGIsZIk8fxEcBrxj9p/JwTzrArb+o3Zb9Kj9cP5lbh+MAZLUq?=
 =?us-ascii?Q?GjjZmYqq4wUyHJ4DVj/RjNZSv1c6s7mv/ZQHU39WqpeancgDXxeJsQDcO5V1?=
 =?us-ascii?Q?cJq6FVeacGbY1W+k93cvAKLoVSXF2IPZiAhWsqJmU7rFbf+8H//gRLwWyV9/?=
 =?us-ascii?Q?7Dhy3T61Qpagl0GrnFKb7Id2VltqlOQbiP7OLPBc3pCO9Cse+Y4PHwibRD3P?=
 =?us-ascii?Q?PDDrHF7xFDc6x9sKIvmvMJ7Yec7yh+YHfaq0+8bL7CLNS3vV6GNiMUXINayZ?=
 =?us-ascii?Q?01LcTznXBAV0HS3nqHXy5TsxbENWALtKcQ5eqonBfwzeQkqg4nuJgi8hjO4d?=
 =?us-ascii?Q?I53La85qpPchKodu2AQw1dX/Y2z1A0/IOx2Hc6BRw2Lqu/TU+ghyTucJ5xg0?=
 =?us-ascii?Q?IT9Hpo3eVV38ZGdQQ98vHGLuFz4I5+2Y4nh9zI7oQFzPxNUWdZUZ9zGPB9ux?=
 =?us-ascii?Q?naoe2wp6rirz6aOWEmutHkeD1f2JMeqaOCD+ny+XBEjYFGQUd5KNdgCgJ8TI?=
 =?us-ascii?Q?aoeL/vpgssy8MA/Nu/P9f2K1UEl4LmHQ565KoWnk8rY+bpCkE4bILJKhlOJM?=
 =?us-ascii?Q?OFoR60AZpHZUnyXiMywo/9GOa0Fx5BGZ2Bh1RzkObDnTAexMsed/1EPTEt73?=
 =?us-ascii?Q?3mybgTaFOvOqFl82v0Fy8n45WUNC9F5ijrvwracdv9r45cYCUFZZTnSobBqI?=
 =?us-ascii?Q?Xj4kmOPH3XJxtsMRMQ0/MiwBDjb3yOEWykdMZLCBRuQjIbnCatfogX17GRtg?=
 =?us-ascii?Q?HIK/GjXLi96RGACqWpFgCqYYCUZf4lrjns8IGIgIYUnlEEUCwgVLl0E1/DCM?=
 =?us-ascii?Q?vT1EQb27+ikggG0WTRo8LPSzBesfjeXYiYWmfsXIMJ/xQI+aYr/+DCFa2b42?=
 =?us-ascii?Q?W9EIPZJ4jcNrprgWo+Wl0a6/nXKs2oGd03O7kvfWeVCBhwdQPelbDKiq0ovO?=
 =?us-ascii?Q?yFxXEQEntQ4FiV0X2bO/12YLfhdRkFIxaX6En+Yg/qJdC5HOliN6y66z3GHk?=
 =?us-ascii?Q?G8YFOlyj4oO3rU/3vdL6B/Lnkiz9m1BrNQcBVxdjkCTWirnZEIlxW7C5LiOq?=
 =?us-ascii?Q?Z0GUXt883yYwM/nSvqmFuXLsSkRGZdtRqC8ec8+zqQryOazIcNCHWpwMu0t/?=
 =?us-ascii?Q?u2El8VM6ej428ojN55C2Mpo30mlTlTUbTUS973uKdtX/8OSYw1rWedDTK2w2?=
 =?us-ascii?Q?49lqR+PeE7MMvmbUw5MhlOGZ1uDHyT8P1/6u+PDHTcun7fJ10dQlsOdNSDA7?=
 =?us-ascii?Q?sfGzEy9mA68KuFJpknQL/HwwdhYd62rmg7XcfjFGrupOJFp+2gQ9Ba4cumZv?=
 =?us-ascii?Q?LKHDcYW1VwIVpoV143DKcdnVrQWqlXu+77S0w/S9+i38dso3wjW0+0kz0VL4?=
 =?us-ascii?Q?tEXVppoOYC9VzF+YpV/U8FhUaw7CIteqTdOdLFdq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J/AxAMrUzXjj+4YR+iAx1DBe/UacRSS+IP/4DihqtZctnjFGb8U7Iq2hfFlnihoJWBZtyuMMyLSwbIhV+G+iNJtsT+qZPLyQ24fN23Eu/3YKSpM8Df2XZbyT+Nj0nCWbr4//8IokMjPBeZ6OjabCHmeakV1TR32oheEAQlLpTH/gX0JYkfIT1yaUR8P6hPSUn6c2Ng1/dzgH2lfeAUmNksQSf0VJNy+4tfkmQyTRFLCX9NGZH2r7dFH7KceQaGAuOozqJjt6kyVcTUjBtEyjHosywiFo1sJZGZunf1PXWO0MAJf4dqxg0Et60lqfWtMqfR9s/quPcVhG3N7qk8og5ydEDZufdY5O5r8aIH5568tI4+B9VX4dPrhtSP0STPUvE3v4iy8Xm7i5b3eKDjzFtl7pfqoOsCtOV91XyYApy6Thtv91LhUuml5Hhzu8u3PkzT6oRGDboMWCvS/IbsQNqNEg7qsuaTo+fvIiabLnnud/Qu5+/DTUnGognrhWV+MBEXNkJW4Sg4K/uce7NIeEHJkCptPyRTtbp2M7sLE5XrUVrJpgG2OCPImdOM4gXYWxwPwH/LB9vX8ls4JoNH8nk+4G+P8tUrremDCivdmi5YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833752f0-4a88-40cd-f80c-08dcc5de950b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:51:35.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf2tE8v3grnyprgpY/T26/KNRv8Xl3taLxddpbc85NcR7uzmZmB1zU1dwRLitnyPhR5xOrndK2BwQSqXDSUuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_11,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=723 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260113
X-Proofpoint-GUID: sPhTSNcEWRutA6Yy4-1GKkNZ9-HkuzEi
X-Proofpoint-ORIG-GUID: sPhTSNcEWRutA6Yy4-1GKkNZ9-HkuzEi

On Mon, Aug 26, 2024 at 09:44:48AM +1000, NeilBrown wrote:
> On Mon, 26 Aug 2024, Chuck Lever wrote:
> > See comment on 5/N: since that patch makes this a public API again,
> > consider not removing this kdoc comment but rather updating it.
> 
> What exactly do you consider to be a "public API"??  Anything without
> "static"?  That seems somewhat arbitrary.

Anything that is invoked from another, distinct, area of code
presents an API boundary.


> I think of __fh_verify() as a private API used by fh_verify() and
> nfsd_file_acquire_local() and nothing else.

That is indeed the current situation. But practically speaking,
there's nothing that C can do to prevent other call sites from
appearing over time.


> It seems pointless duplication the documentation for __fh_verify() and
> fh_verify().

We have that duplication already for the family of nfsd_file_acquire
APIs, for example.

These two, however, take somewhat different parameters, and
somewhere (in the code) you have to document things like "this one
expects a non-NULL @rqstp". Some API documentation, even for
"private" APIs, is valuable.


> Maybe one could refer to the other "fh_verify is like
> fh_verify except ....."

Highlighting the differences is certainly helpful for human readers.

Perhaps it doesn't have to be a kdoc-style comment, but that's
generally the kind of comment a developer would expect to explain
how and when to invoke a function.


-- 
Chuck Lever

