Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7750B6D96C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjDFMHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 08:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDFMHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:07:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3DBD3;
        Thu,  6 Apr 2023 05:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbFf7W1F8+wdqBNkCOiMrIisJr/OL1XD5aJ0OhfPhuW20thp8TkZQ/1B7HVi/xIsZT6ZT0Jy874rPqIffAJmj2lRFzBrHjQh5+EM7jrdSsRtcyvPtx3/oJUkMbOC8ixQh3uOHnapHhnXp5zkeODRmVuXEHjpw54vK6I0k67rMHnTXXSzzzrUuyqJLgJ0Q8KbaLFnEty2/dnXuPH1kvGoi0+D6UIRQMFM2HlXFrUJ1rxSsFiZR6shrmaV/VmcItYBDV3XdiBExM0qZ3NNCz0HsHrQYVizlHFy/8AYKwlaOuNCtaBKqhiXuEzwXfs1OYnrhmoYK4ZSySyyjr1xnInYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+Ck+2lE0MtdhErnUlr5PFQx4kEw0dEhHa/v9MlT438=;
 b=bR8Z5sC7HCIXMX9imjTDgYyjJ6OfSl7aBTr7ks7srlxborUT3L7jYoHFl7NwU4QszCyvH2hXLBUFXUBpyvPUVzrCq/alTlGbn9n4dSx5apW7VZ1SFO4NT9PTIzMN9ppu7d+KWugWoipgBTDFEYl1FxbwLNl+w2MaFbkScmGXX8mSFAM7bUl74SmkFuD+l7+/b8j2TrSS90SlO9hrCi56O8pH9aoSPdKwcCINgMOygh+6ooYoq1RS2Tlw0Tf3ZDET3Qsf+5g25neVVpNBhXX2NH+Cg752rqcJfARzf72zIQ3JRgtrP+464deXXzlk3CT5CM4dTfSnmj6qgs8F1xJhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+Ck+2lE0MtdhErnUlr5PFQx4kEw0dEhHa/v9MlT438=;
 b=W7fUHsN/MmVNbiVctoKE+zNjHoWcfoTdueUlYGOcJULd8rjFsNh3mSCC5gzG6XW1vgC1MQpQQ3j3W4oL8HJw5MQWhYNlfQIkVHMBndmi6ndSvZ5Hf3C5YNWoO0CVeUzn+0Pg+qAqLP9Pso9oel/rZhuHQ4hfHWbverYLPJH3XtxDLKSQxizhdORsSQl1Gd0bMqytI1vFkycEg4bOPvtG74YfqE4W9azKYVNsUxrZvKMdoVuPaVVc5rErRg7z7HBhwCWiOX8VLGRJdaxpMpSK3kDbwfAkpAVTnVdJmWbsPPufFRBj/1Y1GxlT9GPfCrlzbrfcc34Nus7xrJ42qNyRrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5461.apcprd06.prod.outlook.com (2603:1096:820:c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 12:07:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 12:07:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     chao@kernel.org, damien.lemoal@opensource.wdc.com,
        frank.li@vivo.com, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        jth@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        naohiro.aota@wdc.com, rafael@kernel.org, xiang@kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Date:   Thu,  6 Apr 2023 20:07:16 +0800
Message-Id: <20230406120716.80980-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <2023040635-duty-overblown-7b4d@gregkh>
References: <2023040635-duty-overblown-7b4d@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: c9327f43-e919-4449-4969-08db36977cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vejkLj8hzS3eOGUD5ZqzzlIkEOwyJ/h5GX6FX7ohXh2ASS7D0k70nOIPzEJWWXoQ8YgHjXgeujEBL6kMMNEPvrM7jdflJj1QxZgSLeZZZpJ1YWPTjAv1PpGcT7LJH5HTRrUFTv35vp13Cuzr1tJRgwFz8OcpGC8KIvrXcFkSEqLq9ViBygPqWD9UicemdoO7z9NDrKhRaHl2e+bhVKtXtRPF1n/cJfq92lDcuzH9r+FeXj+B0KcQQlKssvzwxJnx0mQHl8f+LZlhfr682OAr7IkDNv+noAoMsGe9OjHO/+Xf2dFBYUZdLa1cXfs5pCJV051GGKH78XFFzEhtZ9IULlAo45EJ4ZvJwkpCgZ0oxDBorUvUwxmHqeBkFn1ifd3NoWYN9d+Wm0dU9d7gX+6+MqDDemdIpP8pTcfhPoZm0F9hXCYera99/8p9IJCgZa0bhdGVJZehuKygwOSDogyhQclvCAGcE7szQFbRHtI9Oqp/6PPEhQnNHf7ABN3zwoOKWQzUNK7o33LGFZ7Y1QVov8bRkbgbIL4yb1ThXJKrTzg4sJWkJayMPIhsezzOxJxCDfzkCaHZ0Z1lAPnVIpZ7V9emjyeYI+LLgy5YNTQ4Hn6oijhOkUcuwHSpG8gJm+cu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6666004)(6486002)(478600001)(38100700002)(38350700002)(36756003)(86362001)(2616005)(52116002)(7416002)(2906002)(4744005)(316002)(26005)(6512007)(6506007)(1076003)(186003)(8936002)(8676002)(5660300002)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I5fmB+06wjRU5CDcW8wHymm8YwX+fhTdIcaUfflNi+olUk14sqfJuQoRCDwC?=
 =?us-ascii?Q?w0ndce3QylzEDR9I7jT1MuK+GZ93SGU0PoB2rpIQW9RZKjqAcST73dCPfHtP?=
 =?us-ascii?Q?749+Rmg9f+Ms1REu2VRXScKBehbB5caxZ431JSib5naRdJLhq+bW9aM+U7Br?=
 =?us-ascii?Q?xAbKfgugdG+BwCU0b5nRGwrs2GhOpwThrAu8rSKQZFeqn1BA/KkV6c79utHj?=
 =?us-ascii?Q?zbrR2GrZQt4uqsRgi1LKwFtdxJiblbUq+c3oqmPjQ/9+PRFfrfAx33ZJdm38?=
 =?us-ascii?Q?9XT6w04ERKjQGygvBmSiw2oxFWl1YJW5EQuLA1kDGnSrE2X3by+7+Vg6YjBW?=
 =?us-ascii?Q?HmbTOBur7uujZ6VeKUDJPSYk82leDn4LV40OvnqkGU+vFUuh4B/RfEcEzijA?=
 =?us-ascii?Q?6wPiA5ABlMm4nIKeKt3qL7pMoQ0UB+Ea7l+b2VCpC8mVk3uVPhsTITCrUC/z?=
 =?us-ascii?Q?kVOglGpxc09yZ81Fq9BBFSIjExIYh0HcqoTeylEStl3o+8bJ2ayHx4Z9SdGw?=
 =?us-ascii?Q?BHLw4RVx2VcwlsKGTwxCTKcu1m2mZM90g62VP6yS/lWwETCJ04a6/jIFWyXl?=
 =?us-ascii?Q?9fYHf2DIvkNjgeXp9hbvzdqFtAED6cTgOO/hnLuDxhOfiZr7ib8sg1veQ1lQ?=
 =?us-ascii?Q?cxDbOH+4cFJfNlwUE0CWubZeEvcl42v4iiHSU/nHrhbvfeLdh4Vn/t+os9Od?=
 =?us-ascii?Q?cus711/QBVzwSbja+M6L9ulfI/VTbrdtuf213T5yrIjAb0KPxV+tAk/+CnIP?=
 =?us-ascii?Q?cjRQwpJIHdwH5VkyJFj9B+sQZqN2JaJXLjxKwMTUt/uRoqV8Dmw9dZ2j5ZrT?=
 =?us-ascii?Q?MsqlJW37RFEIbqR/qnxcMCqKgyxq2IsAFajXTDOEqzZSJPsiIEvrDi4L0ZKd?=
 =?us-ascii?Q?wn2bViVNU1rqJWwc4ON+h9VKNp4KqewfBxF0WdW0L6D4POqCpguFzxuVFV/h?=
 =?us-ascii?Q?C3H9v+X/2sRlhqQDWv+1NBktv5YuinRvD8oE1gf+LeTCerPesF850GNITbF+?=
 =?us-ascii?Q?mU8u+cqc/VP8jEGN6AN/yClKRek6cbOwjZ1O4OA0KcoK96o0qkk7YJJAG4Pa?=
 =?us-ascii?Q?8udeMQlX9VAQjtUdCajGq+KOr2HbGKUjyt2OawLmxNZ83Nsu+yMrqECYVBQY?=
 =?us-ascii?Q?WPU3aq2pEHLQEXH1QukdFAMpL1vpBX5bJ9OsDIL9Ys47C7xz3aKKvaExbjiu?=
 =?us-ascii?Q?y1i11A17F2+qd9DtoiaN5RMOF+9KZtr2sNbRDfQ0eVOerzcF4AolmeYmAZiL?=
 =?us-ascii?Q?yjV1BxMLauyu7oq1x4Pyip0Rl08+m1WHk6QtnRlsLDK/guUjcxv7IK4qqnms?=
 =?us-ascii?Q?ZrmCNYK9FPmMPxEbx9nRpn2ZkDMIPsidp1rMR8oGo9meFpGA7nJjkUcA2Ckf?=
 =?us-ascii?Q?eOxmNTjrsT/LnjNaV2d1lEf0YlnuGQKssJyN/ocFdXJ35oJhfC3v8OwmbfdQ?=
 =?us-ascii?Q?a3nZTscC9xOHdTKTkfFZzMbjr6PVsm8tEF3PAapRvfdZ8DB/gQv/IpcTnI3r?=
 =?us-ascii?Q?N9GYrYiKksLOACoPQaL5cmKiWILSr2NMJbFmVOqaHjCUXBzjKRmKGO07NDyc?=
 =?us-ascii?Q?JDidaJbPtCQLv0jd9VXttJna3TfvIIa/FBaseBP6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9327f43-e919-4449-4969-08db36977cc3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 12:07:26.6655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4eGhBazu+NgFBmWG1cBIvQYIG8wdXJFszf2xXb/lIKQBst7Aj/uqqq6U+efaucV07L4mABU+BfcbuJz60fcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5461
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Meta-comment, we need to come up with a "filesystem kobject type" to get
> rid of lots of the boilerplate filesystem kobject logic as it's
> duplicated in every filesystem in tiny different ways and lots of times
> (like here), it's wrong.

Can we add the following structure?

struct filesystem_kobject {
        struct kobject kobject;
        struct completion unregister;
};

w/ it, we can simplify something:

1. merge init_completion and kobject_init_and_add

2. merge kobject_put and wait_for_completion

3. we can have a common release func for kobj_type release

MBR,
Yangtao
