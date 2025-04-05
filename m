Return-Path: <linux-fsdevel+bounces-45811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C0A7CA39
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0401D3B96B3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CAB15B115;
	Sat,  5 Apr 2025 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQ3jZdU7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ptZpmgWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD82C9D;
	Sat,  5 Apr 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743870333; cv=fail; b=bf1JHTBKMjTlaJzafgiEsbouBhS95xunuo+2+jlEcyDxxBURg9PIvdnQBi0FpK1nAwMb9kHO+DcI96bMoVIV9LOKFmrr8QEh2N3tA3+UAcvx+YL3G2qbrLdV+zPeg3KALSdLqwNYA98SzRN2OWs0molEK7tup1Tj0smc0pei5gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743870333; c=relaxed/simple;
	bh=BQ2VcmFne0XX+XnH8tUAZ2t9vCKzYex3VM8XRQ5pZIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tB/9kcJ737DuMcvWJrxlIPdtltuJ1Xtfxy1EZeLiOUV+LZnjDy4yctZSvjL1TmTR9d6xQkOjWo9emzLIGRQ3Jq8nG+CQDzdZKApx2uSx7IQX50V/HAXtchniXiusqOCLKZPpcUIyuCAwWGRJbMsjFcaQcqhNMXEqQz7g/rTqouY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQ3jZdU7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ptZpmgWk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 535FdIKu005354;
	Sat, 5 Apr 2025 16:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wpShalmiHTInSej8zOr+SXr/GE43OnevcjDH54gJdC8=; b=
	ZQ3jZdU7Fx7DLckGHmHy2Fnc5UH1UuKFckDReJgczq2nT5eXLLXA8GOwBePTVYy/
	KNJ9qVrgoeRBurHw/Cgf95Z8T3xi3hhF3XsBCVEoR5tO2WFclyO7LsYsNQO5AhjN
	L7bH1NQHlgxQZ8L/TxlkpOR+TgUysLgGMiEAKGTr0Fp1L6x/fwG495We4mWF0cWK
	glvS/9LPkc74YJkhlFo2w7jgzrvja/3/J7pUshOiHS5Xty8hDWi3pvlJP7FT3GLG
	8Cz//pQ/LHMk8rwW10LVNPdJ6Qn9+iNJpSYb8UrDheMMjKQYJu1cnOGCQzY7swXO
	Fm+JUOB6qtpSP+MHKm1T8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4srd2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Apr 2025 16:25:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 535ER1Bb022146;
	Sat, 5 Apr 2025 16:25:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty6y2mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Apr 2025 16:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7yJn42Pzzt4KRuKabYtHC1YB+me5YrZGs2SEJN6EqwbRYtGP8xPIqa3YUhtHBc0bnc2DKY03D7UCZ5jgCndUWTQTSRMqRYRYgKmdyB+bl5vtu1lbiCQAhmNgzsQScHOsJlWL4jiuh7iYfAUIa5O+stI5rrUChr24IcAbA06mb4fwlvdtNK3vXKPuScLxqLsi33cljrpf3GsOe7P6XcCF7vIVB0VkLV5QXXJHdJ8jQpfei4+QjRrtEDZl05DzichOYV+a8LlMBTLUBSkT7HRe9VrlDNDH1Ccz4JRQte84c7Hkxbq8luoquq9GNyr3Abqw4nsb5haXhPAcYlqfzAU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpShalmiHTInSej8zOr+SXr/GE43OnevcjDH54gJdC8=;
 b=bltZMaDxSF0ZjPJyiMkdJzLAEW1KDJQiILHeeGxY4dzl3r4J0BuNo0oUCOJD+SPixDEDZ2opiulcsRHQ+HGGHTB9AU0DckP9BrW2z/ZkDLjc3wfhqMSZQN2yKDB1mbRhIG9CrBFgnGBwE6VahV7HgFTNcq7g4A5JXiGDwS4GGPgXTW16e8cjtifvCdBoGlP+ysD7JEZ/kxexMW5Ww8/BIExOFt9AVynxwqwHbbUTBpViWNZmQ0iqmG554TzE9XTQrS7G7UpIwRowmLKAE+fffY2b4kBW1YoVKIltyyWoV4B8HrTrCKrIy4wEfkLSyJCQQAoPGEjM2JveaC52ausPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpShalmiHTInSej8zOr+SXr/GE43OnevcjDH54gJdC8=;
 b=ptZpmgWkF47DjL2GRqq0CiwKL7O8BdPQNsNpolJfxJh1MYq4nW061hxcOw0nTd/AxYeTFUfKVhIhWQmoh/FvJAp++AH+eH80lKCWrKNcJYT3IUg0E1JzxfPQBF/fSt8nQWMt0mnD5Mhj50xVGXhPrDwm4tawfnfBuTQRdQ9fN34=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Sat, 5 Apr
 2025 16:25:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8606.028; Sat, 5 Apr 2025
 16:25:02 +0000
