Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C95AF3EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIFStn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 14:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIFStl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:49:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3EE26F9
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 11:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0VewkjYb6oV0Zqfx9XQmZzX6gHTiVE3CowsjK8hQwRQnWMh4obuj2H6AmiBrJ2b1UPrHaL8tOWRylc71rG2WCAVRSfdsO5UdnuJ3kwg+vxI2/b59huIecK8SZZLrHfaA5G+cKo4a6pl0kFLTi9ffj8RQfIyH54jqcmAK4vzO2lZaBqA7xMYCPsFC+FTvFDpz7v2vR1xMRv0BkLnNzjoErscn+x5QdI3HKON4ZdZpcpncbTvX2E+bhZUtUwW/f6WL5i9pAaLZ9wb8yC26iXam0uoBjts4DifmohqL4eRKoh9qXQ4/Tm47VVmUPZuWWZRT8T/LnLhPiM8CbGGxTHaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmRWnWMbP43fPvsxjN0xlzqt8Jp/h1x/RrEwVZ83uak=;
 b=ON2YbgCjev8TDmThe6gTLlVhI3XDAlR3C1vK1xsq/ob3Wk05SvdBWHLt0dsj+yvYNxRySFbmDV2t34Ms5vihYEVnE/+dJ+xVJnDOEN7i2IEQ/gINqJeqGXGDX7IemhP3SZdoPPJE2dyY9ug6dFknqcR7mg9TE9Qn7A+mwrhUrBO0gUsIMl2wekn1ITNaf6scJ5mKuT3K/wgs/AZTIv1CplvSI03IaIA34LXV3gkUI+fyqOA+5ASvZrGiXGypDwW9rY4vWHoobb3DyzLvCOEw0JVNo9lp2uLROSRREbOQhnG3XgPxRUoDuqauwdijA+JZxudo19wFBOExl1eI59N6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmRWnWMbP43fPvsxjN0xlzqt8Jp/h1x/RrEwVZ83uak=;
 b=MjR93xUU+rSbAo6yzHm2IxK6VPHHF/aICr+zNQllcHZoIHm4m+0UhTrOR6KWPaNV0oM8xLhjDtTwhAmcLJIlD41Mquilu28uTCqGK0bW6gXVZCrvzPOswW+Pax5PJHdkoJoHYQYWuqBej7nexRxHpKyGzJk18D/O/1kkr94lnf/VOYm6TvBKLRdImXLlO6qTl8pYQ3NGjohDAdgcxorox2JQgCHo91is9xbBWtRfzJu2IsTunlVwM1sTOFI90CIwyejvBF3vJ8hCEQNzh2dveRH4GVoB8vbqgM6I3rCiyZDhxCa4zQHqATz02J9MuZGBw5qImkx8SqgckPfIErIEcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 18:49:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 18:49:37 +0000
