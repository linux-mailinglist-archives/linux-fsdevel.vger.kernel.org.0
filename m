Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED31A5A3124
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 23:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbiHZVgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZVgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:36:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CD6B160;
        Fri, 26 Aug 2022 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661549769; x=1693085769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nzERY3SEpmtWN6Kr24mLF+W2usypi8TQFtNtEfzs9jo=;
  b=KOL6xB1lGN/gwAs4UfpdqIuyHbalTM/kafJcB0ledvGkXkJzwruwRLH+
   fdKYdxTJFo8gipVnwTO7vLHcCO/GhXfCbpAzYRj+6bLK5es8g63nGx1Jd
   jQ3juJllUs868rA85lfYrh8xtQDUWubkAmp1xpL4galyJjxG+9BI+dKGx
   VFLsVoAYBGahmzhW7aCULdSMvgg2ar5ezkMVvLw4BWzE5LyVdWNoCGxh8
   GAsYAfGdUiBZxqM/IoqAE1oM6BHMPiL2H2f1JOufVO5PkTf29LQIkotUD
   7uOq2bnIvGzno+BlP6O6f8D6J5ms5a/aXpOLijKQAwFDCr13FVJQqZSV3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="274350347"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="274350347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 14:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="753006952"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2022 14:36:03 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 14:36:03 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 14:36:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 14:36:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 14:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egohwYQ3yupz4aqd9izWHI2KqPi9MTSaLvw2/hPJ7SRm/Vtx7ABpHR9D+vX9uFthKgN51pffA6S7Fc2xik1VhAzSrNeceG6taM+id3NEUI4MXK7NwstlMt5fOtZqTSMcAp1JImIUoTwti3RuLxsmLrP1YTfVxAH861wuQTAqqGrjbLcsYcZ6QMcz9sORpKE23Fh7AAfDJkrgUrhhJYIidiff3cRygAzyyZ5QCvMEvXbVeWnCGfT0Kge80jSVgJkML9Vvet6KGM26ZCCoqujcP4Qosbu97SR4mfPfnNfcTfax+atiVuHhxbOAUlb1cMM+QASApAgjlQIX5i0t0+ZtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TfOpZV6bYYsxFh0znZCZhD6CCXlC9MGzMlLWvxS2B0=;
 b=YhYOlc30Ra2R+Essdl2rBS17fgT4k8GEeeDFF6w7YhTxR+En7qidF1hTv9nMWBhS00BaK6OYN8Rh5zofrx9KeAZWkTohB/Pe386KPcvZwpW+Z/CMque2wOosA2jBb975oVkB7BnczCdTQ1k0PasM3LqnUeaWGn1ky5nZzIfblSVqhwu8i/ng8S8QOmdKbjl/zFgltNH0GThSgKCuUYbs4d9fhhJJTwQQ6b+pXwi6FNNvBe9v1fS1X+QVOKsGeZZ1eNoe0s+nTW5hHPe3AxlO3T3dCt9zVje6C/z+pjYpsNPXxh5uqWvELs1tjnbcE5X2ovXYbAorssaBsVWHKzqBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB0066.namprd11.prod.outlook.com
 (2603:10b6:405:67::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 21:36:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Fri, 26 Aug 2022
 21:36:00 +0000
Date:   Fri, 26 Aug 2022 14:35:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: RE: [PATCH v7] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <63093cbd43f67_259e5b2946d@dwillia2-xfh.jf.intel.com.notmuch>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66210e9d-53c2-4ff6-87ad-08da87aaf7d6
X-MS-TrafficTypeDiagnostic: BN6PR11MB0066:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLRyIMW2KiIQW3UhcD/JERe+3S1FfbBOIW6xtqUSJn++6LQLaF4roDTzEWuven0ENOLeWek75KlwnnBqZzhb5LA2N5MCVci4NW/USixe09aSmOxlONCtTTqmBRZ7jh6vp5T6lAz+LUf+f87tNBtrRjKSBR+ASQEBxYa/rXqpXTcXE6jPFqJ7A2XQ40bTXw1jZ3kFgailVyNxZBvoGElgRGOWf0oiwHQsoJbsk1K6Z1J1OnAXOJSkKjmIDeKXRD9ENSPCBKaYeWwrcm9hBUbmGQ53TJYnw9OQ20oQPd2XYeAnr6W5ZAAn9YO9D/HBoAOQiGQwqUDatz/8TqXb7jfNEggGfqiRId97c/CqwOuA0Q7jnYh/+mdK5lV5l/Ao3ZVts9LtjEk0Ap4QSsJ0jZ6yCJ9U0i/UO7SYIfRsHlTCRuMz7RYuEDd06VLd1zRMj95Ek7zHhwOPPHZEZRGUecmAKFZxSgFJdoh8ot5nIowCMueywVjs1RPSSBio3e6QNr8WV/zwejs+kAEW+E1KEYYZAqJbCgXIzVla15hdsU2s7Vp52upoT0WmDro9/2MOA+C+0fAePyVkrZJzHLo5EDU+XYQXPbzQJtm4rd0tlDFgxsyAY+w+KH9h8RNgBDkejZZXYZAuFCLYa1AATnoq3GH4ddXuljZ4kA3YL0aMxdzRRKLX2Ezq1xhGuwvAcw27ZS1uGIpEVP3A5pnR/s4O5LMZBkn64RfstbDLM6FPZ9n2oAh2jxllz/Oi/ZQldQQtxaEmcuIfO6m0hBHZRolAukE29Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(346002)(366004)(66556008)(38100700002)(8676002)(4326008)(66476007)(316002)(66946007)(7416002)(86362001)(82960400001)(6512007)(6486002)(83380400001)(6666004)(8936002)(966005)(6506007)(9686003)(41300700001)(26005)(186003)(110136005)(54906003)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzFYVBo9PORbai9krsOjQcL8J14PmGph4Lc8HslH++akyKsLCX65SMeYnA6B?=
 =?us-ascii?Q?OsLH9tp5hG5C8davUfXOmtHZbO+5xBjgs3iyAwYbBvpyVmaOWy+X2jluFAVL?=
 =?us-ascii?Q?7kW+LkilXJGHsS6kl9humx4HMcbvUiuU0fMeHUW1jjl23eTwGUSiElconOr7?=
 =?us-ascii?Q?al4iEuPL1BKNH6nbKMp+g9EYRWcg51rGp54JxeOhDgkZ0sm9WFvotkvnP4UZ?=
 =?us-ascii?Q?rkXOHuUsOvya9VQmCexSdpUNIw+4QJ+y6yW39ssHNl55N6t5EDQB4sdodq8U?=
 =?us-ascii?Q?2GPjVUEkdRIUzIooipq0vOkVMumitJ/aFtAhtrFbZVOi2AnVBPYtiUl4CFdZ?=
 =?us-ascii?Q?KfSlmHlhVVd9YRAGiXn8MXHHR+55WZ2eaZmKUk5PRfLfZn8oEq+rvpQEIn78?=
 =?us-ascii?Q?DgcRcGxjTRS8hdtdSym94SeFShdO4LipJnsgrz8bB/tGpl/KznlE+ahfTL5v?=
 =?us-ascii?Q?VY1yTDu/vU1fruvT3O6f6i8lpyCgLAvDOuVfkwa5xr7ZeETQQVsikSUdU5Ka?=
 =?us-ascii?Q?LBGw9CJI1cxl3begGwd5bPiGLMmhg6CtH9N5s2+91Ct3Azt+qNDlUWZq/SsW?=
 =?us-ascii?Q?1Zic1CbJ9fdJnyahK5CEMIPlyILBekzS/XjqI1PDzeo5a0UHNYi395I8MFpi?=
 =?us-ascii?Q?my8mvf/jxv0YU7ogmphLReb1FtCsofIC3qd5q8ceupQw7HUTHLTnwfplNS/D?=
 =?us-ascii?Q?bRHTf2QEbFroiifl8E/OetmD+yjRGULSSg1BUuY1pCAi1xGUgBVIb24PZkEz?=
 =?us-ascii?Q?HstNuYuonL1Vnl1JH7TJhkb49orBhCbih9ipDydrlcyIg1TV42mbqB8rEXpG?=
 =?us-ascii?Q?HZZcFZjIOp+Im+yo9cAp2J+03nSxPcQWGFpw7Z3OD9u31WbyTcEMSDzOth6z?=
 =?us-ascii?Q?SDEGD3v2FAM+fZghD5ms3Ta1UHQBhjWZNpY/tn6W+qnjeN2SuIhgufCyUZkL?=
 =?us-ascii?Q?zcipz8o7ef8nN+RfRnHzhxB6W2xbbMhVJ06VyIA/1fymbBAPh324atWx1nzD?=
 =?us-ascii?Q?p8aYgnFevhfwnLrDWJNklLVmA5DaoXYQup5fFB+NqN1OZculYq5ZbqAxPRkj?=
 =?us-ascii?Q?PbjQ2Y7Kf20kCpiAMXA3LI2DCpa3K0nTXml5J0GIf2uzFUqx/FSRFzohpVF8?=
 =?us-ascii?Q?pMTpf6wuJJ9oWvafKQCsQrQE9lKd7/hPING3qPtEOMpHmliJdgluuPJ9JHQc?=
 =?us-ascii?Q?jls+uHFahLhBdmP4UdC0H1lpfmzQyvRfker5oiQjTCWXyaaTH7FuKTNS6haP?=
 =?us-ascii?Q?qqXpPnmWkm1gNd4Z8izPhnEqj2RiVxKbYPBsLIyd4ExOxhdr78uFU82K/bwP?=
 =?us-ascii?Q?JjeYV5aHX6dfHv4dXrnmYsyrkt7YODD1Sj7v7S1Mzy4NDLEtcvq2LmgkniwZ?=
 =?us-ascii?Q?UfS5aHOWFW6i6hffx1HooYCNAUVWMqhKwFKWZZ8Ko3W16Y01yvHtpXH3y0kW?=
 =?us-ascii?Q?UBfqlbvydxcQBYIXPrQeLz/6nxAPAA1JIH6L65EG0MOzqwMiu49zClarHhNU?=
 =?us-ascii?Q?IkKfiGGr+KX1VPafqJICiwtt1GlIv37yrfDeMIeS9J9xFbeKqZQL1aDq7BYY?=
 =?us-ascii?Q?7M29xUgTMV0iSZTNyzgE+Ea/ma8M+7OtD2kcWK5NwMIosPxfK3kECM/8jXQt?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66210e9d-53c2-4ff6-87ad-08da87aaf7d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 21:36:00.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/FuEUL/2OWyECPO4hK5Fyn8HnOv2U/ZhqgICehZtMBGRDickQnNVv0CPuAQ0+EXoBBgqbc0drPDNUf+O5KkD018hkW2qvOFAsX0EQoWBfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang Ruan wrote:
> This patch is inspired by Dan's "mm, dax, pmem: Introduce
> dev_pagemap_failure()"[1].  With the help of dax_holder and
> ->notify_failure() mechanism, the pmem driver is able to ask filesystem
> (or mapped device) on it to unmap all files in use and notify processes
> who are using those files.
> 
> Call trace:
> trigger unbind
>   -> unbind_store()
>    -> ... (skip)
>     -> devres_release_all()
>      -> kill_dax()
>       -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
>        -> xfs_dax_notify_failure()
> 
> Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
> event.  So do not shutdown filesystem directly if something not
> supported, or if failure range includes metadata area.  Make sure all
> files and processes are handled correctly.
> 
> ==
> Changes since v6:
>    1. Rebase on 6.0-rc2 and Darrick's patch[2].
> 
> Changes since v5:
>    1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
>    2. hold s_umount before sync_filesystem()
>    3. do sync_filesystem() after SB_BORN check
>    4. Rebased on next-20220714
> 
> [1]: 
> https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>   drivers/dax/super.c         |  3 ++-
>   fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
>   include/linux/mm.h          |  1 +
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 9b5e2a5eb0ae..cf9a64563fbe 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
>   		return;
>    	if (dax_dev->holder_data != NULL)
> -		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
> +		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
> +				MF_MEM_PRE_REMOVE);
>    	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>   	synchronize_srcu(&dax_srcu);
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index 65d5eb20878e..a9769f17e998 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -77,6 +77,9 @@ xfs_dax_failure_fn(
>    	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
>   	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		/* Do not shutdown so early when device is to be removed */
> +		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>   		notify->want_shutdown = true;
>   		return 0;
>   	}
> @@ -182,12 +185,22 @@ xfs_dax_notify_failure(
>   	struct xfs_mount	*mp = dax_holder(dax_dev);
>   	u64			ddev_start;
>   	u64			ddev_end;
> +	int			error;
>    	if (!(mp->m_sb.sb_flags & SB_BORN)) {

How are you testing the SB_BORN interactions? I have a fix for this
pending here:

https://lore.kernel.org/nvdimm/166153428094.2758201.7936572520826540019.stgit@dwillia2-xfh.jf.intel.com/

>   		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
>   		return -EIO;
>   	}
>   +	if (mf_flags & MF_MEM_PRE_REMOVE) {

It appears this patch is corrupted here. I confirmed that b4 sees the
same when trying to apply it.

> +		xfs_info(mp, "device is about to be removed!");
> +		down_write(&mp->m_super->s_umount);
> +		error = sync_filesystem(mp->m_super);

This syncs to make data persistent, but for DAX this also needs to get
invalidate all current DAX mappings. I do not see that in these changes.

> +		up_write(&mp->m_super->s_umount);
> +		if (error)
> +			return error;
> +	}
> +
>   	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
>   		xfs_warn(mp,
>   			 "notify_failure() not supported on realtime device!");
> @@ -196,6 +209,8 @@ xfs_dax_notify_failure(
>    	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
>   	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		if (mf_flags & MF_MEM_PRE_REMOVE)
> +			return 0;
>   		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
>   		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
>   		return -EFSCORRUPTED;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 982f2607180b..2c7c132e6512 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3176,6 +3176,7 @@ enum mf_flags {
>   	MF_UNPOISON = 1 << 4,
>   	MF_SW_SIMULATED = 1 << 5,
>   	MF_NO_RETRY = 1 << 6,
> +	MF_MEM_PRE_REMOVE = 1 << 7,
>   };
>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>   		      unsigned long count, int mf_flags);
> -- 
> 2.37.2
> 
> 