Message-ID: <57eec58a-6aae-4958-996d-2785da985f04@oracle.com>
Date: Sat, 5 Apr 2025 12:25:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <874j0lvy89.wl-tiwai@suse.de> <87wmc83uaf.wl-tiwai@suse.de>
 <445aeb83-5d84-4b4b-8d87-e7f17c97e6bf@oracle.com>
 <16e0466d-1f16-4e9a-9799-4c01bd2bb005@molgen.mpg.de>
 <2025040551-catatonic-reflex-2ebf@gregkh>
 <417f41b3-b343-46ca-9efe-fa815e85bdd3@molgen.mpg.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <417f41b3-b343-46ca-9efe-fa815e85bdd3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd8de3f-8160-4069-97cc-08dd745e6ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0d2ZlV3VjVIc25JbVNkZ1BJT1BPbVVUc3NKM0RIakRMOWNEWjlVTnM5NzhZ?=
 =?utf-8?B?cXUwRmJsaHVwUDdwb2tUcVAyQ3J6ZFVwT1hJT0tsZjNtVkg1R0tVamNzTUNw?=
 =?utf-8?B?NnBmeFR1WDRxT3U1OVoyTVRrL1V2emtySWR0VHZVMTYwNmxVVjBpUVZpa3Yy?=
 =?utf-8?B?ejdJWDF4MEtFWTBhT0h2cXVBRWFRVXhKS1g2NWlEeUpWVG10TnkxeTlMQXFx?=
 =?utf-8?B?ay9iTzJmYm5aSUdaeUovOEYwLzF2ZGYxZDJkb3pObGlMSDFtL29sOFhuOWw4?=
 =?utf-8?B?RWsrYVRLU2tjejhsRWpRZ2tqMGdJQU4wVFlhYm43c2hHRS9sdnIzNE14QkFw?=
 =?utf-8?B?cnJWRVRUNUVtZHFYQ0d2Q3drc0grV1hRNGN2ZEJrRG9ORys4Ums0c1NqWlpH?=
 =?utf-8?B?MUpUZTk4RGVzQVR4eGcvZmk0UFA5aWpFOTlpYWo5QUtGTGNDaUdkenZobzF6?=
 =?utf-8?B?ZDgwRnRQR3JncHc3cTRwcE1lemkzcE5CZyt4ajBHUUNGNVlQcnBOWHJ6d21j?=
 =?utf-8?B?azZlRWFoUDZiMnNoTkpPR3NRc2FDTDc0OWdPUVQzc1RkSG5LNWpIbFd1cTZZ?=
 =?utf-8?B?RnJtYk0zOXdralFCMFoyNGNqMU5rczh1MVQ4NHcya3puVUFiOW5lMkNBUVlS?=
 =?utf-8?B?MzIvT043M0YyQ0I3OFdOeCtKam4rREJxRTY3aGlaOFIvTVJoNXMxY1ZaQlZs?=
 =?utf-8?B?TFVhekEwZ05hODZWcmZTWUtkdGhmRkpIUmsrRlRnRmIwdHlzenpvWVZDU2ZT?=
 =?utf-8?B?Njd2VFJMRkZqYnVmSWNyd0NQTUlnaFU3NU5ORm9oUU9oSGZxZUhzd3VBMWxq?=
 =?utf-8?B?c0hsNko2Tm5DQU93RUl4aVBiQi9iRkpvYUFSVHljbkxhSWFhSTZtcmN4aTRI?=
 =?utf-8?B?Vjl5WGtJQW51b3NhQ3QvQVVHS3BOMWYzTDFvYSszVmczWXpwaTVnSmU3SnFO?=
 =?utf-8?B?TVVHazlRWjRJUTkxNFZmNXZUZU9iWmV2ankvZ1E4d0t0cjVCZ0FzOEpveHk2?=
 =?utf-8?B?c3YxU3RJdW9NTkJ2Z3N2RVp1bHhGZzV2NXZBcGdlZFVYZzE2aGt0b2NOVzQ4?=
 =?utf-8?B?VnJRVU9OVG9lSFVlNnN6ekF5VXlpRksxZVhaYVBNRnNOTnNMTmtLdDcwL0ZE?=
 =?utf-8?B?S1pRK1VFY0tMUStRaXNRTDg1dDZpN2cxM2RSZHFqOVg5bUZYcENHY0VqdXZz?=
 =?utf-8?B?R0ROQlluMzNhZmNoYUZBSHRMeGVrbHdVaDhmSVJPemFCN2tXME1LZ25samE2?=
 =?utf-8?B?S2k4bTZnckJxZjlQSU1MSllDMTZDbDNTT3ZSWXNaMmNDN0l6RHBMa0ZyMHRk?=
 =?utf-8?B?Mlk1L0N1VnIvNm9jL1VXQVpOOWduakhEOFNmdEp6TW9kbGZjMEZ5QmxQWkpr?=
 =?utf-8?B?MmpuRDVhbFkram0vcFNPbmZiTVJ3NW92T2dYQzVFZmNOaXBFLzVReUVtd1Jn?=
 =?utf-8?B?NTFqSitkZk1ObTB1MXJxSUl3QWZySFBIMjlYREtYZlhjUnVJMDZXWStCWTlW?=
 =?utf-8?B?N2dnUGZBa1BzMVdGRE0wL1lKeWluR1JLcW9ES3NVcm9EWWF6Q2RyMjB6cXNR?=
 =?utf-8?B?ak5RRW51dVpPRFF4dXFkUy8vQzlvaDM0NnpkVHFpY0hKYlZWSENNUzJVZmJj?=
 =?utf-8?B?U1B2K09NTEpTSzMyVDNjK3FsaGJQQjEwNnNUaEgyc2NkalVhVGM1aUErYktq?=
 =?utf-8?B?OFh5ZTJDTDlJNW80Ly9WQUJzYVpkSjBpNDdhUmVxZEdRK0tYcmdDYlVaeWxv?=
 =?utf-8?B?Y2tnRUpyT2JMWEVUUVlqWjJER2VlK1hXQStEUVBwbE1HQm50THozWmtPVUJH?=
 =?utf-8?B?dmQrRmxzZFFGRUx1U2lGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2h6TnVCRFFkZnVJc0xzVkJSUkFvMjlBMUtFY09xc2c5Rm9LOW5kQzF5Z1dq?=
 =?utf-8?B?TTltRGZzYzhjWkNTVXdsclZBY21paHNFS3dhOFdrRGpUUXFDcFFzSXdwcWhK?=
 =?utf-8?B?VjNMQWt4ZUEzVi9sSDcvYlVYZW1nb1J4aHh1eFJWNjdUaW96Ukh2b0pDd1B3?=
 =?utf-8?B?c0JydFhQZGwvRjVkUHd6clJXa2JWY0wwQ2l0cWdIUGVuS2dIakg4RUhzRnhr?=
 =?utf-8?B?UG5iL05rVzdPVjY0WHhScDNrTzB5QkRlNG16d2Y3OTNQcTVhYWY5aTVRa3hy?=
 =?utf-8?B?K3Q2ejN2WnlQRGxZdzIyR1gzS3FrdGpxTG9SRnZWNzRGeW5BNUFVcDFkTzRY?=
 =?utf-8?B?Qmh2QU4vMGRFSXRlMHBqZmRFTXNYNXZIOE0xZTBUajhnLzRDdlZvTnlYWGNM?=
 =?utf-8?B?cXN3cjVidERvT3liL0pnbURWWXI1V3MyOFlNQzk0aTB3RlVtK05mL3E3TExn?=
 =?utf-8?B?dzllVGllcUNXK2EyeUF6U2FCV3hmc1ZMSkh3ZlE3OHFEZDY5ZGRSQ3plY3Z5?=
 =?utf-8?B?c3luM1FsS3IwbFFWeVRKdXg4dFRxamJqSWRrT3dHeEl5WlRISG1ZU2k2SVlI?=
 =?utf-8?B?VHFBRUt6L2NaNTN6RzR6aXhWTFFQUndxeFErM09Jck8rbU94ZXJWaFFISjVL?=
 =?utf-8?B?WGVHTi84cnpVSGhBQXM4bzJhRGlmYWpsSWNDbloybDlyd0IyL1AvWFNocnpM?=
 =?utf-8?B?Nkl2SmF4eDlQQWtVWjc4UGRjeXppcjBFY1FoUm52T0ZrbFgrdGpYVGlCeHRV?=
 =?utf-8?B?Z1VXSDAxbCtmN3NUZzUyU2s3ZXFDQWtjc2RrN2QxZmNZdUdZQzd6dXRtemE1?=
 =?utf-8?B?ZWVXV2ZpN0gvdEVKVlpXMDIvaUh2Tmc2VWhPWE8xNmhBTU4rRWw5SU1ESkVy?=
 =?utf-8?B?anFINDd1emVlM3ZYUWozY2lLdTlEa2RJck95eElDSmtyd0ZodzA2dnBJY3hU?=
 =?utf-8?B?alM2NS9hdjByM1NpODd3Y3pWNmtBcEMwbm1NZTZ4Wk1CYzJhbmxCRkQwcVNx?=
 =?utf-8?B?RVdnY2RsaTJBTGs3cENTWW1lV25sM1Q1YWJUZUt1cGtOdVhWUVBMODlRYkpH?=
 =?utf-8?B?UlY5ZHFCeW5CWmI0UFhndmQrUGlzNTZaRjJoUWVEU01VVUtNOFNsb25uSnJD?=
 =?utf-8?B?ZXhVRGJ2NHhjdGhTbi9pYkgzTGlnRm5tSi9RWS9jSnFTMUhNRUhsSEVsSXU1?=
 =?utf-8?B?aXd4aDdGRDBpMUR5RUU3TnhkK0VKTlZnOHM2dWVwRTZYMFZHcmxnN3R1cnhJ?=
 =?utf-8?B?aHJ0NitxdWdjT1UvdStteVJkMEFmTkxvNUZ3eFVlckpTdHZaVDJxdDJHdFNP?=
 =?utf-8?B?NDd6WS9seU1BMTJzWEFYZ052ZUloVCtmcys3dllFdTRWckNRbHpwdXlqcitB?=
 =?utf-8?B?SVZuQkdFQnFlY1NmTEd4NTJUb3pTbWNwWXJydGdDYXBoZldKMjkrSGc5ZVpQ?=
 =?utf-8?B?SXlsUHFZdlJyamovdkhhMW10RGFLQURJY2VVQloyRHJUTGk3U0owQVBPYmlp?=
 =?utf-8?B?N3k1NVFrNGRic2s1UkZzelUreWxVdEp3M3BEVDZYQjcrQXNaeEY5ZGo3bDBZ?=
 =?utf-8?B?YzVHNFBYN1MzUVlUZGZvZktvMjFCeE80UlFHVVowUEhFbDcxRy8yNjNmd0NN?=
 =?utf-8?B?M0FTTWhDNXB5QzdyMEtRdy9laldBR010K09qRzFkbzdWaUhXNSt4bGJuM3I3?=
 =?utf-8?B?b0RQWkdNd2ZDVC96V2NBeFFNMGJ5R2FNVjlCNDQ2RHgwcjBXYnM3byttenVh?=
 =?utf-8?B?WFNmWEZJK1huY0VsZEZZZXNYQ0lYRVhmNVg1d0JKbkVHblFhaTJOZmg1RU93?=
 =?utf-8?B?VnptSHBzYlMyUXdSeERLdEtFcVc0U09NTllsUFBXWXJ2RlZxMEhwNGtyTEhJ?=
 =?utf-8?B?amVBTEN3T2l1cTRYc092RlBWTktiNVFaaHpHYTB3a1JnZFNHby9HS1RQU0Zw?=
 =?utf-8?B?TGlrcDYvRVFrRmYrNHArbStxS2JtbitBZ0VHWnZMTHNZdk5tYzZrUk5mZ1hr?=
 =?utf-8?B?aWNJanJkOUdaaGlQaUkweFRwM1FhclI5Qm1ta2RJN2sxUEk3VjRvajBENnFn?=
 =?utf-8?B?S3pFSFRETnNBZGxaZ2NFSjhNRG1CRkpBdzJLa0FYQ1JqckFpV3V1RzhGKyti?=
 =?utf-8?Q?hnfiLMgEDDn0f0ArsTUepffQ+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oDNabEXqn9FKXMVzdtuBHbzsdAuJTgobsmM41OyeQ56M7CL4YBRC+9qQ+HbpztpysWBfGrqoLuNHyXfyMvspPqGGmXQlXCrJTlQbAtsSEzzVRC8L1s9b3mQBojgp9JrJKEGB/TxjYOBwKmZsDi8KeZNqaTwIzegac7ES+lHLCkoCQ9j/5lPNAC6zxuzXwG5aLlhIiyneNuolyhr7adZpI8YyKNOc3L/HOq8CQo2jH/SOYiyUICn0Hv1mHSwJuvP/uHUFRlws8cRq4a4kXu0wjQQka4TtXpaZql/r39ZXtyo431Z2M0+K8fqkVOxNJtUv4nMDbqF05WOLDPGiylImRDeXnocsSFA0JK1vzztozCSxvTbdnKWf9EBZ/lh0LWzL9RI6WpDHt6erxb9cqTjxkcxtLzfnAr+F1ZDCM0EnJMDWaG8YtbWIEVGrsSERqP1Q7CgQjSFtgZuhUB1kHE9S/ciCurIFU0MVRIGaQtlhCocF5xg9tnfMiSJ+tc6ZnwqDMRL8ITwU2ck4P+HYkav80qe1gqG2IffLCiZl1IHx972oXThDqHZg994dCUSK6kNpWCeCx9eCh9h2IMgYcd1WjPbt/5UJ0QxgOpBnqViZmoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd8de3f-8160-4069-97cc-08dd745e6ad7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 16:25:02.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIKAWRJSpPhcvAxaauQ0hLmQe4O0FV+p9p62JV4RJjVwjealceBT/Oe++sdKmdJ0WEm7KXuzaUdNKa3dgavfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_07,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504050105
