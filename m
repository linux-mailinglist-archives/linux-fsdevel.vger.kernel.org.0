Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855B3679B49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjAXOOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjAXOOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:14:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D446168;
        Tue, 24 Jan 2023 06:14:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivslr4GFgE2R40zYmgDSwNNMzAeu0TRwsZrDwCISh+D5hPjwjVU5kR30ps2gO8kyWVkRTbLU24iuVHwKhxhSw5h/NfrsAoe+kO56HPfwSr3xFjHY6I1dtdvKhw3rc3vmLX/wmxvwpkQlAPjFJTocMWZd9wHi1g2fbq1hG8JG3qXY8NJ8y2yMccuuxvrtTV8kb2X3iMl6Zsstiw86q7cAqzTVSyCDGeKxZUCS5jOB0FdJrx5cKB7W0558lEL4UygjGlauKL6dft9ii0WJwYWBxPAenKiAxqWWEM612wMwyxgtQBK5/I98JXivBaPi2FnOjE5LwS5t9k9OG6siEp1jwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+njodJ2VBLpNry+buY2EMdM2XjOi6T363pBkOLsiME=;
 b=SLKvUdr95dTmFHo/aJsWdAHJQ7D07UqV4ElWJbKFZ2ASuhIuRi0KEzXZ9tSD6okH86oEQbqidIo3vZVYoWUkL6N0tloOHCXUcbX+SluGNGdr8z3wds6vuzpCzDUG2wYJq077YW73Ta++uCxSPvdfDFb0SCHxO+KSc8wKoJgAGYqPajRMVUx1wuDekPcZObvZPp1P9cF4sWafKHC1R7QsfnKb9gxjl/I/v0ieR0PPvHAYQVAp9UMdDo9FpCrE5kHNmn4nN+skEtFyRmbec1V1I+dxmUB5NJ65qmFWUG8U6ILjlRhgres2NNDd8dU+0jKI2n0ukUpFVklzjY7ckUXAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+njodJ2VBLpNry+buY2EMdM2XjOi6T363pBkOLsiME=;
 b=PhkZwYVw36wFLyikR18rp3D4rm5nhxuaG3jOzlO4VWFHGQwuW3716CJ2G06QkAjvyDzrbqjtH1wqTYo2OcYqBYiaf+zf+j53T/OEWVzMWXIk1HIfOURGwhCmp/jFRGoygdPVSWSmdm8vvkkzRarvk8wwC8Db3BwPahS5mxYg4AdAQ/jCyTK2JM8HpxCj5FwQyOTvT8nWP3kIFpS3LNPRDr9x8t5/ha3oWisMXWDhLrMG+UDFlY6JJQZYmKwsyw8UTKkSm9swGBPb+PAs0EnGOS6zacdXlZx2TZ0IeV2lDguYPYIzr3Kkco0vdG7ePjqf+fZxhpExIfC76OEtI6b9dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:14:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:14:45 +0000
Date:   Tue, 24 Jan 2023 10:14:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y8/n1AdBwbYqp8lX@nvidia.com>
References: <Y8/kfPEp1GkZKklc@nvidia.com>
 <Y8/hhvfDtVcsgQd6@nvidia.com>
 <Y8/ZekMEAfi8VeFl@nvidia.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <852117.1674567983@warthog.procyon.org.uk>
 <852914.1674568628@warthog.procyon.org.uk>
 <859142.1674569510@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <859142.1674569510@warthog.procyon.org.uk>
