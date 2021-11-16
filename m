Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A98453900
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 18:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhKPSAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 13:00:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64998 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239250AbhKPSAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:00:35 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGHnTfn030336;
        Tue, 16 Nov 2021 17:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SYn+XycxitZ7ny1AZYNbx63Iot43XYjJrPRSjfG7STo=;
 b=MOjDFEPCpXLOW3ijaJuRjacaSoOWI+5rD+1bCNKY97DwmZyLQtBLOh6AnQZ9pgo3zk5P
 ekQ/8VaiutxhgHHxVq75uKCnToYPmohyihxB+TprUhlDY7UgVY7gE7fDrkACCXHgKTGA
 AfbrXD4r/4iorCy0zh+jgoURUoTqGQj95GFVVx3YCzOwbggH1LFjBjrwogTbX9AiA1Xh
 3RNmOzm6EBHBlmF+mW7477/jd4X/w56rjXM/TnVYy4+EoU57Bb7NgbhmKBZMygWQm8Tv
 Gd00+RvLFPWulpzwWQ4y/etJPTSHcNAasv2ClfZn75+IFyA9a/QhSlJK4J2UA+kA+oJE 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnub0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 17:57:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGHoSvv040857;
        Tue, 16 Nov 2021 17:57:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3ccccny49d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 17:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdIKPDnzpfAqPWjtT+7RYEf81ihAKX3WraAfEdoISwQHJdQhUb1VFc9JnvxZi5PYN9VWexuZ9/cPEAYCKSmDru0FVoU/svhvtwvlCFaW1wLfXqwLhueMOmFGAEsDvCS84xLTViweeQwIRHNczckKvSZqhro8y4IJNdpkdUW0imaTIsDDQ81RT3xbz08+bhHAgtY/Z0faW9YWC2ifRpOSy+m6+f33rXES333hZUW2C8hSOr6REC1EZ2Ntb7Jg29QW7m+acV/Gj1dtG9uFZogBfmK192lB6naRfm0gto4HSrje8my7kDaRdB1UDecjh899q2+25cEpOZmw/DKcgeL1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYn+XycxitZ7ny1AZYNbx63Iot43XYjJrPRSjfG7STo=;
 b=j0mpT9BF1hQktK4FnVeLBm2CybeRYhjy9SWPKmltNnBoouq8d1zl3Bl+A1qcTbzmrZhJWaZ6/OTLVK+L8zTKK8JUs/qS3psRVg5X2kESGz/RErO1Bcz8f+yBSD4ia7j4XB8tHH0CfCZdQ9qE9FTsumTrg0lCtqtrXYJl6OUWmOR3QLzcldZvc/XZK5x93e1HOz39rSijoo2nKu1gXdfghgTVa7MPuol3P8kg4m7nRMoW8vOpWWpQq8+t2ktPxUkUZJRW1CViZpFphEQATIJa2XylMsTLSuE4Go5a+01pYvk8mWdw5Yei3u0CN4KmFbBHhMQG1k0nt4ajp4UQC1rdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYn+XycxitZ7ny1AZYNbx63Iot43XYjJrPRSjfG7STo=;
 b=UmFlqlwXho4kgrFMXES+/b16gdDh999r6u6p5/hbIXTGA3qO3vK5MRD5mJqjT5fUPTqGRZQlQSHCy1lxD9aory1hvXMpQpZl5uotbcx3h2YKqBL42zIJIswqtTDX2g4RW0CX7D/ntSFNer08MDjCVoxTmitOqPBGhxN4NSDQey0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2206.namprd10.prod.outlook.com
 (2603:10b6:301:32::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 17:57:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 17:57:30 +0000
Date:   Tue, 16 Nov 2021 20:57:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] fanotify: record name info for FAN_DIR_MODIFY event
Message-ID: <20211116175709.GJ27562@kadam>
References: <20211116114516.GA11780@kili>
 <CAOQ4uxhHzoK=MU4Toc3uQSk5HZLZia0=DBBkC2L1ZeVVLTLGXw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhHzoK=MU4Toc3uQSk5HZLZia0=DBBkC2L1ZeVVLTLGXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 17:57:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4af5292-d1cd-4cde-2add-08d9a92a8f0f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2206:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2206ABAEF1E5CC7CECBB42B28E999@MWHPR1001MB2206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrwaoZYLc14EuJANR/4fIB9BVu5sordagnJBaihQqvWbDnpqTZY+/V/cVrmswfMWtEAzQnVtOwm8P7baUEv6HeY/Itj2+9xAFHmXkg6bjVzY95oBzqV04waTk3e1bPlhmUHhDTGPB48T74aR/k2SZ/BnINoJ5cbFb2jryWsUOruT7QiSH5jQzZ6PbKMVHeMKWUBObBLFSn8c9tZnLUuSagjzneh8UQr2W0w8emckThw+iqxqtHgTe27gEKzHFlx+Mg5HgVc2YVhO/vKGVyqHllRHR2oqbLmLLYa/aBRThvM3G7vYMl5EM2MNyYSV3TB1RmQBqE5wXuTBijMfzP6zjZSfBZvj8Rv0dCQaahe/G+0W756t7MbhCRgGKifE23wfZMjiLW8Sx7jVK9/ltxc9Y3nZvcNNVfdNU7BUevFKGu9gd3iTwCrwIX3Dx6/jCeMrz99B4R/2N92FH9o/79zihoZPXPML7G0FXXJJPJ0qvcuXd+MBPLLvo7NMw8H8nzXfSbUdLpeAR2c/jPlo+iGIer9BfAU0q8E3TbZY6lfcC6EHG1iqNSO+f4N4uBOzC/V3VzMoCQslBXdL61oSr6P9QUq7jicPJ2OQxlnfz/7HA9UF3vXYGtoby8MnAjwe6864H+N5fJ6wNoJhdfRNJNdRFTwfEQNO7ZRxR9Yb5UJ8OD4VPtooMaOacj92heW3IPNbnwZkkhjGDvi7rP3islGkKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(186003)(9686003)(83380400001)(52116002)(508600001)(66476007)(38100700002)(6666004)(55016002)(26005)(8936002)(5660300002)(956004)(33656002)(66556008)(2906002)(38350700002)(1076003)(33716001)(6916009)(9576002)(44832011)(53546011)(8676002)(316002)(6496006)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7e/WxRdERDsRSkDHqYuxlgOzJboX2YsYGh6YKYRDAg7AKiXkoUBgiX0FSY8N?=
 =?us-ascii?Q?jlh2IN9KwdBNgE/cPBEpcgxOGrrbn0dH3yT7dwHUwvZLQvwK4huN4uZjIUh8?=
 =?us-ascii?Q?UkoklyPeTH59iuXVElH9Msd7yGdeHy7coc/y0f/RZq34JDuM4WRTYZzOn48u?=
 =?us-ascii?Q?QXuozMwla9TdNImCB4JP2khE4al4NSMBacaB+gVL8VPELB6INTn3+0RGoXki?=
 =?us-ascii?Q?pATH4MzGv5aDgYVM/gAKgHfs/pDFre6kH9fwmLHR61rVJyOgRMpkFtq+poC5?=
 =?us-ascii?Q?mmz0pXj03M2xW70+925ZREn2KlQD5OPYTWiZYmy7qgTq1Z/T4sqaDonY/uVe?=
 =?us-ascii?Q?j47jEQ0wpgb2CMrunChFjnquhUZOTXk7wgbjZCC/lUXnakyhMw4goBdhIJ57?=
 =?us-ascii?Q?EwZxMWO9v/Enk73KriMfPfHHHz4XucdZXvBzWCH3rTGFVeHOtMLgIIDDMIRw?=
 =?us-ascii?Q?EApqEuMLaIfet9IRiEa8ag/VkduoQjy3enAbAAiimvCbY3zDvBKxFTIb/ELv?=
 =?us-ascii?Q?yUw7urXbx842hCX5D2649eeYHgd2H4QhsxC8gsZl9ul25DH/u4TPVIgRgsLt?=
 =?us-ascii?Q?BHd4EFcwDxDeeV7tgxj1KPTT+eSR0NilpoJ4MJizce9QGFxl9JVcK6uVZt6F?=
 =?us-ascii?Q?urEJbkj07Iu6Ttf26+TWDtP4q4/YKe96cfdkOnmvzuz83x1G43om788it1zu?=
 =?us-ascii?Q?ydj0czwKRClRJIC7aPstJJJJC2IB9csvBhjlGMKeuP17dYm6Nwn6N1KIcZis?=
 =?us-ascii?Q?bhP2pM1CkeZZNgDQ2VW5g9Ah/CQBVNa4aZJJs+CLnc7Ne9nkbglnBoKa+s93?=
 =?us-ascii?Q?GVTBX4bN9QFkHVyWqgXVoSrpTfsucxySFh28ydcuOD7yo+PivmQGbom4SA3g?=
 =?us-ascii?Q?Q8dhpYXWEmnSA2TTasPmFHkEesSzRAkUsNHIOCJkpP3JIxOcohBe9QsZbh5L?=
 =?us-ascii?Q?L6HqM0aP6k0rzy12NOeqAsGQYsKWSUSFSj/ug1ogWEIU36g6UvHt1Tvfv2fH?=
 =?us-ascii?Q?M4SsV9jUle47kWRbzquYXwefhmV+gnCom8Fr9hL9VGLorAFNqHlGVnM5OC+H?=
 =?us-ascii?Q?lT3nRFKeMfaWRBhURxSHreiy66X8ZqkJtDcVbbUvR/zDwHHv2bNWWs01TdGz?=
 =?us-ascii?Q?RogPhdyYVZc6t39yjr90dmAqx71FEUs3ekGokB6NrARLCjBpKI7Ti7fC8Qtd?=
 =?us-ascii?Q?/LXkGyiBEsfLYALdwlQ8l6SPmckm3PM5UQxYTKAOFBBiH1jG/EwihevEBeBA?=
 =?us-ascii?Q?iuLa3UEA7nZarvasT3j3ZiYnrUMAVSIfgqKas0PTRj31ObXcZofY+hFsmMo4?=
 =?us-ascii?Q?jkXztSuYS66ETDnyLO2ugGB18tItCswm4dD5s5CNd+hH2dWTHGO6KtQooqiq?=
 =?us-ascii?Q?SAwnksMml8eWG3GuNzErC4ZQnTFWHpqUDBGXalExzU3LjctaoE5NHHNjCEDs?=
 =?us-ascii?Q?hTEP1OGecGKyQGDM4ruzVvpFzXWHHKPVEhz7uLRKKfCNP8EEt2/rN7FX89cF?=
 =?us-ascii?Q?B/1vLjQaL3G/KTBw5dlkdhZRZI6XVPMYddmTvKBoBU7BH6heFJd2mkyH57Vr?=
 =?us-ascii?Q?gSxBDZDHI7SmgMqgGbpBH562A2qIycwdPoBJJewbhObh2rPMTvFEw/llKIAF?=
 =?us-ascii?Q?EwDiLjKhtBNHnFt0qK6fQOFYILjhQVsQLIeowD2nENKZHM7yQwH+doX5raLx?=
 =?us-ascii?Q?f1ppifLACSGRhM6/H+0U+Tyecr0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4af5292-d1cd-4cde-2add-08d9a92a8f0f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:57:30.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hhul0Zk+OJBtP5f+Up+40xe2hDq4Opfeig3YUKggA9RI4O0GlW+jAnpnbhU3k/+ny5hfUwTvqwfqkj2fp1wL2IXH2CI5MHzQmsr+sPrQJ/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160087
