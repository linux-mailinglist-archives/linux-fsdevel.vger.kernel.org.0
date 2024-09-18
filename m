Return-Path: <linux-fsdevel+bounces-29665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF197BF2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE1228314C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224D21C9844;
	Wed, 18 Sep 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="a725H9ZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31611BC41;
	Wed, 18 Sep 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677471; cv=fail; b=eMC8IjmCs2vT+zLgkx48ipvz58mGc48gz/ybsBHCF3i0iEC7p37jJvcFqiYrRlBg0X9TjqqHbiEPsGA/L+XpfceHkjIYbXj3MyVN5OE7JgEsalTcPVV3A6NO/E8rmibUnVFA6y6kOPieN5nnGPpe2zUO1AEajRkXONLXIS/+sBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677471; c=relaxed/simple;
	bh=eF6f88qSz4JZ3fX/YYtphYKGjLGffdD+j+VpKVIo4eA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=it+n/HtuIDsXX1ge2jrUCJyrYBDahh3uQPX5VDsAp+7X7Z+K9IUvuo+n+cnPu+QKZOe0gcreAKCYy+OYH5IOu6TiZq/f+Xh0HJK7InJoxvY+S8eGKl3p12aP2uXI0iud/Q2GXXBT7qr1xQ12ZGGO4f11YsjPkcnU4wPg0Jr2hGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=a725H9ZL; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IFqBIs022223;
	Wed, 18 Sep 2024 09:37:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=2oDHzzJ/dSMpGZ6wnWsoB7bHqAPThiQO9JVIBTksfmM=; b=
	a725H9ZLfIAsgvfSbzqYuEi3EO/Erj817EPRGLBMQU0RPqMn7lR1AGMuUKuZ0VcN
	jOLTLZX80A6ni7Ze4EZ5BjbTS8jkGa99RDS4rxERTU7kWfDWoCZnMtVTdx2OeTrl
	mnZFi7BrWyfO63jp2G4JHPYSMcgJJwg5V3nRh63bCeUUtYEsPg2FTpDKuZY0Ni2B
	+EdQ7vUCrXEnbbNNGG5r3gUQ2/Z1RMSHldYTxGXQDDSxXqHCEf4FZXOmouVrPkMV
	mXlG2lp/ws+Azr6vqEhinMTZ9mcrvhP+zhD9bvC8B/IlGJtysohGUPeNG9zhAq40
	urqsUGuHIMtThQ23zPKOLA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41qrheks1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9gIlJ2N3Vg8Ebm3bhLBAh1qdZVyTbZa0vvIcrzSQOjmR9v19hktv57rCKE0I+/Cb9m5fUgq87+nQqDDpNdE6H2udzHcvpsxLhdIvRXHt63IMKywJvWqckVzk2R3NdmJdF6EdG3Krh4bAg+vOfXxaG/2bIukQZmHFOKEIvlt0V916ZHNHSs4+p8fUH/gPQb/2ymI8jQY39r/fCRoRr7gGvjLYu1iXpsTHZcdpa7er/S5CXrMW6tQAh547XGhHT4maLHKgxulGMhSBlWgegNQlRhsa1y0+kGBt0V0oOjxojQQ5antaqHp6oL3fHPTNLdrp5Gx70PV1TsQmp31gRyRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oDHzzJ/dSMpGZ6wnWsoB7bHqAPThiQO9JVIBTksfmM=;
 b=Jox2pJ85kT84g/g7PYCK3TuLBT5udrMYddo7FwHgsLPNCqE7Rs6beLRd9qEhQhdv05xcMVaEL7HHj19EnXhwR/Zp1Cg1CkWdyvWH+RnGqX0fMDEFX9yggcEV3+orXrnmD8beIetKNgObtMEK5lVaiyfKZ7wGfKnyCvFCdX7vsph+FTeGsdzf1+3Se9S0stYEPdCfqW474DjS544/87wWzD/ouy8yEyEDvez1k+FSRzQNXjnDug7SNaAoJLmD9Zqoug/1d261FJiJczaBkcfO4c0oHqh44jbNvlF6I7N+PPZDo4Lf9kFQkOIVL8JQZcGAAkmKyDgT4GIA8Jdg98bQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA3PR15MB6194.namprd15.prod.outlook.com (2603:10b6:806:2ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Wed, 18 Sep
 2024 16:37:30 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 16:37:30 +0000
Message-ID: <8dc6511b-dc8b-4c08-a2e7-7f7351969fd1@meta.com>
Date: Wed, 18 Sep 2024 18:37:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
 <Zurfz7CNeyxGrfRr@casper.infradead.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <Zurfz7CNeyxGrfRr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::14) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA3PR15MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: d063ae82-3d26-4d3b-9124-08dcd800301b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk8zeXMwTEtHYzB0Y0tWUldrMHdKcDBPeGZLR0srSENVSUlVZjZ5dm5DdlMr?=
 =?utf-8?B?ZFBsZHpiZHI3VlVMUFpMbUlCT3B4VUU1STlxRGo2V1RnR1ppSkhBNVF2UDl4?=
 =?utf-8?B?T1RRMG13Yksyalk4T05lOUxCOG0yT29DUW1ObVU4V0FLeER3UFBKYUQweE9R?=
 =?utf-8?B?ZmlDVDNBMmQyRlAyTHVMeFc3a003bjhTQkw2K0Y5MldNUmtPL1JiYUNEWDg3?=
 =?utf-8?B?V2hER3JsMmtoUEYxTHpPa29PM0RRWmp2T2FpNDJSNmlGa3NlQ2YzUmxsc01Y?=
 =?utf-8?B?T3grb1dvYVA5RzYrc3lZRXpaVXVkVms3TmVrUUpQRUlseXdiRXJNbkY3eWtC?=
 =?utf-8?B?MStURWhnekJJN2RRbnhFZ1pnSUhreFBDcm1sekp3ank4d1p0d1p5bS9mdHdT?=
 =?utf-8?B?WlpnYUxzeDNmNzR2WmFjMERDbjkxYm9XQkNaNHdlenNKNG8vSU9USVg3MW91?=
 =?utf-8?B?Q1lGR0hXWTBkQXB1UTJ6bUdKMkN1TVdwZC95TVpObmQ2OGI1UzFTaEFLN1NG?=
 =?utf-8?B?QUlTL1IwNWVMeTd5UzlheXpPOHhDUU1DSDI1VWxabmhGVlVFdXBKSHRrZisv?=
 =?utf-8?B?bUZBUDZCcTF3dkZpTHVocG5Kdkd5WTRYZy8ySVE5MEYvc1IyZnlkRUFsWk91?=
 =?utf-8?B?clV1MFFCelhTWlcyZUdubUMxa3MrMCtOMVJrSTkxQ0thUkRpdGhxV2FZc0Ju?=
 =?utf-8?B?Sjd5VE9BeVAwSHZzMnpUQVNNSmloeWtJMWlObHlqUW55aDVweWw0YSs4OWx2?=
 =?utf-8?B?OWVHUjh0UnVuNS8reGh1ck41NnpiOGtwdzRuYS9JM1hEZDg0cnZiaXhTWVJU?=
 =?utf-8?B?dklTZ3kwZXgrSmdBU0V2bXJINUg5S1Vwb0swY2dEeFlab3FEaExPM24vT0xu?=
 =?utf-8?B?RUxkY2xFUFlreG0rZnJMbTRQMXAraXlKd01KWkNXMWhTd2xUdHY5SjNDeldF?=
 =?utf-8?B?Y1AzRGFzTWUvWWcxcmUyYWV0Y0hDaHdOMmpYYk9wd1JrMkYrUk5ndGtocUN0?=
 =?utf-8?B?SFROVWlJL3NINHo2QzZQUTN0a2lQb3BCWHF6RTJad1dlSHI3aTJIOFVmQzRq?=
 =?utf-8?B?V0ltdUZPQjdTbC9vWGYzaGdJd1lWTDlGZ1V3aExtS1E2YTRxMGlNRmN4L3Fy?=
 =?utf-8?B?N1FGVGcwRU4rUFpXLzFnekVqU1hGbEtrL1d1ckFlYzRPM1RNandhbjh0bGFC?=
 =?utf-8?B?RnRTMHNCK1FsRG5SeTN6M1E2bFJhdkx6NTUyOCtLU1VBY1FJMGtmcmhJMDJk?=
 =?utf-8?B?bktPQWsrNnFpRHFnb3RtQitWN3MrK2NIU3BhT1VPN0NYYTRKMXBRMk5XSVcy?=
 =?utf-8?B?N2JscDdoNVBZODMxK3crVzRTYUtUc3YvcDh1QVFYTjFSd3A3V0luUElJSS9W?=
 =?utf-8?B?d295b3dYM01DMjF0Tnh2dHlDRDMyZ3BuYVlJR01rK3ZvdTRVdjZYRDlpSURs?=
 =?utf-8?B?K3d2NWtVZFA5bzVDMjkzcHBkeW5LUDZRbExmYTZrMDVVVi9MK0VtT1poTmZh?=
 =?utf-8?B?WVNtYTJQYXBUanhDWXpEemNCby9PV2p0bFJsbHhsc0NvZ0N1OWlwVjNQY2Z5?=
 =?utf-8?B?cm1rbTVHaFFJUVpzR0VBcWhLQm5BRDYyK2tyYjk5UzVFZlVKK0xNUFU3T0Ri?=
 =?utf-8?B?RXBWNkJYWDNsd0x6RzVQWVJKRkRra1p6a1IyV3dlVDh0S2djZDNWcWVNNWVJ?=
 =?utf-8?B?YW5INUZsWFdVYUU2aHlycC8zdUlub3piTWtrbmhVRzByUDVyMmFrd2drNWxV?=
 =?utf-8?B?cWt4cjNmbHlPVEkzQ2Q2aHVTQTA3S0RXbzYweVRIR3BiTXdDUEdMdmFWVzlu?=
 =?utf-8?B?TmhhNkJsMGhEa1F3NDRYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC9DZzJKQW1TQ2w3cWVSaEhLdkZtanFQU29xdnN6aS8ydW15cDhJUkdhOHBO?=
 =?utf-8?B?N2w1NWlFb2Qyc1F2aWRzVnAvVHRJNTgxM3UxVkdscGtndTZCYUxDMVVqMWpB?=
 =?utf-8?B?R0F0a29hTDg3aDlTUUZqVHNvdHFpb3RkbnA0bTdXWWtzWHloR2xSeFJTNFZC?=
 =?utf-8?B?RFJXUVB2cFNpVXE1c0JuWU1lK28xMTNZbXhINHpEN2dQUHBGRms0VTAzQUto?=
 =?utf-8?B?NzA1V2l6TEU4VHp1WENISlU2ZzhMNUc3MHAwbEkvNmRKS0hXd3FncnJjeEpX?=
 =?utf-8?B?TFY5bXgwZUVQalQvWnhDU3pKQnUxM2ZYWjRFRXdxY0w3SWd4VEVja1FtTHR3?=
 =?utf-8?B?VGlKZVJtZ1JYRmJveTkxWCtYQmFsanI4Tk1BRGtQWlN2R1FQM0JaUDZlYXg2?=
 =?utf-8?B?Q3p0WURoZXAzbHVpUXl2eU54eWlTQVIvUnhtbGFsekEydjlIbmlvaGh6LzlO?=
 =?utf-8?B?SEo5M3Y4dU11RVpGQVJLUVpjdUpIK0xTeW5hZ29UaGpYdG1Vbnlxd0VaSVJZ?=
 =?utf-8?B?L3VtdGhzQ3c0OWRZQ05QK290d09HQ1Y4QTZSSGJ2ZzVpYWMzNjhIT3lXY1Jy?=
 =?utf-8?B?Q3R6RXEvcWJOcUpPTUg4WHIwUmYzYTJnUHIxdVIyRGpMTHcxZW8vZXpTM1BS?=
 =?utf-8?B?aGZmWjhRNzJVOVE0QlhVb1NPM2pQdFZDeXVjWTVTNGZmR1V0ekk2SUpGZGR4?=
 =?utf-8?B?ZEdHUmJwaFlpL2FSbjhyTE5aYnFJdC9oejIyV0duTkdpU3VQV0s3dkFERGI3?=
 =?utf-8?B?UjNCNmdramhHSXlPT1lrUnNLN2hCUWJZNzJTcjF2MDUxT3Z6SXRWaU5MazV1?=
 =?utf-8?B?THNSaVh0NDJ6aEdiVkZzQWhwQ2FjNEZwMVR5NWZmK2ZkVlNoeCt5enk2RlNy?=
 =?utf-8?B?TnpqandOempUbWRUNjluUnVCa0Q5STFrNkp2Q3ZtTWlrWWlkUU1KTTdVaVhz?=
 =?utf-8?B?OWJSeW9HZnIvZ0Rub1grVGJGeEh2SFpIeVRDM2dSNUd1a2pSSDlvYmorTHZi?=
 =?utf-8?B?dGVlR0JGWmVGQ0xSWm54NVhnR1ZoWk50WmZCS3lzWUhYRG1DZ1huTDhGVmdx?=
 =?utf-8?B?elpRRlVjNXlGZC9LQThwaEZYSXIwZUF1SWJCNUIwR1hWNkVrK1lEK1c2a3lo?=
 =?utf-8?B?OFZBQVlGVnNOcS9WNDMyRmdUYTExeXQvMkNkb3Z3TmlwcGlCUFBMR0ltWTdJ?=
 =?utf-8?B?QlAwdGRhaUNtVUpXaHJ0ejZhQklZT09xZEZnUXZURFJYMVJRcm5QWXk5bEx0?=
 =?utf-8?B?eTZTeFFPRkFBdTdvY2RxbVc2TURWZmlnc3Jxa1A5SkZXYyt4SjBIWUozSE9U?=
 =?utf-8?B?K3B1Zk9HL09wOS91dEdRd0trUXdZa2g1SE5aelBYRVVVYTZOWjlaRzdFZ1JC?=
 =?utf-8?B?ZC8xVTZjVDRMREZGK3FXTVJaSkU3NkZDeWIySVF0WEJuNTJiSVYxQ2ZSR2Ru?=
 =?utf-8?B?bXpnNnJLMGNoY0p1M0Q0S3U4UTdvdXZvWStXZ0JLeWlmR2RoV2JQNU5CK215?=
 =?utf-8?B?UVRUWk1pNkVMd3JYd3prMzhIU0RzZDNIalNyM09KdVlLeU5XSGpBbW1BcWZ3?=
 =?utf-8?B?L2VoQkhmUVpKWnlXelVTdkF0MjY4QjBXUmRTRE1zWDVxSFJtRnV2anhlSUFJ?=
 =?utf-8?B?VWkzbFRaYjg1eC9PdDVVdnBuLzF0S1ljMGZldkJrWkpXRHpWcFJySmdEb0Vt?=
 =?utf-8?B?eC9nK0tYTGppRFFXU2ppdjRWVS84Y2gyWWlnYzdzZjJuMDBpSVh2VFpYMWxa?=
 =?utf-8?B?MWErbDJXcEhGVFZ1bDhQU3lMM0s5cE1YbXRDaHhicmQzcHI1eVlRY0VhTUd5?=
 =?utf-8?B?TndwaUpmWXVadkVOSWVsd05Wc3ZwMjU0dkkvZ3JKSjdqN1ZtVEZBWVV1QUZE?=
 =?utf-8?B?ZkxDOU1GN3l0OE0rVUFLSDlpNXYrRk51UmF2bEFVUlQrcENHNFhXNUtkNlUz?=
 =?utf-8?B?S2llenpUM3FPQmNKaFV5TVZURTNISzN1UUxuRUlCNzVtZjJuQkRNOW9WeG90?=
 =?utf-8?B?dGNldTVTMVloRjR1bzROcU5uem1SRGFyM1hHMnpRZ3ZGMVVMQzczRlNZVGxo?=
 =?utf-8?B?Vm93THBGajM3ZFJQcGUzbUVOU1NYeU5IeU9GVmZvZVhvbjdGVytPTDlpS0Ru?=
 =?utf-8?Q?Jgh0=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d063ae82-3d26-4d3b-9124-08dcd800301b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:37:30.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 206Bifo4GcyxlLSNUgwEr7IYvt7scv4qILaMuV4bi9YTwI8lP73SXoLZ+xqR+5Wd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6194
