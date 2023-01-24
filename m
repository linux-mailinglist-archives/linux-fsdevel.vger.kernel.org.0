Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B2679A91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjAXNve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjAXNvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:51:20 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53946152;
        Tue, 24 Jan 2023 05:49:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCahvWCJtnEbKwK/4f49N1T2jC9AXhE7hdi3m8MugrcN7OPbd3n89ZS6Qg1hX+bXxbCLMm0zsrl6ATJN6TDmt7fSqtyJ7eMQLknWCAv1a7YADk+jOSRYrISQ7NwL2tBpzW2jrEDPyMW97coxT8GiHcrpSaWTwF3jKMj9WZmf5yRKbTzeBy6u44RX/QxvFZhZCzTOz6HTmX3PYt5bceosN1g1ZqeUdYWlGBziMIusEdJ8Vjqmd6C8uEED9FbQ3Y91pxBCAyhVncQt87dGbyo6VYEU2ntTUUDhM5pRr/6QILxjROqvXBM1JVCDiwr0MPZkYsakc3VaN2GBkFh1Gw+iOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRUCK+jkPfw0uw2asMJoQeL7Bj+1tylrAOZP9+rn83Q=;
 b=Y6jCA7z9NfFDlNFH6UhuRPrYCz1/oCcoI/BjgBcStGvZE8kHfFKbzT15qPh91hc8qiYfo6wkpWDuTU3VvPN1egr1JIhQAbpNuNhEGUmigplHjDmmLidYJaFADmSB2udn4gEJnzy/NKPV9MyotL8fGTa0rFbxdhGEATErsdbLz4IQH8vGFi+e1PERAvEUtHM/nEe4pbJdsDdE+/8F5B2yp7JDUpiekEQVBJwGHAc48DUmKlb6Rnpq5EparEASEz4oLRaFC40u2gm2dRrWWuSPNmV0Gvu9XEqSA9my3ux2pQMblqmO5oiU7l6T3MdpwjjaGmyGPVOTT5Aiog2ClCd+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRUCK+jkPfw0uw2asMJoQeL7Bj+1tylrAOZP9+rn83Q=;
 b=VfcOBd22hsu3hg07VSjbMWqQ+zT/7RIYRlrkKWcoWW2xsGXo++E6SkuPnxQiZPZhtgqDhfsXPZzX9eZ7dA3RBBhsnlRmTVjo/uHe+xvEa9YrU+AwQoxx3UwFaaHCXl58tPQ3BK+zgTAIZ3N05o8qHW/4YEMpYSZwR5DhIAnqqJZaaBnPx/HvDKpSyoPOHNu0ho20CJNVY9R4foKB0eIFr/OKULxNBpVaeJyXCuDn/75Y1dlnHaAynAW/zCh3Nbo5g8Ex/VklKm6lNeeuQfWCr55g6dfpNHhHZ8s9RQksasxFQGyrsqzSqRSCXXQZELnulMWHpFjasG0GZuFoLZpb9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 13:47:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 13:47:51 +0000
