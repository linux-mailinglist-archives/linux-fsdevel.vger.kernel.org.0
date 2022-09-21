Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11C5E5637
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 00:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIUWXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 18:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIUWXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:23:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C7932AB0;
        Wed, 21 Sep 2022 15:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz9XHBPFuUnxJL6/DDS7tvwZYo36F6j5BOblFKcGsMDYO5Nus8gdLJbPOtfjtvtJdcsuPbHE58TY5Bx9W9aFSpuTTC/eOG+cde8XgGwHueoFxNB1KyX0jU+SNymeh93qmUY3fgXy/2y8keu5eCBLmT7HunKhWWgKHO1Z4bmS186DZEGhrhzlwDFKCr3hBJ2VlZF9nKu3s7TdMSpyQ21jDj5PzzfiU4nyfUqHUXMrmWigWlCzlRFRJMDEi9KnOVPBgXzal63Q3oQI+WBA1I/kL/absZ8tqVMbwLjAgjgRNgQ5tr81RuHid1gcq/YI/Di6d++OftrVfTuzIGO1i5WQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcC3oTkFp/q5EJzu3CmlxnHq/Cidmvvc7HEyiGD9BEA=;
 b=VP04BsMqnC5gylNpJmbX/YrA0rZXQtCny3H1Tn9+zQ1vVOCjrxN1C4c1tbFb5V5WQ5AJ7FkyWT2N+r90YO7OW/Gnjweh8txK6AB+K/FXJXa09vm44s0JXE51NbWoWOgLE7YPYcrYOEHVCkxYcwL5J0+KGVRLHr6waC/iKa9/KCmf2D8OCXHMbTbjVB7PeZEmbVQ2V76JtjBJotpk9+rw92uHWNm66mglAaNCYmQPqZm9BfjwYVIgFMANH1JCOfr+nB/3c5clwaAaISW5Imm1AM226p6iu7rntlLuJWUuQeA4PVlM3eDWA0thM9IC6GaE+ljPvBZ3ymqEWN3vjiDvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcC3oTkFp/q5EJzu3CmlxnHq/Cidmvvc7HEyiGD9BEA=;
 b=ECQsH0FlNCTa2FoyWiFfsIWTgLLTPUQhMRyJlvKp+un2WnXHmdF8/CRsEG21/ZLfwchI9yjd1k/NIuvBLfL+kAg3cwh4avh1d4QjqB5BXD8ItkDKuk2p0AjNs8eRk2C+Qqs176LH+T/zrga4XrVSIQusgQFSaFxG75WSWFoF5wHwwVqdX31S++pY8i38JpTmj8wmmc0fGZf080hRYKYao6oVQiIdRhuRf2LWmLetWdT5UtHkywBLJOQ+gY7k9/zLZ6PzXI37OGE7cWTAIDxRqPj6OB1pk8nKJXosR64BHKv+kzIcXxRmvr2fhSmYFzPlG/BdRNWfiF+zeeW943vFHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 22:23:15 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46%8]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 22:23:14 +0000
Date:   Wed, 21 Sep 2022 19:23:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 15/18] devdax: Use dax_insert_entry() +
 dax_delete_mapping_entry()
