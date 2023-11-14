Return-Path: <linux-fsdevel+bounces-2852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289037EB62D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 19:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF431C20B17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31821357;
	Tue, 14 Nov 2023 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fcmic4+c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S6Un+nMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1A2AF19
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 18:14:07 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1730AFD
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 10:14:06 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGicO6009209;
	Tue, 14 Nov 2023 18:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=6jCkIOLjFDxYthkzorMT8TJFEdrQGAeNJR0LVuq3V+Q=;
 b=Fcmic4+clKGiEl/DniabdIAbzocQjiwH5TEKmhCVmFvIpiIwXOGhMFo7iZZqQ0ECdOxB
 /EOA+oLZEoO17vTGomDMhZ4Swhr+e4+zuqAB5oZURfrmHSkhBfpR2j18g53mG54MYKns
 TlyEimcWIK3IaP2NfBte/YZ1n/Q41T0NycV4kfLDf7prt60WBCuF1JULDxzbjGvZMSu7
 LfReCJvt653CZp+xGzfT+MbYscSN2myJfux6Ar/KmlQuEO8c0O/3Fi6hSiCmEcD0facL
 TDp2Gp2bQYES6ULdhDenRYe0Dmt64nCvytv9tsU6T72but9jZelpjB5ZQmrjdVvrAbon jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stp9an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 18:13:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEHCrac038552;
	Tue, 14 Nov 2023 18:13:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k3r1et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 18:13:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYelXVK75lVUdoQe+wXoGXj3yrNzX68m4EzkCo6/ISVqSgR1DbwYUKEBAWMLlGImn8T2jsbxv1J3aNKA6wqIYj2jntPzYTxxO4dMOHr10qP/2Bvzo4syqrD0HotSbFqQqWuEsK4GLdUH6WS3YQQSshpdlZd2Jb7piIXspc+cdeucm9ZL7b/4SieZ1rOZtKTIw3otqxg7RCOkS3BGc/uxSxuDpVz+3Zx/pWI7fQSy5w1X6uDDBWn3iXS/rWZarNhbRQKYQSYcPG+gIBd8Ol4RQmbek5faCex4s+gQHkZby4weBSh/3VGK2JJUJpMoCHIjlXC9ZkglCIWmzcc+aG7jnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jCkIOLjFDxYthkzorMT8TJFEdrQGAeNJR0LVuq3V+Q=;
 b=Bf3iTQG1s2sYWGGerB5d3odfadBS0QTSu2NbVNiVa/EFL+AK3qhRTy2JMkEJMjoySmxUJt0zijIJbQPeUUL5DuanPF6DRaBK1guJh+ucR3u9EjumqRArnk+oetZlx255El4xP1OY8zK2M31dATZQOz0lecxRciP9t9edKdi0MZMeYqpBthPeELKVu19Zjn5fRsvMdckpHvXROvxr9Ay/AbvFkvEI7KtalRZAkgnUCNAriZODtuHY8ZZ/L1J18StUcy7YnM1xLOx8VHHMxh3n2h9kx1HPJ6IaPJ2OFFZaQR0p0qVIP72ax3cNCyjcm7VJyB5ShXA8xWipxWwMFB6vag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jCkIOLjFDxYthkzorMT8TJFEdrQGAeNJR0LVuq3V+Q=;
 b=S6Un+nMfkbJXA2u0uHBeBzT7AlH/X58JoX+WNbm8RGKkeziQbd0+JQKlgrJYV2DQC1TrrmcxwVnjvrAgQjIw/va5YNvid3JjlIlgz1vF8zWrOthLGWcM7t/oIF6+y/pWu1+N6EMC415M6TzOT/c3B1qg3S8vn/7lYcg3zx/1Ubc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4812.namprd10.prod.outlook.com (2603:10b6:806:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Tue, 14 Nov
 2023 18:13:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 18:13:43 +0000
Date: Tue, 14 Nov 2023 13:13:40 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, akpm@linux-foundation.org, hughd@google.com,
        jlayton@redhat.com, viro@zeniv.linux.org.uk,
        Tavian Barnes <tavianator@tavianator.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC] libfs: getdents() should return 0 after reaching EOD