Date:   Tue, 6 Sep 2022 15:49:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Fix the DAX-gup mistake
Message-ID: <YxeWQIxPZF0QJ/FL@nvidia.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
 <YxdFmXi/Zdr8Zi3q@nvidia.com>
 <6317821d1c465_166f29417@dwillia2-xfh.jf.intel.com.notmuch>
 <YxeDjTq526iS15Re@nvidia.com>
 <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631793709f2d3_166f29415@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbbbc732-f4b7-4abf-38ad-08da90388c2a
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ETj0jxi+pW6GV4DfUhZ8E55bH7m/4+ejI6KAlDRNrDW+U1zwkkUsEK0sOgyWy64DbHr7ptlLmTrtrEqGps5R68zHHzjR4jT9oVSfObcz4IWYW8Y6Q5sl/VCEhl/SVef96IeqyLuEdIogyFQ1JSS0DcOu/ix9a4MwNCeHrecANxye4KXice7C12HzYZq5NKnu26nQkF4dzOBIO78JYXYFb2EhLxAjxR7T5z6IzHFNk1z2FGAV4Q9NtUKlFolMJtlhyhrmoYbnQGSOS9sebqTYwvlHwSUY3ut3TUoWRY0Ci73x1B+kj3S9w1GijHpyJW0y1n4/jhvF71TWdpFTfv7NW+9HhhME51Saf6DPVCiC22iqZ6jX8hRC0ReD1hb9f+hFK9Y/QeHsevBdFM+Ln186Wxc0Y2jGMVzlPqWYO6W2m5Tj5pxPwkyrVDIqH9pmBryTp/oDY4PeXjNkfv2QR49Of6uSPRU5XQx7KRllfaSXIQy5GlemCbTF56m+oSdHOkxy4V5cFIMchRsQSsmYTavwJfFrYhuFp6FkpAZn2EI7I3uHB+tkvD9JKm6Qw/QGj5HJ72RyrlWDl9p828MOMCg/yskK+i+qIH6qPjgg1XbuawUS7VFiWCxKuhYbWIj2LWRwP+C0VzSLZEh0iFdOB4n8YSJPkboG9FJ0jsL4fC8gaFjIPUemFIK62PZUjD+/sZut5x8Q/KJ7iFZKXvNzBko8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(2616005)(478600001)(83380400001)(66556008)(4326008)(8676002)(66476007)(66946007)(186003)(6506007)(26005)(6486002)(41300700001)(6512007)(86362001)(36756003)(8936002)(5660300002)(54906003)(6916009)(2906002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WBORVj9rz64mAo91lm2zOl800jMdM2AdLPTHFe+PFq4cTTAAKnRqYbijZ/p7?=
 =?us-ascii?Q?VEhnDJIw+kxgJuU6nxWvtMmoHwUe3n69qQkLWpqPXz9owiZ88a8FiqbUTn8q?=
 =?us-ascii?Q?qRpqSTf0m8Ivz0Rwy5Rwf4H+yq0cpT5aLn3gjYDxcKsOKjKhZV26pIjxCabm?=
 =?us-ascii?Q?KMTQ7alzBCLLXYhbJPYg2oCSbxXTw71LKEs9/3Ag6Xv1fnT5qk0OPWFzLiiX?=
 =?us-ascii?Q?+lF8Q0MbRDGtKQNmgMBYPdaDtRuxgJg2L7zdeqikTI1QpW72c70BqyPV4ARz?=
 =?us-ascii?Q?VSiwaFftTPS98Xtthfhfle7gd8R9aZeydj9dHU0wsKiDaxc0HwjLnc8Wa+Xu?=
 =?us-ascii?Q?XlMD7ICLMy29edZXlyf1vtoIMy+zxYLFiu+FcoVNhn/Mq5Icoa1MUUA5/Dj0?=
 =?us-ascii?Q?PsKuR0Lbenx/a76o/b2joXVzWJwT9Ht1Ok/OdIiafbo/QfxH287BbU9G4WOO?=
 =?us-ascii?Q?Z6vUJzHIwq4rggDR2tYyrQAo86ssoAf20jmdfDNoQJp9KiIKGGj55bTP2Fdf?=
 =?us-ascii?Q?k7aNugB4um/AN7eWjKtiVM/zXX/wEqqvZrywZx9D7E7YfR2ASqNnyL1wT95C?=
 =?us-ascii?Q?BXxjiM9kJWVyRMh/QoPeu1jUDn3Flb0hp7v/4MqPNx23RMpSTmY+J5bymjeI?=
 =?us-ascii?Q?SygjydeuBHIRE6+nsQ2W+tCUMUv8q4UeGPE3dGu3KrJlMoNoHtisrApuWbwt?=
 =?us-ascii?Q?xxtr2bmT8+BXcsQmiSYczV9i1AHUx42VLqlLliJMnAjU1kQU5hDHpKQax5ku?=
 =?us-ascii?Q?kaFfCaoMLmeOTvcEkwM4En2Yx0HW2o4KfttgSBbaD8QwV9kJISpsIY7jEgj8?=
 =?us-ascii?Q?HaAuKqDjZk88OfhLU3VIOOukyg6sPD3ERFT8KulnTmBNEdfpQVp2mgzMNMg8?=
 =?us-ascii?Q?SF8TkkBNtyTvsSJMaFobDKhHs9hAm9pZYuHu8paap1ymCyfPXsA/l/4RGCKp?=
 =?us-ascii?Q?3pxmOxiq9nWoTC+VyBUUUvieMoGdYFsuTJF6pYkIxF1+ZHI3BsMHz2PFq1oJ?=
 =?us-ascii?Q?uoZ3DSS4MFiaeCJTIg88Hd85mfL6Tf+PKOTSVuUZafbBaG6xbRaVWCFlomwd?=
 =?us-ascii?Q?EtTQU0GBsRYl5To5cMOo2DBPWOmBlgJCPPY+/QAUeZAYqLpszkqsVbivCfaW?=
 =?us-ascii?Q?KzfEoIZxOaCAy9X/WUdCLDCtfgmnDNjR80PULeyIzQklwtqlW8Lq8FLJ3ESJ?=
 =?us-ascii?Q?d0uOQCyqyzV4lJioVymVG1rJUwzKQ/+WmowXRyZpxr0PUJxanuHm/Mk/JX2c?=
 =?us-ascii?Q?RLxcxDPLPT3Z8Wmiv1G2j5kkSMWUfgTJtAracKhCwfwsibp+mSkjqwLGZCqX?=
 =?us-ascii?Q?G1jCx9v5/LaFXYuuu1ZjoJHNUTL8BGByEkiYFxRZKiuvgY4zAaLZiYXgMShY?=
 =?us-ascii?Q?mfw+6Jixpp2acOFgT+pAzU4T39Ty7bGXU+lCfXUwRH5jMjyWDdzpMYPktdBG?=
 =?us-ascii?Q?AuUukx0Q2uTcmKnYYaHPaUF1OdQcIO5bq4S1ntKM97Hea/xvtyZ9+jeuWZsf?=
 =?us-ascii?Q?Qlp1kn5dXUZ0PqFAJtjsoKJ8065KqM6qHuFGiOtE4PWFxshdX80qGyykffxU?=
 =?us-ascii?Q?lFZxyHbOtP58YXAv+tOuBNS8xdjjbDEJWqa/yEL6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbbc732-f4b7-4abf-38ad-08da90388c2a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 18:49:37.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0EIPDdZwjuszY5Jrg0ZTblNZXjTNNs2LJ5zZjmCHxCBq5V/OEpl8VfLEyOfI0Gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:37:36AM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Tue, Sep 06, 2022 at 10:23:41AM -0700, Dan Williams wrote:
> > 
> > > > Can we continue to have the weird page->refcount behavior and still
> > > > change the other things?
> > > 
> > > No at a minimum the pgmap vs page->refcount problem needs to be solved
> > > first.
> > 
> > So who will do the put page after the PTE/PMD's are cleared out? In
> > the normal case the tlb flusher does it integrated into zap..
> 
> AFAICS the zap manages the _mapcount not _refcount. Are you talking
> about page_remove_rmap() or some other reference count drop?

No, page refcount.

__tlb_remove_page() eventually causes a put_page() via
tlb_batch_pages_flush() calling free_pages_and_swap_cache()

Eg:

 *  MMU_GATHER_NO_GATHER
 *
 *  If the option is set the mmu_gather will not track individual pages for
 *  delayed page free anymore. A platform that enables the option needs to
 *  provide its own implementation of the __tlb_remove_page_size() function to
 *  free pages.

> > Can we safely have the put page in the fsdax side after the zap?
> 
> The _refcount is managed from the lifetime insert_page() to
> truncate_inode_pages(), where for DAX those are managed from
> dax_insert_dentry() to dax_delete_mapping_entry().

As long as we all understand the page doesn't become re-allocatable
until the refcount reaches 0 and the free op is called it may be OK!

Jason

