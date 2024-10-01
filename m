Return-Path: <linux-fsdevel+bounces-30437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E90498B682
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C92832F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05351BDABB;
	Tue,  1 Oct 2024 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TvRsHLRH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q6rqrPhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E22207A;
	Tue,  1 Oct 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769943; cv=fail; b=fHrYGGzAlC88PpdQgyunKs9FIVN1rhog/BkYPdlyeLkwvH7nPImGo/pKHUTTr7rcfhsFVv1Kvb8H/sKbraD3lbbGzsK7xIxLbCvJ7oozcQKqJwm4oPetcyiBx5IOLJsY5rMJcKAppi/CLJdoaowO83oIA15BnWmbFjUj2fpYZXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769943; c=relaxed/simple;
	bh=bGTLxTrxCPX83XwFCAC8A4i/3DZ5yrNk/JzX3JP0uTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qEP1Ol48SkR9dWML5GGAlswZ5A7oM+siRI4p0VEMwdaufsNxHu81WB0EvStk5/bAhDviAfFTDLHAlHld0J3L/9+2xZsOPW0wO4Ii5jm1vTX4xb+z0VDBnPIpArcKoOvBAi6RvBE+uuBzU+oRwekf7JkwNdNMTXz3BLO04wzPs7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TvRsHLRH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q6rqrPhf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911ta5t024350;
	Tue, 1 Oct 2024 08:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xEzJNQcTrZwbbh7jKLy5K/UrVhFUJGexObraRawYLxM=; b=
	TvRsHLRHgi87cqabVa1aCBbNsN9rBGKSJB3enyMzPalxJcZxxMqt8d1OpjsKm8q8
	NkgSi1eel6pss3TH0MESKXlFH38X2cbMepl9UWytfTX0yYTWOoptMiK8CmliTts5
	JJn4Ai7+1aQKawp5iwILlKCCaqLFvynvsQGFDVl03BCLhSM6lp0XINBegM1EdRb8
	diZbxWvmxShlFamYonlWFFIWvw5FGhyOP/nSCOXxDkPrbOi2TQKtWMp32IkBFJwg
	Urzli93I9jafb3AtNnOukiI/QlDWBsEXp0+lCOXF7ydAHowpN9a1bGxXcQHBDM5M
	DG7NZJXVugebxVVxxGe6Hw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1dkyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:05:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4916XNqD040534;
	Tue, 1 Oct 2024 08:05:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8876cd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n218gG9e+ro6jInjhbny0sbq0mVL7/XUUYtKLPud1AfEcKQKGrW9RyFRKS6/y3xoVzGdUM0+9fD1AKe69uNOrY+/GIoMre5kdVrGaF/UuMTXWepxjZYJG05QD4Vz19hpMYGUEV9LGM3GgCUMqGAXrnTeiOnnqDi2o7NSbU/AHw8QtfGBSia9NIkxgWIg/WR1PAR2uzHdNInjar+zcQLiWbIWt5y8nP4FV7kCJqJYL3+e6raf+AqdX9eaA18SyPIdjTwr/VaWcBiklzOEwFQPP7muGkwTfGcGfv1F+Mp7OM/m2f7BDKWYrvBOr88YvTeluPzzNWr9ark2+/Jv1/pb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEzJNQcTrZwbbh7jKLy5K/UrVhFUJGexObraRawYLxM=;
 b=uQtQOiKManuRv4eOcuNjSLLaEZ6y6LXDbethBpc513v4UyAu+qByt4puMTA2XygImobS0Qpl62J3PMmpoqeYXAfIDhL2MAMelSWV099eCqyDabF+NfWslT92R8WDcy1D+QpkaUREP1LfXXE+/uv3W92dA1q11r92ydhBkcmHv9RbCJOb9U30kOVBse2Qhb/dVovANbG7CAkh1DjKnCdOwsryQKXjTltzAKhAtgWYYBlAsNOMe/MPwHIMjD8v1NGFA4hoK0l1bcBsd3ODtMMkfDWkcfK41WY4qzNpwk6hQtYBDSSDeSzn8Q3L3lST8Ty9m/3CNKE69Wsr5ply85ONog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEzJNQcTrZwbbh7jKLy5K/UrVhFUJGexObraRawYLxM=;
 b=Q6rqrPhfpe6pmelHCsRCPkLwm30BGHW8uVvWJJWZ0Y+C810RAfmgYggGh1HHxeKBb70IHfPK66CC5nIehP7YmXVQ7p7BcoxMe32IKrj5RVV71ssjJkC4sAbYjZd1my/KND5ajYApqBFOV2Q4mFIg+5xKmGDwLgi17vuOT8FOvm8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 08:05:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Tue, 1 Oct 2024
 08:05:21 +0000
