Return-Path: <linux-fsdevel+bounces-12897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347E868487
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854531C21B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73260135A49;
	Mon, 26 Feb 2024 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B2JNsk9t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hSHOGLn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F73130AEE;
	Mon, 26 Feb 2024 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989346; cv=fail; b=KM6nnzkk1018gZOH9wVg+/MqtHUKSEhzam9Ea2ohgg8rZ1OklnAK5V7dOjmOl9LUO1PYGYb+GWIqHPFmJBUJF2puuxFjRlbmL7vB7wvpd8zRxT8vVY28pNdLUuzUCKibcRbh1ojSpdfw8znQbsONigdL0mBvUzeFscb/+OnaGtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989346; c=relaxed/simple;
	bh=w2egwfyb1R2i5khjFyR9tEg3OowTJLbn329uwhnY+wE=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=W8RAs9yMpknTrTsg3sHetRffoxgXW3p7WEQIlq1t2rx7rOtWdqaqDX71C9VjNqVpw9BkJLTDuR5GF4fCcBMdiGTPcGaOrhqJNNXxSNLH9iMcDkstTI4iJZUzq921NjmqygU/g0xjV5kGRQuR0++a/kqAdNGr1UW22y04EGiepLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B2JNsk9t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hSHOGLn0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QMR5mC008930;
	Mon, 26 Feb 2024 23:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=5RmHVyHMsBvUaBqsvDptYK7UEodALNs5xJJW7SFyLYM=;
 b=B2JNsk9t+CwJtNsfIvWhxyVhsG/KvCsF10DxBGfxgOmDipe7iG5B9bSELv3xL728H5/4
 bMmLIUnYk87qkm2uH5z2MaHOQBBDQg7O2TFgNGlXSjhbysF2R5wAc3c2UPmLxfKYhu7f
 GeOIIPThr+MaHb86Qzk904xDMC5wnOrIOUW1O05BblIvDJhZdDmuwsYCvTO/RE8xVDkl
 m6g8OAG6+j4ioT3RZeXht+8Ha2wuCqWfWYKzXsFROR1REc9KGyyGoSV347kSVCE6vW0i
 xAOt5u99ZbAbrS8GoD7bVIo4twJqNW23ML9AN1O1m3ohqPhYKrRAIII5vctZRF9Vo93y TQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u5sp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 23:15:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QLZTVP022687;
	Mon, 26 Feb 2024 23:15:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w6fugq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 23:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGxCOARaeaaWYIZ6SfsFdCQCZUdPX13T2gm21QucA2BJC5pdSRlI59OTCfyjE/NvWhOWcnOrOaEZbvAyXbGSUrplIWt806KMcTv4quXk/52gHrYzg/9xQXtgB6YkQbqcHoEjUy7fwDrLBRlAUvZ0NY2J1zHRhpuNpy6Kv4ypz75/A59aDND2JR/EugFwxYfdxv/QI9P+TPcmgCBOU40CHAqZmVyN0AoNAf15LoClrzscOp6mbsbE6n3b0C4yEgDY3KhIPs6h9x3MUJkPp5ShoEiWdPArMy+WLn3PdvsKgu0CfzhDK9glCPcB30wIAq0vATez5lpOUwPBMu5p++cS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RmHVyHMsBvUaBqsvDptYK7UEodALNs5xJJW7SFyLYM=;
 b=RqoP6Ui7IwJkiNBLiBirw/Ge6oKi6nwG00PSnd6pzYI9t/zOQIq6FXN3NV0t8QpZp4k+Tn8y5oMEIGsc6orb58LC7/IIj1cp5/QZnnteAg5koV6CVjSuUrRFkITdu0bUNfYXLKaZd0h3X+ZTTrKLuvheM/HOKBTi/SiQP8QAPu7eZD4rZHl2AIzphpFZNzj7BIH6noUU9CDhKTbhGUfkIIx+9kG+luV8cT9ve6IoResVfVCesjM/lk5L8+UjZBd9nK90aXR1o7mJ4mTNY1hZhI3ghlA1PPVNjEhqgIIto6QU/1iPodBr5xwKSRqFfv/GLRx2ltWwlBSfd7bYJ0YIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RmHVyHMsBvUaBqsvDptYK7UEodALNs5xJJW7SFyLYM=;
 b=hSHOGLn0yI4ao2rTOj4tZ1oIzsEPAFjkN5mnWBDi7daZJjEWAnRp4+OZimV4u5zIPYnvxf6aHgXJK6G0V8NvW5efz+2A9GLybu1/H+BETFl5kv3DQiaZ6nn31VkJcTWFwOmxBGAh0yDLu8T/vT+/8fY1838McFw3SI0XZKns2BU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4402.namprd10.prod.outlook.com (2603:10b6:303:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 23:15:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%5]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 23:15:21 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org,
        "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
        Linux FS Devel
 <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org"
 <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
