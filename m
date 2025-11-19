Return-Path: <linux-fsdevel+bounces-69085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D2C6E8BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D55FB2E6BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770E31ED9C;
	Wed, 19 Nov 2025 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbvMHjzc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SIn/bMda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433E3090C7;
	Wed, 19 Nov 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556238; cv=fail; b=bJcoZWVC63YkvajMwqcdUBvvEyED4Pso0qO0/asaPQAFxh8R3Cl3i6UEMvwoR9ZZKdFiE4fu7WUQ3HhJJZDl667T7RKa71CBnjcvDhHC79M75WVmkWLjyCwuLqsridjjWOtxeWv7zKRHqLPMM8sNGAdJ/6cBuL6UIXXUCtMyFtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556238; c=relaxed/simple;
	bh=rUtUMe+tgr96wodK8ulwoxZW8qvaeH33LNmHvioerBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ev6Z9wfmh7pSjVk95NQE4mekSgOacQ+COLUffIS2/ZWmtk9Tk3KhA0MTfmPaNPKJBajlM2+qJdVrImL3EtQJrVg/B7nf0FIUlypzD465Zgu2OzaDDQ29n/qDq5/IlY4ifP70SQNwBv460e+ztVTD0RMt2f6lzFxo1KA6X8fz0XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbvMHjzc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SIn/bMda; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8uuBm015221;
	Wed, 19 Nov 2025 12:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uJuGvuVFrQPq2xw1GO3WSaZVgHuMB43BUvwPK9+NiLs=; b=
	JbvMHjzc/IxPAD6UWjbhn40lADfCIPI61KTxw3v9a4wFTv+v0o9coAnS3c1m8NOx
	RT4tqF6K0/brnGSS9DAGV4aSBK5lRVsNvM5q0ygk+EZdWM2cArMb5gRneSO5QN21
	JWBfJ4tfVvGTDuQs0+nV2hnrGUUeztlxmn+UWjOn2qkCDn2IDq7KaTmDE+uUi/qJ
	oG3bV/brxs7tDxsJpx434BOjWlia3mg+Z9RQ1OxyEG+hzRiAzdWQ/5qPGRWNdF8O
	AejEjnih8ujCofC9zqqWLb12Z7wt+98Bjv/LC5KI9fwjIBQ6vtXTDTPkfGREtfiT
	+D5VlRx8Uck+k0+opUtzqA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbf2s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:37:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJAFZeq009651;
	Wed, 19 Nov 2025 12:37:16 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyejqyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED6hdYST0vCnoWw9tgovTTZLoLIg3USTUtgHD9dtTKij9LNVKWURuYWXSJqhk3lb3LGmLQIzyAR9FB1o+Yn/ftool/VzELFyDrIKtfaUu7gh0aRMQGv/9iMwHFjOQbymf4jzIJdla/PyQnoPaur/E1poht6Xi08LEgyb/s0nVcEqM5j7uIOEDuEE02AygwRqQUFtAgsi2dyWq0OR/3GYFg447MIlsh6+10eom5ubCWs5JDD+6ubpOn0i0o4KRhF7Goykt2bWmNyCzUt8U+B/pLfCHasT7pfzrGkJlFHlgPX5gbTxpZUvfInrz2wy2vB7byDCuG22/D5gVJh1j0xQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJuGvuVFrQPq2xw1GO3WSaZVgHuMB43BUvwPK9+NiLs=;
 b=afk+TrRCYROFHoMEDBzmJ43b8Tt/9+d3ZqAYt58mLpm82s4z4X+Rf7pL9EKGgmzGONgW5bEKWJpq6Exalk3bUJTDvjTDfnHx1shPSCWHsPffvhPCAoqCU6tDbZIM3Sy2JdgtMaazSjuAdR45HUQm2NyUqeP2HmPr+73a7oWZblhWjDStE6ga0Dbv/EaNRkUBzFzJTyWJiIGDNaZVnoEoh3LAkUX3TbotyOPDhtvnYJCHsVXiy8uuVZt10CIzJd8LoC0TyErHmwkKZEECDCS6xkLozkLjcWFrfLXsJnFYEFPQR7vK7x/fVuYCZCG51+CvkAQlOQYWAYOxnN+qCXeFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJuGvuVFrQPq2xw1GO3WSaZVgHuMB43BUvwPK9+NiLs=;
 b=SIn/bMda4Yea2SfTL49d32WxNIiCEvASrgKaTNxN0UTl6Kj+ivE9BttEJ4hbuqEnOI6DQJ4QXjuXA4qt0wZ0osQhV8szrY0Hc+6W3JP2hABEhZwNEbCFg8LzpHECQHNus8sOdqX7KsPQ4PAjamYCN592xT4HW7q+xbZDyS91nXA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 12:37:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 12:37:11 +0000
