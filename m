Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0B6D6C86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjDDSnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDDSnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:43:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E8CA;
        Tue,  4 Apr 2023 11:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX8pp1HOwXVZI9PYiRKCphdmDi73IcrTE5PHTx14F/THcDsa//OL7ZAKztv4g1h+l2SRRXEif5sjXxxSmy0vUCuoips8y8NABNYoi8ykxFGwSz2/t9Zc6uz0bujzuU9WcEExHLE2maMSHiA5Xvz58n3twaFkzWMo4xP/3VrZ8o0A0KZZSBrmVDaUKm5hRek9HRWZb5g/xBuSMPnA142pZA8zMDP1Rghnk1ceqS2hHcvuTBZGVbrGl5DfccM7+fL87nqC0w1Em8jwg1Zowlcio9lgk5Nl3R7QomDgzHYt6nYHeps8KZldlI4cvbURqIlX+d0EezpoHgPXADPGRHu9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21n95Uiv5sjjWj/vt+ANxyxyx50O8SNGVVvA9PntyRo=;
 b=fi0F7dfTnRYpx5ARayhjsh4KikClU141nrPY6YlkYXzV3h3HUSkgeltvKMDmMZ1hXYvStUlfKAknF04/UkGmq8hqWK9LRAmgDE5uFvw+SsP7nzM3JsjWLU1eg0qGrSdT28zLAv19QzOYUxsWE49ybngmFD3Ts88zfurXNn6EE2AkOgODG0nm+oYrSyivQf4LG2GZaD2nADloQLagNasXpVB01QtnEcH7qkRl80w7f7mBOklK9PBGCV0/7HcPm7RBnPKwmKGvi5rk90u5lkfeahh1wbMOHQlcQgs27m3+5+W16lVjGcy9iaaVpS+7tXvpQcIHo6qp7LnZNwM57EbGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21n95Uiv5sjjWj/vt+ANxyxyx50O8SNGVVvA9PntyRo=;
 b=wqS2gOChmuD1LkLqhEB2+4yVZrm58bOnZFZLb3Ew8JrkPpDQjjS6Ny7gGDhS1fDNTNHFpH/aaCjKim1gfaLdWheQxLbThcMoDCjrH8QgJU4HTRK0zFKsLXYB6BYTSUmdKKfzuZ/isrrfRq4tOdziSJyOue/Dkncrl7dqNaraEpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4728.namprd17.prod.outlook.com (2603:10b6:a03:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 18:43:08 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 18:43:08 +0000
Date:   Sat, 1 Apr 2023 06:51:01 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "seungjun.ha@samsung.com" <seungjun.ha@samsung.com>,
        "wj28.lee@samsung.com" <wj28.lee@samsung.com>
Subject: Re: RE: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Message-ID: <ZCgMlc63gnhHgwuD@memverge.com>
References: <ZB/yb9n6e/eNtNsf@kernel.org>
 <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
 <20230331114525.400375-1-ks0204.kim@samsung.com>
 <ZCvgTA5uk/HcyMAk@kernel.org>
 <20230404175754.GA633356@bgt-140510-bm01>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404175754.GA633356@bgt-140510-bm01>
X-ClientProxiedBy: BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::32) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 08768328-a658-4da7-5919-08db353c6f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1htg0lOA28eQ7VO0kTOOTRuJEOkRsnUQGNk2GTOpVso4m/acuIsd5aBOP/YkEIFa8Xicmjf0AaUJbhM7AVZFfgTUELAWaTzuCCguFEzTMymq1e72kbbTwOHWiMA77kaiN4QMWWUBSHpC8XxRhWnIKUoefx44N8hu+YfshKsdSRrrKTrhQk9aLEhA5TXWILFlcR809Gi66dVf2KNrw19Vi6X/UQ1x4xfUCcvgNgDmzVpegkhCGUDp5EpRzAWWZVymd3tVwrmnWSO/Jkr7GrxQhV0Uvv2eLCBM1YwLae5A6oHE3TlvDHvO+qcqYwpn8sTBGhVQf87ZywYAwb9tx0ohZ/OnwdTd0FaN2gcaVXsa65hMHXaOxLqGa7plRB8N85mzZqveMzfjpwcndrBYfUh3Ox3Om3GDREZ3GqV017dXyQUW5G7fy84ewNLP8B4JhtRkFeVu87gvV7mYiaLjI7dspcB9KRav9PCQEEWMqS9rzSmlsmWK7x+VFrQ/2IH6t8xw5ZnsGqAgFtNPXG7hYz89511Ek3rbffla44vDo5NOIoKDCVR4jedUWFixloRQaRg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(346002)(396003)(366004)(136003)(451199021)(478600001)(54906003)(316002)(5660300002)(8936002)(36756003)(2906002)(7416002)(86362001)(44832011)(6916009)(4326008)(66476007)(8676002)(66556008)(66946007)(38100700002)(41300700001)(6666004)(26005)(186003)(6512007)(6506007)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RNb8s4+hP2D6FPFhbWvo4Z/bV0d0hGmbjP9s/rI3Kb+rhJkaJJu4luYQY3TT?=
 =?us-ascii?Q?RyU5xAG5fW5XvILBS0BRb23msocoXrQpnOU4JPnj5LQAVxTiIFq85DI06eJy?=
 =?us-ascii?Q?48r+TTRha1U8W4LVbBGFcJKMKGjjlTpWQBpQEuBkZapK9NLwV6icZjuee3dk?=
 =?us-ascii?Q?HaJqkFphHxrSFo/fRlKNulsltxl132JrFS1iroRrM38KbobxHTfHdT3LW11z?=
 =?us-ascii?Q?zB/OpXhEsO6O4YBrvoW4hSFeEhCnmUlh5sNM2pjYp9vTZPXJ9Eo/DDLyaoVF?=
 =?us-ascii?Q?CobX/Bnuvj3Kgaq+svvYUi292W/FIhNnWMyESZSWMTaSg4p/c5bOJWUGceYr?=
 =?us-ascii?Q?3rngmD3GYimGmV8Wj9DFJPqZXvz/6JQpeavxY7rmf3Y9bHgvJhHWuLwy+/59?=
 =?us-ascii?Q?vTemEb8vztVn/myPcnsArrPrtobT+JV0me+Nu/isO8E/4cCHdKVX3GvBX6zi?=
 =?us-ascii?Q?R6QoL8fdRwPcPFrQljZr/uD3qWVTNJhUowA1ADAvgqwj6IhZDYj8bYkE2/4k?=
 =?us-ascii?Q?k/tfvbTzhNFGwNeadPrkWgN6BKrnsnvlzIfKyfltu+bq7QaoJsA2tuCkyxjL?=
 =?us-ascii?Q?jMqV1dFSaB3DYRicjRg3fll1ThINJui1zbIuTdhNWPt0xPUOHg+n2fw5i7p0?=
 =?us-ascii?Q?qRGGCvqXbmxJ3PWak59zYfcTguNidI+lwP8p16YJHLgYC30xMCuyAeBYQr1V?=
 =?us-ascii?Q?dCbhTatnGosxAJQsPrjIhnRfbHZXOthFyeYmEFvyJZvoakL/ezeY55qE0NtK?=
 =?us-ascii?Q?+eaEwdasqgjUFkgeULK1ibCW8XfMGI1dNDFEzjg+1jRcP3N1FnNm0AqDxYdG?=
 =?us-ascii?Q?0WUAv/AlAC9EfbpVxqld9As2causvRWLYa1zKmAHRx99cN22rOZUpQpBQ7T1?=
 =?us-ascii?Q?TRInqTPuSk4zp2HY3HaVwSDYpbhU7gQd5y0wEVgva3IuzUpKKBZX1FHubyhp?=
 =?us-ascii?Q?keFXWa/Mg0odaUG96z6C52GRKNxPfgJKUF9BBEXin0ALSoFEnvO14AQI0qXL?=
 =?us-ascii?Q?qX7scbyEe3zSvHLLpm2w9xK6HiYaBt1vNmz8VgzU3i3EPifAdYDm4WqIBxvL?=
 =?us-ascii?Q?ot+dLmDQ8k3KJagYZY9UtYxcM1lmfEy2oZfpSxU3ky1Z0d/pY+ASq4YGyvjI?=
 =?us-ascii?Q?lZtM2HGiA2zJpLoEonnNbYWi+tUvWdA5zEu+Do2xAFjHX4AYfNMjC/SsNvt4?=
 =?us-ascii?Q?YTTHqm4JRYiQuOmnEaPszO4H7n+tkHtsyw6qz+GV7/tuykR7itkTKr4ujdMn?=
 =?us-ascii?Q?xq7BWE7/HpTosFKDjpw6abQwRcHBJMO5jELBnarKsna9VruOfNgjtkVv55K+?=
 =?us-ascii?Q?71u8Tx58NPS2rZqDaZ+DWwDNlhCj7EsIz9wvTVohPUV+fmIVxqQNlGHQK8iL?=
 =?us-ascii?Q?4gSBKOA8/7dM7LXTmPv3pO6w+UYhXc1pk2b5kCbISSJUxQBe/rSNHCkBG0C8?=
 =?us-ascii?Q?nEKo4rtZ2EQJE0XHSTW2AC8MC/xGyBSCEMH+afmzmJdiUl1AHx22QvZfbNAE?=
 =?us-ascii?Q?P1Dis0F7LdrAAkFk5qyFndpaUYduWiin7wEdH5EP/WJueo7L+ZaJb1d6/VDd?=
 =?us-ascii?Q?wCUq+TINiVlP8HJN7GqonAqdTZIq3CzR7ynRFepv2zISDUHIV52NoCVg6eKK?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08768328-a658-4da7-5919-08db353c6f17
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:43:08.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpEIX1CZ82jMrMFEdK6yDh1kfIzFBPVY96fSGVrdGpXZU6/zcm/XdkT5yi7+4DaJKhTYWx2qnzJvx6cJe8PYmXaveq+eGeXrbvXJ0OcUPts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4728
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 05:58:05PM +0000, Adam Manzanares wrote:
> On Tue, Apr 04, 2023 at 11:31:08AM +0300, Mike Rapoport wrote:
> > 
> > The point of zswap IIUC is to have small and fast swap device and
> > compression is required to better utilize DRAM capacity at expense of CPU
> > time.
> > 
> > Presuming CXL memory will have larger capacity than DRAM, why not skip the
> > compression and use CXL as a swap device directly?
> 
> I like to shy away from saying CXL memory should be used for swap. I see a 
> swap device as storing pages in a manner that is no longer directly addressable
> by the cpu. 
> 
> Migrating pages to a CXL device is a reasonable approach and I believe we
> have the ability to do this in the page reclaim code. 
> 

The argument is "why do you need swap if memory itself is elastic", and
I think there are open questions about how performant using large
amounts of high-latency memory is.

Think 1us-1.5us+ cross-rack attached memory.

Does it make sense to use that as CPU-addressible and migrate it on
first use?  Isn't that just swap with more steps?  What happens if we
just use it as swap, is the performance all that different?

I think there's a reasonable argument for exploring the idea at the
higher ends of the latency spectrum.  And the simplicity of using an
existing system (swap) to implement a form of proto-tiering is rather
attractive in my opinion.

~Gregory
