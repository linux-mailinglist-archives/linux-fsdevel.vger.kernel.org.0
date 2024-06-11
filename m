Return-Path: <linux-fsdevel+bounces-21410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2405903938
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702A3283C94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBAD178CF1;
	Tue, 11 Jun 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="EE5G2RRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F014F9CD;
	Tue, 11 Jun 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102885; cv=fail; b=YG+vzhgIEpR54+48Ygix9WZFaMYjY7C1PlujFeicKEPXvlh4Nynis6j7FhG0qOa63e7d7f3WsPMI9BIb63umQPI/X9NUPMcZsSG4M7hu2aaZmdRdlgGF1A8ECS7gkCbWVthKgvT00kW2CFvawSZ5k29MqXAdtaUt2S0iyvPdxwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102885; c=relaxed/simple;
	bh=l3qSo/BaZNxTXaW7TA5D5WKS2LykfuSYA3n4XDai2wQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nLyUrRzdARLAsUawxeM3O7xRbzrOQ6zplsqyHBfUOGaQBngys7ZgT/FTwKvMCbWRC2zuOnBWNOr1RitUT4tGIwmMd1+ibnH3aLXkAOavuyZCgA/7Nyx18j+qF4ZksQ/h+ziSQvYM28iAMKSO5h0SeiwSMYMgqwWrxOuavcnhstw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=EE5G2RRG; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45B4bYn7016963;
	Tue, 11 Jun 2024 10:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps0720;
 bh=Uzf1a1jqcDalpp33gDcYF2pLVBqq13HDlP7Jdv4rjNM=;
 b=EE5G2RRGTDxjLtaHm7fuwZAig+/DM5ythK7WR5Fk1imLxxxwnejrNb3oGuE3tvnkm17A
 x+rRhfVPohw5NP4YeqI+3gFOi4+ezGn8lJpf+snuCLnp487AxVRbpTdQ+w5Jp3qRqczX
 pNtBtHAKDvqyGyKPqxGheF1FVkBXQklu5jLAmT/fhYJPFkV5UtmvpYfa2HkWcPu7BV13
 wRk6B9z0LkEKos0iSGBytREO3M2hw4Y4SA0cZ2MdsxjMggJ6Nk3E38iOKLotqn70omg9
 VTPpLJ/AyMbALdXbEmphuoh23MJV+4GuifrRcGt/3oRus4pV9hrKbZFusvT97EZFwN3C Dg== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ypdjvbhqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 10:47:39 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 6A5018059D8;
	Tue, 11 Jun 2024 10:47:37 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Jun 2024 22:47:33 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Jun 2024 22:47:33 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 10 Jun 2024 22:47:33 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Jun 2024 22:47:32 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdI4XDYwHCx2qrrCu5ZMsbqtycUq34+pEMcFZSlFtQsaFLzcoarytv7mCpwBJDZf46OcyuwbjFjI7VEkdclCwI2thp9uojYrbxPXrSRnL8RE/qLhWNNXHJpYDw943LV8ouQg2QsBXNxUe30pzxWz97ORdEoT6QBAJjwYI1hG64J7P64/q31NSSqqwYUUON4GwgDuP9PNdUU+7I6Da/Ocf4EpmmoOcf/WiwZ6RYNl1Azuw3HDPyvnW2IBnx1Xjz7oDPQlt8QuoWamPs6hQqxG2T3OdIzWyKZjwRi5WkZMFezJHURJuL4odj6EP/xAwYIYSIox/Gxxlx/MzoqtKeueGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uzf1a1jqcDalpp33gDcYF2pLVBqq13HDlP7Jdv4rjNM=;
 b=bh2OL7ZtLf9is9oEsvTUdtPmXoYgM65cHGt6acmssd2DwWl7F2g94fR4evDs8Ql6z+Fcf4zgPnOu2lNY7A5KEGQ3y4VAwKrVpBGwC3ouWaY6sSis107RJf07xasYYHTtkVYda/SA3va8fA5zy/E1kX1vOtWAYCKbjuozsQxpiMPJZ6uhuRNxAaqcmtnx/0E9aK9XbEvw8usdpNq8WPXt8JFcAGzuMJiNShsudijKuR1mRE5zcbcf36NNArfoVaWHRfBgiI/K01KOeSY5v2zLalSDQ83/0jPVG7ndy1Qoz8yMctxPDDrjYoWalVBl//JIdbRL8nEA9/3pzeBSe0QFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB1697.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::22)
 by MN0PR84MB3913.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 10:47:31 +0000
