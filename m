Return-Path: <linux-fsdevel+bounces-16122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E79898B10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633CB1C21FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26412AACA;
	Thu,  4 Apr 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A9E4w8lY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kOvfe+66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF902C189;
	Thu,  4 Apr 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244339; cv=fail; b=bTZSVuSkKGCxUnE6r5+X8zxnIIx7vFPTUdiI+MYVW3tQL9YYS4JyqJrAhLleBVJOK2KU/oA2XlGp0vPLgRToqkQOhsO3iPW5iDCjJT3sEKirSNz8SatJa1zU42KXkEXe2OUKt+F8xbBrPkDV96Ss1uTwCVxivboI5gqWEZy2Sj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244339; c=relaxed/simple;
	bh=/BEAc0DF49vgT47gLnsDFQdia1DWmrdpvot0CaxLEu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=snS1IbC8D+M148VoVoJV0TS/FJKdo5fMRSGdExy/0g16ZNwE7adWxFBodgMmW6vr3IpZABFfx1a+oLIZw5esZlDI6vK3UJ05pl16YXIUZ1R+jmHBmmfTaJMEbogAVsZ6I/aV53hl/6FBHqaJBX5z2KnIaN0yrB2ZU97eWhVBmIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A9E4w8lY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kOvfe+66; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434COfhE018697;
	Thu, 4 Apr 2024 15:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=E8e9nr2sLZW+N4VIYwy5PHwi69q3/dlVqKVD70kw4vE=;
 b=A9E4w8lYkD5Bwrp4EBCVdpR63BPBNxKMfptJDs7G5cVsh0b0cVXJvLON2GQISIG8KKb3
 qXPUDNphC5eQa9YA0exZeB+KDje9BzvTZXNTuXleGJE9OXwGmlZq+2a1fTn39gacQscD
 gMMky5uiTahrTN9IZOVl78G7UK2D7PaE0UwFBJHjUasV0aOrlTDR2DrsWqYwsltKK2C4
 U2GmS3VXs0fdlrNlD4Y/P0fhGTh2+RJz7F/lKpgUuFJWXQk/KQSmghU3DAWrmxJBuIz0
 30W93HYS5R2vh6vjgKGyo8Df1dnNb24wG6omBI73FvDxF/8K1os9i2o8j4isv3rUiH32 Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emvsh98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 15:25:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 434EedGu009342;
	Thu, 4 Apr 2024 15:25:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emkv2u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Apr 2024 15:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogrCF+pAKbaz/UfY/Z29GvrT1bhbfP7anlvdQ2V4p6VLXX7rdiYFJkocrM3qDxwPz79W0mUepPcnF1dY/34GySB3vyiQ3XkgMMA2q/nUAX2vT/YoeyshSOb8kBA4WTE7tKmusd6jttNfD1S/UXMnXtoAnrsHIXj635ajrrXvIOls8H+MgSBTn2I10iHOh4Ir/r1APiiOB2Ep1fPrbhuGx77ZY9NgvuHmYKLdcn4Eo0Etg3DchmT0WD5mGg6enVSwIFkhBrSNIzXNFP/5nareWbGbHeY3BqAq2PO3X4+mKctFmQlBpc7I/MuNdqVUOBNuAZTRlQy9bABCF4uZfX0KVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8e9nr2sLZW+N4VIYwy5PHwi69q3/dlVqKVD70kw4vE=;
 b=gfG8f/+J8AHhs8CpsUF8aHbb2iGn3ddZQsuLKvjgSXKfNdw1zGMcFR1G0RoHXHBwnWHH/33CxuAJt72pAmL0Dk25VqXOOm5Hos2xLrtGOD5sj3hIDqPnXV2S68nwWMTRz84x/HhBcmSpG3CyFoxm4lHlx/ZzmxXKxtd6dtsVPJHg2Y6uR+OPR3VuhxWcRYa8fyP7bbmNXIAy21zhsQza047RUY47l16eeb7JPi4kTDDvaVWhywjakgstcbLVVma5lHALijMhJC65FYhSXQf4bOXGCbu5FMsCmTYdU2+C0qrBv37nXasxXw9y/VC89NClSRH+nfxt5W/izEFtN7xNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8e9nr2sLZW+N4VIYwy5PHwi69q3/dlVqKVD70kw4vE=;
 b=kOvfe+667FXHzKJyqtWWmBHAPd903NvGrgZX4PQQd8LunzJZH3Mm/Z737nHF6QxG/EWx/qTBEfC/J+EqGM2cfPlaBzIs3Il+rBrOU9yX+iYLI0zWBV1rNGFYWIbbTPhRIoLQU/HtO9XbcIkRQhMQvgYA7qQBy+rY+qXPyxEIQ0o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:25:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 15:25:25 +0000
Date: Thu, 4 Apr 2024 11:25:22 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Kees Cook <keescook@chromium.org>, Christian Brauner <brauner@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Set file_handle::handle_bytes before referencing
 file_handle::f_handle
