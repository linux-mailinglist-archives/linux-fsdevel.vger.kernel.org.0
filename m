Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076AB5BFF77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIUODb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIUOD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:03:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FA33C164;
        Wed, 21 Sep 2022 07:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRNUtRSsHE3adKUax27AF0zEJjC73VaivZ/vqaqlP1FnN47iNCnR7phjdcjtxkHr81KBtFbUuBYgmhPaw/npCRsJsbTWIZaftm0o2nU8nGbtSjIppSnJmTVGQMto/1ISbQySApOtLv3JZxqRaS62XJuoZT9Was0//ap+pWLO6VpOmBit0OkZlnHfNW5w5XbsrFlm/yCLPOo8qrkVyEaPwBwxi9iOelSgX2cZiAst7c/yIUFKD7/avWcyc2RmJrN1rGVWcxGriazQuy6vJuAMvldMZaltubzqMo/ijBBMY0/tFTk8/hqqnXoy7DsZLwy6tYw6S0T57vlWzS7XjkYBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvqs4A/mqsRrXyiHP3KDP4QYwI5/VBZJY9qmgn6n8C0=;
 b=Qfynx3SujWj0qaqThfiFnm2P91I7rYiK+3wPaSnbp7JiZOszPDkozqNT/riCWfnECu1/RKh88UdJZySCCBi3/nzaTfvTmWwfczjeSyVC2itnC+0ZOH3qHEcWRYEw7PFx7yMNZkgt3/189qGh3KbrI79bM2W9mXOGadNnqTCi4leqMWOz72oDWf3qkUp1l49kG0r4HtGh6VQwfahf9v74fgpmfgdDKPwv7nc5up+o08yMkqBEPApuFKFQHlZl9MrTZiVq+lOgXQhdm64z9HDnC5w6blgiNW36soJndNx9t6yt0j+WinW4zDEsHi542CsZ+e9Q9noVrA5B3waAJJV9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvqs4A/mqsRrXyiHP3KDP4QYwI5/VBZJY9qmgn6n8C0=;
 b=CO2YhnQFL4/oIwDEgBk2Q4/gfn3uk4sZY6OnzbJpHj/984P1gvOM8quLOyuil9njksaoCL5Zsx2ncC2muyK0q+tUmnghprwzdK7AqlmlUEKS807YIA19e3ciX8whPuEng7Mxs0Q0/sSUGZL+6FHoirip7vRhyZl4XMvuHujC9E9SJUtKQ3FG6iyzp+Hr7WETRyZEro2Y/titEkbKRjMTpf900PczBK7fy0qwXJ2jIpDOdTDcvAr5K9JINDz8/yCj4wqWSpC5CXm3+OdfoSb+0pdOpIEwl5BPSKP6s4IZCLVDbK4xXG4mmJSZaG7K7fr+khRHAHJw4E8RKxV5+V43fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 14:03:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 14:03:26 +0000