Received: from SJ0PR84MB1697.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5041:5fe4:74c2:c9af]) by SJ0PR84MB1697.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5041:5fe4:74c2:c9af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 10:47:31 +0000
Message-ID: <8e23be47-e542-4bb8-8da7-da7801c98e42@hpe.com>
Date: Tue, 11 Jun 2024 17:47:12 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] filemap: Convert generic_perform_write() to support
 large folios
To: Christoph Hellwig <hch@lst.de>,
        Trond Myklebust
	<trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "Matthew
 Wilcox" <willy@infradead.org>
CC: <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20240527163616.1135968-1-hch@lst.de>
 <20240527163616.1135968-2-hch@lst.de>
Content-Language: en-US
From: Shaun Tancheff <shaun.tancheff@hpe.com>
In-Reply-To: <20240527163616.1135968-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To SJ0PR84MB1697.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:a03:430::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR84MB1697:EE_|MN0PR84MB3913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a56e543-cc8f-4817-b0f8-08dc8a03e4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnNHREFnYks1bzlGVG1aRWJUZ000QjJ4VVAvV05IZnY1d2hXT1VBTU1nZmJM?=
 =?utf-8?B?UW1GQ1RmNTZhVGhBRVdvcjNCd2dkRGlMaFhNcGxPM3lGMm92d0JlcUttcWZz?=
 =?utf-8?B?byt6K3Vzd0VzbWlFa0ZqWld0Z0FOM0NUSHdYUFZKcnlVZmdSNStMSmowQk1z?=
 =?utf-8?B?cDNqV3loWTdiWEpBd2JiK2N2LzRrSk1jbllFSEtJU0VLb0FseTNFU3hoeUIx?=
 =?utf-8?B?UTMzTHlwVVNIUmZOcElzN3VYam1KcFNuL0lXWWFQekh4UkluRHBvdlZaQktF?=
 =?utf-8?B?NWRvNWFZQzVlcWo4NElDUHNoTlUrcGxaWlB4ZDU0a09RL3dVQUlTb3I1VHRF?=
 =?utf-8?B?MklSMVdCRUNSREtCeWxwVWV3T2VPNklCTlhnVnN1NXc3Y1N6ajVyWG80aG5V?=
 =?utf-8?B?S0dxbGRiUXJIK1FqM2c4WU5XeFpSRXdNbXZ4dTY0V0Z5NitvUkxMbEVyQmhi?=
 =?utf-8?B?WWEwVE5WSEhTZUZmMjg4b1VIYWQvcUxTSFJ5YXQ1Rmp1YmVzRWFDVTdwcjAr?=
 =?utf-8?B?ejhkenREZldBcXJHS2tOWlFzSW1qalorMElCYWZHc3M5TjFOUCtXQWtSeitS?=
 =?utf-8?B?TWlDRUNLb21INU56N01RaUQ4ZHdOVGVsT1R3ems3bnV4a0d2ZDlqZzZsQ2d3?=
 =?utf-8?B?THpGZlRUM0FnOEtUYThyMDNpZkhDdzJTWVJjS3RYWjdHaWUxcWNxYmVNbVdU?=
 =?utf-8?B?WTRiMlF6S2hDS2NOVElEdkZ1VWMrdFdNWE5Bb3hhWXdXbUc2WEZtV2V6c1Mw?=
 =?utf-8?B?K1kxNGlYL05sTzhiZHBndHhmRzlIZ1o5eFdFNjlZV1puUThVbFprdW1xQlJ5?=
 =?utf-8?B?VjIwbU9acUh4cTJlRnpZVmlpcTdBRUFPUzZhVk9PY2JkaFhiZVF0bllVL2du?=
 =?utf-8?B?MC8rTE1QWThIL0VtTWRBTWtwSmRORmFjSFNodjVxVDVzVm1pQUdqTTViZWZH?=
 =?utf-8?B?VXFtOXpTVE44MjlUUjJlRHRIVEliTkZmVzM1WmFFTVRUTklUb3FzQUR2THBz?=
 =?utf-8?B?VEw2Zkc5SVNmZENuZjZLZEhNK1RtZStZeTBHZVFVNnR4a1JsZTMwa0NGdU5m?=
 =?utf-8?B?M0czblowTXR2MVA1VHJiUktnVUZjZXJEYUZyUEZCNVU3eWs3UDdtc3pBZml5?=
 =?utf-8?B?OWNZWWJaQXY3b24rTG5MbXMxNEJqUjI2UFRmb1BBZHlTVHZZcFk3b3J4Q0xr?=
 =?utf-8?B?UDdoVlRubVNXR2FrSEdoRGFJcUZSc2w5TWFjWVJyZVRYM3FnUVk3MWtXMFJH?=
 =?utf-8?B?bWJsTDVhSGVldjE5NjcwVWxQVDZFTzhka0VmRGNMZThRU2grczdBWFBYdHgv?=
 =?utf-8?B?bmozNHczeW94T3Z0M3c4OWNIRXFzVmlCRnBJa1NseWg3cTRtbWxjZnNhcGVY?=
 =?utf-8?B?cWFUOGRxS2FBNjRKS3JHT0RURW83VlhRT1NId0ZPWmVEc0RqeGJNeDQrdm1i?=
 =?utf-8?B?UVA4UHZmRlRHWWd0MnB4enRUVEMzOU1rcUdWUUhQRHQrM3djQTJPTkFCVnYx?=
 =?utf-8?B?dWFidlF5cmtiMXlkR0tHWW0wcVM4bGNqRlFLb09lVW5PeFIwLzcyNVFydlln?=
 =?utf-8?B?SEp6Z1Y4K1dLd1hURjE1M0tJYmZBYU5zQUl4T0Rhb1RORlZ4YThxck1wNjR4?=
 =?utf-8?B?aUlIV2lIdzlCTlMrOUg4S1FPN216dm1FZkVDeDlTcmcxYzFFQ0xQU0VEV0p3?=
 =?utf-8?B?VlBzaTcxckUrY0x4Umkyb3lBR2VxcnBjMVp4TmNab3hRSExiby9aZkNxWklM?=
 =?utf-8?B?U2V4QmRmVnhqTDVRSEJTTEF4dkdyaDlOL2x6b0JFQ0NqQ09QWHpvVlVzMFdI?=
 =?utf-8?Q?r6OCJzbrZ1zBH3nzWIgRCbj6CgaVoBbCRL5O8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB1697.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0srZ0Zibk41OVViNkthNi9iMW9vQS84MEpXSmtQb3Z1NTVhWm1KS0h1bUNx?=
 =?utf-8?B?MnA0YThWYmQwSDlkV09JR1NsL1FMbGcrcmZrQTVGY205NWhXRWdjaU15em9T?=
 =?utf-8?B?c1YwSjVNZnRCZ2s3aTJaalByRWQ4NGZWSVVTVFBwYnRzR2oyMEg1dHo1aXVZ?=
 =?utf-8?B?RUwwTHc0WjViT09Bck14ZDBzdHNrSVNqaXF2bGpWL2dpRGVteTRrWVhYN095?=
 =?utf-8?B?Q1hxMndVOXV4emxIaExseERLaGtJNWJBM2NUc2k5ZDhVYVZJQ3pGYVRCTUZt?=
 =?utf-8?B?cjNQaldXdStRWS90eXBnOTBmdVlDbmd3djI5RER6ZCs0V05ZZ2pFOTFrSVBZ?=
 =?utf-8?B?eFZyUFQzWGU2ZkcrZmZGM2w2WXJnWVBEY2Z2SFg5K3p5TkJMZlZhbUdiZytV?=
 =?utf-8?B?NFgvenQ4RURDM0N2OC94K3hFdVRCM0RaeUUwWjFBblFxN1hQZC9sY3c5RTcz?=
 =?utf-8?B?NnhIci9HcGh6Ti83N0hEM3J2VWFiK3VQWnJocDJKbU1hWmw0TVd5L0pFQUM4?=
 =?utf-8?B?c1FWbDg3TDk0a09INUhrc0ltY2ZHRU5GdlJzRUxNRHlBc3ByejBJazRzKzZG?=
 =?utf-8?B?Nk9mY0JqWXhIUUwwd3hodGxmYisxS1hrenRQaFRHb3ZtZ1QyclFUMEc1SXdD?=
 =?utf-8?B?YVpQUU5NQmk0MEllMG1YeTZXdzVpMjM2QzZzNXFCOU55Z2JIR1ozZXovTUNn?=
 =?utf-8?B?TTRIc3dBREt6K1JCdWRYRFRtSk5GQUdkSlJNRjdXbDB6Y2hoNEF1WlN2Q1ZE?=
 =?utf-8?B?NW5CcGowYjMrbWE2Slh3YkMxb1FaZFQwaTI4VndwOWpnSTdwelZQdkN3ME5W?=
 =?utf-8?B?YjJsTFk5elpOS3ZFeUZKc0RMWU9QdlpLc085dG1aVHhuN1RYL2swR2s4NjZD?=
 =?utf-8?B?R3NIKzNKc1ZRUU1BM3pNWEkyYWozKzA2N0xPQVB5RzdEUkJOVUZDQTJ4WHVq?=
 =?utf-8?B?cDg0UWZmVWV3SVFiZUwraDR3MVNmYjVRSWhqa2dhRkVIZEtiNTAvTjZvZDVP?=
 =?utf-8?B?WGN4UmtiQnJhcnlqalNvS293NXI3Qld3Um5HRTJBeURzVlhtOXAwODFjVHRD?=
 =?utf-8?B?M09uZmhhNnhKVFZNVEw5WVFwbURrdXZtSHRSREk5cW95K0NtVmtFRnYyb28r?=
 =?utf-8?B?L1FFK2IrR0gxOHgzMWthVHJRQ2tnVm1pQnBWZ3B5SzF4QUVwRmZkdDZIVlJR?=
 =?utf-8?B?TUttQVVRRGE5dDloYUIyS1phWVh6azY2cGtBbnRybU1qRTdFckpwc00wR1BT?=
 =?utf-8?B?OVBCb0lscDVXYnlIdy9BSWNuY0s5T0hKY21sNkFlNzBVY05DaHZ2VHJuSnFS?=
 =?utf-8?B?dnNFVno5QVJOcUNHc2tWdERHM0tuRzY3WkFxeFRncXR3aFArWFlmU1BTK0VC?=
 =?utf-8?B?V0hjQ2pqRGlkYThBcW1pNU1PaHVpcXpVbXRnMVVGMk1xYnNHWDYxQi9QWnRm?=
 =?utf-8?B?YUQ5UEpnZ0FwNmIyeHhVRXdnMEFTTlpHUTN3TDdWdTh1VUlMZWljTk9lR21D?=
 =?utf-8?B?ZksrMHh6eFpKbXp0TUNxQVBHVnB1bGNPSkJ6bUk3Q3FZenJYQlNQV05sbVVy?=
 =?utf-8?B?ZkZudEFIeDJXeTM0eTNaSEhFTzRyTG1uU3BDQ1E4QjBVR0YyRXQvUUZleVVl?=
 =?utf-8?B?bEM3QzRJRDR5YjMyZkczTFpJUGpMdysxcm5mNm1KMTB0eW5sWWh2U1VCbHE0?=
 =?utf-8?B?OGJLSE5TNnNMUS9IMTl0amFSbjROV1Z6SUp1aWJ1R0Q2WW5obE15ZmR6b2ZM?=
 =?utf-8?B?emNZVUZ5Wi9uMHl1UHJKSWZUeFN2M1VvWlZuOWltMEZNTUYycWNKUU1NK2s5?=
 =?utf-8?B?N0NlcGUxb2tpMXExL3FHRzJmVDdld3Rqb25yT2dlVWNpR2VGc2NITFE2dnZu?=
 =?utf-8?B?UG40a1pXUVdBZkhJd3BQaGkxNFZ4MzlYb0M1c0NKdTJ5Tm5iYWFFNTNmWHl6?=
 =?utf-8?B?QUZGaUFWbTdhbWhleTFlK1oxWEJDRVlsVnZXNkxqTnBmeDVtbGJlczBuWWYx?=
 =?utf-8?B?bU51QlNPMnQ1Y05VTVFTK3FveTRpYkRabW91N1hnclliUDRpWk1LNTZwTmR0?=
 =?utf-8?B?b3ZHanZJYjVKT1dXSHRzOUhSRDUwRjJBR0lXT2RoZEkydklOZno0bjF4MENR?=
 =?utf-8?Q?SADH/ybgJQ+PwiYqAgyF5oLQE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a56e543-cc8f-4817-b0f8-08dc8a03e4e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB1697.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 10:47:31.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSGKXHG6dvAqNB8CdR5msAvMaJHMM7xkeS7Tv7nyYSibmrnQSVuEUIVG/u0xieNBvByfr12XDTucAbNHBH5fkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3913
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: yPFUXbeTuFJmA-wDLoEAjseP2FNsC0-r
X-Proofpoint-GUID: yPFUXbeTuFJmA-wDLoEAjseP2FNsC0-r
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406110081

