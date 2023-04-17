Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF76E4972
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjDQNLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjDQNKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:10:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA55AF14;
        Mon, 17 Apr 2023 06:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G89tKpt92EgpYtGMuTmPDClwEL6Bus+Y5BkijqX0cvypUGqGZsdSIG3UY056wpexw/L0xDpcAEHigfGdzP85pSIPX6QN18ARhNUGezdMNecdFyLAokmd2sY0OWMxEezO79YzCfIU7+hXNpd1UqMKwjANUXOtWI5eQbLvQ95GPKa3delnYoR9hRUhRLjKbs8ic5qOtEv8+UWAVibOm6RSPn03jo5D6zpOaM2gwzGBD46rIQx5nlqdmxn01jcP7p2Fl8r3CJaxcFK8uickW2hgxYTN4UWXyE6eoqwtSKHUPKRDh6isYu0wEq6LsK+e9V4CDiMuQLXjkHt6jWpnQuTehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpz1+HfZkJgLZIIfaMx+w8aaEDg/GsNeWlrjiVnRJ8w=;
 b=PFrPgZLRGeUA+LPTJ518X42m1h1D5mEQufK9HTGGDYRUeX7pl3nFi7GWkp2XPy/f0/trVIBG8ISYvI/1HsFTP3bcwOP9hIjDKjlO2BbVzEqMkFiuZODA66kv59MncLffO9Ei6D3K36ZUwyUkZOjOj8QD/G6vDM7kCRhd9efI2wg19iY2ELC7U0pIYCo1Xq/4O9uWGdqIo59sZgkoAI5y1F15ckSYnbvZlYvcYAWe4O22YLNzqGyvqW4cxDHcnKzzVy852sJWx6I6lFN9iQUsk9o0ducVLWGOypEulQNrHagXcpZ1ZS6Bv6DJFiZ9EW2aPZ55Jaud+22NuV6zWzHOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpz1+HfZkJgLZIIfaMx+w8aaEDg/GsNeWlrjiVnRJ8w=;
 b=hSMZxaJp7VZRdReDy1wmcNcTYgmu+28UhvMcULa2Jcoj5+UJSB2bQPtipi29MKmOC0FuXZcUFQkeBBEQ78H+mBNAs+JuoEPS1egMWprjbovIb0r7lLmtFlRQXKoZEduOwNWkWMUIPCcvF6K7b09VXkn27GBHj7hNOowiZGNFBSk3zS+YQ7GzgIqVtMSGVY5UG2T6hHcMCuEQAQ5IqvkjO1byX1/F6BypO0/iidRH3nSPaTDWO9PLV6aSpJ3M/kzjq50JlP9R5k7dta1ymysgaI2YHW/Bc6eisJup57n8sAn/Nvni/p5r+BT4xK16wYcp+HHX7loSjyy7udezUP6Acg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 13:09:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 13:09:39 +0000
