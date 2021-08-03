Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C393DEF2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhHCNkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 09:40:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38544 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232748AbhHCNkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:40:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173DFseI012312;
        Tue, 3 Aug 2021 13:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=AbMNw6oIMbfpw3giGqhnZSivjhfWYTJKupWdSEG89qo=;
 b=rZdLuFqfyAykhSXrpuW5/1i7rom1XPCoPujOS5dl3x+AN0rX9AGHFyxaZ6qU3yQz27kl
 9HC9wJ3Vkl/+dG1prMjkkG6WuyvQOrgA/9LJEQ0WaJxvpc2NfDMNljQUszKyAIYCE+VK
 7uxfOSyETrshWqUkAaWbdWdeHsAK88IOen4rfNMDWVTmR4eQ6bboa7HkGU6CZeBgzFvX
 UX6yl/C+AIyd9xRKvgptMB30FSOqY7xbMKaANlgeH9kQWXLc+hqMK8Mve9VEqRAIkpcC
 pFt4FhsS514WPx789FNYRQwDUOB6QZY6PM1XhQWja7n+Kizog57GDO/kidTZaIRBRx7V sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=AbMNw6oIMbfpw3giGqhnZSivjhfWYTJKupWdSEG89qo=;
 b=kvq3alO3zBxjNGKIeKjNT7vTyceFo1lRdOxGb/R9L+7mxhz9wAirOfJXrHdzN7JA5SGb
 XTMaKfwGF/FMwIrx6QUd1Cavv1lrNgRRRghXyzi1xHV22A2/pK1M7qEtBLMTpUEbWajP
 RSsuofKJQ5bil4j+YqpFlOD95k0gnsOIkDHsUuYSNhxhUPyPUhVb3+2CCmLMG9K+Z8bd
 5S8Tk5c4IztvLeGfakGs2PERp8avRaFLmcsehyYIRvgEP6ICb+IFo8Lpivwm4ubGP4+H
 et/yaXhT3grKs8xn89FG/fe92ZICoisLG46xFTfE/BkXrScN+r78BqVm3KVF9DPtb19g Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a70pjs1xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:39:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173DZvBM057608;
        Tue, 3 Aug 2021 13:39:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3020.oracle.com with ESMTP id 3a4xb6ry10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meTJ+7u9Ym6UyZik3wwtaP+9cOuV4957bPt0H9Yr/zd4A+edS3V8OMbF4E94nYrQtUUZHgotm+oivPhA0j4OeF5yVtOGEnWJADvuCYBMmAqZ5TMe6EqZQSOxNRT9hatwtHk4H+OBYfl2aDtt0V+WWXbOH/4pI5mT9XjsaOs1ev6Nkd8nv3sjtBQs95GBiKUDWEax/1SmPSrPNHc/6sT/tQi2a8uXCteN+ibMyXpxszwQqBk+QOOw0r+xti1UwZjCffSlTx31Wvd5FUVrAaT3jVaPfwUlWkxhy7OVegf4IPK+srO00TTjoQ3zQqcuq6h4d6mWdo2EAv/uAG/4jwiZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbMNw6oIMbfpw3giGqhnZSivjhfWYTJKupWdSEG89qo=;
 b=eJRMUHbhbO9b+BAQn4Z4dqfln72IJ4ky8yYqiM9TGzH8t7ASXi9vp/mvcoBI0ft2wxWcSKRlcc96Ao2KfVYhGPQveXDwOZ5K9bt4mhrX8IJGvOVB886jAwk/yxoXdgtxHKdmqsbtH4YvC7Q2Y+5SMyYGB2Zrtgh1ORCeCj+FbUfeQThGDDtYYTyizQnZix/32ahutpnKqsd/TpzE5XohdVhFWjI2eyiINonA/dJE5M0H5VQlKU3GY98cJU6xnXcZ6rpIlBdd0zHzA6+Q3IvHay0BLFhz3Gpj8UKnaVhRBdZCPzuKIbR2CgJ44nirxzMfZty1JTa/q7kT5RlxDAzMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbMNw6oIMbfpw3giGqhnZSivjhfWYTJKupWdSEG89qo=;
 b=T4z6j67Jav2AkJxa3QhdDqrnO8SNXLJbPPORoXisD5jWByRMW0j7zm0kxIS/V9EOlBSA+ZJ+S+jyAFNTbG8zgU1jISi6VaSZqAj9vLUh6g/0hJKZvM8Lw/XB5SWoQ7WBQe2muzwsk5vHw/vNbNouov/jWmfykkUQ09d5MeC+uIE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5569.namprd10.prod.outlook.com
 (2603:10b6:303:144::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 13:38:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 13:38:58 +0000
Date:   Tue, 3 Aug 2021 16:38:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH] Restyle comments to better align with kernel-doc
Message-ID: <20210803133833.GL25548@kadam>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 13:38:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e48a1cf3-66d7-4d33-16bc-08d956840b8c
X-MS-TrafficTypeDiagnostic: CO6PR10MB5569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5569BDF07EC6014A222A45EB8EF09@CO6PR10MB5569.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wWm4gQci5mVSWdei6yEWkbKRc5Cjf4VoIMmFoN4uckPv9x+AuqfW89/OngfsXlVovWT3jIH3X3ZrTmMRRTJoEMVriRCzbKllBFRJ6+wzrfIXuNC/OLqphJHACQAwXGXj6CB+uabOm5lu5msoCrXTvbueR6bBe33oGC+IdAaDv8T2TBfp3Cbdeaz7SvaE8m6bV/mSNYsBH/P57dTwRangdpXpNTaAvLxRhhxny6jITEI8BNqx6ZHh0fI0ayWyhXO5ITogG4oZjyw4BVoUVD0N3WI9WQT7hXXoRZNHUtAWlrg29YA+rn1PLVdJXQsgR7xLP2LK7zkkVQs+tpdkb9X+gFWLkZZt6wlFnNlEMt/Wxw4tCM0Vk63Kpnikh/TUGvuZpdJvzOtIJ8b3LU7PToT3cLzdaUgFXYZ/2DfxOETDfythJsFKfIQ1go8R+z7himzMULnCXFCd9L/cyAWFklRmf7pE6QXlgi/2stS42awFc8B4jCWl58bsDArkW2OvF+c2cfrvaD4pv/IqG5nFlQYJ5hMEbQq84XwYNqDK52IBC17lxegWxhReB83IPzKyTCHP5ribhx4e6qUyt+zwS7AKGbNxC/E1lGjpok60jZAoT/b+ub/eg0Vk2Uygk8dl7ZVf8b12S3E0DbyOvrtNfhAsuBA//Dfin2rjuUFXmdCCe0Nyu+afla0aoidnbEnFUTU+/RpCKldTWZeFVzzvDyGMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(39860400002)(376002)(38100700002)(6666004)(8676002)(66946007)(38350700002)(52116002)(33656002)(8936002)(66476007)(55016002)(66556008)(26005)(6916009)(9686003)(44832011)(316002)(9576002)(33716001)(86362001)(4326008)(478600001)(6496006)(5660300002)(7416002)(2906002)(186003)(956004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?glLSVixW7/5hSf+i0JD+jIZVycsDWFO6WRBY5fnPad9NnlQerVz6c9M3aa0V?=
 =?us-ascii?Q?K3K8Azs61ijd/DKF5CVZwBvsBGLDEZx20yXQDPBh6t8GSGgNutF4eDruYaqo?=
 =?us-ascii?Q?8QpErewEGafK/oR37dwekct2Ikqc5PpJJEk081vEh5dM5ceFJZV7QJ8kb/g5?=
 =?us-ascii?Q?dsd2Ijia0ZsnsvFTJnx5wsi56sSG8j+i3NbfIuZEpG9RalLurbHNciVPx/cb?=
 =?us-ascii?Q?yxKCI+IoPtchhd+77DLZD7wJaYqwUGc+Y9DZ0RblsW3JkGmNGxb73bfOxEV4?=
 =?us-ascii?Q?lfQOD8MlJjHS1cCSVB2RAuWs2ZnohyQXPOjry5TVKJXoRm1daMVEaZGmD68I?=
 =?us-ascii?Q?f18YE1GqbJO8bj1MyaTr8zrkI5UArvassmHl7lbLOWcLAqWf/6ofeHydKkQA?=
 =?us-ascii?Q?X1uOx40PJy3lv9/P/omHW7c58FKJPgvhC1LwUlO+0FLtDfMHkZPab1L3QeRk?=
 =?us-ascii?Q?1JyKfRiBk4zdRqOnKVX5/CVvcQy0sfMV03fZDb7C7nQLLGETphiWM1qwAxxY?=
 =?us-ascii?Q?ibT77xmxZaGKX+yMSDO6KHYhsyLTQ4LtkSReHGRudDim3yiWG8y/uc+8bKqy?=
 =?us-ascii?Q?ma3+w00xa3giaSd8we70Aje09jgSS96ULsPn6ra5wHS+s8iaeRs7r0+x518A?=
 =?us-ascii?Q?JDLejITAX1zqYJ1baFrwfu+3b9t3VYtXO0hmYhCl8aOd/72/lKD6GgpsM0fy?=
 =?us-ascii?Q?wW51HyLS7SQaYYLNZy8ieIM0aCfQWvyC8UoR5eBFpzyk8xS1uL+H9seC8Awx?=
 =?us-ascii?Q?OHsSuzfLjiujI2kg/LGc5UCSWJAIxb/KSK3G7l/bJsKvuTdmttfSQgIRc6nK?=
 =?us-ascii?Q?mfooydwETzT7342AZi2yS8PFfYKalvBiRpCOsbVM+g89c3IWTL9QGHiRYTcC?=
 =?us-ascii?Q?yzkk4ZRgqiKWiuT2ReW3c9ffrjTI/te+HJ8bk2jzSUEuWzOjj46MsKpOVEuY?=
 =?us-ascii?Q?L0eyI2mvloonIi+DyJbe0+/GT9ojtTTfDd+tBi8cfMgU8YPWssjkJNsWogl2?=
 =?us-ascii?Q?8fyo85Zy5qG9P9L9yC5joDfhbCML/RuPfwSzmqEmkWwBVci2stBeMXXIsIWa?=
 =?us-ascii?Q?+wZxFZ3cVEIeXbewb3vkvJdkJBdtfP124PcTnUqdRELii258k0pFg/I7riS8?=
 =?us-ascii?Q?2Es3UNnu5lrBZVAbMLBAEzjWaP+9KS+nZPHYzPMuJqCTgWSmRf+FzNztbsLy?=
 =?us-ascii?Q?QYSmpIc+ZTds7ShZHfvmmZiJhvPUUadfPluAdkFcaYMxW1RSEmgX6Qrwo5nv?=
 =?us-ascii?Q?HZCYisRViVq5rksmvJmD3BagdrZTAHvTHOppiU5TPTiP3/QUQf6l+KFguiB/?=
 =?us-ascii?Q?JditOI6ul23om1tpgn6Xfau6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48a1cf3-66d7-4d33-16bc-08d956840b8c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 13:38:58.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zUgUHPrzsuSzjwWa3Qn1LG8jR8QwiJ8G02tmCAJllEVjwj6QXEBpUDQzob2NiYWfDpXyrqhAi32fugJiyX/gjRubNm/eDGiwYgEUDwSOi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=763 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030090
X-Proofpoint-GUID: W8sJHpVxyde_thda3B_5N6wgzkTm1Qvw
X-Proofpoint-ORIG-GUID: W8sJHpVxyde_thda3B_5N6wgzkTm1Qvw
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Missing subsystem prefix in the subject.

On Tue, Aug 03, 2021 at 02:57:09PM +0300, Kari Argillander wrote:
> Capitalize comments and end with period for better reading.
> 
> Also function comments are now little more kernel-doc style. This way we
> can easily convert them to kernel-doc style if we want. Note that these
> are not yet complete with this style. Example function comments start
> with /* and in kernel-doc style they start /**.
> 
> Use imperative mood in function descriptions.
> 
> Change words like ntfs -> NTFS, linux -> Linux.
> 
> Use "we" not "I" when commenting code.

These are all nonsense style guidelines that you invented yourself.  We
already have too much pointless bureaucracy.  If you can't understand
the documentation or if there are typos then, sure, fix that.  But let's
not invent new rules.

(Also it annoys me when people pretend to be stupid "I can't understand
what a NULL deference is.  Ohhh...  You mean a NULL *pointer*
dereference!  You left out the word *pointer* so I didn't understand!")

regards,
dan carpenter

