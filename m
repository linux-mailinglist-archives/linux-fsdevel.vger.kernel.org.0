Return-Path: <linux-fsdevel+bounces-28881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1D196FC2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 21:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A01C25296
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 19:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B31D4146;
	Fri,  6 Sep 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K28p+rBT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MF4DoOJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBC1B85EA;
	Fri,  6 Sep 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651130; cv=fail; b=eWdMdp0qjES1GhYj+xs6dM2lTgIhK0Iwjs6fkSHHrYt5UFiDIKmCtGVTl+bdneFdmwl0IYH3NB4dgQe445jsCW5ngjxicaFf3JS6T2OnocZSm1bph8REgQzxMruPhVkHxx+jIjuBt/sUEwsgmT4fyhVdjrlhN3QDa0iozeBPd7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651130; c=relaxed/simple;
	bh=T+YFSQldoN9qyp0zUPo+bjyXNMZy7VWKnzv+CSKsxRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=csTaBSgbiBxBSHrgVyfE4rDRGHEn56h7XsoZrj8/YrJ8isn/BN7U2lFjBLdtLryXWqpqomgsEkSVRP2fMPtEP6zTQLZB8Ety0NbybOcgRDqhVrdq9po0J+KRdjQx2nOp1kUfX9vYmedeFEbQ/MZZcyVlt5KPOPLtwytu4yQM35Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K28p+rBT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MF4DoOJm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486FtYUc007093;
	Fri, 6 Sep 2024 19:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=cM5G8JqBsVQfPcm/SfaFmL3N0PgnQxYuucVdJxkTTMw=; b=
	K28p+rBTNkG59MEhgjXEmU3jK9DgMe9C1C6iRtztLHNlB41ddHMNapjs/V/Eq/1b
	4hMXu0gmzE1jYKdukQ2a1lAKDHIFewKDVCcX19yssDhieijv8phQmu7h97oPJkSe
	cF0fvtHGQU0bfh2KhyvaUOyQqKgw5Qak7y5icGdE8HyChncQ6z/WQ4fK9Jko+K1o
	LeB06xaaXWCgdQltuoYAkAjqNiDUOz0xJ5DQIPdX95AkcanJKAzAif3mS4Yns3m6
	n5aKD2DBWKCgL+C5yTkpJ9KbBm4eWMUpLCmtdmXhBupzd5LaX5wHTPGQhJUp25qB
	VP2hvIKl8CYKD68iK7G/pQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwkaeqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 19:31:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486HpUup040889;
	Fri, 6 Sep 2024 19:31:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhycc4jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 19:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqlfZanV8qSblN9Lpf5hk0bzJRUIFGS4c90oR9Coqk+IeltgZGkFhnx95lB3ghDCfugh+ty+9uqdUHCgVC6Pzlar1OiJMKsXCrO3owOxa/PGAaNROLbR0eDr8Vk9GiDgXlxR6jerJ8u9KfDA0wrwVmigfgZbssg25cUMio+dWmzENDDDyYvUohgkUMcZ6kBvlPvI+VN+swceW8QDC4RGnFxUJwFqqAYLf94df/BAnDpFLLWA1HPjrl4luYflOmEpWf7qExpwVPsz04sSg3ANOHWo8Fh03dvHcKMAw3MjcWWZH5mEdumOjNd+WBTQWp1wzl/P30Bi/DASaSM8I5a5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM5G8JqBsVQfPcm/SfaFmL3N0PgnQxYuucVdJxkTTMw=;
 b=aFFEH1Tw10T2VLcghWN/Ph6w5mDK9H6KXSOYB6EeN85O01YDa/qgDl6frbYrlixBufD9JC8VnEM009WKvK45R0GTBUrdyvOwjwwJJRqUfrXq2VELTy2tYmuoADQoxcp3yCNLBjz4nDDzN0Rql2/+pVQ6xkQ9cNr/ghJ4m2656ZFn29/2hiQpCydjcjcQho1lMHhiNfbjC9gxdt1cjH+Kh0pOVKbvYzw6Zh6LHzYfGZhhQEyEHwI/CuGq4T7V+OXg3lHOLZTKYD2LMUs/COuauBMdbB4BB+fCrWVpt1/omCAMkp5x1PTqyv1yxoK7/3TnmDZl0LvtLNtSHzlmF+nAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM5G8JqBsVQfPcm/SfaFmL3N0PgnQxYuucVdJxkTTMw=;
 b=MF4DoOJmCdwPQ6yeZtu/+NfhEtI4pJ3g8tPiD407cp09YK1HGnufNBnMSRwOtoZIZLxQoroH3FgqccGXu26j7X4S+ooLuqepK8MQ8f8IEYHcNukqgdsd47+e0v0b/9kGEfplxOTCgbcuTBiskakfY5QNOf/QeTLEkjlEr+YiK50=