Message-ID: <Zg7GYmGQG1S+F4WS@tissot.1015granger.net>
References: <20240403215358.work.365-kees@kernel.org>
 <20240404091900.woh6y2a52o7uo5vx@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404091900.woh6y2a52o7uo5vx@quack3>
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GkVOkj0NoERxD+Ef7yN+h8Xz6xrK0153dyQcYBvuQkdzs6gxyBG+89Xy/NMWrpT/T6JUA3T+TgB70kMzcrKwvNZ7zb5rXxLQFn253T0sIZoDPJLpHPXeF6hhFDKz+62mNTXcWWqLgGkwrGd8spTi37x5FMRT3E6HWIdmmUPq86N8rPnAbFdYmGc4CLWcgA/zdQXcuo0m8rppRd1UgRu5/RuSHI5kZhitKmyIqL9vUjHfDLxW6QlEWw/8TCFeDshU/p4eM1atb+tK4q9E40C4GGrua3yepRdaoRhaBkGceJlfNDB2MavArONxJMqyH2d5gtjYqmsCJUwQNPTR69/pg81g46lioae+p0+emgDv04+uiB/KRzrAvuwiIIrfIRddLV9lD8ScmqrZX1fiBrQVHHueEyBzl7QQWPVToI6ngpgdCBqfm9BBOrZuYHwY/dRHRiV0opYsi+vgPOcVGTBH2XbS1ZZxeRD8oMVmq6BsepoaV1SWAA+h4AQEsFmYttpixAfmRma7CRv/X6pD0HfbHHnPigmiI/1sp8AG+toekI0qp3OJDAFiS7fDCiPYIR4+mXCaiCehW6vrvpsYqzpJ7iNCqB7+mejTxrpPbE67AEqvheSlMLtOhCU1z/oSPi368xXphvZV6TeqsJQ4u/zoiyJlb7tL/Ue7MTDrbJLa7W4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HGKPA9IBhEgYNl3VCM6mOcMqmDAwoYIYb/+m4x2xuwwJ7nIjjscFT7Vktx6M?=
 =?us-ascii?Q?SOAMvSuDckHAcmTnwJKp9/DIg6nB3YWug7EDhCjGO6TuxiLGE8nn6f/1HRyS?=
 =?us-ascii?Q?hPl97VGVYIsM61zbXCNTWRvNKdOCWCfFUMIV1VhcjzYdoWBhAwwQFi71nYvu?=
 =?us-ascii?Q?+7g/EZP6CYiYoxMIi6kHgpai/VjXVvNtu0KAHiEwRMKuM5BQcXDPtczWn1lJ?=
 =?us-ascii?Q?X5ZltBtqBYo2b7kG57t9k+LtEHWO8xKqhBtgOrLH/FYs+AaPscz5LmLXWKsD?=
 =?us-ascii?Q?cqN/rWEWIpdTiqsMCAEd/tcB+O19ahQ8wxs/JycnLk+aNTSYrhU+DpgDHyEI?=
 =?us-ascii?Q?BQC29cnRyG4JWH7ClHR/OJ6mEvkgjTKDEvdtnG3j9WSI7lABZ5IhNeed1WOp?=
 =?us-ascii?Q?z6QE9PTqxtAECuZh7z1YjpcMmHFxeZWItLlNyLVvv57bj68oCUXYuqsIcunM?=
 =?us-ascii?Q?gfnbqCe3896OMFEMzfX5dZRXo/HCJOoVtIJgzF9OI0XgCMeI5libVxhm+l5R?=
 =?us-ascii?Q?UjP46NYhGEUDjODy52lMpq01yTXFvWQybLx+8gzAH7IdtsT9K9n+dw0lBkoG?=
 =?us-ascii?Q?G/QnaEe6hbC0g47rcC5DNfL92zQ5cNwxuG4UBQVeaZjfTsxRgUjbia1qQvyB?=
 =?us-ascii?Q?vPMHoGsTEak8ey8w6FwIb2KumcpEXYdJz6cULgb0ijXrcruUZdxo4sHsJ8y4?=
 =?us-ascii?Q?8cwN+t+SWV5xJnm6lwp0vLO+Vg+oLmImgMRrRmCBi90PdNjUmISkJMnckn/g?=
 =?us-ascii?Q?QNykD4FsIS1FeGLEB++egzzcQZvcVR6ZxZ3Ij9xsLFHEda4q3iBLIh0gzK25?=
 =?us-ascii?Q?yqDnXjC19bRtQl2LggWtyQmQOvjR+Hjo6nQZ6yGuF2jdIC4PUaIy9Zw3D2un?=
 =?us-ascii?Q?I+KMP3MeXpfdT60rQnWT8ArydvZ+irQZTtiJV8gGeABuWLoAnpEEFL9kwozz?=
 =?us-ascii?Q?O8OiPxCckCqNhHWlXjV5FgTEctVKDk7g6d4/ATRwyl81oDg83x0raszUE/+C?=
 =?us-ascii?Q?iuGxZeZ6rFIF3+2aDqKCpDiuPh7gAz9Ewj0QgqhE9l8vw5N23RN73WO2fYC7?=
 =?us-ascii?Q?lXHHaahw+4w2TeI8lQkuQ/Dq9s0tEn3DPN54Y/II76eDPQyvQc3qBoaT1SIt?=
 =?us-ascii?Q?kMCU2lVnGP4AA+h4ZHKBUA4rYAikvDT9btYrMIxHF2ebmbDYC24eWW1OPTX2?=
 =?us-ascii?Q?mkBt3P+mzfoVZ36I8ywjdHLCXUdpuHWHaUG2nlHmsbiScHdpqyDrF1+JpUc7?=
 =?us-ascii?Q?9IS5ovsgQz+cywRziww4NiX/zxg1kxapql2MsAV8NuEuvOShRDpUjWY6OzPO?=
 =?us-ascii?Q?QxYWFJHagDJR3uMatHQ2qihnKtMy4W3FECCSjZ0KituRIWOXrX6NJVsNku4W?=
 =?us-ascii?Q?ygD61xziIsP17GRC0jz1I/vx0rgTKr0QlCrQjqrk79eKuhpJa+NN6JNo52OB?=
 =?us-ascii?Q?zwwU7jucLHsz5ZAl4LLFcwZtXk/cxOAPG+EbKmdp+JGbixZzuSuZ4fiGLZ9l?=
 =?us-ascii?Q?QKAoGTTTkUg5KrRMDG4Lts2Wjx+UxqGcwV3NbHdMYgReP9SlvPOzuXa6JFjn?=
 =?us-ascii?Q?pmtHvDBlHSlMDDQjgpnl4vslfZRc/bSUhdO3tfUFDBWFnXzAFVGo7AqiZcl8?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uxzTzLhdwylLSiCnbOawbAmZPNHhT1oimIPTY9EDK5U6nKv8zHt1NFapwCn+fcy14JZQ2i76ErHcYybFFGnGc31tzY8Q7Ci95lM3yQErCcYlTm/kjqNfHsANZiY9iWBf8CzpgwK+gJO6mYgEuWV5rcbCCMCdtS10EexoW5/cSdcNKRnxZsWur6PGMYBWZ6Nf4HqMyGsD7fKvnq4eSHzV1xvsRdZvA9+rBEHGly3+x6p7vCUMsMC+ZXWXnraxnWrNDNuz+3Nr13RUn+MLkt3MTtwoorZWPE1bFNI6iiGvcbqzkK7iLR6jN9if9bXDnKnvdmOI27MOS9mtF81F+U3Wr3qQhccAoNtgvUhvKQKPTpP2BnlRbEi8xs8BTWbfJ7/ZVmv2R2LOn75zxQsRUHAQujepke4+E/9PwOISEqXEwTo+HwhhWjizrgp1WKOkMCmGXKIBLHwdBY7c9WKFkL3d88nzDvq17C07zm+E3wJ1nFVOqAQyIU7xekBRtygiwuMZJyq6bgXj0KkyYJUzy7zAyEjALHuERZzb1vK2XEbVga6WGG4c6growVyOjojH/ykXsAbJMLrP4GQWi1Y1/3GEafDK//ebFKeIa2zP7LsBhCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1955317a-29d8-46c5-c877-08dc54bb7392
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:25:25.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMJ3oWqsug9mfJVMg8LSwOInIxlXh+P1NubnDHabEa3CU/2RX2SCwcmm6Xr10GDH0pjTIzSImwDScu5dkvROHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_11,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040107
X-Proofpoint-GUID: fpe8qJIydJc7aLDBJLARVNoie0QpMnaY
X-Proofpoint-ORIG-GUID: fpe8qJIydJc7aLDBJLARVNoie0QpMnaY