X-Proofpoint-ORIG-GUID: 4W_S5BFbkWyhz8h0RKXKLyurLdY0um9C
X-Proofpoint-GUID: 4W_S5BFbkWyhz8h0RKXKLyurLdY0um9C
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 05:21:34PM +0200, Amir Goldstein wrote:
> On Tue, Nov 16, 2021 at 1:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Amir Goldstein,
> >
> > The patch cacfb956d46e: "fanotify: record name info for
> > FAN_DIR_MODIFY event" from Mar 19, 2020, leads to the following
> > Smatch static checker warning:
> >
> >         fs/notify/fanotify/fanotify_user.c:401 copy_fid_info_to_user()
> >         error: we previously assumed 'fh' could be null (see line 362)
> >
> > fs/notify/fanotify/fanotify_user.c
> >     354 static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >     355                                  int info_type, const char *name,
> >     356                                  size_t name_len,
> >     357                                  char __user *buf, size_t count)
> >     358 {
> >     359         struct fanotify_event_info_fid info = { };
> >     360         struct file_handle handle = { };
> >     361         unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
> >     362         size_t fh_len = fh ? fh->len : 0;
> >                                 ^^^^^^^^^^^^^
> > The patch adds a check for in "fh" is NULL
> >
> >     363         size_t info_len = fanotify_fid_info_len(fh_len, name_len);
> >     364         size_t len = info_len;
> >     365
> >     366         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
> >     367                  __func__, fh_len, name_len, info_len, count);
> >     368
> 
> Upstream has these two lines:
>        if (!fh_len)
>                 return 0;
> 
> Which diffuses the reported bug.
> Where did those lines go?

I'm not sure, I suspected this might be a merge issue.

regards,
dan carpenter

