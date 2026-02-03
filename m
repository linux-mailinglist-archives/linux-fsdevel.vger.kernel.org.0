Return-Path: <linux-fsdevel+bounces-76231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CN0A/yAgmneVgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 00:13:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C3DF9A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 00:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE8643045002
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8A30FC26;
	Tue,  3 Feb 2026 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iqmzqgKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D22E645;
	Tue,  3 Feb 2026 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160373; cv=fail; b=nlr9z2ckIeKuVIwlRXxNyrbXnCLdx8OXjH06kjblNzJp3hafmQ9iCgeYU/MsT+93TFofWT4pbHeN23A3uhjFvr33dAAfhs/RekY5xhYradB5B+53JG7Tbc2FJVCjYUjdPAEotK8N54SP7AZR02iLvnileUQat9jxlkpQiHHQ57I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160373; c=relaxed/simple;
	bh=wqHeFXpH0ADb4OsBSaCV8BD6dIvI10DPsUzG3pcMwRk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=G7U7x7ShE/nDb1owZIChHdj6DX/+SMhWxvngaaOrKqgqp5QMdpEjRoc3JrmSWtiBsxv036x8OSRrLeshIiUDszyXTr+XevA87oE5AKfcwVadttlIMMGK0lyAzG+UWHUfP+5N7X7F9TrFBUiVUVssFOxYLd8pa/qjbNsccibmmPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iqmzqgKA; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6139JEoa020418;
	Tue, 3 Feb 2026 23:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wqHeFXpH0ADb4OsBSaCV8BD6dIvI10DPsUzG3pcMwRk=; b=iqmzqgKA
	vJFX3vxOvRmC60SPOgnChhW/IMNiSPyYn2o+9a1Qtn6EJi24P1wOfJvM1ClNCIUM
	/9IUaPVp9d3rihbsfk1jLu+H3ci7nCbCymFTa6H3HOtY4iaHFXdTR6ReWQQIwMm6
	FPCHnUWFcVWrBQYh44PiNMxH/hD8pg5Nu0ZQcDK9gPS5J03m5qdEKMpOFmZMIe7Y
	0VuxkQXNuu1tw4aNk8tH9rC53+geOOQHpmyHd22LhUtR3Y0r+CZJF34ncvrVR8OY
	JWj9kXVGbT6Vo5yALdTsarfGkfx0cFcoHVtTQhM+HXnzAE4+hs4ga7Uaj7ddCGd/
	Vaj/9g3krZWS/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gw83w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 23:12:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 613NCjOd026199;
	Tue, 3 Feb 2026 23:12:45 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gw83r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 23:12:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFT8nhWLlnQiTLhn1QZnZPJVDbGZOq46jsqBsZ1c+6sgSwblTQNlHPwHwnKsqnBK5oae9m5g4RJ2I6zxUMt5L9BdtBZHRLpc7HMrQ+4yZvTtrI49jnN4ynuJVAtWkb8fUnf4RXhDo70akffb+i3Ihf2mIv+udCXX4fCSIyuzXFYvrJxPH7f9KYLqO3OTYf3Tdo/lDpMe93tkgZUA5Ypp8ASOUgWwrCj2+EYU95ZN+dOlXF/ndoBP2U/GzET8yCsu8nG+ye2EiU94X+poCBb2p56y4ByE/FEXaftvMem+YYf7H42cEaf3FpATDOiYNOPTg7FekejvY/XeDpGgqfXb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqHeFXpH0ADb4OsBSaCV8BD6dIvI10DPsUzG3pcMwRk=;
 b=Eh2mYqVGocSwBOei4ExOv44/pbphVciS5njF9tKlQxw95wqAVH2i8F4frIZzkF24tskpmA2wsYWnwOpmLYwnfWwKBhS9lMHbZzxNlVgKJWOH32+sR6A9nxSsSOWsxO81LG8Z8QgtMbqTLSW1zgLATMeMnVI5jO9XYP1KClRKq+z203Dz9byQUlnXZ+jzdCTk0B8t3Z4GbfSGTbnPU/XX2KIr0eIE4S9IHidow8/5z6gMrhQpGJpEBInkQh06K7/Lg5viuy6QuVsnlQNBc6Oh4sLVlf8hIcdyzo8HqFln4qgBpN7ieDJTh2WVN3T99KoHK3qn0XfYEDLBRZaXgpDAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF25982425A.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 23:12:43 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 23:12:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>,
        "janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v3] hfsplus: validate btree bitmap during
 mount and handle corruption gracefully
