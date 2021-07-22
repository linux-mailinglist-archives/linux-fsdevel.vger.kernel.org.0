Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE93D250A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhGVNVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 09:21:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31280 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232177AbhGVNVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:21:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16ME0vNw013456;
        Thu, 22 Jul 2021 14:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=w31ZYQiggnfBgtWIsRek2y7HK2iAelKQtLHiwc1V9Wc=;
 b=kGwraQX33mNXyOYp+9ZkZ3KfQFvE3wE9sL+AC7n07T8c9L6GZwVKzLoJYnuYT0ek+Kr+
 UcqgzkCMDQfc8fWfYZHYYGyQ4J0JMPakl0d8OQYgOHgCTfO42UB/dZPfjznn1tzwee5B
 ynOiCA7qHHn7vEHHlVme0in6DOlNIVh+oZnPC4aKi+3INew0OYoCtUx4uIJiavZTwTLB
 fWjyi8KzeLyEfS2p2hY6P5Vt6tTiioNcUe1/Qwz9ZRbObivxzcRGX49hMeoAmOTtedf1
 CP+KujScm25QLfg77dk2s9ApyIWEmpX9DWuNDTYjZaeBjkKzAKgnwJB8mxLKkJzdwDkA iQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=w31ZYQiggnfBgtWIsRek2y7HK2iAelKQtLHiwc1V9Wc=;
 b=YkzHJ2l2pNkrT+Sp5GIhN+F+JY7481eTrslhHSQUzUKlu3kF1eS2voMm33crpt/LweeJ
 9TrdqNVyyLkPhSVaZG6A2W6sJ0IKGblyKVS/BY6sHrEI2+2hQeYzwFSHcY41bKYCvvP/
 fN4jc98dJDqG+Ve3nk4gBm50U+ldBFs/2q2VtocahpIAwVzs+5Bk5oMAkC1bLV0bX3xx
 AlkIEvyWWcuemT6BzlLCBYW/e/PCzP7Sm+TiDECHUtaA+yW8G1L/Acwikn+HeWKpdiGE
 iJZmErZ2Q3bXu2mlSJLJg2nCaqjWvflcmP80+q368HXuGD623sHG80BobrpNqSa4vj7q Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39y04ds566-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 14:01:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16ME1TLI183593;
        Thu, 22 Jul 2021 14:01:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3030.oracle.com with ESMTP id 39wunp0dmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 14:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej9QYyHIwmoqlM29ZYWxs6qisPL1XgzXiS4DlG9cUbhyAgnLMMSC8sMdpDbdT8iztDoED5CW8483g1tABk/HBWIbXi/eETif7lLR7uyzEoZPeZoDAYYxKy6D/qoopxmqp3dZ0MmTtNjcWoai/LRj8h5t5PwRM9mMY4kMQPkItNobxQMNwDdPGNSiRpvoGjkPgsRkUC6hxFiUOmhWv1HODqcedp5ue7vDqxq/MfnaVrMKEETg/px2UmjsuWc0qm8bs9ojcVPLFmYNeaicdXqS026Z8KWFGHyS+u/2v05dFsrYtHiYSAMf05A1IJpI9detMUFqeiTBYYxGrt5/kbdsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w31ZYQiggnfBgtWIsRek2y7HK2iAelKQtLHiwc1V9Wc=;
 b=hE9qVfbwVsmhOql9orsG4pe7LGVQUcla5fHnoz4cUARQG2QliqjGpZSdOlFkDkp2VMKcy5Wt0i+xeTfTkGCVft3KgoRoXbqSN2FL57oUILHnCYURgG9u8DcFcdciQC+dK07N7Xdou1rPsvDQFCRijJmXLgCaDJaDlP6UOCtp4RiY/LbEdHnvO7rfi75pexTgmv8InSIzstvGyIpLXz05+HRwsCq+4ypra1peU2pwlZz/1ZAvo0AtYYBqYZBdrm83MqUBgNCXmUI3lVWwGH5lTf2m4BeVbFIbqsxlHtD52YMb2F3NBaASPj7IpSH9rEhyF4rx49tC6abfmwJUDvWL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w31ZYQiggnfBgtWIsRek2y7HK2iAelKQtLHiwc1V9Wc=;
 b=HftMqmwn65yVl95CXostc96rEcODA26UoMmpIW/zJN1iZtLDRNvZ+ZDSyWaucs4/PT/yPgLL8PQPN9WHlGgcLTIvHzY63EDf2rAJw+C3gF6ECYYpNPjv/UNKrnoHHfggBBe75TSJ3RwEilZ+kKFQ6uD6EgWW1Y0x2Nrss7/fiPc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1951.namprd10.prod.outlook.com
 (2603:10b6:300:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Thu, 22 Jul
 2021 14:01:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 14:01:19 +0000
Date:   Thu, 22 Jul 2021 17:01:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] fanotify: fix copy_event_to_user() fid error clean
 up
