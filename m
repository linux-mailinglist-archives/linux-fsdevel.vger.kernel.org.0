Return-Path: <linux-fsdevel+bounces-17797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB308B2408
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F8728602D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C6B14B06E;
	Thu, 25 Apr 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m7RHsLE0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WMelPRYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1B14A4DD;
	Thu, 25 Apr 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055116; cv=fail; b=gbdYwyGF5IQze2+h3FYv+GolY2/+cHDytnkjz3+VuDeysQeCxSRgO6GJxE24sYP971D625x8FYzQrQOihXqS1oVjIsfqKt4MOIwSL5y48A8FZ57iHo8btjjK2t1899UvoXU0vSZM2uL9kORlRcwrvBpXRY/dSnXx+KwcaCgELS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055116; c=relaxed/simple;
	bh=D0LmbyBT1sXmyihNeaboFsk/SfRt1u5Ei1k2W4GyJBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PnsoRajdr7r4RP3/vGeTN5P/28iNpexVWLU4J6f7jQbgDSCbxaoMVVjEEscadeEyqnhxLCaAGNuQkPLliC4Q0TuDjMsvgnGzJWBZIgSwrFXUgKvEAhkw+A6opWsVQqxLd1HrnlDnZG+A/Z3rWOXxoxnfwS6Hcp8XAoMLId3VajQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m7RHsLE0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WMelPRYO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PEDp5q016960;
	Thu, 25 Apr 2024 14:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JMkvpL7kHCxSOjKctVkMpFe4k8uS8NLkCLxC10yBjeM=;
 b=m7RHsLE0C2kaRbAlMdJHKlR6G1xJwD0gWhDuijMQWZbwUXuLdY8yiRjlU89LuIBZtXyY
 yjtJssbe5XxJ1UN/nnp/UI7zZsN5ZhHgGvUxWOHXvW55tJWrYqGSXrqsIG/lCKD8rKnn
 k3KFDUEapA5Mdo0Gx5+RjgZCwKKl8Mtlcv9g25SbeeXW+h7r6B7N0PDs4Y3ikdzgwGFm
 E+FCklM9ljXkZoKpLSjv5b6RJ5ONVB0StQ9jWbi9xQtbebzm0y9a8eFr1ghR2Zhggyr0
 wxLwO6GNn0VjslVETqLwPr/oQ2vxs2Rsba6542QxbV2QOtJHHaiOlgrKVfQeZv2MzQ7A WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4jnvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:24:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PDZbLK030842;
	Thu, 25 Apr 2024 14:24:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45ae4j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIbVw7AP3SuAvYOMa94KpK6QtTSeZA4ARe6vLoweVjOWVNlwGGBPR+XEGAcQ04E9uvsmD3pJwTcBsmkJg5M/oJe24IsIgg9MnUky5b6gfSk5P2HhuJGIkYHqxICl5DKo6YAFGcLozomCmzIJw256kuEVuuigEM2QpDPAn/ldTekw/rhezaQcPVU429WkTGMXvuk7VLzYsl/L/dhPPnxgVGe6BP/ldZ3k5vhhrDerPqFF0kDNWzvzlaJg0+pRuLDw4KcwLP9IP7l9rAIGXNF1l4AUZBmzkYxX5T5wy4o8dtRse/uZ2ynG7SkkpO87ogpdzQv8+0oATsRsPNLKluXDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMkvpL7kHCxSOjKctVkMpFe4k8uS8NLkCLxC10yBjeM=;
 b=i5mgzXlG5tnBylASJXoU9/Hmxx41O8ndE5TyjJpGKRM/2+7BQTUzhlb8G0Csa4c6FHEjuBcidhxPHwKVCpAG/xM//QbOCugYEoRLh0Za6JFClWCEGopkPeuL5lhTwBjLxN0BMat8txhi1++iQ508UHezphEOtgBhAAaXgESKm0Z57aBbIF6ICocsnp5OKMe5KLl4kFeUEWUO97VvQz2LPbfUcOf/SVYRWW94tX4ju8yQO1cNMUSgj7sgtLKNcrx8aIp7eNye0xyfuwwfvDW/V0aQZwgfLYh03hKNPqz5v4cmZHwOeP6PQnyhku1ozGHCjRnbDMrlWwq43iXcoZR/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMkvpL7kHCxSOjKctVkMpFe4k8uS8NLkCLxC10yBjeM=;
 b=WMelPRYOF2eSwRHZ544LhuML2LqqT8fyifBG1BUHLqUrMLpKlYG/8DjpesojORkXr59RUMSpK4TeQZJHWYeaMj7jZA1mM6FU5E2NW8trsUfmBvfPtjS4u6ca+4Y8jQ10/lY3A9yJkOX0BQ6Ojc+OmL77CxEztB4XkSIm6Up9sIo=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 14:24:49 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 14:24:46 +0000