Message-ID: <b7c74954-f4f0-44b7-ac7a-87518f0808fa@oracle.com>
Date: Tue, 1 Oct 2024 09:05:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] fs: iomap: Atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        dchinner@redhat.com, hch@lst.de, cem@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-4-john.g.garry@oracle.com>
 <20240930155520.GM21853@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240930155520.GM21853@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddddd7a-1ebc-4103-4086-08dce1efcbee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em9PVGtvNHQwb1QybExmODkwR0psbUNBeEZuQXhFa1MvclNhY1VRNXBvODFO?=
 =?utf-8?B?TDhZdm1SNVhtL216cTVQWHRMd3JkL3Jhc2NyaTV0S0J2OVAva1R2ZHpkMXpL?=
 =?utf-8?B?Q2pkUkM0bk02OGVGZWZVYldNSjl1MDc5bTVlcUtEcGJyWkxEb0NqUkhWRjU3?=
 =?utf-8?B?K2tUaTBUQ3FEZi84Y1lGZE1mUDZsRGY2bW8vV0lTdGdkVWFhYVVwWEIySCtD?=
 =?utf-8?B?UzZOQmhNVmlpZDNhSENoZWdNS0dWQjFLNHp6YkJ0TG1yVGRwYy9aUDIrZkVs?=
 =?utf-8?B?VklhbWhDbzVKSTFVZXBUSGlCL2hVcmNsQm1Bczhua01lL2pWelA2VVVIL3oy?=
 =?utf-8?B?cU4xNko4dEg1aFUxemtBeEJLSlh4OEIrUHhmRHB0eXMxaWlyaUxNWlpoUXVC?=
 =?utf-8?B?REhuOWI0TGtqbzBWbVFHMlB3MnJMT0tFVW9GZWU3UGdIMGJUN3RqeU9kSWRK?=
 =?utf-8?B?MzZXTzhxcysxWWs4L3ZYWm9ka0lRRFJyRWk0a1lsWlNtT01UTUtWcTMxSDJO?=
 =?utf-8?B?NTdacnJDNHh0WGo4ZHVMMG1ZTDdKcVg2WkF0WEdsSFBUZDVmMnl4cjZoREY2?=
 =?utf-8?B?eEM5RENJZlB4aEtWN3lZSGY5M3dCdk82R3gremI4WU5aanIxNXNQaVMvRDMw?=
 =?utf-8?B?V1FhN0JRUXBJN3NoZTAvTEczdkJuWnBIUm9TU2UrQXVCcXlJNElabHhEbUFz?=
 =?utf-8?B?bVlNN3dwRGNUM1F5UEhGbUNDZWVPVFU5T25KUW51VFFvTjVVdm5ONzBGMjZN?=
 =?utf-8?B?V2oxd3F1eDhXeHFaTkwrOWhHbGRSSWdvaFhweDBrc2JRVmNHSlRFcC85c1Rp?=
 =?utf-8?B?a2FmbVlpOGZKQ3BJaE1rV0I4NUVodm8zMGlYUm1qaUFhUE9CTTJ1UFNJNmNN?=
 =?utf-8?B?N3prQUJEYXpGaWs1TDRVK1ZWTWxKOGVKZUZKbCt3R2twbk1oN1hQN0pOSTdF?=
 =?utf-8?B?bXpQMFhuZW4vQWFuMG8wcWE3MkRUbE1XeGhXU2U2UThQOTZHSWNIVk02YzV6?=
 =?utf-8?B?alhERE9lTnhCRjl0VTJ3UFNZODNMdXQyQnFiMENaQW9MWUtxOEl5MDVsWVJX?=
 =?utf-8?B?UjNmMUJpMlNUN3J0M20wU0t5eVE2VHNaY3c3TkU5YisxeFFES3hjSGZoUE9B?=
 =?utf-8?B?L1dSVElOZWc1eVBhNElYOFZROUxvZkhqbDRJWGNra1pMOTdVaFN6QVQyeVdW?=
 =?utf-8?B?dmE1ME5BbnBKcHYrMnVTbUk5b1BvQ2cyL2ZVK2txdmpMaThVSmlFS2JjcUFN?=
 =?utf-8?B?TEpIK0tobnBGNE1XbDVnM0tDQXNCbTk1VHR1WHUzMzFxL0c4ZjNPc3Q2TTJs?=
 =?utf-8?B?Qm9tTCszTGVGWDZrcGNlaU5aZ2hzM0RjWkphTEk2dlFKVmQyTjZZcTNCbExO?=
 =?utf-8?B?L3BmV3NsK1lVTjFDTFFNQjFFa3NPMlREbm5NYmJJeXNPK1hhY0hGVWFzenJL?=
 =?utf-8?B?emNzVGVVamJCUkd3UDlwVGs1bkFLZXRYdUVKRERXazhxWG1wa3FrQVNMZEx0?=
 =?utf-8?B?ckc2SnpiSUsvSHVDVXBWcUxjUkRyK0F1K0tzdUh0Q0pVdzNNWUJQQ1N3NXJO?=
 =?utf-8?B?TkU0NXM4cEthdktVUUdjdklGWEZ4YlhBZENHMkJMVVZaV1k2YnIyb1pVSGVT?=
 =?utf-8?B?NGlLaUMzWG9yMFduV0lwSGVXSFN2WU4rTTRnSXluaEhxUlRVSjdaeWFodnhr?=
 =?utf-8?B?TkJZeTEwVmxKUjJnaHVET3dCaG1ENExXR2pwd2UzR3lVVkZaWmFpRHJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Slp4dFlJMUF0ZFN1dHZJLzQ3TFk0OVArZmwwMmVzc1dDWCtZSXBNcEp1eDFr?=
 =?utf-8?B?Qyt4YXU3WVlJZWJKNG9LNlY2aStRNHhHM29US21SbjNNSEQ4Q0hiTjkwWXlB?=
 =?utf-8?B?NXJYSktpRjlaRzg0WDhrSHFEQnFPVHYwbTU3RFVpYWpoS09NWWgrUFRQRkts?=
 =?utf-8?B?UlRiUGlGLzdPbFg2YlFwYU1aTzZTeUpob01rQVV3NDBiNGRseDFQalFTKzMx?=
 =?utf-8?B?Z3NjNEM4c0dnSFZORVBuS0ltRCtyN3hBeGp6Z25VRGlMSmwyalA0QS9oenE3?=
 =?utf-8?B?SXNWUHhjMWRiRkhVTlQxaHRtOFFmL1FJNkcwRWRKZFovK1pwQ0h3SThDQ3pV?=
 =?utf-8?B?SmdRd3VrNGVPRW8zL3FvTlFKeUtXOEowakI3VFdNU2lJcUhqNU4ycnhxc1dQ?=
 =?utf-8?B?alZzRVVRR3dQZE5UdUxjcHdkL2NSR1NabmtIUnYySTcvWlV1b2Z3S0VxU09C?=
 =?utf-8?B?RXBmWlF4bzd6dG52bnJmQW50K0l1NEx0NmFtZzM4WmlDWWRaQkt0VlNZNUZ6?=
 =?utf-8?B?dXFnSDRCQkdjUWZlb2VsdU84OGRSZkRnYTZPbG92bEF2bmRlc2Roa3VMYUlQ?=
 =?utf-8?B?eHdRWWx6eVArcFlZOFoxTDU4SkYzYjB1bEpFTUtXQkt6eXV5ZW1LUUlDTGsr?=
 =?utf-8?B?TUhKc2x3b0JKTnpndDE4QWtFNU5PQjd1Q3M0dWswQ2R3ZjJjUWdBcnp5R3A0?=
 =?utf-8?B?ZWRHWUJvUjBkQUd4aGlCMjE3OTRzQ0tNbVJPSm9IU0JWM1ljU1FRQUFyaU9J?=
 =?utf-8?B?MWllK2tmcmFRNGZtY0RBbkRjbU9TWFRqZktVc3hFZGJ6Y3laS3BQbEpySUp3?=
 =?utf-8?B?ODNERjhqQXlCaDRYbG9BcHlwT0poZFV5NCtzRklNdGVNYUZtVUtRbHBuT3A1?=
 =?utf-8?B?VXdBTFFKeGJxdDFPSktpbzROSzBHcFVScUtOSE45bmo0NjBvVGlobEsrZzhU?=
 =?utf-8?B?WE9RSFNuVFZKRDFIZHpWc2VDRkhtYlFUbGtHRFRSYmUxWjY2RzNlbzdkMVVR?=
 =?utf-8?B?Y0tFaDM3TEU5ajNLZlgyVUtjTnp3WmlZT25VemsrSndFNjRwRjlCQTVlYXhO?=
 =?utf-8?B?R3dENVZhUVYvRVdjOHE3Yi9nWmJNTjhjNlpTcElud1E0MXAvaEE3bXQwcE1P?=
 =?utf-8?B?WmFod2dSck12R2lkRVZlM1pQOXNpeEg1RkkyMkZjb2o3eDRVM1hjUlR4aW94?=
 =?utf-8?B?bG5teTlCVk5laWxZV1JyZldtT29FT0FLM0IyN1hlQ25oR0I5bDM3OXcyaFJR?=
 =?utf-8?B?SXpRK2FWWjRmdnhQSFZVNG16ZlVKRk1ON2RVSlFDTzl2S1FQd2JVUTdpQzVL?=
 =?utf-8?B?MnZrejU5MUVTNm1QMGpGQ2ZHTFpUR3A1bW5RRVpHYWdkQWVtWmlNZ1ZING5y?=
 =?utf-8?B?Q0xBR3dtQjRiL1NQSUxESmFTMU05bS9OTTJreTlsb3FKa2Nzb1B5SzBqOS9x?=
 =?utf-8?B?WkhDbE1RTWRIL0hIdStYLzdKZm9oV0Y3RmtJSmhzTjU4RTJjc0VLOXNOQ05J?=
 =?utf-8?B?UVRxdTNiZ0NWNjRRTHJXdUxTckVldjB0Sit6cnIvYUJVTWt2SzN4bEhRN2lF?=
 =?utf-8?B?T1Y0MHFVRXdzTnVpalhYVnI3L2I1QzZpNGI4QzR2SUFpK0k4YW1FRXgxNU9I?=
 =?utf-8?B?eE1CR2U5ZW9kQXRBWGlvZkd2eTVaMGlObEF3YjhmTFBpL0UvRm9Tci9DVy9m?=
 =?utf-8?B?ZlZQNzNoWU50QjcvQzIvaUxtRjFMbzR3Q2pWRFJ0M0s4NDBmb2d4bUZGeEFz?=
 =?utf-8?B?emRXVWZCdCt6bzFrVW1UcG5ydXZocEdzR2xEbzlUUWI2aU9PUTRQRUIwa3ZL?=
 =?utf-8?B?OVVlUnl3YWI5V1UrN1NYZ0NPUUZJR1oyd1BpM0U1ejFqMlBwVFl0UzFGclBx?=
 =?utf-8?B?Vmdid0ZEVlRWdVk1TDFvb2QwVnY1MmVtR2Yva3QzS2JsR3NSclVCd0pkM2NI?=
 =?utf-8?B?TlRyV1FlTUhXVG9neTVHUUpWcVNDYWI4bmFtWTFWdHVLc0tjNm9DRDR4cWpn?=
 =?utf-8?B?MGhCSVFXVWFhTDhIWjhWM0hzbGM0NkhKS0QvblJ4NUtXOUFwaldjMTBURjZw?=
 =?utf-8?B?WW92MUNOU213TGFxTkRrcWF5NzV6UnBwNjZVWVJ6VnRhemlDTDhyY1hMOHlq?=
 =?utf-8?B?WHFRSDFIMjIvRFRPVUxueTVwcWY5ekpSM094T2NQd01vaEJHUkI2a3h6YUZk?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HfttlLG5TIFqEypR+4C+wgp1Qj8tA67KIOUgfJsD6qiKdRSRSqOLx9UaIjx90AgkAn5wAeJZnGFUujkSftZUc3fT38OejZZ3kUK4p9pcFroEGsIWMk1DkwW5XUqJnoa11goFxklxttyEBRqkkZTnmvee7WknVDzeztGS2rWCbO4mhc+4eSnuv22W4ofunJgcc4+nPFicRQ8XVQCicm9hLFvuJ0aPLQhcbQK8xaG6HoHa+HOOFG2/2sH4EN8pMz4mjpJwUYS5BVodkcdwDvlzqc5OXauR/u//Zk4nqhWCYbfH3VSLXBK8gS5hOBO5J3gtUYvWpFNHPWmJmd/C2m/AVqRzrla6BIBPDhP2yiFz9ES3L4+mPMVcjfqHY3fBNV36RjqL8BGrxhkE1V3tXfDeBFEzT69Wa6iDH2NiNB8ZXMidv9e+BanzluSLYyYIQGLsgGFhN0Q2QAJJYstdJcx+HLr6zL16t3HUcE13cRzRfaFaxESvXLPtrPOkco8eXh218dYADHA5Lsnfl+bA5lnm+ltoTCKPjfbrGxOm6zA4C3LWebhIhLePQ/blIJxDrIUO72VULIPgZ1atHPPKYwd586H1gSUtXpUIrfZCVyK1M6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddddd7a-1ebc-4103-4086-08dce1efcbee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:05:21.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6mZE26Cqvs8dxzqF3DAOZo6zK+yK1m5DgGCandh6+8wnUW8BI7jz50j0NN4+jESKQ+nP3q58dmYBPmuZ0RpHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_05,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010054
