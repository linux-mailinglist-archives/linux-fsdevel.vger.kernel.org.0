Return-Path: <linux-fsdevel+bounces-37560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514539F3CAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC75316CD3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C01DA305;
	Mon, 16 Dec 2024 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="tCUW5+JR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E51D8E12
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383966; cv=fail; b=bIFwzYl5+sDeINmEgOjbfNE7HKB+FxDanDOzcng2PIijcf5sf9VabrT49W3sNX8JRn9L2ip23AI3fiUfYbTKyktkIUiifQmYVfyTL1SfTm74BxnaWN3z0E8YH2kvB/xE78yz8SPeMIZQU1juwZCurKjd0xNWOXSzxp28GNGz6Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383966; c=relaxed/simple;
	bh=GyNdvvPh4J5fjl/bp1kl9t8ruTXo4OQUv16Xq2sNd4Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XxeJ7n1y1fTGsRi1eNzi1/lWx3hfuz3mZsOEC2vwaxS8IJ8nI4WGfTwPREdIp0j9ntmR/t4JnO9880Ypa1Pji5qLgk6vsr1G0SXkzeDvnrQ6e91MyWPDZ0WKS/3YsisMVnmpTSv4lE2EWCW41ltFAzWg07O+VwgE5xf046iiKtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=tCUW5+JR; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46]) by mx-outbound14-73.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Dec 2024 21:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkq8O/DbUg0ccQSmVTJpsKTwMM5+VhFA9x2LVmMM1oSFfPtdJzpiC1f4EO38St7tvWm9holuo8savDJcYqB7VdiFbsIp/QrUiP8eEpQ2ah9sNdt5kgGjXigt2KGN1lfBU9DYhnZpLuOL7dK7zsOE8O8YsSU5mXmxZ7/VZSKTI3sm971F4foTN58mk46RJJ9G+8WmI89tUxV7gz1XhQ1hg3HBcLawS/uSs+ZUCRgroYe87/lfMpGm0E7FAbuSckIUi9Sd6Af92c/Kj/jm6zYhnSH0AOyuEM30IFROVPgpfM79tbwXhctj7uVE0Ug9m9XCWEZzlF5/5g7IZGRysmPE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7+q22YwIVtWf3AsJAhvH8E5zxCCtim66rfl106GLos=;
 b=iZKpXc+Ova7yusl1jaGeZ2VWWo8bzlIckKjL+XKuDLoP0q+L/DvNFoT0CqBOiZGKsKBV1WAZW7xerg9pD+1gFYM0ZPom/4mFumuwrhBSIfI3qJvjU3ItOr3sqDAOsfQgvjDpH9t2vhRWe3a1tfFgBWyym/ed+cb11ieqia7meOwfJwWhNsPCQ88xNupJSBappOHHj/BsbhY0/UUX4dpR13dnyw1v/8rERTQ8QIz1Vey87rnIowT2qhpcXlalQpgAQHFALXPg4x7j5BoqvYI8G/dnofCnlzgZN65Frrsx9W/phuYCF8ccqRpZKa3A2Xdb6Lh5BPOw6T3XGmEq2Ya3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7+q22YwIVtWf3AsJAhvH8E5zxCCtim66rfl106GLos=;
 b=tCUW5+JRgdJAwDWxaA9SfLcnh+R6eXTMV37wVWUxYSHfDaCLdTarUcBPAObkIWJfaiA3aVneY6q6rvWVQ/i+r/xex1SnOhydElBPcm41p/SkZ/WXYFZkfWRsUF8XKFkKL1v/c4MV33jVKL4P4LiPIhV7tHXW01lrm1nYsyJONZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW4PR19MB5519.namprd19.prod.outlook.com (2603:10b6:303:186::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 21:19:16 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 21:19:16 +0000
Message-ID: <9af818a8-fa42-4694-aba8-e61c6806aee1@ddn.com>
Date: Mon, 16 Dec 2024 22:19:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>
References: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com>
 <20241213-fuse_name_max-limit-6-13-v2-2-39fec5253632@ddn.com>
 <60105613-b0d3-4345-b4c6-aef7f3b90e71@linux.alibaba.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <60105613-b0d3-4345-b4c6-aef7f3b90e71@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0269.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::17) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|MW4PR19MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: be3d4d63-c010-40c4-dbfe-08dd1e174b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWJKU2F3VFA4L0JQMm0zcC94T04vak9GV1I1N2ExQVREQ0dYZ3ZFaEpCMkpF?=
 =?utf-8?B?SHlXQzl1NURxWFJiY0kxdGRWTmdMdm1vN1B1d1IydUp3RWNaVEcxUEE3UUVC?=
 =?utf-8?B?Vlo3YmNROUV4aXJoak9TUHhLYnRJUjFEYnBkUFdVTjRDd3Nxdmw5aHo4ZTRI?=
 =?utf-8?B?L09XcmtGTlQvbmVrRWRmTGp6d0NNN0R2Vy9sZEZlQjhwdEVyM0xVZ2JjaVNz?=
 =?utf-8?B?SGY0aEFtcFpUL25HUDArajYyNzhURWdQdUU1Y1c5dUNLbmFhVlZ0VDdOam92?=
 =?utf-8?B?c2tpOGIxS21JbVU2Mm5GYk9ycTZLWEZmNjVRTzFLajRrc1hsdVV4ZE5Db2Qy?=
 =?utf-8?B?YkUzOHNUVkdFNUJCZ0d2b2U3cWM0aENCbkFEalJVSW1uNnRZbFdRN1JjVlpx?=
 =?utf-8?B?aXFiSTFtMUp1ZFBCVHBKZCs2dEp3MlQ2K2ZIM29zRTh1VEdXVW0vRE1OMGJG?=
 =?utf-8?B?d0I4Wk9YWFdQWFhXc1IwcTJXZjF1akVVMURsV0Jpbjd1S05IRk1aSGt5S0xS?=
 =?utf-8?B?TWJBU1JhWW9iY1doOEFUbk0yRXBIYTc5anB0S3QzZ1Z4dGFzSW1iYlJFYVFs?=
 =?utf-8?B?Mk5yd2l5Z2M1V1dUZnVKdEpHbm9OcXdmT21pWFZCQXJTUzdXTmluZFFlN2NU?=
 =?utf-8?B?UjQ0TGFEK29zY3ljYm9TRGtSdHF0Y3AwQUJUWVdLdUliZFFvL1pMTkpqNGJT?=
 =?utf-8?B?TGRhTWRwMTRqWnB2ci9yWEtrK25OVTBlZlYvak1jTGNvNkhLMExpc1BMTnJ3?=
 =?utf-8?B?cS82Mkozc3g5RndrUUtjK0M2SXh1eGlPTDFEZFpiTXc5NldUczFySEo2UXFX?=
 =?utf-8?B?MnhWY2p3aytIblYwUVcrcXJvNmkzZ0hrc0lERGZITmhQdnVRUWZMSk8zWFZn?=
 =?utf-8?B?OEttdGpKbVpGWDliYlM2VDdDczl5dVdyZmNGNVU3L3NOR3VKa0JmTkxyekZL?=
 =?utf-8?B?MjFBU1YxcFV2UmovdUdPaERqMmxRdE53cXg1djlIdm1DMjVyam54RElWVjlM?=
 =?utf-8?B?emZLemRPRktFNzlZckpOcllMdkNTeks4RzFIWmRtcmNCeDNoeWNoRmsyeWdL?=
 =?utf-8?B?RG1CN1B6TnZmeGJFdWtPUThtVmluSjdXTFUxbHZWd1RPREI2YTAzQVpUaEg3?=
 =?utf-8?B?blE3bjZ6elBPNlNLN2FlWkRxMmROaW1yd2pmeEN3a0JsdFJkRWpZOFE5N2kw?=
 =?utf-8?B?dDJxaGJzSkpnclF6M0xCZFRSV0VmOWp3ZkJNN3JTUHJEZGpRVEJENzluUWFX?=
 =?utf-8?B?VEk4OHlmZlpWQnJqTWRBMndLNmFRZWREVUk5ZnJraFdDcGFkUVc0cFNFU0VP?=
 =?utf-8?B?R0lnaFZScFh0T1RWMTRjT1lUb1dnbG5mQS9PL2FYbXUycFdWaUdvWWMvQ3Uv?=
 =?utf-8?B?ZEUwWGhGMmdQY2xxZlRMaGJWZjNaY1B5YjFHMTZEYkJKY2NmMDNWc204emlR?=
 =?utf-8?B?anhFT2pBckpTRUx3cG03ajJSampGVU5zQkhlSHJqYk9jN0xPR3hCK01xd1gv?=
 =?utf-8?B?V29HbWJURVhXQmdLYnRMZWQvVTc1dFFhWDVCSzROeEtPYjk3a1pzcUZydHRj?=
 =?utf-8?B?STI2clI4NE8vRGJOQ21wN1g2OW8zNXp1WWYwZUNURmlNeTlKeWhvZmVSc0ty?=
 =?utf-8?B?bUpJKzF2M29mY1pVYS84TFIrWGVmYzdQandkbnZFUnc2YUttdFhzbk5SZllj?=
 =?utf-8?B?Zkg2UWlOb0lPUnltSlZ2UWNUcDM4QTEwZFFTc3E3a29udWs1OStNWmtHVHVw?=
 =?utf-8?B?U01ic0JUd2Z2aGdEdERIYW4vWHo3QzlOSy8yWDYvRkFGUTRLdWlMN0Y1eDFW?=
 =?utf-8?B?Mm43TkVSOWZSeVdXUXIvR2pqazAybEN4ZG56ZmJyUmRUVE8zUkVzSDdpM2ZP?=
 =?utf-8?Q?WvHyqu222ZHEb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk1FRFFVNnFrR1F1c0lnN3ZXYVdLSTgxanZKK3ZqK3Q4TUd2cVZyaEJDSk5Q?=
 =?utf-8?B?NjNWTVUrZ2UzMnFDdUhHckZvcGpocUJrNnFRV1hwcjVjZzBTc0dZMzBXVzZP?=
 =?utf-8?B?NDhabGcrVWJuaFhjYTVnaTdnNk5hV0l4UThNT1pBeTFoVis0K3I1Z1ZIZC92?=
 =?utf-8?B?YWRlcDhVSlArWi9xeFhHUGJpb1lUZnRocm9Hakdab3JtWGozaEdLdFpNS2FH?=
 =?utf-8?B?LzhJa2lBN2d4MDJrelgwYjA3TjRrY0NkNktsaThlS1Y2a1U3ZVVxWk5qckN6?=
 =?utf-8?B?ZFFzdU5LMzZFVTVkU3BOWTFKa3B5R3AwOThDOHN3T00zRkcwaC9JS2l1NnJ2?=
 =?utf-8?B?bFhkNDFONEJJVktYd1Y0R3lkbHNsOGI5bzZNSy9pQlpsVXZDS2RSVmJvNVBs?=
 =?utf-8?B?N29DOHVVdjMxVjhOOXV2M0pOa1NZL2l2Q0kzYjBOaHdJN0pBSHNpdFdKVGtt?=
 =?utf-8?B?c21WQ2Y5SkZGQm5GcnNCOCtRU3hEVW1EN3B4OXNKNzVubllOSzZtUURkbE1U?=
 =?utf-8?B?cFZIWjRnTE5XODg4ZW5RK3VBVWV4SWpnK1h5WC84OXB1UkxsZGlVVU1hL1Nw?=
 =?utf-8?B?NHdzaG9nRFJTOE5kSlpBODhlQ0lUb09GK0lCaDdyUG96aTNpOTRvcklDaVBV?=
 =?utf-8?B?L3JWVlVKVkpwb3hWQmdFc3FBR2F0U3YyQm9zQ1VPMFdFVUdLQ01VaWMzYWx1?=
 =?utf-8?B?Vk5SYUlJTDFKR3EycjRBL3cwWEdZZEk2VXpwZVUvNldTc1dhWk1EK0RjMFN4?=
 =?utf-8?B?THg0cGtubzJCSHlJR081SThaK0Z5QWN0dmVjSWtEdm1KRkpoVVRrVjFOSXNT?=
 =?utf-8?B?eHU0K0JMMFhCd3k1ZUxFQnJBZWRNMkZiSm5aNW5qdllrUzdGZ2VCRkYvOXRx?=
 =?utf-8?B?SHFzT21qc0MxM2NxczlSd0R2NFZMMllLMUE2U3BBU1NDbkhSdThZdXUrMThQ?=
 =?utf-8?B?a2pYYWRRSHQzd2MrSmh1NitaQjBnV1dVbzdwalB0STRQVTdjZ3ljM0s0SEhD?=
 =?utf-8?B?d1RnbXR5RUNUVmVOM2NRR29KQkR3V2NObktLSzZJMFZQcmRuRWs0NW9RVjI4?=
 =?utf-8?B?MjJNcVkvTEUyZUlHODJTSGZoeGlhaFlmLzdGT3o3dU1JeTg3dlpreGJ5QjNv?=
 =?utf-8?B?cUR6T3RSRWZzMTZEWURSMmw0WU5zUkpCaDJUdnQ2ZmMvOWNoaFJnSFdhTEp3?=
 =?utf-8?B?TnNRclZuaitIZXF2b29acmJHVjRaeUhWS3AvSElWRWxzSUp4Lyt3R3FaaEhr?=
 =?utf-8?B?MzRuVFUrcUNVdjVWOUhzZnovK2NqZVg4R3M1SWVpd3BQWk5rQ2Yra1BsYlha?=
 =?utf-8?B?aEEvRzk0ZXhHZmtYazN4djdWckxjdGRjU2JvaHl1VlR3R1RZT1hDQWxEQS9u?=
 =?utf-8?B?LzYxMUNIbXlPUDlOakVvZUxhOU44R2lxUmIwTW10emNTSjdTZGQ1LzZaaVBC?=
 =?utf-8?B?QU1XUDlkdm1Lc0V1T0JDenIwNmJMbGNhK2RlTlVYbjVZY1cvZ2pJVWtwUUJq?=
 =?utf-8?B?V21XYUZhbEljZDgrR0ZWRENXRWoyUG5IUUt3bE5Tb3VuSU05TjVaOTdicmll?=
 =?utf-8?B?N05Cc2VWS0hPcDM3bmJtYUFpVzVSdExuaFl2NDViSG15RU54YzJlRGUyWEJi?=
 =?utf-8?B?dHJ1d0pRTmN2cjhPNWdyeHcwOEdmV3dLWXorOWZrcFBMU3pHcHRURjZjYTJ0?=
 =?utf-8?B?WDV3WEpsNE83Q0kxVW51NmU3MU92cmQ0RkRYeXgxSXlhUFlNZ0g2ZHVkbjVW?=
 =?utf-8?B?aWE3bHZpVW5kMThEbnZROGRXQUE4WHU5cURlbWJ5d2l0Y0VJYlRLbHBxM3pZ?=
 =?utf-8?B?OVZOdjdTeDVMVk1JUlNjdkxBUXZiV0gzYVZYZzBXU0ptQmVSNUhycGdueTg2?=
 =?utf-8?B?UWVpVUkycmRzbEpycmpmZXF1WG5KTU5oZnUvZC9aVlloUFFGMjJlQm54Rk9y?=
 =?utf-8?B?bXZiVDJlSTNiRGQ2VUdScTl4U3JJL2xad29JRWZ4aTU3dDNrOHJwL01QS2lY?=
 =?utf-8?B?aWoyYkZqSWxSeVRFazJvY25lakFpUWlJTVdFenNSLy9MZUZMSDVLTlVDUmFB?=
 =?utf-8?B?WUM2V2U2ekFZNm1qcHVBTmsyem5KZlhnRTFUU2JQMTA5VlBiTTNTdlZMY21F?=
 =?utf-8?B?SCs1VUVNcG5rL0c0b0Z1eVcwOHJacWdvSjhSdEUrWTdEM2pGWUxtZ3dXRkph?=
 =?utf-8?Q?jb4B14zCbVuc1Y48o/pqUKaxEGxunifuQMeQjclEmiFR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CSswnvf+tpH0kYAuSbgmjDk/2tPHj8jQSKTE7nIlNvSLOlv54Ibm55T7BJRM8SQAfcHTHXavjtqnXw1wx/wNlvXxYs0/WMW/J+5bLzYXrxBXA3gatMq7PvKFuRUMAW+kn3pf92c8rzfAWSOKWhAu8Bh35ZZSz8NV+6S1xaT7vIwEenCXMdqoI8ZakYFxQa5P96GnTKsAEmCxDf4HnZDtfswH5l1z7OTnLwbtegYggqqM3e6S6eCikpe01X5wN3ho+MVCss8oeN932BfsC37A4XRIV2aJ9unJbZhoZijCriFQV4cBRIdIhAlznqXF+ArtYtqiP7xPu1dYmpfHc5luFmwez67zeunA9Nczz4/iMx129E3ofv/vtNW0j2XTNo1v3o+PyrgrCWQdIl+yoWdBhQlklNYgBfF2WTdd5WapWrLpjNnbnf7o5Wt2po7FyNXEPuoLw7tHjviZ7G6hHZo8BVOs+Pn8hupEfbqakYjoCYlZp67Jq6tiOEo9TQJKOK6KoeJvqmxMDBmHIteJtpQGruwr6/53LJPU3CiKH1UWQGylW7WiacnHWbnuTYttFKw76jRfG/QSmwCBeFuh3aMm+xjv9YP1h8Sj5S0qNDZBtZEGpxkPNstkZOtR33zR0Gfeum01/Wo0yDOK9sX6a8if8A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3d4d63-c010-40c4-dbfe-08dd1e174b9a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:19:16.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3Ams/7Fx1TwN77rz98knQ9ICMeikAg37MmVT+nJ4XrPr2czyGgyz2sdpySymbb9lIrKqENDn4Wvx3kMFekAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5519
X-BESS-ID: 1734383958-103657-13372-29594-1
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.70.46
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGhmZAVgZQ0Mw4LSUx0TLZ0t
	Ai0SDJNNnCMDHZ0tjcMNkyydTM2NxCqTYWAISSLsBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261160 [from 
	cloudscan12-233.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 12/14/24 03:07, Jingbo Xu wrote:
> 
> 
> On 12/14/24 12:01 AM, Bernd Schubert wrote:
>> Our file system has a translation capability for S3-to-posix.
>> The current value of 1kiB is enough to cover S3 keys, but
>> does not allow encoding of %xx escape characters.
>> The limit is increased to (PATH_MAX - 1), as we need
>> 3 x 1024 and that is close to PATH_MAX (4kB) already.
>> -1 is used as the terminating null is not included in the
>> length calculation.
>>
>> Testing large file names was hard with libfuse/example file systems,
>> so I created a new memfs that does not have a 255 file name length
>> limitation.
>> https://github.com/libfuse/libfuse/pull/1077
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> 
> LGTM.
> 
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 

Thank you! I didn't add your reviewed-by yet, as I added some changes to
address Shachars concern about operations that need two hold two
file names, but fuse server might use FUSE_MIN_READ_BUFFER.


Thanks,
Bernd

