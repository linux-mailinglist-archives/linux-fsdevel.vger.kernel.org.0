Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71A679AEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjAXOBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjAXOBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:01:15 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78323F76B;
        Tue, 24 Jan 2023 06:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHU/cVu7U9Jpm8Re1QyBDK90qGmKM7qICoPB9pjr+Io3y1rZwl17Df8e4b1oeBCapoeMZCKrkXNp5brwpZCDgjzqKHr9LLNDIEHc+JR9ADVP2vXwl5usecp4F3GOvwMQhGEO60J1BYhngaCALk7Vyls47uuODIRobdaN2Zh62/ejJ4nIEu2P49nLZHxYJwtMvVEDoBmJShx6b9PccEod7bLIbYveTkRMzn6q2AqKcYAIFbYWWryU+7iczdNH71c3E4E+A4VMdQCAiVm5d60uhZzpM9nmtv1Aqt5rk8KsFAqjPRGv/qJkYEtAAF0M/J65XNET3v6DqaHcg8uZUAIBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/gJirx0civvafuXC3Du5UhUMe0BAjkxgUcXj6ysWE0=;
 b=b+Wc5uin7UAwfdsYnc681HHxgY++DIGerL1zrHZD4e33pV+NWq1pPY6jbQGCI/Nd4v7x/yciL1wnsW7tLoPZFm8Y1jwg1nof6JR7ZI999x44w6O76XfVdd6F099ifYkQKAk3HikqLS9F4aoWxMMu3shebEO2B5kMpNLm1ptzDYZ5733yfOqsG7mgrQWKWoC4ymN3irezfdubUDva37OfnLx4OxZTCToaQR8sS4wnrTz8es92qU3lSVNtNI7wD/TY+8LZm6aKQ3iDUV0JD4Fkd3E6yBxt17YfKVQTrzxfAKSMDX5FFhxHF4yLPlhTqpVv947rqGtVSA3/w9/a2/ld6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/gJirx0civvafuXC3Du5UhUMe0BAjkxgUcXj6ysWE0=;
 b=BmraP7q/ZMX1QypkUed5qNEvrThuYd54tp/y7pRG1nsvkR9OGTK8h4e3OFvCQ0LkrV8vylafCrX42jxcgpkMWx2+TqT6ZLWuLa8HwPvUPqxxMqXrQqzcer4BLioxUvZT7w3AD0VtWsmXiJqjaaMA4fEvYmdhmn77qiOEyRof0o3+ezlxifvrSsB65T0gP0O5x6ol+SnHAaBtwwbP6vJ9p/uIl1/slF9pggwbnpOQ19h1b3qusNoSBsHERdSJC6PhPH+C0JD0PIdF3w0JhaDHE7xDSHT+Y1xtwhuINZIyx39iwNwp1kFEzv3ya/1ICs64Li/OK3COedNiWTw0z4kyYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:00:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:00:30 +0000
Date:   Tue, 24 Jan 2023 10:00:28 -0400
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
Message-ID: <Y8/kfPEp1GkZKklc@nvidia.com>
References: <Y8/hhvfDtVcsgQd6@nvidia.com>
 <Y8/ZekMEAfi8VeFl@nvidia.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <852117.1674567983@warthog.procyon.org.uk>
 <852914.1674568628@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852914.1674568628@warthog.procyon.org.uk>