Date:   Mon, 17 Apr 2023 10:09:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Message-ID: <ZD1FECftWekha6Do@nvidia.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cb5713-fc5a-448e-077b-08db3f45004f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7dBBRxVm8mYOzQ0DfUx4MiwDO8ArpSlgOiBFpJVFAyI+ICLr3S5D5ikpC8c9pQzZY4Y29fQy9IxdvJO1M515WvAqgBy/b9KxZm5J8qrqsPHFLB8ZB3/kXcKXK5zE0ioIITO4JpvJvFrRKYuVA/OBXlzlbIPiDPNZzTgYycAnvqKMD7sUqDd8pgK/+VqByvV9Zre8PlnH9peDwr3eKIkkHwoTzK21TkwdKazZr4S14gHYADrhkfJuah996afkuxmKEhSF+YxUAk4GKwd7XHzRoR8S7hIiKpz5Djudnb2aFywEIqMK9ybR1LcBSsLjlMNB9/4nDpIUmC206kiJUNDM0WhzsG/Q09Y/uOcvLMB1SnPrqXuK8neVOo1RDA5jG4FrWWDLiAc+fhZ4CKpAsAi58AmPXQwumdMgr6A3ts6WLw4s6obW51lgf7SKhTednqLIYp+Fbp6QgXLnIauYOC9uueiTduwVHLInqDmTZ+QLB63th0KpKkUrA2+WBw/RQurzA87PIsdM7M2IZGnTqUW4d9untlBR2mjFAejaXVQCvNTEesSr7BW7sL9cX69OpuJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(6486002)(6666004)(86362001)(478600001)(2616005)(36756003)(83380400001)(26005)(6506007)(186003)(6512007)(38100700002)(6916009)(66946007)(66476007)(66556008)(316002)(2906002)(4326008)(8936002)(8676002)(5660300002)(7416002)(7406005)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2yy/biwPHZy8ilmq0YNL9tCqzoGpXPyswKP3G3dXPbfIpTNNDb3UnMtCvbT?=
 =?us-ascii?Q?r9uDLALWDAwSc5Z99LIoT8RoZBz16DmCXXkDaXP+8vlKtbmO1GsbUcYGbQmM?=
 =?us-ascii?Q?bGF/goPa/+CedsTe+XoLua3vFa6/zBdFAEJ3W9hfql7dJbA2AcWRbKp4yyPF?=
 =?us-ascii?Q?0dmDXVf3GED3wHhqytl5uZZRycX29NmoDpANbfzdVG+dDc0Tjj1GWyzKF8x3?=
 =?us-ascii?Q?MGdum14NYZVIVy8E/eY1DE50HFqV5onse3j6no+SHQ6ZI0mLwlyzF3cE/Oyx?=
 =?us-ascii?Q?ywHJqIipG7VvrRbw7ipT6IumPF1sUULDSDefzTLhaW+4cNsHvaFA/QhG1a3+?=
 =?us-ascii?Q?VenE96xv//f0EfiDt6g9DvrtNCltgvduiU6jVmw7koiHDlDKC+R1LnuZyBRY?=
 =?us-ascii?Q?GTwpgoTd0uyp7j/dkXV5udgkgq9HBCpTXdNPUt5HoF62hw84c2Xf/2WzX/OO?=
 =?us-ascii?Q?i+J3NfZuamM+CNpE6TsjghKl6Fcagv+iT9HmvLF2pLvc5ZslOC6mrdAubPvx?=
 =?us-ascii?Q?WOj5ZkDIk9fPmWXUbYxTWJht5rcaV4niHjPOKCDMJqKMiYCq344/85xOZbS8?=
 =?us-ascii?Q?jltRxw94+YlXPQ1KJDxxgJwf3PA+LmuiIDF1sKQaNEbS8eQRx8pADaDLUU/i?=
 =?us-ascii?Q?tNRJz9wZUYCuLU6adFAU/WizSzNrfO+4QSAGnUZ0wRH3ZtOwwAWFsA8Ktpcd?=
 =?us-ascii?Q?j2c2IMu7YEvW1FaHMrT7kHgSje4WdZcMue6BvehIHoIXvZwiTcha5wJpFaAJ?=
 =?us-ascii?Q?NLtPS4UE/qB1dEqs6NfyAIZ9eeynBI4OJgojb6sSEF0TsXIIRA9gR4iG0jux?=
 =?us-ascii?Q?q4CYyBuYg4Iqt+ZtZQn5Zrd4y3C2Y49I3Dy1PPVLpmnVI1gTwhPqRoRYj+V0?=
 =?us-ascii?Q?PtwwIBBdlQe2DCCWVdi1N0W1mdG0zW4MfZGJ6wAM1chp8uo+2/N5LjIj06/C?=
 =?us-ascii?Q?G1xCh7azkgJtI5j4qtLwXDaWd3lHG0JU/VWtM/xSjcOBNFz9Cx3CTnB7z0Yn?=
 =?us-ascii?Q?hZ/f6CJt12k5kEtSUthmsGUnakr5i3lyZYpMdGyBMkLPKvYVn3zgp29dqoMS?=
 =?us-ascii?Q?7ePmgRhdKsuNOjx95Z0f9wI+l8CQx7IDmPDRWd7uK0tK7XtSdf77k8vJNQMr?=
 =?us-ascii?Q?sMFIVNsaa/yYu+MiXuB9NXSX/wSLcdAudgXBiYxunIJ8yrxF1CSPEZvePjpt?=
 =?us-ascii?Q?W5I+WbPlr/n+CJmrgVNhFvJK9IhPTD8NihYNZvXrdKA3bT2lMEkiWURkzzsF?=
 =?us-ascii?Q?cZCQMbl+9dF+4H4TlhnejIGMSsU8PRpD37fRpzmefgOVJV3H30C96mYZe9sf?=
 =?us-ascii?Q?PVrFXCHUzd8zHglrVlrPkCxBZzf92vG50WBSg+Bo4F3lGbXE+/RUEy5hqjsl?=
 =?us-ascii?Q?PCd+htLB8utfRkhBrN993hOnLxSHtVEdoEPUB1sG87P1VpnPzyvg0PAAK7ee?=
 =?us-ascii?Q?FFajWMQjqLlZxzropW7qQIoZDyDtKK0STTON3wwshbmgiq/gJM804YrOgC/7?=
 =?us-ascii?Q?QlqrA3WrolQSeS2oGRvTeQrHqz6Z2Krx0y2LpZE6NhooL+RKct3H7VWlWNpb?=
 =?us-ascii?Q?TlpOxOlRuMr9n05l3HtCHBM77v8x2dk5x7v6Vdmg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cb5713-fc5a-448e-077b-08db3f45004f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 13:09:39.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oLjo/OBSveZ+2eKG/RE5a388wGBSDA1kBSQ3y0ei7335TXbQmvdSaC6x2eaZ5AU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 12:27:31AM +0100, Lorenzo Stoakes wrote:
