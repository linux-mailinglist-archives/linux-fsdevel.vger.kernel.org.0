Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE940433A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 03:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348992AbhIIBtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 21:49:47 -0400
Received: from mail-dm6nam08on2105.outbound.protection.outlook.com ([40.107.102.105]:29489
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242103AbhIIBtK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:49:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nORD4P67cSntY3GtO9WZG1tI23K/QLlZDI1yBg2Ujbaj+ciqdB6BOm1U+Nb5MKTsLmaA4oS4ohN5SmawzVTA0QaFVtQ+twkdU/xEa4kY2+aTwfZ2TU6jLl5KnqQ5vf1riiulVAUN4qPUNUv6Jn7+l8YhyaghEn36L/d3IU7gqoIsyC8QU2FmaUszdBrwE+IQ8/s5yBVbnUMF/vfbYns5NUteZLFPc88fsdnlIw6yMtiYsu6JGGtZZsTKlltZfN6+7pExc6VtiI/e0g73xUFlvvSLQOTn9g4ItZgJEzbwF0+lW+SnLEf7rfzzHR2cTyFMILKYVqaUz3JLrkTUSAX66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wsDPZC+Mu4wyZjXc8xhoBtGqDYNeH/a5XikYjQY2tGs=;
 b=FoxVo0liaKqhc8tnOjwMzOMsYWglU/nhDUQnvjgZGfCNBBgJkVA2HWoYyIB0Ot/w7PSgT9/aE7Rg3UgWk9emkDu4EHuFtzQ8g0XzaFWagn3NEfhbDMTGZwPSIAn5889cWPnCIUTGvEmUQeehElAMlSQ4UwDNJ0tFp/VMMFvwXMUZ75EY7sIb2DLv7UN2sMnbHT2fUyUk7/5/6n425EFoOBM1EBu4yYw5O2/gSZ/V6MLFFQ8sMTpF0T6RZTEVJJ5NVVwrlz8DMgttZg/TbZgTcOl1L5pWXTb8Hq5AiC+0hqPO5P0VgxfY1y+okdplfNqcSn/KRnHjUunibOLodrGrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsDPZC+Mu4wyZjXc8xhoBtGqDYNeH/a5XikYjQY2tGs=;
 b=F9q1G/phdktO/uHDSNZlaFzJ3VRpKIT555Xz7bfHK2+1ZdeWYjZ3L3RJjnpr7SssKFjsVFhsQqoMRY9MwHt7oIjINYjUT7WFHWm+VnV7OC894IuF4etPAiIw5pGkWjQ3r6UUFX8n8mEfZvlGftW36bm8V1X5T3+aMVbuBkpW208=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO1PR01MB6712.prod.exchangelabs.com (2603:10b6:303:f1::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15; Thu, 9 Sep 2021 01:47:57 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4478.022; Thu, 9 Sep 2021
 01:47:56 +0000
Date:   Thu, 9 Sep 2021 09:46:20 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        jlayton@kernel.org, bfields@fieldses.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [RFC PATCH] fs/exec: Add the support for ELF program's NUMA
 replication
Message-ID: <YTnX7IyC420MNBLq@hsj>
References: <20210906161613.4249-1-shijie@os.amperecomputing.com>
 <2cb841ca-2a04-f088-cee2-6c020ecc9508@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb841ca-2a04-f088-cee2-6c020ecc9508@redhat.com>
X-ClientProxiedBy: CH0PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:33::34) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
Received: from hsj (180.167.209.74) by CH0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:33::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 01:47:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa62bd01-a3cf-4e10-1960-08d97333d832
X-MS-TrafficTypeDiagnostic: CO1PR01MB6712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR01MB6712B44F5AEF2D37F568D800EDD59@CO1PR01MB6712.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHPbNv70jsh9YxGponcpoQxHr1/1/sV++r9hOdCxpWw7n3K8pRmcB8DMWBn+UbofsgdCBtW11SCJ2MhWjKy6ol6KRU76Y9SWdtNpMw088/QynEqGw9c9SVGWtCpnNO94FYfB/PkcqrzyLXUlkLNd/4SUgsiEZxJLtec8wRnd2OiwEc9S+TW0mwa8X+bsAfSAYpjFUpsTqAxwKzLOA8PW53ERA5ceE191xXVDMSXYLxa8/G14Q1/Y3wpfkOHTonkPgBYFiBURuevre4uJh6mpcgQrzlpT2nc7mBTpaIeNesON3CXW0SzXAYFN+pjlBGzb3qbZ9drzi8YLg4bEhk3ZYTQdPzJMEoKQylCcYxb5E+iDvcgoziiS3AwmfbYduaOsA4E6QUBN1F0CJYh3kxQfaM59HQHiPoKZH9iP7CTnrAcDieeLwdxNhswWPuPQq1wuRNkBaCVzJyQhvl+qXMri+2pUJAOTsZGeF50SyjWGom7kynYsYCEOwjhG9Z65EoxRhAIdDcfubQoiCGEJ2cpwOPvnURBANLrvDoIHV4ke1uD7h4HWWp6bRLzGxDXJkF3nypAv0DoSNrALWNbx72699DYSz5bjsn5jK8lxLGxJPdUjhQTO9Saj9AlJuMnfmU4Yd8+Eq/40M3TfdC88evZVU2p5XCt634oECw6NJ1LREZfpOusBOCvYLIBfPdel+qQTrgaCU5LBBBPA1dXr5pVKDBI7K7n4lIyyOfK8sAwPs/0+zlZsiweWA3HKU5n7aqOTyIgMpNWaM0e/9UEq84oKCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(38100700002)(38350700002)(6496006)(55016002)(9686003)(107886003)(316002)(7416002)(26005)(4326008)(186003)(33716001)(86362001)(6666004)(53546011)(52116002)(9576002)(2906002)(66476007)(66556008)(956004)(8936002)(66946007)(4744005)(966005)(8676002)(5660300002)(478600001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQvgZOIqmmZAVIs6TXSDMbHMPMDoZT6EP9UM+1Nf4gPEm5U6SqDwMJCCSB/p?=
 =?us-ascii?Q?SNe7a4zg3C/E0BuLMDHyq/o/169npuUgUg1/WAb2LqYw1QVe01dvO1hYw3YB?=
 =?us-ascii?Q?+XXWiUkMSLmJbqX1iuANcvSbwGvzaUHAx95v9Ez6gdHEr19Ef80TrfMh9cvC?=
 =?us-ascii?Q?N8j5vSgE1OiBBuu6Wp14w6s9e7h25gRMaOV0sL+7v5gVLxJC7fvEomjEY6Hj?=
 =?us-ascii?Q?aZGbsF/J9R/UNHwKywnGckWGZbEt6PSp7Iq8yx1R72XsECNQKSe2hfY1kEYW?=
 =?us-ascii?Q?V5IPKGoBhOfMiKvuRBml1y522U13qDBcHos3OkxegzqSnIFbj6dGfnPghko0?=
 =?us-ascii?Q?e+FlFzPlsLY3ku7dmgLaV3VBTvHFRyo3zKvQRvxNFecRFkAaiUJ9/U6zh4oa?=
 =?us-ascii?Q?svTcbxEdsL/oHGGFine7iPnuDtntzAzwJmyjPidxhOuEcW6lg4i2GFWXGaZg?=
 =?us-ascii?Q?U0wyGhAySX6zXDf2YRzOTNtRwDDbl82yUIL+P+OmjT5n8b6UZBeuJX8RH8ie?=
 =?us-ascii?Q?sTorygDf3s/ferm7qk6Bm5LcKk2rodR4a5evYlICiBjBkcpdwLHb7wv6FJYG?=
 =?us-ascii?Q?rryX52RmoTC1Fsw9W3thxC3yu5hZAvGJxj8V98sbNI5SM20uLlHvUTCZ+Mfi?=
 =?us-ascii?Q?Fmkd7GIb+miPT8N1eANTaSSPuDKnsaKM8jpbISsVxugPHdQ7m/KbAL5dGmWv?=
 =?us-ascii?Q?0914qOL9bLayXHqZzUEL02hkiovSeHJmrdS10m7OMurQN+81TxDMczOO2Xk5?=
 =?us-ascii?Q?IjBSDogptmR2WUv0EF6jVJub8SwNsfbcNee+wvp29VAZ7/Ip3NtXAok/mkb2?=
 =?us-ascii?Q?TBshjeXpog2cXGErF7C5MP9+yyqZrl1QIIFGMWorCjitcwMv35eoYEeahETS?=
 =?us-ascii?Q?pmQG1QsYD+orlhQbFHozsgnV9wJ9FUUWS9hBHx42RWqAnLDyNDjwKd+BS47y?=
 =?us-ascii?Q?ALVPjl4S8ThaY3A0VhVnNf3CCLgAwAESBiMGR7f5E7mWajU7NoImoLffcHKn?=
 =?us-ascii?Q?1Td/rDAzdMklKoIoptrsW57SxdOD5eJi46GNDRKQuOgiLGE2G/jNCadJORyC?=
 =?us-ascii?Q?8WZBJLpN6VWzU0t+SUoKa9TaVSmexIwpISDbZJoS5xap2qoCzV6aFPjbwFO4?=
 =?us-ascii?Q?qxYjxyXGwI4pb+fiYJhdsJLFM6brCXXL0VoTCXFVVzs9PyrZ7G0TWc32x2ye?=
 =?us-ascii?Q?AIuXr+oRmDepygHa95471205MeQVZJIMDl+OHAE/4kMCoLvWAuPsavQzFqGJ?=
 =?us-ascii?Q?vNcLaS1grDZ6LGC2e7mS84HTVo2H/zPa3DuHMMBa9E9J4uZ6EEbI1xP3+pIk?=
 =?us-ascii?Q?W+yvke/qvWxJZ7rjWJe4mHvs?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa62bd01-a3cf-4e10-1960-08d97333d832
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 01:47:56.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCEVysz2gLB8xT3ma1wfT0k+K3eMwYSm2VHPHdHWkAyy9PqPWqKsLHlS8RnsCnAKHw+1BESLJ4xg95POAGt0v/9eSZ+FVAS+tQ0BNe548kbttmiPZ/rqQMajLfCUkc3X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6712
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 06, 2021 at 11:35:01AM +0200, David Hildenbrand wrote:
> On 06.09.21 18:16, Huang Shijie wrote:
> > This patch adds AT_NUMA_REPLICATION for execveat().
> > 
> > If this flag is set, the kernel will trigger COW(copy on write)
> > on the mmapped ELF binary. So the program will have a copied-page
> > on its NUMA node, even if the original page in page cache is
> > on other NUMA nodes.
> 
> Am I missing something important or is this just absolutely not what we
> want?

Please see the thread:
https://marc.info/?l=linux-kernel&m=163070220429222&w=2

Linus did not think it is a good choice to implement the "per-numa node page cache"

> 
> This means that for each and every invocation of the binary, we'll COW the
> complete binary -- an awful lot of wasted main memory and swap.
Only the one who cares about the performance in NUMA will use this interface.
Most of the people never use it..


Thanks
Huang Shijie