X-ClientProxiedBy: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: a91cc852-0d76-45da-e572-08dafe155823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYwtAUUje5MAk9YKTgGT2cCXxkLunpFpjLS7hPPXLLxXj02BGKzr4AeQVqhLWpwpqzRdTsTIiAcsEky7MJ6nlCbGOtfSyEGIayMIpgKUzmlkbdh5zNkBswHYoLDeOFu3laVCXWZ+TbPxJXUKDSnriLGRRmsbRA3Uga/LR7Xvpd+iT96oPwSOV6fSV27GNKwSSw9tE0pFs92yyf0rw9zBO/JENL/YuuPmVi+yiT31dD7aMnL60L7dGab9FHZHX+qoT2TlaNGGRsx4KxIJa+qyTQaMKvlKwRppzhjrlu972P9IQR/CDVQZmVmGgT/xzzrs4kmiJC1qMRSMCtXheUsgjzvMEFl48FzZEWUrTOhSw0qfQ253lKYJgfIpb3CShP5XR5RtSfU4511RbUC2amDo9V3eQXgZcHw1XVcFt4/Gsk6L/rHfFkL6x8Cr9IBO17RwWrqVEo83857rhF/pnkp72y2H+BrTmhdCwMZsuMPxBfG24lD5+30QbKVabX6lcuXM9k2BMM7+450e0R9zyHDRAgvDgKClGPTgbg5BUtuX9/Oj4Ob2wycjncF17Tm0HNiH0zK6LAE+H44BzF7PyJhD5UpcnPO9VqPWgebxAZz4oAk1u0iJENfFU2qaMyx/wT3i1TYFCB2b4h3oIwu9P4J8Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(38100700002)(7416002)(41300700001)(86362001)(4744005)(2906002)(8936002)(5660300002)(4326008)(316002)(6512007)(26005)(6916009)(6506007)(186003)(8676002)(66476007)(66556008)(54906003)(2616005)(478600001)(6486002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0Ahp4q6eOWS7tyT2vfOMsPE8mQfFWBSvnwew24eglQcKe+5zXJ6jMKWStAT?=
 =?us-ascii?Q?XBYNhkmYmHffwP4EZgYYF9a14G2Jlby8/DahOFKgSezy9IiO2x9dY2VAiwVq?=
 =?us-ascii?Q?9JxSdju/AleZHch5XkkYx7uglmXSuAUATXH5NECs/SrH5Y0kVYXULG6HrcMy?=
 =?us-ascii?Q?/xZn/BlKa4PxLU3TujwUgsvIUozSlitFRVjAu8VOe0IJ1yOd5WGQc375pMww?=
 =?us-ascii?Q?YG8YSZRuL8dgnULyp9+nLejN1TtbSqql16FayTh3dE/+kGaSki086/7q56Jr?=
 =?us-ascii?Q?FjW1GPcS8WBfyGJdEmAVC1M2XViywyh2m3GYLhC/Fak5nrjeN9MSq9AR2hde?=
 =?us-ascii?Q?2OWzaEEs0MMiGAjGxO2Kb89w6m72QJtBPS91SEx5aMueSa79GYzucZ5Q1srM?=
 =?us-ascii?Q?EgGK+C/gFaDbQ0JcwE5UNexI4XprIbJsovRZtgM7ns6m9tGsnzpxlaCr5cF9?=
 =?us-ascii?Q?3a5eFMUv21O7OXbXG2RkvrSwH2ws3ilACNLwik23lIpf2XKSYbZ8p71a0jAk?=
 =?us-ascii?Q?faSdgrdvJnKuCIgAF0nesi5+VX+Q8T4SfnaVaAupn2kkrsuCYaen862xTRfb?=
 =?us-ascii?Q?56gfHSqoakEX8g0rkdJABC1y9sYSBQJOLlAquyIMTHNP9lr/Y+EcR8gcfrUF?=
 =?us-ascii?Q?Vz+Q27uTA6+9D0I/OFpZfas22fWLATfvMGoHTe2XyM2QC2VTn3ekHorzRkQS?=
 =?us-ascii?Q?cRRtqrze8OpdiRu3eOA2ojrkvN2RXAx8N62JiHQto3d3UuqLEExKW1F92lgY?=
 =?us-ascii?Q?mAQ453LWerEviCtBAWEj/WC1v4hc7388uB02K4M6IQT5OFDs9MCLkIfuGpkA?=
 =?us-ascii?Q?FJDUTm8/sw3lQBHS1ERjbI/yJzD6jm3vHBrkY0XPLqpSQqQKE4yxxWiSxsfq?=
 =?us-ascii?Q?nSPvAm9CFv66tW87JkMRqamwjnTnrg6dMK8tznYOQqiN0JYGWCF1kl6p2B5x?=
 =?us-ascii?Q?wo8Fc6YB9wTRGAWOPLyUNNmqZ6J2wEkpqGAvxdGr1vIBJvB+qMIfOO3EVSRv?=
 =?us-ascii?Q?nX4FbBCdYdQ18Nh0OI6+3Nn0bqMtoAmzsyswmUGOJvpwG0soElMdQg/Hwi/y?=
 =?us-ascii?Q?EliGJPXxCLrH6/rahBW8k68qBueQNNeiJUjLJqUSGrogJjSJHzYyyyrBydZs?=
 =?us-ascii?Q?O7+oAfNJjpl7/n29oLXYDA8g4LkCAJs4tzAomwu3s+oAB5b2qkl62fEJqsJ5?=
 =?us-ascii?Q?GkleHZfyJ9qd2OqoHzYndgwXWJzvcbzJwLjNUn/4h9dPR0YrAnPaLQ8pTg4B?=
 =?us-ascii?Q?DiF0IMn5U7wM8SFswncCmZ2POafbZYfd5TREyoIbyUX0dD0dTXhQx3RLjE3E?=
 =?us-ascii?Q?+W98wrOklLBBLxT9jiE4npHq32UNKj6T2254m10aL82If6yzLYPdghv1E9Np?=
 =?us-ascii?Q?4vJml8Ce0vFtJwTdWl/QV8DYDgSCZqYIkLDJ9gumrbTJlWqxqbNLrnfPBInL?=
 =?us-ascii?Q?yZovgnZNLBWDhsPnJ1HHKJmaI1GN7q49XJJJE8WkXVGi85TmRn92hVE2RxJf?=
 =?us-ascii?Q?Xf7/RePhVlD7kWT/xNEWyf8tOiryWEEai3Y8fHdutx+UnKsX87LtVADQLbTm?=
 =?us-ascii?Q?/+hZxxnqSGUihKBWVEDEmNPEGXPalyUmCNmY/MgC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91cc852-0d76-45da-e572-08dafe155823
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:14:45.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULytzAauRcnYl1Z0ARN44pAjTTiXMceFCYX0rOJVmDXFb8BNvva/ABmdprI/SVEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:11:50PM +0000, David Howells wrote:
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > if (cleanup_flags & PAGE_CLEANUP_UNPIN)
> >    gup_put_folio(folio, 1, true);
> > else if (cleanup_flags & PAGE_CLEANUP_PUT)
> >    gup_put_folio(folio, 1, false);
> 
> gup_put_folio() doesn't take a bool - it takes FOLL_PIN and FOLL_GET:

My point was to change that to take a 'bool unpin' because FOLL_PIN is
not to be used outside gup.c

Jason
