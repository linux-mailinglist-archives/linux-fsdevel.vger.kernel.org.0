Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876065F7B4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJGQTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJGQTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:19:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11F10C4E3;
        Fri,  7 Oct 2022 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665159556; x=1696695556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WDHhiug4Q9NB4fff3gTEfwqJ5AxTADVqtYCdfS0OprM=;
  b=H+qosHeU0drkn/7QEyeF9KXYR9t7TPX2KHGCv3SO9ExDF0NO37uK+8ml
   jc0o+uHbXosKc94+kl57QuIr4JEaDEOYaMSq8yN2SeoetfSPj+M3EQg6M
   UmCj6JSqqe90ArVsn0B/okqukOTZO0s19jYtDwm9qh6J6cdnztthgJrrg
   P+xMAB5hQKLxvQs9pmeAJZ1e5WyaTXgqtz3SX6YUJv23MdJY5I3xhmBdj
   eBTaYre54+2ZLVs6c3Lu/8tJhJoJXe53La1bl7izUMF1C/PSgzko5H6Ea
   bkJmc2lfyU+PoVDJoH8hYY6xwoJfRFy9kK8pyToSQRzaqa7kf8Ez2gLpL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="286998066"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="286998066"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 09:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="602925493"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="602925493"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2022 09:19:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 09:19:15 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 09:19:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 09:19:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 09:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7EtC8K4ZpyVoURV4D5M2M5KCCG5gOdE0yHDgesUaIFtFGa1hMGZI+2IIyZSB3L+vUUb3Rm7yU7jANXcY+gXU3y4b/kZWbf3yO6yJwV/Gn6R7aJdnNlJV18U5Y5X4XsKdyhC/FWX/EP071fNU9rdsxuGtr4E+CnJyM8ch3fbkfBki07vBDH+bY4bbN05sQhqP4Yt/5Ck+c34gUL8b1GZV8Zq7MvZ+FF3KpsQOZoOzhwNDqaWN8/VGujkrJafsfaybZk+nwDa7u9gC8MaCIJRAHusEILtVi4gP7hj8MyEQXAHLkB+K46QA/I1MsP0QfJbTt07VLFaLvPQuNncQRFZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDHhiug4Q9NB4fff3gTEfwqJ5AxTADVqtYCdfS0OprM=;
 b=TOOhTDW9LPdPllpFsUPZ28sqQ+KBRQENGIjf8LSkCgOYglSJNEhQi9ZAgSQH0izopQw4+rFd2WN0Xb7nR9fKIFBMbKz67tfBH/e7rrK5LrKgw45Sa5JrRvNaM8qJnUlTcQQF1UWuPm2hNFoJBL7OOGZ8QjvxwZVBhKltdW7L678IxMGy7xAAb3vW8q2IgYub42zqGeK9V/pfVpkWXTl+Jsi21ehml/cuDF8S4n8C5aM9KusihnGJz6u+hdHaQ66L7tMjeEM2LfMgjuj/YVucOW0ACSpsiZVuboviXIjA0bKyfGmoLZfWkqVbZEOnd6NOEHWHfgD2jMw5s83IQ62P5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5413.namprd11.prod.outlook.com (2603:10b6:208:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 16:19:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Fri, 7 Oct 2022
 16:19:13 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
Subject: RE: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Thread-Topic: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Thread-Index: AQHY2dU8uHj5q4rVPkaFVzmcNEVfU64CAV2AgAABXCCAAALagIABF3xA
Date:   Fri, 7 Oct 2022 16:19:12 +0000
Message-ID: <SJ1PR11MB60834997A4B271B19DE5848EFC5F9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-7-gpiccoli@igalia.com>
 <202210061616.9C5054674A@keescook>
 <SJ1PR11MB6083D102B0BF57F3E083A004FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <202210061637.8C09C55@keescook>
In-Reply-To: <202210061637.8C09C55@keescook>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5413:EE_
x-ms-office365-filtering-correlation-id: 8c398dbc-3f47-4cf4-bd63-08daa87fac39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBnq1vVZeu4ahiiGPfE4R/ld3pWpO3OiVLgIHCn2moWMEBz9TakNwOipEwMcqOsNBkYIuRqRObO74Edd7CrW5dw9Xq684besjyPqS/ccjglhL1sqBRz1PfyWd3d2eCyeaFV97j7fvtH/DJYPJ2tGft42ZjEB6AgA+qxDgkBAbN//xlNyGe3z1spzssMVwFnSj3iNUxWzUHt7lyFfoGG7V9r6Mc1Pu+IZ+BQdxvQKPm8CSPkeLp/gEH9/XkjaKDdWOj5XVkuILlfxFfXXgiOA85mfZwdo2yr1IPmNM44vz0z1L4JF7UPKzjmjC4AQrP1boppZPAaojj0UI0mAvoZiz5YXahX4XRSKcPNoI08y6FBBoqXUmSRTlGzRt2vjlH7m6JEfucupwwBI/DtjzxXurCndd8vQGMbN6eLYGFFl7JYf0bXtSGvrqNkhC8MAcoJWo84uBobuzpHzYRqPwThiejNDToRzhXFgLHWAjZxlvo+Z1WPXy20+U2EySq0rYr63/oLsvun/nZwK1Xe79krSTi/WGdr2RwC/GePTaTYTem+FQTBzFWNbF+GF8L4k02da7gUhzRWSj19cHY71Jtj77sbtJAOm/IWPOGuDE3uhLFveHX/WwEklbtH1zI53EkET3lqy4925BkYuyCNUilWAnmgVDtbT6a7ToeEC1h3WLCEutBEHFx29n+BWKXPzqycvZm6L15KNGU9q+94i0BqpRfsmVF7DS67GvDaIsetN9TVz0IyKodg8vaF6150MgMJWDWZIJGYaQDKJcjEbxKbtPhM/xocg0dJvp7chNuyEV2QRZ79zhxMCtzLHWFfK/fyS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(86362001)(26005)(2906002)(38100700002)(4744005)(186003)(38070700005)(82960400001)(8936002)(55016003)(122000001)(64756008)(66946007)(316002)(4326008)(76116006)(66476007)(8676002)(66446008)(41300700001)(52536014)(6916009)(7696005)(6506007)(5660300002)(71200400001)(9686003)(66556008)(54906003)(33656002)(478600001)(130980200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kts3SjleATA8ENbn62FZDOnxifAA4WMoe4n581iK39ah3bUdf94ix5pTQ7GT?=
 =?us-ascii?Q?9x7QSYrJOs72Z+YXLk8idclEIdaHAamVkw5TO6sTkEXEgwMZ87y93xhviD3S?=
 =?us-ascii?Q?zMdAvoBrqz47lSMzCZuuHuOzibeEYlkUJRne5YykI8ixOx2BEOMx0zm3VI/S?=
 =?us-ascii?Q?rOmnslRd0WjfNrPgia1jZMXVGzhsLswnyLKg2SOYxUWu7h1xTb0+nQ4Qy1Oa?=
 =?us-ascii?Q?MwmTdksbXm9ZHym8p5o0JXFSCSQN5SBehyulUwpt14ceurfmvDC5yL3sOcac?=
 =?us-ascii?Q?I2bOcRL3yLpcli14LQD13vbx/dmwLUI8y49klkR7TjpzFCzirTuowzGg4+R7?=
 =?us-ascii?Q?h5ldgaAjIa61PXR50GMH1NZAvqsowO+EdlymGV35s49MMBnZqBjLFtcbV8eN?=
 =?us-ascii?Q?g7977yRK/Zn2cbkzNUOnO86C4uv11g+GQl3KGct2oS/d4jiz8ZD+NNUjD9G+?=
 =?us-ascii?Q?AvHvQWVC4cWgdKfc3U/R6KHVMlFXG4Su8Jh9dDJK1yPf9To9BERrLLIoy9hD?=
 =?us-ascii?Q?c7TWeKslRcmEbGuxgR9eYpuG1UFZf0s1/xCR0rvpLvyDsZymiyBxoWpqDki7?=
 =?us-ascii?Q?OJ7brSdxswPc/fxnyWzZ7XYhG83JaNdJFI6FkT4zWs/UWLPPEPuwRcrWgyLm?=
 =?us-ascii?Q?Y5LZ1zv3zwO+1ohapEw3s2sMYwR7RjJNc9mCK0s2DCjFE9QyJQQiBVbigeOp?=
 =?us-ascii?Q?En+4EHHkV58Qq5MwgwZd1pqmfunw5Y587s/kz0kREcNkoRr2q7QJl8dgkCp8?=
 =?us-ascii?Q?DSSsFHqNG2PRRGu3RHBYSsfoxaCyZPxrCZ2qPg3ofEwjcsDdQrPjgOCdGcYA?=
 =?us-ascii?Q?IuAlSNWYT4kn0j81ozhqzKsocJpesmWmeBQqCoiHC40MXsb8cnGejl5VsmDA?=
 =?us-ascii?Q?FW3DBaxbUgBO1M2reUy/P5XSCO4cejmmkycKZURyvkm+qmz0V+Wa327DwN50?=
 =?us-ascii?Q?raxY5T2guNlMeLwoE97CQ0SmetAY6Q+8UoktXlImvn0W4mFjj0it1njECS11?=
 =?us-ascii?Q?dEntsvFCCHFdKyVWapv9B5HAHbXqz50FhLihqEMmFn2yFh7GmTJ/yKjTohhU?=
 =?us-ascii?Q?ehq4p0UbwV8ttLNA/LNbHOToMEuNPcMnjG+eKMBOTHqskVAbMKn8NtXTiEJR?=
 =?us-ascii?Q?evqR5tKyt77i+R9gZoNaWRuWXBpUFSSjEHrhV25TMnafCsys4wkoI/wEgyxt?=
 =?us-ascii?Q?PSuafP67L1xMStu+PKCduCvI5AbGjGjBjXeRnrz6oGDaFLwlM3qcVVXmhz0b?=
 =?us-ascii?Q?sXILyavR0c4SZwN3scfB8CSHDu74253WXkqSPUqOhEXH2hmkizB7bzBRhB2I?=
 =?us-ascii?Q?qPcXb6w81rvVDfw92ZDmLiqlilbMxo8poPZAhjJ3w91pdiKtTQUZb007zvQA?=
 =?us-ascii?Q?v4Bxc84aQucfYRSz7BHKBejRtTEVTn5uUoU1OyVUolZ/UJIP/6ngENdiOeam?=
 =?us-ascii?Q?AHXjxVpt/vQ8/BLQLH1MWB98fMSuW4nFijGYNqrBqLjKVadu0weRH/rlyyzu?=
 =?us-ascii?Q?gDaacBfZESEpoTEkR5Bwumm7yElliA9/eydpG71RufyPvFgPzlM+o2T/yay8?=
 =?us-ascii?Q?SzUJNHAiNUbv/Z/RiNwLj+8bfhnExb+5oXhHh0RG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c398dbc-3f47-4cf4-bd63-08daa87fac39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 16:19:12.9655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AlnNlcw8aNe24guRuO5LL13HKbEOidFSLuL6Ba+FmNZNhAdBt/145KSkPAaYzNqhhkw7Rar/XRG76d4vV1mQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Occasionally something catches my eye ... but in general I'm not looking=
 at
>> pstore patches. You can drop me from the MAINTAINERS file.
>
> Do you mind if I leave you? It's nice to have extra eyes on it when it
> does happen! :)

That's ok too. pstore traffic isn't a significant fraction of my e-mail flo=
w.

-Tony