Received: from SN6PR10MB2958.namprd10.prod.outlook.com (2603:10b6:805:db::31)
 by SJ2PR10MB7013.namprd10.prod.outlook.com (2603:10b6:a03:4c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Fri, 6 Sep
 2024 19:31:44 +0000
Received: from SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932]) by SN6PR10MB2958.namprd10.prod.outlook.com
 ([fe80::1aa6:4097:e5c6:932%4]) with mapi id 15.20.7918.020; Fri, 6 Sep 2024
 19:31:44 +0000
Message-ID: <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
Date: Fri, 6 Sep 2024 15:31:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
References: <20240831223755.8569-1-snitzer@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:610:10e::18) To SN6PR10MB2958.namprd10.prod.outlook.com
 (2603:10b6:805:db::31)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2958:EE_|SJ2PR10MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: cdda491a-1346-4d77-7450-08dcceaa8a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TExNNG1qT0Zhay9NWVpJbkJXQTVibExtdkQrckxnWUF3d2hDcWFDMC9Lb1NG?=
 =?utf-8?B?SFlEYzJ3a3N6TCt3VG82czhuZmpYaFhneXlJZnRDblo3cVB6SjRvVmQwbWVs?=
 =?utf-8?B?cmRPdmM0RDFQR0lnMm91eVlSMUhLWmg1RVowRm8zbkV1bWk3ckJpQUxHc3Rr?=
 =?utf-8?B?OTRaS1lrMWgvQlVXaG94Wm55SFlVMmYxMXE5VWtobG5rZFo2S3pma3dkL0FC?=
 =?utf-8?B?ZnZ0TkZ1YWdyU1RyOVc1UU82eWZVWDZWd2VTbExrNy91QW5vRStQSi9mOFpk?=
 =?utf-8?B?YU9aMXNVWXF5cVhIcUViSXNzUXRCODFNOTFRR0o5RVFsQ3BlNGE2NjBjYnMz?=
 =?utf-8?B?Zng2ZS9XVTcyVFFXRmhTdlBvNjZkT0RsREJXeUh5YThaQm9FVjRXTWFZWFhs?=
 =?utf-8?B?bUNlSFVmcEhnaHhndHJyS00zVkZzSnJPNGhyRHdleWFJSXltNVdkZHVjV3lP?=
 =?utf-8?B?ZHRRS2hKRlZOemF4dGlsbTMvVFpYZExORHhlc0dBeUdlZmx5eXVrV296Ulhk?=
 =?utf-8?B?SWNOdG9EUHBWVUFaREU0RTZPRm40UU5xWnh6YlpEU3JpMjdBSDhFdVdnVUhJ?=
 =?utf-8?B?a05nMFhNRFF5Q000SzhsRTBKcXkzYlRvTU1QV0EwZ2ZheUxrd214R3A1UTVj?=
 =?utf-8?B?ZFpKeDIwN3hKb3BRY3F3bmF3bUZDdlprSW5NQ29yczFXMSs5b0Q0aEZtMWdG?=
 =?utf-8?B?RHM3Z25OTjl3UVhNYWQveXBRSzBmUFVXTXluVE16ZzRGMHRDSDNyR0FwOTZ6?=
 =?utf-8?B?MC9jZ1dESUdLVHBtM1FoaDluL3EyUTd5UjdFSURqQ0k1MWk2MysydDJScnF6?=
 =?utf-8?B?a21qc2FaVklWQzRIejB3UHl3aytyY2tQdEx2ODhwU3ZndGVxR2x5SzJta3la?=
 =?utf-8?B?L0VqOVppVWRMQmdYRjRCZXBQT2RYREVIb250K1A4WDZJd3ZHemVEZ2pRSEFG?=
 =?utf-8?B?WUxqWUV2dkhRMUFDY3prWHUxZFZBMDF5bXJMNVlyMm1pajMzZzd0YUNCRGhm?=
 =?utf-8?B?ZEsxOXU4MVMrVFFXZUtVL2Vwd29heHNIUE5FS0kxYWJrQXZEc0p4THdLd1R1?=
 =?utf-8?B?VzFUWHlnSEw5MnlqcmxEVVEyYjVGZ3I1VEpZMGFRb3FKaUhHWWY3RHEzSncv?=
 =?utf-8?B?eEtCQXlWK3BFaDErN05oamo3VEN2TU9XRGJKWnBud3ROK3FiYTg1OXExTlJv?=
 =?utf-8?B?djlJZUpTWW90Zkw5Zng5TktaNHBZcGxoaWdOekdXUTZjMzhUVFoybmFRUEpl?=
 =?utf-8?B?b1pWRENMU01uWFBqRG9xck9OUGFqTzFhSGZ3Y3JtZjFXTDV1SGlQT2MyNlVU?=
 =?utf-8?B?RVFKMityQlJTL3RXVnZpZDRlZmJTdXBIUkYyamxSbVhTdXorU0FRcy9mZ0xX?=
 =?utf-8?B?Q3RGZjc4TnFSaXBxSkNrRkppS0d6NW9ScE9oQWNEWWkvK2k0Kzh1WllsYnZG?=
 =?utf-8?B?TVFoNHd2RDhZbjJxWjZNRGVPVytKenBuZDFMSSsrOENHN1NrbGZPK0svNjNw?=
 =?utf-8?B?WGNKSitXeENzVmxzSXVEaFRiTVdaaUhqd2FNRW9CM2hkSmR3bW5BZk1rczFI?=
 =?utf-8?B?MjdLYUJwanR3SE9sYlM4eGNuOXpWTGtKNUVlbVpIeTFuRTU1MkI0K0RJYjIr?=
 =?utf-8?B?amZvZGhYSzAwOU84dUhvc01lamVmbGRxZFhTaFNEZnhaUzhVOFhESXZEMDJJ?=
 =?utf-8?B?Tk9IYVpMS1hpYVBxWHRKcHJXdWF6WHRUNTRMbWFPWmRabkx5VjRZQlBXdWlE?=
 =?utf-8?Q?v/DVQvyc9CmTdUL4gg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkhKaERmRm0xY3V0ZEpsWTFHN3gveHlYZENreEozWTZHTzExOHpXb1VhUmRk?=
 =?utf-8?B?V2ptVm1ITXk3eGRZdldWTkg3QVZ1czhCMm9XQ3BJdzJJRkliYWJYZS9KcE43?=
 =?utf-8?B?bmFqdEZBVkNVUnVqQ0FlSEJldU9UY2lDSE5hQkhETG5maUJkdURnMGRhY1pr?=
 =?utf-8?B?Y2N2YmpSdFIyVGU2ZDJDaG9veHkzNG9VMldVL2VKajhJYmtmTXRaUExWMFhM?=
 =?utf-8?B?R3IyYTRsZE9UVFJLNzYrMzhHTU15MThCeFE4b0NWaXd4Ukx5SlAvM3dRZ0s4?=
 =?utf-8?B?OFAvUlRrUHJKN09Bc3FGdFM0OVZnSWpER05NS3RKV2FtTzdHV2MraHdJYkZH?=
 =?utf-8?B?ZDMxcDFQYVg0K1N2cHA0cHZLL2ZNSDBDYUdyYjRtUXMwTUYyUzRYWk9WYWJI?=
 =?utf-8?B?dE45VC9RZ0VxVDJsK1BpbU1vTE1VbjIrMnZrY2JiV1JDRXNnSlRpSDBSSE91?=
 =?utf-8?B?R3F4M1dGYzN5U24rVGs1aTFEVGRBQTJEcE5Pay9rbkM0dzNXZkIzQ0ZMNXU5?=
 =?utf-8?B?VGtSVGdMMVdqU1NreFo0Y3k3TTBBQWZvbkJsT1ZaWXhkSXplQUFpK2dEWVlx?=
 =?utf-8?B?VEVEZmpCZFRNRjN3UzAxampsWDVjTFR0OUs1Y3J4S2t2c0U4L041aGJEQVR1?=
 =?utf-8?B?c0p0YTl3bVBuc3V3K1czWTJxNnNXemVkMEF4amZmOFVPTkR5TjJHdDhySlR2?=
 =?utf-8?B?cHkxeUE0UTNHdnNRZDdhUzBCVmxZbEtlVWZITWZTRy82SysxaW1YaUtGblNn?=
 =?utf-8?B?Q0xLSis2K2wxWXhoNldIMnBUZ0tYMVJHaDRjeXhkN3JOSXJZOXN4S2F3dzE4?=
 =?utf-8?B?TzRUd2xqbFpsQzRha3F5Zm1kRHFNcG5ZSHpkQWdTVmtMUGZCMEZ0RkdUOExl?=
 =?utf-8?B?MUVibDU4aXFORkNJN2FRK3NDdEQ1THN3U1pUei9wbTEwUWE2b2tZYm5HbXJ5?=
 =?utf-8?B?V1Nra2hEbldKSkFHYTQ2Ky9GaWpvV2hWbEkyTzBHZkVtSVlqUmg2d0FTWmxq?=
 =?utf-8?B?N0x3c2IxY28vWlJFeTFMT3Y1TUdhWWd6c29QVUFHdml3UUpUMDYrOVFaOEhx?=
 =?utf-8?B?dTAyNXd2eHIzbjc1OWdkUkpzZGRXQkNNZmUzbkJwWklvWjNDbEdiNFpYTmx3?=
 =?utf-8?B?RGhPQnIyLy9BU3VIanR3eTFMMFhkRk1UQ1QvRE1sdmxGc0FaM0hCcHVDVkk5?=
 =?utf-8?B?aVQ1RzVubG5tSDNjYytLSlpXLy9iRmJPbmNFaHRtWUN2QXpDTE5TWEwyMkRP?=
 =?utf-8?B?cTlYSUpCK0FoWmUzNEpRYWE1WlhhR1RVK3FFN1hBbUJDM1d4TnFlUDlYcnNK?=
 =?utf-8?B?dW1XOWg3RUcrY2RFZGZHQTdaSEVSUVRMOTRhVWpGN0t1MGkxT0JFT2MyU0Fn?=
 =?utf-8?B?M05zQVJ6NjF6YnNCRTYwTmJ0a040TlhBNnN4elhqM0dSZkJvcCtaZkdleUtS?=
 =?utf-8?B?WFBCSkppOGlXemNBUE51SXRsTUlOaEs0cGhrM2dReU81V0dTYmQ4R080c29s?=
 =?utf-8?B?YWpIbk1qakdUNzFkaytXM0dtYnIvV3NkZ3EwYlVOUmx5K2RENjZSV3ErN291?=
 =?utf-8?B?Ui81RlF4RXozZDh6dDJRQytyc3l3aG0zN1l5MVZQdksybzNWUklVTDBramNz?=
 =?utf-8?B?YmRQOGJETWZEUHMzVlF5U3puSDVUWnVEeXJqdVZhaytQc1VEaEpmZi9HelU2?=
 =?utf-8?B?dDQvdDRnYktCVmU1Wjgxb0w2cUxadm14Z3ppT1ZNV1NxMHVMUzBtbUdrdEVw?=
 =?utf-8?B?cHA5b3R4Y21aVkZJa2l5dWRMNnF2NlpqOHV0U3VNZjJVeXRXcG44bEFlQTdL?=
 =?utf-8?B?OFBycTEzTmFiT0lZR3JZM1kvNzhLWkpZcm4rNzgveUo4SW9mSFJBNnRtdFp6?=
 =?utf-8?B?R3I2eTREcDRhK3MvYVVMWWd2dm9BdWNlRmlya0UxV05yUmkzckE3MlBJSW9i?=
 =?utf-8?B?SHh4N3BNanBqTkdkWjNKcXpsNDNmdGxYdUtnMXptQkRuR0VMNWd2d0NhTVI3?=
 =?utf-8?B?bmE3RytReUJWWG1yVHd5YmxKejRZemRsdE5aNjZJcXRSS05hMXJjUjNSMWpu?=
 =?utf-8?B?QnJhOE9lQkRTVDFESWgxYnYwYW5kWjNmdTFZSlFrdzNYNTY0TGwxcnpad3Zv?=
 =?utf-8?B?bUQvejRqNmpOR2RudXdBSXZZOUkwTTF0aHZFOXQrNTFYOUVPdU9oTnNYU01t?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DfFs4KTCwEaaGcf95Dch17cOPiGbR4hmJ0y0JA7b8zb37dFZi5cFCmGHwoVBW1xaIQ53QiY2dHK7u5klPqqeGw1I00ql5bqcoTrsGGDLViY37M5ITLseObNP+I0KSctK9fKAUR70wPMptoAfDFmL/NwBGOoil0atSaSQnmrJQMoqMC5AhTdOgPIFTQtCWgP+pHQ32IoyUnPLiCJf83QyTD6KsMPwhtNx5SVpTmYsDCQbByJ40pMKC0G/OIrBNWrxPe4T+h010LcVyGMboiaJQ+MCTxZkQueQ0OJW9cPn7un7nAZU/jEJHQN1ie7aFABH4E9GHXiunmPKuNG5W/0U11367/WSqBq1008SU99AvTZ3TPdDuor5KF048PiWp2PBPwNkBZgMIsQZJarH7leAFq/ww0e/gKB3oxggqYNIxtp3JpYtBT4a4ntUkcPKa9xBurPj82EHftGOyc3iv+27EVbjnnftSgxcHsYlozteG0CgLkjW1ELw1ju27TGE71FXdJui1yxugx2Ls2BjC0eSmUeEkE2B9VfeXUnU8IQX5uExwciEExY+e0GJ6Lw+LsHmMpEIdBOWoxENGyntrlVyCaOnFZvOzt61CrZawfF9SlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdda491a-1346-4d77-7450-08dcceaa8a47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 19:31:44.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQvdPB5a69kULwSersYlKACb3qZA9wKG0RQ+Ok5opy9wg+erV42smjqlVaE5JmFMpSPwDEu1Zlxo7+CXiFtfSDYSJcdK+/UZxFlVwyXIVf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_05,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409060144
