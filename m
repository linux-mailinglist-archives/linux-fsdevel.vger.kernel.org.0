Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864476E49B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDQNRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDQNRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:17:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA159F5;
        Mon, 17 Apr 2023 06:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW/3K7N8L57R5flZ4zLp0Ic0rObTQY3ao2c0dGpKfswNwmOMZ1FAfsl58on1tafCll27GKw5jfCBApBZhSH6+bYkaf3TUjPwkN87fJO4bwiS9OVligvgqm335dg3TDGjD+on9j0T0mB3Cmp2ndG8Mbz+YQ3KMhlsuu6FSIu3g2SXLB2RrqJ3wlBQGTiw7cu5sl8vmtV1Re4oLsSdzy1FavQ5zc97VSzuuEeAkUJQIyCS5K0FN7xoWxE0SFbZS2Yfieny3wG7jOlGsjeru/fgl+9YSu6+PbSI7nHvKeSWJhCKsFXCzGfBCPD5IDxODIajFSLEuvI3MccNNTQeuFkQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0FEAmxqklWslxZKI1x7KM+olSXQnnNkgHn9DnVUrfU=;
 b=F5XzLRgRtK22iEt195OZ47d47KzLSxLBZCpYKYEClfoX+KqcXxMU7WGgUJvIoQ1jnuHmZuS1gmJnJpeV3NzbHTeiMdZBOVvUoUOM2epTjKiFV+s9EbS/P09sWL9qsHoUQ7DsTA0YndyBCUPUxf/1vunziumyCD0+pEmTlzKd6NMkjpoY765Fz+/kde7gdRwDEaVJt+8FGI0NX5y11rG/jb2PR9wPBEyNRGZGjhxbmcRN8pGQcbVf2qIt7fJoG3YdVlKLfXQKT1VP/42O5T7iPX/ybO6QHZUXeojNMx/3cc56zocgPWLpWAamtqKwn2EY3ALXmUf3td5RU1Q7YPp5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0FEAmxqklWslxZKI1x7KM+olSXQnnNkgHn9DnVUrfU=;
 b=nc+7buMxjVa17ZqW2COfHWCV5mrekKZBG08AIKb49Olj+ByRVijUQpJkT5md43r8pDpPTs1r/sa8LfNGSoLTUKVDVFFtEWvfehDC29j+Ux1nJlf28k8ldDzVu90rvS8IuTwgskBwfrv66rMkwHCNZsch6p/r+v44JnGWF0V0SobyBplIFTG810M1LTAOjbiyABlA6sID/0K00uIUNfkaNw8cKGwhOVcox9bPdZtMvkSnIa4p5bg9lHc4KEHQSLZRbdbcl7PXasbvYwOYch33KD69Pq9QiK5Aihvr87sErNg3GvxUpZ0mnWn7zfwfIAUcFw6fH93+yaMBYP8d7HqenA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 13:16:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 13:16:30 +0000
Date:   Mon, 17 Apr 2023 10:16:28 -0300
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
Message-ID: <ZD1GrBezHrJTo6x2@nvidia.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <5a4cf1ebf1c6cdfabbf2f5209facb0180dd20006.1681508038.git.lstoakes@gmail.com>
 <ZD1FECftWekha6Do@nvidia.com>
 <9be77e7e-4531-4e1c-9e0d-4edbb5ad3bd5@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be77e7e-4531-4e1c-9e0d-4edbb5ad3bd5@lucifer.local>
