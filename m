Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF436D6D5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjDDTn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjDDTnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:43:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA28E131;
        Tue,  4 Apr 2023 12:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHuLWPB3XV7IRqgMFGJLqLmNFL00uglj+8/xTre2OTGe9cilP4ZAHHIOwOPdKv+gklOuPQ2VyuJ5sInWhVHi3PlAqXl+825zhUKbDE7AFdB9p57IPGlSRx57LNJW1du2644lBaO63s+PPjV0lokV6C4kwkKiD0+ZB7Y3RUmSJCEmvrI4dymfvClniGXT2SR7U+DNFTYKIEYaLynEMVLabjE8FCMUujdlq+ZpGqgA89hpIBdUJYqf3ZLEWkzcEDx1czCjJbPwVe6C0vaCYoFehK/Ftn0ErublC0npuLV9ENrF2EDywWHoY4/wmOzZbYyoPo8Amqg9W5qdcA8Ry7QCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qapz4nlM4pl+FdBQf7W7o22a92AmaV6teirFDT0ekas=;
 b=oCahE46IbI1TmupW7b/ge02VFuBe2R31wRjRDx+RG2OLd5pMWfE5JFpnZUV5dW47Ix+Ugq0j83aO24X5uPZxMwuno7RI6dh5+ZWw7jGafcLCIsPc9uOs8lVRRDTxLFZMoseg64kQaXkalZEm50oPDxeaCHa11lY5+QvcmbGqP4jkm/UDKonQjop4M3ScLhHJhzIp7KyC/Q+eWazRRL/Ji57Q/jukSc5yOPK2Pdk7Beny9+dB7qbPkA8cnOC8Gll26gRhUF7FzDbqEYpZhjpVr4XgYJMkac/2KqLcVNmC2LCIi/x5mldTkC+ZvocEaxr9sVIgPoI7tz9cuEAbHA7+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qapz4nlM4pl+FdBQf7W7o22a92AmaV6teirFDT0ekas=;
 b=sZOvrYLaSUbP2ugRbT83rpdK1O831Gcr1m31R8Q2ZUnsziK3BPdKMqb2lcuqLYWl7L7yEvuH5w5LoIN4pagcfUGE5cJ8a/chFwSQuKTNp7WI0P8ipax0QTS7X1KSJQ8xegt4OShoj4uCki7rgpfKZIjoPfRHfmJQyxuCNcXltWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4223.namprd17.prod.outlook.com (2603:10b6:806:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Tue, 4 Apr
 2023 19:43:19 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 19:43:19 +0000
Date:   Sat, 1 Apr 2023 07:51:12 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "seungjun.ha@samsung.com" <seungjun.ha@samsung.com>,
        "wj28.lee@samsung.com" <wj28.lee@samsung.com>
Subject: Re: [External] RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM
 changes for CXL
Message-ID: <ZCgasNpBjtQje8k+@memverge.com>
References: <ZB/yb9n6e/eNtNsf@kernel.org>
 <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
 <20230331114525.400375-1-ks0204.kim@samsung.com>
 <ZCvgTA5uk/HcyMAk@kernel.org>
 <20230404175754.GA633356@bgt-140510-bm01>
 <ZCgMlc63gnhHgwuD@memverge.com>
 <D0C2ADD0-35C4-4BE4-9330-A81D7326A588@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0C2ADD0-35C4-4BE4-9330-A81D7326A588@bytedance.com>
X-ClientProxiedBy: SJ0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::34) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad2f421-64d8-4c88-62b1-08db3544d74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2ixuFaThYJKTE1BHtBsUp3oWpIdMS4HQj8MlAuxRG9uHmzkvLIVaWovd1OJ6H3bdY7gwhmD2CHIUX6pG3AW3jpRve/u548V/IZKeFRbj+3aep6yAwEqy+1SblJbDURzy5u2DDsILh0ZG1LxAOELOKqG8xOL3KgN8/5OCnEDhq3b4bfsY3qBgyCQ2IhvgiULuz1FaWWRBMWnuVQmoo38LQgN1yFlJhLcSpPPqUQMhrdF5h4k+AhdDc3C9gNEkSUkXlNORu91TfMFzUpGD63lJiz3oWmPuL1eWxeqvRszZvs5na2VjDUIyk2hwD/V/OLHN9E2hi0aQKtayd5QLx6GVXIB6An0LyvvPjDlByR/1s3Ourj6D0gkXA0T1jqZgw8/a0a/1+uAkvaoAg+Pwyl4iC2dt+cRZD7y8J5IS2ljVGuHhffMQRSm827bSRdRAlZLvrZFnPcoMuO4m1Exm46R5kXUr2CoTjL3K068yooGaIIR3JZ4sEOGDzYC2Hq60qJ2ZwLXZiWPfGDKvIzLVKJ85ALe1OIdhFliEKHaYL1xqW2lFSD6Lf0Mzpo6Rn+Gdq1P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(366004)(396003)(346002)(376002)(451199021)(4326008)(8676002)(6916009)(66476007)(66556008)(41300700001)(8936002)(86362001)(2906002)(5660300002)(7416002)(44832011)(478600001)(36756003)(66946007)(6486002)(6512007)(53546011)(6666004)(26005)(6506007)(83380400001)(186003)(316002)(54906003)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kIVB/T8Dy6ZKtEZvbEHJETZW+9xsWA3yY5m7va10oSM7ftF//lvQMvIBmR+O?=
 =?us-ascii?Q?DXgPPCk0bVvW1qJi+l7ZgTjFMu8FPMnSgMCwg1Ck++Iaxf0Z88vS8CO5Ve61?=
 =?us-ascii?Q?UR/bi3mY84NcKcWOiXUKjPJVHR9Tl6W97/HDe/8KpOu8uljPPhhi70TgXe+n?=
 =?us-ascii?Q?8wipxcHIvBsivo2XXVX27BQLdyOnKbIdRcvSpYFhoxu2b0pDNp2Go0zRzefn?=
 =?us-ascii?Q?iguIsWierERWJftNbJeA/dWRZFs3OdqEn3LuO6maVJnhnpBrQN8gdFsy6upC?=
 =?us-ascii?Q?KHNMXv9zdeRF38no8cjJMS6T/wJwJNSOghaQwXO0tHI4HaO+csOJxwfHQdiU?=
 =?us-ascii?Q?saG+2EbBxPTN518YT/ik3RuEIMSvh2952r0rt4s6UufaR5VtBjoNaCE7mLCd?=
 =?us-ascii?Q?5mPHDFXY8sNXOpOZF5CYmfecY+Av+tnkZzSY3K2mt9YVJcD4T5gYO4yBsNBV?=
 =?us-ascii?Q?BHumAQ+iFnHBjVjASwqNR8Nr5QDE9KM0gmXwtPAkpcCdbhxqPgQyCtFscWuG?=
 =?us-ascii?Q?OHCUNbMpQ1V50Obe6MTXNcw+SUo0NeileuErBVaNzQxHgN1P+pElzZOtdF2D?=
 =?us-ascii?Q?qOqULrSXkntqpuAVfFecXf26XETW4JoSjDDs4cT/60RvENi9bL1ojNp6NLwW?=
 =?us-ascii?Q?2qTRRn0o3scPRWNaYVsMq0rI3dm698CHyN148MnKFb7YZn6q1rS0VrmhO0Vy?=
 =?us-ascii?Q?aeoGFEMS1C8irMZFEzzDX4vJr1Vhu5KTcbWEz1cAhhSl6mufjK7dLADjB2qC?=
 =?us-ascii?Q?m8/lIf/96G75G+k437AJRDlcSz9uQ4U8T3t7+J2fa99iO9i59TlgkXFa++fj?=
 =?us-ascii?Q?e629kpscbagYpkwkeZse12f2svjHC2DbbVxsRbUF+X2FK8P/8dXwPy0TjnyK?=
 =?us-ascii?Q?C/UNnjDIH0bcREhUPWRnyUbMbX2FP2Ezm7nnDt/r9eXaxRwQGuyaTuyGuqS0?=
 =?us-ascii?Q?F6VILSU5mdT1jqn0xibXTl3Vc3kD/vqlwZuCoPPoOLk9fYvL+JnR3wcadg6r?=
 =?us-ascii?Q?mutR7LgSIV1cQCPIkgOeGqTToqOLPhtLBxPIyCjmh1MhcYHkTrBU+iQ7Mvpm?=
 =?us-ascii?Q?OaAxwMNmKeOeHmd9V+yBoIdcCdkahICe0v+iwcqhfMb832W2TOUgxM4jLyHQ?=
 =?us-ascii?Q?3au4IvJ14E4cNiKbUfAAwuwVlhgVxwwkMxc7TcfwC5tWrF9UTOttMzwp7Kip?=
 =?us-ascii?Q?7obgsDqng++54MM4y+brvBaBa/Dn6wiGdTyurDWBqi3UY2LU1kmnxRROVU4t?=
 =?us-ascii?Q?2vrZyiONeJ+tZRfBX1yqQVO3j03EjG0FiiJC2wsaodUVoZfwUJXC7gJTEW9Q?=
 =?us-ascii?Q?heMd+yC3bE6cKKTSgVQU2btWgvGuzlgkDU49VbdL4LAVONSCSR/djFwE7MUA?=
 =?us-ascii?Q?NsW+YtfFF6+xLbodTkuab6x5qvye+pm8EfPBNZnUsqDvwKATB3y+85o9QLhF?=
 =?us-ascii?Q?DYClPUdItrKB9NIbF6JECwPoJrOpKnNTOCUrhT2U3MTHdv1XIPrgFq11qW5+?=
 =?us-ascii?Q?5I0ha1UYNJxjhtj/SHz+H/wY2MRb8mpwe//x40yw12FrpFSNfUbwxV4ZQZXZ?=
 =?us-ascii?Q?7FdK1OfPrQhIVW3VOS/7J2olfvJQiIUXRslpjjwrnk2cZFoi6Asaff1hTKrQ?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad2f421-64d8-4c88-62b1-08db3544d74c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 19:43:19.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aH3clZFPWanMivNkWJzyUJvOBJiygMYfTkIBynzmu7y4XibK0hRohes6EC2EZLJOjKdI8Qh1zHDqi6mpAp3dFZuS2CF8fCJFIVDMu3TY0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4223
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:59:22AM -0700, Viacheslav A.Dubeyko wrote:
> 
> 
> > On Apr 1, 2023, at 3:51 AM, Gregory Price <gregory.price@memverge.com> wrote:
> > 
> > On Tue, Apr 04, 2023 at 05:58:05PM +0000, Adam Manzanares wrote:
> >> On Tue, Apr 04, 2023 at 11:31:08AM +0300, Mike Rapoport wrote:
> >>> 
> >>> The point of zswap IIUC is to have small and fast swap device and
> >>> compression is required to better utilize DRAM capacity at expense of CPU
> >>> time.
> >>> 
> >>> Presuming CXL memory will have larger capacity than DRAM, why not skip the
> >>> compression and use CXL as a swap device directly?
> >> 
> >> I like to shy away from saying CXL memory should be used for swap. I see a 
> >> swap device as storing pages in a manner that is no longer directly addressable
> >> by the cpu. 
> >> 
> >> Migrating pages to a CXL device is a reasonable approach and I believe we
> >> have the ability to do this in the page reclaim code. 
> >> 
> > 
> > The argument is "why do you need swap if memory itself is elastic", and
> > I think there are open questions about how performant using large
> > amounts of high-latency memory is.
> > 
> > Think 1us-1.5us+ cross-rack attached memory.
> > 
> > Does it make sense to use that as CPU-addressible and migrate it on
> > first use?  Isn't that just swap with more steps?  What happens if we
> > just use it as swap, is the performance all that different?
> > 
> > I think there's a reasonable argument for exploring the idea at the
> > higher ends of the latency spectrum.  And the simplicity of using an
> > existing system (swap) to implement a form of proto-tiering is rather
> > attractive in my opinion.
> > 
> 
> I think the problem with swap that we need to take into account the additional
> latency of swap-in/swap-out logic. I assume that this logic is expensive enough.
> And if we considering the huge graph, for example, I am afraid the swap-in/swap-out
> logic could be expensive. So, the question here is about use-case. Which use-case could
> have benefits to employ the swap as a big space of high-latency memory? I see your point
> that such swap could be faster than persistent storage. But which use-case can be happy
> user of this space of high-latency memory?
> 
> Thanks,
> Slava.
> 