X-Proofpoint-ORIG-GUID: c4BSkImZ3bBh-eJH355-bnr49EJZwe-U
X-Proofpoint-GUID: c4BSkImZ3bBh-eJH355-bnr49EJZwe-U

On 4/5/25 3:43 AM, Paul Menzel wrote:
> Dear Greg,
> 
> 
> Thank you for replying on a Saturday.
> 
> Am 05.04.25 um 09:29 schrieb Greg KH:
>> On Sat, Apr 05, 2025 at 08:32:13AM +0200, Paul Menzel wrote:
> 
>>> Am 29.03.25 um 15:57 schrieb Chuck Lever:
>>>> On 3/29/25 8:17 AM, Takashi Iwai wrote:
>>>>> On Sun, 23 Feb 2025 09:53:10 +0100, Takashi Iwai wrote:
>>>
>>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped
>>>>>> working
>>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>>     https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>
>>>>>> Quoting from there:
>>>>>> """
>>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>>> working with Scaling.
>>>>>> ....
>>>>>> I am using VSCode with:
>>>>>> `--enable-features=UseOzonePlatform --enable-
>>>>>> features=WaylandWindowDecorations --ozone-platform-hint=auto` and
>>>>>> for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>>> """
>>>>>>
>>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>>> to iterate simple_offset directories").
>>>>>>
>>>>>> Indeed, the revert of this patch on the latest 6.13.4 was
>>>>>> confirmed to
>>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>>> release is still affected, too.
>>>>>>
>>>>>> For now I have no concrete idea how the patch could break the
>>>>>> behavior
>>>>>> of a graphical application like the above.  Let us know if you need
>>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>>
>>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>
>>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>
>>>>> After all, this seems to be a bug in Chrome and its variant, which was
>>>>> surfaced by the kernel commit above: as the commit changes the
>>>>> directory enumeration, it also changed the list order returned from
>>>>> libdrm drmGetDevices2(), and it screwed up the application that worked
>>>>> casually beforehand.  That said, the bug itself has been already
>>>>> present.  The Chrome upstream tracker:
>>>>>     https://issuetracker.google.com/issues/396434686
>>>>>
>>>>> #regzbot invalid: problem has always existed on Chrome and related
>>>>> code
>>>
>>>> Thank you very much for your report and for chasing this to conclusion.
>>> Doesn’t marking this an invalid contradict Linux’ no regression
>>> policy to
>>> never break user space, so users can always update the Linux kernel?
>>> Shouldn’t this commit still be reverted, and another way be found
>>> keeping
>>> the old ordering?
>>>
>>> Greg, Sasha, in stable/linux-6.13.y the two commits below would need
>>> to be
>>> reverted:
>>>
>>> 180c7e44a18bbd7db89dfd7e7b58d920c44db0ca
>>> d9da7a68a24518e93686d7ae48937187a80944ea
>>>
>>> For stable/linux-6.12.y:
>>>
>>> 176d0333aae43bd0b6d116b1ff4b91e9a15f88ef
>>> 639b40424d17d9eb1d826d047ab871fe37897e76
>>
>> Unless the changes are also reverted in Linus's tree, we'll be keeping
>> these in.  Please work with the maintainers to resolve this in mainline
>> and we will be glad to mirror that in the stable trees as well.
> 
> Commit b9b588f22a0c (libfs: Use d_children list to iterate simple_offset
> directories) does not have a Fixes: tag or Cc: stable@vger.kernel.org. I
> do not understand, why it was applied to the stable series at all [1],
> and cannot be reverted when it breaks userspace?
I NACK'd the upstream revert because I expected an RCA before 6.14
final (that didn't happen), and the Chrome issue was the only reported
problem and it was specific to a particular hardware configuration and
the /latest developer release/ of Chrome. Neither v6.14.0 nor a Chrome
developer release are going to be put in front of users who do not
expect to encounter issues.

Note that the libfs series addresses several issues. Commit b9b588f22a0c
itself addresses CVE-2024-46701 [1] (in v6.6). I did not add a "Cc:
stable" for commit b9b588f22a0c because it cannot be cherry picked to
apply to v6.6, it has to be manually adjusted to apply.

The final RCA reported in [2] shows that there is nothing incorrect
about b9b588f22a0c.

In addition, the next Chrome release will carry a fix for the clearly
incorrect library behavior -- applications cannot depend on the order
of directory entry iteration, because that can change arbitrarily, and
not just because of file system implementation quirks. You will note
that even after sorting the directory entries, the library still had
problems discovering the accelerated graphics device.

Reverting now might follow the letter of the rule about "no regressions"
but IMHO moving forward from here seems to me to be the more
constructive approach.


-- 
Chuck Lever

[1] https://nvd.nist.gov/vuln/detail/CVE-2024-46701
[2] https://issuetracker.google.com/issues/396434686?pli=1

