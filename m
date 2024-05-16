Return-Path: <linux-fsdevel+bounces-19592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2B8C7990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93BC1F21169
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2CE14D433;
	Thu, 16 May 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fZvBGLBt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="syqjxGbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2D14884E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873652; cv=fail; b=iuqmjxQnysJmv0bW/j8nqdjn76vgObrf+C+KSWHXXuQCXuUwLnEYjuMuWtbYruWVZD5miHUvoFdtVGfLkyb3TJNxivNUwxUwemMzsFKZj2kqX5s3qnmscHbTAD0hOomTmpmRuiM1o6t65CHsFs8dhlM2h1MmBkmHawJE3H33lME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873652; c=relaxed/simple;
	bh=limdHSijw3gdx7ipaz/MTXuywCXb8xd8NvXL/WiBTNc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UgxK4kkXtAE2j9mv1rIjdNOEvw7zjyrKPD1d3dOSrC9ND/ezNWQwu/BMbj5V0WqJQrbEap7aDAAi8ghSrzeTMHP3hrC/82xUzinKuV7D2ak+kp3mx2MYIiPM6lbndPgoHsvboDjzXV/cJbwoG0MHfygAV7teE0OPQSQUidXoLww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fZvBGLBt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=syqjxGbB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GF3Gis016340;
	Thu, 16 May 2024 15:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ds+Qw677M67Fq36x+ye9mTA9pFOl2qZlRc+/ttLuXb4=;
 b=fZvBGLBtdhxe2WEB+4l9XIypGKh+h32CHZCsq13uDQhB6bwcmVrGn3K9taoLf0mQT+0U
 s3HFkebqFzbtDuAz4KTvgFmPmjho8xxH1AGAFcQAsPsvhBnTcAQAkMUBmGjOVoz9Q7cH
 rrh09WKhSYdvwmF7Uytdf+F2CAoIfe3QjB060iz8cvJ4lZRyMDrtQZKHx8Zj5Hm+yJ95
 MuE0bOyhZEhw1IQJTJoU3mcANVkWWzPIEcdnKBjHhEu7hotqDp4u1p1ibCvZO0ShHyL2
 W8OjTSPMjZ019euqLlvnEUPPh9Whz3g6xcQd/m11C4w+YTLmZ0s59RPRSAdEbeJaM6Pn GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4ffqrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 15:33:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GEam1h018048;
	Thu, 16 May 2024 15:33:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4gm72d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 15:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb/620GDOgWBt/WpP6l+W0VUd7MfHw8m1EkUynhFxsl5/yfiZJC7Gspue1Tbv1cykRSCFZpLF1oRuqecV3SvQ3cfEz4pNFc1qFk3Y0vGJaJTg4ndwJiyOJslg1zf9+Ul1g0DiD4LIZPCBrn4x+2uHI1y1Z6cvPN1mBD/dk03ixqlk14EGgzoRAEjsOjKndp/Az2y7YYdfdmI4JoVCuWsLq07qpm2m0mpxzLFRgwozcYWsqiI6WzbFkuxWLWUTN3CMW+1bg59PE95EnyAYoH7xjXBnaYFL/X6H8K2csNNGto4Txo42EZTg9p3W77bg67YfOwDp+U/aJN0rFD1SK8Rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds+Qw677M67Fq36x+ye9mTA9pFOl2qZlRc+/ttLuXb4=;
 b=gPgXc8qNJ5Oodmk4iiaNxg0lfE1kR/TELfWAIeU18fSHALKvLt2uwUwpqCY/1cUmfiDhawSf5kc89X12vdhVqyq3bsmBqWVtlJCcc/CaC/bVlC88HL6Og6z3rgZMJhjOdBjgTQPMLMYALbEooTk8swUaTe19jkQ0/Abu3A/3rTQMGclJqZwwxKaTwTkS3tVF20r9r4WmyzVM//SVyow8rmWaImwIz8ChId3H62S2TZ6e5OHzMcO2KUeqwK1+2+7loD3P86bV97cPemWDNgO7MYxKMyYnjMt34js/IZrLWEDPJ76EjK5Od9qJzdXJd9tW2ACBVvz+OyK8IGQB3dA3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds+Qw677M67Fq36x+ye9mTA9pFOl2qZlRc+/ttLuXb4=;
 b=syqjxGbBltymzHaNMj54loLB4IaQ2kjxpPVDhCRS59ZCEpDs782Oq7+/uYjmhWw2d+4Ie/e4xtEwFsePBpox87fuIaIykOxiXR2uU8Zhtp9iGM6ClGYurX2mvBMaHGC+igcL8Dz1WAqBBVZK65p0fvThy4Ag6vS/VdgQ5TeijGc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6610.namprd10.prod.outlook.com (2603:10b6:930:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 15:33:53 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 15:33:50 +0000
Message-ID: <2e46a67e-9823-4681-88ab-fccce39174ff@oracle.com>
Date: Thu, 16 May 2024 08:33:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: page-flags.rst
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <ZkOu4yXP-sGGtwc4@casper.infradead.org>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZkOu4yXP-sGGtwc4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bf5cf3-79df-49cd-0278-08dc75bd959d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YmhGdmJidEJHNDVad2xOVjJSZXJqRWFMMy9WcE1JZVpNTmpFOWFjRGlwVUNk?=
 =?utf-8?B?NWIvY2xjM2k5cjJIL294dWcvV3hOQXd0aHZFWHNjSlorYU5ZOFY1Q0tIeXdR?=
 =?utf-8?B?RDhVcXc1RDRIMi91NW5DcC8vbHpoRzlZQ2o2VEZUUHhUcWlCY2ZGTGtKWW93?=
 =?utf-8?B?MFpSalFkTVI3a1QwSktVcW5BZEdmQzRNWUdaNUtHRytnTXE0TDdMc1BGOTlw?=
 =?utf-8?B?UkdiNjFBUzVwT2k2NTM1RWIzSGsrc3owRkJ6aDJqRWVkZnBtS2JxMUhaMEZ5?=
 =?utf-8?B?RzArRm5rRS9pT3hWN3RWL2hoU1lTai81bGxTcUd5QzlBd1NrN2E2d2Z1ZmlR?=
 =?utf-8?B?QzBXRko2cFBoUWFFcmNCQ1hBSDRzYWFVUXlNdkQ0NXorWlF4bmdTVmdvdXZN?=
 =?utf-8?B?WGo3V2FyYmtNeSs0akhLVlBQaCtrV3NmZEI2dkpNZFhBQkdZM1pqS1RHVXl3?=
 =?utf-8?B?OU9pV1huNis5V0dSMEhZMGhiZXpPVzhnekRZeUdvU0JRaUpsVUFpZDVBKzB1?=
 =?utf-8?B?S2UxN0pjVHdQdThRSUhNMy95RWNhUEtVSHlJQmhtWFRRQXdidExtMnhGUFJX?=
 =?utf-8?B?THRBT1hHRjIyZVJuS2l3Q2Zkc043S0w4U2F2dVRrODRBYThRcTZSQ3pQVTNQ?=
 =?utf-8?B?cGs1UFFoUGMrdnp0YWZOY0NDNFU5Ym9QQ3FmY2xVc1BWZWdhb2JTcU1JdGtq?=
 =?utf-8?B?a0s1SUtnV2Y1em1QVkd4RjlkZ1hTVitUK0toTEZzZnpZVldwQk9TbWp4NFlJ?=
 =?utf-8?B?WUZFeWVUdTlLZ1VTVjV5OFRtTzNqOEtJWW4zNER1aHJPcmZzV1lOUThzOE5n?=
 =?utf-8?B?SG00cVpYdmY5RUM5clB4ZExyVkx0OWdWK0lCajIyT3pUNGpoaXRMdnRabVNI?=
 =?utf-8?B?dkhTZHIrQi9KMmsvZTBuaUhyeVF6aWhDd3NsejB0MUNVV3dUaDhkRmx2ODg2?=
 =?utf-8?B?MDd3Y3p1d2FWWEZmVjBsdENxbzkrSm14UUgwWmZMbWRDSWc4allnczhKNUN4?=
 =?utf-8?B?TjNvYzlNSytlYW1mWEtSTm85dTZoSkJINzJYTGNCbVhSbUlscllyMHVseHpi?=
 =?utf-8?B?Umd2dWdDK21reGJLTWxZRkJ5cHljaCtXTmhKRjhOaDIxVHZFMzZlZFBxdUlX?=
 =?utf-8?B?N2tyM3JsQm5JV01GVnFEeVNXU3BvWGZOLzNhRkxjVmE5eXBYYzhhRUZtWEcz?=
 =?utf-8?B?SjVjSDZtZU5iZlg4NnljbzljTHU3YytxZzBYcWtDeGsyeUJXSVFleXZ2clEy?=
 =?utf-8?B?OUpNemk0VC9RNFV3aGlRV1hFM3NLTG5VaSttTU5qaWxSQisvRXkxdzFyQkFU?=
 =?utf-8?B?K0d3MVBnRTBoK0s5dDVkK1dOdnkzRkpLNnZuY3BtcExsWk5tT1hUVldXb3lP?=
 =?utf-8?B?ZkViVDNXZG1GZ1FSRkRPSUlnYW40NzVHaUlZaHhVajdZa1hVekFwRXFjVG1H?=
 =?utf-8?B?dDN3SnVaMktoem5zSWRISEhOOGlUelZvMVF0ei9sdi83MkVtcmZhTDVYc1N5?=
 =?utf-8?B?Q2VpbWxRMk5SMkEvQXE1WTN1Q2lMOCtvRlBIcGpncW1nOFN4SmhwQXNnTFJw?=
 =?utf-8?B?R3hBK1Zjd29NV0d2REpXQUl2TXJDY0E2WmU2U1Q3dnR2aUVNUmJWcjUra2xC?=
 =?utf-8?B?cHRLOWZsemFxTVBtUHU0Mk1ISTQ5L3gyait1Y3FBWitFNVN1UVBPUTFWb0Vj?=
 =?utf-8?B?d0cwbzFiUzRGTDBqMVdUclhmRjltRTl2cllGWXd6dk5wNnhqQVFMbUZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXNvbitjRTJDeGxhdEhOMWJscGxnZ3hWbmdielc0Q0J0TG1LUk5hMXo3ZXN5?=
 =?utf-8?B?QU1HQnZSeU1vUEprWEpLZytHRUlVa1lpcENtL3BlWXhiZFFPaXJQeGhIUlRa?=
 =?utf-8?B?QWo0SW5GNGw3WHVDMW1vT0lOUWgxNjB6K0ZSSlhNMC9jajlxbTVSZ1htRVkr?=
 =?utf-8?B?WGRFUWdrU0Y2UGkrTmZUU2dwWFQ0WDVvSVFNbFZna3J0NGViUzZaK2lpaEQw?=
 =?utf-8?B?TnhxWUp1dWtoTDRyU2RQaUIvRWE3QkdSdUVkZzhlREE3Qkd3blUxUTJUNkRE?=
 =?utf-8?B?YmFEb2ZPVEF4MlZiUlN3dGY2UW9lR0pUeDFIejIrVFEyZWxsK2dCMWt0dEZz?=
 =?utf-8?B?YlY3dWIxYitVTTNUVzdjQVU5SWVlK3JtZER4T1d5cmlEeFU1RjhhbkZaY2lV?=
 =?utf-8?B?ZHpZZ21MUDgxTzh5UVZoNmEzYVYxME8waGlyZ3B4SmN0elhtTkM1UzRuY1ZS?=
 =?utf-8?B?M0Q1ZlhId3BoTFNFVlJNejNGQTFhSmJ5Ri9kZStjWTdjUEltYWhhcjlrOCta?=
 =?utf-8?B?M1Q2bTdJdUVMZ1hiK1I5OGZCMFIxZU55M2xYaGlxdzk2Zk15VTBxZFpYU3Jm?=
 =?utf-8?B?Rm81azVlcW1oRUxVV09yMzc2VlV0ak5rY0xkTi9LMmpvTXFZWlNxZThyVFNN?=
 =?utf-8?B?NlBWQzVWdWg4clh0M3A4Z1Q1dFV0cTNnWUdQVStMRG1HL1ZVRUZDQ2lyQzVq?=
 =?utf-8?B?OHU4SlhOYzVmUXAzZXA4TmxBMUh6OUNBdHpqZ1BHejhoa3VUdHkxK3pHZUJ0?=
 =?utf-8?B?cGpjT09MWTdGRG5laExPV2duZWZnMGxUeHZhMmxyOGk0SjRUTVlEcWFqQXFh?=
 =?utf-8?B?T2VnS1pCYk5WVUovYmx3U2xOcUY5ZFNlbDZyVktDSkdVcnpMdUM4QVd6YVJZ?=
 =?utf-8?B?Y1M2UDhsRnNKeXJhOE5iN0JJVzYydUdSZU9HbWE0Zy9aZmF6RlRuR0c5NWNZ?=
 =?utf-8?B?TDFOWmpxemNVTFN4MXNjeUVqcFFmdzJ3OGM5dnR2a3JRRzZlMDRrd0Z0QVpP?=
 =?utf-8?B?QVZVaGNiR29VdFJXZTBMdjU2Mlk3bC9iYlBJM1N2RkZlUjNsaHYrcktGWVhy?=
 =?utf-8?B?cDFHRFRaQ253bG1MaGwvZ1FYc3oxZHFpYStPUWs5MWxzS0lKNTJ4Z2hzT1Av?=
 =?utf-8?B?bzhMODFjTE42VU41TThFNWp5a29YTlQrUXUxekNLb1VYTUI0bEtnL2t1emJz?=
 =?utf-8?B?emtpcTU2dG1FV3RGSXRJWm9rTzlhQTAyYnYrQ0RQRWxCY0NEMlpVK3JSUmxS?=
 =?utf-8?B?Yk1hUDhSZGZUblVsZm1ibHVsVEQxRDk4MkNGUU50ZVh1UGZrYitob3doSWsy?=
 =?utf-8?B?MUZzc2d3MUpZM0xjd29DWldGSDFvZlVxcmJ1R0dEYXBGMW9KbExSR3ByY1RF?=
 =?utf-8?B?NFV4WS9sV2NVYWttalN6QUhjZk05K1NGell2ekYxUzhYZEFaUzFPbzZXRFJS?=
 =?utf-8?B?Y0VCTktWSUIxUFRsL3Z0RzdjajdETFBmZ3FWbytETndmQjk1bnFXdEU3RWUw?=
 =?utf-8?B?VzNhdGx4ZHFrQ3B1T2VBYjJNUHZSTHNTN1BITWlKTkpwWHRTVUZGNlRLd3la?=
 =?utf-8?B?SWxZcnlHdWxDOEROcWM4Wjc4MFpGMDRXRFA0NGZPL1lpMm9obXY0YlNlalJz?=
 =?utf-8?B?dEs5b1JOYU1oLzNJN20wSGMxUEN0c1NaVTFoRHB5OHpqMitJb290SDVhL2Q1?=
 =?utf-8?B?cDBHNXBGN09pSFc0YzQ4ZjdUdXR2K1BXMTJCdGpBRnc1V2w3dHY4d0YwdnlY?=
 =?utf-8?B?c0lpcGcwZ21QZU91T3MwTGhkZHZ0Ym9lWGxrRGpBdjY4cFAxb25mazBWN0h6?=
 =?utf-8?B?a3UwZW9mK3pEV3lXcXRJQ1MrTzFFOG8zS3piNlpMVFUwVEZmSmR0MkNOV2Ux?=
 =?utf-8?B?L0tBd3lSSDAwaUtUUmlWNXBRRmhSamNKYVBIMUMzYjhuNmJkc2paVFZESFdK?=
 =?utf-8?B?NHNPeEgwWG44eWhLZk5KQkxKdy8wMzdheUtqWnNyR3FWbTFpUUZWMkg2alFL?=
 =?utf-8?B?TkJjZmhhOExVVFYrVmh0N2pPY0MrYUtSTnhKelpPbTQvUnJ3YlMwUGhsR2FL?=
 =?utf-8?B?NksyRWx6MmNzZFpxOWFWRWNva24zMjhMSEt4Nm9lb2tTUFR5Y0UvQ0g0M25p?=
 =?utf-8?B?N3dJUllzYnJnRlRnWWRQRHBwQ25TN3NHU1JpUDlNclRVak9KL3c4bzIxZW1F?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0ewsTwaurYPYIl4K7vfxPb4eAFEEpvYlNPT5CnLiEgTAAau4lBjkvGLI42bGk7fSWib1qhqbkwRYhsPubU7AcTXc3phvbInNsGLVhMrsHXbYDHpCsF7FtxJj6Rx+XIAm1h7sO7hUywx7nuaSgVpjKnUR/FTEMjAmtLa5mxnr19cDVXdR2nznyL8ctR5mzwXSi0gACjbRPEVRLAFrhP+Jl41u6G5/LujX2WP03vX9V7DL3+TaiiD/QfDlTIE31JWYJD5D4zvQroYAVvwbuc1UyuY8K3pV1OWTG/2sgZ1nAioRnc8erQ6zO8MHnj1ZhuTr6FQDNWmDc5EDyTy6grj0j4TxAD7OiMDmOWVyQFlxzPHTVZAor5JtklDZ4+q6rQzR7IylbzsSHRJ0CiY+HyRE7JccsRlgnFDqUGFnIedGZVXMbgt4NEQWN2Y3FIXEmAaONGeGCjBVXQEIwSjFt757ngfm5UAXMu2zem1WBlHzZDXZcLsr/FdwcenQ5yOb8L5Uus8ONXzerE2XLPb2yUNKRBKAb92agv8/DQe4Y/AKEIEdH5yYKHi4+Y7ns4NF0EZeE+MPgH7P/mxxF27qFmMaRtp5edjWX9XHN3yENVUqko0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bf5cf3-79df-49cd-0278-08dc75bd959d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 15:33:50.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5unyyTE/3wsVKFyA6wmWyKeDC1gLAP0NJsrInb67G2U6cRrMTasR11/xRIdW6o5usi7jiEUXsyiHFYZ73z9kPgIQVeOf2tjnf5z/EeE+xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160110
X-Proofpoint-ORIG-GUID: IW89p7_2vipSXHhJMEjsdHYEB8LaMs4W
X-Proofpoint-GUID: IW89p7_2vipSXHhJMEjsdHYEB8LaMs4W

On 5/14/24 11:35 AM, Matthew Wilcox wrote:
> As encouraged by my lively audience / collaborators, here is the
> typos-and-all result of the LSFMM session which just finished.
> 
> Please don't respond to point out the typos; trust that I will fix them.
> 


........

> 
> Has_HWPoisoned
> ==============
> 

For Has_HWPoisoned, the comment in include/linux/page-flags.h:926 works well 
with some additional comments.

This flag is per-folio. Has_HWPoisoned indicates that at least one subpage is 
hwpoisoned in the compound page. This flag is set by hwpoison handler and is 
cleared by THP split or freeing of the page. This flag is not set on hugetlb folios.

> Large_Rmappable
> ===============
> 
> 
> 