Just spitballing here - to me this problem is two fold:

I think the tiering use case and the swap use case are exactly the same.
If tiering is sufficiently valuable, there exists a spectrum of compute
density (cpu:dram:cxl:far-cxl) where simply using far-cxl as fast-swap
becomes easier and less expensive than a complex tiering system.

So rather than a single use-case question, it reads like a tiering
question to me:

1) Where on the 1us-20us (far cxl : nvme) spectrum does it make sense to
   switch from a swap mechanism to simply byte-addressable memory?
   There's a point, somewhere, where promote on first access (effectively
   swap) is the same performance as active tiering (for a given workload).

   If that point is under 2us, there's a good chance that a high-latency
   CXL swap-system would be a major win for any workload on any cloud-based
   system.  It's simple, clean, and reclaim doesn't have to worry about the
   complexities of hotpluggable memory zones.


Beyond that, to your point, what use-case is happy with this class of
memory, and in what form?

2) This is likely obscurred by the fact that many large-memory
   applications avoid swap like the plague by sharding data and creating
   clusters. So it's hard to answer this until it's tested, and you
   can't test it unless you make it... woo!

   Bit of a chicken/egg in here.  I don't know that anyone can say
   definitively what workload can make use of it, but that doesn't mean
   there isn't one.  So in the spectrum of risk/reward, at least
   enabling some simple mechanism for the sake of exploration feels
   exciting to say the least.


More generally, I think a cxl-swap (cswap? ;V) would be useful exactly to
help identify when watch-and-wait tiering becomes more performant than
promote-on-first-use.  If you can't beat a simple fast-swap, why bother?

Again, I think this is narrowly applicable to high-latency CXL. My gut
tells me that anything under 1us is better used in a byte-addressable
manner, but once you start hitting 1us "It makes me go hmmm..."

I concede this is largely conjecture until someone tests it out, but
certainly a fun thing to discess.

~Gregory
