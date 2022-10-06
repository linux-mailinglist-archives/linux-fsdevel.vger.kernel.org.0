Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5705F71C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiJFX3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiJFX3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:29:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91EAEB7E8;
        Thu,  6 Oct 2022 16:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665098945; x=1696634945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gbd3v3UmgfTYeuh0IGjyXCMB4GtAjwbIb1eQ7kFcefk=;
  b=Xdybo+MrPcxq3M9x/Yexw3S8+CDxVO//rt/ofVGh427/wqBth8Hd9nsT
   szNNvE0d2zlDyqEaaqpLfIKr/hXP1dhSXzg8rQhcLbMhIRii9bM+FviOy
   TIbP/1YLnhHbp8ipBZ8ndNiylEp1PyB0PfGCfytY1+7V5aQqmq5x9tS1G
   3Oh2/Vh6GX/wHltXcqsANJfVOtBytYY3Gji565rPOsD1YOeN6CZIubCbs
   LI0L3HxWZ7MfX6/ehPjSUO7RSLr3wJyCUJ1UO8erJGPFHlq0HynrKpyym
   oH/jtzeRZJ+8aumnER9SH0Rk9WIkG1UtgdIjRtCe6OeRuD0K1PE4YZP9V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="305181903"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="305181903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 16:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="750338734"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="750338734"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2022 16:29:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 16:29:04 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 16:29:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 16:29:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 16:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISBcOga1ZAdN5cYB/QcbBvOtj75F3+BQhwQ5FMBCGbx+rOyjZrED6GDky9LtYjx6bGy2TZ7VtKa72G+8HCPZugBz7Vi+FC3+79fgSDL5BhCd2j4YwTfsK1l7xwCx5jgxA5/HFQVXgiAoT8IaiBc6V1CdI10W4Y7MPh3geQlrCNQbfD6cLUiEq0kkUdh66nXy7V8X+ujFMdWKQ6UBjZHoxYsMxDZ1oHuJO2a3G5nWDOLOKlTbo3HlbN7f63kq8//7VoMTAqrOjiW1w4DlcY8VYvROvAImNSxJqYJ9ULB8MThKfgQA+OGmGY6yuUej64N8EQm39G/C+ppHtixFj/J42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbd3v3UmgfTYeuh0IGjyXCMB4GtAjwbIb1eQ7kFcefk=;
 b=Fv6MTqhBZLntLYXS2loC9/nBm5ttBlgu16R+06QXletA078qJmasQ/8FsYu2gy2z89WcA58hVVjuUZB2zj6WHwADJaWd/CA/uYm02omwQ2lfyzJ/gAW1UqEMDaVzeJ6JDfU7F3L3vIgv1WSrPd+t6POGGOLj0anYosYQqHm14ZvC2n8ONZYAX+SAUMmrbc4WJ83L+FM6kDtedPii2oMgM+T1cASnL+mzuh51+IUMrvqub0N6SOg9mH+hvFS4oKdlMOKhPMM/pf3dD8dFdG0RtL2jsliJPXgT92CiIOMn/uNmGjveEHc/wil5fCBBwSJDNbgiXZSUQtOAKnMei1qNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 23:29:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Thu, 6 Oct 2022
 23:29:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
Subject: RE: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Thread-Topic: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Thread-Index: AQHY2dU8uHj5q4rVPkaFVzmcNEVfU64CAV2AgAABXCA=
Date:   Thu, 6 Oct 2022 23:29:02 +0000
Message-ID: <SJ1PR11MB6083D102B0BF57F3E083A004FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-7-gpiccoli@igalia.com>
 <202210061616.9C5054674A@keescook>
