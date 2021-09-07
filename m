Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F120A402FE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbhIGUv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:51:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15870 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhIGUv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:51:57 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187HjiEh022675;
        Tue, 7 Sep 2021 20:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ex/mWzrlSinNuYk3E5Qb+cYr0SCKR4ValGQtSSPDGi0=;
 b=etBw+amx/l5R0O0DfXIBDUZf4PCZnz8vcb6HjvfQi/c+Li4Eaa9kdeOJy0avdoh1XDSf
 pTj5j0xFjuz+nCw7fvmzayB+z8twXfGmQ0HZhAo1Q1IpWIWpV09NUpDyDsiUKZQSDW4+
 0o6H76vaZPt+OsblM+OTH7XQsqQxee0C/7+irCRk86OPP5ndnVAmwijrz/tmJGLFQhh3
 lZNL2/A0BU0HxFkHFFYzEk/3ybTKd9BiHGQWkZvRlMnXHIogib3fCuyUEVcMA6md0gA9
 tMosUoNRQI+bF791J/TBfBRmXQSXc9fKIhyJu1qbEOYqexi9lkmtN0h6g5sEexGfTbUZ Qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ex/mWzrlSinNuYk3E5Qb+cYr0SCKR4ValGQtSSPDGi0=;
 b=de19zN2iq08Gnatkfed4Lira4Nmq2kaZ3tj3NXx+ikSwYggULIBeKMFgxFwVQ5yAfuzQ
 S7p07zxV0FmYVnlWjKi1avLggnJvboWKuo0N/ALZqGCIgsGLVrBUjsmfLqTSBnsiaFHI
 QED27S5WE4ETuqWnxYJPc0CP+p8QhX4T/8vv7UBTIJEsUlUshOwC2pInt2DGDanB0tbc
 WriHKsQRaPbmAntKT095O+UahDT7OGDKoXgMv6btrOk/SMEgVRjFpcGVnrBSYaYzMLhz
 yqQcvC28B+2uVsCCjlDlethZkJqOsn0RAa5Dp36oDmdSTjJ8TG5B1D8I9TbWMzZnciDz Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs18ey8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187KQC0Z185448;
        Tue, 7 Sep 2021 20:50:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3020.oracle.com with ESMTP id 3axcpk7tfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXYvBbG6tx9gWhnpuyHfY4dwehr44SVDuFCjl3BtIgPvj1a7g6Ovb0IXRfK6EAJ1s35NREu/MS0kdlodnxakOrlyvqscSTKx9oeLUy7Y2vxWE8kn/Abf5muw2i6dJ1ukUpL6ZMbXCvI0y2hPuTBoSWoocjjBs4BBeun/EsKr93b4l6igCndpv+RiNnhNiGMfDhhevsUf10vqT1qT4+zMI2jcoZWfeXQ7OHgY4dmc7MO/+hNo5GZ9vhCyb4c0b4RtBy4haY+V5Qzm1nWlXEOB4YEYGLaFe393Hswbsuw5qKKRLMsN99laHMRWAygEFMhvMC0FhfAUOV7MRLv6iq79ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ex/mWzrlSinNuYk3E5Qb+cYr0SCKR4ValGQtSSPDGi0=;
 b=LVB2W/ewBrhWXrfRjhFydtvDYSA2J603Rl4RYk1EkXpGa7aD/vYO7iYgmgsdb6VUboupFeqY2sps7NAvmc3p34JBLeAkY6k6vYlkLwDeTAyinftqwMttsOXJHAezd9A03+JsZxZE2ZfGUxx9Ffzkw1P3amo1aOXg0YxXR5uUhWdpPYF7gkfUR0jbUb2n6hyVyPOcc16eUWrZoZqhbHWp35s8e3zWU14Z6rYBHdBTwTmotwRBvKU+oJ45EGslD5Jglf7sc9sNUpJI+zsZuHVcPDDrwQyk0yDw8SomOuPrFQC/nSKwBQgdH+OutqCIiMeNJ4ly22Jvh/xsRamL3hdRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex/mWzrlSinNuYk3E5Qb+cYr0SCKR4ValGQtSSPDGi0=;
 b=fxiDABrB6uc7NpK5F/P2Q4TWMiatXTTjXkK15re2F1SSY0EeBbkgTS3wuolYXCaxFqIvztzSmvibwtBdolU5u3Er8evlqObqGzrfSoPHKTx9TOhRGMDq2smIjkEiHueIub9OybQvgzQa+in7Sn5QXLNpdsvZrYwzCu48ogW9UY8=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 20:50:45 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 20:50:45 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v2 0/3] namei: fix use-after-free and adjust calling conventions
