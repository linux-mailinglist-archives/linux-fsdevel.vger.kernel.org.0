Return-Path: <linux-fsdevel+bounces-7028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5988202D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 00:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224E61C21A23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 23:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE714F63;
	Fri, 29 Dec 2023 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MCRhoVrM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZHDKvEm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEC14A9E;
	Fri, 29 Dec 2023 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTMSDw3010301;
	Fri, 29 Dec 2023 23:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=jhqH1oHSf6OJhBm6fBfyXDIV0qWTP3TG+opXTHIHL7Q=;
 b=MCRhoVrMxY8JkciybOSnoYrH34l6ReDFvyXYY0jCju9yIoP3hUjbiHoGp9dQ1sWmHbGt
 l+mEqr9rtVWdnn0GzX9GQ6AhHfooZ4zTFQjmt1agBO4QJ2/NJ7W7AJwSX6LdRaB1xCk8
 R7x0sDn+OL4nLqtaMqTM4fJx3iGSK3a09eXjs33qGrJq4ysPNrGdFKuyY3b4ECpRzzBj
 t+r4iJrcBRTEDcwNhXgV84sW1ld3sPRVPNrRnW742o7bL2IH47pg3hewxt3bmMX5HVNh
 4Th7hkwS5qb1UIh/cchd6/uyujVLjW279+fNDCDrpym+YRAPtFPoZLJfJL81vfLohGGR 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5q5ug2cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 23:29:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTLUhWk037040;
	Fri, 29 Dec 2023 23:29:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v73ae026w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 23:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5GXJMD55bN8h3NdJzO5cgEoBpOJWCjdZ99TbmhJpgHY26j5gAGdAeenwwRXhgNEES1f+NQphYn/g2omu7ev5BHJl/Gxzaa6gh7fnqEOPUmubThOEUH+7yplqgibD+I4Brr6bDVig6L+SmJXtb2tK2pjI7PDFXxx5HGv4a1PPs2urcavWRVpo65q8upO/m7SSQkBLnDg8Ev0m3fg+i3k08ViSRSDDldcuQpzReSWSbGioH7kPRkmkjH6xzXN9sFtSUDjK/Nsu/oje0o1oRBiXQ7+nz3W40DCvJZiVo/PCU68yWaAPP1oAshn5rqihqGl+ti/+hK684+tGrsvbGH+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhqH1oHSf6OJhBm6fBfyXDIV0qWTP3TG+opXTHIHL7Q=;
 b=nARnoGDiYpTw+Sgdtf6LeNYog5L6yN7ttFSccq40mmMtE2+ql4MADILB/1VH2aSgs9lJjhIegKYtBWsZ4Bk/UxuFW1rhOpltMwTcHq9AHyVel6RtnXaL6czEaMn3hrpckgwFz926Y6/QEtNaqHz7i/lJk+FxKfsYa6DaMUBbqBk/Q5DnFkDYSrFL714QjpBiEqHe07uBRc41s5ul2YupMpdjZ8nB8a1MIlx8JMb6qcL6n+sVaU9L8azQLzv5NAsDb6Cv/TRD8w0L1VE+waeDCb3N3nevRVDm4pNzxmHBvF3FnEVZtAGQVTxI3fuaLtz4ujqc4F9HfxjgddyurROljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhqH1oHSf6OJhBm6fBfyXDIV0qWTP3TG+opXTHIHL7Q=;
 b=ZHDKvEm5ZCNhyXGYH3vVefa2N6De9U53E5vBU4DeRsgkZ41cA/Bdr3dN/rQSDkAFQj4o0qEghzEnJP8GdgAexTFfcVnBaNIQWfqg0BPoVCP8XIRhHPLFjSiGepeGAsOTtyH4eSFzFArzWHpprEjbbFR+qxxDc/GSStvDFDpD+zw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4767.namprd10.prod.outlook.com (2603:10b6:a03:2d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 23:29:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7135.022; Fri, 29 Dec 2023
 23:29:03 +0000
Date: Fri, 29 Dec 2023 18:29:00 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: trondmy@kernel.org, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Message-ID: <ZY9WPKwO2M6FXKpT@tissot.1015granger.net>
References: <20231228201510.985235-1-trondmy@kernel.org>
 <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
 <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net>
 <CAOQ4uxh1VDPVq7a82HECtKuVwhMRLGe3pvL6TY6Xoobp=vaTTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh1VDPVq7a82HECtKuVwhMRLGe3pvL6TY6Xoobp=vaTTw@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:610:cc::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: b8abb717-08f9-4510-63f0-08dc08c5f16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2Gn+Qe/8sROGJ5jW1uD6Fc4xpXQCZqSmGXi734E5ddIXUavRjVGrmxT5CNlUDPfMETvrzef9LC1VIBxymuYULjH4JJ8HVtNpcLn5JSEdXzggipOoxdetdN95vD42gxVoV+b3/ZzjZxJDtCTIu4VrC+mzLsxXuccuSr6apyOj/7Z48Q7C2wJbauAaf7px+BM/krJfT6nMlG/cm6ZP7WQrLfWn1JUI+qG0pCanLFbRroohZ3kRgx9sNwTaUSDEqt91FBoiHDgo7jJgM2Hcy09Ze7l1koXbwzvuzZ1nP2WzzllSO/E4vBk/B6ojAGEt6COiqWlQ1utvy+Og7XzYXGbtyenMlICA1CaJ7LAxs5KFLy3o2OatGhrcTCVz/PVMUSl8SSF4SbppOU+8eJ8nVfCdUQwpeYF7PmZ/M36I93UHCFBnsieM3N2Hyv7xAVAT5YUqlZPRlsRdruiwlA3ftmoT8BSAA8N89Btwi6gfJ+9GHeRbB6B1gmgIlUPAWMU3LVX4+qNaDWZi3gex9v5X5eEaFkIvG4dlm3bXB8pFAQ294E6wXEpH210Hgwgiricid6BS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(9686003)(6512007)(53546011)(6916009)(54906003)(66476007)(66556008)(6486002)(6506007)(316002)(66946007)(478600001)(8936002)(4326008)(8676002)(44832011)(5660300002)(26005)(38100700002)(86362001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VXN4WndxblBMYWFBYkEyTXNwWWRSUUx2TG96UlZzVkZ3Rzl1T1JjaFdXanJW?=
 =?utf-8?B?Mm9jWHVsVHJ2MFR6blVNOVozSmhDRFNFOHhtK2ZyK0g3a25VektNc1diQU1D?=
 =?utf-8?B?VDZLdkwzdnNPb1VWQXRqYjhlYlRMUm42TnJkUTNwR010QVdCVjRxVjc0RXJy?=
 =?utf-8?B?ZlZvdGVoOFRVSkY3SmdaOE5WKzRqMXYvOE1ZZWlaclp1UnVQTkRTNGJaSnBk?=
 =?utf-8?B?TnhxZDBmUXdKQjNvdE1aVEtDdDhZNDdiNG1MSG51WXhsN2k1a3VDT085c29r?=
 =?utf-8?B?WVZYL2lNd09qLzJVcnlURktzdldKQzB1dXdOK3R3VHpjUEdCY2JlbzREaW45?=
 =?utf-8?B?dEZkaTU3b1Z3bi9pZG83dEg4T1lCdk5tYVB0ZVdiQlhESGZLMTVDK0JXWDYw?=
 =?utf-8?B?SlBtakFIVmdvQlRQQjIxNWcyMDdPaGs5ZWdDMGRWUGVRWjdSN25yVC9zNXRL?=
 =?utf-8?B?bGJXaVFMZyttdUQ4YjM2a040dUtQRDNLNW90endlc1RyR2w3bmxYUDFyVXFV?=
 =?utf-8?B?czVBMENSeTdkY09hOHdkV3VZTFYwSDFLSWNkME9mMElOWlJ4MzBRdldlUlhW?=
 =?utf-8?B?ZGZSU0FMSUhGbDZMYytkODRGRHRMeENTaW14RVdyZzRqYUdHSW00U0NOMlZT?=
 =?utf-8?B?V0JodVZOOEpNUWkwWlRXQ3ZUem52NXB2ekJoZjNzY0pPMDF5eTBFT25lSDdH?=
 =?utf-8?B?M2JLRDg2dEtNZXVPQzliV0dMNm5EcGJnRVlVczIyQTBUR3dtTkM1c25Kemwz?=
 =?utf-8?B?TEJRTEZDOFFQdmZDdjlPd0lvZytzaERsVVI3WTA1N0VTUmNYbkhLOS9lMktp?=
 =?utf-8?B?KzMyZFZyYnlSbVM2bUlIS2JsR2x0UElFSUFsMFBOWU1FNGs0eWZFZ3VPcXlD?=
 =?utf-8?B?ZklRWDRxLy84MGtOUVVKMzE0QjcrYWRBZUMrNGZsU3VzSXlGd3poakNXRVl4?=
 =?utf-8?B?UEVKU1BHaUc0SDJOS0x5NDlYSWttQUNNVmU1Vm5mdHJPTWt6YSs5bXRzcTBx?=
 =?utf-8?B?bFVQN2hwTlkwaEpxTnBndjhaMjNOM1Y5NTRMTXNIU2kwalRLUTRsSkJDUEZV?=
 =?utf-8?B?M1hmVmJNV2E3N0ZSVXJhWmlqLzVEdHVuS2FIZDJLTTgzTVBhK1BjV0JzbHBZ?=
 =?utf-8?B?YjlheW9LQnBnSWY5bnRJanZ1MGxNTE1aRHFTZHlQM0FrK2ZBT0JpYUo1cFIx?=
 =?utf-8?B?bkljaUoxUW1rUEFrMHBhWENTT3pPVXh1eWU5L2Q0Ylo0Qnh4YUFCb2hZVWUx?=
 =?utf-8?B?OWt6Tks2eVdUOHlvQkRucFVlUkNDWVZjTHlUa0Z4MmhQMDRubnRkaE5VdDFF?=
 =?utf-8?B?QlhEL0dNandEMnlzSEw3QnNIVDVqSnNUODhYWHlIUnU5OW5QVExoN3kyUXk1?=
 =?utf-8?B?RDRqWG1CQnhMVGZhOURrNFgyaHBBVDRPQ0lxSkxFalVCYlpFUEVSV1h1QU4x?=
 =?utf-8?B?cHo4N1BvSVovalBiQk0zemtkZjBUUWRTOTNEU08vS2MwOTBUWEQyY3Nyd3dC?=
 =?utf-8?B?NmZwRTc3cHJicUxvbGVyYm43TGZTalE2TUMzU2dmUFRnZ04rWDRyT1dhd01T?=
 =?utf-8?B?ei9XU2xWNHRkVFNFL1hGZkVxTUFvNVRyeDJtUGpUdkluSTJqcGpodzNLaW4r?=
 =?utf-8?B?bmY0RWd0b1ZDbi92WVRMK0hNS3poM2hVWFdyb2Rva1ZIZ0ppelI4UWJhNGNj?=
 =?utf-8?B?T1lEME5aT2F2eGZnWkF5OWpCNmtpMzhSb2RlWU5jY2hsVTJqVG9WeWJ6ZTF1?=
 =?utf-8?B?eU5zZVN0cnBOdnJWVHc2SUtQZTV2c0NCakNnNnZ6RlVKTGJTeFRlcGFkWlFE?=
 =?utf-8?B?UEhrUUs2NW9YblpOY2VDbEw4RkdxQ1d4NHFEU3YxME9remtLZUxMYmtSS0Qz?=
 =?utf-8?B?RXhDMnJ0SWV0UDdXdm5VdHlDNXRHM0JZU2ZlZHlRN3h6RnZKajN6WEpyd3d0?=
 =?utf-8?B?NEdnWEM4N2xTc25UNXdtT0h0WFMxMGJjRGpRNUdkZStHRnBreFV4ZEhlUjRM?=
 =?utf-8?B?cjBSNEFONnUrdWxEZmMvZDlWelc4WC9FeEx3dkY2cTNBRHVXMExkc0QyNGNI?=
 =?utf-8?B?TGVnZk42SkxMd3FjUEZjOTBEbjJlRldPUVdFSmcwMWg5SURRcDhraVFRTm9x?=
 =?utf-8?B?Z2F5TDhxQVpxa25yUEdYenVOOTFlWW55R2ExUDNIaTRCMjA0VlpFcnNzMkZ4?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZIljVHdIJEV57p69d0KThCZedc0XHEOsI47A6U7tqF1mjZ2Oa2PYyhyi516LcXSHyEornJrXGkzfDjM+y9hN6h+09WS37ptGM20fQw2btYugEZ4QKx36yO8YKC4pGwOGwUsavFvPfgpEqrD8+B0ZeKYyluCSbDgzit0xOXvSvJ5UBIjzIw7xNwvFLwjazTZP+OQb43B3yFbpVkSqYdNIuJoTHuqLeS+k/fz14OI5xdaRB85Dfs+JC+HDGu842jTIAoNTU3jlEjQynny1KQ7w0qZLKDQxZ281Oc9Wy6ung5Hw1/C7tJPvPgzA99mzpYTCVddnLZRZxdCgZkiN9rY1vCzezG//u8xSAIH2QA/7CizZnbB1ompq3Y5ZlIMxBCbw61tdveu52gttZMd2N7I5EG/NyHd3FaL3qmDRzmqC9O89aJbN8vBrgS6tTye0S/eSpa+h9iMHJmof5aan0chDcdUwFV1UmPpYmz3YlCSwSBBpj2KgZ+P1FRFtaYLYusBhxhgD6+vnaYjLwxNzoOr5+2lgdKuQcSm62JtmSO4hvWhipbvSuGzLDsd6EEpEYtyJ9TRWAa+0LHnXEYev+fkTfgpsco4/qVd/K29C+JJ5whg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8abb717-08f9-4510-63f0-08dc08c5f16b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 23:29:03.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DNb4CP2tk+gcpb6lqVXGM4PTvDzJmQxRIGX4v5DZSlz8X815Kxt+WG/Cjga5MmhVOz+o1k6Re0S+6QFFrZ1rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_12,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290189
X-Proofpoint-GUID: mAxZ8Tu2wkoj8Bp1a0Zu-RJYv_OxMqeL
X-Proofpoint-ORIG-GUID: mAxZ8Tu2wkoj8Bp1a0Zu-RJYv_OxMqeL

On Fri, Dec 29, 2023 at 07:44:20PM +0200, Amir Goldstein wrote:
> On Fri, Dec 29, 2023 at 4:35 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > On Fri, Dec 29, 2023 at 07:46:54AM +0200, Amir Goldstein wrote:
> > > [CC: fsdevel, viro]
> >
> > Thanks for picking this up, Amir, and for copying viro/fsdevel. I
> > was planning to repost this next week when more folks are back, but
> > this works too.
> >
> > Trond, if you'd like, I can handle review changes if you don't have
> > time to follow up.
> >
> >
> > > On Thu, Dec 28, 2023 at 10:22 PM <trondmy@kernel.org> wrote:
> > > >
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > >
> > > > The fallback implementation for the get_name export operation uses
> > > > readdir() to try to match the inode number to a filename. That filename
> > > > is then used together with lookup_one() to produce a dentry.
> > > > A problem arises when we match the '.' or '..' entries, since that
> > > > causes lookup_one() to fail. This has sometimes been seen to occur for
> > > > filesystems that violate POSIX requirements around uniqueness of inode
> > > > numbers, something that is common for snapshot directories.
> > >
> > > Ouch. Nasty.
> > >
> > > Looks to me like the root cause is "filesystems that violate POSIX
> > > requirements around uniqueness of inode numbers".
> > > This violation can cause any of the parent's children to wrongly match
> > > get_name() not only '.' and '..' and fail the d_inode sanity check after
> > > lookup_one().
> > >
> > > I understand why this would be common with parent of snapshot dir,
> > > but the only fs that support snapshots that I know of (btrfs, bcachefs)
> > > do implement ->get_name(), so which filesystem did you encounter
> > > this behavior with? can it be fixed by implementing a snapshot
> > > aware ->get_name()?
> > >
> > > > This patch just ensures that we skip '.' and '..' rather than allowing a
> > > > match.
> > >
> > > I agree that skipping '.' and '..' makes sense, but...
> >
> > Does skipping '.' and '..' make sense for file systems that do
> 
> It makes sense because if the child's name in its parent would
> have been "." or ".." it would have been its own parent or its own
> grandparent (ELOOP situation).
> IOW, we can safely skip "." and "..", regardless of anything else.

This new comment:

+	/* Ignore the '.' and '..' entries */

then seems inadequate to explain why dot and dot-dot are now never
matched. Perhaps the function's documenting comment could expand on
this a little. I'll give it some thought.


> > indeed guarantee inode number uniqueness? Given your explanation
> > here, I'm wondering whether the generic get_name() function is the
> > right place to address the issue.

-- 
Chuck Lever