> The only instances of get_user_pages_remote() invocations which used the
> vmas parameter were for a single page which can instead simply look up the
> VMA directly. In particular:-
> 
> - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
>   remove it.
> 
> - __access_remote_vm() was already using vma_lookup() when the original
>   lookup failed so by doing the lookup directly this also de-duplicates the
>   code.
> 
> This forms part of a broader set of patches intended to eliminate the vmas
> parameter altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/arm64/kernel/mte.c   |  5 +++--
>  arch/s390/kvm/interrupt.c |  2 +-
>  fs/exec.c                 |  2 +-
>  include/linux/mm.h        |  2 +-
>  kernel/events/uprobes.c   | 10 +++++-----
>  mm/gup.c                  | 12 ++++--------
>  mm/memory.c               |  9 +++++----
>  mm/rmap.c                 |  2 +-
>  security/tomoyo/domain.c  |  2 +-
>  virt/kvm/async_pf.c       |  3 +--
>  10 files changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index f5bcb0dc6267..74d8d4007dec 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
>  		struct page *page = NULL;
>  
>  		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
> -					    &vma, NULL);
> -		if (ret <= 0)
> +					    NULL);
> +		vma = vma_lookup(mm, addr);
> +		if (ret <= 0 || !vma)
>  			break;

Given the slightly tricky error handling, it would make sense to turn
this pattern into a helper function:

page = get_single_user_page_locked(mm, addr, gup_flags, &vma);
if (IS_ERR(page))
  [..]

static inline struct page *get_single_user_page_locked(struct mm_struct *mm,
   unsigned long addr, int gup_flags, struct vm_area_struct **vma)
{
	struct page *page;
	int ret;

	ret = get_user_pages_remote(*mm, addr, 1, gup_flags, &page, NULL, NULL);
	if (ret < 0)
	   return ERR_PTR(ret);
	if (WARN_ON(ret == 0))
	   return ERR_PTR(-EINVAL);
        *vma = vma_lookup(mm, addr);
	if (WARN_ON(!*vma) {
	   put_user_page(page);
	   return ERR_PTR(-EINVAL);
        }
	return page;
}

It could be its own patch so this change was just a mechanical removal
of NULL

Jason