Date: Mon, 26 Feb 2024 18:15:19 -0500
In-Reply-To: <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com> (Kanchan
	Joshi's message of "Fri, 23 Feb 2024 01:03:01 +0530")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: c17ce8e7-89ce-406f-c47d-08dc3720cded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MpNdFl9N4YFsMhNfeAJVzDHZQCaC10MHhvg8KlaE+ZMG5Y4Z1p/S9tLvu/e1QirSf8rMXNqEKmblHda2DMvNcYv8Qu89tsgAG6xyf4ute7bX1oz6Tb3YVftgUbDfNy+ldUQhuU5jLVs3D9Is57zq3DVblkHgYJAnk/0bdo3k3gfWICFqv/LJR9HVJlqM0vdi5usa73Vwwt3O43AWBmtUDSvRIhZyT0Zc7SFlhe4B49Z18TTWHz0oeHnDSOybBR/vzCjRcJyfT0KirZOQHXcERmf4r8vEBFpuN7qP1DuGUmiVLVVxAuLhMY3MqmW7U8VHwP6B0WU+w7jx4HLKn3Ma1/tf4G6TwlF80zzbkZgLimy0wuSAOobqWK65IdgzdFIcCTAZrzxwBVMjRgzGK4TqnTB6Gl0kjShk7vUaCBFkuo3KpUI+9RVOzQjlEPH9UWjRmpyHs0H7m/Z9pVCXaWC7ICgO+VLePEE7uhCEs8w66hPJDqXziJOwRyGy4yGuUy3XZie1ZLkqh19pt/cPI7dmI85C72TB97hJUb5fhEjWfs3yidWK3wA9attv63yAaK+EDwq6txFDXt0ZnawCugAytRDkA/NNwzuWbRZ91w+Ay0f28wiiDPDPBsAyDAboAtLAD496f7Cw42SSTspluD2yzw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iEknIPKUptw/Q8p581p7s0lSyLtQrsfdsYnHej8VHMVvnDKtEy6Pa6Ww6GxE?=
 =?us-ascii?Q?rCyTs9/72y1gS+3ar/z53ph2/NC1ysfvHCVycoxMdWDNCauSbkmWkFnzKtnm?=
 =?us-ascii?Q?4Jf/XwkU3BzSFpFBYr2cIufCnkcl+Bx/3xq7qZeHhBJRo8qT14YcOCzX2Vop?=
 =?us-ascii?Q?DTOmWrCIxSK5LCAjQIkbUE3ALfshYe0dUBBhyZg12Su+mbb312bZ4m89dWiS?=
 =?us-ascii?Q?REcdzHBotsgxMapIjZTSqwUK17oVN/rCYxSXs/egyfXPD1zoyiEkqNSwcedF?=
 =?us-ascii?Q?WSPFygiUh71nFP+Kly8v1LhKrvt8hnaINz3vyU+f3GAVYOvQeUizzOYODyqw?=
 =?us-ascii?Q?Q54yJhpDvtaid4lx6d/y1un0TbIjk+FBm8XSDkTHoH9olyXxdNuiA95k7s+w?=
 =?us-ascii?Q?g0GVbiuGGU17gYF/dJf2NgL+VOF6OPZytjg4S67KqKQPX3Jfjnfsnct2QeIw?=
 =?us-ascii?Q?lLGRKlupB0qt2WP0LfGT5f50Yk2w//gr4sclkDhu1uimNaTALxVq/hJaeuf6?=
 =?us-ascii?Q?n6Unc5B4CTLlhvVAkGzzt7EwCuQuoIpOG4tJrDqj8a4066tIN2MZZWKfdxLp?=
 =?us-ascii?Q?6HRw1Fi2G/oR+Zy6+qzoU+wAUZ89oynV2eAhEkZkvTlheLloBQ3YwNgQZZgm?=
 =?us-ascii?Q?HoV1Lpj/SWOO1NyDKqTorXzQPgUtaPF9mb6rXBqc0sxuWrOk1kHGvs7CTEeu?=
 =?us-ascii?Q?3fSpk7v4Fy+yj8SYPtfMG6mRFFidVhf5jAQk4AqmN0+X87b1QOAEAJLD/X3Z?=
 =?us-ascii?Q?WdSpTpCBh8tysSb2RseCwafhfzoSxSlgfcjSXVCpt3IoWTuak+rKqqfUX5Q0?=
 =?us-ascii?Q?x/IlJWSXs7TDEMLqFuVmVuYdMQ3hH+6rDfp7nsL1SmcIvsAOAOJr/HOh1D5k?=
 =?us-ascii?Q?uCtif4yVrQ7OEss3YoiBkI2osQ5VndjaD1a5/sWNEoDDEAtvldYedvyl+0au?=
 =?us-ascii?Q?iT8MR5x5wDHF2GTWESSAkelqV2HUSwHC4dxKDNvLRT9crkWog2Dj4V+QJmrY?=
 =?us-ascii?Q?hMoCkOGw52zZ56IfxvNV98+phXCjkICA9iupuf92Ff0MipbMdD4rW32SFqMS?=
 =?us-ascii?Q?+HUZCd0NMx8ugP7hfee3HPBFC9MAgJFKu+ya/Dv/mcetXZGwb1EBJc4vxVpA?=
 =?us-ascii?Q?4C0hWdC47Zc+jK6U8W9HZePOK3ONpVk1vM/QJNHJYxnVektPN01Tf75ZM6/u?=
 =?us-ascii?Q?bAEzNOeYytBAYd0Fla3bO9QzJyRPVvE4zxR5sVoUdHz2cAiaf/O/TspRfqNR?=
 =?us-ascii?Q?oWO2nKZ4/vf3maW6WllFjQ5jtQCVk/sQyw6V1XmC7AikBZkxLNyU/xVMv/Sd?=
 =?us-ascii?Q?e7SxKi8Inkg9QZrZamShV8iLpXzs31bfBMechyCSFy9dxDRUQTMCNWKiiGVW?=
 =?us-ascii?Q?bT/phc8K0BUnAVuYzRNxsWfhlykw07RnNRUbX7T64FtDGr1w0PYfuukRgfQM?=
 =?us-ascii?Q?fFFnylWR7gWhlodop/kyfWR95ubKEJ/+/JzZjPnK25aef2NpoHtoaDbDQMTS?=
 =?us-ascii?Q?3m2ytV8NlYaURbArmpYqeYBsonavKXBrhEUr/Whfm1cr+q5lgPduiAlvb81F?=
 =?us-ascii?Q?MQs9451SOqoneRjTxdrIE5Eb4t3CR+i64wCACuwmJfLleOUD187hrJMw/XMa?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	noBj2i5ltb4/Dpy+L5NnwIdVgHhjwBs73//eY4qoM/2DHiWzZqvNJCFffvOKWTKvDZRG6CvjgzoLbg7ndvdfztWzusk+RxZAToC7O6D11zGAV/SOpUN1GrQjy/OObX8p0bYYUFEkJMeAEhmPsi0T8EdaXpt6uPKBalL6LjZ7UKDGcPZPxB+NWANQTQkEiSZC5NRpTAa3zLz20FcaHbj/6BbRvlm+wR/TcPyiT1eQycrrC7m1wBmfr3PCQNj2v5LhYcpyU+RP4558ajaCTfIXG/gvS6LBx0CrhV6gRu+No4fK96LhKqEXZqOueREDGTON1UEnB8xtbu+6YxfYlNVdjAukkKSnJCaQwd/UupsTgtlwqRoV25xGH5ZuUU4BjjTNFz4OLuucXXbdMoeN1HrGwnncqmj143rlfbA583A3zA//5BHyzkx0tfXgeHWIXkHDR359kO7xtiH8cWxjhVu599q4xKa0xtmp3pisB+9sfE9sdroVTF2x8PAD8Z9LWY8jadkXW0+tNwNiLszOQq3MYEez7V44iOX2YY7oi5BARjEHo/9M2DVLgEYkpvcA6yZ15nWBmQsvSKxE1XoIXqmgZEdaqZVbiaTI3IRBUCuIVs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17ce8e7-89ce-406f-c47d-08dc3720cded
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 23:15:21.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Conpu21cGZGT94R1grjYr525DE4GL8/7KLNqI2VDqBw++CICZkA5rRNfWMW9nZgH16mXFvAhA53Kej9VkM4/gS/X5Wq/VENTQwhEwMgbPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260180
X-Proofpoint-GUID: xXen7BkYuWRLdv7aIms2Kd9IIPhim8LJ
X-Proofpoint-ORIG-GUID: xXen7BkYuWRLdv7aIms2Kd9IIPhim8LJ


Kanchan,

> - Generic user interface that user-space can use to exchange meta. A
> new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
> direct IO.

Yep. I'm interested in this too. Reviving this effort is near the top of
my todo list so I'm happy to collaborate.

> NVMe SSD can do the offload when the host sends the PRACT bit. But in
> the driver, this is tied to global integrity disablement using
> CONFIG_BLK_DEV_INTEGRITY.

> So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
> that the filesystem can send. The block-integrity and NVMe driver do
> the rest to make the offload work.

Whether to have a block device do this is currently controlled by the
/sys/block/foo/integrity/{read_verify,write_generate} knobs. At least
for SCSI, protected transfers are always enabled between HBA and target
if both support it. If no integrity has been attached to an I/O by the
application/filesystem, the block layer will do so controlled by the
sysfs knobs above. IOW, if the hardware is capable, protected transfers
should always be enabled, at least from the block layer down.

It's possible that things don't work quite that way with NVMe since, at
least for PCIe, the drive is both initiator and target. And NVMe also
missed quite a few DIX details in its PI implementation. It's been a
while since I messed with PI on NVMe, I'll have a look.

But in any case the intent for the Linux code was for protected
transfers to be enabled automatically when possible. If the block layer
protection is explicitly disabled, a filesystem can still trigger
protected transfers via the bip flags. So that capability should
definitely be exposed via io_uring.

> "Work is in progress to implement support for the data integrity
> extensions in btrfs, enabling the filesystem to use the application
> tag."

This didn't go anywhere for a couple of reasons:

 - Individual disk drives supported ATO but every storage array we
   worked with used the app tag space internally. And thus there were
   very few real-life situations where it would be possible to store
   additional information in each block.

   Back in the mid-2000s, putting enterprise data on individual disk
   drives was not considered acceptable. So implementing filesystem
   support that would only be usable on individual disk drives didn't
   seem worth the investment. Especially when the PI-for-ATA efforts
   were abandoned.

   Wrt. the app tag ownership situation in SCSI, the storage tag in NVMe
   spec is a remedy for this, allowing the application to own part of
   the extra tag space and the storage device itself another.

 - Our proposed use case for the app tag was to provide filesystems with
   back pointers without having to change the on-disk format.

   The use of 0xFFFF as escape check in PI meant that the caller had to
   be very careful about what to store in the app tag. Our prototype
   attached structs of metadata to each filesystem block (8 512-byte
   sectors * 2 bytes of PI, so 16 bytes of metadata per filesystem
   block). But none of those 2-byte blobs could contain the value
   0xFFFF. Wasn't really a great interface for filesystems that wanted
   to be able to attach whatever data structure was important to them.

So between a very limited selection of hardware actually providing the
app tag space and a clunky interface for filesystems, the app tag just
never really took off. We ended up modifying it to be an access control
instead, see the app tag control mode page in SCSI.

Databases and many filesystems have means to protect blocks or extents.
And these means are often better at identifying the nature of read-time
problems than a CRC over each 512-byte LBA would be. So what made PI
interesting was the ability to catch problems at write time in case of a
bad partition remap, wrong buffer pointer, misordered blocks, etc. Once
the data is on media, the drive ECC is superior. And again, at read time
the database or application is often better equipped to identify
corruption than PI.

And consequently our interest focused on treating PI something more akin
to a network checksum than a facility to protect data at rest on media.

-- 
Martin K. Petersen	Oracle Linux Engineering