Message-ID: <YyuO0ZL0HG6zZ9PI@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329939733.2786261.13946962468817639563.stgit@dwillia2-xfh.jf.intel.com>
 <YysbXPnA3Z6AzWCw@nvidia.com>
 <632b3246548ff_66d1a29431@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632b3246548ff_66d1a29431@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: cb906428-e6a6-404f-9af8-08da9c1fe016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqQjbFMrFj5zKFgzHwP5LwlrKZkGpnA6TtKTay1/H4cGigp3Fdal1tcRVIXVAPupqYb4h79B634cBD8LoRnHGli5cRNW8q1m8+5dzqwITMdrvoVzCu+Iwbmujli+FoY3mZIq0yqNyDuRz7MfRLi9vmFXqw/ZR/vVbEjCrTKW1OBYNT2Rg95EVg6aiNp1HQqm3WWP0y8X2w6yI7I6NCVK/ljis65i5LeWzmeW8rj2lQpD1ywQxmz8gb/VJYaNoY0wZ1li9SOAHeD2e5/sCANiJzyTRQNygo6FSuaHoJ0tNThZSk58UTE/NyK2fKWVOYEe1TSOh2eXacMGulOwfXOKhfoCEmq+u4KcLPaAQcw7UuacMaEbcEN5jvM2Ze95b7i5tb9WWFkUEVt6m0LMcfgqse75URj/aZH11qKJfWovHAtPs7bcyq5IIFXnlzvSAWE1PvdA/sRpCHgtXo6SShSyBsom4o8RQL8hxgbn0CUE4ss6JuZybkpYYOBpMQxKOjP00RAmqufoug9lrqTJBTT9zmUuwSzikfrtJ1erOQEVNKov+uj9vePdz1rO61OISblRGy65PtegH6957ELeASGp38EJwrRfuPj7OpPwpV0yf1dAVukB897DgMDVTQvY5ymLWA4YjNIaRHknPaBLJOQBdE7XTg2szyLxnkKlCc6NeF6DEthYGGtkKUW9AdQYVCch8yF2L1OKx9hWwwXIyAMXVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(5660300002)(41300700001)(8936002)(38100700002)(86362001)(66556008)(66946007)(66476007)(7416002)(2906002)(4744005)(4326008)(8676002)(83380400001)(478600001)(26005)(6916009)(36756003)(54906003)(316002)(6512007)(6506007)(6486002)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgAvEZHORIrL4cWTDrhISBhz02wejbs71n0UGz6V9U6yAqk/Oe++U32cJnwI?=
 =?us-ascii?Q?RlBf7C24/vBwGEzPw1BJ/PUNnSaYUQtcCGy36A6RoaSwEgEC5tz4KMPOtWcg?=
 =?us-ascii?Q?l/HdzbqK44UxiyLlCLzEf1loE03rmh4XbxQ1Q1e00Mj9HJn3yTjQMDC0+DkZ?=
 =?us-ascii?Q?3+LloZXRV+9444r98zvvvICVc/0gBoLCrOgMhIUlRC3oAiRgFo/nr0V4tXuO?=
 =?us-ascii?Q?dRzqjcBLvnTOiVZdsZwFncSsK48C3/doiLOeI8h7AsJqEfKcrFYfRR8O3dKZ?=
 =?us-ascii?Q?BiCA7iZTb3narNBb+mEK4lpx92kOzMg9OGOheUAGrhiAJgbSSbdG9WBqq6fz?=
 =?us-ascii?Q?bNQn6Xtq9tZK7usyv20tK7QoOCF8ErMt+NCFly0Xu03x8r6APuKmc3Lsf3W7?=
 =?us-ascii?Q?nF5FkrHmr54XWd9nO5TxF0jj1kbM+vI6Atcm/tSs7XYTRZmLAZK3I4JNkl2F?=
 =?us-ascii?Q?eFYspsEDQJU0HD7L06IE08lYGznYQSLIldZPhRRPNykA4ZCzF8ox6Z4s1qzx?=
 =?us-ascii?Q?/DcSv65oj021Gr9Ecc+2JD4uOwM1Dmurs7RdvP/sm1IHbCxqE7a5tFsT2aWp?=
 =?us-ascii?Q?wsPWDVBRxnYeK2m8Xj7a7VQQv/+GRyGofuEVMsZDFYnkDlmiexDzMCo3e9af?=
 =?us-ascii?Q?fxdAqrLU0cZdsKnZrdxxYXTIoQRFcm18sc6QDPKGJhIZXyDrPtLnnqjm21ah?=
 =?us-ascii?Q?g6xYfUhwF9STlA45KSNUN4qI/n+BHIJgI8qOK7f/uaAWbR7g0z9xE4mZPSkD?=
 =?us-ascii?Q?NMLpVQBiQ/y06yQL0Wzeot0BtPHrDc5HcGVtQKoAmXCgRiKSAifAZ8KF4c1f?=
 =?us-ascii?Q?VDechIBAz+QgFMfp1dmyvDr7tE+aDtY7T3DvUw/RFscvVWrTJhSMmJp5hbak?=
 =?us-ascii?Q?9hxSqGmsSVN2Eiz6ip1DXNBq6eTu7i5WEhxmvJ4OdWPdnHuA8cmE70TAe57g?=
 =?us-ascii?Q?eNBHPDBP22B0iuQ/hSuftlDapb2yS9VHV9uo36kJpn7+rKWExTSstOPYE1c+?=
 =?us-ascii?Q?Z2POWlCnz+DnWp/P3NzAISI2saC2F0rhjbxttMC8hf6eJP8rS7TkqtYWxuy4?=
 =?us-ascii?Q?ITijI963eV2yiFl+KVGuF953qnsdSlZOXcd6OgBW7YavvTGlFxTGBQkyCgm9?=
 =?us-ascii?Q?pzaixGXgBok+IRMhSZaUWpf1mUlfEOmAWc8PPeqRxQIdm/VxpzXTT+czNekC?=
 =?us-ascii?Q?BLIv6KgMTqBLtlVWvjTBTtcp2KUytqvBEoEVXC7g8v1xHMab8nt9+n0LlE2R?=
 =?us-ascii?Q?Ois0pfwV5FsgecWVjTiduhTM20M8/OApw6xsvfCaw0alo9As3bOanjLtQJUZ?=
 =?us-ascii?Q?voK5tu3HkNnFlBxNwH8O3az7LvA6Vxig/mHDbCra30/ylotFyenCDIlq/E3V?=
 =?us-ascii?Q?y/DrgWPkDJVG/GhubqwBpqFCNNB4fNr5qJiSU+CgNhIm5x9kI0ZBiUf58EcK?=
 =?us-ascii?Q?UTaJb8CK2/9La/7cWOp6/xv2CXZFPb8W0GT1tt5H4xZHWaHm1TrAmP9/Gf7T?=
 =?us-ascii?Q?jTvby6XRSHrEHslYNB/DjGYz0EZbe9z74NDYBRyDAfAqU3JZH2rA9e3IAVND?=
 =?us-ascii?Q?i2/AqwM3s2QPC97uXHFsKP3H3LaH6q7WdG+aoQC7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb906428-e6a6-404f-9af8-08da9c1fe016
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:23:14.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5icy4kyVaV/Ug1SjLrTA57yrcCDJgN9Nv49MLH33xCSkfKx3qk3XTKgo2YV2q1tD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:48:22AM -0700, Dan Williams wrote:

> The fsdax core now manages pgmap references when servicing faults that
> install new mappings, and elevates the page reference until it is
> zapped. It coordinates with the VFS to make sure that all page
> references are dropped before the hosting inode goes out of scope
> (iput_final()).
>
> In order to delete the unnecessary pgmap reference taking in mm/gup.c
> devdax needs to move to the same model.

I think this patch is more about making devdax and fsdax use the same
set of functions and logic so that when it gets to patch 16/17 devdax
doesn't break. That understanding matches the first paragraph, at
least.

I would delete the remark about gup since it is really patch 17 that
allows gup to be fixed by making it so that refcount == 0 means not to
look at the pgmap (instead of refcount == 1 as is now) ?

Jason
