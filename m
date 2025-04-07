Return-Path: <linux-fsdevel+bounces-45883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBC8A7E0D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC2F3A240B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3391C862A;
	Mon,  7 Apr 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BEeQ9Rx+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D3UdAC1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F31C84B8;
	Mon,  7 Apr 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035072; cv=fail; b=s7U6yx8/g3QJ3JNhM6O1NbkOz4b3llq0JPkXmqB5BoVWvAaC+JCry12dZCoUkL8R5bsXO14uHELdOgMtyD0RvLGcY0IxSppIr7xaNXff2vkYSjA5VcIcKwuoGr5tc0FCgi4ARxVfSTBi8GlX2oPHU8Eajw2tLioiH0ygGVW+xC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035072; c=relaxed/simple;
	bh=qZXb9PwAB1bBznBzIXOBDswsyITdkpNDQUn+nFp/gk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXMxJ3A4fk5ZEwST44wczxca3Kph2XNAVegzn8N5IIpUMHTIQ/MZXExt4s80BCjY2GCaZiB+hrJ7zYw5/+h1OByiac/t5gY3cEAQHnNANo2eq/SukxvSVIcYYq+xkB9BSfpIWZQUtstxnKsUiBAgmFlRcHJjwFpnZgnDP8TtwpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BEeQ9Rx+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D3UdAC1u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537DH2TU030872;
	Mon, 7 Apr 2025 14:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VETBxGv5mNoJlp6iGrC91lzVEZLQJNkJ6VMxarqfwgQ=; b=
	BEeQ9Rx+4c/qSObl2F4NCPDoaqTcEuNPexQ90AP+01pkVNLzbI9rLKPsiWLHdcgR
	9coDAli8iYhZWc/axQmyZu6Zsp6BmFfyi+VdO4F/rwMsskUene+MR3aqq8vQ3Ub3
	uA9kOCXOPPF1E+dy6Cg7PMwBP/XjKX/BW2AUPtWWeUV6u4Divf4OChEHzCw+Qk4X
	EFPqxOz0Yx8bw7gR6o6lNbvOqJa1aCjTKX3wdUn4+tRx8p8TlI+dEFViJnA8QnqF
	vlTJtbxgSJrRDgpC+lKhr5HCX6LX7zb4xk+q4g2+DCDxsdh0gh1oN9uFBukPsoTo
	8JGwH3ABlWXwdCqiALP5TQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tjnpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 14:10:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537DSEoM013695;
	Mon, 7 Apr 2025 14:10:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye3v84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 14:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYPmP/raoDDSwCM/L+eY/LnMegRZ1VhkbOX2WHCWm365SZ9/W/JpbF9+r/326kGtPeGvySAbw/PgrVHUFGPF9lI4MXaEToIIdkZyIr3HmMqJt5o1exzTbaOzdCBWC1mo7roR1vfyiu1nELKWFNuLW020I1o1TIa3O1ul/6rL2/5yB08Hy9HJ+xSV31LUP3mn6gXOU+IM+7/LIqaStGtMX2/1Ym6p1CPG/RDitTdxPeeZQ91PFiHY9XgaGzzMJ2Ew5VYpjpuOI8GMoXtKdolKEKmyoC2NasbYP2tHqUuu5P7rRrfna4zEzUap76TTSZK87lwTtnEKiW8bkQZraQ7EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VETBxGv5mNoJlp6iGrC91lzVEZLQJNkJ6VMxarqfwgQ=;
 b=JVf9wTUhfK4/NBV+zcKcxqyZNs8vfxr812zMtnqzmfAqSrU8mHyA98ymfyFCmp83uNzFY2AvmN24Oh88xQ7YpiLJNnqsdWLC7mQjDvX+xnmHw76yGSGJueGI2LJ2IZUo8dQghw14JLIn5rdfQRF7TYMzc129aEj6HUXniq8o1u2UHqLyA1B2m+CY5jEv+oG1uhNJ2Onaf8xLdBlIr5K5BPdWBunYhjgpeIwpL5UrJumFoz0iDr2jXppllM0VDrRi88QKYjnO/iD4z5y2dMRxQJYB3ztQKfEGkTU3nBKUtjQdd8ohFLVbehud/e0tnA5QTploty43kWwqcaSa9I+EiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VETBxGv5mNoJlp6iGrC91lzVEZLQJNkJ6VMxarqfwgQ=;
 b=D3UdAC1uAJctLfTT7S4bIyt+8aTX6CBXGD1fVYl2mo9ZPt3NnGsFM5AWUyd2Xx7f5xpN8aV0oVNAhL3Mo9tMR0dc6T/pXxToRIeXS9WH8KzR1aCm6ByXKOS4BETIqhUz4nw6GQizq5DPw3acVyECwGzV+bbW1LLHv0k4dRJjuHI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 14:10:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 14:10:40 +0000