Message-ID: <ZVO41M9KPRje7RjZ@tissot.1015granger.net>
References: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>
 <20231114-begleichen-miniatur-3c3a02862c4c@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-begleichen-miniatur-3c3a02862c4c@brauner>
X-ClientProxiedBy: CH2PR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:610:56::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: d5aadbc1-c031-4daa-4054-08dbe53d6f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xvvhcN/nXNihITM/w3d7ETdnc/XB+Vv5RE23b43Eny23uiLCVO002M4+ZvqMWX/oVAe+jWAqubXu5LgOo1uVrttwwvWDTXW3B2DpYM6knjqRfOfx0hsELLw5uDPjedultfe0NHSzgjot3Kf4+tXkDt544h5OxUhHUJXZ6GZ1TqFM2Q3cnVDg6b6F/REAQ2EZBPxJ+5ng9s6rpBroTQjZkbzMiscR8V6vRDDHSXWtPWpfsCunQQTarLWm+7bf3HC2KMhi6SRjy7+cd9FWQY6KkzeCJOglc96CQS9cxtR0LOI8jpIteDpoqI7omxrGqmc39H9HOO/JawQsjCenwKLdlbXpZ8mf5DPNox7nEXww89vFE8FRl9jzX9FRFm8+TZ5TkImwVPru0vFsQtqTBNIvLx4L4wL9wg6G5xpCR4JoqcmktxjsrOXp6HYBk2qWnudUV9ysix9ZvdLhZ/unZV6NpDs1io2sVsPYhJLZx0WNxEJnG6am64dGg4xdtAlIJylPBAGDjnF4676SNVmfVMr2vBoqDXgZA6swFSGgzySB49E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(4326008)(8676002)(8936002)(44832011)(9686003)(6512007)(6506007)(26005)(83380400001)(6486002)(478600001)(966005)(316002)(66946007)(6916009)(54906003)(66556008)(66476007)(41300700001)(2906002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Kz4k3zm/wYNRMHyiwhCXsY7cLPu9UNZoH6WhueSS0WcJeNKqae8p8bcEp8fN?=
 =?us-ascii?Q?I9xU0bAVf8FFRsan5YF0Fq84MP2jumfqF9qsSTTzgY1PmtRO0jBcTrMDAN0M?=
 =?us-ascii?Q?w3FQo/WJ33JnzCDnrtHRVXVm9ayvOC7yZgG+E+OsGz6ZRlSOIcB3VTJDcCOY?=
 =?us-ascii?Q?F9iC49NN3zxXcjOz+KCP4vI95qQHokGcWqqrRaR0ym6PTgw/oolwmo/3P22F?=
 =?us-ascii?Q?25PBqVbbldSy6YT9mnzKB66skperU4nMQYvGYC7ILTpn27/+LJKt9OOp/ea/?=
 =?us-ascii?Q?oSxB7xxnxUmkRBMRexdb1QFFPg9E6SdJOgbrE/iksVBZWnwre4WMP2ABvyba?=
 =?us-ascii?Q?jmR2yhNVOblJsEIyg5/m4VychBPy3Ra5lYk8shCab59BrkmqdKXk3qushtLb?=
 =?us-ascii?Q?PuaSFrbAjxkzwjxemK1UDmQsKvYe6vA9I25nYMDFmt91o8vwS8VbullWjxVp?=
 =?us-ascii?Q?Kl4SWa7mLVNN0vzYnWcT5sOx8kd8pv4uPYLD/rc7BJ54JA1pCVLbOc/AlL/M?=
 =?us-ascii?Q?ZMSiXgkk2YrzHrvLN1adeuEQGnvyRhH6oqLOPIumuN2yNDUKExPfkRpWw24n?=
 =?us-ascii?Q?oBHBrQCaJUi9nIR7UcxLE/PMiylW/bTY36p81M/1HjkQQovfcQoKHuRWWv5Z?=
 =?us-ascii?Q?yQllzDJvBO/aWkogopHJhEZXLMinBSCxktMTkz/JQlSuVbUcqXfPZw3MXS2e?=
 =?us-ascii?Q?MWLyXYKRMZEDJfbA9kPLr4xrELz+vEGHYWlWkwXwFtKLwQjnIwlFste1Y3U3?=
 =?us-ascii?Q?TLdLpqecLqV+FHdT/lQ7fLMR+goDYDifBbSk9GkSEKQPRCHDov/Z4ibuODHO?=
 =?us-ascii?Q?vV17mioqcNE//dKXfB38pd4mhR5icEuWWXMZjpzpTAqglsxywMI4siWdXE/M?=
 =?us-ascii?Q?zI8JUE4/7PHkEw6SWsaix5H6Fr6E9wQEdoMnzkCOjzjJ+ola83CBUVtfLYe9?=
 =?us-ascii?Q?8Pg57PKEvrCH8S8n3IV4mp1HHbZ8noNIbEn1p2qKv8VcPJJNnTz9hJqz0vWL?=
 =?us-ascii?Q?w8py8pk4jxVa43Zkk/Jd6C7hLb6IYN5rRMr1x/NIrntboWR+2Bl54e++J6g3?=
 =?us-ascii?Q?D9kR0QK+0MpeLEXEjXot0mFV02t/y8cOf1XJq8ykK1J7FVRTZR9YWib44MU/?=
 =?us-ascii?Q?a2SsUpnBlxQBMRJPialazXMt4bKhSn8i5tm6VVog0J6Affu5qj/AGFvZI1rW?=
 =?us-ascii?Q?8g8G5JPF+o/mAfLgdJnPKEnG8ivXVaL/rdWa+tJR4rnnxcVCn2Tl5OiISp3r?=
 =?us-ascii?Q?ATjIoGQB2gMuKOxnodT8jTBP7JvP6R5YZhKMc3cnmbQXuNHKqFkNJZb3rWbx?=
 =?us-ascii?Q?TgF6ipOGlBCZLdggfWmOylbatOXEbhSXkDl/RHjyNwg2evi+mVT7zfvRAELV?=
 =?us-ascii?Q?au7PRM8OW2vrzin/1q/kr4qAij9l9Vyl5DuXBb0xohTJA32NLo5IGKp3sFtn?=
 =?us-ascii?Q?dlg0epFQt1GjlxeKu+MuZba0LPcbqky2FGk4Psbb2bqpFu1pgdsDCMtDzZrJ?=
 =?us-ascii?Q?lthD7iZ8iBNFhcoeXwcMs3QOZRFh0N4sNI3mc5qJutTT90DEarbCDdh2iMES?=
 =?us-ascii?Q?7XO83IMsP19neZPCnUnWWBoSLIy6U8zOaOgfwmN6SMbqjh/KhiAJN6mNOXeI?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?xZiXA71vlqzxHCErK0ZQD2IBUPqV7VgnF0uHNZTj0PKnMtNxz+K48KP6P0SF?=
 =?us-ascii?Q?iDHM6eXXlQAtRLLA24/jvaA8BhDVyGEguXgBuf7Y1/NAzW6W+ViKixhOGG66?=
 =?us-ascii?Q?q5iip2nUPLaNKZyk9/MZoOZxWRLf4qAMrK2HcSlK3HKAFfuChGuwmmwf2xpT?=
 =?us-ascii?Q?U6zc60eQZ/MX4pXWr+Lp/YhLyUb7xsulEsq45yfRH/AYolXq1ufCjJTVY2HR?=
 =?us-ascii?Q?lM9eedISzLpS3tRwcRSssl6//kPwGeZ/w0UgfnZOpwPjzDL2NEmfrU6EYRtb?=
 =?us-ascii?Q?67aoI+zWKdmb0vaZvrV5TVG+udp8hyEHYEFRQN3J34nZKu0W4qh1Gkr1n4TT?=
 =?us-ascii?Q?T034yBvilOX+UYams+hq+xLYfkxwWna1Abeim45EVb5Vc3XnWYAf+XUbMlUx?=
 =?us-ascii?Q?4b15PXTkIEw8Kpg22Xn2xp5CFUy+YQuEiY8lmUkbEdOgNtXI1/F6jc9La5+B?=
 =?us-ascii?Q?z8deQTPv+cliI7zNy0BsJaaF/M0owO6SU2TkSOssW4iPBiVvTiJGDOjMkDKs?=
 =?us-ascii?Q?A1ffaUQilHZ2Ro7X4i1ArewQMtrGFIQVcpUMjR6T9bSBq/9vzFj8wQsNB36U?=
 =?us-ascii?Q?B4/IL+rJtq7ko+EZNkVLAk4wsWVRuRVr9/o2L1NUWpgV0JNQOUj4CSGr+Wr+?=
 =?us-ascii?Q?+2cVvwXx2yTUH8Z3+O0EOlJsF5pVOXKHCkqwL0z5cKYGizpKor6NSe3MjEhg?=
 =?us-ascii?Q?xZH1DsZee+6gcQNq+zAA+Q2/7ZZv7UDmF25EAkc32TnQ4HoA5FklfKVP15h+?=
 =?us-ascii?Q?+CzCfKxiFe6Z9IiaWgWDXPrnj1b9jErjxc4787MixphadTocv4comyHly4Lq?=
 =?us-ascii?Q?VMNXn5bIyMRMvgscB8eNFyLr2W6PzGwWDMuZ1C+ZX2L3t3ceww90T/x9mkcr?=
 =?us-ascii?Q?oEJjpYZJtXHn9ciRwnIE9lyieRqiG2mdlC73rY5IJ7THdyKbS6nuWm5JVXQ0?=
 =?us-ascii?Q?hm+5mB0s27LxdfRgfjCsEk1umL1Pd3ZFnIqknXhOrOxlpfRlKsEbq32DxTvW?=
 =?us-ascii?Q?zCGL41TyRnUbeZRM+tlaBPs7Og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aadbc1-c031-4daa-4054-08dbe53d6f81
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 18:13:43.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJWu8c5TIaX6CBLFozLuzhu1QPjxsy+aaK7YXuaCEoUAqKDHj6yLAz7tHKB59/+7JrSYlflvCJ/QBjUH9guNTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140139
X-Proofpoint-GUID: Va21WZDAo2T6zijKGI56Tt9zZ1EcHd4L
X-Proofpoint-ORIG-GUID: Va21WZDAo2T6zijKGI56Tt9zZ1EcHd4L

On Tue, Nov 14, 2023 at 06:29:15PM +0100, Christian Brauner wrote:
> On Tue, Nov 14, 2023 at 10:49:37AM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > The new directory offset helpers don't conform with the convention
> > of getdents() returning no more entries once a directory file
> > descriptor has reached the current end-of-directory.
> > 
> > To address this, copy the logic from dcache_readdir() to mark the
> > open directory file descriptor once EOD has been reached. Rewinding
> > resets the mark.
> > 
> > Reported-by: Tavian Barnes <tavianator@tavianator.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/20231113180616.2831430-1-tavianator@tavianator.com/
> > Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/libfs.c |   13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index e9440d55073c..1c866b087f0c 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -428,7 +428,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
> >  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> >  }
> >  
> > -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> > +static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> >  {
> >  	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
> >  	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> > @@ -437,7 +437,8 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> >  	while (true) {
> >  		dentry = offset_find_next(&xas);
> >  		if (!dentry)
> > -			break;
> > +			/* readdir has reached the current EOD */
> > +			return (void *)0x10;
> >  
> >  		if (!offset_dir_emit(ctx, dentry)) {
> >  			dput(dentry);
> > @@ -447,6 +448,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> >  		dput(dentry);
> >  		ctx->pos = xas.xa_index + 1;
> >  	}
> > +	return NULL;
> >  }
> >  
> >  /**
> > @@ -479,7 +481,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
> >  	if (!dir_emit_dots(file, ctx))
> >  		return 0;
> >  
> > -	offset_iterate_dir(d_inode(dir), ctx);
> > +	if (ctx->pos == 2)
> > +		file->private_data = NULL;
> > +	else if (file->private_data == (void *)0x10)
> > +		return 0;
> > +
> > +	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> 
> I think it's usually best practice to only modify the file->private_data
> pointer during f_op->open and f_op->close but not override
> file->private_data once the file is visible to other threads. I think
> here it might not matter because access to file->private_data is
> serialized on f_pos_lock and it's not used by anything else.

I freely admit that using file->private_data this way is ugly. I was
hoping to find one bit somewhere that I could use to mark the file
descriptor, and file->private_data seemed the most handy.

We could go back to allocating a phony dentry (d_alloc_cursor) and
place the end-of-directory flag in there.

-- 
Chuck Lever