X-ClientProxiedBy: CH2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:610:5a::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 392979d9-8e53-4964-ca6f-08dafe135a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMKL/EQg3FK+dV7UhCV7wDYl3JykYN9K8cGVb3wM6NcthuAcPK/WL9bMPDAJe83+HWLeKngXPD6zGkm7xI/C2ipgwcgjy7wHy7HTAJ8Aq77qiR0cBM8EuERrA/rS5TplXgxU6EGk6MDFfNEQplL6niNj0LN0yEe8DjcBax9NoYYKn022mzPZDVIDv8k73VjLC1EWedhmraNTJdEw0eaQGCcv/mrK7zdojLKSi9tHJXvCt599hERXtWBQ9DoRahOPXWANf/VYLdHIaCRz5cBgS7vAfL10SIET+BxeLg0HNqirfEkWpLeeaQvU+q8MJEHQkd1IBqcO3ZzKLo+yS0u1EtLaCoQaKfgB3ji9eLUSKyd2vt4Q5MJPQEDNd8hvIJO0utkAtMMluGMoAZpM9Ls0RHG/TaYklCVr0hkfehH6nt1S3csXkQ5giITB9jYAgMSwZbnDY9zPA/OtoomWcIjgf8J4F2UnuINze8+2JfZvoJyhShRlMijgMnTEWbD0EQ2SJblA1NGGTe/1t1W4NX7/imuZ3ssNpSohwMW7W3DO/SPg7M1qIitm8bIO1xWdaa1zF13Tpma24ZHFx4TAVlU2t6rpvOr1+tKQRjajW5+ZR87IZmrVU/5XHcifYg26zACJIDGemitY9apk7oGwm8/8dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(86362001)(36756003)(54906003)(316002)(8676002)(66946007)(4326008)(6916009)(66476007)(6512007)(66556008)(26005)(186003)(478600001)(6506007)(2616005)(6486002)(38100700002)(41300700001)(8936002)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUwkBA1cvgvd1xYRK16nOIPWDPIptUs/e6lOwnnvnl8N1e3kuDtF72fN2mfy?=
 =?us-ascii?Q?PBVP0J7/eM+/eAC71LAJSRB9U6VRL/g/dR5nwUNOCBgQ0fS8AiQidjrIww6+?=
 =?us-ascii?Q?KOzJ/DnlsIeRy5ORiyGiFGmX1SrR1URym5CRSzhYnUWTYBRA/Ew3fx8qzpx7?=
 =?us-ascii?Q?IBgkeQVJUqwO7CqDnZfbmXxb7OT8TNUmEkJLseizrlGymfLD9MRoDlgo07+e?=
 =?us-ascii?Q?z+Z/8jkrJmGFVjVclAt6/KaY+G10oY1S3p+x5OZo2xSKk0Tm7fUZQom4+MEb?=
 =?us-ascii?Q?mzZa6Hl6GQ1jkWb0P3U2Xd0X47VpRZQV7iRGBBZG4AoE6HdjPmgwkaIIopr7?=
 =?us-ascii?Q?5Jz2FTlhTmnb0l0/VafyYiTVKBeFnHKniMYgnpwn0vBKnFf9tdbN0sRx/43S?=
 =?us-ascii?Q?UzBV04/LIPDd9iHve+HRSeHCDLsaRLMFQ1r3tD8B3MVE38SwGp+H40Uvt9lX?=
 =?us-ascii?Q?pL1vz+EjIu0g783ypxllAj7FO2ctp45UzhtXQboBpD3LoRyVSK+J44JGAs/s?=
 =?us-ascii?Q?mTE6BbeIWpT8ITtqhow+DYOnGtgVAkso1n+WIk1FAiV2a9jyAn8hdcqnFLC+?=
 =?us-ascii?Q?SkAgxxjhlBjxq06gDt+sheNnlwgQI2CAl/tpvATwe8ePk4KqBoBxb5KUgvhd?=
 =?us-ascii?Q?oNexJbp3CKpuKwQ5eLNUV59ObeGd+71KhM4PPZDMq/S+3liOMPKDSQqrW0WG?=
 =?us-ascii?Q?nosNZnSzrzN+1V8WI3QdGJ7muSU95CD/qbo1pIJ02POfnN+jeKSajDd9WnV7?=
 =?us-ascii?Q?rSz5U148hGrXXJOwOs0hpX33RLdLIyO1E77iCT/qfP9LImtBjpN6BCLfvYRq?=
 =?us-ascii?Q?X29Exjbg51WdIOohC3+Y4tFWMQ2ngW01w8fqEZpl+cmcSg1REGA+TIxKF9zr?=
 =?us-ascii?Q?g5UIWlzlF4LPKGLJ0WnHNkLJ82r98pQhw97IntPB5DKOpIpoJSNsDjcWdisw?=
 =?us-ascii?Q?96IGDuKh7h6wLFycdderhpg7dPNHAODGkiwDYiHjrB3oHvL3EbSbY4iE9RLr?=
 =?us-ascii?Q?o3Vo6qzVEHAYUFi+XpcyPy9BUJ8XXZbVCm84MpfYT9T8LirU7rYpk/+IzR/n?=
 =?us-ascii?Q?4f30yo78azo6avdH6QaxD4oCbO3NvqPNqt2zER1/oxoYrafWkrkO9sgUfhXg?=
 =?us-ascii?Q?v8V/gWC2eWTNPoTIIJxIBb8qNpLU04WjcQn9iY99QmRKibQ+Hs0aTynYmykQ?=
 =?us-ascii?Q?F/uPN14OjrqFGgECFDzs6u4ooK9dlCnQ2jrBVr+qiKXZCa7Fah9DpiMd9qqV?=
 =?us-ascii?Q?SNWC3FrXCAW6y6DBmvsF7SQcyjvGtPZAPQAgHXVQ1r7ki6WZ0S5rn4+EULrL?=
 =?us-ascii?Q?eo5P4G102hKPz34JFsufHIHbV9iEWlps2O1OXam7p4rwlNbBaI946S1Cuq6O?=
 =?us-ascii?Q?YO428OyWu7wUJXYhv6xDC1y6sVUMZEOnHJHslyY1dbp23/wsGqnxKOZ/lBuj?=
 =?us-ascii?Q?NwUaOOuYvVfV3Rknlxei8ZJDpB5HUL4D28ZkkA8+3np/EBjlU6lDfTzkxFj7?=
 =?us-ascii?Q?qukDxZX9dNXJqBvzS5Dt1rWWD4cXry1d2abPyV0S+5H6leIc9LDyZxaZw+iZ?=
 =?us-ascii?Q?sbASgZ6Pey3xc7ZilAJaudzJz38896QK3tspq0ei?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392979d9-8e53-4964-ca6f-08dafe135a59
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:00:30.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2CkGc8pHRhc2kMBi5Mv5FXoYzHDlBgmRZlSyglIAmikjvG2G7CyJYNRcfDcmnAG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:57:08PM +0000, David Howells wrote:
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > I moved FOLL_PIN to internal.h because it is not supposed to be used
> > outside mm/*
> > 
> > I would prefer to keep it that way.
> 
> I'll need to do something else, then, such as creating a new pair of 'cleanup'
> flags:
> 
> 	[include/linux/mm_types.h]
> 	#define PAGE_CLEANUP_UNPIN	(1U << 0)
> 	#define PAGE_CLEANUP_PUT	(1U << 0)
> 
> 	[mm/gup.h]
> 	void folio_put_unpin(struct folio *folio, unsigned int cleanup_flags)
> 	{
> 		unsigned int gup_flags = 0;
> 
> 		cleanup_flags &= PAGE_CLEANUP_UNPIN | PAGE_CLEANUP_PUT;
> 		if (!cleanup_flags)
> 			return;
> 		gup_flags |= cleanup_flags & PAGE_CLEANUP_UNPIN ? FOLL_PIN : 0;
> 		gup_flags |= cleanup_flags & PAGE_CLEANUP_PUT ? FOLL_GET : 0;
> 		gup_put_folio(folio, 1, flags);
> 	}
> 	EXPORT_SYMBOL_GPL(folio_put_unpin);


I suggest:

if (cleanup_flags & PAGE_CLEANUP_UNPIN)
   gup_put_folio(folio, 1, true);
else if (cleanup_flags & PAGE_CLEANUP_PUT)
   gup_put_folio(folio, 1, false);

or if you are really counting cycles

if (cleanup_flags & PAGE_CLEANUP_NEEDED)
   gup_put_folio(folio, 1, cleanup_flags & PAGE_CLEANUP_UNPIN)

Jason
