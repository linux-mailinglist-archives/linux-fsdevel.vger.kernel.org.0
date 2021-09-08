Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23E403F36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbhIHStK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 14:49:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37378 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235775AbhIHStJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:49:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188HxO82028121;
        Wed, 8 Sep 2021 18:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=O6FfJGLjk4Ch6HJOV36+MG4jXFS8LhwqU0pMFhBFF9Y=;
 b=he4pu1h4+ip6bWatBulS9ymfadwuPhtrPvZJHc9BynKkaaJREs/QNknoZn2Kdk8+02WH
 cpA1tn2Dv9XtfUpGtqTmGhzBK1uSy6NjjlVeY6ckNqH5tdFrhykza0X+4zFMxvkzfboZ
 QUGKsbZheKsC6X1hssMGkcs8TVDgU+/vSLNM5ilfIC0XMKK6JsMmwSlhasrX4XhKIge6
 e+7fZlCR7AJlhf+FAtZJPz1uevkDCsYfvxpyRy62kWbtAuhrpIsBndUeQKadmUjYf2Bp
 eVWVzH3nHTZHCvhJcaRM1lZTyUteaHG/ZmPIi+Rvzhb7TsLVQQ0qsOQWEQK5ODWyS7/m Fw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=O6FfJGLjk4Ch6HJOV36+MG4jXFS8LhwqU0pMFhBFF9Y=;
 b=Fs/QSuXrMXJW2MuEqdZa2vhsIbE4K9KTWRs5Nq4p63Db+cSYcxNe2X6GUAUvkdEg+yXp
 XDUVjrmT3P7qYa20WoBq7aEoqpwK+HmsPPgA6btyMKQynDu0DZtCK78jGX8jDqbuWnWS
 UYCv6e05ZFYpeczqhqeDlRLAzYjeyH1O7ZU7B7ka9kQ4jSvo1pdOrVInf/ISoF8PVgHA
 2Mmpx4Aa0RZoVYNpGZC0OGB9mF1YTLuBIbMljbhe9M7CCF19x6HbFk4Xl5QQSyKpynxl
 l/Vo31L2WH854OZ0lwzU2WAL0vBKQ24KswWn6k2fndVidwHEZipkp0E8r/ii5HkoU2Ay Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q3s4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 18:48:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188IkDnv009680;
        Wed, 8 Sep 2021 18:47:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 3axcpp5jwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 18:47:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhswUCJ8Lwc9xgyMrMvNQU+j5jbZkx8kvu6Aah3E+PpLASZ09wyqJax3Hzikcc6j4R+5o5mSIwJcHlcbTUUOrxKenvcnKgX5cxGTWuJ0cOEB6x1Ihh/pc3icRQLOvtxoCqzpjcuYadbD5EescD3sf9fVA7dzwTihutx+8T+M56YOMb3Yg+wdHeLtRsfwf1IflZ0p6tJqHMuNT/joOjNjExzOMA+SzIJLZs9ZkM6IydVZgNgEjoMIHUKl6cDl3aWPjAICECB8h6vJ1D+eOnxVHJI65OtnBYCnODMhXeKg58vcMPMGRhms90nRPeHp9e5y2E0+IcQNfedit6f1u7ZU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O6FfJGLjk4Ch6HJOV36+MG4jXFS8LhwqU0pMFhBFF9Y=;
 b=F5PFVlGQ6nNi6nnNQQ00up+GwmQj+KjigOjP62amIDSWL0hAfsLOjwxjpabEcg8XqCRwLfXX1Lwc3TNvRXS2BT4ut7bbHQGnGvQ/tkJBiyi7NRVPdbwBJDBslD82wS9LnYH1P/XRvjj0lAkwfcbwpcMkXU2VlLsDuzZ+A3la+AghHWjSDMMmLLXcxtVqF9rMKTLIOOpX+sKRXogyzZ044Eu1+Obx9P5lUTPCEpHUWpR0buL2+2OzjJQ3liqN6j93FW8HNtFWhvPtDRgVNhg7nOa7VBPjyq1J7uHNmkrwgpmfBeRPWJHC533ehsB/bB8aF+5A8zO9jxweVw8Guizq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6FfJGLjk4Ch6HJOV36+MG4jXFS8LhwqU0pMFhBFF9Y=;
 b=KCbRJemFjgtHvbqSQtZ/3EhH/QuZWYEyytMz4p/FbQj03sH5wbkV55ALXXnbDe6U6HPqFeS1PHgL8gjamIlkfJzxHCztTJCjIfVUw4v/rDvc3qJUjlfewsQjl9u8a0rkbnyIdaR1YdqvLI/arRgjK+ibqZAhUiMBTBjVVZFb2ho=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 18:47:58 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%8]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 18:47:58 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] namei: fix use-after-free and adjust calling
 conventions