In-Reply-To: <202210061616.9C5054674A@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4574:EE_
x-ms-office365-filtering-correlation-id: 1bbc144b-8784-4019-7384-08daa7f28d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ww7zdjKNPUO7vwRzhv9eUFnq/zQMMGTWb4EVcc+CX7Q6PDqkn9jq1rqhSmgZGZrEd4ZOOaZSEpVQrQe5oS6IvfhgSdWLVv0AbAY610WgIYqpc5thGFq2KFH2msehQTOihwKJpB/t91pUf6iHqRoaIvlUDcYxjyhoukjJvyPLLCd+MhMGpx6t0DedqnBS8yu/TwiZejuR2FPGJBidagSYMXuVL60Ji1/VhCEoUdbCN0MDFGztu6vVTO+DzyZHSkB/4qY6lozx9gS3MKYVna0DUVITCv3fjXXUQb6v8Oj/swm+j/rtWb5TfSdfEswaGn0MbAveWt2SRGzZuGv1P+IH57tOxNjJDjeMmQ92uYz2WSVOaN2sR8vIwUp7JzX5fY8ddqxz/p7vzlohFFeeWpSZijE8eRz0G68hRJeGguuGbM8BxjjOF09zl3ryWgljX/lQl0iMbFqRpYL5D9qFpUd07HLLZBQnxNT0VL8ypiEBFwnx+ZItQkVd+ThB67R3CT6dAb+oKPeU1850khXsKMXI/zUSXIO/hUR+2Qx6FGvIgrtYz5wIf2kdf/vr4VE1nHmRQh5YWuL6EgUwHCz0gULI0F5m9iMH6+whRy4hUl6G/MbdKRg5WKxHKpsksoO0zG6rR6pYa26lH5bTdvqNFo+8+//y1/vZuapYeexMRm1KBclD7kwGHuzaAvK/cSEOQ8AqwKmycLC8HHM4tLIPrCjsgd1K1oNh6u4T9P2csQaSPe82gF2iVbGfLs0VEj3VAc/UWHjCmDlZ63zc4KDkVRNVCFa4gVuZ4K74nBa5TGDi5ti8V3b5a2u8dPTseHh3A2Hr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(38070700005)(26005)(86362001)(9686003)(6506007)(7696005)(82960400001)(33656002)(41300700001)(8936002)(55016003)(52536014)(66476007)(8676002)(54906003)(66446008)(76116006)(64756008)(66946007)(66556008)(316002)(4326008)(110136005)(478600001)(5660300002)(71200400001)(2906002)(558084003)(38100700002)(122000001)(186003)(130980200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nFKzCGj5wXJwcphT7SyjsLfZWnKbYYHgWh1buNLDSMnU3lwhYyc4V5AJuRop?=
 =?us-ascii?Q?d7e0fwXUG1Z3q1EGm0/PcOccOeQ1azQ1s837JbrvQYxzRfR+fbfvCBQVZvUm?=
 =?us-ascii?Q?ChgEZK8/oPEwJVTXhmV0WxDcTfWOCMEsvlYV5x4GvJ/m5eEDDK3LBNRLiowk?=
 =?us-ascii?Q?gkxEb/JzWifDGl0Pd2C1FPOGrs3TpV5PMNIzV9ZFB5yn6+5V16fuftTgWgxy?=
 =?us-ascii?Q?izAODno90yzDqnL4lLqgZ/vh6k7T5roRoKfIP7Os1SJLHb4gr26Z7gfDnktK?=
 =?us-ascii?Q?9WKFsycGhDDZy2VublBfp7fEMykO6A5uSWhXnedSudeEJXNhP/kCkOvDaOfT?=
 =?us-ascii?Q?REXH7Dk1bzrjxLkzZEhSjIwlIqK8sm/Gla6dWw3fgs7lgXS2c1dVqIx0wJmy?=
 =?us-ascii?Q?h8rVWzVHPJ8YiltgdsRff+34Z/ZpK1peX2neHMAGSislbXpDaFFolaTPdJcD?=
 =?us-ascii?Q?Sk8ARhtb5DAEgPaiUf6GQQMym7Yc9r7336wcDWeoE6Tw9QWIvrJgojO1sRTs?=
 =?us-ascii?Q?kiY9cV0wK4RMOC+YiXIRH9eu03Fd4C7U9rkPtqTewuaWBgb5guhmqNkY6qJC?=
 =?us-ascii?Q?t5KGtyg9cFy5ibRps3MeppQT9yFqiUp9bUDhrFp9Stmeoo+tLEwkFXgdBGzc?=
 =?us-ascii?Q?yx7sCg4rGktKneY4zjfsSiMDnx4LD2p1jIXG2bhlM+X/CemOFvQYKGrv0/9v?=
 =?us-ascii?Q?n/VJHxdvs2WrIJigo2K2GhkEcUi+J8KcybE/dez8SOhSPjrqhKblpd7ad/Lw?=
 =?us-ascii?Q?5ge15bHJMTWeZdux88gT3RXAO+S5RWMygIK6Kxg8nYQAABWtWz2pSzxkiCHY?=
 =?us-ascii?Q?f5Yi8k+kDUIgH0aVbnHjoTwRYfoKD/UUNxLmYgN9bu40ifZBJNg6rCs2P41x?=
 =?us-ascii?Q?Yk8JJ5Q+yTMQCiMvD8jXQQsau57YkVWcJQS5+nV6DNeNxMlJ5WhNvQ0vhUDV?=
 =?us-ascii?Q?W5EXqMFHkwAmKAsO72wE5CJBZ3hn4pTQH6zaxK3QqVjQnbQW+U7ld6qyRxFK?=
 =?us-ascii?Q?FhvHueQlh084z0AfgXa5fEJFefPnxXcc6DurOXhMrUFZ+NSNwaJ5pcNCTXSo?=
 =?us-ascii?Q?vFbYh4NvXSteqVedf/rKcfaCQ6TGT6ktEHIewbkHHP+Kpx/R8De5UEjO/9U6?=
 =?us-ascii?Q?LYbynTcY5Ih7nt4AqGGsxO4WGaXRaugYNJpQxXq08cjmH7CTzPIc6qcIToVv?=
 =?us-ascii?Q?CBhqisspxztKGRYZLHJkfSCQcX53WMas/7YbSo93pzBzhwVKOfoHNISWC+2W?=
 =?us-ascii?Q?lBWcqy9nux5hWVgnDGf8UBVSD49nvqh1o4AT4RnwD4uYDXExHWmsElAnGAfy?=
 =?us-ascii?Q?VHOeerMsUW3cbbe2YkgShK2E114yYtPNHVs0DLZNbDH34dgaxlpH7Ld3LOK6?=
 =?us-ascii?Q?jUUYrPT2NJGIybVmCcxuLm1S1wUxhrin9aqhMAXErMpM7GxWJTJ9p8Ng3MYw?=
 =?us-ascii?Q?dCfKv12y2lHKaF5mQaTq2wyAK74BSevxwZ4y2U6IjAl1tS5x0DLFBmbhaf9C?=
 =?us-ascii?Q?C/KlOfEQH7CQgkKg6QK0wwmdkRlpsAt2n1Rr1pThQ1vSSwieyftt43LdLwlA?=
 =?us-ascii?Q?DuyOr/b1fRiqKbjPO1o9wP9RxdXAQznB6fFBwbWX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbc144b-8784-4019-7384-08daa7f28d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 23:29:02.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTuz1VBEFGzNqcDcv5DcLv4KBcxGbTRyvOwuIyBhQ0lHzrED85xYjLyo5FjNErKdLPpersCKhzNlGRuNtxa2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Tony, I see your recent responses, but if you'd rather not be bothered
> by pstore stuff any more, please let me know. :)

Kees,

Occasionally something catches my eye ... but in general I'm not looking at
pstore patches. You can drop me from the MAINTAINERS file.

-Tony