Date:   Tue,  7 Sep 2021 13:50:40 -0700
Message-Id: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (136.24.196.55) by BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 20:50:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d01d19a-dc83-4f60-ad5f-08d9724129f6
X-MS-TrafficTypeDiagnostic: CH2PR10MB4149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB41494FA09CFE23780DB4E96FDBD39@CH2PR10MB4149.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?REGxjAlZ9VXH6V+p/qigV/zMU/1Hi6/JxCKSBQV3RLMS2HcsXihbjAK/Ijur?=
 =?us-ascii?Q?YUeyte8FNEEF2gEbGHJHx+zIJrFSc96+i5I4bTcBs5ut0xnGuvLQS0Fh18mu?=
 =?us-ascii?Q?LTJmr7Nq0BwuUPNEsfrztVEiJLSzsreTQgkeAp/7ZU1YNU5OBIPTL+ihgZ+a?=
 =?us-ascii?Q?Fj5EK3h8msKOx+NGPc5roY7PunmwVbjXqR2ea/FyE6OrYyBQ+NgVyYmfMsQ7?=
 =?us-ascii?Q?NMG0SPrrPuUzyoQKRwvgtTDcq5zghsZoUPhiIFTZPn9aPFdhrEHDh11ptn23?=
 =?us-ascii?Q?MShsz5pbkYqM0UNQA388Io1PAVkQ3/B8qd80L10BaFA8LQ/Ok6+Fr8e21nJU?=
 =?us-ascii?Q?3Xyv+h6BCwrDIThoey7jBY05oCaFvqQ2Bml8FJabfIqnYdkYAYb/aapq9NLX?=
 =?us-ascii?Q?xPSJ8VyXYVQSykRDtLW7i5CFnzwAlQaeHtLuCEtNTdjJ64VvryycAESFJQok?=
 =?us-ascii?Q?fQjftuq8XxXTpzWapBqwvFXwP4bIkWxWWgDNQ1CMY93TfPhxYivGRlvcYwZx?=
 =?us-ascii?Q?mSMdC51MKl6JMfRr22YNUGVFEIh7v3h8EbSiJ+Zf9YQ5jDU9w7eabSBTvLJv?=
 =?us-ascii?Q?sCT8PkfDyH6VcEP6ZqwBmUSer/9ySaFYM6N5YwVYS3GFRgav+2Y68UaHeNXU?=
 =?us-ascii?Q?LoVnED+RUF8THTFJRaQE3bWaLzfAeDhQErcDeGMvt3Xor4EXKtYR8KGPLNBT?=
 =?us-ascii?Q?1QptBwH5XErrOLbBkgrXwO5+uipbUJ6eBOL2f59ZicXEK70OYFpX4IGSTt7+?=
 =?us-ascii?Q?Rpu5PWT1LaNllkdwWFAOQ5JsCz48/jLLJUGxhbUCjGyQAZdJpd/azrQMzLhQ?=
 =?us-ascii?Q?JhAkJ9gOPqAUi/sk8T66MrqB4b6ncXfRJFig9Y1BQyawoD6l3kG+pEMsLTEl?=
 =?us-ascii?Q?sZRUYyJ7CL7ykiZZFgq6GzpZTWrvWa60X1MdXUa5hYJjUk+XYr+OZxVzPPWm?=
 =?us-ascii?Q?P1y7PjcuC2sKk499Fdg9L2KmKJtxOOgOkJHl9KoYEPvJB32ghgoi0vGVVfjs?=
 =?us-ascii?Q?cvCIppxb+Tt1SzC11yzc5RLE6KEDXpJJDYP2HTjJ9nPAzYg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(103116003)(83380400001)(6666004)(26005)(6486002)(86362001)(186003)(956004)(1076003)(8936002)(38100700002)(2616005)(38350700002)(8676002)(36756003)(5660300002)(4326008)(66946007)(66556008)(66476007)(316002)(508600001)(6496006)(2906002)(52116002)(6916009)(107886003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DyiJg6QRgEeLPsaeikoWhUnbNU5rsZcH8qGKOO/FhiXmC6mi6KfyGzQYZfXq?=
 =?us-ascii?Q?hbv24FCnISPclQuFe5GYQ/304BIkr5GmLRnPmaaMMRCFmSZimfNqjMvqVGqw?=
 =?us-ascii?Q?GkUV7PPJ3AVeesL7sp95c3wy0mzWILjUJAcwMiwaLTUCS1OWbRhvtT9pVJim?=
 =?us-ascii?Q?CCoBZiDaEJ5bFQXK97Cvk3uICc7nxiHH1L9vTLb2cNiDTR5UMwj3yzfNaZnE?=
 =?us-ascii?Q?uIgiAqxJ70Ju8En1BNupLxoNqhLGovtOb7Q5Yqwjml7kv1zwHZW1iuLacK1B?=
 =?us-ascii?Q?93JJLg/vZcHMdkbSBXxaaWTXpoSXFNJfMR3FXdntJwK9MVaTStD5g7PdMD1y?=
 =?us-ascii?Q?INqn3TvvcTaoHpUOQhkPmvJUpcdCNet5n1Ja2E+OadiGMQ4pHG8eFeuwEC96?=
 =?us-ascii?Q?v0ORHoqCrOajBZ9sQJMPpbXhl1vhYVL9i+1qn8skCudLTTaRYow4mMSnesl/?=
 =?us-ascii?Q?aMNqWaTdKpYVPTwoarTLoSlbYu2QL6fs63SHgRl+tWWLbfvoxlsjR8etjLHa?=
 =?us-ascii?Q?KE62MGL9rzrNplIJ9WgbvcdGyKbWhfV0QxJyyIH8QJosnMr+XOoACjt7+Cs8?=
 =?us-ascii?Q?EBp4wl8q70ASCt0i8hH6kk58A/jZi8tbSj6qailPm17CyOlA4/b+UxWFAJzg?=
 =?us-ascii?Q?VUOM+2i/wHLSqmyAfuohn6WKEUbKONl+i4J4hwVPct4RqmfovZZKHhd5ztsH?=
 =?us-ascii?Q?vtPNngoYuWDjzZm8ls6qtRQf77XbMAmos5TCzVvMKaq6JhJZD/Ro6GTa9KHH?=
 =?us-ascii?Q?lktj+/o5A5e86noWILYbvZdOL6wMo58yhY0HTiOs1KTuyjUBAbRFzn7T2Gkn?=
 =?us-ascii?Q?F4qUDV2nk0Pisix3qE683eThOAMwUXMKvmVPWb6j9H3oPjrPHB3wpjtTlr99?=
 =?us-ascii?Q?PWyAtAX6DdE1kzOUmXfS3rnOE9qlNmdOJH0Jn9hZXAVd7flAq6EtAG6DIn8H?=
 =?us-ascii?Q?qZ2FJtxHuKtG1HBH7iAM5mjOVUyxHneohuDzYbnhjOR69+NhIul0RWLLKtfr?=
 =?us-ascii?Q?9Cu8+UYay3BRgWBd0BXerBmwQfhAIwcO5FUnkMaK7PI8hX0tCLyZV5GFPHeX?=
 =?us-ascii?Q?dUiihvlTR4kwVk9hf+Qoi8KGqKwyJojyHLkKj64/BzGwkHTS+0FlqspeNkNP?=
 =?us-ascii?Q?WsRrhfugsVbd3tBYNbBYbMEPlLedWta+a8beWOcd5OqqItNV5dVvh1tufO4R?=
 =?us-ascii?Q?E6gicxWAifU0syLesZtTenkmAaZo37nWRlL3/W07T2W5b1d9YpVW8XtI9Cw6?=
 =?us-ascii?Q?GSka/3DQulORUlgWFz8BctZ1k8Sa+MO90CvsRr/MRSQh9gVoaApscQcKeA6n?=
 =?us-ascii?Q?IOogfdHhbEeVV2///RiCpgz0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d01d19a-dc83-4f60-ad5f-08d9724129f6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 20:50:45.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/mElSIUc7c4S40+LiEn2CYboVLTBHG7dimVYr1PqDq8TCl5gF3U6eJruevGW4S2QXfVLnxiFaTmJBS7eGqFEMUKcCm+fyMocS9LOgkR1SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=784
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070130
X-Proofpoint-ORIG-GUID: M_7n4CFQXdXQtFNzcjpFAgVOnf2dQVwa
X-Proofpoint-GUID: M_7n4CFQXdXQtFNzcjpFAgVOnf2dQVwa
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drawing from the comments on the last two patches from me and Dmitry,
the concensus is that __filename_parentat() is inherently buggy, and
should be removed. But there's some nice consistency to the way that
the other functions (filename_create, filename_lookup) are named which
would get broken.

I looked at the callers of filename_create and filename_lookup. All are
small functions which are trivial to modify to include a putname(). It
seems to me that adding a few more lines to these functions is a good
traedoff for better clarity on lifetimes (as it's uncommon for functions
to drop references to their parameters) and better consistency.

This small series combines the UAF fix from me, and the removal of
__filename_parentat() from Dmitry as patch 1. Then I standardize
filename_create() and filename_lookup() and their callers.

v2: Fix double getname in user_path_create()

Stephen Brennan (3):
  namei: Fix use after free in kern_path_locked
  namei: Standardize callers of filename_lookup()
  namei: Standardize callers of filename_create()

 fs/fs_parser.c |   1 -
 fs/namei.c     | 126 ++++++++++++++++++++++++++-----------------------
 2 files changed, 66 insertions(+), 61 deletions(-)

-- 
2.30.2

