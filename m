Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA95BE90A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 16:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiITObF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiITOa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:30:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966E311A39;
        Tue, 20 Sep 2022 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUmr2RK8Wsivkw+GqxgLhN7QgT/k9Ues2Bf3k/MBv787hWbzZFoJ2XGPgQDWFcLvFh+wT+6Wars7vqilgsthddbTI/e1VGH1hmCvfBms2PaHJz+CAcUzcTlRbrEgtl+G/c/rXJmp14RpUM+GDUSGZY/xZ3DK0yumgWI03gPXmRc+HMYsYG/xoF7cvkBjtg4dKBAdxcUENorWl2MsPJ+ln52UrGigiCqcJW5K05rqZ813vJbt0CyapH9e99XPoHQmPenEEnBAwWjxnE6dmHMKI3y3EIeR8Q3dyWsOByLKa6pa7b2H5nC97ta5HWQfxwwzRGDaR9S/A5iZcv6GVcZYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqFEpmnD/LikTFXpwGNCCS/yYkeuhjTeAkcFYsMGLbY=;
 b=CW17ZIsXvzS8AsmeElQaUgq24pF7tyLzY7TAcZ1eKZ2iuWMeS80kyJi/nEfsJyyeKwFve016qQ6HNvGd7bYEf8yq9dwAYdSCFfp59mgdTPP7GGro5NsmafnLlFD8a/iEZrr41liSvifceTrF8GB1ZgAAV7FP1Xd3d3YYTaGdkKaItsUvagAfcTxiRTDf8B/WQ7c4VFKOnLWrkZKOd0slsodrdlUv0j5renAHigjjF9urThGN99iWLe/j3+ylA5qAMWpGn+djI7IZjvQY47Q4DgB6GbkIxa3ND/NlRm382bdd8DMSfPU37+ZufTcD7PbeJGJ5gO6S24oHpQxawPhtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqFEpmnD/LikTFXpwGNCCS/yYkeuhjTeAkcFYsMGLbY=;
 b=Nj0w105sm/1joqv9k9PbKRoXzQeOx3VnehuOwbhtdF55RJD9N+b8m+KqJG2ZJ0lH5huVkP2QXKva234RVMcyOI0Pg3u+9EvFbY0pWrA88+aHOaHTwlr+LO1UWJVN7Ws59QDe4bEvhhWKSmvG2BRXM3eBG+TQ0yqaYRUkqUKnvgKC3WdM4gFelqlyvmOGNlsD51KgongjXi8XGStKMHzJQJVsLp4Pq4ZPGc+lPsoC8ZRvPAocjSyGmtx9hHXzgNMFKNLK4Lq5bLqC9ynMtJCh2izAn8HFTh2qCAImheAELnV6qmFJ5yT1dgBKDbocCG7BMLDwUhMJCdRkLpvYbWw9Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 14:30:57 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:30:57 +0000