Date:   Tue, 24 Jan 2023 09:47:50 -0400
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
Message-ID: <Y8/hhvfDtVcsgQd6@nvidia.com>
References: <Y8/ZekMEAfi8VeFl@nvidia.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <852117.1674567983@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852117.1674567983@warthog.procyon.org.uk>
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f821d3-c2ee-4ba4-8d1d-08dafe1195dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yanf4wYPsUE4L+O4QSXxBpGCJvjTO3WkeYiZgUgLx5LWSILpodaGfZf/2y1Cx3ouKriwR9kGZNq4TqkS2APU4x/6zsy8neiFjc4aAV94yUdkbZwBrOv3MfKt6i6tZmiCRrKt0UGtVFYjMBHDUu916ddbmIQFFYJwgtpEOs8s7WYGDVnYbTSFdcsgCva+khz2lprNE+jmB30Xh+mbF6o906lQysZa/AV7iV+AqJygvr6cleSA4Veg/k2nMomDECHWDk9cbq3C4326EwqmA+NLFgPHp4HNxODeLLwITsrUtF3RQTVhPjc0HI9L76Wknqdb1vBK9Vgg7y+9kd60epBEuoS2XwYVBbhTv8EJveIcRf7IY1coc1Z1jpWuXwVna/GmEJFok35YE1bbsmDgfRVIoSltW3Nxr0Z7+dV8+kyXXUH+Gmwa/5WsKmrl7UoM03ED8PFXZ3CQ+ZT4D3fUwsU+EVoIK9zXE6o3gSTkbXXdcPZ7no6a5QVnHftEjqT8H/Hf/fEjMv1a3hg55E1/Ugy1If1Sck7aFTly3u/Mk42LJ5MQvLZH8mY4ttksqTnIMYVDP1eeDxQapGJP0FCtClLgMXyBpRR+ILq7gQMsH7VHgd5ur7rzi7xFAcFq0ybIL4MQ91oWegbGetg26I55Lvo1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(8936002)(7416002)(5660300002)(2906002)(478600001)(4744005)(6486002)(26005)(186003)(6512007)(2616005)(6506007)(66476007)(4326008)(6916009)(8676002)(66946007)(66556008)(41300700001)(86362001)(38100700002)(54906003)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y93cqHX068NjmZ+6vFQXvc8wszoXOJ7RDqTIx9lqEuj6jRtxPzUsQG7bir4u?=
 =?us-ascii?Q?2BP4XzxR4TQo3iPHDRUg+qYomzBxyGTJcitro9mW4q5t+Py0cPKcXIOgyqA7?=
 =?us-ascii?Q?LTyspWDZY6LIo9mTh03u9KL8Yd7cX8WwSOPeOgRMgyLaxEZ2TfH13sR5q7P1?=
 =?us-ascii?Q?IzGrVBnU642XfxSg93EDsoatsIyqdUr6XBZBGQtjhHnVv3uSVV3YMz5azGCs?=
 =?us-ascii?Q?JBZX3bKOF0leuHqsUmwKWyJYJ50FAkZvSSPRiO8X9boQkRn19mD0b7OdnOJi?=
 =?us-ascii?Q?ywMAENEgng2pf+xKoQnJv7nSbo6Upht3noPIufOkWMXwGpGHg6Po5/PNgAQ9?=
 =?us-ascii?Q?2ebBalBRCPlFgDiM8AvEM0FcLkJylfp8UeWNU563kmDevCMJcodGu0rg789a?=
 =?us-ascii?Q?vbgzGExxufxW34s0a6CyEw8tR7o/B9Lc1QxsjtE5XjlUPD+XSWML2v8oOOQg?=
 =?us-ascii?Q?iSPweL4GuXBOnv5gmhin2y551k24iSlhhH/JGP+XbQaXIQuS2VWeAHpyoqeb?=
 =?us-ascii?Q?geZa4EkGrGdL2c/zTH11zshTsOEUkd4thaktp14SvYOSWHwc9bVdQ/7o2uT9?=
 =?us-ascii?Q?Zjb/N+mmB0xFxC453AsUk3sNDlaOOyzp1h1VvsZSHu6T2vecSyPrX45NOoCp?=
 =?us-ascii?Q?yNj5+lHkasMNqdR9JwnvWp+2mIsrfaUurFWUSwJh8gs2u9i+72b8wqLLsYyS?=
 =?us-ascii?Q?PcBI3YMDk9+rH9p68/69lmAcYZnPuldHTmO/pnz9QcS/pR8U66IcRG2z39YK?=
 =?us-ascii?Q?T/r1huWhoVxvGopxQkle8VpseCH+RVf7jbEVwrzCuS9LrTBwq02d9LhXSDsa?=
 =?us-ascii?Q?0NZxsOVxiaSZgMr9VE9qf7sdZGjcoWvKLgi8ezAuTRngeBccRf5FPhGOtfnl?=
 =?us-ascii?Q?qwM/0a4SST9d3ucBvqHRu5/Vg998W4iHQZbcu7V3tKpqgMyXyGFAEM/B4DfI?=
 =?us-ascii?Q?DD+YLQiv4QedWh7qlmG6qeVTTaFCtlS1fNMaFg0g/ASlPalMLN257EuTU0QX?=
 =?us-ascii?Q?6IyLx8UlG7uhwLDIG3KbSEHt0iuA0Sje1hosgSFjuN2jU1k8PcKa2UT5k4fk?=
 =?us-ascii?Q?qjbIzmqxw2RoIFGci74n2Ajlsivap7WwfVzdJjJz1Y8TMivebW8FlL56eJ+/?=
 =?us-ascii?Q?+O8R60RV3OnkWiDBnt+OCcVO8WNKvMljKD25n+i+g+8mxaDEE5LthvH3WKn3?=
 =?us-ascii?Q?PapydQLLb7rL0ZziRlDO0xT1THdgo6RzVhfwVbvkKQy6hCOyvMBXfpL9VLKS?=
 =?us-ascii?Q?Kov2n3XWxlaalqMm8nlGOjag6/mTsIeEnOnYOqyZz8FiVsN+JyIVH5R5dEhF?=
 =?us-ascii?Q?wWvOTbZcjB+E8tBRWsBc3ZRk/Yj7ZNSedmgZYrd59VSqDV3zYMXjbVH7RL+g?=
 =?us-ascii?Q?4IqIqmIUKLRly53/D26Py5C1zD+cK7ZXYNXvLj5fi/G96MJbNIk2woplhk/e?=
 =?us-ascii?Q?A/bL0247HLPS+DuU4/jlXyCwTsgzdcXl9aUJyoQs2m8cSvdnrGWQqh4KfWsl?=
 =?us-ascii?Q?NZn4edx5rzBWBBZpouGlyngLrZoS6OOvAd5nJOMfRNT0+HCa6SxrWJH3ZkvC?=
 =?us-ascii?Q?d6W+RiBSl4E+zKQ5ReGjnxPFiE3cw7A/cO3Zpj5O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f821d3-c2ee-4ba4-8d1d-08dafe1195dc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 13:47:51.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcu892uNs6+MHOlwbvsQBRod+EvJMXtP34vhC5xdBqB0Qs46pvNS4bcT1VEYs7jD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:46:23PM +0000, David Howells wrote:
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > Yeah, I already wrote a similar patch, using the 1<< notation, 
> > splitting the internal/external, and rebasing on the move to
> > mm_types.. I can certainly drop that patch if we'd rather do this.
> 
> Note that I've already given Andrew a patch to move FOLL_* to mm_types.h.
> 
> I'm happy to go with your patch on top of that if you can just renumber
> FOLL_PIN to 0 and FOLL_GET to 1.

I moved FOLL_PIN to internal.h because it is not supposed to be used
outside mm/*

I would prefer to keep it that way.

Jason