Date:   Wed, 21 Sep 2022 11:03:25 -0300
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
Message-ID: <YysZrdF/BSQhjWZs@nvidia.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MN2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:208:234::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: ef07b360-34d7-466a-997b-08da9bda0dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IepXeZcPeBxe0vN344WDYmIlOhi4+OrkVOGWyhTKo2Wb8sQV7ZLa9VqGERzISS9NJTYYz9qjrmanjoUlF0eWsuPww0uraLyzZN5ciCOcvmTASPzK7AuiKQyiBAdldyLXifZVM+7M1/wGKBgERxqHfggBsCQFo9FRSzht9WJpujoROU3dLgkH4XGLROXH/UQ1tcLSN3XzY8un7IJYnsETLGmYiv8bTgFTle4K7WDHM4Y0x+l//Ztzq4GMvm06YX0QyedKrBU4oughAaywKRqLo6oB0cUBsV1n21TyRfWwVxhbfs0Cnw0iO4YrCM5z3JKwd417f6fMFdXGCG5zw94giuxJCKKhShu3FL6Zmfoh0NwV5xe9QNQGDubsZQqal23PDxN5KVCkam0c2rK147CxKTDwmXpcEGWFGfoZdyYquzdZJLIX74qL5/l2RbA3eNEfUhzC/zBhJa2mlDY6xH41/9z8orgz23Z4oykJDNSBKdhtwmftKUuiVZWeB7oABE3qf3Hm2IDdNJq5bS8A1gNX/nAGEP+y2lBrQ3XtRVbRoJZ12r1uM+ISDkQnhmiefJSAHcmmEWdaAbHP78PDD2mlfUinMEcZnALMdw3w+FWhRvfBaRazLSrWjFT4YTKYNbx6rRcq/yUTNsHw+CrSUTrzA8i44DNtfhv1KzpD5GemRHkfG5yOq94BNqNqJqpXwsJD6wqaibVmHhJ83jgVQEzmeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(41300700001)(186003)(83380400001)(5660300002)(38100700002)(2906002)(54906003)(66556008)(6916009)(478600001)(316002)(8936002)(7416002)(6486002)(36756003)(66946007)(2616005)(6506007)(66476007)(4326008)(8676002)(86362001)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9NNNFW/EAQBgUM+DK1oZp/HQjNtZEdxNvhTSwp60nPL0OShlIftoM16BFFE?=
 =?us-ascii?Q?TxnxyThJ36JOTekmALC4ppTqvR5oEDEKHFXCT6jQO1eOpyq9iSW/d4ouw8Fe?=
 =?us-ascii?Q?0PAmhJ9H7vR5mS6WTzueijsBJmt0t8t+VH6Lbhx1oMXNp+RTZWVq0BPhSZhc?=
 =?us-ascii?Q?dGmZGlYYnJ3oxyh0fETembdM2v1acxKrI+a2jP74fre+AjH2nWc63uWDyMzt?=
 =?us-ascii?Q?Vr+mvRnuWECH29dwG5buGeL2N11ra6GgkKL3VhyVyPLm1ahr+QUuklLGVaz5?=
 =?us-ascii?Q?DhBE9GyZC5d/kAJjW+fI/kBzZwbux/GOL/+rwtuwTmWyh24Qroyz9OFkyKEK?=
 =?us-ascii?Q?V5iP7xz9H6cU6ed1n5Yi2HPKGrFT53ufOiv+EoEmFQr2HYcQgID3xTHQKQg+?=
 =?us-ascii?Q?7BP07zl0DMDl2JG2AFfU7MUrHdCkGEDc0hEQfDGQhzHJ6Tq3X7LMPCRkJ4BS?=
 =?us-ascii?Q?0lhOQ/0cyYBEE17TOXdq1NuP4v4QCS2suzc6oo6zG28GWkh2VlhwVgtJmXZf?=
 =?us-ascii?Q?VsaCUFKRva+CMj/QFI0pb78yLb7myLfdsGEykpGh98MFFqCwHfBOr2Xo8z8H?=
 =?us-ascii?Q?d/F4Zzw+CAanTuriFCGh0TgVGZwuNU84qPgtE2drXp6VhxMl22KWyCLOS75t?=
 =?us-ascii?Q?R3ngl1cJUW4XZv39f8uZdu4o6eb/6B1C/weAdUx7rfv6nnIqiY/eUUsFyYLd?=
 =?us-ascii?Q?FKxgLLQpLJSPgKe9TJQZgvyV8o6ig1DbwKbu5iPIQKYCJD5eJ6ziJainoQUH?=
 =?us-ascii?Q?E8aO0YtDfhpOq8+MGGW2xGVCtLI2iUZ2jKULPcUobhlvLIfHNA/jQMbEkIKl?=
 =?us-ascii?Q?gLDTy8EC7t2jwE/oTY5oETy9mvTmBGKh4HpjTtcB+3CRzSb9BUbunixBXt0w?=
 =?us-ascii?Q?lQh8xciOn8SPFm59VVPYXW7Mf4ZJBN0JdGr24q/88+uiR1gHlvtTYy63RkH3?=
 =?us-ascii?Q?1SsFIlgZK9lcOsTmsiskbbJF5AmerKd1c7MFFeilscSYMGARLtiKAw5N9b7l?=
 =?us-ascii?Q?j9swqAF7+AMuIcFZU9mV8mZoTIOkg6GO7hnHjMXq/+BvASIW2iiIF5BOEMHH?=
 =?us-ascii?Q?m+55PcOf1U1YTI5zBs7vLcDqFUkNpKYcSSsI9Gyt9bMGhVL1zbvNf5g/riWJ?=
 =?us-ascii?Q?BBLNrtCO9AzZJFJXr4n/krBYxx9EQEqky5igL1xi2AkqlgofaTLkWdR7wRSf?=
 =?us-ascii?Q?xEeNZcVy9tPAOWOI3wXEuaA/I4VdrbkgJg0jZvfzCqAhM+/wCJHzl0J4vodE?=
 =?us-ascii?Q?bAbjSDVOZuGJiR8BCi4SA6L8DX2pMA5Qvi59AJt6kgWcH+AfKm7WnRYtuwbB?=
 =?us-ascii?Q?wUmx1H+K0XqJ4J+twHUjCVYsoWsIlKsDC8KWwdI6CJTBMCfkeHi0Z3qC2UaU?=
 =?us-ascii?Q?KziZWfY0H+XlGiLnKyFCculZToSoNuwb5GRpPT0yOD/8XOedwX5KgM5f3xy0?=
 =?us-ascii?Q?5LsiJBB/K9rqbS0Dq7CHC4++i7w1rRTfBvrBQzrejdm6SgwqhnmaOf4pT6cw?=
 =?us-ascii?Q?y0F95elXbGSdZh45plpHGDm4q89adjNA9PgnZ4LsxwStHbsi1wCOB5hZYIOA?=
 =?us-ascii?Q?iVasPDqmkXygYMG7r+dzNQAtmf5lv1NR9rBg3o7j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef07b360-34d7-466a-997b-08da9bda0dd9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:03:26.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o2QvWsQVMxBoGhUx4ypqUUMg+akEqEACasop4laEQ1pKWsE2nf1wb98da+kE7LC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 08:36:07PM -0700, Dan Williams wrote:
> The percpu_ref in 'struct dev_pagemap' is used to coordinate active
> mappings of device-memory with the device-removal / unbind path. It
> enables the semantic that initiating device-removal (or
> device-driver-unbind) blocks new mapping and DMA attempts, and waits for
> mapping revocation or inflight DMA to complete.

This seems strange to me

The pagemap should be ref'd as long as the filesystem is mounted over
the dax. The ref should be incrd when the filesystem is mounted and
decrd when it is unmounted.

When the filesystem unmounts it should zap all the mappings (actually
I don't think you can even unmount a filesystem while mappings are
open) and wait for all page references to go to zero, then put the
final pagemap back.

The rule is nothing can touch page->pgmap while page->refcount == 0,
and if page->refcount != 0 then page->pgmap must be valid, without any
refcounting on the page map itself.

So, why do we need pgmap refcounting all over the place? It seems like
it only existed before because of the abuse of the page->refcount?

Jason