Message-ID: <674f1ee0-4b7a-41c2-8bc5-82bb0f490565@oracle.com>
Date: Thu, 25 Apr 2024 09:24:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
To: Matthew Wilcox <willy@infradead.org>, Jeongjun Park <aha310510@gmail.com>
Cc: brauner@kernel.org, jfs-discussion@lists.sourceforge.net,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <ZipSO4ITxuy2faKx@casper.infradead.org>
 <20240425141038.47054-1-aha310510@gmail.com>
 <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::24) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BN0PR10MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b80895-59b3-4eab-bf01-08dc6533756d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SVJEd05KSkZLeDMvTVhYKytYVEFMbXNRRlIwL3FUVGtXNC83TWJFSHpzUm8r?=
 =?utf-8?B?ampUTzlDdngzaFVMOU10SlBmekVpcW1ZOTJWUUVPbHNxS21jY3pFRmFwdHFn?=
 =?utf-8?B?VlBCUUloL2FySytueTdDTHlRcTFwdmdzTUMyZDQxaFNxSTRSQjlZcS9CMkln?=
 =?utf-8?B?SThuUXhqcTMwdHF6S1lZUmo5dWlvMDZtbVZhaDBrdS91SElVZldudDhCd0xY?=
 =?utf-8?B?YUYzdGplUEZHcVkzVVgzZ3J0QmlWYTd5WCtxUFV0VGxyNjRBbkJ0WHkrdGps?=
 =?utf-8?B?V0RNR1ZLbXVUbElvang5c0I0OWp4QXYva0NuejBqSzJ6cDBEcitoMmxZbEs3?=
 =?utf-8?B?bjN3dUc5cXRtRHpzeklFMlBvaURpME1Help2VEIvV08rbTcxWHhmRmQ0WVhy?=
 =?utf-8?B?aEUxZkpYT1FoaXFiRW80VVlxQVVIaEc4cCs2UlgybVYxYTJBU2JxS3N3UHp0?=
 =?utf-8?B?dzVBM3dKNVd3eXdDaEpLQTdFWVpTWWEydkVxRnZ4MEhEYzBlbmNLdlVBM3dv?=
 =?utf-8?B?NE9RTVFzZGNEbXpISHpPajVLM2xRTXhRbWUvY1orK1FUVVRIWnBvNzVCWGI2?=
 =?utf-8?B?WTZQVjRrbVlGN3NXWHIrMVlGd0pPakl2OCt2RmwzUUdrSnpNSEpnTERUTVkx?=
 =?utf-8?B?ZlI0Vjd6VVVMZFlQcS9OYVdHZzF2SHlwbHd5WVRaanpVdHFWbkppTmc5eHg4?=
 =?utf-8?B?dkU4VkVjcUtVVzNOMWJhdmFNRkFybU5XVy9iS1hLRWNldys1b1NvMU9qOGpZ?=
 =?utf-8?B?ZHVtOVJBVjlRNUtMbFJjWFRDVSttaFl4R2c1NUpITTBlQjB2OXdCdVBvdzQ1?=
 =?utf-8?B?WkdVNU1uakJjWjc2MEtJUnVOMXgwekhvNHpJZlNEUkp1alhhbmt2QXZZVEpE?=
 =?utf-8?B?RGNsQkhhYWh3UFFFd00yRk1hRTlUOUVuQnJZQVpOTUd2ZXdDbS9yNE0za0pz?=
 =?utf-8?B?OHRBWkpHY1lrSWtNTWIva3BCK2l3SkdibWFOaGJqNDhRUC8rRGMyY2E3aWRi?=
 =?utf-8?B?VzIvLzhWTGlkUUV4ZGZkU3VCOUs1L05qTklseDNmVENvbTBoTmhIL3lmb0RF?=
 =?utf-8?B?ZFhLWTFnSitzVlNreWE0d3VQbTZhaWlPekVRTCsremZ0aFo3N2RieEhKUk5J?=
 =?utf-8?B?RXEveWRaSHdSMGlGQVJTK1ovaGhhaDBhUUE4TzRaNGo4S0JLdTZPdjErN1ZL?=
 =?utf-8?B?akNPakNNV1JTM2pSUExtWDd4aU5uY2VzcHFQZXdpeXdKTVV0M0xJdC8zS2c3?=
 =?utf-8?B?aU14NC9wVVplVy9EVm45cUYrNzFlRm5iVm4yWHduVFNsSldYT0dPWUgyb2da?=
 =?utf-8?B?eGRJbks2UkVrQTZPUXBuTkMzay9qR1VqZkRqNER0eXVhOFRKS1oxT3FWdnF0?=
 =?utf-8?B?REtmcmw5bmdWd3YxVW10SHhKNjZEeHNzRDR5MFZEWUZWcENSeE5aUk92c2Q3?=
 =?utf-8?B?ZnJGbFlINDNZbFBSdCtaZkY4a1IyMjE1WjcxT1JXTHcxNlQ2Zk5QUzFWcDJU?=
 =?utf-8?B?RVE4Q2NtRUNmUzNlV1p3alFuOHExTis0YmN4V0s5UHNrUTViNTZUVEdBV0lx?=
 =?utf-8?B?RjRsTjQxWHlnbWpXQmp6UVNGUTNIYWZUS2NweHo1bWhGckZCN1k4Vm5MUU9L?=
 =?utf-8?B?d2Y4RG4wK2NDZkh5NXc0aXBnZGRDSkliekdTbVF3KzJBYko3enYwdGw4alJZ?=
 =?utf-8?B?cmF0L0lwVkg3eE1CQkUwQlNPWHdrUHlXc0pZbVFCL1FlQzVnU0QrR2RnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlhsRXlnK2pGcVhybWpNekFXRDVFVDBxWTVoR0dQUk1NTEF3VlRIVXdlSDVS?=
 =?utf-8?B?MDlBS0wyTmt5allhWkVWbjRMOUc0enk2bWI4WDh6T3dReHU4a1laVTVGdnNI?=
 =?utf-8?B?NzFjcm5tdEtXMCtnSlNUeWxQWkNBMCtTWUFSRlZlNXJXQ3FaT2JSUEpBTFM4?=
 =?utf-8?B?THFOT0RmeE1VWFp3VWJtSVh5WUFPZjk2WWRDWmp2OFR0b3BsZ09iWDJjYVVi?=
 =?utf-8?B?WkhQeEVyOWRXSmpiMWtBTzdZQjBMOEdYcVpkNk1kOGFEZmVuT2gyd0NvK0lt?=
 =?utf-8?B?aFdBSkN2WFZZa2lWU0p0WXNsc3k3dlZVdzl6Q3dhWTgvMHVFcDhtRmd1RVN2?=
 =?utf-8?B?SWJHODF5VlZxb0E1U0d3L1d3SHJnblg0UktyQlZ6dGlHL1Y5MzlzWUo2WG1k?=
 =?utf-8?B?UUJyUlZmc0RMTzgxNTRpQ1lyZTVyTFBCQ1ZBb1lWY2VRMmhFMWRlREhOQkEv?=
 =?utf-8?B?NzNOZGlRR3ZHQlVYZE90V0k4UDB6QmhLL2h5eVp2OXNOSGo4ZWhQYlpxbWVo?=
 =?utf-8?B?R1JVQm9ZdFpDM3hud25sTU1ua2NybG1NbkRnOThLQTZrK1Fxeko2SnFwYlE1?=
 =?utf-8?B?SVJFMDRmTzBiZmxqVHpsQVEyL093SE1IMzVKNC9UUmlNVEU1QXQ1UGJRYWhB?=
 =?utf-8?B?aFZYMVl1VDQ2THFOZmV0SVZ5bHNTeWhEY1Y5OWFGeWhweUxCL0VTUDdYNC92?=
 =?utf-8?B?SlVxUk9EUW5tY09TMlpLbER5R0lCRkpReWN2MFROMlhYbm9VTTJVSlp1dVJ4?=
 =?utf-8?B?Vm5pRlJGTFNISUhGS1JHQ1VMT1cwUU55OG9MZW1NaXovK2s4MXRKMVZ6cTlY?=
 =?utf-8?B?WERHZ2F5eWNNQVV2UWhxVVR2UUtTUmZhaGZ4cFU0NkFrRkk1Y3ZXcnlZTXE0?=
 =?utf-8?B?UW00R1pWeDIrVXREMzlDQlFaOUdZc0toYjhBczRrLzhmSWVVdG1BNFBUM3d5?=
 =?utf-8?B?THZIalQvZDZIZG12T0xnMGVvbEU4dHNJKy92R0NGV0FKTHFya2pzZUQ0bDNI?=
 =?utf-8?B?R3F4VFZwb3F3OS9IckdmdkhLTU5TMExjdkNvcStZNXZQMllRQ2Z5cmFHOEtl?=
 =?utf-8?B?OHVPb1JzQW1NR0d3Vnc1TFZBcGNUOGhQdCtiWnNHTCtBaVB2TE05dVAxS3VU?=
 =?utf-8?B?dlh6a1lWa1Y0eWRJOWZwWkJGZ1BpVzlRV0pJZWhxVUVTOTJnS2wwanVEYkRO?=
 =?utf-8?B?SU9QUFV2dUYyWGRzSkNReGxmS3RvSVZTcUpTdTBMS3FhMktHR2ZidlJrb2ph?=
 =?utf-8?B?dUpNZlpvcDdVREZReHlUQVp2cTd0Y1NhU01tUE9rYXBwSmhsNkY0YXR2Qk1Q?=
 =?utf-8?B?WjZSY3k3UFRxRFY2Z3loV3cvcG8xOGJ4NHJLbFZHbnE3T2xrRTl0SmlKTE1X?=
 =?utf-8?B?YVF6OHordmVyczFNV0I5N1NaVHFUM1pvNWdQazVlb1owdmxUcXlMdFpTQnBW?=
 =?utf-8?B?NlF3S01WVFlFanNSbi9HZzljU21GL1FGZGYyMVlHL0U2YktscUxza3JTSTVa?=
 =?utf-8?B?Zmp2ZUgzbEt3WkpaZnZoU2xrUVh2bWR4ME5Fc1VaM2lpL1c5SFBheTlLRE9a?=
 =?utf-8?B?RnVLMmkzalBCeHVLTHVXWWxnbnczazVOZEdRRUtFRGJBK2tnRmFKTFVzQ21I?=
 =?utf-8?B?anJoSTdmNlNuS0cyYkdmNDQ0aWFWTUlVTmw2T0ZOOG9uZU9Fc1NOS2FqdGN1?=
 =?utf-8?B?MVZYaDdDU2NlaVRrNUtZTGpONEJONVZwYkxuSGVrbXNiRisvUmcrSm5meHUw?=
 =?utf-8?B?M0dSK3M4aHRBL3lPenB3SmU3SlZ2bklOTU1kYm1zZnFiY0kxMEdQY1dMelJl?=
 =?utf-8?B?OXIraGo4ZHhOVm5RV2Vid05mYXJJQ0FkemNCbnlDWnVuRXZ5K1prY0lxZXdM?=
 =?utf-8?B?aUV5SFc3dGxkS04yVzJIenpVT2F2VGtaYXZFRjZWKzZ3OXpaODlwSGJTRC93?=
 =?utf-8?B?K3lhL3JrV3hxdGgzM1dTZm5YazVWMzZ1a2NuaXBDenNpZFQxT1QzRUJOS29C?=
 =?utf-8?B?UFV6ZnJRRU1kZ0Z1aXZjOHowM3FvSWxiYnBKai9qSzY2YUtIQWJ4dUxEdHc4?=
 =?utf-8?B?d3c1WHI5MGg4T3dVYndFMGpqUmJXS1ZaVkhORk93dkQ0Q0ZQZUZ4cXdnOStx?=
 =?utf-8?B?aHMrYlJoSGtKd3RUKzNpeS9aTW1SVzZZaUZOT2VNeWNsUUlCNUpkNHR4OUhh?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RH1xFwTlQbjOz0kkYvEKzrAOPsz7R3pfdi7MXioJqZg9L2OkStL8KO3ozgmxM/BsjKvT8VDttS+IvePM9m0Ydv/ebYvkCQRcWWWTfUw+VLKblkoRiLzGuEDY1qTLBvxCNhOFLuTGGHG5OJdOxD0LsEodo9XXFKuZ32+4AQCkhjwPyN5H+t3f1ztDoUFCQnVoD4WP6tAxURr1ElJNzKshDtMwj9N66AKZT7mF+vHGeF5R53p+7t0Dz9mj3WdSxR9NJuC2Ax/ZOSy0zXexRMXdK4LyFt/ISottOYpvSMBduxiAi4Ir/ZkDYgu0Nyhqx9YuPxq79aBqCDvRRvY7emDo9wgW8yYo1rLl6Cqd2hqEv//R8+esnOPl86bKuKoM2TxkmEoGeljAAURXipSDibg6vzvS9ZVaEs88NqAAn1dNfTCX8dY0DPRGKNQy8VsY/j1Dp5fLBZgKGxTQ0HH16j0+YcLBK7LaKDjP6ZNd4EJFyKqTPkWpBriwqDmqpRLRKiD/MHRt6wdQymnXY3/aixq7392ojkRGMyutnADfcytSHpoLyZWR8fNh4hbFZ/e/oR1vcVZsQi2bKYfbzWdXLp+H2n6ryuHaVS0bsXwDXFNiDOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b80895-59b3-4eab-bf01-08dc6533756d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:24:46.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qlHwzLTCN0BKnYhqxf/6tpTemsg2VZgTeKZCFua5xJ15Ug2e7wA7Lg6aYjbUh4/5S7ryxGVtSu1x9pAdyfVzlfk62TLdmNvM/6HjGzLjug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_14,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250105