Date: Wed, 19 Nov 2025 21:37:00 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>, Matthew Wilcox <willy@infradead.org>,
        david@redhat.com, Vlastimil Babka <vbabka@suse.cz>,
        nao.horiguchi@gmail.com, linmiaohe@huawei.com,
        lorenzo.stoakes@oracle.com, william.roche@oracle.com,
        tony.luck@intel.com, wangkefeng.wang@huawei.com, jane.chu@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Message-ID: <aR257PivQXpEGbKb@hyeyoo>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org>
 <aRqTLmJBuvBcLYMx@hyeyoo>
 <aRsmaIfCAGy-DRcx@casper.infradead.org>
 <CACw3F50E=AZtgfoExCA-nwS6=NYdFFWpf6+GBUYrWiJOz4xwaw@mail.gmail.com>
 <aRxIP7StvLCh-dc2@hyeyoo>
 <CACw3F53Rck2Bf_C45Uk=A1NJ4zB1B0R1+GqvkNxsz3h3mDx-pQ@mail.gmail.com>
 <5D76156D-A84F-493B-BD59-A57375C7A6AF@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5D76156D-A84F-493B-BD59-A57375C7A6AF@nvidia.com>
X-ClientProxiedBy: SEWP216CA0079.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fb1acf-cab0-4841-c054-08de27685c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXRBQ3NscWV6ZDRSVFJUZnZrWWxiVUlwM2ZGNUpJNHVGR3VhcWhpa1VIZ25W?=
 =?utf-8?B?elE3MWlGUU9ETUlFRTJ5U3lrbTk0eHRmdzFyRk9JcVJBSnl0RFJURE5oaGta?=
 =?utf-8?B?KzEzUHlBQk9TUEs4VlVRVFZFdHBtOGk4WFkrdEh6aGFpVXJPZHR1ZGc4NHRi?=
 =?utf-8?B?SjNkaVcyNDVucHJUc1k5dzFrSVM5VTI4cHg3SW5pMHU5NWZ5cUlwd0dRV0VQ?=
 =?utf-8?B?ZFlFcHNQdGhpcWRYS2tobVA5OFdJcDNBekFCckpXamRpTlF6NnIxMTFYY0Z2?=
 =?utf-8?B?bUhYWTh1by9lUGxqS0JYZjFzZ2JqNTFiWWc1OFc0dUxVb21RTUMveWVPbzE0?=
 =?utf-8?B?Vjc1dzNwR0JKSG1JRUF1NjBhYkgveXh0M3Z3ckx3R21HY1R6OXlzR3pacU5F?=
 =?utf-8?B?cFZabGdjRlpjb3VyQmxEMFNsYWY1RTEvYll0ZkVVUlI1VlpVL3I0M3JiQlNN?=
 =?utf-8?B?SGZrK0V0Zk9FekxEUm5pRzR1NmV1SzBUZFlaUVlDWnZjRWZBd3pmTkd0aDVt?=
 =?utf-8?B?aFFRV25VTkt4YzFMbW9PdkVDbWVuUEVuUnNmTlQyVWVYWkRueDRDT1U4NHFM?=
 =?utf-8?B?RTFsQTlIOHI3V0NaSVNxTXhFS1ZrQjVDM3pZeXZWaGkvL0tNa0ZnTnBxa2tR?=
 =?utf-8?B?L2tFcm9OeWdwOXFGZms5Z1FmMGxlUUxBbTJ3ODFHTWJVOENtYWh2TENGUjlL?=
 =?utf-8?B?dlBnSlFmRHZYYllIUVk1UXFuSDN6VVFTVWJvZVUvakdvUGp4KzhENjg3SmFT?=
 =?utf-8?B?ZUlBMUlHcUlHNmk2Wi80WkovWUxSRElqS0tJZ2dmWXJYTHErODMzbDU0YTdp?=
 =?utf-8?B?OWpsbldzT01sa0dEWWZxMmdKNjVoVDZCZ0ZzVVZoRGkrNGVOVTltWm5ORWVR?=
 =?utf-8?B?U1F5WmNaeVZRSzJZWGVWRTBoKzlWOVl2cy84TWY0eFYvSWlva0J3OGNnVVFH?=
 =?utf-8?B?K0I0U1paay9PcHZVc1lIQVlXYzhDc2JIbzE3UnlOZjYwQlYxVmJQMTVsNDhL?=
 =?utf-8?B?L2RWWU1vbDhPV1B2eXBFYndDTnhIZWhtVXU2eFA2K1htZjZDcEFXTE95anJP?=
 =?utf-8?B?NXRzTExaOVZQMnVOZEpCOEpYcnU3Ymo4V3JESTBkTmVRakI4SlFrcGNoNkVu?=
 =?utf-8?B?UURiQkpHS2VxYU54UFZLR01Ca29MQkdwcG4vVUYvemx0eUkxM0E3SUNNRVQ5?=
 =?utf-8?B?OG54VUJsZ2ZQQnBVZDRnd0kxRURDcTlkQThLL0w0U25JeTZmdmV3YTQvaFJK?=
 =?utf-8?B?Y3g2VExzTUJxeE1aQkJINkFOeU5zR3lOVkVocEpMZFM2L1o3cFNkYllJSGdh?=
 =?utf-8?B?Q2k4VmpheDZsNjBnaEQwR1ZIYWtiUzRXeHpWZ3pmYlluV0J3bXExdytlS3Rz?=
 =?utf-8?B?ZXZ6WXVoa1R3YXZmNU8zdVF3V09kVEhXdTdVRXdjQ2tNL2FIMnd2QW8wZWow?=
 =?utf-8?B?MmZUNWU5WUVzYXhIN0gzM3U4eFVIOUlWRTVQdytUb3BDVnp5b3BGOVR5R1hx?=
 =?utf-8?B?NVJ0VjE3NkRFUElWTFh4bXFORndvY0hjczhvZUdHU24vaHByd3cwaEMzYTl0?=
 =?utf-8?B?bkxRQzVIZzhWOExjQlF6NDYwVEZJQW5QTmFPNFp4eVRmTEhVdk9UQzJZY0Vy?=
 =?utf-8?B?cmJqM3lhYWxndFg4SHlGZHMrenQrOWIwMTdGODRWajV4ekFjNVdicm9wbWpi?=
 =?utf-8?B?VlY4bGtDcllscVRKRHRkd2xOdHNJc3lVbWg5RVlMOGl6N2dIbndFTFRYQStM?=
 =?utf-8?B?RU9OQmppZ1pCNXh5S3oydDRPNXMwNFJKYjBndEJrN1NUUVg3MGRLNmc4UEpp?=
 =?utf-8?B?YTM0WWF0cHpMa1E5cmhXQzZnSENqWnBDTm1sVmlnNklPQU5LWGFObjhwSlo0?=
 =?utf-8?B?RGJoSTk4azg0ZnprMHhOclRzN3FQdFg1dG5QUSt5dE9RYllTL2kwcHpROFlN?=
 =?utf-8?Q?l4BCBkgIZrQ0DlBxiPR0A4NQesiMzkHr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emJsMEFzcE9KdWVoVHVmVFZEU2pNa0pDZ0U1a0F5R09JREg3aGVFVy8xeFpU?=
 =?utf-8?B?WncxcGJyN2tFeU9PMjJSZWdCaGhpMGZCVHkxRkJZakdrcXo1Q3B0TFQzK050?=
 =?utf-8?B?bENTdzBxWnVSdVhEYTBTZ1prU1lIMktWL3F3TVdFWUlVeDhiNE9rek1pNng0?=
 =?utf-8?B?cE8zSHVYbFpKNnNBNXFZc2ZGOUNUS2ZBek52UVdCUmQ4WHVuSUJSaGxsbUt2?=
 =?utf-8?B?d1FkWDgxR0l0Y0JKRXhUQjJrM0t0VUs0a21wTWRhMWFoR2VaNjJ0SlBlR0tL?=
 =?utf-8?B?VUVxSDd1TnY5bTVLekgxZmhmbEQyWm80T09iVXN2aEJucVVvenAxOFN0UGRh?=
 =?utf-8?B?MFpCZy91VXlaYTdQVnByMm1yMkN4YlpVQ2ppSVRqUWd2YW1XVWZKOEVNRzFT?=
 =?utf-8?B?M3JYMjJLcURMQmJvdXdTK09yb0NkQTFFNHVuZUE0KzV0dmlpOHJIN1o0WThD?=
 =?utf-8?B?MzBVUlVXenFOZjMwNzFRYkNtYmNJSkpEdkVVbUNRTHJVd1JEWTFTUis0Uk5p?=
 =?utf-8?B?WkovR01rSFNZcXdXOG5pTFdlTjY2SUJUYVNIWkk0ZnAyaU1rdGNlODRKK1RZ?=
 =?utf-8?B?VU1EVVRnbDhRNTdOY2RCK1VNUUlDRWhyK2hjMFdrV0J5LzFZRkxYazNvTUxJ?=
 =?utf-8?B?RStDWUUrQlUvSXRDUEtrNUljT0RXUDJ1L3hlNS9YTFQrNGlHUFh0RFhsNHls?=
 =?utf-8?B?NE5BZE5uaTlIcmNFNjQ2MVltK0Y0QTExdVJVbmlpdWNMdXo2LzFJN3YvRkt3?=
 =?utf-8?B?N0ZmdVQ0bmY3NG92clhZVHEvbEtWd0gzdmpmclp3aXc1OUdRYXlNR2w5VEQx?=
 =?utf-8?B?VEt5amRWZ2xEMnZ5TEdkMVpKNzZMYnR1MWRkRUhFVzRVSzBGd2lMOXVGMmgy?=
 =?utf-8?B?RTdqYlY1UzcwTXVRSnFvTWNyVEc3dkdSK3VJeGI2YTFOYUQwRHNSc1FxQitY?=
 =?utf-8?B?bU1xUUhKRHVQNzNiemNqMVI0a3VseVVEcG5ORGxWdVpjaHdib0dBUG5ERmVn?=
 =?utf-8?B?azJtVWx5YnU3aFozbm1zcWh1SUYrQ1RlVGNjUTJ2UHFlRzU4RmpBYWtROEF6?=
 =?utf-8?B?Z1ZhSmhlZ3ZnMUpqdXhhZkQ5MjhJb082akRwS0V4cFlJMDh1UmUvZm1GaFJI?=
 =?utf-8?B?Z09IaFdqTUh6bkR6ZlJrV2tjVzlMZjFWTUtGM1NpQWdFM2Y2YVZYdGNVRnJs?=
 =?utf-8?B?MGNKL1ZMWmdhaVBpK1dkbGdpY2F4SzFvNVA3bHhLbWJxRnp6Z1pXbStWeFAx?=
 =?utf-8?B?VU91KzdSSThYSUl1TUthUzV3UGw5VER0ek43SUZlTTlBTVA4U0JVcXNDblI2?=
 =?utf-8?B?a1kvd3o4MFZWYlBZZDFsT3hqQllCaDI4Zi9FQ0NhT00xbnBIZW5UQ1lWdUJw?=
 =?utf-8?B?Y0RsUmpGbEM1UGJQWCs5N0VUNEhFVG9sTlNrTWtwdlVScGdTbHBxQkV2T3Vw?=
 =?utf-8?B?eU1uNG9LaTJ0eWs1aEdYQ3psQk43QVVxbUZRcGtkaVo4bXR5azF0S25KanZ2?=
 =?utf-8?B?NFJyM3dSZWkvaG1uL2MwWFVsdkl6QVBsZlZ4Z1hPNUNERHI5dlJycEMzQ3Qz?=
 =?utf-8?B?NDlHV3ZQcHVoOFFvWFhQajM1MEpWeDdKKzNqWFcwYythUVJTT1BDTkZSYkto?=
 =?utf-8?B?WHA4L2JZcHBiN2I2bHR0ZWFVeThIN1lhOGZRMjJxbXBpTE9pQzlCckhxelcv?=
 =?utf-8?B?Y1g5bzMyVnlVRmo5RmZqMU5DRUlQdVZvU2QzNDNRdjFldjAvbW5KZHVhS0tv?=
 =?utf-8?B?OC9pODRkZWFQOHBsRDNzYnIxaWFSOWZGakVqSk8vVVdTZjhNWktvZEVXQm5k?=
 =?utf-8?B?N0lXaUtldUlWeHpTKzhaeE02OHpZSjFOamdCQ1ozeEc1azgyNU0wNkpWSFR5?=
 =?utf-8?B?a2ZscFpzbXJHM0d1NUdWcmNuaTc4b1RzZy9FTndtbmVCZ2VRbWJoZUVoNCtr?=
 =?utf-8?B?LytRM2lQTk8wbnNTQmg0cXhjeTB6aWoweFlDeDRDUzloeS8wWExOQ21hK0NE?=
 =?utf-8?B?QW9PZ05LVXdjQUpyVHFESDZiWGVpZVVqMm5qUHppdmEwdlliUy9qWW5WQ1ZG?=
 =?utf-8?B?UlhaUm1FV21wZ296TERQM3pHbTB4UWNXaWlEbjBvdHdUckVlZUgvak5zbVg2?=
 =?utf-8?Q?2tT+NIbU9WtIQw7sec9GIhf7V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	THXgyEIBiZeaki4SOOHD/rOhXLn032sAClBSVw6HxXqNG4/KdLL3vbabYT+1nRQKcgGhc9fgx3HDGYyJrMQ+Bip48QwTnfNVLD68qG0sHIuNX5kKXF3NlLlrs3vUDOLiWpVSEElTvpLz3G5fL/eheZwOK9sWESXW7jCZdiiU3OW8vBNZRfdKrGD8fFBUEUqZw6LQUpQyaZC5/hV+iMS/wi8cMg6BXBhxbfq6T+cqGs4JdnSw8uvzGg+va2S3XiAtbFWGuLrAIttuq4Mz/ddKWElrnSxwT9muyuLtQIMPx7jJLvWl2QClA2qII09n6ZsCM2kWHLuxTbvF9ZuKWWR2xT5nD+yZasQ/+pdPemDxjisDjUlMtIPPjvlUnbCuoaH6KBLcF1jgJD1ypbZC9RdB2B0B74XeiO8sGLZXVgdwZJXgQED74k2aucBizYxudy01TTUpcIE7md1Ahs84wxIp8aWYgCvMo9NvGZ1FIDptXUox7npLtaKOoceHev8ARdIWlubmwXZ86glx+TEk0EHjXBWyBRRUb629qR0bpXgvZMmF4sOrfTvzVOQoHD8GQoJXA84NaLrNxPI10jrB4wniqXWI4OgvbY2tsz+3H9xfhiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fb1acf-cab0-4841-c054-08de27685c04
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:37:10.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuACqJQ333S+QYPXEVDVE+itveYPsjuftu4wJ2rdnjegqNelA6KkyynXcgsYsgKLjydqmJfOWieG1ob09eh3ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190100
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691db9fc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=Ikd4Dj_1AAAA:8 a=eB7HIBGYX8SMtFT31VsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:13643
X-Proofpoint-ORIG-GUID: IdQcm4U3uXM6h4J8tCr1PqPOlSvxvoMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+ig7XhvOZcAJ
 ZTnV1w2hGFoMUpqxiHUY5P+WrPAAbv649UfF4P0zunMiVQ0ssSWvsqM1scPGtk8w93Vd/WixXkf
 qXgQqs8DugrQHsGK6F2xqo3DuTpewsha3ZWOw8BxMHiepH0plALs7hqDdNNbLMMeB9hohwgCwte
 xADIF9ZkhuoQLLLHJG1ZWrUDr+YlwpjcG4p4PLMYnM/bZ1eg9XPYKQJl+dqQEe5JlaL6zLhjWz3
 b934xvnu/yy22DAY5nHF3p8q5cN/UoRaDaIYpz7ZtAn3bdy0M/XfpERWmvmFfmYHgCBCwmtCGkX
 6JmmYSMi5tu13iYaUaXjiVwB3yNZtlTrXJbiXk7lDM6z7oBLkD91gEZjZM2TyeA5e24RRtd0sYs
 L082vsyG6bc6oykiBqOKnyn7c5hPAJFb76yX2cJa65qAgjyKbSM=
