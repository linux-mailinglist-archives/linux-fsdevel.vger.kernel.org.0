Return-Path: <linux-fsdevel+bounces-74716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKPXNyvfb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:01:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 710EE4AF15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50B41A87605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E547AF49;
	Tue, 20 Jan 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RGAgg17G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qXPoptas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648847AF43;
	Tue, 20 Jan 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936965; cv=fail; b=c7hwdpRwdpbHKKRVBKvMnlDgGLSTXGsnnBov26mYLUsEWPY8k3BA+GbiT1Dq2Kngxc9cbSroTmkn+7taA7UIxhe1k6MuFxiwilG8UHVHwKjnzGGAIj8fTH18JUq2CJS46IHDNIOV81injLEUpD294mAnjI7CsvWSy455+3rZjPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936965; c=relaxed/simple;
	bh=zrP6w1g2Bjxr3V0/96DggJmjrhZS9Dl5qyKhkrlH1vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PdEExifwgdRJn0K6jdM+QJzyJz5HVApExh7dks7sxPij2Vj176DAgQ5zTQ95i2k07MCtwWvWE5YWGKI/9W4LNVpKn9lZZvI/tq0RuKyJoIF+a4K+QnCawK0We/bwsBPOa8YXQJ6jrWfPf8ZDIe/HY1PxE4Nrj7jlIydPoIHFTRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RGAgg17G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qXPoptas; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KIhToD3032109;
	Tue, 20 Jan 2026 19:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Cyhy0Vu0f3pAa8qBqzIzBsi6Nt4BzTpW92T7FScrDLg=; b=
	RGAgg17GJqN4pTH9fZHhYTS+GktefdTMyOaj5oBW+DwBIBX9Eqxbaun4Q2G0BSBC
	IlUq6EgH7fBOVfI987YqXsF1Ma1zSAdjbgMQjg7JWmBqtWKaoBETX6J4uSy/Qs/m
	fAldS/5ur31Ioyr7GFYIZaCL/bBO5AzedOz7UbWqM6hMf2f1pUfw0nxqzZV6SiUF
	HSN18VDF9bU7MlFHVl6wkUBIgTnbPDDOXr+vOaTjQBsyQt4EOhjhjP1rnQl1f1K7
	nDMm0b4ivWawsaOXPVXq5g0ytjqOgOIX6yKBc2MPCAO635j7G4wdOx1GZA/sA4N/
	j8R3w5LodyZ1nowBxfYazw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypv78x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 19:22:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KJJnhw019040;
	Tue, 20 Jan 2026 19:22:26 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrqxnuq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 19:22:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSdj+gGlbPuSy9ZZwrBLLzBSZq7GLuHdFuVjynPJpYqAp9wBKiHMxwqejua75fImoQuELdBn+BvKRT3RPRJWJxjGIGmw+9vz8kDnf9D7yPYA3d0Hjo3lR2Z9b9y5L7rv+YX8IIe1re5aspFY8xPPH6xyX/Pok4wfto9jc+A/gHZw1XDMqui/aSR8jAzuhx5VeaVth9HQ90k8S289+3qXWzcN2Vc4MPIqmwv9tws2/41AuP3dW8rZrrmRCj4+7HTGpui1u9EF/NmxGE5D/e5cR6L/dpWlzJJm6FMfmHLdaffXaZs4cLbuR1v0XbNHf0hLNpS446eyRGe/7xSvOwWu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyhy0Vu0f3pAa8qBqzIzBsi6Nt4BzTpW92T7FScrDLg=;
 b=rgubfgFCWr6RYVYUYkZQ3W5BxOeKThRA90Eo9tXvJjs0vveObpBoNKEdP6Cm8qOUb5kjLnKRgyHc3E02p8e87d223GYJ5XTDj+5zxv6nXF2UgpGUEwvGxImipYwtP+crU1yuo4jjsSpt2KcG9usFz5ZhsuGq//gK0/OF2YcthvW3WDwLKoS56FTjoIMGH3TBE618FDm7AUAibHnSI6K6NHFHNFwoC1d762F5qpHPJpqouRTl3XwF0QiQHxkMVjBa4EtKAWuctN1JDimeZXvhSVHlFOWn3lxY3g3iAEK5dsYaSMS3h9GaVRJCIZGlGqP89zURy+Io+KIGDZ0HYcrAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyhy0Vu0f3pAa8qBqzIzBsi6Nt4BzTpW92T7FScrDLg=;
 b=qXPoptasjyPiCkaev37dQYuJSS59W8YfShcEBxA8ipfmZFvLbOV9ZPxtfCnHraEblaG195NzGybNlQ68wB44xsirL5wgIfKd+ZqeXYj4VLUsFnNLHj3ETHCRR0EHoDtiDuhfWFYHL+8b5vHU/EGvnf9uXA2IWC6JNn/0rZ3bCzM=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 19:22:21 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 19:22:21 +0000