Message-ID: <ef223eea-7796-4a0e-a401-68acf2b549ad@oracle.com>
Date: Mon, 7 Apr 2025 10:10:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <874j0lvy89.wl-tiwai@suse.de> <87wmc83uaf.wl-tiwai@suse.de>
 <445aeb83-5d84-4b4b-8d87-e7f17c97e6bf@oracle.com>
 <16e0466d-1f16-4e9a-9799-4c01bd2bb005@molgen.mpg.de>
 <2025040551-catatonic-reflex-2ebf@gregkh>
 <417f41b3-b343-46ca-9efe-fa815e85bdd3@molgen.mpg.de>
 <2025040534-anymore-mango-d9fb@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025040534-anymore-mango-d9fb@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:610:58::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1028599e-7b92-4f1f-ed93-08dd75ddfa0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU5WYVJSdXFUR3NnY241ZmxwcE5hU2lRQnF4bkYvQk84c3hyQTF2Yk42NzJK?=
 =?utf-8?B?L1JJcHZrNktvVmVnK1l1Q0FNSkRJYnJFZVlvRExEc01wZWUyVWJyYU0xdjR1?=
 =?utf-8?B?RktTUDI1dWNwUGxMY3drRjFqK1p2S25mZVZSeWQ1cXBTc1dOa2lpZytDNDd3?=
 =?utf-8?B?S0VXaUJTSWcreHJYNWpGQ1p3YysxeituQm5mQmYrTk5TVDNHaSsxRmNVWFd2?=
 =?utf-8?B?VFcyUzEyTFVUTkdqOS8xSVhxeGpwTHcydzRaQ0l2MGF3Nk9kWWF2Ym5BNzd3?=
 =?utf-8?B?S3FkSURZTGU0eFYwcXE2bHNRVXdBUHp5N0RxQ0hkV2pXZnc4Z2lSZk11LzU2?=
 =?utf-8?B?NVhld3kwNnFaRjQ5SHphN0FKaGhOK2RqekVuRlpFZUl1WTBmdTFTaU51Vjcw?=
 =?utf-8?B?R0IzSjVVZG56NWs5RUZKRmVMV1ZYT08xRzlXQWtuTHNMa2FndUY1bnlMbVFL?=
 =?utf-8?B?ZWd5QXVTTGFUYXJiajZIQ3NlTlZiNXBraksrbDZISVZtcnFid1pneXpuUkp2?=
 =?utf-8?B?NEdDL2Z6Wi9qbUxFM1lHbFhaUlY3Qk9IRDBFbE9NZU84THRyWXkrZW83eGhk?=
 =?utf-8?B?NjI4NFE0T0dpZURJQWordUxTenZpcFdXR0Z2b2tsRm1ENXg3RDlDN3VTekxN?=
 =?utf-8?B?TE8zRXNkVkVmRThHNFA0SnhpY1NQNzVUd0prekxLMld0bktrM280ZE0wNGNh?=
 =?utf-8?B?ei9NWHE2REJ3aGpwOTREYTNnWXhGMUpYbCtrbnJNUk1xUUxwVDlvRVJNQ3Ry?=
 =?utf-8?B?M2FRb3RDRW1DeGxjMml3eVdxZmRyUmJKak9RUVlOT3I2UFRxdTBSTXR6MWdL?=
 =?utf-8?B?d2dqMnN6N3EwcjdSQUhjN25FVEFVTzAzMHJWYW9GaXJVa2pDcTQ1ODRmaEhW?=
 =?utf-8?B?bVZZQzcvR0xFeGZQWHBCTW1uQ05zNGcvTWl5WWJSbnVJVlNsQVgvaG1zdloz?=
 =?utf-8?B?aWVjeXZrUkxRamVsYU5PbTJxMEVTMUR4QUNNdnJ6MFE3VG5vSFNrWmE1dmNn?=
 =?utf-8?B?OGFaY05BVTRBa0tWQkdCUklmQlZNS3NMMXRNQWQ2MGd0aVhkSmNPOE1Sa3lK?=
 =?utf-8?B?UzVMSy9nbjFvbVpkaHdsVTc2ci8yYXBiYUxoSjl4NDU5ZlJDUGZvdStsSFZs?=
 =?utf-8?B?ckxETDhIT0ZCZHNjTjBGeDRyNDViOHVpQmN4c0FRZ0F5MjNkSC85SlpjVCtV?=
 =?utf-8?B?L1FRT05PSjFBeVdHdzAxdVBlbFgzK0x3b2tZWW0xN0hCVTVOM0tzQTlET1Rj?=
 =?utf-8?B?elFyZWVvUkd3UmRXeVBiT1dneU9tREk1WmJmaHZ5YVFKWnIrbFFUWVBiTlpY?=
 =?utf-8?B?UWtBRjlIVnI4bTBaS2RSby9XRWpOTkRtQUg4d1BNeDAvY2pNTzZXZjJVSlBT?=
 =?utf-8?B?WnRneHkyQklZNm9JUmZuQ01ubjdlajNpWGJadU1WTDB1a1BHZkVjeDRUY0FV?=
 =?utf-8?B?WjBZS0NGbXp4bWlmY3pCV2w0VnVHUTNmZ0lUZitGdE1zb0x1aGJhSGRxNTNV?=
 =?utf-8?B?TWI5RUNHVFhSWi93ZlFOUElrbVlnTXFkS0VNRnhQdGpvUVFKRERGdTMyMXJi?=
 =?utf-8?B?RnJ6aVloSU5aMnFkZDVwdXBHa2ZWMXIyTTRPeG94dU1RY04zUkRGUXJGclpz?=
 =?utf-8?B?WVNXL2xtTkZKOHBKVWJjQWZQb0dpQkN3S25PdVh4Z0poTTZnMk1CR2pmUVV2?=
 =?utf-8?B?RkptSFZuTjAzQVZqejI3MlBTeUtVUjBBSzlyRGxMYllhT01RcXVzQ1NzcEtC?=
 =?utf-8?B?ZmFiMjdSNWV4Q2l5L3pzN3BzK2lYdzc0VnF5WGVUekVBOU5HbW8vZWJuL1Uv?=
 =?utf-8?B?Rk90U0EvTVA0UTc3WE9Cdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUZaMmpldlBJdTZwcHg1cDNXVE1Fd1BvRzNFU0FraE9BMWdIODVKcy9TdTQr?=
 =?utf-8?B?aSsxaXUwcVIwNGdOdmMvZmZLUUVNZStxVlQwLzhYSkpqeVJaYVFkUXY3WkN3?=
 =?utf-8?B?RTNtbXpnMnRnUkJJbGJlUlFwbFExOEx5d01qcVIyWWRENFE5QUl6b2h1MExY?=
 =?utf-8?B?YVl1MTdiSW9tVzRVM1NIU3lUN2JPT1ZaUlhlT0g1b1BUelpTdUlCd2E3aGFP?=
 =?utf-8?B?S2h3UlViZEM1QjJYZzBuQ3NpU0QzRVR1WHByQ2pEYU9VYzJPUEQvSDNyUm10?=
 =?utf-8?B?aEs3T2ZkbStrek04SkhSMHhTUUJQYVl1VWptOWxjN0hyS3NCcDhTS0RsMVNC?=
 =?utf-8?B?cFd0VlNNekZBbnRMQmtDZFY4VUF5YjVySDlKd2xsNGpmMUxGNzZ4cUtDajVU?=
 =?utf-8?B?MUluMCtOU3p4cFh2SDZkem9Wb2JDZWN0dUVtSmQvQnJpcHlJWjF2Rm9TeWpM?=
 =?utf-8?B?ZStJMXB0SS9MUm81TC85WGtPejFzWEI0eEFUcmwwNjRsdGwwQ3RXOHFFVHE5?=
 =?utf-8?B?UitEYnNqVFhKMmFnbDRPYVFDbDk3TENVd2tIbjBkejl3ZVFIU2hrT1VSWjNS?=
 =?utf-8?B?eWVIRU9HZWx5eDh1bEs2WGgwcFlWKytKR1VSYXc2UTVFTmFWVzNBdjJJQlVm?=
 =?utf-8?B?RFI1TjFXVDRUN0dNMXI1SWhNMjkrUktOendlTWdtR1hhVVlFZ1FwcFhjNkNu?=
 =?utf-8?B?T2dNWEx6NUkvcmtMNi94MmYxVFN3NndlNkpiNElsL1pOWUxzeUMxZDlXYmVr?=
 =?utf-8?B?bFBpMytKRk12NExFYTQvdWpPbFdnMnd2NnJXV2FxQWdQQ01taHBURjQrVmlz?=
 =?utf-8?B?TmNPNHExMytTZTA3clZ5THBDWUoxbkJadXduSC9TNkFRK0dqckRaRkU5TlNt?=
 =?utf-8?B?QmEwMzlkWExjc2RhVkFRR3ZDVVE3cW5QMjJ2Vk5UdnB1ZXMwNXBqZnF0ZEhh?=
 =?utf-8?B?bjhKSTMrdC9sR2dHV1B3SnFDQ1Bvd3RlSlhQMnpBZXhQdllrNTFOQkpVSC9p?=
 =?utf-8?B?NmdHWENYalBNbmpLcHMzOS91bE8yZTAxSzMvelZtcSttaE9iNkVtSVN5ZUpJ?=
 =?utf-8?B?SU9JcTdSeExmZFFCOTNhbk5xVjFQMjJwdncvM2VNcERSdVVJcVdzQW5KalhV?=
 =?utf-8?B?Q21QMWZycW45RUl1eGJGK0NXSUwwbmNSc0ZuT3hVcTBiVmYvVGEyTzdlRUgz?=
 =?utf-8?B?QnVsQmpIeVZJRkdtYmF0VVdEbWRVMHRPclRCUjM3c1Y5QVdJMXMwS3czMDZT?=
 =?utf-8?B?YlVSQzBXU1UrWHlJK293bG5sVW5xZlJDcUV2KzRjVzZxM09yTXgzVjV4eDVE?=
 =?utf-8?B?N29lV1BtS3gyTmkvSGpZdTZ3TENNTTA2Q0Z3ZUd6SytWTlQ3Ukt6ditKUFZY?=
 =?utf-8?B?by92bHhqRlBqQXFSODhjVVVFQk01NHZnVEI3RjJoSUFaeldsWEJ2N2UxM0RW?=
 =?utf-8?B?Sm92dDdTdDVvL21sc2w5RTZvcXNoQ1pIVG5jYlFQU0FIVEJDWUlTNHBqY2lB?=
 =?utf-8?B?dzRUU2Fqanl2M0MwK2JNMmFKaEdrSXNxVjM5THF2aU13d2kxbmlvTlA5cnZn?=
 =?utf-8?B?RXk1ZmpRbElrcXpFN1Z6RnQ5NTMvLzMwRkpRNFExbjNSSE1xUlZaUWpjeFd5?=
 =?utf-8?B?MU9MTHQ1TndEcW0zOGx1bjdhZWVKYktCbjVJK3FUSXN4TytUTW9zUWYzOE1v?=
 =?utf-8?B?MUsxRnRBV2RpS0duVGc4Q3ZWa3FHblNLTUVLWFNOdkxBN0hQcFFpL3JTcHNK?=
 =?utf-8?B?NUdiWEp6V241UUh2Z3RmbjQxL05zcVhqUXh2UnlkSm1wb3UrTXk0dWtGM1px?=
 =?utf-8?B?QzVnVU9YaGRDdE1iRHhrYUEvTTJsd0QrY29vZWtYK1FDT080RHc2UFFrV2ZN?=
 =?utf-8?B?VmhQbHlLbjdpc0xtNDdNYkdkQUZhMUsydlFmL2JMS2dDMHdQU1B2YWNxRERS?=
 =?utf-8?B?SHo0VEtSSTFBMnFXYzlndk8vNnJjeE1xNDZ2ZjBtUUIvelRhRC9iTnFOVWZt?=
 =?utf-8?B?RnVyMmdlMHErK2tSUnR6cWdEMWxzdlNwb3RMRmlRcklGakY2cWVSOElFbkZq?=
 =?utf-8?B?VjR4RE41djJ4WEsrMWpPQ0ZwRG5IZ2hJT2h4V2pyZktwWkMyWWttNXo1aGdZ?=
 =?utf-8?B?WG1Sdm1IN2sxcDI0R05panVtRS9XSVFvQmkyRVVTV2NGU1M3QzB2VUJFR25G?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	72pbHyggfDKQcVQnfU9KQhxAw3iNXuInWghxbpjWEWXc4AO6N5UWCDCucHmA4e938qOnBhhmTPAW6AqG8qNgF84O6kEY6pVRqlTRwY/08iNJYI3fb4uOUH6E5M2VCOg+lHKc/Y28dYrybuVsRnIh/eZguZxJdgLQDaSM3z7owz9+9FE5OMmg/yJKlE7NTpNuNqg0kyVyzg8BjGEDg16S54qg6Z377xZfbMjoxYW6zEEITP0Qw0Cl9bYbYNCZoR46jcdzyFgu+RVc4g1SoEeBG0ri2DvNiaffIaICUt+zgPyrJygJIUhCUU3/xS9CF0BKVYb/667Iz5IOkf0mpAMcJlpZmVo7fXp8tqPmKBdSrKpezZq7Z8KYTWaqnDp71sIZL85UPYVWb3GhlqcMvdMMbceZ3jgb/fv94kQqUWB2lGcfWr1nRzanXCTmtJRe8lGA5kphiVdPX2TMw4WCD+ZtqCZsJ0ZBRixJrcV0vjlhWdkOnZclbEhQeSMnKPtNp6Kf3t16ox5can97GLnpWx3jY32/EeNuQzEMF6aMmcq81zv/Nc67Jz8AJHlp4aqxEI8o+1F9gpdsD+d52WgSaAOAqJnH9O7EX+04+G1ozkYBUog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1028599e-7b92-4f1f-ed93-08dd75ddfa0d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:10:40.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Wrih/cj1SPT/A+dlRS5fob5ziZi9+asD4GjmY4EMnmnqhjD36gUOlbScMagYeOzzY9ei3Kf9mbvqwTmR65dZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070100