Date:   Tue, 20 Sep 2022 11:30:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 01/18] fsdax: Wait on @page not @page->_refcount
Message-ID: <YynOnzC5ddCZkir4@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329931529.2786261.12375427940949385300.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329931529.2786261.12375427940949385300.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MN2PR19CA0047.namprd19.prod.outlook.com
 (2603:10b6:208:19b::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5c19ef-2e4f-424b-f255-08da9b14bb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1J5A9aaBpBEOTLz6fUGeKuRhPdA+LcPDXQCafR2TmMnO3mAXJi8RAIjMHg9Vd2Ip9D/rgaJfH84LOeNYus8lEc3GZo3jPd4JZhqdMLVgaR+V5j4JMDFWTJyaWBU5CrlEy789eKOK2ylYute7MRWYn6zTMiyu6KLcKFkyfNWhMviLLZDEG/Z0PAoGRvOio8Oirpj4tnp7FXBF35qX2Ae0vlyl6iErw6nh7C4Hi8TL0Ew1Vec/0IG+C53YxzdsR8U1NkIXLyMZwJ/UOvJhnBsV5OOxgTDrOnY+rzw1RjHrc5mZSpUfDBR1nbj0oR+xBrsmJWcrx9pXpp91NyMRPM88ZZhgQ40tZG0Txnf4jSFazXnMwqMhwkAXSkXXyNoALA3nhqGaja8Gn+LTDhy2EUw16ixlR2lBzLfE0W+pAc0n50Vfcslhhm8RsHoilckinpHwBa36L9jTDd8NQMfC4ztkjK5DfqC6CQVE/YEO5fHI+4OMCPupoh9u0HFvI+LwIfU9Ll1HppsZH4LW+gnaPNlwIA6bSfCDBnpyNv9hsdCpojEdL9CkPDgJKO6Tn5a0mXW9fAff8MOO/vMyAs32nCFBsfUG9ZoLninXGeduN1Q8TFWJQIvGG9GRraMAj7WXqcsPz3feq5VgP855jos37uH+9mCGQU3R8qXw+W8y+5VFBQm5WS7TKJG8aLBehx1W6iRHdUQgBTWd0PoHNgz3cd2OQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(6506007)(66476007)(86362001)(36756003)(38100700002)(478600001)(7416002)(2906002)(5660300002)(4744005)(6486002)(66556008)(4326008)(66946007)(8936002)(8676002)(54906003)(316002)(6916009)(83380400001)(41300700001)(186003)(2616005)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R430zEPhE7t7w80h4oIqDkMy6IR1pJ0+SA4oDCIxp7Lx3eXxaR4BdqZ5lwA1?=
 =?us-ascii?Q?ryEv24codxF4wfSjT2i8n5r//pEQgknssUEb7NDXH506WYl9IjULPpD8nvBr?=
 =?us-ascii?Q?0kHEr+yOTyWUcJ2pK17L3UjEJXx7Bx67yfqFkLIk34ApUdCNpEMZsAK2gCNN?=
 =?us-ascii?Q?NBVqMhqCyzCkBU3ck0fVKF8Flg4UqNIvMlNsXmEgMf6hrCHVD/rDwGn4/t+3?=
 =?us-ascii?Q?+ECQDmW0vuOPiWQqwVeQlxd3W7TJO89hp1pFCAQOh0V512FlIxSn54Row3Xq?=
 =?us-ascii?Q?h3uhqgPrm3YHq0g/hILchjFinWhkKjYidclwMSY1PuxWJBjN6sd7ykoemVxM?=
 =?us-ascii?Q?iMJuNZHpcBHkTFl135wX6qroPRifY3xs2IgPtiNMQamOaxhGbdQ6NBZuWSVp?=
 =?us-ascii?Q?HUNh2paCuDVIagbsrCG0yGsJ4kExs+ob/GOTbHKeiJMuymr146c+IDISziYO?=
 =?us-ascii?Q?TBZvUJ6SDOXHkAZy9qhinNWLWaxEbUh5ZrnS8EEtE4sKXy/pkLXrpyIc8I8r?=
 =?us-ascii?Q?rJJ+NlS/nOYqeSVeRif/gbqvSn/Cr3T+j3IlFyPTUrrpOBRXTh0ozaz+eKJJ?=
 =?us-ascii?Q?AaUiFf0KUm/W7qXm9ELJKbvH4bj8eJN+50FWEXh/vXBQlhDyW/L2x6jSmSw5?=
 =?us-ascii?Q?IAo2vo0JtBQY8lflYl+kAuKXdOpciYieKkrzTJSjx+Nem7ygsKmjxbpAwqWH?=
 =?us-ascii?Q?VMLn3XMQl37YUaWko5j7/6LRVU9vCrHdUgY53UwNZj5FYMLbDCQSmrciSVW6?=
 =?us-ascii?Q?xvJYAajtdlisOnm5wpEOZVHYagCzkJ3YtaJsVL3nvXw3gRe5rEtykBqBcQwh?=
 =?us-ascii?Q?/tbtETBfo9eFoCp3Sy2rOVFqoB78aNSGKMmZoaqtQmhZ6X+2gOFKQzeLA+y8?=
 =?us-ascii?Q?e5wyL3xYWVGAobtkH9ho98A68aufrRL5HckYIj8UIntx8JUnb5/FiyMzUPzL?=
 =?us-ascii?Q?3ngcVB/3BJL+WGiYm47Kpll+nbVjDCJM3C8jpCwsXgEZOZvbshgVVf5TLW17?=
 =?us-ascii?Q?CJEvyrV/SwUFbpdsqfT04cc//SRHRa/Inxmg+mKHXIGxG/okTnBGe5sS6EXo?=
 =?us-ascii?Q?knX0gXD2727BOjGNmkzODuKeYOGhYNEnHgPYdVgBCSxyY52mWgHwt6/jBt0G?=
 =?us-ascii?Q?RATjLa6i9JDIhGWTO3E1SPz9PmRwDzz21cPmQJOwan3haBeX4CZE2lvMGiX1?=
 =?us-ascii?Q?TEH/DuiZYzFLD8+z8S/1Z02gOtHruHQQVLaSA0qUT1b+fb4pRABu0gBZpDMS?=
 =?us-ascii?Q?csX0HJnnVFModI8KYjYIDDRUdBdzpAfYzR7GafoUiimGs/RrC6LUenRvoCIb?=
 =?us-ascii?Q?X2UusEP8PnnBEEyy5SEGEpEngd4WPxvnMeAO/7WeEXabsxi+DbczBs9fPxO0?=
 =?us-ascii?Q?LGqJ6DSUZYhpheo5t9Fi+EwXj3CA5yMZvIiRIqgqz9DIvENxqRETpVupL6Lf?=
 =?us-ascii?Q?YtUJqe6UO/fSjjRicEyzqx+gf4o0Gxy2vXn1FvHA16at9glvcWAgK6WvgH9A?=
 =?us-ascii?Q?FRvB6nxW6MhDXvNkWfX9qYKFpOo6p7rcY4FVZJPWB/OcPQMqdhpxKUjPAaxW?=
 =?us-ascii?Q?P0EbI80ioJy8kb1otfPH2IakqrnE2Cr0bcyPN1i1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5c19ef-2e4f-424b-f255-08da9b14bb28
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:30:56.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOgEnoDtQ+Z1oMg/2vinM+2cAh6vHSMFQPru1te0HMJENCjRUS5mbbJXCtdq/taQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:35:15PM -0700, Dan Williams wrote:
> The __wait_var_event facility calculates a wait queue from a hash of the
> address of the variable being passed. Use the @page argument directly as
> it is less to type and is the object that is being waited upon.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/ext4/inode.c   |    8 ++++----
>  fs/fuse/dax.c     |    6 +++---
>  fs/xfs/xfs_file.c |    6 +++---
>  mm/memremap.c     |    2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
