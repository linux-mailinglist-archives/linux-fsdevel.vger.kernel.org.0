Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2155B5E5749
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 02:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIVAZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 20:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIVAZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:25:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391F99CCD7;
        Wed, 21 Sep 2022 17:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imrJ9JMbf3n0JgPzKS0NWLVoiMicuTrXM0IXKymgp7D2rfpAVcuu/jtcC6zZX74iQZnEYQaL5/SQfV9+INZwWhMRdgja4IgqidasgfFl1duAOMgzIRQZZ4BbBXzaxEj0U2GA1TEgvSlPHpm9GNDTzQf6NNL3d2TomNQqrBdG5oRP4p1LBxQ380HvtiTQN+pKPaoVV2XIG14/SRqbnLr2IgExarog3vLqVpCDiX6cvNibji8wXZOuN4HQiq84LT87rylLO8ReJDgMfk4g34AYX5Q76kmnm5/CH1jVUxplhvyY42x1U5QkCf2FmfwF6l5b1EVKxkkxjoKY7INyl8XWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+YOLF9d2NU0IGbytQfYgABRQ6cNe2oZqRv3wong2sM=;
 b=jZSm7aFHbbAr51QyF8pTzZmbOoyOgz/wVkvxEkeAF4BQFWnx5lrIP9gQPGHY+TFGBn+M5nKIoZ3sK8Lcd7soeDERtU8a5j0+dWs31iIRkbdvGiV31u80exqNKb5nfLGpU5+qs4NoL4tFx3hLa9n5yMuiJqofblceIVoVrflXzf4ikscPwqKCYvjppGD8hyU9TtwFeCYCxfNF3wD8t6ItteKZKo27KXC0nOv5Ab0uUSNmbyt/wFONBd/f9cF6MNTQSoUCZbkL+WYikxGuxoIWrLXMg1I0tk6+EkkoFMOgu3oIEfHp2oC2MqJgwLkr/XqBxZCIdyL8SemeKlXg1ZmsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+YOLF9d2NU0IGbytQfYgABRQ6cNe2oZqRv3wong2sM=;
 b=YWH17lRqrxlqf+5qFwT+o4PrUTdFPVLgPcrcA2ftOZrAcS9WlZOdczGSZhCcUTFIoq23sXFRqhiTa2GTi9o4QOuJx+d/Q2rVf4oxZdR3KWJ/Ui4YE3HIGIb5ZOX7Liv4fJhxSIai8XXraYg/qBy1ohUwSr/w+d+RM9hsj0QeHfDeNWzibshpHidu/kUnbGz9ZVNADs6RWo60Oy9A3Wy7IIZkOavdyP8cxHgW+V4H2SLPhoe2EpzTOdVvMQbwMgnXbCrNLa5lrBobm+n+avjOuJ3x0MR4buJb/7UPlXrYcNyUGUxe34sSmZrDIwfvzvs9ujcRO2lqDpNID86ZgoFZBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:25:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 00:25:26 +0000
