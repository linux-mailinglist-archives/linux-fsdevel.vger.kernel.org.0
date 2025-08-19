Return-Path: <linux-fsdevel+bounces-58310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FCB2C74E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57A7522CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C52765E3;
	Tue, 19 Aug 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W7LObWOJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zO0YuP6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0C264FB5;
	Tue, 19 Aug 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614213; cv=fail; b=F5BLzGUaUNsHvJrejri5JMdof498t8SNzLBQD18CEo8YeaulJTTCDd2tK8oK4zcwb6wF89nRE04tg+zWfvhQYprTDIy/bhGccjaV9pwoXrPRse+aVLMrOi77cVt0boI3j8/2qAcrp3VyaHRAIFbJ0zNZMTpW0F4Yo6wfMULrt3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614213; c=relaxed/simple;
	bh=IBkv0bLo8LpPpxti0tIkJH1x8n7r5q2p/F6YEq6GWaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CtAhY9FU27lcKU/x1xykfd10KkAzAMMNF+mtjjoKpDSONP7R5/ndo/qF1e3lrB5IgTOzk0ZYXvuI+1EFUs0XufMXrPHwjgkInGYVuGtGK4CkSDbMjQ6jHCXo/nKYsumB7eBUlYSEirfez42HUbXnIiZCDCMS/9/XfrcPOTijaQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W7LObWOJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zO0YuP6E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDit3P013844;
	Tue, 19 Aug 2025 14:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qhOdz2SlTvmhIHlsGRHJXkjsMPKGKD+2J+h+f9amTGE=; b=
	W7LObWOJWq59SdvNVzKVmvcRVyoWnRGhcoiOMpZrYGPR3xXHhytVubA+fmVhAYP1
	5PwkaFCioFJW43y3eXC7MtSY3kKpiZR3j5n/X9esAQAr+sZ/aKYPPtPhfrYER7V/
	6deV1Mmj2gZ+eS8jyAOIqHzQwE/oXo0T78+VqT30YQdyLVgqtgxmf2UpkFUFJean
	vMy6lAmyb6J251JzGolsnz+iwlCzZlwZF2hEDfj0BroYTHn1+dliRcwV5Ey4QefU
	53WEpxhZ6BgQpEplSj+2YN1L8DK9UHTLm0EMX+t0TX8sBrUDYIi/rVffCVDTvNcr
	dyENiV+hZZMzrUS73QvP5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jj1e5h2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 14:36:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDkDfH036702;
	Tue, 19 Aug 2025 14:36:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jgeb16df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 14:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4hEgoFTrr6N2Z4KlkxOS58ttqIMfS8CEzD2mcLLYU1p2nPPRqV597NgEYH5r6+sr3yJZChyoEHvDhail38hQqrk+y0RvgAgabm+xRvnwedQDHsQ1DToaTYXGnKzLmbzFA0UzZJ6Mth23kSvhqHrHsbgShCd4tgxWkjMsNgBpJ6hJrEzXxQv85KluEJgh/UneVzU79ErKTP4aUAuzKLd66D1uVV4yeRLpgHsonOTnaX/AuzvUtyFf9bbDNSCqmU/AkLdWV2icbPM2j3T43CLkm9YvtF9PO6veNYJXMWbhGq7Tm3Yknpguy4QMRpWv/rqbkx09KGRq+Xnjuuq68BJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhOdz2SlTvmhIHlsGRHJXkjsMPKGKD+2J+h+f9amTGE=;
 b=iMlosirbckMfYZJgjxIWCldYtEvmYi8edoLHSMfTeZHG2ebCgwcc1QGM2sUR0xOWYpVPSkfavTIJScrzD4bJiu3neuVuAo5SkqdQ2N8S9TL9QcQ024hFw2vBBOWuEepv8HuRorVEGyZaUT4c585O2tMRrnAh7EJxZFQ+jHZQtuOxpvu/sWeDTE7EKicOu1LiTyURWhqAIY301bwCKZalJ8QJlywL11vN6v/6wMJCKZtbz2Wu89WEtAeX4kgR3EW9G5OUTptQRIIkfQ3FHDP4igH7d7hnAtXd008dw51UrLhIJueUS3vxcumtCUQoBRog6Hji+Jg/px7G8ayn66Fp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhOdz2SlTvmhIHlsGRHJXkjsMPKGKD+2J+h+f9amTGE=;
 b=zO0YuP6ECSztGo2yjriF0gc/63J4QtT8JJTIC/XCokCxVS9rgH7P3gCEJtFb10mKpajkGUIidSYAenETQe2cw2T623bpOr0K3HLupheBSZzhURZeBh0J6qM2bWj1BCvBV2H6Q/slqOo2XQC0wR5QGcVBGmIOi5A5ko7I3k9jOrk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ2PR10MB7038.namprd10.prod.outlook.com (2603:10b6:a03:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 14:36:37 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 14:36:37 +0000
Message-ID: <59a0d2df-a633-4f82-8b11-147ba88b7bcb@oracle.com>
Date: Tue, 19 Aug 2025 15:36:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
 <20250715090357.GA21818@lst.de>
 <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
 <20250819133932.GA16857@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250819133932.GA16857@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ2PR10MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2f6bc4-6729-4cca-82cd-08dddf2dcd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0pJRDB4alg0QjRobExxR3NSV1pJWDQ2eVgrWDFpRzB4M0FROUVaWnpaNkFC?=
 =?utf-8?B?WlFnWUJDODh2S05DdVA0M25ZNVlXM1I4Wmg3bzJpOVZ4dURvK0xEams2Lzhw?=
 =?utf-8?B?b0ZuRnlFZkFubjJUeHc2WXhvaHNaUXUxeFRWQTR3alRSTU1PTVFtbWpqMnJx?=
 =?utf-8?B?NzJmZmowMURtOHFmcHdlcmJZRzVXeVhSYUx3VDdDcmZWcGNucDE5T0MvMkQ0?=
 =?utf-8?B?b1IrTU5tVEg2RkZ0aCt3dkxoSEkrWE13a3Fkb3p6RnNVWk9Bb0RlYmRpbEla?=
 =?utf-8?B?R1grMmdFUitvMmFBU3NQMXJlTXVDN1RiNERQVjF5VXFUS2xxY09uOEhMNVRH?=
 =?utf-8?B?dHVYL1N1R0FsZjlLaHlhK3hMdkJ0c1NML1BmUEp0RUZ6Rkg1M0g0SDlRWWMr?=
 =?utf-8?B?YU9xYUh3VlpoS0lEb3JTenMrY3Mrb3l1bDh5Z0ZvUURzMWw5V0tXN09Yc0pR?=
 =?utf-8?B?b0RCSm55V05QUDRteHRSdzNlYTl6RXJjL0l5clRRaGZzNGcrdW4vY3hwZkxj?=
 =?utf-8?B?ZkkrMlFkWVVyZzdsN1RGb1QvUWw2bjhkdHVidjRVUWpzSGtyQnJ0MmlRczl2?=
 =?utf-8?B?SHlUTHNueDQ5Q0FhNnd5WVRDL1I5WUFvN3N6ZDhtNUpNeTVEWldkR3FJZXd0?=
 =?utf-8?B?Mm9mUDUySE9WRjViMHdZNng5L2FVQTRySi9jaGY4b1dnU1MrcEJkMlZaanVv?=
 =?utf-8?B?OS94dklpSUlpa2V0S1BlbWwvbCtFdUI4RmRMbXNyYmRkbEJZQThueloxZHpC?=
 =?utf-8?B?c2t3RU5XVjlBckdtSXVwVFFlTlhLTUFObmN4dFZjNHFxaFBtbTdVNHpTWHg2?=
 =?utf-8?B?Z1dDS0JpUW9mUVpYT3dZSHVQRy92UGowSzZ5eWs2OWVlNjB0Umhub1oveTdN?=
 =?utf-8?B?cFhXa05wN2dmS1EvQ3FSUGxPV0VRbzl1dmtKbDVLVDNhRlRqemVPYVdkZlZn?=
 =?utf-8?B?a3Q0RzhodTNHQjZXTnNYY0V1bEFZSHVNdzZ5bzZPQ01URXFMcko4Ly9IZGFV?=
 =?utf-8?B?cDFOT0FrZW1JWllSakFNSVRXYmFJRXgvUkRxU1RnYWMyWWw0b0RKUTlydWY1?=
 =?utf-8?B?KzZ1T285RS9ablhNV3BUUGFJMmNuZWE4MXJlT3NnWkZPU2FGd3hyUFVKUEo2?=
 =?utf-8?B?eVpRSWhmQmtKeFFDUU9UaHN6RXUrMTNWdHg0UTVBeGRNeE50bEd5eU5GSkVu?=
 =?utf-8?B?dmp3WGFYSmo4ckRWV3BuUlFhMnhPQVVqWEMybUJQeFBoWkNvclRoVitDWFpZ?=
 =?utf-8?B?aFlkNFhXUXMxamZoS2QvS0N4MWM1c0JPOHN3eVZHZlpEZnA2MWhTWFIzcHFR?=
 =?utf-8?B?OHZXM3lyWEZzckZJRncyVDZ4M0cvdVluS0tVTnhXSmdUK1FacTY3cVluS0N0?=
 =?utf-8?B?dTRrY3lOWDlYV0pudzFsWUY0d3Y1aDJoVjRpZTh2UENxOU5rVUYwcWpFRjk5?=
 =?utf-8?B?WFQ1bVJodlpjOFBxT1czSTcrR0VsV1BRVHpDOCt5SDFmV2pNcTVOTTZ5SHVL?=
 =?utf-8?B?OFVTcy9JSzVlaVVVMEhPOWpOaDZSRlR4L21oNGpiU1lKR0ZVRmRaRTcxcjdC?=
 =?utf-8?B?cU1wK3VoWFo5Qkd0YlgrSWFwd3ZHZzlLWEhZRVpMWDdsL3RxdzhPZU53dnZS?=
 =?utf-8?B?ZFJlYTIvQitoTmFleTFCOE1ENG8vQUI2azhTNlhlZG9IcXVOYXlPSnVaazZ5?=
 =?utf-8?B?WVQ2MWNsdHIvcm9hZng5VC9scWZlWElVdGYxWURVMTFkbHRQVlRicUZHZkVD?=
 =?utf-8?B?SEdBUzlHSkxmOHlFaVhQb1NZY1pOQ0tuOEFpN29pdU9scGwwejVicEh4VWlB?=
 =?utf-8?B?Y0hHUzdSajE3Q1B2YTJZQ1BlZDBhUTdScGlOdEpGUmwrblRMNGQ5RmRmN3dz?=
 =?utf-8?B?dFR2Vjkwa01oWTU5WmQ2c2trczl2VloxZm5hVVpsSnlQZXEwdkt5WTZZNFV6?=
 =?utf-8?Q?uyLqVvRU1Rw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1lPNlovcjk5NUdBS05rUzNzOUNNZHhIblNkL3hHQVd3ZzNkNTg1MFlvQmF5?=
 =?utf-8?B?R3RRMDMxcm8wZGFPRXpYaVdqUnZydm42T3pnd2psNDFBYzF5ZjNVRm5wYU92?=
 =?utf-8?B?VnFFY0RhenF2STBlRnYvTUJqeFlvZkNjNDhSRENaazNhVmg0S0RMSjVvRC9B?=
 =?utf-8?B?UW5MN3NOU3Uzam5HaE5UMk04cDhRY0pid05XbDUvQmVnSXFxRWpRMkg2ek5j?=
 =?utf-8?B?NWloYUYraWRmVVFuY0hSTTVJRjBVVzVJdFVpaVgrWW9SemtmVEdXbkgvTzBQ?=
 =?utf-8?B?SmROZXZSVW1nMFlQd2pmVzRJRDdjNjF2ck1Od0wwb2t3d1dzT29ENGVxMmU0?=
 =?utf-8?B?Ky9HYWFqWVFwdElkQzUzM2pNTHpNdUltajl2KzRaNkEyZHpZWmRqWmpZUy84?=
 =?utf-8?B?K29FSUd5VngwRVNXekZHS0Y3Mkg1M3grV0RrWUNqZ1NzcGZwajVPQ2Jaa2hI?=
 =?utf-8?B?d3JNYnBzMFltcGxoRHhUVG16anZzK20rMTlzN1JsQm8vYWdsU0xIZ1JJVlJD?=
 =?utf-8?B?TkYwNTEzR3U3cTNleE11SldCbG85SkdicFJLdElWZ2kzUkR1Q3pJc0hBakRH?=
 =?utf-8?B?dDZHUC9VUHVwZUg4N251c0wxaDA5YnA5MDVyTzF0aXFTQmZiZ0srY2J3S0Q1?=
 =?utf-8?B?MVNWeWZBYTh3UGwrTUI5SjhsVXM1YjZzdVk3cnJ5SHhISmFMTVpiUUVaUWhs?=
 =?utf-8?B?THBVNjk5cUhma3RSejBMRldzc1RaNnUrQ3N6bWJMT3BXTzdDc1NLTnNvbTFy?=
 =?utf-8?B?S2Z4VlpKdFBFL3FDei9OeTZXWWk4aU93UGFyYkJ3cEwwbDFuakNubjJkQWUw?=
 =?utf-8?B?Nmprd0tWcEFZbHpVcmdzWkVEdnVuOTdGWTlNeXY2VUZ1M2RINzlRMS84RWx1?=
 =?utf-8?B?bUdyQm82OUdXRkNyNmhVZFBUYVdWdUhYTlJua1RiRGNUYkZ3blU5dFNla2Yz?=
 =?utf-8?B?czlTd1ZlNitOOGdYQUNXaE9QWWVwNEtnYjVSNEpJdGdQam1OTnVTQUlRMHJE?=
 =?utf-8?B?bnJjNExyanhUdFdqbHFGbkIzcmtlaFRlM3oxMHpaVkNGb2FVZHMrNEg4amNC?=
 =?utf-8?B?T01GNjFOb3BNVHVYWTBYL3J0OVVQRkdRWlpnSGtGWDV3QkRLS1VjMUIwaVFC?=
 =?utf-8?B?bTArNDlSWlFJZTNhNUEySDVxUmtHQXJqcUdiZU5ISFZpSzl4TFhGK3A0SnlQ?=
 =?utf-8?B?ZnNSUlZSd3k3S2xDZ3VpbFhuZDl4dDNmZnQ1c1pwWGRBb0x1NCt0MFlicysy?=
 =?utf-8?B?cnMrVzI1SUMyQ2NLdDdtcU5rYmJUTm9QQUdlWUJiN3J2Z1ZwZ2cvdUpHSGZD?=
 =?utf-8?B?d042Y2hheU5iallhVFgvQlNBYWFoRmVNUGtRNGFrSGpUTVJ5a04xMWxFSHZV?=
 =?utf-8?B?V2FnWi9PeVhhMk1rNFVPZ0NBZVE4eUN1YllmRytyQWM2YjRVNTV4UmNqdHJi?=
 =?utf-8?B?ZzliOWdqVlkwdmpKenBQVEs0L04zMmhDZUNLYjJXVzVSenoyOVFFODd0Vkk2?=
 =?utf-8?B?QjdlUmpReTZvQU83R0VydEJHSjdsS2FMbmFwTFBrMWNJMzJXN2NORWF5UkRS?=
 =?utf-8?B?RDdwYWY4VmVGU0F6RkZySTFKQnRKeWVOSGIveXd3MlFncEhBdmpGSXJWUDJT?=
 =?utf-8?B?bUJDWVVDQ0o2MDVwTnp1dTJlTmcwd2RybzNudDlqUDdXZWZYSUs3VXVDeEFL?=
 =?utf-8?B?ZXVRVFIxRHRsWFdhNTlsRXZZYUpmZ1NmM0hCNVZ2aE1mVW9ZRTRjUU5CLzln?=
 =?utf-8?B?b2NtNEQrZ0JhZlFXNlVqVXRpTnhRS1ord0sybVFuWlY0ZXJBMzJGbTlQaTV1?=
 =?utf-8?B?UktzemxUQ0pWck5rVEhOSFVtMU9sUnl6K2lOMkRmVWc5akFPbXNJM0Z1MFZk?=
 =?utf-8?B?RXhONExSSGxJdzhuMXFzTlFOcHB5QVdkRU53M0IvZDZqS2RCaG84dHp2N0I2?=
 =?utf-8?B?dWhvd0tJcFB3aUVJVWVRK0hqZ29tSGkxclpXYjFYMlJ6NVBlMkM4azZBMmgy?=
 =?utf-8?B?TC9DNzZkSURKcXpnZ1F3UExxazhlRURFR05xMjFicVEyNkFFWmcyem9FUVkw?=
 =?utf-8?B?Q0FNekxlUGZPZnJLS2orSUxrZnh0MUFaNUMxZVZ1Zm9Gam5kTXNJT2ZlV29U?=
 =?utf-8?B?Yk5QWEVncGZEZGdaeGtKa2RweVQ3Z2R3c0xMVWw4cTlzQXRSbkhJeDRmaU9z?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dVR+OeL4jkVoHBhUb7zUzwJsskG/AbGEnCpr3HPSQLtZiW65wawCDXgG1HuFtly6d3RLheXMG4GGXgxVreP0ZERfnsYOLHEz1ftcOFTgWzBF8FWhGe6MqZh1yjRmklg4sRNKwCyAWT6+vT6LTZyryCByvqrcgxc5JyQI2AM0cSz2rHblYrk3RW8SPojlDFwdhTZ8q8RWNy2+466e36J2la+lJIpuiV7MD1fD3NYa1hjtD6eKsZ1ccKEHCUpBOZsnN9GBb9O/ZRSPMJbX8WekjWbwKQ5iyNoLH/ifxmOiYJCPkJR98/kOjytdykTA0gK8Ly0/at1qpDJzOvuMrNfVWbXvUPTYyXRM3a4K97d439JJQgWl1o5vyPMggTmEAw/wX8hRuuARiGnS2Tskg5uHe3+Su2+1BhErTUpWlUjhuCX1ByZv7MgL+9aN60S9c8XEyxFF5VaVwiBF8FlrP2+LWtqnHo9g19a6bPTYlqH5vukMMcOUEH0KtNfACMWydbtA640TBzPmuJWpl579CEd+w7irMEArZ85jPcT0uvst5P3MQITRhpdJUF+G0TgNrpjclkVGfo6TuDITMlACqs16Xccw44tNyYJAYx4+keqYHM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2f6bc4-6729-4cca-82cd-08dddf2dcd49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:36:36.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZYXU3OmSFLZWQExL1uE81dQrr673gh/JIGkjsqQgEV9eqZIyGLsE9qD/1iO47poIrKiUK7nR3g/jzfGa3B2iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508190136
X-Proofpoint-GUID: Is3YVcH6UIPl8vvlw-pPUi4_ynLyuGhl
X-Authority-Analysis: v=2.4 cv=dN2mmPZb c=1 sm=1 tr=0 ts=68a48bf9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kLWA3gBXtu5QbDPQ:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=9pbvY709o8pVKMR9FcoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDEzNiBTYWx0ZWRfX508TZ27RDZmt
 h+uSS1wjKHAyvf1moO66/ndX1+U7GvMf3V4UYX2e4PcTmbjFRWxdrn7g2pXqlxiGWeRthCIlE+S
 3beUSrweYbBMU8/YE6C43rxgQoabjkNSudg6z2dMhuKY/+xFmyVJPy0U1GwSNcyeJSvQlORrlxG
 G5DxoqYAeL4WjTLWHp6Hx9J6Mu67Z2tXeJp8DoiPLcKRmb9Qco28Pwj4ekJ62W0jEsV7D/gBNNq
 fA7iaB84FN1hphS3ZUb4nonWNN1TzIPFv91tEvTInAROzi/+QB470PzpAA70CmKAZg1fvXOa8m6
 iLvlV0xdY3D0bTNWgDMvr+aXpYz14by5IRGXCXSIGeS+Jc5y5bx7HtyLHTII7KM3JyQbHeNd909
 iZm8Jo51r/enOyDfasgwpYdGl9CbF7lS7ZtN52SKNOb0ShtjmIweQje6n/tNoBQ7cbPSUsXi
X-Proofpoint-ORIG-GUID: Is3YVcH6UIPl8vvlw-pPUi4_ynLyuGhl

On 19/08/2025 14:39, Christoph Hellwig wrote:
> On Tue, Aug 19, 2025 at 12:42:01PM +0100, John Garry wrote:
>> nothing has been happening on this thread for a while. I figure that it is
>> because we have no good or obvious options.
>>
>> I think that it's better deal with the NVMe driver handling of AWUPF first,
>> as this applies to block fops as well.
>>
>> As for the suggestion to have an opt-in to use AWUPF, you wrote above that
>> users may not know when to enable this opt-in or not.
>>
>> It seems to me that we can give the option, but clearly label that it is
>> potentially dangerous. Hopefully the $RANDOMUSER with the $CHEAPO SSD will
>> be wise and steer clear.
>>
>> If we always ignore AWUPF, I fear that lots of sound NVMe implementations
>> will be excluded from HW atomics.
> 
> I think ignoring AWUPF is a good idea, but I've also hard some folks
> not liking that.

Disabling reading AWUPF would be the best way to know that for sure :)

> 
> The reason why I prefer a mount option is because we add that to fstab
> and the kernel command line easily.  For block layer or driver options
> we'd either need a sysfs file which is always annoying to apply at boot
> time, 

Could system-udev auto enable for us via sysfs file or ioctl?

> or a module option which has the downside of applying to all
> devices.

About the mount option, I suppose that it won't do much harm - it's just 
a bit of extra work to configure.

I just fear that admins will miss enabling it or not enable it out of 
doubt and users won't see the benefit of HW atomics.