X-Proofpoint-ORIG-GUID: 2MBA1yzqrLU5ns92vtGiZKQ0mDYrQCld
X-Proofpoint-GUID: 2MBA1yzqrLU5ns92vtGiZKQ0mDYrQCld


> 
> This new flag needs a documentation update.  What do you think of this?
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 8e6c721d23301..279db993be7fa 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -513,6 +513,16 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>      if the mapping is unwritten and the filesystem cannot handle zeroing
>      the unaligned regions without exposing stale contents.
>   
> + * ``IOMAP_ATOMIC``: This write must be persisted in its entirety or
> +   not at all.
> +   The write must not be split into multiple I/O requests.
> +   The file range to write must be aligned to satisfy the requirements
> +   of both the filesystem and the underlying block device's atomic
> +   commit capabilities.
> +   If filesystem metadata updates are required (e.g. unwritten extent
> +   conversion or copy on write), all updates for the entire file range
> +   must be committed atomically as well.
> +
>   Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
>   calling this function.
>   

Sure, but I would make a couple of tweaks to the beginning:

  * ``IOMAP_ATOMIC``: This write is to be be issued with torn-write
    protection. Only a single bio can be created for the write, and the
    bio must not be split into multiple I/O requests, i.e. flag
    REQ_ATOMIC must be set.
    The file range to write must be aligned to satisfy the requirements
    of both the filesystem and the underlying block device's atomic
    commit capabilities.
    If filesystem metadata updates are required (e.g. unwritten extent
    conversion or copy on write), all updates for the entire file range
    must be committed atomically as well.

ok?

Thanks,
John