Message-ID: <1652de99-7bb6-4121-a5f4-2454ddec7d41@oracle.com>
Date: Tue, 20 Jan 2026 11:22:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
 <627f9faa-74b0-4028-9e52-0c1021e3500f@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <627f9faa-74b0-4028-9e52-0c1021e3500f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:c0::39) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 642293a0-c233-4098-d61b-08de58593b9f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NVdGZ0tOYi9tTko4SFh0UjVSOVB4Z0M0czg1aVZOU0hmUHkzcnBKcmZ3SHpM?=
 =?utf-8?B?YWpaN1VubEVwY01iM2RRRWhHaE5sSXVBOTgzMFh6aWR4cnVaME1BOVc1WE94?=
 =?utf-8?B?cnVLdVFrRC9RdnExWlhJSkhPMDZCZ3pOWVYybEQ3QWRhTStGaks2REF2T1gv?=
 =?utf-8?B?dnlPNEp4NmQvT1BIczd5aFloL1lzRmdwK1UvMEMzQ0NQWWxINml5ZVFteDFh?=
 =?utf-8?B?NUN2UUhYYkZMT0xRMElGanh3eUR3UmdhWFUyU2o4QXlPNTVFZS8wZmp5TU1U?=
 =?utf-8?B?S2REbkNCTVNQM2I3QTQ5OTltaE5sNHQ4aW13dWo5MWRtZndRaG1PRGJxZVZN?=
 =?utf-8?B?bjVhY2tjVmNDWWM0MVV1cXhockVEU3NrNEQ5QUFFejBWSnlXOFppa0FGQlMr?=
 =?utf-8?B?blVoY08ySi9ZUC9wYTYrZHRhVlBaNHAyWitrMDdTMEpIT3U0Q1hzMndJMkkw?=
 =?utf-8?B?Tld0b0hITitzcm0zSVJScDl3Y1U5UXZVSnpWeXYwdHZwZ2tLU3J0SGFEUGxl?=
 =?utf-8?B?Z0syR2lwVGUrNnlsTVcvb1dyWnJpQ0F6eFNTWExaQmM3d1hIalAyOWhOYm9N?=
 =?utf-8?B?UGRwcitKRytYbTdwMmYzYjdFK0JLU1k1akhiMmgrMlVPbm5OanQ1V0VyeGpO?=
 =?utf-8?B?cXBNSy9KU0ZFSVVqeFAxeDRtYXpXNGd1cmNpdk9vUlEwVkVNbU1xc2ozeFhR?=
 =?utf-8?B?a2o3N1pkYWJHa3JkUVUrWTJLY2d1Q3hsaUhMRE5RYjZ5OXZWWnQwU3oyT3Fh?=
 =?utf-8?B?TW91MWhlbndhcUtHMWluTGhVRE1BOFVFeWVTYzBlM3l2Zy8xb3YyWkhuSW9s?=
 =?utf-8?B?UWFWeFc0MzBVeTJpdXRxdC9FbmxwRjI4ZXFlakZmbEJ3MzlQMHcwOVJxRkQ4?=
 =?utf-8?B?WUVPem50Vzl5eFBVV2NsTkljZml5a0tMQTMwSHdSMERiZ09tcEpTYjlzYkR1?=
 =?utf-8?B?bWdZdTlHdFptSyszQ0RPbmM2ZjJCV1ViZXhtZndNVWZkMVdzUGFHL1BTRjla?=
 =?utf-8?B?cU1TdXBKTlNTSHRpTEJnMHRsRjl6alpEV3AyeU9sYkxqOHhGV1B0eFhiREVw?=
 =?utf-8?B?NjJ2WkUzYzNOUXpVZjAzZVNSNHNMMzRDekkxRzNmaFRjOFZmZlJuMWNyaFIy?=
 =?utf-8?B?SkllTThHanF4dS8zZlBXOXZWNkEzVURqcXZTQk52ZnArdFFobXF0SlFwenVx?=
 =?utf-8?B?c1lMYUVSZzNEZWo2WnJmTHd1UDBEb2ErQlFmdm5uN2EwNFNvM3gzUEU0MC9X?=
 =?utf-8?B?cVkvUmNCN1M5c2VBSlNVOTY3ZzlIazh2WE9udkcvdDNaNU54cFZnTlV2LzFN?=
 =?utf-8?B?QVVzWXU2L2xPNndmR1pBSVYrSTFJQ1owQWhRWHRmOWZyaG91eTkzblRNRjhp?=
 =?utf-8?B?RzB3eWQ5ejJoTmJ2ajlhMzZFYzZtQ2hoNFdCSUhoQVNCdFdQeng1L042R3NI?=
 =?utf-8?B?SHh0a3Babk5YSzE0aEo3ZHBqZnVEcHZYeG41UWZMZFR6MzRzQ2VKdG93d0d3?=
 =?utf-8?B?VHFLQUhYbUc3NUVWVzFFTnZLbGtGb2pmbzB5Rk9zOUU1T2NSZ1Z6VlFHV05m?=
 =?utf-8?B?SDVYZUtnUVNOWVlmYVVaS2FkU2M2dEcwNHNsR1VjUFZEclhrODR4UWVHV25M?=
 =?utf-8?B?NndlYmJzdWNqNHAzMjJiS285TmlyR2dTK25ZcFdsWmZiaTBzdmVvem5URFNB?=
 =?utf-8?B?K1ZBS2hrWEcwTlNKMXl4dFdQeTUvRUhnc2lpVlZBaFZvSVJ2ckFtRE1mT0sx?=
 =?utf-8?B?VGludy9ZNk9LaTQzMGRnTklEeHptM2dMU3Bka05tRGcrTUduN0FjbGtwZzB6?=
 =?utf-8?B?WG9wM2cweGI5dGVuVWR0ZGhHV25oWnFzWURKOWpneUlDOXNHMEZFdDdhc3pB?=
 =?utf-8?B?WkZob3U0RUE0ODBaYlRscU4wSzU3WjE1K3M4TUp6QzMwd0k2cHdxTFlXYXFr?=
 =?utf-8?B?K1c2RDBGTytsdDRmYWs1THRNWDBQZWJvNzZlcUwvZXFlWno2bllQM1Y5Ynlq?=
 =?utf-8?B?ZmRCNko3L0RJTU1QWVVYb0xaNjRRVDZ5c05lYnM1YUFuZE1DMlpkM0d5dm9U?=
 =?utf-8?B?b1VCVWNOQnVyalhnUitnQkorT2YwZU9YVElleGsraTJ0QXdqVDJqTlZvOXdY?=
 =?utf-8?Q?5ubA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bTZCdTZSNEZ5aElHd3BSdUhlbFo2RjJHanBBTWczaGZGUTNUS1lZcUF2VUpE?=
 =?utf-8?B?NXdaUDRjdnlDM1VoSm8rZDBBZHo4RkNpZ0tiOU9TWUxCOUMrMC9lbUliNDFN?=
 =?utf-8?B?YTVVdXo1UGh2MkFEVHFvZzAwUHd5WFF6ell3NHF0VmZkaGs1UnlsRXNFTlhS?=
 =?utf-8?B?ZTJqbnM2NHozNm1lTHhsQUNhUVU3bFhVcHpDellDSFl4UWkwYXZjQmtoWWNm?=
 =?utf-8?B?RXd1WG5VRzFnU0R4bTlXUkRKc3NBWHFKdmM1TVRLdERvRVE0WnpSaW4vNXRR?=
 =?utf-8?B?Mit6OUJkR2crdy9aMTM3Zzl2bHFmWm40V1ZEUk52OVVPM1NNSGQ4OWdjaVNB?=
 =?utf-8?B?dzJDbHRhK2dQMGE5YnNSSkR5NlN5NjRPdmM2NHh2SDV1SU5jeGJSWFVjQnZk?=
 =?utf-8?B?VUVRWEg1cGQwZDlVU0h1Vmx0RGROL1hrcG5ySjlHOVZOTFQzeWVHRzlJWGFU?=
 =?utf-8?B?S2lXL0JVRU0xUUpoYVlodGdOK3gvZ0pRR01jb21FT2lxditsaHBUVGdBM1Qz?=
 =?utf-8?B?WStWdUlGYklRaDhtVVhIWURzOEIya2h6eW9aellkVithWHNiMnpLSGtOVkVH?=
 =?utf-8?B?OHdrejQ2U0FFOVhCNmREeWo5bkh0QzVuQVU4MEthbElScEorMEpVN3BxbVhi?=
 =?utf-8?B?UjZiQmdJS2hDcE52U0tJbmQyQlZCVmJOTko4cWxrQXh2TWFtNGs0RDlCS2c3?=
 =?utf-8?B?MTVtYjUwWDZaWDA0bGhYL2tQdTI1ZUtNcy9ETmM0RW1tSDNvUGVQNlFQeFB1?=
 =?utf-8?B?NjNadWdBWFl0Tld3QVRnSUV0Z1cxVWo5MDJpQmNkU2wxT2Y1UXdFYVQwWUJT?=
 =?utf-8?B?MXBjWVFDM05JN3JqdVM2NlB1bHh1Zmg1Sm5yNUJ6OThZeHhTNnlybEZ4Z1ZJ?=
 =?utf-8?B?VzJjdXRxUE12K09rN0ltLzlUWUl0amVjcjZTaytrUVd2czhzMjJJc0VreUkz?=
 =?utf-8?B?Uk1yWnBPakxES3RmNk9nYzhvMXFzbFZzbFpvcVlkRW5yUlBQNUsrZHE4cFRZ?=
 =?utf-8?B?ZFpucmxzY1kwT1NIMFpSbzNKWnNQU0dwOGFJa2dqTTdqNWtaN01MVUx0RWVq?=
 =?utf-8?B?QkdmZ29DMyt3ci9KaVlGZXlDSHZGUGMrSC9hdHdqN3paQ2JZb2Z0SjFCU2JP?=
 =?utf-8?B?MDdBREIxcXhTdUtVakhGTkFFL0JTRXNYS1p1VnpyTStMbXNqVElvNFFvS0tz?=
 =?utf-8?B?WTQrdy9UaUY5WUZPQjJVeHBzcXRHenVCR29LM05XVmxYWXNjWHdIdkR6eFNo?=
 =?utf-8?B?WlFYM0dsZ2hQaUtnTWkxanNvRjR1MUp1ekdyQWIxYlMzZWoxV1ZSSW1LL2Qz?=
 =?utf-8?B?OEo2eEI1TnQzaXlFMnkybDZZNDJQS0E2TDUyejhTT0dHem42MDBaQmVwM2xt?=
 =?utf-8?B?VmgyTE5FTnljcU9VK25LRkJGWDU0SkxhNFJKaDljR3VVZ1JIRFhHMi9VRWxl?=
 =?utf-8?B?dllVVlEyVEpzaE03TCs3Vkdib0NBNDhOSUdZWUR5M3I3YUI0SlVnMFA3TTV6?=
 =?utf-8?B?NTVOVUZCWFJ0Q3FURlhGTVJsV21Hb0NYb052NTVJZ2hYdXlaYmhOY0NtQXlY?=
 =?utf-8?B?ejhGb1pPNEIrSGIrc0pUMi9SWVRtY0JmdzNpbnRvV2tjNmM2ZUJlMnlOYVpC?=
 =?utf-8?B?eVFRMnhTREdmUW9OKzlmdDFud0xRYWZrbE82dXExQnp2MmU4cW1YcGJRL21Q?=
 =?utf-8?B?T1E5eWdYTkJvRGRYM1F1UnMrTTZDTGtTRU5TdUUrbjFSQ3FrZFhuK2lMcUMr?=
 =?utf-8?B?ckZuUFlWWXpxdzNSYzB6MXJ2RU05UVhORnl1MUlNNnhncU5SS1A4V2ttalpU?=
 =?utf-8?B?cEt6eWdJOXg1STNGV1FMejIxYnVLYVpEU3FlV0NvK2ZxNUVyNTd5MDQ1K2Vn?=
 =?utf-8?B?QTh5dUgvdkVIakphNFBxT05jbTNzQ1NQMXhlNzlvYUR1alJjNkVmRExhN3Nt?=
 =?utf-8?B?WUJlcVZBZkhvUWVHajBid0lTYTBBUkFheW1uekdHOFVwNmNUZzNJbmUvaHFh?=
 =?utf-8?B?c2xEZ0dOOFp2cDJHbS9rOFdoc2ovMHl4Zi82MmVYS1pjdm4xQnNuOUJoRG1J?=
 =?utf-8?B?NVVhWXFjT0RWK0FoQ2xZN0VCcXdGNlhqNjRFK2ZORngycVdqTDBWQlV0cXha?=
 =?utf-8?B?UVhBVHlwekYwWjhrN3FWNFFrejlnY0ZXT1E1ZW1jNGpabWp3anNJdnA3dm84?=
 =?utf-8?B?c0EvQVpLRmdUendGWHBydVV4akJ4cHdIY2IwZytiMERHR0xSWG9sYnorTEND?=
 =?utf-8?B?OVJ4dmplUjM5VjdJWFRzY3VaTUJPT2Jpbk9SLzYzNGw3WlZxbUR1YjRpUEtY?=
 =?utf-8?B?NVZ0dnhsWERXekE1UG95OEVQb2RHa2dvN1FnNlBLQStYQVZHZ0lHUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VHtiySBu6aZPkwU4QeHjgNhQI40S6WRVXKXRysktPkrEoKG8gpr0sMp+1D8kLiXpFxiuoqy0HO8pNZDsqhC38s6ULVk5o3cTNfwNx9wNUyoH7o3pP9CI5eLSGoC5oH0SMEjD5YLmqiFw3gQ1hrNjJzFm6WAbVh3/Mej6yLhdHR4DU4sGkxrgVsMvqXvYw4J9TvUGkhLM4D0z9oDipJjgLt2BjLu9v7upqljzpWw7gXRe5jqw7xfPbOEH27x84LPRYyQPBWIbLaf7h6ill9MSInqsO2v2IXrKvWoyInd+an6iRjyrnSW45GqjEvD8IuLWkdllGzhxR5WxgVzaq9ESHp22jOd9nPKQHgh9FL3C73mroNUIZG4vTqM+RIMygPgqkP8q8gvQo2T7Kna3xrS2xgCf6wyMtL5DSr1nvp4TcoEglqM1dQE4vu/NwkWfHDq5YfZnx39BdAl8PquKSaC3Qy8x6dPaaRiGNjYfJ8lbTx37DPEEWo+5yYV+bk0DN7V6At+cl/N73WCMAyPqQN+QFxyqLhoIolepl6F/w+awq2KzR1bZu7y8I4l2Flk3SEm0IQgEJfuGQr5Lus9AKxrAhMa9/KgxAl/sYLVq+gfVRkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642293a0-c233-4098-d61b-08de58593b9f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 19:22:21.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZToVTV4r0S8RNpj/WE60KrvSXIydi7fooWTy9IUqAHhEWsgQrfnYq+/tQDzikAO9E4q8NGVR9WijCwSiC1T9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601200162
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE2MiBTYWx0ZWRfXyde/0PnmDgJI
 yEGWGTEc1C0zJY4GmD3eQNxf3I+/8bbitIt74rDhR1B0ZW9NPMo3PKWDjptNYCOMpFrRWy/jrDG
 3J3D0QpOYoDcW9SG63BKWFcLnBPopqoGv6A/ncwNYtzovUwUR6R7885N4zKiwaI/Y8CQdC0NvZa
 cxyY3zDothP7NZwm/I81pGuCIqjSXt7WsfbhB/6i01c10pYjecFaVC45IOepZg5acL0zd24KUul
 9zGeeek3TGBz8v+0hxL8UFOIIWwGaUZHI1HXmNwQT9DCP2WTdG6mA8C2x9jZ895Whr8kPA4k8Pc
 YUzOn2UD/eVes0O7IKvBeIDitgoUMmzQfoGF2gbHPAhuLVNniebskCF9xfIafVZt/8QkL2DxkP8
 CCsJa4oR1oRho6WSUfR5Ej6nir6RZ7IKveHKl5SO/YHl3mPM/D6xmljYNnTGhPY5xobjI+8FuQX
 8q6wlKkWDqwXbR6aJzQr670N0wop8vhr5jT6K/DI=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696fd5f3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=UtJrIc-ZVEozPGJJcHkA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12110