X-Proofpoint-ORIG-GUID: qs3xYMVmJP3rFgqMmPtz4e7OscxtQFf2
X-Proofpoint-GUID: qs3xYMVmJP3rFgqMmPtz4e7OscxtQFf2

On 4/5/25 4:19 AM, Greg KH wrote:
> On Sat, Apr 05, 2025 at 09:43:29AM +0200, Paul Menzel wrote:
>> Dear Greg,
>>
>>
>> Thank you for replying on a Saturday.
>>
>> Am 05.04.25 um 09:29 schrieb Greg KH:
>>> On Sat, Apr 05, 2025 at 08:32:13AM +0200, Paul Menzel wrote:
>>
>>>> Am 29.03.25 um 15:57 schrieb Chuck Lever:
>>>>> On 3/29/25 8:17 AM, Takashi Iwai wrote:
>>>>>> On Sun, 23 Feb 2025 09:53:10 +0100, Takashi Iwai wrote:
>>>>
>>>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>>>     https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>>
>>>>>>> Quoting from there:
>>>>>>> """
>>>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>>>> working with Scaling.
>>>>>>> ....
>>>>>>> I am using VSCode with:
>>>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>>>> """
>>>>>>>
>>>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>>>> to iterate simple_offset directories").
>>>>>>>
>>>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>>>> release is still affected, too.
>>>>>>>
>>>>>>> For now I have no concrete idea how the patch could break the behavior
>>>>>>> of a graphical application like the above.  Let us know if you need
>>>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>>>
>>>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>>
>>>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>
>>>>>> After all, this seems to be a bug in Chrome and its variant, which was
>>>>>> surfaced by the kernel commit above: as the commit changes the
>>>>>> directory enumeration, it also changed the list order returned from
>>>>>> libdrm drmGetDevices2(), and it screwed up the application that worked
>>>>>> casually beforehand.  That said, the bug itself has been already
>>>>>> present.  The Chrome upstream tracker:
>>>>>>     https://issuetracker.google.com/issues/396434686
>>>>>>
>>>>>> #regzbot invalid: problem has always existed on Chrome and related code
>>>>
>>>>> Thank you very much for your report and for chasing this to conclusion.
>>>> Doesn’t marking this an invalid contradict Linux’ no regression policy to
>>>> never break user space, so users can always update the Linux kernel?
>>>> Shouldn’t this commit still be reverted, and another way be found keeping
>>>> the old ordering?
>>>>
>>>> Greg, Sasha, in stable/linux-6.13.y the two commits below would need to be
>>>> reverted:
>>>>
>>>> 180c7e44a18bbd7db89dfd7e7b58d920c44db0ca
>>>> d9da7a68a24518e93686d7ae48937187a80944ea
>>>>
>>>> For stable/linux-6.12.y:
>>>>
>>>> 176d0333aae43bd0b6d116b1ff4b91e9a15f88ef
>>>> 639b40424d17d9eb1d826d047ab871fe37897e76
>>>
>>> Unless the changes are also reverted in Linus's tree, we'll be keeping
>>> these in.  Please work with the maintainers to resolve this in mainline
>>> and we will be glad to mirror that in the stable trees as well.
>>
>> Commit b9b588f22a0c (libfs: Use d_children list to iterate simple_offset
>> directories) does not have a Fixes: tag or Cc: stable@vger.kernel.org. I do
>> not understand, why it was applied to the stable series at all [1], and
>> cannot be reverted when it breaks userspace?
> 
> The maintainers asked for it to be applied as it fixed reported
> problems, please see the mailing list archives for details.
> 
> Note, I have submitted a revert for this already, see:
> 	https://lore.kernel.org/r/2025022644-blinked-broadness-c810@gregkh
> as I too think this should be fixed as it caused problems, but the
> maintainers involved decided otherwise, please see that thread for
> details.

Greg, thank you for your patience on this issue.

My aim was to address the CVE specifically in v6.6, and I think I didn't
understand that the stable process requires that the upstream patch
needed to be applied to later LTS kernels as well.

Thus I labeled commit b9b588f22a0c inappropriately. It should have had a
Fixes: tag and "Cc: stable", even though LTS v6.12 and v6.13 were not my
immediate priority.

I will try to be better next time.


-- 
Chuck Lever