X-Proofpoint-GUID: IdQcm4U3uXM6h4J8tCr1PqPOlSvxvoMa

On Tue, Nov 18, 2025 at 04:54:31PM -0500, Zi Yan wrote:
> On 18 Nov 2025, at 14:26, Jiaqi Yan wrote:
> 
> > On Tue, Nov 18, 2025 at 2:20 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >>
> >> On Mon, Nov 17, 2025 at 10:24:27PM -0800, Jiaqi Yan wrote:
> >>> On Mon, Nov 17, 2025 at 5:43 AM Matthew Wilcox <willy@infradead.org> wrote:
> >>>>
> >>>> On Mon, Nov 17, 2025 at 12:15:23PM +0900, Harry Yoo wrote:
> >>>>> On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
> >>>>>> But since we're only doing this on free, we won't need to do folio
> >>>>>> allocations at all; we'll just be able to release the good pages to the
> >>>>>> page allocator and sequester the hwpoison pages.
> >>>>>
> >>>>> [+Cc PAGE ALLOCATOR folks]
> >>>>>
> >>>>> So we need an interface to free only healthy portion of a hwpoison folio.
> >>>
> >>> +1, with some of my own thoughts below.
> >>>
> >>>>>
> >>>>> I think a proper approach to this should be to "free a hwpoison folio
> >>>>> just like freeing a normal folio via folio_put() or free_frozen_pages(),
> >>>>> then the page allocator will add only healthy pages to the freelist and
> >>>>> isolate the hwpoison pages". Oherwise we'll end up open coding a lot,
> >>>>> which is too fragile.
> >>>>
> >>>> Yes, I think it should be handled by the page allocator.  There may be
> >>>
> >>> I agree with Matthew, Harry, and David. The page allocator seems best
> >>> suited to handle HWPoison subpages without any new folio allocations.
> >>
> >> Sorry I should have been clearer. I don't think adding an **explicit**
> >> interface to free an hwpoison folio is worth; instead implicitly
> >> handling during freeing of a folio seems more feasible.
> >
> > That's fine with me, just more to be taken care of by page allocator.
> >
> >>
> >>>> some complexity to this that I've missed, eg if hugetlb wants to retain
> >>>> the good 2MB chunks of a 1GB allocation.  I'm not sure that's a useful
> >>>> thing to do or not.
> >>>>
> >>>>> In fact, that can be done by teaching free_pages_prepare() how to handle
> >>>>> the case where one or more subpages of a folio are hwpoison pages.
> >>>>>
> >>>>> How this should be implemented in the page allocator in memdescs world?
> >>>>> Hmm, we'll want to do some kind of non-uniform split, without actually
> >>>>> splitting the folio but allocating struct buddy?
> >>>>
> >>>> Let me sketch that out, realising that it's subject to change.
> >>>>
> >>>> A page in buddy state can't need a memdesc allocated.  Otherwise we're
> >>>> allocating memory to free memory, and that way lies madness.  We can't
> >>>> do the hack of "embed struct buddy in the page that we're freeing"
> >>>> because HIGHMEM.  So we'll never shrink struct page smaller than struct
> >>>> buddy (which is fine because I've laid out how to get to a 64 bit struct
> >>>> buddy, and we're probably two years from getting there anyway).
> >>>>
> >>>> My design for handling hwpoison is that we do allocate a struct hwpoison
> >>>> for a page.  It looks like this (for now, in my head):
> >>>>
> >>>> struct hwpoison {
> >>>>         memdesc_t original;
> >>>>         ... other things ...
> >>>> };
> >>>>
> >>>> So we can replace the memdesc in a page with a hwpoison memdesc when we
> >>>> encounter the error.  We still need a folio flag to indicate that "this
> >>>> folio contains a page with hwpoison".  I haven't put much thought yet
> >>>> into interaction with HUGETLB_PAGE_OPTIMIZE_VMEMMAP; maybe "other things"
> >>>> includes an index of where the actually poisoned page is in the folio,
> >>>> so it doesn't matter if the pages alias with each other as we can recover
> >>>> the information when it becomes useful to do so.
> >>>>
> >>>>> But... for now I think hiding this complexity inside the page allocator
> >>>>> is good enough. For now this would just mean splitting a frozen page
> >>>
> >>> I want to add one more thing. For HugeTLB, kernel clears the HWPoison
> >>> flag on the folio and move it to every raw pages in raw_hwp_page list
> >>> (see folio_clear_hugetlb_hwpoison). So page allocator has no hint that
> >>> some pages passed into free_frozen_pages has HWPoison. It has to
> >>> traverse 2^order pages to tell, if I am not mistaken, which goes
> >>> against the past effort to reduce sanity checks. I believe this is one
> >>> reason I choosed to handle the problem in hugetlb / memory-failure.
> >>
> >> I think we can skip calling folio_clear_hugetlb_hwpoison() and teach the
> >
> > Nit: also skip folio_free_raw_hwp so the hugetlb-specific llist
> > containing the raw pages and owned by memory-failure is preserved? And
> > expect the page allocator to use it for whatever purpose then free the
> > llist? Doesn't seem to follow the correct ownership rule.
> >
> >> buddy allocator to handle this. free_pages_prepare() already handles
> >> (PageHWPoison(page) && !order) case, we just need to extend that to
> >> support hugetlb folios as well.
> >>
> >>> For the new interface Harry requested, is it the caller's
> >>> responsibility to ensure that the folio contains HWPoison pages (to be
> >>> even better, maybe point out the exact ones?), so that page allocator
> >>> at least doesn't waste cycles to search non-exist HWPoison in the set
> >>> of pages?
> >>
> >> With implicit handling it would be the page allocator's responsibility
> >> to check and handle hwpoison hugetlb folios.
> >
> > Does this mean we must bake hugetlb-specific logic in the page
> > allocator's freeing path? AFAICT today the contract in
> > free_frozen_page doesn't contain much hugetlb info.
> >
> > I saw there is already some hugetlb-specific logic in page_alloc.c,
> > but perhaps not valid for adding more.
> >
> >>
> >>> Or caller and page allocator need to agree on some contract? Say
> >>> caller has to set has_hwpoisoned flag in non-zero order folio to free.
> >>> This allows the old interface free_frozen_pages an easy way using the
> >>> has_hwpoison flag from the second page. I know has_hwpoison is "#if
> >>> defined" on THP and using it for hugetlb probably is not very clean,
> >>> but are there other concerns?
> >>
> >> As you mentioned has_hwpoisoned is used for THPs and for a hugetlb
> >> folio. But for a hugetlb folio folio_test_hwpoison() returns true
> >> if it has at least one hwpoison pages (assuming that we don't clear it
> >> before freeing).
> >>
> >> So in free_pages_prepare():
> >>
> >> if (folio_test_hugetlb(folio) && folio_test_hwpoison(folio)) {
> >>   /*
> >>    * Handle hwpoison hugetlb folios; transfer the error information
> >>    * to individual pages, clear hwpoison flag of the folio,
> >>    * perform non-uniform split on the frozen folio.
> >>    */
> >> } else if (PageHWPoison(page) && !order) {
> >>   /* We already handle this in the allocator. */
> >> }
> >>
> >> This would be sufficient?
> >
> > Wouldn't this confuse the page allocator into thinking the healthy
> > head page is HWPoison (when it actually isn't)? I thought that was one
> > of the reasons has_hwpoison exists.

AFAICT in the current code we don't set PG_hwpoison on individual
pages for hugetlb folios, so it won't confuse the page allocator.

> Is there a reason why hugetlb does not use has_hwpoison flag?

But yeah sounds like hugetlb is quite special here :)

I don't see why we should not use has_hwpoisoned and I think it's fine
to set has_hwpoisoned on hwpoison hugetlb folios in
folio_clear_hugetlb_hwpoison() and check the flag in the page allocator!

And since the split code has to scan base pages to check if there
is an hwpoison page in the new folio created by split (as Zi Yan mentioned),
I think it's fine to not skip calling folio_free_raw_hwp() in
folio_clear_hugetlb_hwpoison() and set has_hwpoisoned instead, and then
scan pages in free_pages_prepare() when we know has_hwpoisoned is set.

That should address Jiaqi's concern on adding hugetlb-specific code
in the page allocator.

So summing up:

1. Transfer raw hwp list to individual pages by setting PG_hwpoison
   (that's done in folio_clear_hugetlb_hwpoison()->folio_free_raw_hwp()!)

2. Set has_hwpoisoned in folio_clear_hugetlb_hwpoison()

3. Check has_hwpoisoned in free_pages_prepare() and if it's set,
   iterate over all base pages and do non-uniform split by calling
   __split_unmapped_folio() at each hwpoisoned pages.

   I think it's fine to iterate over base pages and check hwpoison flag
   as long as we do that only when we know there's an hwpoison page.

   But maybe we need to dispatch the job to a workqueue as Zi Yan said,
   because it'll take a while to iterate 512 * 512 pages when we're freeing
   1GB hugetlb folios.

4. Optimize __split_unmapped_folio() as suggested by Zi Yan below.

BTW I think we have to discard folios that has hwpoison pages
when we fail to split some parts? (we don't have to discard all of them,
but we may have managed to split some parts while other parts failed)

-- 
Cheers,
Harry / Hyeonggon

> BTW, __split_unmapped_folio() currently sets has_hwpoison to the after-split
> folios by scanning every single page in the to-be-split folio.
>
> The related code is in __split_folio_to_order(). But the code is not
> efficient for non-uniform split, since it calls __split_folio_to_order()
> multiple time, meaning when non-uniform split order-N to order-0,
> 2^(N-1) pages are scanned once, 2^(N-2) pages are scanned twice,
> 2^(N-3) pages are scanned 3 times, ..., 4 pages are scanned N-4 times.
> It can be optimized with some additional code in __split_folio_to_order().
> 
> Something like the patch below, it assumes PageHWPoison(split_at) == true:
> 
> From 219466f5d5edc4e8bf0e5402c5deffb584c6a2a0 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Tue, 18 Nov 2025 14:55:36 -0500
> Subject: [PATCH] mm/huge_memory: optimize hwpoison page scan
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d716c6965e27..54a933a20f1b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3233,8 +3233,11 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>  					caller_pins;
>  }
> 
> -static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
> +static bool page_range_has_hwpoisoned(struct page *page, long nr_pages, struct page *donot_scan)
>  {
> +	if (donot_scan && donot_scan >= page && donot_scan < page + nr_pages)
> +		return false;
> +
>  	for (; nr_pages; page++, nr_pages--)
>  		if (PageHWPoison(page))
>  			return true;
> @@ -3246,7 +3249,7 @@ static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
>   * all the resulting folios.
>   */
>  static void __split_folio_to_order(struct folio *folio, int old_order,
> -		int new_order)
> +		int new_order, struct page *donot_scan)
>  {
>  	/* Scan poisoned pages when split a poisoned folio to large folios */
>  	const bool handle_hwpoison = folio_test_has_hwpoisoned(folio) && new_order;
> @@ -3258,7 +3261,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
> 
>  	/* Check first new_nr_pages since the loop below skips them */
>  	if (handle_hwpoison &&
> -	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
> +	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages, donot_scan))
>  		folio_set_has_hwpoisoned(folio);
>  	/*
>  	 * Skip the first new_nr_pages, since the new folio from them have all
> @@ -3308,7 +3311,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  				 LRU_GEN_MASK | LRU_REFS_MASK));
> 
>  		if (handle_hwpoison &&
> -		    page_range_has_hwpoisoned(new_head, new_nr_pages))
> +		    page_range_has_hwpoisoned(new_head, new_nr_pages, donot_scan))
>  			folio_set_has_hwpoisoned(new_folio);
> 
>  		new_folio->mapping = folio->mapping;
> @@ -3438,7 +3441,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  		folio_split_memcg_refs(folio, old_order, split_order);
>  		split_page_owner(&folio->page, old_order, split_order);
>  		pgalloc_tag_split(folio, old_order, split_order);
> -		__split_folio_to_order(folio, old_order, split_order);
> +		__split_folio_to_order(folio, old_order, split_order, uniform_split ? NULL : split_at);
> 
>  		if (is_anon) {
>  			mod_mthp_stat(old_order, MTHP_STAT_NR_ANON, -1);
> -- 
> 2.51.0
> 
> >> Or do we want to handle THPs as well, in case of split failure in
> >> memory_failure()? if so we need to handle folio_test_has_hwpoisoned()
> >> case as well...
> >
> > Yeah, I think this is another good use case for our request to page allocator.
> >
> >>
> >>>>> inside the page allocator (probably non-uniform?). We can later re-implement
> >>>>> this to provide better support for memdescs.
> >>>>
> >>>> Yes, I like this approach.  But then I'm not the page allocator
> >>>> maintainer ;-)
> >>>
> >>> If page allocator maintainers can weigh in here, that will be very helpful!
> >>
> >> Yeah, I'm not a maintainer either ;) it'll be great to get opinions
> >> from page allocator folks!
> 
> I think this is a good approach as long as it does not add too much overhead
> on the page freeing path. Otherwise dispatch the job to a workqueue?
> 
> Best Regards,
> Yan, Zi