X-Proofpoint-ORIG-GUID: EyObJ1nlwia7-dXSXgI-Uzi8sBIYBw1s
X-Proofpoint-GUID: EyObJ1nlwia7-dXSXgI-Uzi8sBIYBw1s
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	TAGGED_FROM(0.00)[bounces-74716-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 710EE4AF15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 1/20/26 7:19 AM, Chuck Lever wrote:
>
> On Mon, Jan 19, 2026, at 12:47 PM, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout
>> is necessary to prevent excessive nfsd threads from being tied
>> up in __break_lease and ensure the server can continue servicing
>> incoming requests efficiently.
>>
>> This patch introduces two new functions in lease_manager_operations:
>>
>> 1. lm_breaker_timedout: Invoked when a lease recall times out,
>>     allowing the lease manager to take appropriate action.
>>
>>     The NFSD lease manager uses this to handle layout recall
>>     timeouts. If the layout type supports fencing, a fence
>>     operation is issued to prevent the client from accessing
>>     the block device.
>>
>> 2. lm_need_to_retry: Invoked when there is a lease conflict.
>>     This allows the lease manager to instruct __break_lease
>>     to return an error to the caller, prompting a retry of
>>     the conflicting operation.
>>
>>     The NFSD lease manager uses this to avoid excessive nfsd
>>     from being blocked in __break_lease, which could hinder
>>     the server's ability to service incoming requests.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  4 ++
>>   fs/locks.c                            | 29 +++++++++++-
>>   fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++++++++--
>>   include/linux/filelock.h              |  7 +++
>>   4 files changed, 100 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst
>> b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..ae9a1b207b95 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,8 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>> +        bool (*lm_need_to_retry)(struct file_lease *, struct
>> file_lock_context *);
>>
>>   locking rules:
>>
>> @@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     no              no                      yes
>> +lm_need_to_retry        yes             no                      no
>>   ======================	=============	=================	=========
>>
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..cd08642ab8bb 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose)
>>   	while (!list_empty(dispose)) {
>>   		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>   		list_del_init(&flc->flc_list);
>> +		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>> +			struct file_lease *fl;
>> +
>> +			fl = file_lease(flc);
>> +			if (fl->fl_lmops &&
>> +					fl->fl_lmops->lm_breaker_timedout)
>> +				fl->fl_lmops->lm_breaker_timedout(fl);
>> +		}
>>   		locks_free_lease(file_lease(flc));
>>   	}
>>   }
>> @@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> +		if (past_time(fl->fl_break_time)) {
>>   			lease_modify(fl, F_UNLCK, dispose);
>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>> +		}
>>   	}
>>   }
>>
>> @@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsigned
>> int flags)
>>   	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
>>   		if (!leases_conflict(&fl->c, &new_fl->c))
>>   			continue;
>> +		if (new_fl->fl_lmops != fl->fl_lmops)
>> +			new_fl->fl_lmops = fl->fl_lmops;
>>   		if (want_write) {
>>   			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
>>   				continue;
>> @@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, unsigned
>> int flags)
>>   		goto out;
>>   	}
>>
>> +	/*
>> +	 * Check whether the lease manager wants the operation
>> +	 * causing the conflict to be retried.
>> +	 */
>> +	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
>> +			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
>> +		trace_break_lease_noblock(inode, new_fl);
>> +		error = -ERESTARTSYS;
> -ERESTARTSYS is for syscall restart after signal delivery, which
> doesn't match up well with the semantics here. A better choice
> might be -EAGAIN or -EBUSY?