X-Proofpoint-ORIG-GUID: zgqbuhjpNT5NIZdaqNJXRZVhUd3pBbAD
X-Proofpoint-GUID: zgqbuhjpNT5NIZdaqNJXRZVhUd3pBbAD

Hi Mike,

On 8/31/24 6:37 PM, Mike Snitzer wrote:
> Hi,
>=20
> Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
> what I hope the final LOCALIO patchset this weekend: its my birthday
> this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
> inclusion sometime next week: best b-day gift in a while! ;)
>=20
> Anyway, I've been busy incorporating all the review feedback from v14
> _and_ working closely with NeilBrown to address some lingering net-ns
> refcounting and nfsd modules refcounting issues, and more (Chnagelog
> below):
>=20

I've been running tests on localio this afternoon after finishing up going =
through v15 of the patches (I was most of the way through when you posted v=
16, so I haven't updated yet!). Cthon tests passed on all NFS versions, and=
 xfstests passed on NFS v4.x. However, I saw this crash from xfstests with =
NFS v3:

[ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
[ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv:=
 empty string added
[ 1502.699514] Oops: general protection fault, probably for non-canonical a=
ddress 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
[ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6-g0c=
79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
[ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unk=
nown 2/2/2022
[ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]
[ 1502.704474] Code: 8d bb 30 02 00 00 bb 01 00 00 00 eb 12 49 8d 46 10 48 =
8b 08 ff c3 48 85 c9 0f 84 9c 00 00 00 49 89 ce 4c 8d 61 c8 41 8b 45 00 <3b=
> 41 c8 75 1f 41 8b 45 04 41 3b 46 cc 74 15 8b 15 2c c6 b8 f2 be
[ 1502.706931] RSP: 0018:ffffc27ac0a2fd18 EFLAGS: 00010206
[ 1502.707547] RAX: 00000000b95691f7 RBX: 0000000000000002 RCX: 6c616e69665=
f6178
[ 1502.708311] RDX: 0000000000000034 RSI: ffffa0f8a652a780 RDI: ffffa0f8c04=
cfb00
[ 1502.709055] RBP: ffffa0f8827b2ba0 R08: 0000000000000000 R09: ffffa0f8c04=
cfb00
[ 1502.709728] R10: 000000000000009c R11: ffffffffc0c77ef0 R12: 6c616e69665=
f6140
[ 1502.710382] R13: ffffa0f8c04cfb00 R14: 6c616e69665f6178 R15: ffffa0f883d=
4e230
[ 1502.710982] FS:  0000000000000000(0000) GS:ffffa0f8fbd80000(0000) knlGS:=
0000000000000000
[ 1502.711645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1502.712087] CR2: 00007f2c4d1ed640 CR3: 0000000117a1e000 CR4: 00000000007=
50ef0
[ 1502.712615] PKRU: 55555554
[ 1502.712804] Call Trace:
[ 1502.712979]  <TASK>
[ 1502.713131]  ? __die_body+0x6a/0xb0
[ 1502.713372]  ? die_addr+0xa4/0xd0
[ 1502.713583]  ? exc_general_protection+0x16c/0x210
[ 1502.713880]  ? asm_exc_general_protection+0x26/0x30
[ 1502.714164]  ? __pfx_nfs3svc_decode_sattrargs+0x10/0x10 [nfsd a9c12e0cc9=
647b021c55f7745e60fc1cbe54674a]
[ 1502.714700]  ? nfsd_cache_lookup+0x2b3/0x840 [nfsd a9c12e0cc9647b021c55f=
7745e60fc1cbe54674a]
[ 1502.715156]  ? nfsd_cache_lookup+0x2e7/0x840 [nfsd a9c12e0cc9647b021c55f=
7745e60fc1cbe54674a]
[ 1502.715590]  nfsd_dispatch+0x93/0x210 [nfsd a9c12e0cc9647b021c55f7745e60=
fc1cbe54674a]
[ 1502.715997]  svc_process_common+0x324/0x680 [sunrpc 2f7328527f188558dea7=
880294960ba75bb09c81]
[ 1502.716439]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd a9c12e0cc9647b021c55f=
7745e60fc1cbe54674a]
[ 1502.716873]  svc_process+0x117/0x1c0 [sunrpc 2f7328527f188558dea78802949=
60ba75bb09c81]
[ 1502.717276]  svc_recv+0xabf/0xc00 [sunrpc 2f7328527f188558dea7880294960b=
a75bb09c81]
[ 1502.717674]  nfsd+0xc5/0x100 [nfsd a9c12e0cc9647b021c55f7745e60fc1cbe546=
74a]
[ 1502.718225]  ? __pfx_nfsd+0x10/0x10 [nfsd a9c12e0cc9647b021c55f7745e60fc=
1cbe54674a]
[ 1502.718641]  kthread+0xe9/0x110
[ 1502.718798]  ? __pfx_kthread+0x10/0x10
[ 1502.718979]  ret_from_fork+0x37/0x50
[ 1502.719154]  ? __pfx_kthread+0x10/0x10
[ 1502.719335]  ret_from_fork_asm+0x1a/0x30
[ 1502.719525]  </TASK>
[ 1502.719636] Modules linked in: nfsv3 overlay cbc cts rpcsec_gss_krb5 nfs=
v4 nfs rpcrdma rdma_cm iw_cm ib_cm cfg80211 ib_core rfkill 8021q garp stp m=
rp llc vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency_com=
mon intel_pmc_core intel_vsec pmt_telemetry pmt_class kvm_intel kvm snd_hda=
_codec_generic snd_hda_intel snd_intel_dspcfg crct10dif_pclmul crc32_pclmul=
 snd_hda_codec polyval_clmulni polyval_generic ghash_clmulni_intel snd_hwde=
p sha512_ssse3 snd_hda_core sha256_ssse3 sha1_ssse3 iTCO_wdt snd_pcm intel_=
pmc_bxt iTCO_vendor_support aesni_intel snd_timer gf128mul snd psmouse cryp=
to_simd i2c_i801 cryptd joydev pcspkr rapl lpc_ich i2c_smbus soundcore mous=
edev mac_hid nfsd nfs_acl lockd auth_rpcgss grace nfs_localio sunrpc usbip_=
host dm_mod usbip_core loop nfnetlink vsock_loopback vmw_vsock_virtio_trans=
port_common vmw_vsock_vmci_transport vmw_vmci vsock qemu_fw_cfg ip_tables x=
_tables hid_generic usbhid xfs libcrc32c crc32c_generic serio_raw atkbd lib=
ps2 virtio_net vivaldi_fmap virtio_gpu virtio_console
[ 1502.719684]  net_failover virtio_blk crc32c_intel i8042 failover virtio_=
rng xhci_pci intel_agp virtio_balloon xhci_pci_renesas virtio_dma_buf serio=
 intel_gtt
[ 1502.724436] ---[ end trace 0000000000000000 ]---

Please let me know if there are any other details you need about my setup t=
o help debug this!

Thanks,
Anna


> git diff snitzer/nfs-localio-for-next.v14 snitzer/nfs-localio-for-next.v1=
5 | diffstat
>  Documentation/filesystems/nfs/localio.rst |  106 +++++++++--
>  fs/Kconfig                                |   26 ++
>  fs/nfs/Kconfig                            |   16 -
>  fs/nfs/client.c                           |    4
>  fs/nfs/flexfilelayout/flexfilelayout.c    |    8
>  fs/nfs/internal.h                         |   24 +-
>  fs/nfs/localio.c                          |   92 +++------
>  fs/nfs/pagelist.c                         |    4
>  fs/nfs/write.c                            |    4
>  fs/nfs_common/nfslocalio.c                |  287 +++++++++++------------=
-------
>  fs/nfsd/Kconfig                           |   16 -
>  fs/nfsd/Makefile                          |    2
>  fs/nfsd/filecache.c                       |   27 +-
>  fs/nfsd/filecache.h                       |    1
>  fs/nfsd/localio.c                         |   79 ++++----
>  fs/nfsd/netns.h                           |    4
>  fs/nfsd/nfsctl.c                          |   25 ++
>  fs/nfsd/nfsd.h                            |    2
>  fs/nfsd/nfsfh.c                           |    3
>  fs/nfsd/nfssvc.c                          |   11 -
>  fs/nfsd/vfs.h                             |    5
>  include/linux/nfs.h                       |    2
>  include/linux/nfs_fs_sb.h                 |    3
>  include/linux/nfslocalio.h                |   64 +++---
>  24 files changed, 410 insertions(+), 405 deletions(-)
>=20
> These latest changes are available in my git tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=
=3Dnfs-localio-for-next
>=20
> Chuck and Jeff, 2 patches have respective Not-Acked-by and
> Not-Reviewed-by as placeholders because there were enough changes in
> v15 that you'll need to revalidate your provided tags:
> [PATCH v15 16/26] nfsd: add LOCALIO support
> [PATCH v15 17/26] nfsd: implement server support for NFS_LOCALIO_PROGRAM
>=20
> Otherwise, I did add the tags you provided from your review of v14.
> Hopefully I didn't miss any.
>=20
> Changes since v14 (Thursday):
>=20
> - Reviewed, tested, fixed and incorporated NeilBrown's really nice
>   solution for addressing net-ns refcounting issues he identified
>   (first I didn't have adequate protection on net-ns then I had too
>   heavy), see Neil's 6 replacement patches:
>   https://marc.info/?l=3Dlinux-nfs&m=3D172498546024767&w=3D2
>=20
> - Reviewed, tested and incorporated NeilBrown's __module_get
>   improvements that build on his net-ns changes, see:
>   https://marc.info/?l=3Dlinux-nfs&m=3D172499598828454&w=3D2 =20
>=20
> - Added NeilBrown to the Copyright headers of 4 LOCALIO source files,
>   warranted thanks to his contributions.
>=20
> - Switched back from using 'struct nfs_localio_ctx' to 'struct
>   nfsd_file' thanks to NeilBrown's suggestion, much cleaner:
>   https://marc.info/?l=3Dlinux-nfs&m=3D172499732628938&w=3D2
>   - added nfsd_file_put_local() to achieve this.
>=20
> - Cleaned up and refactored nfsd_open_local_fh().
>=20
> - Removed the more elaborate symbol_request()+symbol_put() code from
>   nfs_common/nfslocalio.c in favor of having init_nfsd() copy its
>   nfsd_localio_operations table to 'nfs_to'.
>=20
> - Fixed the Kconfig to only need a single CONFIG_NFS_LOCALIO (which
>   still selects NFS_COMMON_LOCALIO_SUPPORT to control how to build
>   nfs_common's nfs_local enablement, support nfs_localio.ko).
>=20
> - Verified all commits are bisect-clean both with and without
>   CONFIG_NFS_LOCALIO set.
>   - required adding some missing #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>=20
> - Added various Reviewed-by and Acked-by tags from Chuck and Jeff.
>   But again, left Not-<tag> placeholders in nfsd patches 16 and 17.
>=20
> - Reviwed and updated all patch headers as needed to reflect the above
>   changes.
>=20
> - Updated localio.rst to reflect all changes above and improved
>   readability after another pass of proofreading.
>=20
> - Added FAQ 8 to localio.rst (Chuck's question and Neil's answer about
>   export options and LOCALIO.
>=20
> - Moved verbose patch header content about the 2 major interlocking
>   strategies used in LOCALIO to a new "NFS Client and Server
>   Interlock" section in localio.rst (tied it to a new FAQ 9).
>=20
> All review appreciated, thanks!
> Mike
>=20
> Chuck Lever (2):
>   NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
>   NFSD: Short-circuit fh_verify tracepoints for LOCALIO
>=20
> Mike Snitzer (12):
>   nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
>   nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
>   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
>   nfsd: add nfsd_serv_try_get and nfsd_serv_put
>   SUNRPC: remove call_allocate() BUG_ONs
>   nfs_common: add NFS LOCALIO auxiliary protocol enablement
>   nfs_common: prepare for the NFS client to use nfsd_file for LOCALIO
>   nfsd: implement server support for NFS_LOCALIO_PROGRAM
>   nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
>   nfs: implement client support for NFS_LOCALIO_PROGRAM
>   nfs: add Documentation/filesystems/nfs/localio.rst
>   nfs: add "NFS Client and Server Interlock" section to localio.rst
>=20
> NeilBrown (5):
>   NFSD: Handle @rqstp =3D=3D NULL in check_nfsd_access()
>   NFSD: Refactor nfsd_setuser_and_check_port()
>   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
>   nfsd: add nfsd_file_acquire_local()
>   SUNRPC: replace program list with program array
>=20
> Trond Myklebust (4):
>   nfs: enable localio for non-pNFS IO
>   pnfs/flexfiles: enable localio support
>   nfs/localio: use dedicated workqueues for filesystem read and write
>   nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst
>=20
> Weston Andros Adamson (3):
>   SUNRPC: add svcauth_map_clnt_to_svc_cred_local
>   nfsd: add LOCALIO support
>   nfs: add LOCALIO support
>=20
>  Documentation/filesystems/nfs/localio.rst | 357 ++++++++++
>  fs/Kconfig                                |  23 +
>  fs/nfs/Kconfig                            |   1 +
>  fs/nfs/Makefile                           |   1 +
>  fs/nfs/client.c                           |  15 +-
>  fs/nfs/filelayout/filelayout.c            |   6 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c    |  56 +-
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
>  fs/nfs/inode.c                            |  57 +-
>  fs/nfs/internal.h                         |  53 +-
>  fs/nfs/localio.c                          | 757 ++++++++++++++++++++++
>  fs/nfs/nfs2xdr.c                          |  70 +-
>  fs/nfs/nfs3xdr.c                          | 108 +--
>  fs/nfs/nfs4xdr.c                          |  84 +--
>  fs/nfs/nfstrace.h                         |  61 ++
>  fs/nfs/pagelist.c                         |  16 +-
>  fs/nfs/pnfs_nfs.c                         |   2 +-
>  fs/nfs/write.c                            |  12 +-
>  fs/nfs_common/Makefile                    |   5 +
>  fs/nfs_common/common.c                    | 134 ++++
>  fs/nfs_common/nfslocalio.c                | 162 +++++
>  fs/nfsd/Kconfig                           |   1 +
>  fs/nfsd/Makefile                          |   1 +
>  fs/nfsd/export.c                          |  30 +-
>  fs/nfsd/filecache.c                       | 103 ++-
>  fs/nfsd/filecache.h                       |   5 +
>  fs/nfsd/localio.c                         | 189 ++++++
>  fs/nfsd/netns.h                           |  12 +-
>  fs/nfsd/nfsctl.c                          |  27 +-
>  fs/nfsd/nfsd.h                            |   6 +-
>  fs/nfsd/nfsfh.c                           | 137 ++--
>  fs/nfsd/nfsfh.h                           |   2 +
>  fs/nfsd/nfssvc.c                          | 102 ++-
>  fs/nfsd/trace.h                           |  21 +-
>  fs/nfsd/vfs.h                             |   2 +
>  include/linux/nfs.h                       |   9 +
>  include/linux/nfs_common.h                |  17 +
>  include/linux/nfs_fs_sb.h                 |   9 +
>  include/linux/nfs_xdr.h                   |  20 +-
>  include/linux/nfslocalio.h                |  79 +++
>  include/linux/sunrpc/svc.h                |   7 +-
>  include/linux/sunrpc/svcauth.h            |   5 +
>  net/sunrpc/clnt.c                         |   6 -
>  net/sunrpc/svc.c                          |  68 +-
>  net/sunrpc/svc_xprt.c                     |   2 +-
>  net/sunrpc/svcauth.c                      |  28 +
>  net/sunrpc/svcauth_unix.c                 |   3 +-
>  47 files changed, 2468 insertions(+), 409 deletions(-)
>  create mode 100644 Documentation/filesystems/nfs/localio.rst
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfs_common/common.c
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 fs/nfsd/localio.c
>  create mode 100644 include/linux/nfs_common.h
>  create mode 100644 include/linux/nfslocalio.h
>=20