Thread-Index: AQHclOtKLfhUmNqRn0mOeRrZ0UkGhLVxm1gA
Date: Tue, 3 Feb 2026 23:12:41 +0000
Message-ID: <c755dddccae01155eb2aa72d6935a4db939d2cd7.camel@ibm.com>
References: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
		 <85f6521bf179942b12363acbe641efa5c360865f.camel@ibm.com>
	 <ec19e0e22401f2e372dde0aa81061401ebb4bedc.camel@mpiricsoftware.com>
In-Reply-To:
 <ec19e0e22401f2e372dde0aa81061401ebb4bedc.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF25982425A:EE_
x-ms-office365-filtering-correlation-id: fc4dd31a-6dad-4ef0-8a61-08de6379bb38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmxOdjhMU3AxNGYzREM0dzRaOURRWDdGWVZKRGo4Y0xNc1ZoQ0wySDk5VU5I?=
 =?utf-8?B?TEFPL2gvUy8rWkhGSzRJMnI0TWUvU0RlYnF6Y09SVHEwekVQdS9Ia09ub3E5?=
 =?utf-8?B?R1FrTm5NdjlXY3lvSENrZ3pMNFAzNll2eDJTN041ZC85am5ZeGdqQ2RvZ2RM?=
 =?utf-8?B?SGRSbWtkUEIvNDFWakJVM0RVNEp2Q0luSW5HQkhFK1lTaW5PRmR6Mzl5Q0FS?=
 =?utf-8?B?aVpwNHhtbFdJcUNFVjJleE95MVJweis1RisrcVJ0dkZXRDQ5SjhiZno2eHBG?=
 =?utf-8?B?OG9xOFhPTGRFQ0NPRGNuWitNZFZSMldCV0x5UEcrcFhXQ3BMd1dHVkxHa0Fp?=
 =?utf-8?B?WjhVcHpuNG9wNDE5NGlybzdIMDdET3lMT0gybU1DNG1yaWdsU05nZm12eVlk?=
 =?utf-8?B?NElPY3J3NGZ3c0hyRzhObHdzTFZ2bHBZVXdNZjdUdDN3SzhKOFJ5TkZ2a210?=
 =?utf-8?B?cXMxaUYxd1dsWHNBblVxUFFENGNIeC8zMlVYMjY0aU5pK29nWEdMdGtZa0dw?=
 =?utf-8?B?aXNHU3NleXEwcUhKQzJQS1paTVl5Y2lYNWIxYmRsT3NzWlJkdlZwbk1oOUkx?=
 =?utf-8?B?dm5NZkl0SjJsUEY2Z3J6cGo0MmZVTjhyRmRaeGNteTYzdm13VnQwT0FpdHNy?=
 =?utf-8?B?aHE0aVA3dXdNY2g5WTBpOGhLK0tTWHpRUW1pMzk5ZU0vZFdUd3FtTGtJcVdw?=
 =?utf-8?B?R1hGUGt3OHZka3kwakdtSjNtMmlBM2h3RU9CVnZCNElIbTBScDZ6ZmJjdnly?=
 =?utf-8?B?blFxcFNvT0xleUVEWmRocmxUdWx5dHNUY0JZL2dvMzJwVGx6NC9NTEh4a0RC?=
 =?utf-8?B?bGEyajRGV2p1UjlBV3NxY2FjM0labWdIUjdxMWc1dGQwQ0tmT2xzSWNmTjZZ?=
 =?utf-8?B?WFBmQVNqNGpQdE9jMmw4RUhYRTdleUgvRnM4eFp3MkpTZ2FIMzE2WlU1N09I?=
 =?utf-8?B?NytPaWJ6R2NSV3pBbnd2TjB4c1ZvN3ZmUUR3TkpQSTFRbHI3eXJZZ2FMU0dr?=
 =?utf-8?B?SEFjQ1VwaDJFdXpoKy9meHlDcHNFU2NGcnFETGxPdEhFVUNTbURKdnVlVTdr?=
 =?utf-8?B?OERYc2ZwcDlOQ0dxTGgxY3d1K3VFWEIxSlJpd1VUaGUyU2gwVjNVRnowRHp5?=
 =?utf-8?B?TzRvcVFwVWJKT3Z5T2FZYkxYS2J5bjJNbUd3T0I0RHRhUjB0N0NjVWc5MlFi?=
 =?utf-8?B?ZDI2MkNLU1ZOaE5MM0pCblhKYmZOZXdpdktYWmE4YnA2bEhVWkM2Z0xwUTNm?=
 =?utf-8?B?R1h0S1ZNV2hzMzYvK2tTWVdMMStRVGV6MFBjU0MxV2JHNFVod1h0UHNTUWdm?=
 =?utf-8?B?M0NJL2VBdEt1SDB5bzZUY1FCWlJsNkNWcEVxcXcxOUluSDl3OEc2KzUwOHFI?=
 =?utf-8?B?aEd0UjNFNm5UUE9YdGxXRmNWTkF3UXVhUG5jS0NDUTNqZExraW52YkxjUVVr?=
 =?utf-8?B?MEw4RlNoY1dVeEkrQTRiTENiOEVxckViQVI3V1BkQWxTYkxoRTFnMGVwNnNw?=
 =?utf-8?B?V09ZcXRqTW5pdzNEeTVMSDBqNUZ0RGY5RDgxWldETlJJeUJVb1ZMTktUSWpH?=
 =?utf-8?B?UXZjY0hyVnVZbXZQbDhCZ1JmVmxSNlFGdXByNGUzWklzQWEzY2gzUjZCVDlC?=
 =?utf-8?B?VWZaTWhubVpjWkU3TGhnc0RSSDlQamxxRTU3L0xEZW9VRVJLTXdvOXlNRVJh?=
 =?utf-8?B?NENLcCtsdUsySmtHQ2l6NWxCRnEvN08zcld2QlZmUmNhcGg0eWVGTUo5Lzdy?=
 =?utf-8?B?dnJDMWE2cTJ5Q1RGN2oxdTFHTjY4UlVDUWlFUnk1VWxXcms4bUtWK1BWdUFV?=
 =?utf-8?B?VFk1Ny9XTDJndmdvcEhGS2xNWGtPeFgrM0tqZFExQ3lRVzRHVTY2aWJISkUv?=
 =?utf-8?B?SXJZQU03ZWRtQlJiQ1FVejhPRG9VNEJ6bFU0QVF0RW0vVTU1V0huVjhrR3pt?=
 =?utf-8?B?MG9lNzRGOHBCNmp6YXRHU21nNkg2QlFDUkZFRjRESkYvaXp0R3lubiszeUV4?=
 =?utf-8?B?YUV3WGsya3NFckh1WGVCRE1DSTFLV1NpeHBQSTNyZnZmUXpHN2FranlaUU9q?=
 =?utf-8?B?NlZIdUdPQ0pGRXYwanpVYm94MXZPcGo2OW9ZV3hxc1RCODV5bUo1eVBsbS9R?=
 =?utf-8?B?a3I5MUVycWZMNmJ4cytLSzRnOTBIamtGU1VMM3I3aHNTamFnK0lSbEdpdEVI?=
 =?utf-8?Q?RfXoCFmAEzhGIABDvRNTyWE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mml2akQ1bDQ5OXZIVXJjN2R2TWhKZWRoSXZLbWVOY2JmTm04RTZ1SU1pTDRV?=
 =?utf-8?B?U3g5a3ZLKzZtY0JCZ1crRGJ3UkcrQ2h6MGpIVVQ0OE1GWnRYNDhQUFVSRDdO?=
 =?utf-8?B?R0hmOUl0OU9KRm9SYXdoTDRXSXBLWFVrVTk2RFUxbXVheVp0NWIrRnNuSytK?=
 =?utf-8?B?aXZEcFJUdC9vWVMzYXdLemRxc1lKV3B5SWNlbjcycS8vZ3p3K0tzZWZhMDNW?=
 =?utf-8?B?QVpWOUtLa0FNc1R2c2dTYXdpRGJJL2swcEVHVTVjUUZ6bFdrdzhRZVN3Y2lM?=
 =?utf-8?B?RzNPQ0pRbDFqekhhSG44ZUFIVjN3MWtOcVB5cG43a21ycmh2eG5CcjdsY2Vk?=
 =?utf-8?B?d0xMcGdUcDY3U2FOcnphSEdUeGU3L2hQU3NCNkpDY21UVTFSUFMrNTB1TGZv?=
 =?utf-8?B?UUlkcU91YnVocTdqRG10amJrN3hUTGFnK0VhZnRKeTBSNHV6SUZmYUFsSTlq?=
 =?utf-8?B?a21ZcldyQnNHbkNyWDVGNUlwYjNpL2RRb1k5R011ZmtGQ3dkOWZrQnJ4RGxh?=
 =?utf-8?B?aXQ1ZTEwaFBuVm90cy9rQ1hTeDZ4WExqb3lvT2tzT3ZTV21mZHF4cC85bDIz?=
 =?utf-8?B?VU0xaUhmZzVUTzVsa2l1VVJ5enVFSGJNS1FJVTFtbFgrcTl4TWRxUHJvUFc1?=
 =?utf-8?B?SC9ja2VQWW9mamYraFpuWWczNHZtU3lONUpZS2pZQUdUT2hRQVVXbW1VWXZY?=
 =?utf-8?B?S2lteDNwZnV2eUN0RTBHaWJFZWJRajNYellCM2d4TS8zL0lNQzYxYlJGSm4x?=
 =?utf-8?B?S29GVWxKQlg2S2tNbGs5M3p5RCt5SnJaVlpyQ1dxeWt3RXVwLzJlTzJ3Z1h0?=
 =?utf-8?B?OTBOdUsrS3BuR0w3cGRZb3pkZkt5N05RNGd3NW1sTmZ6KzBvbGVJR3I3L0lR?=
 =?utf-8?B?OEU3QmZaaUVPRlRrMk1zZThqaXRxblpoeVFyYUM5a2gyVXFiQlYxZFR2V1ZT?=
 =?utf-8?B?Y052NVJ2bjQvT3lIemlzbHFib0hObnloUHdaenp3QmdhSVh4TVIvQjJmM2JR?=
 =?utf-8?B?RzlqU1liTVEreklMVHRGRTBPTmdHa1p2ajJwUEFaTUpCVEMzSkRwVWVUMHl5?=
 =?utf-8?B?TThwQUVlVWlRbmVua1ZlSjNpQVV3R0NPNW5PdHNMTFBQQUtGd2ZnYjVoRXh4?=
 =?utf-8?B?OGZHakpLL1pvRGU4Z3k2dUxzVW91NzI0eUhVV1lvVHlEdlpRNVJYbWFIN09u?=
 =?utf-8?B?OGdkWWF5NFMwa09ac3RwY2V1dkcwSmVxdVNLZHlETlhLczBBYVYzMVNoN0Ru?=
 =?utf-8?B?Ly9wcnczQUpVMk5Ob3E1NTJnR1NoYnFZbXh6aHdFSHI1dngvOU1wOTJDV2w5?=
 =?utf-8?B?UmJyLzFPR2taWkZ5Y1RUNmU5OW5xcklXV1FwdHk0b2lNSy9SajlPOVJ5cXVU?=
 =?utf-8?B?T1Y2SE1PT1VYQWZkZWt1UGd4RENDNjlVQXZxRnJZTWdNdnkrYytsdFdDTmtW?=
 =?utf-8?B?TEF4ZUpxd3VLQUtCN3VYK1BYRUJPNDZJQWFMYVZOc1ZTbStlZjFxSGV1Smpj?=
 =?utf-8?B?cGdMNjUwZElLRGh6SVMvRWhJeUNtRzI2V2QxcVBpcU1vd1JMT1k0VHF5Sm9S?=
 =?utf-8?B?OW1vSXBsM3EyaFFVQW90U3NWUlkrZm5NYzJrRmg4S2FiS3g5SjR2eDNPeVE3?=
 =?utf-8?B?aFo4RGRMd2Q2cXVTTGRJUTFsc0hqUHJkK1BCNExuRU1sVFlqei9YL2x4TS9U?=
 =?utf-8?B?aUdEcFhSdTgrTTZES1h0dW16T2ZOSS9vemFsaGZFZ3JRTENhamQwSnZGQ2tu?=
 =?utf-8?B?ejN1Y2ZMYmFGc3hGZ3JVTG1Qek13OUdtRkpKaGNNRTFreEJwVjl1SVplQjdZ?=
 =?utf-8?B?TithOTJVU29QWWtzY2NvSmpuWEE3YWEvTE5LdFlVOGpqU0h3V3E3dElDeTBH?=
 =?utf-8?B?ODVMVXZoTnBrUjROdU5ndjNUMTRvYTE5bUVkUjJONlJlQ2Y3U296WUpZb1Zx?=
 =?utf-8?B?RzQ1anRQR294Wnl6cjhhdWY1cmNFQnhBcndvbldZNWlZM1ArRzIxTnpZemdV?=
 =?utf-8?B?Ny9LbDBwVFhJclovRXQ3OXhzZmhIcjhNOWJSeUZYYkkxbmVzSmpCcXZCOUNs?=
 =?utf-8?B?SEZMY3hTZ3pKSlFvL2xObGEvMUxhUW9vVnJiNUhDdVc0VkFZTXV3bk1HU0dx?=
 =?utf-8?B?WkZMRWl0d2pUd09xYlZFSlR2U0VsLzZaUGNoL1NaNUdBVVdHUk8vN3hKY09a?=
 =?utf-8?B?bEVpRExpOFloYXJTbWJlWElLUFQvN29HOTQ4ekJ5ek9FUTlsL3BQSjdpaEdu?=
 =?utf-8?B?a0dQRm5uaThmWG9DcGFhRk5xaG9jdC9rY2dIY3JaKys5bzlaTmZEQUZwN1h4?=
 =?utf-8?B?WnJTSnVlYlc4UDJkZmtPYks3d3lJdEE3QWs3Mzg2VzJqU0NuUlRIeDhlODJL?=
 =?utf-8?Q?l89QxwfrvJdOETfnzrlMElK2r+nNC3LbVZ28u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56ADFCDD21E44B4192F2A42FAAE49A69@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4dd31a-6dad-4ef0-8a61-08de6379bb38
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 23:12:41.5991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wz0aDJJ1ya3JGpgRUvls2S6K70sndg+MLw9vWyVc6DwwDVeqafj3unrWddPL3gqJqHy0TOiBXZcVIKzV1fAGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF25982425A
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=698280ee cx=c_pps
 a=3wiUqt7F461DME2/dPg5UA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=817Ebq6TeGoHMHPnBj4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I5UtuhJwMB9hI9sA7Fx3FxLQnNntgAlK