X-Proofpoint-GUID: -eitMEYlV5wKpJAe1ImxVS860f1yZ-fq
X-Proofpoint-ORIG-GUID: -eitMEYlV5wKpJAe1ImxVS860f1yZ-fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01

On 9/18/24 10:12 AM, Matthew Wilcox wrote:
> On Wed, Sep 18, 2024 at 03:51:39PM +0200, Linus Torvalds wrote:
>> On Wed, 18 Sept 2024 at 15:35, Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> Oh god, that's it.
>>>
>>> there should have been an xas_reset() after calling xas_split_alloc().
>>
>> I think it is worse than that.
>>
>> Even *without* an xas_split_alloc(), I think the old code was wrong,
>> because it drops the xas lock without doing the xas_reset.
> 
> That's actually OK.  The first time around the loop, we haven't walked the
> tree, so we start from the top as you'd expect.  The only other reason to
> go around the loop again is that memory allocation failed for a node, and
> in that case we call xas_nomem() and that (effectively) calls xas_reset().
> 
> So in terms of the expected API for xa_state users, it would be consistent
> for xas_split_alloc() to call xas_reset().
> 
> You might argue that this API is too subtle, but it was intended to
> be easy to use.  The problem was that xas_split_alloc() got added much
> later and I forgot to maintain the invariant that makes it work as well
> as be easy to use.
> 

Ok, missing xas_reset() makes a ton of sense as the root cause, and it
also explains why tmpfs hasn't seen the problem.

We'll start validating 6.11 and make noise if the large folios cause
problems again.  Thanks everyone!

-chris


