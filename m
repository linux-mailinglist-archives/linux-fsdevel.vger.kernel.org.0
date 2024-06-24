Return-Path: <linux-fsdevel+bounces-22222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE6B9143C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11649281816
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD1B44C7E;
	Mon, 24 Jun 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JtNyRprg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zqQkSmmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213083B1BC;
	Mon, 24 Jun 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214511; cv=fail; b=I2slgsBc/bEJKUb5CHvkMeh2gsPFwrFhMZz+2o9YgelnwSNE5UadGMTrFFhGyXcrucmVEKcCTw8VCan7q+skQcs1dlSHDjKYUyjBw+0otoIdWAo8RdPrRV89AdqbaXHT0yhDU053B8CcNOZe+opklec+YpuePKutrka114aMYQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214511; c=relaxed/simple;
	bh=SZcFdKb1rw02uQBNJMKHA8HaZrsAMHnOLjWbr4KrgP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjOMXdp13qhyJTNYNuTnFutnaKa5G3sgnFuQyob2hGplEKb/VfAJLht320fvd8Ph9gKNWo4V132SxnsDTw81Ub6LEDgXgo6q0MdDTN1XQ/b5jQ0ndb/PT6OW0GGvhw2YfF3QUaS9EuOnAhJxjnRCQ/5osCbbHtQlIAFk+dUeAKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JtNyRprg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zqQkSmmX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NLYCKq032035;
	Mon, 24 Jun 2024 07:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=J1mmHaZUxqMZxwlqm22VskCC980vQqvYk3lLRvGn1HY=; b=
	JtNyRprg72+JcNo3x2iT9sPJizla89bwR4mnoLjk8VNqNX+oycwK038rFa5dGYs0
	E+FX1LyVw760KduS+FRzFvY6B89lyLJYFErg7ZLvD1a9BhRpf6Q8Kz3Aj3ufT33L
	KxmIbtvBZEtLeVFa8Dspo8FjsIp8+8Dpvvslsa2jgPrgbN+qok532AMX4PSdpGDp
	fgPk/5r0/UNIRGl5/+RIMacbg31k6ssGih8DYQ+d1uqMqKZGlVOHPJO5xZUNeKmY
	Dx723etY+x/7n6lAR2K5LtfWfeCu7cg0XZaWlLadBLg8WmvWfS7GkV86lByvmI+a
	F57mHhDo1Ctr2BlgH6e+UA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn7020sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 07:34:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45O7LqWP017835;
	Mon, 24 Jun 2024 07:34:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn25k37v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 07:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnA/w2EOecd8BU5dLqvmvvWoCGg/QN7QhorE6Z6uwXTxOgnxGOth1kGtgcePwOcQcpkVQ3CcQcBKKo9NLtHy1x9O08+l/HVa4F06LE0CZtLS0+U17W91b93TAFJTgD6S0ENmmKrtAJneVW/YAAjlRSe+51DuT0QCilYZRFWwolAlf+NuSi5GtFY+p5E9fb3PwMez0rwx1bfKVKZ594j9Eiiw+HAITvAejMVfZ20VqtcGl6NOG+HGr85JjWzEPhzAAmPLUXot8x26qpgTarOLOSBd1e/BcGPJ/xUmL6vteoIxFx+MQWlNpM4q0wzevwjZ1+Au0N5Uo/SYNFiGO5tFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1mmHaZUxqMZxwlqm22VskCC980vQqvYk3lLRvGn1HY=;
 b=bwX291vIh2+x6BzTh3nng0jK9CbD+OTAmdj/TtOktodjQmXG+/27MIxz78tHqUo9Mh6E32tdLPo6AzBlzfmhIme8nVj3GCH7zi9NbRHvE5JcB3xCKzW8zvSyYEqE+3J+7w6EfLFzAxRWIScvljIyVMjGGJxmpI+lyHUmSwmwc819WXd05O2PGp8q03+x3tad/aNt2zhgU4A7CKT/bm3iavib9zsfcy1+FWXzi7RWIV5s/RENd9tApL8hT4ogtY14RDbjp1DxHWoznwiddZhz91GfAEcXmE0h8Bd3eeiY3OgJy8VC0VNeMYBXk2xA19eC1RYuY3M6kuZfSeWXi3DZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1mmHaZUxqMZxwlqm22VskCC980vQqvYk3lLRvGn1HY=;
 b=zqQkSmmXe737PEycqWwevgX+9TNe4EsWjIfeUU9XIe+yWoGp4vBBcZZe7oHc9r3vwVMGqTnTCwO+4zTmjR+muUglFTrvlx0T8oObE60q02f9+Te3a7kwqInFSCvEFBiEjDQLXD7p1u7s5bkcltmJreCsZfrGKNY6YOBXw29snmQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7979.namprd10.prod.outlook.com (2603:10b6:8:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 07:34:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 07:34:37 +0000
Message-ID: <259e6f94-282a-449e-9ef3-85469b8457d5@oracle.com>
Date: Mon, 24 Jun 2024 08:34:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] xfs: Update xfs_inode_alloc_unitsize_fsb() for
 forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-10-john.g.garry@oracle.com>
 <20240621183824.GL3058325@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240621183824.GL3058325@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 87df7297-be22-4c5c-577b-08dc942019e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?THoyQnFzcUw3cHREYmNTUWZqTjNCaDBzRlNiQ3NNbFE4a2pxT1ROb0tFb0lQ?=
 =?utf-8?B?Y2dFYjNNZVhhcUdDaHdjS3lSMzgreTVYYkRYcHNCOHNDSjllZjdkdGFMaElI?=
 =?utf-8?B?d2xrUzF1RkhaeFJyUHJESUtOck9CdHFQaHFkV0ViVlFzbG1DQStlMzVYZVFT?=
 =?utf-8?B?VVVYRVZlZDB3OFZpMHpvaytTdzd6R2pudkpsUzVSWmV6aGlTZEtHRkZROUdz?=
 =?utf-8?B?d2lvemdKcEgxclNnVllDUEFlR3IzdTRTeVZzNEhoNE11eW9YckE5cWpQUEV1?=
 =?utf-8?B?am10ZlRPTVhUU1VVM242Q1Jvc3FnWmFEaTJXSndxRUxKdXFaMnV0MEtDRHEw?=
 =?utf-8?B?S0daV1B5ckx0NHNLa1J6UXBnWnE3YklKeG9lcUFmUmZvN3FjdytnWTFjYWRv?=
 =?utf-8?B?bEYwMTVvcWkyNm9oQUNWQzNzU1NvaVo3cHhobVpEQUtpbDRZWmRzMGdhWHRh?=
 =?utf-8?B?YUU5S09qeTViVWZMM24yMmdkcWsvdEJjREFDZkJOVFIxWUNUVVUxb2wraVdY?=
 =?utf-8?B?YW91eEI4cXVHQnBlNjNRQ0o2WDRYRlVkdVBEUW5lWUdOYnc1R1R4NzM3WHlz?=
 =?utf-8?B?cGlHMllqbEk3dUxFZy9rK1ZRQXF0Qm11THBkR3JEcGlhK3pwUWthQWtqQW5I?=
 =?utf-8?B?MkJhSmFRV250cGRvUG1RamlTMnBOQ2pydUdXWVhYMDVRZEtVRXNaZWs5a0Vk?=
 =?utf-8?B?OEU1RldNUmZQWVEyRFdqRTdGOWIvcEtBRkJla05rdmljYi9sbGtQbmlLVzgv?=
 =?utf-8?B?L2JTR21vZjYrc1gzQUQxMmd1aW9hYytpRVcwdHc1MENKeHR2MUNMR2RMdnpp?=
 =?utf-8?B?bVNIZThLcDlKd25tdU95Y2lIMlNWdjBXWGg3Vjc5MHloY29BRmVOS01nS0Vp?=
 =?utf-8?B?VExZaWZEcTVNYjIycWF1NTdIdXVrU1VPbk05SWQ2RmtjcXZwN2VwN2ZsRkhu?=
 =?utf-8?B?TVpkQkVlM0ZEMkU5dFF6MlFIZ3RrOEtFeUViOUdEL3cxc2tlSFFBMzVsaERK?=
 =?utf-8?B?azlTTDFveWVoNEZpU2hEekxmUW9LSWM3S3RpRFFWNDVJL1VMZ1VuM2VLeVl5?=
 =?utf-8?B?eUVmZjg3RzBYdC82VGtoUmpSMHh0UFJubS9HRkE5RUQyQ1B6OWZLUXpxemo1?=
 =?utf-8?B?b3dPbmpBVXR3NzJWYkswVVlvWEkwUTN4czRuUDB3Y01PY1N1bmlYZ0lqWGlq?=
 =?utf-8?B?Uy95TkFRV2dVM3pveXhMTmVjaER4dGpjWHc3RloyL2JndDRvNnhrcjBDWWIv?=
 =?utf-8?B?cVMydnhyVjg2N1laRGYrUThLUk85czliL0o5L2xIUCs2NmVjbEcxUk0yQ2Rp?=
 =?utf-8?B?OEhBaHd0RXhlVTQ1Vmp3K1RseitpNTE4cjFkOEUvMzMwRTVqRytIby91Vkxh?=
 =?utf-8?B?QkpEQm5VTTFPZnRNak1VTzlsQ3pGbnB3OGViMytFc1V1MjM2bFpOQTB1ZVpV?=
 =?utf-8?B?K3c1ekkzQkdpUERXWHNPVDkwS0dTN2R4ejVqWXUvcGJtOVQ3bmRxbzRzZlo0?=
 =?utf-8?B?Tko3MlVsOWVsSzJXWTZKckxoUmY0LzhCM2F0TUQ1Q2FqQ202QmcyaERIaEIv?=
 =?utf-8?B?ZkZGclkra1p2YzB3U2ZFSmliQ0pNMUhQOHVYZzBaS3V2elhwcy9ZQmRwcDA3?=
 =?utf-8?B?TFNXRnhaS0s1S1BiTlF4Uno1d1JNZE12dDcxTmtITUlnRUJVdmprYzRJRlRO?=
 =?utf-8?B?VjVXOXpZQ2xZQmxDNnU3K0lOTjUxSnVrTEpEOFNHd3dQRS9kVTdhcmptTUlB?=
 =?utf-8?Q?LLQcvg3Y6NiTCHciyYXTQfmkg3uQQPd6ptywQVS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1g3NXg2Um5EY3N3Z2IvdW85ZTl2d1pQUndOTXBqRXlqMkNJTCt6VUNFcEc1?=
 =?utf-8?B?MGNiMzgvR0VpWkFMY1l3eXN5ci93bHppN0FkYVk4VFoxQzNiZ1dBakQxWTBk?=
 =?utf-8?B?MU50UlpVUFFuN2lWbHdFK3Q2RlVVYXFiODhvUzNJT1p6SWFTbEUybDk0S2Vj?=
 =?utf-8?B?bWxUV2RkNmg3ZmpEK2lIUXFVUFVJNHAxUGdIM0V5aUNCNldXWE9MSncyMkli?=
 =?utf-8?B?RkdJL1ZRWkpUZ21wMzVuT3ZmeURObU1KS2VhN3dPcTdDc0lJR3p4M1NBdG5z?=
 =?utf-8?B?ZTVXeHJxYmZyOE1EeUFiUjNEbWYwelVPcHZkS3o5aTlkY2xqTG9Bb0ZLYzdP?=
 =?utf-8?B?YnZWV2Z1WFNZWTZ3ekFyTkQyNlFYN1M4K000Rm84TkRBNnlsLzBmVjZnU3Zw?=
 =?utf-8?B?ak1GYW84UmJUVFo0bUJSK1E2YkpMQzFtS3BtL0N3R3pJUG85UitySFU1bkVr?=
 =?utf-8?B?YjhhZEl0a0twbm9RTGlrcXVJNVBtRlVVRjdGRm1JdzJkaGtmRUhpOGZJUUVy?=
 =?utf-8?B?MnU5ejU0ekpLZ3dyTW9hVVoyN3V6KzVoOXZweVNXZldPdWFZbnpKNGN0QWNU?=
 =?utf-8?B?MU5sYWV1eHdpUDh3eHMxZzJ5enpSckdtOVZvc3IrNEs1b3BwS1JuNXJRaGdU?=
 =?utf-8?B?M2I5KzNLZExlbmk2bmU1NTgwY0NlT3ZBc0tucndwK0l3ZmtjY1VNeStQZ21n?=
 =?utf-8?B?OWYyOFpjSTRDRFNvVjRXTSt4VnhGRFB3Q3FEN3p6SzMvTG1uZG5JSTV6Vmxz?=
 =?utf-8?B?K2tBUUR1Z2JGRmZPdkZJc0Q2V0hnaGhLLzNqd1hlRENZWEk0eDRxeVFCcloy?=
 =?utf-8?B?bVhnUGhvRnhoUkJwQ29EdmduZHo1cHU4by9PUERFM0EvTGFMNDN5VWRWdVVu?=
 =?utf-8?B?MVV6RWlDUDY3dVBJcTJTdnZETklySDQ0NlRBYXlXRGxmREE1TVR2eWtKcnJj?=
 =?utf-8?B?TXJDdm9tVzFaSUhqNUliSFMrdnRqVmJhSGJ3YjkwcGluTWNPOFBPT3Y1bVdt?=
 =?utf-8?B?OEZCb1NZVVJjOEJXZmw1ZnprMGJ2QjBUSWwwQmFyZnphRys3R3lFNEllVVdP?=
 =?utf-8?B?b3JTbzVBYXRxaGgvOFpsZFdTaGpraFNwZzBSS2hpVC90QXpzSHo1c1dZeXlR?=
 =?utf-8?B?RTdoelFHdmpzakY0aFZRNmhzUU5BbjdCTE00RmJvdlBRL2RzVHQwdC9Zb2Zs?=
 =?utf-8?B?bkw1MEhNMjVWWU5Vdlk1WDFSN0NNcU0ydURZTTg4ckhGa2VRZGFtSjFyS3dT?=
 =?utf-8?B?TkdCWmR4YnhvclBISHRIRlJoZCszTy9uYzlzbjlBTGgraGh4UEQwY0hqNWYr?=
 =?utf-8?B?NWRTK1V1KzdsTC9OdXVVbXNKdUdGRHlmRU56cDdoWUhadkU1ZXZOcDhCUVlZ?=
 =?utf-8?B?NVkrUUttWGFPYnNTU0F0VjUxWFZjTmxyRC91dXlWek9MTjJwTGtwY2xXVGV2?=
 =?utf-8?B?VjdkcHVKVDdxMUV1NDRjeDdOZFZzZEh0ODlkSjhRVjV4V2dDN0gzWUF5QmFF?=
 =?utf-8?B?M3J1cUhDQTk0TldHc2YzVGpuWGI1UWxXVUVkYk1iRFNTYTJMVVRxUHZBeG9M?=
 =?utf-8?B?MmVTb1YvY3R6ZUJXTmhNRjRvUWtSSlB6bEJRaXF0ZFZUbHdNUE5iUzA3ckJi?=
 =?utf-8?B?Tk8yclQ3ZVFlMm5TMlNDTFRJbW5SSTZrYlpCM3ZiY3Q1SENkdCt4ang1TnF1?=
 =?utf-8?B?YnVzVGRMT0FXR2I3K3hRM21ickxjUCtZSlVoMk9tWE9tNHNKTU1IMkZuY0NE?=
 =?utf-8?B?Nkp0TUl0VzhRem1aeTlGekxaa3JGVDV2SG0vWWdkb2J6NThuUnhJbWszOGx0?=
 =?utf-8?B?ZGI2OUg2ZzVjdVNyRmI2dFExT3h1QUxWdjNSWmZSekluU0xLZ0t1cHlXV3BF?=
 =?utf-8?B?UTZWNHJsNS85OUw0empOSmxFU1laZ1FjYjlvYklsMmZMRG1iaHlwd3JBcDB2?=
 =?utf-8?B?NkFmR1o0WTdVVnlldER2clQ5ajBFV3FaQWN2aTV1aVlVR2hIZW9md202Zkhm?=
 =?utf-8?B?d3MwOUFVMGVLK0I2TDB2aGRpc2N2SmROdGl2QlhDTzdoVW1JaU1leDB6dlV0?=
 =?utf-8?B?UUZnZkZ0d2tnWkEyZ2pKT0J0MHhnV3hoN2VIUmVUeEZoUXFFeGlOZVpRUW9L?=
 =?utf-8?Q?reUjFj3M5F0AyvdtVdxieBL6F?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0iCsTK1M2QzulpElvo8FuO76S2plRToRheT/eXF/wdQP+ojg8nBJmKdErXiXnqce3s+JugYF33WE5tGASCHCbzVBPeHggw4AwYXHiSbEYzw5vosXIzfg54V+stX+mgmbhNpDLDHbClXDrfQYdYrFFcjTrA3Vm4pNsN7CtLlHkb9fLmQzJXQgQ7Wgb9OsEHgGKQoGKFva64LtNmhFCHS2RClPXFE9xio9hpMuOCus5MZwQ6wcmjsS/Ju/J+JDiuOUdF4+ZzixF+2/9yWhJTfogxf4FQsG74mRZg3rj69S1AR+4i3NQuF7QeYtLqVPmjDVFcmA7ERW8lifrDbh/l4Nw9qS7yDrCuSB1RTKQY6vPxQtUJbBdo8HWbDH8VS6Ej9bBV48IhFoM/4TpsjX9atZu/p4dO6hPhfm2HYas+ygTejsKYyRQOy5jItyVn201iGoXx/z7EDMjo9IrlMAzi9u87dgj1Rk5g+4sMshb2lRh10pDGTzITO9HaKBYw6bsL2rBrtUcO244OqyNvyp/GxYv+ZPf7sc1LdF9oLDH8JPktVVbZsosYWzsyhkaXBFlkQL5lCozOwcA7+EEVm9qy8z5CZkbqJRGWjPd9DmZKRJ00U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87df7297-be22-4c5c-577b-08dc942019e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:34:37.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKUye2CvRi8+BLR9VQenTxTmZlPVxKovYgXzTuYyuXOldePkR5Soau3ey3AeY3eL491pGGSXneWpeqrmKEjiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_07,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240060
X-Proofpoint-ORIG-GUID: oqZFwSCqh86veaLiuF2VG8bJCEZ3TwnW
X-Proofpoint-GUID: oqZFwSCqh86veaLiuF2VG8bJCEZ3TwnW

On 21/06/2024 19:38, Darrick J. Wong wrote:
> On Fri, Jun 21, 2024 at 10:05:36AM +0000, John Garry wrote:
>> For forcealign enabled, the allocation unit size is in ip->i_extsize, and
>> this must never be zero.
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_inode.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 994fb7e184d9..cd07b15478ac 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -4299,6 +4299,8 @@ xfs_inode_alloc_unitsize(
>>   {
>>   	unsigned int		blocks = 1;
>>   
>> +	if (xfs_inode_has_forcealign(ip))
>> +		return ip->i_extsize;
> i_extsize is in units of fsblocks, whereas this function returns bytes.
> I think you need XFS_FSB_TO_B here?

Right, that was a copy-and-paste error from the previous series.

Thanks,
John

