Return-Path: <linux-fsdevel+bounces-77241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNMWL8tCkWmrgwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 04:51:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66413DF79
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 04:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DF23019920
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 03:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537EA220F49;
	Sun, 15 Feb 2026 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UipUvVJ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="If0r6D/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682E339A8;
	Sun, 15 Feb 2026 03:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771127486; cv=fail; b=of4vfL3KRWSqzc5l90nujDziAdaD5mY/M6yCXQAqQ2BVEcYvpwoHBLkpGT6Ty037N7XnEXYnF2lmw+4Rr3xkTCp+HXH62HHMwrCrImWiknfE/ER/gJOZiuMu/KF87W2Kn53Dy8Is58ptP+gFAo9n+1NjBjc63bkLT6Q0B6Ey8Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771127486; c=relaxed/simple;
	bh=UqAHG2AHuceDMhKTCQtRtDmdg8QFVYnmifFtCghreL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YUogVU5mVj//50o0MnF6Yk2xt/VmPSz69ZoKoMtDwu62U0y/EwY6w2Ec+lccNEtiXGeVcgtQi6qSdrcTgbIzauJe4VoYxLM26R3iK0NMCd0xupf02U11IbvUtwgK2/L+t24Mv1hFNGXq0MvdyThEcuT5nIRPCmr+jW1IVlw+fVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UipUvVJ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=If0r6D/6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61F2w4rY3957270;
	Sun, 15 Feb 2026 03:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Pz/WTGk/B5aCIeLosMLbMWuhXIeYgdkFBaH5yV7Wzjo=; b=
	UipUvVJ+mIexrfoZdVMv4zkQJf5tNsBI/8xN/iLhQFFVXXeMhNZ1q+3D8W6wyyIx
	NAQThIeml+kSPOIcb4Cx5RZnLKwyLOD1oL8KkPKlQpBlDGFArA9N1ux9l28tGUm6
	lBM8zhlS1wCpuZgv64V3v/5Vsskl8yiNMEGW+ryIKrvE2JaEBf1nzUbeTG+T4yZx
	vxZ5T1yXYi23COtoPrOZ3f36StJPsVx4vMSL6BOkohbhYbr16BpJEbb9dDPrNLQf
	bdvfD7jnXhtu8hmJmv6UwOaUhLcA+R4EWKo2HR0L6Q/jX8RVeFuwqMDhpE7YwaiX
	TYHLBZzUh7iDosjwjuUe8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj3t0n44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Feb 2026 03:51:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61F2rSDF022873;
	Sun, 15 Feb 2026 03:51:10 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cafg6yqnk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Feb 2026 03:51:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7YxOdaLLFyov8JdINtby+1pduTRWuGRelVWUGij/R6jNbiq1+aQnGfqv+RcuE6lOgt1MgZ04E2c3zn9PZkyXP3apDZwQSNtHk0jbMoMh6up2anTqnAKajEi+9JmCpsHWjrbwz19hziuzqdJVffRxXfvR6b46/52mw8FT7BluEoisPvuZK6z3NglvwHc2GMhWC6eBYYik1YY1aCtK00kwrbzrf1YBr7JVeRzlncRtlXQC6aeW3aq7h4GJuHQg4FkTcQ8VSUjymjoIoAG5326mN+xYcZcbz6i6vJrN9P59cDLFk2KKeWHq2NiPPGbb2HPowe1fS+OXRp8jx0Oe8iRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz/WTGk/B5aCIeLosMLbMWuhXIeYgdkFBaH5yV7Wzjo=;
 b=dy4bP+SfOuvp5sRrrpkbSeFSmfDIv0zCL82kwzUtHfc8oybsa6vNHSS5/3iKvaEXBrPa79z1u6E/zScE86P+ZVEg6VmdOknWDpJ7L8ucfJ6FLSMJb+x8R69uW5i4JKBhSbhCBFXzheH6k9dtP6jwe55XhFfCbViXcnwJwZjIABGLiTMAMQ9zwkOtMMqoZJRvq0rnbt9bMFZt2wkWHmLlaEHfCWN80W0PV4CJfgGnixNiYXFA8MxAzPm5p9hy/sXxMJZ06SHFDRrwCx6Qurun4NQaES+vc6Qji3Zgigk/JBh14AujESCtddm+cZTHIvr/7jycddWpdgCqaRqViMyITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz/WTGk/B5aCIeLosMLbMWuhXIeYgdkFBaH5yV7Wzjo=;
 b=If0r6D/6kUcL/ftoQzPlNbIkLwybm+kaFXYUpYczypuxy/kzOPWe0LsT8vw+8r22FPNZdt4aaI2f4GuIW2SPFyGQryUD/BhUlOWI8Lq6AGc0uOwTXFtQjxixkNFFxC+yOZ4TQujOxLxDJOpSAx6CkJCWA0mMGeYIIqW+fuXJbFw=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN0PR10MB5960.namprd10.prod.outlook.com (2603:10b6:208:3cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 03:51:04 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 03:51:04 +0000
Message-ID: <561ad2b4-6612-455f-8b47-c8bdc1fc6e04@oracle.com>
Date: Sat, 14 Feb 2026 19:51:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Chuck Lever <cel@kernel.org>, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20260213183647.4045478-1-dai.ngo@oracle.com>
 <177109154296.57968.985044750836996107.b4-ty@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <177109154296.57968.985044750836996107.b4-ty@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::28) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN0PR10MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad167d1-bc83-4694-43af-08de6c457110
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d2R3OFdjSTFkYjN0T29uMVNLWXlIbUtLSFFTVDNTbERxUVhBVi9zMTlDZTZv?=
 =?utf-8?B?V1lrM1dUVWQraVlQeDZ0VytFNVJRSE1ya245Z0E1czNBcjIwZ3JUejlZOGxi?=
 =?utf-8?B?ZWRhc0RQcTFzSzF6QWVhZHBINlUyMTgvMlZzdUczY3VvOWdtbDZRaEg0THRs?=
 =?utf-8?B?UmJIS0tGa2p4amdabDdlNHA5bkdtd1l0RXFqckZQREpBSDhaWEJjcVJCa0tk?=
 =?utf-8?B?ekhSMXFUa1ViSytsUjV2Q2ZzdWw3d2tZNWwrUzBlOFZxT3JYbnZLbnBYbVZs?=
 =?utf-8?B?TUZFd1p3MTJQSkZOL3cyOGowMWdwdytIR3BpK0MySDdlNlVPR0s3cVROVWs1?=
 =?utf-8?B?QXFYc1FrWksvdXFxRm9oT293U2VtR3pocjBiMnZxWlhoeFRJa1BGM0hXMitB?=
 =?utf-8?B?UW5kSXdvSmRPS3ZCTzlNYU1uSkdpdDk2V2ZLYVBpN1dZZXlncVB6TjR1OFl4?=
 =?utf-8?B?TExKSVQ0YUgzTXdLN1JGRmlnZmJqQTY2cGhhWlVtYTJXSjJ1amRKMkNwK09S?=
 =?utf-8?B?VGZVaEFaaTRzdHZyQndVWi9ZNmtQSk1ocnZoaldlSitOSEUvSjl5cUZIcDVU?=
 =?utf-8?B?TlFhR0VQOVVxSEtReUV1WDlCOStNVXJzVENPQkVJMElqQ245WXZ6VE9oVWcz?=
 =?utf-8?B?eTdLVWk5MHlib0dmUkxPd0lGUUlBWEV0UmVReUsvbmdaTVk5ZXVXWlcybFlD?=
 =?utf-8?B?dHZPQjZxOGF6Z3Avd0xUNmp2S2ZwOFBMdjRtQ1pYSlBtamNhQVBNa0JwN0Zv?=
 =?utf-8?B?RmxhSzdrWWJsc0UxSzcvTFFZd2lRWVBpOUo0QUdBdk5lZU9nNno0dXN2K1lj?=
 =?utf-8?B?dDZWQUo3TWlHYTBUbjdQemVWR3VseHJNbkRhMjF5MHJyOHFCeHhTNmFFWGow?=
 =?utf-8?B?bVVIR1VzaUJTUzEzdnZHOVRidGZUdlVDRjMvenplOS8zWG85aGFIRVNFNFVk?=
 =?utf-8?B?MzFCVWRBbjU5Mkx3OFBQUVg1R2ZjeGhyWGNOZVk0WUNiU1dxbnNTQ3pheGln?=
 =?utf-8?B?aU5hVEQ3Y1pQYTNoZXpxZzNEWWxmWmdONFFBY2FMUWdCamRmZUdUdmdZRVg4?=
 =?utf-8?B?UGxRd0xmN3laQmNhMFZJSGsyZTlPSWdoaTE2THd6TU9uN3FrSXBQb3J1dS9V?=
 =?utf-8?B?eFh0ZVNFbXMzRllBMGxvZHF0V1oydXo3YXlzOWVEci9vbHBqNTkrTU4xWVdk?=
 =?utf-8?B?blZsa2VRWFpraVFtR3dtM1czL283S0FyL3g4ZzRhOXZMUUdURC93ZTZHRUU1?=
 =?utf-8?B?c0NZZGx0M21lMUdabVlLcC9ac3p6YTk1Qkp2YTZMa0lYNXI4NnZ6bzFiZlcz?=
 =?utf-8?B?MnZXdEFxbzVPbGJxVWg0MFhzdHlsaXJaOE5hZHhpNlBwQmJYWHhMMzNOdHVl?=
 =?utf-8?B?cm15ZThadkJnV1FjTGo4UWVtNy9GYVRKWm82bnhqK1lVTXJidWYrWkpCMUdK?=
 =?utf-8?B?cEFvYks5ME9LZEoxZjhaTVhSMS9rQ2czS2cwZjJFRmtSckVFUS9DVnJtYzFW?=
 =?utf-8?B?VitxTC9jeXEwNFdrUU1OSHBXVXRUR3FXOStGYVdNUis5VldZOGZLUTZybm5N?=
 =?utf-8?B?ZWhmQUVGdWpwZ3d6c3RJd3M1cDZJT0N1cFVUUHNjWWgwV2k2SHJHUWJRbmtB?=
 =?utf-8?B?aDM5RDN5OGx4bERDWmxLZCt1YjlvTzRCVGxJNzVnT21QZFhkZzRFbnBqOWpa?=
 =?utf-8?B?eVFsVEFlb1VVZTlmVGJPYlArNVhaVmI2Q0J0eVpaWWl6cThJOVFhaE8yR0dS?=
 =?utf-8?B?Rm85azI0ckh5VTYwbEpZckxMTjF6THNiOFV6NHEzMjR3MHpQSzFza1RqMEtW?=
 =?utf-8?B?VlNoSG9SeGEveXpWakNwNGRSMjJxeGlQSXVNVkdWUE9JMzB2RWdoZURhbzJp?=
 =?utf-8?B?WlB2Mk4zTVNNcVpRcFlVWC9DVXFLNTVoVXc1RGxOTUhCZlJkZTVrVUN5Z2ls?=
 =?utf-8?B?TU9OYUQvR0tDeFlpUnhTUVlacGNqNWI0aUpJeUVuN01zUkg1ZmNpQVJvcFU5?=
 =?utf-8?B?VnV2WWttM29tYVUrNDZ5bmxMdTJROFU0dFhSVlpNWGphaWZsckJjSG95SkpI?=
 =?utf-8?B?R09kdHlFS3NOTlpOOW9hNDBGcGx4bFM5bm83Skl1VjlobWxPV0FOa2Vza2pT?=
 =?utf-8?B?VlFoMHZNVWNrdWw2L0l1V09McFhFWUp5OVg0NDhGZ1U3MFhiWHBTYVhhdUVM?=
 =?utf-8?B?SHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OTNzUGZQbGgxZmp6NWltbG1Td1A4Ym5mSUJvdFZ0WHNLK2lEOHV2RHJ0RE1M?=
 =?utf-8?B?U3JDZ1VRaWZTckxjbWIraTFHK0doU3hwbkxOUkZDWDlpeVhkbjlEVVY1cHVE?=
 =?utf-8?B?bEo2ZGRUVHdtY0JVUUhPYTlrczdQZW5LT1ZEalIvTWEzNlRUNjIrUGY4aTNy?=
 =?utf-8?B?VjMxRm1kQU51c2NseEVXUTZnWjJaSW92VzdrVkJVNUZkdFBzTEdkRnFQTjRI?=
 =?utf-8?B?bmRybGl5RjRxckYveWhvOFpFSFFWNjhZdDE1VDlWZU9EcWlRNWMxVHBQTHl1?=
 =?utf-8?B?MTVBd1dFWndJM3NmNUpJUjgyZzJqeGhFakxNU0tJejc5RE9aSlg3YkRaeGZ0?=
 =?utf-8?B?UW9SdGF1QnpuK1o3Nmc0UnkzdE1GOEJEWmd5U0NhY0d3QXlLekhZeDd6dVJa?=
 =?utf-8?B?bUZkOG03eUVLd1l5NEsvc3NjRklSeUl0dXlEekdWR3ZUNjFHWHIzWmhMdldZ?=
 =?utf-8?B?dkY5c0hmWTlad1F5ZHhtWjZUelBrbEdKRmJsOVhXenM2MERQd2RMQUhBQXZF?=
 =?utf-8?B?S0g5cC9KbTJtV01qNUFiV0UwdldGQzhSVEN5bVBacFZhcThyU1N3K1R6WGd4?=
 =?utf-8?B?QmZzM0plVnlMRGsrWElWdkZPWncvQlpacWxVT1hwSFl6Qkk4MU9pVEhuTDlX?=
 =?utf-8?B?Z05pNXBsYWVuUktxbndJRWFvby9aL2UyQmZSZmNjQzRERk5sZDdETEhVR3V3?=
 =?utf-8?B?QjEzZm9VcUo0SjZxZE9wRmFmRUJvaW9IZS9OeWdwa2RCdXQvWndFbHVVMFl6?=
 =?utf-8?B?V2VMNEJPenZKTlRRa2ZWTTAvRG05S0w5TVFDZ1gvMkRnRGVBanFyS3o2eHBh?=
 =?utf-8?B?ckJ4d3FFRzcvY0NpczRtWHpyYUtDL3NMOVlhU2xMWjVuSFQ3bGwxM0NzSG8v?=
 =?utf-8?B?R2FmTXN5U2RVZHFCc1N2bkV6OE1zQjJ6QTY4Tnl6azBpUlZKR2JOTmpOUTAv?=
 =?utf-8?B?bGZzMjBDMjN3T0FVYzZCR3RzRkNiMXUvanFOcFJ1TG5RdE1GUGozTlNJaCtX?=
 =?utf-8?B?bENKQVo3ZjRZTnRuclgrUThwLzJYVDVrK3F6NDlOS0VtQkgwSmNHZW9RRjQ5?=
 =?utf-8?B?R090S3cvYlIwVHNDaFVwWUJmMkpxWVZXd2IwZGVGWFVoR2RYUmZyVTZlV0dk?=
 =?utf-8?B?VFBmK0FIclRGREEvY1dhdU1sTUpzQWp1Z0xYNDdGL0hzNkkyVFVHN0JSVWti?=
 =?utf-8?B?NUtIV1pIVjIzNHR2N21KUGZVQkhYUzFaSXVlTUJIQUlpYlBXTEE4eFdaaTFp?=
 =?utf-8?B?eGRaSm1iN3lOaXh5c2NIVUJJOXBENDBWZzh6Mm9kNDFZZUJrVjhkVGhRMHZF?=
 =?utf-8?B?TzZVQjR4MFVxOFkzYm1PbDlqM3pnQmNOSjlIV3VuTTk0emxwWXFzMG12bzY0?=
 =?utf-8?B?cEhnYjdlS0hqVFRkWFdlTGhjbjhDYWQ4VkN3Y2h5bE9tdnNURUdvRVlzVXRs?=
 =?utf-8?B?Mk16SWpQUFlJY3hkZ2JEbHdlUXBlZlU2dFRpc0tTSVYwR0FiOThjTnZWeUNa?=
 =?utf-8?B?ZzZqQzFEeW92TEdzK05jczJ2RmhUVnpCL3Fnd29iSWlCZkJJWWJDZ3lBQ05P?=
 =?utf-8?B?Mlp1cFFTRHIzcGZZdVM5UkFiNEpKWVpQcE1pSW9CUlRmR1plc1cxZUE1VzB0?=
 =?utf-8?B?WXVBVzdRQXFSTzFqend2dlRaM1RmemNadFZpenhXUXZZVC9RTXhKaTFVciti?=
 =?utf-8?B?dWQvTXJuZGw5YUtyMW15WVp3dFA0T1Z1TmFndDBxS3lmTUpYS1NzRHBab3dz?=
 =?utf-8?B?UmxaSmY3N1pwRkdYRTRHM3dQdms1dzJ1UDhRTEJ0cWlGVzVOc0krWmFsOFpO?=
 =?utf-8?B?cVp0N0FyQzVFSHU5VS8zK2VIVU9nWXc2cWFSUVRJVlFGYVRla25mYmhXb0NY?=
 =?utf-8?B?VVlIdkp3QlVkdlgzUWVqbFU3Q1ZWV3FraUduN2VBL0JkZEl0b2FCZWVadERJ?=
 =?utf-8?B?NWpYRm9MRCtOZnM4MUFLUjRnVFNBaXlFTGo5UXZ4OEpmdzFVc2x0cSt0cDkw?=
 =?utf-8?B?ZkkwY0JmRFArc29nZjJDR0M2c0hGSjJadVQwb3lsM2ZzWmpldVhsRGUyemF0?=
 =?utf-8?B?MHJQMU5MT0xUTFR0MFRpb3RJb1J3TytHNWU5bjBOcEkvSzc3WXk4WklUZmxM?=
 =?utf-8?B?ZlN1b2FVSmpqeXFqZHlJeFA0dm1reCtwUW5FWGlPT2FZR0p4KzltcXFsc05I?=
 =?utf-8?B?NEVwb3RwMzhGakMrOXYzTXI0Z3M4aHliSGNwZUF3MjFCZFVoRjRoZWtqRHly?=
 =?utf-8?B?UUYzK3VDUmJRbFowbDJiUmhtZk1pa1dQaVo4bWhaQW5DNDZwNW9Sd3piRytJ?=
 =?utf-8?B?Y2RwVHZzRDlFbWFJeHNZVXNrWFo5aUYrQWowOEx1ZjRsak4wQlRoZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	syA759WE3qyauBCih3SQMnFszsLORZtvz18tiwElefPid9IkjdoCq8RI96T3z5slFJBbTb0YS3t8OdKN9BVP+hrrZURPJj6ruw1cO/nXwLyUvnMD15yHytZN0GOR2jHZDQlpHEmJYpHZ1uHrneAKQGvWRltvv31YaXsJwE6GCSpjwrf/3lhGKyypRyxLkR+Gcxcc8g5w70F1zaJ/TTEa4Jjwsm+5tvUmC+LBGYj2m9fqvlRFoYR1Hjp50FMk5z5RWIPahLbBGUFtAFDlOfbt/TBAEIyTQFaFVf+dRQbCmdNduTdYe54QS2nkmTDLn4Xvd+FmfYj/QDe5TItfpYsB/blJlT0xPxxUoUw31b8qFMxrm7r1121TqoqRS/3jZzTNaV5/faeNKPJ7ZP54bbf7bCQuEkP8cTnW0AG+fN/ZUC6ws6EKtipkYnJx88SagSpk9PeelsQz9Mu1IMnW1cH4qTWAM6Nwxt00jGpRRw3EDn5KSkExTyD/MTTWhEQH1QYLMQbAeKQwRr4d8CMFBX/2h9mXGlMloB97VCJy1Cl4mZ0J7IYICDrwl2NhWei5FLJILGnA3LIrwaKiIllVG+EYif1RtZ09AH59105DAUBrgDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad167d1-bc83-4694-43af-08de6c457110
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 03:51:04.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxSuOnGr8ddAIV3cO48+UqYBoGq2rVE4QlJTW+SSFJnIC7fl8oi69dRWzxHpZVpPuukH38J76jhWl37eI9CjIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_01,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602150022
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAyMiBTYWx0ZWRfX+6Iy9zOJcGOR
 CF165n3eHmHRcuNruEWERr5Lpm5RkE+/CBm3G1ah5UZkHd8lu7C5vCE+85YGRtxk45RdqlbDaqx
 E9M00YxMjprW8zKrTcELtxKqidfAvsMi3QP8MMsaUQeuKR9V7vInlGcfzeAgkq6o9ZFvvMFhpOv
 ymyBBtsqVGK9QBsCL3qhFHDwf2QeC1lko6mQxsMW75x6dKxblQfbblqon0BkZ3ELoYUhDHHwHVr
 A5r5dIGXoypMsD4LQSY5kUdMvV3hQBe46Lu6SEQXggPwxcnLePcDDPRhw5vcBMRQwEKy6FVn9tN
 jC02DgCrfA21iwxLJSQC9r4FoDtjPYi7X0yFoG90qNgircotWIPk13ph1cJHaQE95X1tnI81nBe
 vKZgqJ//GahwwC0u/GUHBlqWm3urnvbuugtkqHcZGYlyqvsPtXQPYwV9alsIHiZ1yIEE26qrEPr
 FLwlEo5UR0nVXBSpAbg==
X-Proofpoint-ORIG-GUID: VtgTn7aGAzYBvXJfaUPUUlHihP75SyEL
X-Authority-Analysis: v=2.4 cv=b/S/I9Gx c=1 sm=1 tr=0 ts=699142af cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=Ho_CpjmcLz1q1sr5LOcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VtgTn7aGAzYBvXJfaUPUUlHihP75SyEL
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77241-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5D66413DF79
X-Rspamd-Action: no action


On 2/14/26 9:53 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> On Fri, 13 Feb 2026 10:36:30 -0800, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> [...]
> Applied to nfsd-testing, thanks!
>
> I made a couple of small adjustments, please review the result.
>
> [1/1] NFSD: Enforce timeout on layout recall and integrate lease manager fencing
>        commit: ce1368c9edf719a4fada76bf537f0614ab611835

The adjustments look fine to me.

Just a note that the reason we need the call to mod_delayed_work() and
cancel_delayed_work() in nfsd4_layout_fence_worker() is because we use
delayed_work_pending() in nfsd4_layout_lm_breaker_timedout(), instead of
the ls_fence_in_progress flag.

Thanks,
-Dai

>
> --
> Chuck Lever
>

