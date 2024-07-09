Return-Path: <linux-fsdevel+bounces-23396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C494792BAC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5053A1F24341
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5AF158D8C;
	Tue,  9 Jul 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cv0ONxh4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T5vhm93s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330F12DDAE;
	Tue,  9 Jul 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530857; cv=fail; b=lbuYoFlELPcBlcvYLVYr4LszOAp3Fdwjp8uwYhDFSO0VXTIuFeonVVqVaEkRSTgoNqsxCnHCZkBOmC8P31Mpt6nFLQB6QCmnZ0TaUL0IbqRs5nFvh/1sdlaCE64Y8Q+Ii215G2cmXfTr/7dQV+x9iQok/oawKYnyffOG6A0e038=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530857; c=relaxed/simple;
	bh=tiNqwAuI8jxJ/mgetbvAgmHSx+DbYIizWPn6wFxLU8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lRELYbEiPloJ644p6UPC+0zlpFzrldZYtbjYfBipyp9EgAjq24hE1xNosZUHBbXoU3pIrBIV/J3KieXX0uO5IQtxUKnYN9w8dHbsgimrkiUJ6SrZ+Wq8iZ2Y1L4U1Zdv/Quz7qHgePl61YmQg6tBW6o21nFZQ/Cmc3y5PdQI+No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cv0ONxh4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T5vhm93s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT5eg024972;
	Tue, 9 Jul 2024 13:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=UBiL2xs6iDQFEMh
	f5HdRucXQ1tQUTvlQ6H7YSULEOV8=; b=Cv0ONxh45Sa1oHHfXV8Qwtx/uS7rp4S
	HdFagSuQ8YgdbWyDDwwDqvbY/OnhIM7KpZHC4cqGpejQ7Pf1YVK2u9kjWUaImj0Y
	xbv4YAhZ+ZFX/VjIj6aoanfCDvg+wLvI5oGQDDrffuqqMi6d0b0j/v0dacZUmYyo
	q5TW6B4Rv2Fh8Aa5FW+tPmyT9jwz7BZD8L9ChV3SZ0jv7tKi09Adcn/iPZdTZDOS
	Ug6YQwbCKq903ffP4D/X+kp2UhOYy+IIxczC51ZnZf4xPwKC6v1h0Ixrz/4xADR8
	sb7slkVXo9CSsE+OjzydrNzXdLegKZXVzljMXZro8+e7oRKel9qSDeQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky4wvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:14:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469CKdww037162;
	Tue, 9 Jul 2024 13:14:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv19t0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:14:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS31MwAZ7gqC9ufi+/H4/mtJwMFBo1IWXfVFyabFhsiRkSArLR7Dn15TOKg/V2OM3lOsBd+fPzi6h9O5i8PKqyxWd5qnsaSAPEf5Dvr7WMXXTDAmGZwllD/rO3UPnr0zopu/NkXPvi8MKD3JmDWooWtXkOnGQZGvhfcHpQPXDVJkvQ3LNMao9CXH3zImeet/rAOq6jDo26z3h3ivDk61B33Vl6H5VJJHNmxRCkDSScuS24OAQ263iGEeI++yvFNYXrXC7ZVqdDtvDOlF1qYoOBMTRTTYQvhFcClpJ+EAgAet/slb203wgjAu/1m6LdbBJQYt4JFlZdOMU7siux6kVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBiL2xs6iDQFEMhf5HdRucXQ1tQUTvlQ6H7YSULEOV8=;
 b=LI5q5IxZYSMQS1UB9nUubiiaWQzE0kD+a+rceF1V3G2ABasaK63HLWnf/zLujWIgAh/fevw4SfE60mrEK0JyRNwhq6AfBeFs7kiCNCoKehGLy+YbMxCgnFkkpgPPpTUQZC5ywFTO8mYpR3J47fOe+lQKnoTO/Gz5OVIemv0J0aFNIqsrnJN5GM+cCBwlTEYdBGDrc3b5UjKCkz4Rq+CQQuIFQNAKS1IO4qVooyiYv3Gx/ulAg/oqlf3YeFhNmRebpkzn+khJSFZV5KcxGZUB8yqZy6w0NAdhWba2t3sgB8YzuI51Inx9jACkHjbDU+dNRFVphtcbO1gC2VduO01YYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBiL2xs6iDQFEMhf5HdRucXQ1tQUTvlQ6H7YSULEOV8=;
 b=T5vhm93s9ZC+hiuF9N43bS9odIFFFTWE7IimWKwnqX412laDxp81A/Ze7SvR88W8O+G7z8Wow6ObNPC87AhizXolxftPyYjPLxFwW71tmx1r0ER1VOIj74PIEos8+iK7NK9BnN8moysLtIlUQlhtdnnBZAnOWYxjaCweehT2UBk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB7060.namprd10.prod.outlook.com (2603:10b6:a03:4d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:13:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:13:59 +0000
Date: Tue, 9 Jul 2024 09:13:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 6/7] tools: separate out shared radix-tree components
Message-ID: <6fydm4hfvo3q6ae35sbvsh3epoa72timp2s4hx6l4wb7zgsvav@tlx7eex7aty2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <98f5264d2cec9ab7d066603981e8c0ad0a8752b4.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f5264d2cec9ab7d066603981e8c0ad0a8752b4.1720121068.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:610:b2::30) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5f1bde-384a-4922-4252-08dca018feee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9hUYe3u352pYT1hyyt+kdtzelqUSvp4zUL3vdm5s3HLUZJC/dpVyvkZhcSqT?=
 =?us-ascii?Q?MvdSUFkq+3bn/+AgE3gUj3zaJaaW57e9gNKkUeDZ4ZAeo0sppcjfzhD+E76N?=
 =?us-ascii?Q?fFoFVIVlN+9IrHVX16dLhMF3Vqqn5noCf2wUUFfLRnKBUXyVF1JZ4wJ/zgZs?=
 =?us-ascii?Q?d3/KAb4CeWHYJoxtL7/W5btTz+4n1Wg5gF6qJFW1pE7R/MmHP/Cb2wmPqJmu?=
 =?us-ascii?Q?NM3zwR1ZnwbUj48Bh4zXghYxWQ9UsPAPBqplES9086IoTeDEoxkF7Y67AcC0?=
 =?us-ascii?Q?RDwlml/5rtodheb4hLaScpiiPu3GHFR3n4f+sl1lV+xEEU5EHNTEctE82emg?=
 =?us-ascii?Q?KMIF+Z7olyMTqpuwvPJrJ5U0SBFFI397XFBT80aF0jAJHPwg0ZIz2geTXCam?=
 =?us-ascii?Q?HXmEiHu7Trk3d4rrNO6xyQQ+NAxjz34poXqm+P6dR6iCQK4o9kSxPY34T6U5?=
 =?us-ascii?Q?IBNsn6XMPh4xoCBo6ggF1dLFV54+6g7c495k2yDKLlepIrpvAUvo6dXxuPcx?=
 =?us-ascii?Q?scJBUhtyj58rnGhn6gH25uadzr/y3HRPoqQpitjxWSifNAyFzBKk8hdUnwAJ?=
 =?us-ascii?Q?pTuq7IX/x8UK6xV4JcC907vM+aytjuhcQeinUNb/VcJpl+bgX/+idVJcQaDx?=
 =?us-ascii?Q?JJq1jduQ8CAcb62U5lPydpo0+2A7YuqplKVW3kNma4142xE5Po1Yz9I6ecxw?=
 =?us-ascii?Q?bosGDMdmk0AljarK1i0Z3YcYvOfXimsDcHiQK3KutHXVHK0U400Wqzy+rokw?=
 =?us-ascii?Q?X5Po1rIcvZeU0fx4MvSAqQq3ImZHXBWTsvPQZngxql6zoB4C6Xeimkbk4rkE?=
 =?us-ascii?Q?7/qLO5t1BVEueh8+o9mxeFhhscJ8wArh9HDYZKtJaHGU061nJlmdss9kxRJA?=
 =?us-ascii?Q?ehVahWs9IKZ1tKez99XFJGJ4TGMAD26ZagOIP5k2JpF9cex2XyXDLskDdN/Z?=
 =?us-ascii?Q?ausAtajrUyuoYckzdq+CdLmB07sGr2Z8o47iLbCmUAZY0JAT8uK4mk8fzb/s?=
 =?us-ascii?Q?rDYeGyJfKY5soMGjCeRHsC9+JxVd/KW2iyV9HD/ivsU7Rar3GhcmuoFoCqEc?=
 =?us-ascii?Q?U4F6HUzWjoG3bJG0mLoMiuzAQgwFT+UneELMYjHQuRMeBvywOVJkoyhUQ6w9?=
 =?us-ascii?Q?w4IsmnSLEQTIrVxIvfajEyRaeJBl/srz5OCRDUpYqiadv2vkFgHy/A6Pw06k?=
 =?us-ascii?Q?yh5oCkVT+Yh1A70EeoNhPh4tQLtaqX+FrtJpLTCrAl8urGuKu78mDU50FLwP?=
 =?us-ascii?Q?I4GMDkxWSsyXrQfLr219NGI5Bd/inqyCBH0Gm+vp9VU6xfbccsrRbqzCknt3?=
 =?us-ascii?Q?VvB58qCRZgJhNm1DiEQVziQHWyYE5888Za+qHzmxeV4vRQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aByJhP1GQkDJ+vvuGJ22Z01bZmpRZkE9AQdjVo8W4oodXhzCRAV7G1P511SZ?=
 =?us-ascii?Q?s61Jr/5G5DFNh6CnL8tL1AYtISwx+uR5jsyXh88x4v5xChsfWTFeDQRaZaM7?=
 =?us-ascii?Q?S/BFla9lsvrH6N03YnNuwdHBTQE2mPIRmjIvaiG9A/8e5jCMvVfSqt0g4EIK?=
 =?us-ascii?Q?gXZJ3cVSnO7PYc+uDHWXYuwOLfXQp8ZrS0LFuUAWMWQzb+7H33iuWqavFYSd?=
 =?us-ascii?Q?A2SnXMmqGakz3YZjQEfR8vIVJQJBM58+2CTAQSu0sexPgPydKCsIvmW0XJmh?=
 =?us-ascii?Q?u5Ng4LskKgFakpemxfnfapBKkszQZyS6z6NWqXPorU2Y7IRcjE6zK6TpBzWt?=
 =?us-ascii?Q?AenJVQYwzdtN4rOtEeedm+4c3dTK8aSOuYuh3iuo9F6V/X83tXehEcB1v3Ir?=
 =?us-ascii?Q?wxLTlht8nGeZZOdQs5UXBBqzqzrq2aDSlCDXNHOS4QiWPikEQylqUXHJt9s3?=
 =?us-ascii?Q?tj9CbXFhrzv96srqy7FR7VZIaBZABEvbEFCIDvzJn1fzGPTOOd6+3s9p47Tn?=
 =?us-ascii?Q?W7YHo2L5vw90Ncoz7ZE4litX3Vt93Chjp1D+Eml6/Mq8MUSat7A+N30rBmrg?=
 =?us-ascii?Q?5EOiH4yyqIIwO62iJhbBsGMQGNk43DT/+X6fQUNp8nlCQvllqBnn3wWi67u0?=
 =?us-ascii?Q?kv3SiZvXpErNaocdCNsVEBcxGAKKJFRAo4Zabdgp8Jj+vVTc3rroq63uEU6s?=
 =?us-ascii?Q?TV9bJshcz/4kNExLIzDzSlwKNUIdaZvUHPcSB54+AfAoD9QsumkeKCinFCi/?=
 =?us-ascii?Q?cJr0K65bVtw6fzpPvcIiX3jOqtwjZs3MdJK0Rb2tajH/iIs3HBhg/IpMGfMN?=
 =?us-ascii?Q?/FGq601KCAkCswFJjXuXo2nalJ6Ct0dgczoZbbCGssJPTZ+nS02VH5yImLkk?=
 =?us-ascii?Q?E/EVLohNPgAk56zD8x5WChYpPMEbzuehqZKxsaProYwcezS6U/GF5SrmoLDi?=
 =?us-ascii?Q?3j9/fG8b/UofG5WpTpkas81OMeDTtC713TyIIfRJpHKK/bZdUQix9Fj9de4q?=
 =?us-ascii?Q?5A77HYq7jZllCaaPNNgJAH4+HoMSZMoPW6LUkZu301IMsuwTUDieN/UWDyHc?=
 =?us-ascii?Q?t1Xg8ElfG1sFZyLofW6ALk6a5a2H2xgVGwVm49A0cbPoBEWxCxVxg2tDExc9?=
 =?us-ascii?Q?v2vtKIG93CT+XxCCA6m5ehoM5YWnofQ1Yla8D0xctt0YMwbOUZyEShkREQog?=
 =?us-ascii?Q?KjBRphfMYcxx8S6Xsoz7GF+RL012nfCj/M/uEDQomz9O2SZNp1sLMHnZ0Wb/?=
 =?us-ascii?Q?vM/ZUOY1u0WBJHswxSbdTFf2I4KYnqBzqaHwQBIKsmaUvnB6votoJlv2ynGh?=
 =?us-ascii?Q?VjnyWw+dJOmVAbRz27adqYszGYSGA32+DdYqhXPYEmxpS57MYx5zdzyo0oNk?=
 =?us-ascii?Q?kU39iB2lHpQxV8lCzE/mp2iidmE5qHvInj2PFil89PZ+o/XmIQuAE23OmmWH?=
 =?us-ascii?Q?Uekiv0isV3HCu1H2J83tRwTOQoPN6+iltAM7kYMVHSnUu4TVB4lEWj++xVzy?=
 =?us-ascii?Q?My1luq0KwYs+r75FHOXo+dCYh65rmOqu8JGQT+nY7qpU1+DOIVOjEjoGp8vh?=
 =?us-ascii?Q?nA5m3DhxmM27Vv22BzCtKMGuzxBM0OLR4HsuaqRg2vSeQBvPYLyUJV1tLwUD?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3NBSNTWPtQKqcy4DCAlXGVlRqvaeb5VExEX++ZF5fjXUip08L1roWu5wwR4Bhbvab9iPAeOQs1eTwtvVlxRm12iQo1rSfX8WT1QwkLriR57W0+yhImiKAIN1WHk5UB1OaZOIHoDU4LH/UZ0fJPdvoQjpro3yguINjS1EnqMs9QDjU6YhWHY6UZxEtwPzYVJ4VrHgyAn5W5hfxEKvIXf2GtKu1MfP5MHRnGXMjTwkfJBTUI6IX8lQRRFh+tdEON7vjvkYBXcmi50wYzbhgadPUR0hWwy4WunsaoPSVGFZ3Q7mMy0vRwrWBfKJ4ABSbQGS9pvJR51DfDoQjcrrnisVGgoB8al1HaH1HJjDCF2zIWkOEplNv7LW+KpMZcAcZs540J1tf9qhyH8WwhbBDJLhHU4KoZ68rza6rCbFwrgSwe61YmEY2NAfLdEFGPc6Rg5+13vHLx0xWfow5B8m3FgCf8TQAZ/MhN91LTZQEHtqrXgO6DfQ2eCNP3iF602n7+cnCR0bp5JmP9EQjIU1xMwoUKOwovuVv0fAzJXKIYJX+5hXo6gcAfu9DrXXRfBdww2LVQ1kK5uI6J1QjMr0fa04jh5K2D3FNdNhO3rJf8VcU6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5f1bde-384a-4922-4252-08dca018feee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:13:59.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhQbSdb3UR4LecDSy5xJtu3QMxEpCbQt65jvDwn+ebMOmsL+ZTF9o44XhrEQnn61Ysd8JNGwmSlWf3IvsmnGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090084
X-Proofpoint-ORIG-GUID: 2Yt_AFMWLX3dqctEHb_rEHHM-CAys04p
X-Proofpoint-GUID: 2Yt_AFMWLX3dqctEHb_rEHHM-CAys04p

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240704 15:28]:
> The core components contained within the radix-tree tests which provide
> shims for kernel headers and access to the maple tree are useful for
> testing other things, so separate them out and make the radix tree tests
> dependent on the shared components.
> 
> This lays the groundwork for us to add VMA tests of the newly introduced
> vma.c file.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