X-Proofpoint-ORIG-GUID: YDPcp1POyX-PDpJtQe78etrGh4hHKyBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE4MCBTYWx0ZWRfXxm3fjyztNzxt
 KoUSExcEoBihLqp5jix2DiXoxKfPHnw+5uODeA0tvbGuuPeQzmIXRHJZEHzqrwIC00y8NtjnFGp
 RGHuzbJw/+tj3ouJzKk7p5pLS9tCfvfC7mAJc/KKpftUsGf8Q7Cim9YeFXxb1sRV931WcIYnko8
 6Kj/0TFbw2UU+pP60c1k93Lju9l2YFD/bYQvlprSTX/ZzuK9gxbybpSSq6eToqc9iWJba6PLlVu
 4fAEjajTKsxlEFcKhsjbHwrCWc/4EeYQY52sEVN/wqumaFMS8Rb7T/HxAXYhk9g6yQ8DXGzHKI3
 XECgJXSjO+LlhIO0PJqwTQufOsdAmDNxQAGCFXbFdx0QnkDEu7sGm8ZSvM/ELpJRCU0dr3AiQLR
 //8yqOVe1sYo0IC4neiFggrO5PSIBfNYkDXcgxRqDmmDuQn00Ne+NrOHRPvNHEf4zQF2QiVw3jL
 F75NOrYC517DnuFrCTA==