On Thu, Apr 04, 2024 at 11:19:00AM +0200, Jan Kara wrote:
> On Wed 03-04-24 14:54:03, Kees Cook wrote:
> > With adding __counted_by(handle_bytes) to struct file_handle, we need
> > to explicitly set it in the one place it wasn't yet happening prior to
> > accessing the flex array "f_handle".
> > 
> > Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> OK, so this isn't really a functional bug AFAIU but the compiler will
> wrongly complain we are accessing handle->f_handle beyond claimed array
> size (because handle->handle_bytes == 0 at that point). Am I right? If
> that's the case, please add a short comment explaining this (because it
> looks odd we set handle->handle_bytes and then reset it a few lines later).
> With the comment feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

I agree, an in-code comment is needed.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> > ---
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-nfs@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  fs/fhandle.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 53ed54711cd2..08ec2340dd22 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -40,6 +40,7 @@ static long do_sys_name_to_handle(const struct path *path,
> >  			 GFP_KERNEL);
> >  	if (!handle)
> >  		return -ENOMEM;
> > +	handle->handle_bytes = f_handle.handle_bytes;
> >  
> >  	/* convert handle size to multiple of sizeof(u32) */
> >  	handle_dwords = f_handle.handle_bytes >> 2;
> > -- 
> > 2.34.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Chuck Lever