X-Proofpoint-GUID: N-T5G9uPnca4Jglm6GKuTBj9Aa42odzt
X-Proofpoint-ORIG-GUID: N-T5G9uPnca4Jglm6GKuTBj9Aa42odzt

On 4/25/24 9:17AM, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 11:10:38PM +0900, Jeongjun Park wrote:
>> Matthew Wilcox wrote:
>>> If that's the problem then the correct place to detect & reject this is
>>> during mount, not at inode free time.
>>
>> I fixed the patch as you said. If you patch in this way, the
>> file system will not be affected by the vulnerability at all
>> due to the code structure.
> 
> It should be checked earlier than this.

Right. This is preferable.

>  There's this code in
> dbMount().  Why isn't this catching it?

db_agstart is not checked in this code. That may be the bad data in this 
case.

There are probably dozens more sanity checks that are missing when data 
is first read from the disk.

Shaggy

> 
>          bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
>          if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
>              bmp->db_agl2size < 0) {
>                  err = -EINVAL;
>                  goto err_release_metapage;
>          }
> 
>          if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
>                  err = -EINVAL;
>                  goto err_release_metapage;
>          }
> 
> 
>> Thanks.
>>
>> ---
>>   fs/jfs/jfs_imap.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
>> index 2ec35889ad24..ba0aa2f145cc 100644
>> --- a/fs/jfs/jfs_imap.c
>> +++ b/fs/jfs/jfs_imap.c
>> @@ -290,7 +290,7 @@ int diSync(struct inode *ipimap)
>>   int diRead(struct inode *ip)
>>   {
>>   	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
>> -	int iagno, ino, extno, rc;
>> +	int iagno, ino, extno, rc, agno;
>>   	struct inode *ipimap;
>>   	struct dinode *dp;
>>   	struct iag *iagp;
>> @@ -339,6 +339,9 @@ int diRead(struct inode *ip)
>>   
>>   	/* get the ag for the iag */
>>   	agstart = le64_to_cpu(iagp->agstart);
>> +	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
>> +	if(agno >= MAXAG || agno < 0)
>> +		return -EIO;
>>   
>>   	release_metapage(mp);
>>   
>> -- 
>> 2.34.1