Date:   Wed, 21 Sep 2022 21:25:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <YyurdXnW7SyEndHV@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
 <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 718fa14e-969f-4637-1907-08da9c30f247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqdGvAI8B4YuIKhvDXUYYLmOJn7+91giCIrmWTCOYSY8fo0KbEXX3KqkuY6/svSNcKinU9HnOoQXvtqueDqBEL7pgoRwZsMnzAADkrvyY37ClZulGi8snG8kz2sV9qp/RaNEsz4d8A9NAVkjGaJ9cmvTUbtcVkQ9IMb9ySPbZlQVrt5CtqnelX1dxSghQ7oy5QMu5v8xbnE7dNH+BNPKlSLZ50WrNPfljjX5CWhyJm74D/sSP9mpuCwmTTtdIQHoCyvWKLfbfXQ2+u4egATcP8WXYj8wZYpTo/c06NlorWERCJsDxIsVfJM1T+7CI5VyDvHe4uf1dKt+N9z+GDrhzgKTDNQvCEHPEaZ4bWGq3xtqWOJz85g4PhLbq5LLZDDFl27ztruVPe1gfLW+hGUxDLrD3yPfFl5vDCm9F4aRl8VpDCV9QV0W7sfzNx3LOX0ZRUAoy7GMFtfoowYb2vb9+xS6EIguo/68KdAf2vJYm4BHC6+gX2YHzl8tnW57Ih34tYqQ8o1md1uE/FbhftnoBnQsYcJ77Qfthgpdm9TI8RMrBkMrA/NaHwum78xbRa+PJOCftYqPhZ9GeJTszdO4CcJvpY0U1rBpXlrB+7+BXjS5kMH0ee2U1bWpmgPvCdAra6+4EV78sCLNca/iaDp/k0o1q2a7jT2jQhQetaQ1haYklCQ6n+Lrmv5Dsu6MtLr3vdjtLKGEcTobffdprtDytg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(478600001)(6486002)(54906003)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(6512007)(26005)(6916009)(5660300002)(6506007)(41300700001)(36756003)(7416002)(38100700002)(2616005)(2906002)(186003)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ISHAsAGIzJAN3SF6xX11s2obAZIvEzDnFewalLCD4wXJuw0NpJXpcr/JaSqg?=
 =?us-ascii?Q?uC0xrl08eOWR61nmDjEFOuv1dNBxExMfpZUzNhDaYTOgggAUWfAaluOOEbzu?=
 =?us-ascii?Q?eyUj77AB0kNunnjZ0T89PBx770c546QzW9i0Uv8LBnJjCefJjvcPEAxLMXVj?=
 =?us-ascii?Q?lHsxBqaD58iDes5QUrnifSBdPfQoyBs5lHD47WHJ+0nMPbYZFmolzrlPXjIX?=
 =?us-ascii?Q?MqeiwmDhG+Y1WQekLTlM76Ln7IOW/+8eBcSW6QroYPaIxwIPMyHJtG/TSD6X?=
 =?us-ascii?Q?etUcG3rU16ZGPC9P6LUiICz73Q1/s7/Jpn61UzmwPKe2RbngnUaS8rUGqOM/?=
 =?us-ascii?Q?Gwi1LIlgA1WZSIZSGiLi6nnMjN6BUw2huhLLbHVbYQL5RaKFxZucM0ytYDdf?=
 =?us-ascii?Q?+rVl3p7k2gzhs6Z4h9UtJsZOfcb2xSSxYzEBgIf3cTBvUvyeyFWbFrTrOGtG?=
 =?us-ascii?Q?ojCQKEaX24UQOjIqOq6z1fs0lNUx4oKxTEBlmfomwoXQ/usNW1PmmzvDhFte?=
 =?us-ascii?Q?8rjOfYBQiml2qwoIvuWyMeb8g/2GXn9cSLhIUDiU4hUQFk7vGOwdo0FdtNxy?=
 =?us-ascii?Q?PDgJTVlYSWYTvAonHKNy5dVYOPf3YZGz3OQvQPcUPKW7ifhl/PgYteMjDdyh?=
 =?us-ascii?Q?zHx7YTwIVy4RuN710VC4Ar8wlyQZEvVln0GNeowycBrBIChK0nwWmz5JnI+o?=
 =?us-ascii?Q?5RjoiC6jGWN/oQ5tAx4/MuibqPkaYj+BnB7hji2oAHtm1O7u91etUxmRL/UR?=
 =?us-ascii?Q?5vkVBrlmwXFFcKmunvjX8ICXwV5SNkmpC21zAD/zwx/uhF1ge91haxm/uw/i?=
 =?us-ascii?Q?J8tqb1hBaSXVydeXhFoyXJHDiGLFfctL7KXuvvI5EFY/qQX4bT+UivXKhkBg?=
 =?us-ascii?Q?rdGPhuYrwWENamGzkimjRjtL/317HicjSdnMb9Py8FQt3po+h3DX2EBdCMCp?=
 =?us-ascii?Q?oz7fVanpnIPnk80qV0PAJtimNH7NaMGjQue3jAj32tNv2sSs7CaIkBByCAie?=
 =?us-ascii?Q?ONVkp6yUCOWyOD6SeQfHV+Qrs7wbTpjAP5edU3WVv7G13JW8Spf4niHiFbpU?=
 =?us-ascii?Q?czktB0Wyy+2fAEgGJu27i/LqW+9ec9d9cEH5qB4nT7NI2FPo+W5B38lPAZXE?=
 =?us-ascii?Q?fpEVxGmIZmPisPRwttxcvKdmW9MQfg9gXdM2rZECV6NrQWUSF7ZJmb3aRIP6?=
 =?us-ascii?Q?q0ci3AyvRTWOIVQlCNS0XYiLL1UUtAwadxC6aaUeTcQHZ4mFOoQaniSz7LA9?=
 =?us-ascii?Q?LMP+5TDvtIQypk14k4Rq7DxTsoeNgN49RROZG82KAZIeEYQTeGC/rOp5elS/?=
 =?us-ascii?Q?E+Nz2PSjAvfkNEbEq7djUF++iPG6n2yXQewjjtBhPG7zKt+W4SSAkkJuv4y1?=
 =?us-ascii?Q?rPTD+i1lMnvj/WojYfDkVZSgbs8NguI0KFEF/8AW0v+02S3jhSk4BG494qz4?=
 =?us-ascii?Q?Z448P+j1RuPv/SPH2sygeqBfzfwJYGmMTB1rAm+5rvVD0LRujJG9JeE7PRfs?=
 =?us-ascii?Q?qAfVtOvoahV+4/fEYzXFjrIkYMqkje2VObnMeXpb4xONjmKHuLhBJaARcTh6?=
 =?us-ascii?Q?gWKiS62CnhlbnViC1CuL/hIfKHU0PguCkEV7CmXa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718fa14e-969f-4637-1907-08da9c30f247
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:25:26.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dybTyZIkA1CcSi+t+cqsHCM+G/EeruGWtOa/A/NG2SVHHSha0xgq5HBLW7pZHzWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:14:34PM -0700, Dan Williams wrote:

> > Indeed, you could reasonably put such a liveness test at the moment
> > every driver takes a 0 refcount struct page and turns it into a 1
> > refcount struct page.
> 
> I could do it with a flag, but the reason to have pgmap->ref managed at
> the page->_refcount 0 -> 1 and 1 -> 0 transitions is so at the end of
> time memunmap_pages() can look at the one counter rather than scanning
> and rescanning all the pages to see when they go to final idle.

That makes some sense too, but the logical way to do that is to put some
counter along the page_free() path, and establish a 'make a page not
free' path that does the other side.

ie it should not be in DAX code, it should be all in common pgmap
code. The pgmap should never be freed while any page->refcount != 0
and that should be an intrinsic property of pgmap, not relying on
external parties.

Though I suspect if we were to look at performance it is probably
better to scan the memory on the unlikely case of pgmap removal than
to put more code in hot paths to keep track of refcounts.. It doesn't
need rescanning, just one sweep where it waits on every non-zero page
to become zero.

Jason