Message-ID: <20210722140103.GZ25548@kadam>
References: <20210721125407.GA25822@kili>
 <YPih+xdLAJ2qQ/uW@google.com>
 <CAOQ4uxgLZTTYV9h4SkCwYEm9D+Nd4VX5MbX8e-fUprsLOdPS2w@mail.gmail.com>
 <20210722093142.GU25548@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722093142.GU25548@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 14:01:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43895230-d38c-4e92-de14-08d94d192e29
X-MS-TrafficTypeDiagnostic: MWHPR10MB1951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1951396FA999719C35C8C7D98EE49@MWHPR10MB1951.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYbKs4Oh0BJWa1MocG99+yuOnJxCEXck86AytyGW/wnx4nYfn1+46r9hDnvIHU0sFib3FQkwC3rA2B/osUaTKAyaqdYCMyaHTkU6FAl5tfRac82gIH51Bb8mgtashHI9w6+oLw6FJ6+WS5W6DPoYtyZBh5zFYA+boYHoELg8VlNicJXs/FsnCNyaZwB6eTRZHP8xSz82v1q7Ls6dcHv8yzsTl01F/B2NxnQt36yIwE5lXB69mXJJxI+Hkssc2V+a698yMgme8SzuYzwJEurvjLLx8WfPzgBWoJtxoc8o69bcYiYuJMdLXibGtkoxJ904lBWSlwrflKmTUIxbgTEWcwpWhlR7FgIs4NupGjspqqkF+hRuUke3nhgVtwPu36arC+v2asGTn7lO3iJMNbUozyOt46ypbOkHHQFk0m6Rzh0m9D9w/M8kJJtztGgsnwoNcyLP2fdrksZEAa5iOjshU9r/6LFkepi7HiOl+bzPIDknK1v1AQfGnTPrkM9CcL5pbuI0ZLmsHA8dxyRI8pxPMdewMHPWurB1z0AOkaOIdyGcg//0Qb6LQEzd4JB8gn1yIK8ACUxj99T089jYkZLcqug/GOMxwJfSqrN4GwEVCFMlhg0PIGr+wLLkpWat+qEMZwkaK7hhCxZlL1jg05A56LKzSiPNkkUcT/0PR17ViYL5LkzhTkiRhzuPo9c+2IdwsZWu1QIu4+Sgp2bcgjvomw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(9576002)(4326008)(9686003)(66946007)(66476007)(6916009)(66556008)(38100700002)(38350700002)(54906003)(316002)(33716001)(508600001)(86362001)(52116002)(44832011)(6496006)(186003)(33656002)(55016002)(1076003)(8936002)(956004)(8676002)(26005)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKe98UeCzde3NvR8xlaVoIJtgifp4PsB+ZAMe/BzR82WKTKaVZmP88l3RNCX?=
 =?us-ascii?Q?x0AFWoAEUsI5TOU39kY6YsyRxZgL+kVo+oYNeQjert3YtQuzJOKBmex2DjZB?=
 =?us-ascii?Q?eXCKMCIGAxYNhqKVbz0zy8fTUdjAngVgzWU/a4h0COptSO+XCUN+kIsv7w3Y?=
 =?us-ascii?Q?6VG0yr9EKK1lwUhtBy00YjLl/RMdA5xDWZ0ELpyqSzLBqyo+XZgcLB58XYvI?=
 =?us-ascii?Q?2oSrO6yS2CdCSO3uTpRwiPYGATgy3VnhZ9lrN5eJ4Pv0hWWDFpaYnO36CZNQ?=
 =?us-ascii?Q?L0Xl5gpSFNJPJHjljZ9nVFfx5f78Wt6wjbxXvVwU3iCcc0q3OKXZtl1yBJe4?=
 =?us-ascii?Q?3PON/QEV7lApRIbZq8WwhT80s696jgKKmyE4SS8spZ/otmKOZuzIG2dsrvgS?=
 =?us-ascii?Q?Q9mFFi+V9xW8PEKs8RiSyaJrvVpPYzZZ7HXWz9flC+KCECXq9n1AWkLnSJqm?=
 =?us-ascii?Q?QEZ6yHJL5ZtmvYa6w0KzRt7n6pB2/m93AvC8edAklnXFOD9YbbNk/UxnSDqi?=
 =?us-ascii?Q?71c6Mb1z8UmH97Z3T636xaWJ3WzO+3LEET72xRD1WSGdkvMBP5lJmTkPbCBX?=
 =?us-ascii?Q?y8L1Mhtcg4yyJKhrQZyjJC9B6FVg63fjvLhO3ZjtAM6IW66a3gJi9I3nnqOu?=
 =?us-ascii?Q?M7biARhLrQvYhK+tmHZRK7ds/U2UfSb4mJYDRqVEYP1ErLDPVDRGV5QQr7Ix?=
 =?us-ascii?Q?d2uoCHKZ6EteiOW7mBJAoCVhbOE39b3xE4zrlCx1OuAmh9ZhrT6PWtuYXNcK?=
 =?us-ascii?Q?NZjq8+QvAWZDpSVWLV74DjjC+PFUo1OrxNrAWUL0jo9i4WUlxzsRcHzNiD9q?=
 =?us-ascii?Q?KLXAe7LgnP8EHaqX5x7973cC9Dj5afSqABafV2FrTrzuuIdbXRPPdGNwM0YK?=
 =?us-ascii?Q?/XoMYGXuNrO+7XsIQSX4HMSCtHth7OHX2alaxnMDT1ggVgGXg64Mg+5mBmXd?=
 =?us-ascii?Q?f0WQEgbCKdOuhg0/fQmy3LPfxKpysxhltHWEyU71YMw8O6drmDHdcXOGoEXD?=
 =?us-ascii?Q?vtyGZ3SNriTOa950NB5OGa6wJetbpsW9C/gtY8eazgSBVAceeprnmBdL7GJe?=
 =?us-ascii?Q?jhcVOkQmHVAZVfytnWGnVKFzaqqs++p6O/rYi7wlLc7gLSpqx3J2Y9vP6P/H?=
 =?us-ascii?Q?6Y8lxB/w51VyZz3ltuIG54fVWY0tloN7clhg/MUjo5ZoNwKoae0f/d3OG+hp?=
 =?us-ascii?Q?pA/ddhri3R3QGc1YNE95HCnNrwzwN6KbgX4Up4K6vBxyios4VzTC4smqKswZ?=
 =?us-ascii?Q?CPl7iIP20EkwrlRk0wjfkjhMCxll9ByfI9LYtJpLYV3zHFbp6s+eGhq9kOe2?=
 =?us-ascii?Q?9noqZS5YJOHjo5T0ZYRV3l0i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43895230-d38c-4e92-de14-08d94d192e29
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 14:01:19.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHuw+eYN6r/v3WqsHFnBDAgUQUyBDNvpEy20klnfQepX/jiiSJD6Nvg6QAkgSPStugOX7D8qjjlVXppQI44pkICDn+xw9wiz7NIJZQjqdz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1951
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10053 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220095
X-Proofpoint-GUID: 97X-dKSDc72zlc1u26EyvFwS-tT2YcjO
X-Proofpoint-ORIG-GUID: 97X-dKSDc72zlc1u26EyvFwS-tT2YcjO
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:31:42PM +0300, Dan Carpenter wrote:
> Smatch is *supposed* to know about the relationship between those two.
> The bug is actually that Smatch records in the database that create_fd()
> always fails.  It's a serious bug, and I'm trying to investigate what's
> going on and I'm sure that I will fix this before the end of the week.

I'm testing a Smatch fix for this so hopefully it will pushed in a few
days.

regards,
dan carpenter