What we want here is for NFSD to return NFS4ERR_DELAY to the client.
Since EAGAIN is the same as EWOULDBLOCK, returning -EAGAIN would not
break out of the while loop in xfs_break_leased_layouts. Returning
-EBUSY is mapped to NFS4ERR_IO.

I don't like -ERESTARTSYS either but as how xfs_break_leased_layouts
currently is, there is no other choice.

>
>
>> +		goto out;
>> +	}
>> +	ctx->flc_in_conflict = true;
>> +
>>   restart:
>>   	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>>   	break_time = fl->fl_break_time;
>> @@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>   	spin_unlock(&ctx->flc_lock);
>>   	percpu_up_read(&file_rwsem);
>>   	lease_dispose_list(&dispose);
>> +	spin_lock(&ctx->flc_lock);
>> +	ctx->flc_in_conflict = false;
>> +	spin_unlock(&ctx->flc_lock);
> Unconditionally clearing flc_in_conflict here even though
> another thread, racing with this one, might have set it.

I don't see the race condition here, flc_in_conflict can only
be set after flc_in_conflict is cleared since while it is set,
other threads will return to caller with -ERESTARTSYS. All of
these are done under the flc_lock spin_lock.

>   So
> maybe this error flow should clear flc_in_conflict only
> if the current thread set it.