In-Reply-To: <YTfVE7IbbTV71Own@zeniv-ca.linux.org.uk>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
 <YTfVE7IbbTV71Own@zeniv-ca.linux.org.uk>
Date:   Wed, 08 Sep 2021 11:47:59 -0700
Message-ID: <87mtomsy3k.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::20) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (137.254.7.171) by SJ0PR03CA0315.namprd03.prod.outlook.com (2603:10b6:a03:39d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 18:47:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 474e0d7b-0d02-4ca3-9d3c-08d972f92cff
X-MS-TrafficTypeDiagnostic: CH0PR10MB4986:
X-Microsoft-Antispam-PRVS: <CH0PR10MB4986FF0497A20EAF2B471CCADBD49@CH0PR10MB4986.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:200;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NhDk+VQQ9Ml7JtaqQN46W0Yx8T7vxaHUlH/vKHK+cboziN1eryCTs5MB+/VR983cOWJ56ISeCJcWxzh3fSQQxE9xcSoD//sNOHIagYiie4S6675kPXfvF4ckSH9myzMx6bnhZy0Dqr9Ie31SL2BrkiR7Rlmgd6i17DwEpgknPi0KKkky55gVX481fViWKa+dY5azzZgCjdkO5qpT05CopAY/TrL3VOOUoiwPTGJYttpeoDd0HmMIRCNpfQsybgWrzEjTFHQpwTog/KLKlfs/IWMIljamHJO4n0CLEC2ybvirgyv1tUYogDynhe5BePaGQQHiAu8oslFlHZb5/zwup6Bb6lED4Phro7foFpMmOahfKQ3CmqIuXps2rRWsCmXyiTgDRVD15TVdozRY52j+LXl+pKWqRtcrnMDNjZAutshstfwVLVJfFXSCzJXM9OMhr4lY6c4GLmlqfE766QdLOd3RraQCjeNHkqxDIw7o0U56VqxIJ2TXeeQerAqxt/OwEu52cG6vl9VtxzRlczaNGTi6rR2BfKjPG4/i8uToTU08ccl7mVcA0t6HkWcJvYmu5nqNX6zWtuuEe9VO/YgngbJ9asO1kf0br+HgbbfMWUtSpDqXbFSqI4oLR0v4bYxzuaDqRRNhw6ROkYG18VlVQf5a7Ne/MEiubGLiiwLMT0M2hrbSpPGIbqV2IqxIhd9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(39860400002)(136003)(66946007)(5660300002)(66556008)(66476007)(316002)(52116002)(2906002)(6916009)(478600001)(86362001)(4326008)(6486002)(6496006)(956004)(186003)(38350700002)(8936002)(8676002)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyXstCtChJRPzz4vGSoRX5Vb5HpGKbA4vsELy6cLpMiLv8bO7DSM2GvYx3E3?=
 =?us-ascii?Q?7DnlnGCNPUn4kV6LwDx06vu9Vx6hABivABNFZM0aocLI9CJjnNmqWPLH/zCd?=
 =?us-ascii?Q?mOdoUl1Y2gDtcmNJwJEshLDxx6b4iSvgicq2XmwWjmIT1C3v5zospiHSQMQA?=
 =?us-ascii?Q?XKHK/jZAocMEC/w4wY1vxodSnWWce7CKWVri6OZagjzPiF6eHLcqP4Bvu1Jp?=
 =?us-ascii?Q?Ohjk7yGOPkSxdkzsGGIrt4P1Mrp7AnzTb2KxFXT3BcBDp+klm1dSFzSVIU4v?=
 =?us-ascii?Q?VJ6/nShbDAT/k3OMmpZLiW63dO/iv8/IulZF3BH0MONKR/VNE3quXI4qPHIk?=
 =?us-ascii?Q?pC6rp2Dzb1GBUVRDOcOIgB6GtH8rd+vu09e5Pd+ggNj5+s0tV+RJGQs2yTag?=
 =?us-ascii?Q?dIsBOlzY7XU8Pqkj5oyRR09P82j6uKDGNkwWWuTPnLZlEU8fVDmqB8M0ECSr?=
 =?us-ascii?Q?GKBt+rVE6hlSXJ0LjeCrlZ3dkOcKA/UfbBB7Ezoyv5suqdX9eId9Au5AQEU0?=
 =?us-ascii?Q?OK9MGlqBHZLbdlkuW7XwBFQ3Lq4Wc0bJXHeFHrjJU9bDxgsyKY4/eVv5Uuxs?=
 =?us-ascii?Q?4Yr6oVPC9JCJWN0OGIGeAdl3VCora3PS0PlOFGHUxhepfoJtxwT9VLSVgjZ7?=
 =?us-ascii?Q?79gS3jBaUG3OQA2z5uLHZBHqhj8pYjXXVQXxIu5wLRn/xMZuYKsref0SXxZM?=
 =?us-ascii?Q?kSqMhz0JV8AejDq4gx5cCXjMh11+44CSAjt+ceNQ61MNksRR5TyCt0v+y3qs?=
 =?us-ascii?Q?8c8AOruXKtofdHWFr2viCUxr/D42b0MqaKbSsZjuvPNIAq1oZ62gbEiXON6u?=
 =?us-ascii?Q?eCKizEIyEza3vbWED7HI5qswuNIhS8a+z4W+wVzw7BSCMZL7QunbutKQc3r4?=
 =?us-ascii?Q?pcUzBUj6i61g12lg2hDri00SCy66/6ChcD1f9j7mJqMKLDlaW4QSfm/NtxEC?=
 =?us-ascii?Q?PhASHn4ulRFooDR/DhyVfSxQNRRu6XvJXhi0725pB4rehooJdvpamcZC8k4w?=
 =?us-ascii?Q?7JhIp574r1UFMbEOBywDtaXVWUP34UU/btkjl5uhqx6aMWhRoEmsKqxR32dV?=
 =?us-ascii?Q?GLGMZdiaOItVQjP4ez/8VeQ2kGke9BDWUmthrjfB0wpCpRp3NiR0WARaGzkX?=
 =?us-ascii?Q?MDum1/rzjofrXoRDQwaYagOQTq+NtKWjj4iiZykS8KsqoZ/iqRDcbZ0I/g+2?=
 =?us-ascii?Q?EloczorgCJFmfZR0KU07x19FgbuRaIWs0xxa6ZcldUPFbaC/5yDU67grXG+3?=
 =?us-ascii?Q?wc3sJrH8HpChL5ky2af630vVtb6+oCU/cdq77wEDFGRvXNOczlYfT4q+dzus?=
 =?us-ascii?Q?Uy9O1jag4qTHm+RC+ODyK1Cu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474e0d7b-0d02-4ca3-9d3c-08d972f92cff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:47:57.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qE+DeIKoETeW4UDtFPz6mso//+qsXxiYYnIOLVa8TwHFxOXtlXAq1LygEw9oZYYpmQZjtM/dlfdA2N5zwLWqbrd2l0hxULhkyphmHsh0Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080117
X-Proofpoint-GUID: 8sXFP1yOilDjSTmbvY0rpy3Lx7GcHdCy
X-Proofpoint-ORIG-GUID: 8sXFP1yOilDjSTmbvY0rpy3Lx7GcHdCy
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> [snip]
> Another part I really dislike in that area (not your fault, obviously)
> is
>
> void putname(struct filename *name)
> {
>         if (IS_ERR_OR_NULL(name))
> 		return;
>
> in mainline right now.  Could somebody explain when the hell has NULL
> become a possibility here?  OK, I buy putname(ERR_PTR(...)) being
> a no-op, but IME every sodding time we mixed NULL and ERR_PTR() in
> an API we ended up with headache later.
>
> 	IS_ERR_OR_NULL() is almost always wrong.  NULL as argument
> for destructor makes sense when constructor can fail with NULL;
> not the case here.
>
> 	How about the variant in vfs.git#misc.namei?

I went and looked through the changelog of fs/namei.c since this was
changed and don't see anything setting a filename NULL, so it seems safe
and good to me. I couldn't check *every* user of filename but the change
was only two months ago. Feel free to use my r-b for that commit if you
want.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