X-ClientProxiedBy: BY5PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:a03:167::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 589d09a3-bfff-4146-a6b8-08db3f45f522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWgN6FZ4UgZGpEjRi80WktFV1KCa8tiqe/2HR5EIQMAl7sybVGADHIfao8kX71RRiXgUHJKl7JEglA03LWTWaFHN1uq80XBg6w7qqhHVY6df4vFxhmB1w+/e2rrio17AeokKDUwc8uoCsPeFhsMpUcNTv4/i8Tzfr+4DrmRaCTsqzSXJS/JiUvoRu7K7lTIUPGnRFNDqRJ3iYbhdjlhBHjtNMHs5h1fUw03ygP0Zi741mERozD6Cz5f42Dil0n7mdYPrFAbvxWybH1M3djdSVMNeyEKWxoVpPf9P79OaxqjudQjZtwhCacXcP4wA9mFjp+1wbrc1o9TqCDIB8i60t2ZUpr1de6H0n5u5Ew3QYEIYPJ6UV4jEUg8inO6/2SqQY0EXhjZZDpACP5OnqB1JW6wcDqoXLGxchU/RrnSpoqsMqcw/Ave3iDwpGlXttfLdKLJ6FIZXE4hpO9wFwipg87QFD3YUis31ApTPcM2K3DOSQEO0FHaKLG3pM9Q5mVngSQUQqu/T3QbXrtl9x41CrtNO+lSFzbrG9I7bBcDoBs9+5Q3twx28dQwaez35oPfI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(5660300002)(8936002)(54906003)(7416002)(478600001)(7406005)(6916009)(41300700001)(83380400001)(8676002)(4326008)(66556008)(6486002)(66476007)(66946007)(316002)(6506007)(26005)(6512007)(186003)(2906002)(2616005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wTY1MJE2OMH2IL21PsL74H2UiPTIJc7xYsgEM/t6/ICOob8Zbx+esbYO9D3p?=
 =?us-ascii?Q?yhZ2ZaI6BarizkqaYSgDfjlu7Y7XkhDbfopU2Yu93IFlY/mcBg5XjLyNzlpH?=
 =?us-ascii?Q?fiTL0l9FtZW/WTy3iwARAtY7mWA01U6AfGQKZuagqF1t0Fwdl9hspIfBLb6G?=
 =?us-ascii?Q?LBR3NRzFNMEEvgXt5/negutzMsCti+kc3dFlU1Pth9Pv0taarn0qUe0vuzkF?=
 =?us-ascii?Q?3w/TdM5CR6fZAmLMIIEtQEIhy6ry7CCyhbVsuFMGO90Dd7E19F8A+n1r7pCC?=
 =?us-ascii?Q?A/ifuko8Gs+MXBiJR/rtom7QuKvcKwba6gieZF3T6Y24pLXh7Wwkgjqm9ZKZ?=
 =?us-ascii?Q?xdl7L6VUFql3m/JQrXlfd8ceKoYP0GJokkoJUjroFskEjANNfUopBdT+HISs?=
 =?us-ascii?Q?CiT7emTzlEGBumr1vBZIgEnqwDZRHFuaIN5KI2J3lqyF0dnKZ+5PpRT5y/14?=
 =?us-ascii?Q?n/xV7EtRjIKKX5q8UfdA3oymTpr+7AUCZHxq/J18prDplNhtkbwhDnyb4AYo?=
 =?us-ascii?Q?vJSVt2GEQIIcOxyciYIdNbZzuqcWsiOaNBh6Y3MYVUxY7hK2HlY73yYCxWQ2?=
 =?us-ascii?Q?90vfDfrRxaQf+IKZ5ZLS31QeWZT5mbY25Q/bn5a9RfGf0h/oJuVfjEiL0Wc4?=
 =?us-ascii?Q?VRY8Ay1OPYiwO1qg12/cZw/4kkdsLywY02Cx+uRCdd4Qr5fP+eL2Vqp/6qQH?=
 =?us-ascii?Q?MljTVzPsicEy0aVu5pdnSFJsVsx+SOG2ilmm938ZGzGb771a5nCVaJvhFAbR?=
 =?us-ascii?Q?R/4OoMcPfRG/mj2xGeN48ZlKUFb+rotwb/LRB0jMHvMVu0xBqRG4iZ+j9Lxo?=
 =?us-ascii?Q?7UBILzEFFQAvUfKEFiCjeLqtYT9QV6hdYGHUq5qvH774d9gXSX12QGpSPMnp?=
 =?us-ascii?Q?/F7+rmcoK0fsIPJt7DSrPHT7dGyWRoXchF8atenqMUeyw/H+b7I8l2M+NBa+?=
 =?us-ascii?Q?i0I+NP6f9km+2TBq5HiO+WxAoqvFDjAHJHnkowyCuh3h6UQPWV/sUwPz6nxp?=
 =?us-ascii?Q?OQv4lWDyRyOvBvlSKlACOsQbx4QjRij+xoj9MP8VeF/NxdQ3ITA5pnDbST3r?=
 =?us-ascii?Q?HWRg2g63i2qlh/cE1udbO4MqHaZhO6uSXt/sZG9u0mr2ZeuxZNfXa3bRYH7a?=
 =?us-ascii?Q?Z5JZ2pHtbBAx1KWpNS6gJGgizMPyle40ifyLuQcjrcUhymq/Pqe/p3CmT7jt?=
 =?us-ascii?Q?kCLlg2HYpZtEPzV88rvreFfmUElVxHzdz+M4IXliYcZ8OmgOc684i4fklZ/I?=
 =?us-ascii?Q?ljOGSiFEogjPqWJ+mWgwoTviS1ySndplUQsEOSNAv+IIVaVS04Bo0Vx8p+Cc?=
 =?us-ascii?Q?9CDDYBBg45OxP9zszXUWC2n2CBUCwxFASl/RsRcTxIclAlNZd+k/DSG+kXWT?=
 =?us-ascii?Q?r4yBOn2WnTeCWcEjMyJ5AZw/AM/cI8hbSbFUyv/VAr1lGdHBnavTGm2S6iiE?=
 =?us-ascii?Q?URIBvJ+5+23HlWt0ELP7JGptetM8t6RQlxa0aPHm2FmZKAQ8SBEZLW5m3ULM?=
 =?us-ascii?Q?fdOY1QpGgeD1oX7BgiuZo9qHNxp01wK01GPFAhE5BHr5083BWlD2bWzcip1S?=
 =?us-ascii?Q?zzrjReNBLnAWiwiYftD5UbbVG9Nt26peWlMuZps+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589d09a3-bfff-4146-a6b8-08db3f45f522
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 13:16:30.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj2oQWNa9e/i0aZEoojiD3NBRWryBh5GjkS3m/diDuhnYfMbM4xSM2g5GDdLDyoK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:13:39PM +0100, Lorenzo Stoakes wrote:
> On Mon, Apr 17, 2023 at 10:09:36AM -0300, Jason Gunthorpe wrote:
> > On Sat, Apr 15, 2023 at 12:27:31AM +0100, Lorenzo Stoakes wrote:
> > > The only instances of get_user_pages_remote() invocations which used the
> > > vmas parameter were for a single page which can instead simply look up the
> > > VMA directly. In particular:-
> > >
> > > - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
> > >   remove it.
> > >
> > > - __access_remote_vm() was already using vma_lookup() when the original
> > >   lookup failed so by doing the lookup directly this also de-duplicates the
> > >   code.
> > >
> > > This forms part of a broader set of patches intended to eliminate the vmas
> > > parameter altogether.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > ---
> > >  arch/arm64/kernel/mte.c   |  5 +++--
> > >  arch/s390/kvm/interrupt.c |  2 +-
> > >  fs/exec.c                 |  2 +-
> > >  include/linux/mm.h        |  2 +-
> > >  kernel/events/uprobes.c   | 10 +++++-----
> > >  mm/gup.c                  | 12 ++++--------
> > >  mm/memory.c               |  9 +++++----
> > >  mm/rmap.c                 |  2 +-
> > >  security/tomoyo/domain.c  |  2 +-
> > >  virt/kvm/async_pf.c       |  3 +--
> > >  10 files changed, 23 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > index f5bcb0dc6267..74d8d4007dec 100644
> > > --- a/arch/arm64/kernel/mte.c
> > > +++ b/arch/arm64/kernel/mte.c
> > > @@ -437,8 +437,9 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> > >  		struct page *page = NULL;
> > >
> > >  		ret = get_user_pages_remote(mm, addr, 1, gup_flags, &page,
> > > -					    &vma, NULL);
> > > -		if (ret <= 0)
> > > +					    NULL);
> > > +		vma = vma_lookup(mm, addr);
> > > +		if (ret <= 0 || !vma)
> > >  			break;
> >
> > Given the slightly tricky error handling, it would make sense to turn
> > this pattern into a helper function:
> >
> > page = get_single_user_page_locked(mm, addr, gup_flags, &vma);
> > if (IS_ERR(page))
> >   [..]
> >
> > static inline struct page *get_single_user_page_locked(struct mm_struct *mm,
> >    unsigned long addr, int gup_flags, struct vm_area_struct **vma)
> > {
> > 	struct page *page;
> > 	int ret;
> >
> > 	ret = get_user_pages_remote(*mm, addr, 1, gup_flags, &page, NULL, NULL);
> > 	if (ret < 0)
> > 	   return ERR_PTR(ret);
> > 	if (WARN_ON(ret == 0))
> > 	   return ERR_PTR(-EINVAL);
> >         *vma = vma_lookup(mm, addr);
> > 	if (WARN_ON(!*vma) {
> > 	   put_user_page(page);
> > 	   return ERR_PTR(-EINVAL);
> >         }
> > 	return page;
> > }
> >
> > It could be its own patch so this change was just a mechanical removal
> > of NULL
> >
> > Jason
> >
> 
> Agreed, I think this would work better as a follow up patch however so as
> not to distract too much from the core change. 

I don't think you should open code sketchy error handling in several
places and then clean it up later. Just do it right from the start.

Jason