On 5/27/24 23:36, Christoph Hellwig wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Modelled after the loop in iomap_write_iter(), copy larger chunks from
> userspace if the filesystem has created large folios.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: use mapping_max_folio_size to keep supporting file systems that do
>   not support large folios]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   mm/filemap.c | 40 +++++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 382c3d06bfb10c..860728e26ccf32 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3981,21 +3981,24 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>   	loff_t pos = iocb->ki_pos;
>   	struct address_space *mapping = file->f_mapping;
>   	const struct address_space_operations *a_ops = mapping->a_ops;
> +	size_t chunk = mapping_max_folio_size(mapping);

Better to default chunk to PAGE_SIZE for backward compat
+       size_t chunk = PAGE_SIZE;

>   	long status = 0;
>   	ssize_t written = 0;
>   

Have fs opt in to large folio support:

+       if (mapping_large_folio_support(mapping))
+               chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;

>   	do {
>   		struct page *page;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> +		struct folio *folio;
> +		size_t offset;		/* Offset into folio */
> +		size_t bytes;		/* Bytes to write to folio */
>   		size_t copied;		/* Bytes copied from user */
>   		void *fsdata = NULL;
>   
> -		offset = (pos & (PAGE_SIZE - 1));
> -		bytes = min_t(unsigned long, PAGE_SIZE - offset,
> -						iov_iter_count(i));
> +		bytes = iov_iter_count(i);
> +retry:
> +		offset = pos & (chunk - 1);
> +		bytes = min(chunk - offset, bytes);
> +		balance_dirty_pages_ratelimited(mapping);
>   
> -again:
>   		/*
>   		 * Bring in the user page that we will copy from _first_.
>   		 * Otherwise there's a nasty deadlock on copying from the
> @@ -4017,11 +4020,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>   		if (unlikely(status < 0))
>   			break;
>   
> +		folio = page_folio(page);
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
> +
>   		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);
>   
> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> -		flush_dcache_page(page);
> +		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> +		flush_dcache_folio(folio);
>   
>   		status = a_ops->write_end(file, mapping, pos, bytes, copied,
>   						page, fsdata);
> @@ -4039,14 +4047,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>   			 * halfway through, might be a race with munmap,
>   			 * might be severe memory pressure.
>   			 */
> -			if (copied)
> +			if (chunk > PAGE_SIZE)
> +				chunk /= 2;
> +			if (copied) {
>   				bytes = copied;
> -			goto again;
> +				goto retry;
> +			}
> +		} else {
> +			pos += status;
> +			written += status;
>   		}
> -		pos += status;
> -		written += status;
> -
> -		balance_dirty_pages_ratelimited(mapping);
>   	} while (iov_iter_count(i));
>   
>   	if (!written)

Tested with Lustre with large folios and kernel 6.6 with this patch (and suggested changes).

Tested-by: Shaun Tancheff <shaun.tancheff@hpe.com>