Subject: RE:  [PATCH v3] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_06,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76231-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 672C3DF9A0
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTAzIGF0IDE0OjI4ICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gTW9uLCAyMDI2LTAyLTAyIGF0IDIwOjUyICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gU2F0LCAyMDI2LTAxLTMxIGF0IDE5OjM0ICswNTMwLCBTaGFyZHVsIEJh
bmthciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgLyoNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoCAqIFZhbGlkYXRlIGJpdG1hcDogbm9kZSAwIChoZWFkZXIgbm9k
ZSkgbXVzdCBiZSBtYXJrZWQNCj4gPiA+IGFsbG9jYXRlZC4NCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oCAqLw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgbm9kZSA9IGhmc19ibm9kZV9maW5k
KHRyZWUsIDApOw0KPiA+IA0KPiA+IElmIHlvdSBpbnRyb2R1Y2UgbmFtZWQgY29uc3RhbnQgZm9y
IGhlcmRlciBub2RlLCB0aGVuIHlvdSBkb24ndCBuZWVkDQo+ID4gYWRkIHRoaXMNCj4gPiBjb21t
ZW50LiBBbmQgSSBkb24ndCBsaWtlIGhhcmRjb2RlZCB2YWx1ZSwgYW55d2F5LiA6KQ0KPiANCj4g
SGkgU2xhdmEsIHRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCj4gDQo+IEFjaydlZC4gSSB3aWxs
IHVzZSBIRlNQTFVTX1RSRUVfSEVBRCAoMCkgaW4gdjQuDQo+IA0KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgbGVuID0gaGZzX2JyZWNfbGVub2ZmKG5vZGUsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEhGU1BMVVNfQlRSRUVfSERSX01BUF9SRUMsICZi
aXRtYXBfb2ZmKTsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChsZW4gIT0gMCAm
JiBiaXRtYXBfb2ZmID49IHNpemVvZihzdHJ1Y3QNCj4gPiA+IGhmc19ibm9kZV9kZXNjKSkgew0K
PiA+IA0KPiA+IElmIHdlIHJlYWQgaW5jb3JyZWN0IGxlbiBhbmQvb3IgYml0bWFwX29mZiwgdGhl
biBpdCBzb3VuZHMgbGlrZQ0KPiA+IGNvcnJ1cHRpb24gdG9vLg0KPiA+IFdlIG5lZWQgdG8gcHJv
Y2VzcyB0aGlzIGlzc3VlIHNvbWVob3cgYnV0IHlvdSBpZ25vcmUgdGhpcywgY3VycmVudGx5Lg0K
PiA+IDspDQo+ID4gDQo+IA0KPiBJIGFncmVlIHRoYXQgaW52YWxpZCBvZmZzZXRzIGNvbnN0aXR1
dGUgY29ycnVwdGlvbi4gSG93ZXZlciwgcHJvcGVybHkNCj4gdmFsaWRhdGluZyB0aGUgc3RydWN0
dXJlIG9mIHRoZSByZWNvcmQgdGFibGUgYW5kIG9mZnNldHMgaXMgYSBsYXJnZXINCj4gc2NvcGUg
Y2hhbmdlLiBJIHByZWZlciB0byBrZWVwIHRoaXMgcGF0Y2ggZm9jdXNlZCBzcGVjaWZpY2FsbHkg
b24gdGhlDQo+ICJ1bmFsbG9jYXRlZCBub2RlIDAiIHZ1bG5lcmFiaWxpdHkgcmVwb3J0ZWQgYnkg
c3l6Ym90LiBJIGFtIGhhcHB5IHRvDQo+IHN1Ym1pdCBhIGZvbGxvdy11cCBwYXRjaCB0byBoYXJk
ZW4gaGZzX2JyZWNfbGVub2ZmIHVzYWdlLiBBcyBwZXIgeW91cg0KPiBzdWdnZXN0aW9uLCBpZ25v
cmluZyB0aGlzIGN1cnJlbnRseS4gOykNCg0KSSBhbSBub3Qgc3VnZ2VzdGluZyB0byBjaGVjayBl
dmVyeXRoaW5nLiBCdXQgYmVjYXVzZSB5b3UgYXJlIHVzaW5nIHRoZXNlIHZhbHVlcw0KYW5kIHlv
dSBjYW4gZGV0ZWN0IHRoYXQgdGhlc2UgdmFsdWUgaXMgaW5jb3JyZWN0LCB0aGVuIGl0IG1ha2Vz
IHNlbnNlIHRvIHJlcG9ydA0KdGhlIGVycm9yIGlmIHNvbWV0aGluZyBpcyB3cm9uZy4NCg0KPiAN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoZnNfYm5vZGVfcmVhZChub2Rl
LCAmYml0bWFwX2J5dGUsIGJpdG1hcF9vZmYsIDEpOw0KPiA+IA0KPiA+IEkgYXNzdW1lIHRoYXQg
MSBpcyB0aGUgc2l6ZSBvZiBieXRlLCB0aGVuIHNpemVvZih1OCkgb3INCj4gPiBzaXplb2YoYml0
bWFwX2J5dGUpDQo+ID4gY291bGQgbG9vayBtdWNoIGJldHRlciB0aGFuIGhhcmRjb2RlZCB2YWx1
ZS4NCj4gDQo+IEFjaydlZC4gQ2hhbmdpbmcgdG8gc2l6ZW9mKGJpdG1hcF9ieXRlKS4NCj4gDQo+
ID4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCEoYml0bWFwX2J5
dGUgJiBIRlNQTFVTX0JUUkVFX05PREUwX0JJVCkpIHsNCj4gPiANCj4gPiBXaHkgZG9uJ3QgdXNl
IHRoZSB0ZXN0X2JpdCgpIFsxXSBoZXJlPyBJIGJlbGlldmUgdGhhdCBjb2RlIHdpbGwgYmUNCj4g
PiBtb3JlIHNpbXBsZQ0KPiA+IGluIHN1Y2ggY2FzZS4NCj4gDQo+IEkgcmV2aWV3ZWQgdGVzdF9i
aXQoKSwgYnV0IEkgYmVsaWV2ZSB0aGUgZXhwbGljaXQgbWFzayBpcyBzYWZlciBhbmQNCj4gbW9y
ZSBjb3JyZWN0IGhlcmUgZm9yIHRocmVlIHJlYXNvbnM6DQo+IDEuIEVuZGlhbm5lc3M6DQo+IFRo
ZSB2YWx1ZSB3ZeKAmXJlIGNoZWNraW5nIGlzIGFuIG9uLWRpc2sgYml0bWFwIGJ5dGUgKE1TQiBv
ZiB0aGUgZmlyc3QNCj4gYnl0ZSBpbiB0aGUgaGVhZGVyIG1hcCByZWNvcmQpLiB0ZXN0X2JpdCgp
IGlzIGRlc2lnbmVkIGZvciBDUFUtbmF0aXZlDQo+IG1lbW9yeSBiaXRtYXBzLiBIRlMrIGJpdG1h
cHMgdXNlIEJpZy1FbmRpYW4gYml0IG9yZGVyaW5nIChOb2RlIDAgaXMgdGhlDQo+IE1TQi8weDgw
KS4gT24gTGl0dGxlLUVuZGlhbiBhcmNoaXRlY3R1cmVzIChsaWtlIHg4NiksIHRlc3RfYml0KDAs
IC4uLikNCj4gY2hlY2tzIHRoZSBMU0IgKDB4MDEpLiBVc2luZyBpdCBoZXJlIGNvdWxkIGludHJv
ZHVjZSBiaXQtbnVtYmVyaW5nDQo+IGFtYmlndWl0eS4NCj4gDQo+IEZvciBleGFtcGxlLCByZWFk
aW5nIGludG8gYW4gdW5zaWduZWQgbG9uZzoNCj4gICAgIHVuc2lnbmVkIGxvbmcgd29yZCA9IDA7
DQo+ICAgICBoZnNfYm5vZGVfcmVhZChub2RlLCAmd29yZCwgYml0bWFwX29mZiwgc2l6ZW9mKHdv
cmQpKTsNCj4gICAgIGlmICghdGVzdF9iaXQoTiwgJndvcmQpKQ0KPiAgICAgICAgIC4uLg0KPiAN
Cj4gLi4uYnV0IG5vdyBOIGlzIG5vdCBvYnZpb3VzbHkg4oCcTVNCIG9mIGZpcnN0IG9uLWRpc2sg
Ynl0ZeKAnTsgaXQgZGVwZW5kcw0KPiBvbiBDUFUgZW5kaWFubmVzcy9iaXQgbnVtYmVyaW5nIGNv
bnZlbnRpb25zLCBzbyBpdCBiZWNvbWVzIGVhc3kgdG8gZ2V0DQo+IHdyb25nLg0KPiANCj4gMi4g
Q29uc2lzdGVuY3kgd2l0aCBFeGlzdGluZyBIRlMrIEJpdG1hcCBDb2RlOg0KPiBUaGUgZXhpc3Rp
bmcgYWxsb2NhdG9yIGNvZGUgYWxyZWFkeSBoYW5kbGVzIG9uLWRpc2sgYml0bWFwIGJ5dGVzIHZp
YQ0KPiBleHBsaWNpdCBtYXNraW5nIChoZnNfYm1hcF9hbGxvYyB1c2VzIDB4ODAsIDB4NDAsIC4u
LiksIHNvIGZvcg0KPiBjb25zaXN0ZW5jeSB3aXRoIGV4aXN0aW5nIG9uLWRpc2sgYml0bWFwIGhh
bmRsaW5nIGFuZCB0byBhdm9pZCB0aGUNCj4gYWJvdmUgYW1iaWd1aXR5LCBJIGtlcHQgdGhlIGV4
cGxpY2l0IG1hc2sgY2hlY2sgaGVyZSBhcyB3ZWxsOg0KPiAgICAgaWYgKCEoYml0bWFwX2J5dGUg
JiBIRlNQTFVTX0JUUkVFX05PREUwX0JJVCkpICAgKHdpdGgNCj4gSEZTUExVU19CVFJFRV9OT0RF
MF9CSVQgPSBCSVQoNykgKG9yICgxIDw8NykpKQ0KPiANCj4gMy4gQnVmZmVyIHNhZmV0eToNCj4g
UmVhZGluZyBleGFjdGx5IDEgYnl0ZSAodTgpIGd1YXJhbnRlZXMgd2UgbmV2ZXIgcmVhZCBtb3Jl
IGRhdGEgdGhhbg0KPiBzdHJpY3RseSByZXF1aXJlZCwgYXZvaWRpbmcgcG90ZW50aWFsIGJvdW5k
YXJ5IGlzc3Vlcy4NCj4gDQo+IEFtIEkgbWlzc2luZyBzb21ldGhpbmcgaGVyZSBvciBkb2VzIHRo
aXMgbWFrZSBzZW5zZT8NCg0KQ29ycmVjdCBtZSBpZiBJIGFtIHdyb25nLCBidXQgSSBzdXNwZWN0
IHRoYXQgSSBhbSByaWdodC4gOikgVGhlIGVuZGlhbm5lc3MgaXMNCmFib3V0IGJ5dGVzIG5vdCBi
aXRzLiBJIGFtIGdvb2dsZWQgdGhpczogIkVuZGlhbm5lc3MgZGVmaW5lcyB0aGUgb3JkZXIgaW4g
d2hpY2gNCmJ5dGVzLCBjb25zdGl0dXRpbmcgbXVsdGlieXRlIGRhdGEgKGxpa2UgMTYsIDMyLCBv
ciA2NC1iaXQgaW50ZWdlcnMpLCBhcmUgc3RvcmVkDQppbiBtZW1vcnkgb3IgdHJhbnNtaXR0ZWQg
b3ZlciBhIG5ldHdvcmsuIi4gU28sIGlmIHlvdSBuZWVkIG1hbmFnZSBlbmRpYW5uZXNzIG9mDQpv
ZiB2YWx1ZXMsIHRoZW4geW91IGNhbiB1c2UgY3B1X3RvX2JleHgoKS9iZXh4X3RvX2NwdSgpIGZh
bWlseSBvZiBtZXRob2RzLiBCdXQNCml0J3Mgbm90IGFib3V0IGJpdHMuIElmIHlvdSB0YWtlIGJ5
dGUgb25seSwgdGhlbiB0aGUgcmVwcmVzZW50YXRpb24gb2YgYnl0ZSBpcw0KdGhlIHNhbWUgaW4g
QmlnLUVuZGlhbiAoQkUpIG9yIExpdHRsZS1FbmRpYW4gKExFKS4gQW0gSSByaWdodCBoZXJlPyA6
KQ0KDQo+IA0KPiBJZiB0aGVyZSdzIGEgc3Ryb25nIHByZWZlcmVuY2UgZm9yIGJpdG9wcyBoZWxw
ZXJzLCBJIGNvdWxkIGludmVzdGlnYXRlDQo+IHRoZSBiaWctZW5kaWFuIGJpdCBoZWxwZXJzICgq
X2JlKSwgYnV0IGZvciB0aGlzIHNpbmdsZS1ieXRlIGludmFyaWFudA0KPiBjaGVjaywgdGhlIGV4
cGxpY2l0IG1hc2sgc2VlbXMgY2xlYXJlc3QgYW5kIG1vc3QgY29uc2lzdGVudCB3aXRoDQo+IGV4
aXN0aW5nIGNvZGUuDQo+IA0KPiA+IA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93YXJuKCIoJXMpOiBCdHJlZSAweCV4IGJpdG1hcCBjb3Jy
dXB0aW9uDQo+ID4gPiBkZXRlY3RlZCwgZm9yY2luZyByZWFkLW9ubHkuXG4iLA0KPiA+IA0KPiA+
IEkgcHJlZmVyIHRvIG1lbnRpb24gd2hhdCBkbyB3ZSBtZWFuIGJ5IDB4JXguIEN1cnJlbnRseSwg
aXQgbG9va3MNCj4gPiBjb21wbGljYXRlZCB0bw0KPiA+IGZvbGxvdy4NCj4gDQo+IEFjaydlZC4g
SSBhbSBhZGRpbmcgYSBsb29rdXAgdG8gcHJpbnQgdGhlIGh1bWFuLXJlYWRhYmxlIHRyZWUgbmFt
ZQ0KPiAoQ2F0YWxvZywgRXh0ZW50cywgQXR0cmlidXRlcykgYWxvbmdzaWRlIHRoZSBJRC4NCj4g
DQo+ID4gDQo+ID4gPiDCoCNkZWZpbmUgSEZTUExVU19BVFRSX1RSRUVfTk9ERV9TSVpFwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgODE5Mg0KPiA+ID4gwqAjZGVmaW5lIEhGU1BMVVNfQlRSRUVfSERS
X05PREVfUkVDU19DT1VOVMKgwqDCoMKgwqDCoDMNCj4gPiA+ICsjZGVmaW5lIEhGU1BMVVNfQlRS
RUVfSERSX01BUF9SRUPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMsKgwqDCoMKgwqDCoMKg
LyogTWFwDQo+ID4gPiAoYml0bWFwKSByZWNvcmQgaW4gaGVhZGVyIG5vZGUgKi8NCj4gPiANCj4g
PiBNYXliZSwgSEZTUExVU19CVFJFRV9IRFJfTUFQX1JFQ19JTkRFWD8NCj4gDQo+IEFjaydlZC4N
Cj4gDQo+ID4gDQo+ID4gPiDCoCNkZWZpbmUgSEZTUExVU19CVFJFRV9IRFJfVVNFUl9CWVRFU8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAxMjgNCj4gPiA+ICsjZGVmaW5lIEhGU1BMVVNfQlRSRUVfTk9E
RTBfQklUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDgwDQo+ID4gDQo+ID4gTWF5
YmUsICgxIDw8IHNvbWV0aGluZykgaW5zdGVhZCBvZiAweDgwPyBJIGFtIE9LIHdpdGggY29uc3Rh
bnQgdG9vLg0KPiANCj4gQWNrJ2VkLCB3aWxsIHVzZSAoMSA8PCA3KS4gQ2FuIGFsc28gdXNlIEJJ
VCg3KSBpZiB5b3UgcHJlZmVyLg0KDQpPSy4gU28sIGFyZSB5b3Ugc3VyZSB0aGF0IG5vZGUgIzAg
Y29ycmVzcG9uZHMgdG8gYml0ICM3IGJ1dCBub3QgYml0ICMwPyA6KSBJIGFtDQpzdGFydGVkIHRv
IGRvdWJ0IHRoYXQgd2UgYXJlIGNvcnJlY3QgaGVyZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

