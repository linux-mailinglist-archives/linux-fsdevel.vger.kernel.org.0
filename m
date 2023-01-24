Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D454F67A448
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjAXUue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjAXUud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:50:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9C5085E;
        Tue, 24 Jan 2023 12:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbGdyUD1aXig7uFq9YYJQuojUKjtQnLSeX8au6Y+dn0MaTRLNhJuV9hcNNO0qOhyeZA/tCCZ6gOhj2W8XEI24QR5PlKq+dA7cjoYIKXlibdQ62ZVewKsAdi/u/WCRMbOoHrY6bVG/OFMFWAg6FS9T5WQXrVfryezp2bSO7b2YQZqHIEtT2ZKONQAPpTht99IMTEbN59iFysr/buX6J2Ifqanuy2zTez8aUhJK8B148gZ0uXh5UJj/LQWKZ0TQAzdJuo8g1yw1FMAH5yfuZqL7WOiAUSKx5WdpTE7k6gbapETwkXSYdpNpZEDD5XdCWJhXSfy26zSQhfi/tX+2UQlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sltJZelMqsslUPA+lPAlGHwIx/tAq+6UZgGrTJLuvAM=;
 b=MZr2vzF8mj4BcYYAcllWsysPbK5yPcMLVOVowrWk1BVcZg7kLiH/vnQZ4kLPaXO/2txVQuIqFMhLww2EHP5k3PbXKWX65Mjfq7wKwWkxvSVlzB3BkyH1xJlV+UPz6BYYqLQATgmovNINk+cpY+QF67ikiUSq1NAS4U02UFO8gxgeJ/M5ZZk5KhBWWBAGFRjsiCKkHM6OQTSpyvJUCduEBXlxVHPo6WmVqi+NYx+/jV1/KqO08XbRxCPourVdmWpbzCw+4O2gvC3cY3B96/N5Cn+AWbT9/hNuYKfYQPl0ygaDzNRJRvo5YbCdGWY7Cnw9Wf2LN0ZxFiqYL0obv1dK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sltJZelMqsslUPA+lPAlGHwIx/tAq+6UZgGrTJLuvAM=;
 b=SbPvRboo7MdAVsgHGmn+yFJg4ph2JmRAnDqw7PwsEGRa8ngKeLd9xPbU0J7GMiZEPYAS3jLG/CWA72cfXo2rU6mShOhH9smy530QkByT15dxbyQxMx1aZOj5pTbvJXyRR8t/bizmmvTqV08CEquW0VsZ4RmTU9WU2PLramt5tVqhm1CvNlsowUCbywSPGImZ7dnIgVovOFif98GFpHFXo6+E3ddiI/7XRg+OodoMyw92AFtJ/kxfAcI1O2YsfTZmN0938Ixcxu2ZJZjW9aXkgETdpDNoDLYcRWqvxGtuVynxjHB3c9vdj9R7oPqUy/eixanwCKeCZx1fV+hG79tfrA==
Received: from DM6PR06CA0092.namprd06.prod.outlook.com (2603:10b6:5:336::25)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 20:50:30 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::32) by DM6PR06CA0092.outlook.office365.com
 (2603:10b6:5:336::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 20:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 20:50:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 12:50:19 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 12:50:18 -0800
Message-ID: <4be974aa-2beb-9ae5-3f48-7dde6241b0c7@nvidia.com>
Date:   Tue, 24 Jan 2023 12:50:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        <linux-mm@kvack.org>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-3-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-3-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8554d5-0b05-4f59-f95a-08dafe4ca112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLqigxiQKSYtYMdGlcGt7Mst2A5MKr/p95uEDo0bVZfCL/RhJhEfEBr5Ela1+z2E5UZZIOT8MRyfLvjP9ybqNdvBlkyY3XDvR2YPEA7kUPGu9YltJXwTrCuIEk8dk9tJ7P0SdEDKfYSyH9ryRpnbFKcTyNSBTR6NYYpH+lLJs4BU1RbHGhM0TDOEpJPB2YD1U0SpFK/J6990g/VdtGwjGynD16tkHov2IfqVUo8tDLc+cc2vBOiLwI6CHr50VFSYKyXgZ8k/RHDX94rU5cijeFRGMyV2l3IWYVNqPM3Vom34VjIXEiNhFs0itDP1OKxviN6ImDgNC+li+5SK8uRjKav4EqKUkmp4VGCRuNdv4Bg8p7gqI3C6T4o1tIKoSFvt7mf/I5l0CwtWJUagAaQOsrAbaTwVet2LEL7Vug7c0ATl1h6NrxcOXxUHyfQ5utiSx4aGLYAXLMSs1kWdhNUUTAxQtMh/RUFB0uGPgVbkQ9vGm/nqcUB6POZmYORU2uqDgYfEjna5X4OMdyATr6F7H7cgLOuR7TEpvp+dnLJPAfoVdg41+dOviPdRiXKl4XpetlnpwAJUZymhRENX/VK5C8xeSAssrplI9jOYm3ofgW5sIwFNv47McrQsr5/cgsNqjfxSzXKmpZU0WDnWR5ba+oppr9WBVQsUxjfPQYIQt6KyMUwXqaJsO/3/U0L7krt8eVfmJSITM+mgRfWVU8En9f75rBkU5ZGNjjXrMuH9RXk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(31696002)(36860700001)(86362001)(5660300002)(2906002)(82740400003)(356005)(7636003)(7416002)(82310400005)(41300700001)(8936002)(4326008)(54906003)(40480700001)(40460700003)(53546011)(16576012)(336012)(47076005)(2616005)(186003)(478600001)(70206006)(110136005)(316002)(426003)(8676002)(26005)(16526019)(31686004)(70586007)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:50:29.8128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8554d5-0b05-4f59-f95a-08dafe4ca112
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23 09:01, David Howells wrote:
...
> +/*
> + * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
> + * not get references on the pages, nor does it get a pin on them.
> + */
> +static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
> +					   struct page ***pages, size_t maxsize,
> +					   unsigned int maxpages,
> +					   unsigned int extraction_flags,
> +					   size_t *offset0)
> +{
> +	struct page **p, *page;
> +	size_t skip = i->iov_offset, offset;
> +	int k;
> +
> +	for (;;) {
> +		if (i->nr_segs == 0)
> +			return 0;
> +		maxsize = min(maxsize, i->bvec->bv_len - skip);
> +		if (maxsize)
> +			break;
> +		i->iov_offset = 0;
> +		i->nr_segs--;
> +		i->kvec++;
> +		skip = 0;
> +	}
> +
> +	skip += i->bvec->bv_offset;
> +	page = i->bvec->bv_page + skip / PAGE_SIZE;
> +	offset = skip % PAGE_SIZE;
> +	*offset0 = offset;
> +
> +	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
> +	if (!maxpages)
> +		return -ENOMEM;

Is it OK that the iov_iter position has been advanced, and left that way,
in the case of an early -ENOMEM return here?


thanks,
-- 
John Hubbard
NVIDIA
