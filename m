Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA4453FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 05:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhKQEjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 23:39:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10792 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhKQEjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:39:01 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH4TNMR004758;
        Wed, 17 Nov 2021 04:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uK0m5geO1BSXtG8/25swvAwcS735vktZKRpx+JxXgQ0=;
 b=BZm7Jfw5kWntnyUQDb0nh/FyhOsTHdmvQm9+9JsBgZPcmmh9dwGLD9Dgmg5hhoFVgBPA
 rT+9s7r00LOAC353bz9+tfG6bjAOWhyFCUMU/RJH9fuIpFHQOUTYIOOLr4UC6QLi09nY
 RqomVm2Dm4Az/jyCHIEUtzuGpMISZRBhf1mo/WJBAfoN8pO0IKij3hUYrPjXfob4+6Bp
 8fdYcdVRWyHyGR64ISI+bFpMAwMxYLFfyD7UBtbs/SLA2m9zdfK6X3YsGSa5rZQ7fUai
 ujos/CjvEfdxstlVS2mGeu87xIPXswL/vQ4nog4Sk8XF5oGLbggOhAGNRfrAESvdfZx8 LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3e5dcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 04:35:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AH4V5Dc049871;
        Wed, 17 Nov 2021 04:35:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3caq4tnxna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 04:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO3jSYKSxD9jzrAnznXZtIpTEMmlqt1wtmL7B6NecgF8ekNy7AAlMI5XSb6ygF0xP4y9wGYD1BmyoDFN178xtq1rPlfydW5mhpIU0WPueWdfBLc6qG1SLtTw1BfuQ/uZqxFyPSVWC+Ng8mPBhiR0nkKmtQ9GP1O8Tafi2if5vsYr5WS8RTtnx3bdMRrNDRva73oztGWaHkju0st2JFSYeJipJCjPgSiXUx19VjQ/4WoH+2mPyYhfNUU5dDM/8KpvJdbRHiyKhOkGUdXZQCR/xdAgEyOr30z/b0JfNt4Pw23eY8BTX0KU9UqM2hhfGxayRWkRcipu8YCy0Rg8Ohtf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK0m5geO1BSXtG8/25swvAwcS735vktZKRpx+JxXgQ0=;
 b=Q2Ih9BDcN6N+eTosXIDtTd1USqGfK5WQMDbibRavqB00DFDzMlpv+nbNA+UfnO89JqpActVlV3AKUOSv7rQS8plRCOmlVkXUX6VQGfPkC18cW/ti2Ek3Ug7KbugxVxP654k4BDILM+Mm9nKM1XxNDEozglqTaN/iykByQHjFtxruveKmYuKLILg60ApQRFxLWA7shbpO9ZYegSpu5xB0E79cnf3dssd6cGlSoD7/DmHWxLQGMjPrzbjaP8oN1xFTUL3LTLMhGsindupu7aVZUUboqKySbrsJzOkiIcIH7xJOYnRd8YBjcMTspe8f6IgvF1zuEFw4iynEMyC8/nD+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK0m5geO1BSXtG8/25swvAwcS735vktZKRpx+JxXgQ0=;
 b=sfXOZtfzRqHfQEYBTKCP6udSqsfRnfv7fNEH4QB3VGLl7QEC4zZ+tzG8CwA0h2hUj/8Pb+wWTZ36UCNckMxfuykab98Qi+IzMtCBQRvwrg411yiMexYHAwHVayYj2Pjd3USukvMztFSj5cz/JmgI0qeDKwli8pqn2fZyfdnEtD0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4485.namprd10.prod.outlook.com (2603:10b6:510:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 04:35:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4713.019; Wed, 17 Nov 2021
 04:35:52 +0000
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Martin Wilck <mwilck@suse.com>, Jan Kara <jack@suse.cz>,
        Ted Tso <tytso@mit.edu>, mwilck@suse.de,
        martin.petersen@oracle.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y25n8lpb.fsf@ca-mkp.ca.oracle.com>
References: <20211112152202.26614-1-jack@suse.cz>
        <20211115114821.swt3nqtw2pdgahsq@work>
        <20211115125141.GD23412@quack2.suse.cz>
        <59b60aae9401a043f7d7cec0f8004f2ca7d4f4db.camel@suse.com>
        <20211115145312.g4ptf22rl55jf37l@work>
        <4e4d1ac7735c38f1395db19b97025bf411982b60.camel@suse.com>
        <20211116115626.anbvho4xtb5vsoz5@work>
Date:   Tue, 16 Nov 2021 23:35:49 -0500
In-Reply-To: <20211116115626.anbvho4xtb5vsoz5@work> (Lukas Czerner's message
        of "Tue, 16 Nov 2021 12:56:26 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0005.namprd07.prod.outlook.com
 (2603:10b6:803:28::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.21) by SN4PR0701CA0005.namprd07.prod.outlook.com (2603:10b6:803:28::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 04:35:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7520f86-8ac0-40e9-01d4-08d9a983bca5
X-MS-TrafficTypeDiagnostic: PH0PR10MB4485:
X-Microsoft-Antispam-PRVS: <PH0PR10MB4485A07E706954AA3B80A0A08E9A9@PH0PR10MB4485.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ym+3aBkkXV5GxzLXJ1hPexykcMfz3GebMt7iCNoeVnGHH5q1GiI1Qpav5xy7hYoBll9nXnFWzfuW52CrtN8UMCB6iUSXlpNqPWsHI5whJSnFjVdHlsod9Gou6mj0Qb7pFUCiF1xnFVhBbLbhvi6aG/JBXk2y5HiaY6h7KrlPmkX6SVyFRYSBCiDUipb8Xggu2h7XRgcrh9+0fXv0j209z8KGv9prJnuuariQQWBgOb8MP3OqCsxVsYk/+UqaWMiEPArtD7eq+V7buWnXTb9haSXm4ZSpcAstuqNswCL/XTcSSoDX0AtcIbTikLEZL8wTIe0oR7dblBWq5gcqED3dM7N44R0soP1fhQi0oDRh7dYhG1Vdal/GsiFSHO2W78LZWYhx+FGlR360i1us/3x5Qr0R/OfJ3MPid6kehsVAsS162DC0t8NKxEt/soHxpZUtRmT1cpg8hBFi33KjnvnVBuimgDrOx4n67lMIg/nUdevfumIx0yRLO94RJv9RMuDGGwxqSg+Ow72nVOc7LaAK12KCE3eJifVa6Pp3kRDoOVhDDZBRz8WBuUs/cTluAi4ewhu2KWd4txs7E7N7EpigxhHI7IUvgL6ZKRH3AECWPlLlHyxsRuH6B+XtbSEIRMY0TPLz+g0gKPr3tKi9RbMiPGoMOw/tQsJ8/ZybLkjZRFGZOe5K9UYazNObAgg/F0EBG1PJLpojMlJtHX6j/X6vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(38100700002)(38350700002)(5660300002)(66946007)(66476007)(66556008)(83380400001)(186003)(8676002)(956004)(508600001)(316002)(54906003)(6916009)(36916002)(86362001)(55016002)(7696005)(52116002)(2906002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lqha1ychcINdUlddMxogKY78glKO+KrN60VaiaMvYTqhOicEJVERFBsAW+vd?=
 =?us-ascii?Q?VRHHghKJrRdjSvpSUvlJoo6KA4v+CnUYSW8yPyBqgs11pnKTjweUM/Znz6wB?=
 =?us-ascii?Q?/BJZuEmHQevQXmNlFq3a7NJHrhNOwJ4sQtHN2mAI8ciJC8nAt65dKOffMkpA?=
 =?us-ascii?Q?nNdlZzfBBd5HMiL68XpcRCmfKjJ57YX8CySI/Esr+YmNpkAOg/A8ikjITDdx?=
 =?us-ascii?Q?HA3i4cqj5O/sVUDDs/b5KkuzpacPefZTbyHbSqr30kW1NGeNmL/nyjNZ1gUs?=
 =?us-ascii?Q?N0nXiOTN5c1gMfRt2nyH7fiLaZKfO7HB6P/JDK8N1fQiXiv6nfGjRbWgVAWZ?=
 =?us-ascii?Q?Wkb6pLhQ0dSj+A0ee1NnNJdqtv3XIUsJ3fNCx2R6zc1QbaXA697tcC/9z5Lo?=
 =?us-ascii?Q?8sh+kVM9eqlq2wBy/n07AJFgM0ZCrdfDq2cAE+InzORvCFWe/KaedEVVCGeP?=
 =?us-ascii?Q?SzyzZsKQTv5gN4ovSII5bCFe0KwuJf7nSEiTYUgBMzheMpagqrP6JqahCJMZ?=
 =?us-ascii?Q?532NfPD9NsiuNjK6NbpCsfNnxwTdDdPUftamWkko4aZG5JU53MSZwjmxajtp?=
 =?us-ascii?Q?WF003V44cDhczut3NGZg/UAY9yELputcP+zhHIZksas12QhcI5rOYhjQGMzL?=
 =?us-ascii?Q?IAkKgG0BDerEyKP5J+L+CkmXf6E+l+InSJ7kScv2sXdfjab8Pkr8sNx1yRHu?=
 =?us-ascii?Q?noIwOSrOdR5iCUPk0sms9eatYBaodAmvB7hfmNtWdCMP4bCT+WqdsRMcdzSV?=
 =?us-ascii?Q?gR35yUyjBHcPy6h7j02whsb8CevasOd3oNoD8tnyx/8aMq60PEJYhqXXvSj1?=
 =?us-ascii?Q?Z7s1JGPhGK0IGdNM0i8xr/aCNCYZz+ygiR2k3S3oYWtwuWM/fAVWyFg3iviN?=
 =?us-ascii?Q?YJf/bRV1RTxKkD+luRe0C+xTeeWhi9ek9/8z59bHs3Hpr+E47VozNwA/C2r+?=
 =?us-ascii?Q?d3AQPziZEMNfoW9wXSW566xoDdmqy7ZtwQaTUkXS38tWcmGDo2kA2Bqkfq1Q?=
 =?us-ascii?Q?kxoJq8q/IKn6gFvIrtynFOgyyp5pp133qbXClf7xo8xI8AQIfSwBOuGXeV7y?=
 =?us-ascii?Q?q2mURPO3rAk90S5PR5ZLRYTP2oIMzh3IAoOS8In52sTeQrABDorHsz9/4CFa?=
 =?us-ascii?Q?EC8o9asCkXBPy4EuRK/qVUSKclBw9JESFc2g8zlJPN+j0vPVrPCBdK4Mv/S/?=
 =?us-ascii?Q?52+yTMN9/jGhIMalAZJhX0wISghdxNABLhxX+Brq+uG/fqDpV/3vKZ+IRz8Z?=
 =?us-ascii?Q?c1b8K68+D4Nq0+i6Zs98UD83XgIb2YptZHT8pHMIiawV9YWgBwxBe9ww+R5A?=
 =?us-ascii?Q?h7HfP7cWgLolEltycEWsTb/qq+/NnEl9k/QvesiJS9NIfQnajjEmEsVVvJsf?=
 =?us-ascii?Q?DMgYDDJbbGWId5toXmSf7K7ID5Qp1K91guayvBe2LZxJEvNqXepqdgCa5b0y?=
 =?us-ascii?Q?coduaPQo14rYMzc48PnurX4gYJzX7GqA9IEiCX/waoesk5n7hruwbkwM3HEM?=
 =?us-ascii?Q?XNSbPj5Vv4SHboaxGrFDxx88o7dwGumZPwh77ffk/B40boWES9hCESj1eGjF?=
 =?us-ascii?Q?uFb4AMnY733zbA8lJPIEVpidPX9Jc8CRRULbimOQRoykK0+AGcscxVSVCLJo?=
 =?us-ascii?Q?/xfkID8EQABJULhUpbFkfGhv+DfyJKETBVa7Q0eTEOLHdT7/rgq/FMECnZ9l?=
 =?us-ascii?Q?ZjSSlQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7520f86-8ac0-40e9-01d4-08d9a983bca5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 04:35:52.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkRCTffsPL2eZFk94BToMnWBrBYM5vvvQ7EDcSBDBSJAMjgx9GEm9/6mRGSaKNPNFmy1KFi5aAgUOapKpkWYsKEQvJ8yrv6/li+9lEgOh+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4485
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170020
X-Proofpoint-GUID: HTM0zYg7XAB6iA3Y4YVMpmaSR6ODkkwo
X-Proofpoint-ORIG-GUID: HTM0zYg7XAB6iA3Y4YVMpmaSR6ODkkwo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Lukas,

> My understanding always was that the request needs to be both properly
> aligned and of a certain minimum size (discard_granularity) to take
> effect.
>
> If what you're saying is true then I feel like the documentation of
> discard_granularity
>
> Documentation/ABI/testing/sysfs-block
> Documentation/block/queue-sysfs.rst
>
> should change because that's not how I understand the notion of
> internal allocation unit. However the sentence you quoted is not
> entirely clear to me either so I'll leave that decision to someone who
> understands it better than me.
>
> Martin could you please clarify it for us ?

The rationale behind exposing the discard granularity to userland was to
facilitate mkfs.* picking allocation units that were friendly wrt. the
device's internal granularity. The nature of that granularity depends on
the type of device (thin provisioned, resource provisioned, SSD, etc.).

Just like the other queue limits the discard granularity was meant as a
hint (some of that hintiness got lost as a result of conflating zeroing
and deallocating but that has since been resolved).

It is true that some devices get confused if you submit discards that
are smaller than their internal granularity. However, those devices are
typically the ones that don't actually support reporting that
granularity in the first place! Whereas SCSI devices generally don't
care. They'll happily ignore any parts of the request that are smaller
than whatever size they use internally.

One of the problems with "optimizing" away pieces that are smaller than
the reported granularity is when you combine devices. Say you have a
RAID1 of an SSD that reports 4096 bytes and one that reports 256MB. The
stacked device will then have a discard granularity of 256MB and thus
the SSD with the smaller granularity won't receive any of the discards
that might otherwise help it manage its media.

-- 
Martin K. Petersen	Oracle Linux Engineering