I think that what the current code does, unless I'm missing
something.

>
>
>>   free_lock:
>>   	locks_free_lease(new_fl);
>>   	return error;
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..e7777d6ee8d0 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -747,11 +747,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>
>> +/**
>> + * nfsd_layout_breaker_timedout - The layout recall has timed out.
>> + * If the layout type supports fence operation then do it to stop
>> + * the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return value: None.
> "Return value: None" is unnecessary for a function returning void.

remove in v2.

>
>
>> + */
>> +static void
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> LAYOUTRETURN races with this timeout. Something needs to
> guarantee that @ls will remain valid for both racing
> threads, so this stateid probably needs an extra reference
> count bump somewhere.

I think the same race condition exists between __break_lease
and LAYOUTRETURN (client returns layout voluntarily) so there
must be an existing synchronization somewhere. I'll find out.

Also, the timeout value for layout recall is currently at 45
seconds so the chance for race condition between LAYOUTRETURN
and nfsd4_layout_lm_breaker_timedout is pretty slim.

>
>
>> +	struct nfsd_file *nf;
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		return;
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +	nfsd_file_put(nf);
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_conflict - Handle multiple conflicts in the same file.
>> + *
>> + * This function is called from __break_lease when a conflict occurs.
>> + * For layout conflicts on the same file, each conflict triggers a
>> + * layout  recall. Only the thread handling the first conflict needs
>> + * to remain in __break_lease to manage the timeout for these recalls;
>> + * subsequent threads should not wait in __break_lease.
>> + *
>> + * This is done to prevent excessive nfsd threads from becoming tied up
>> + * in __break_lease, which could hinder the server's ability to service
>> + * incoming requests.
>> + *
>> + * Return true if thread should not wait in __break_lease else return
>> + * false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_retry(struct file_lease *fl,
>> +				struct file_lock_context *ctx)
>> +{
>> +	struct svc_rqst *rqstp;
>> +
>> +	rqstp = nfsd_current_rqst();
>> +	if (!rqstp)
>> +		return false;
>> +	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
>> +		return true;
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>> +	.lm_need_to_retry	= nfsd4_layout_lm_retry,
>>   };
>>
>>   int
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..6967af8b7fd2 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -17,6 +17,7 @@
>>   #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>   #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>   #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>
>>   #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>
>> @@ -50,6 +51,9 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>> +	bool (*lm_need_to_retry)(struct file_lease *fl,
>> +			struct file_lock_context *ctx);
> Instead of passing an "internal" structure out of the VFS
> locking layer, pass only what is needed, expressed as
> common C types (eg, "bool in_conflict").

fix in v2.

>
>
>>   };
>>
>>   struct lock_manager {
>> @@ -145,6 +149,9 @@ struct file_lock_context {
>>   	struct list_head	flc_flock;
>>   	struct list_head	flc_posix;
>>   	struct list_head	flc_lease;
>> +
>> +	/* for FL_LAYOUT */
>> +	bool			flc_in_conflict;
> I'm not certain this is an appropriate spot for this
> new boolean. The comment needs more detail, too.

I will improve the comment in v2.

>
> Maybe Jeff has some thoughts.

I will wait for Jeff's review.

Thanks,
-Dai

>
>
>>   };
>>
>>   #ifdef CONFIG_FILE_LOCKING
>> -- 
>> 2.47.3

