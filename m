Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E977C7B5C96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 23:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjJBVne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 17:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJBVnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:43:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BAAAB;
        Mon,  2 Oct 2023 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696283010; x=1727819010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ImBSKqFocFUuPet6uNRyHRBpn4ZUmgtlBaXfVqyA7Lg=;
  b=gUgFdGnARPysxvyfvecu3arApiTvRvX3yoPyfvvnBSE+pMIjmkaLr6Bq
   u4x6XY3RxRNQ+GliPs9695MrIlgmO0pyu1cARopJbtg2x04+JgxY7N+Zm
   6AP1KS2mZk0OslBg8Q2y8Yi8ftwVgdBfr9zWQDkgc/i/CfTbGCsjTHDv7
   YphljYB5PwHI35dOaQiDvGdu9r7bsB2/Zg1f0a5Ye5oRk+dMpCLCqHZYj
   yLUi6/ttXADVsuxoDd5+kAfwRW8hYF2SZP+tVLtPr8Y/nXcDtV2RlBEPy
   6PbDqX/eapXEP/d+WQ+rtdcdgFSwDbRchp42fDBs95ZDrFuu0XnZOVJ0s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="469020073"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="469020073"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 14:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1644548"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 14:42:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 14:43:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 14:43:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 14:43:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 14:43:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK4G5zfeB2pIgnky3H1tQLRFo6sakhlVKcawr3n7vmy6ZBXd41mP7Ha6I0KrtOkPJvvcsjAtFxVQB5P4t7ZSoOeTNFeIoATAUSfddXDhSRF25WB1JiZ5BFqA35Jkd0AqTFgxzXV5rzld4mI0Lze5jC4/O+56+oa35eAEHGOyJhXEelxboFmRuClG5LS5yi7IqvHudfUQm4Ac43pWnjzeL1j2SlqzcqKG8O9gh4eodYG8bWjUSj0tnQpIXi+llVPSeBcyZ/e0Dd9zKjF+atdrJPHym2DaT3K8BGxYCTP39715pDehj7HKD6V37V2OMV6Xm/hyCrqW9mSdJUh5MaYygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImBSKqFocFUuPet6uNRyHRBpn4ZUmgtlBaXfVqyA7Lg=;
 b=TYGd0c2TCLlqd70MKzPddUVIIpRgqKy5Ryk2zuQyt2jd+ozvGKPUfqe+3WwxMtAnLCTX0Z0FA812r47pWXL73+OxVujQCvETv6N9OJ4+YshOn3ve+aDtLUzcQvuFuJIt5SaUxTmKeNf9Y19BBSmk0l7XF2OgK/rj+jf31cSZh4l2togX4cAAUxOgPUq1gDo8NCX3yMhSMY2aoHtpls13p6O53MKr3hLYY4EbvX5xp7wR0DriiVVwefMHcBvJbUySJqeuMHZoXUVdpqTyvp6/QDDfCf+3nHl185O2NcbscUZB90Sf5l8FoVWLNlDvvKZmYilFJfFXmUzQa7NiHhhI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Mon, 2 Oct
 2023 21:43:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf%5]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 21:43:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Thread-Topic: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Thread-Index: AQHZyXrQTo7DD5VaeE6rWykOJvFzra/iB2IAgAATqwCADkUwAIAAI80AgAYaVoCAABGwgIABEOyAgAAynICAONO3gIAGeNeAgAAf1YA=
Date:   Mon, 2 Oct 2023 21:43:25 +0000
Message-ID: <add914d6ad943139cd4a8f23fea7167b083a53db.camel@intel.com>
References: <20230807-arm64-gcs-v4-3-68cfa37f9069@kernel.org>
         <ZNOhjrYleGBR6Pbs@arm.com>
         <f4cec4b3-c386-4873-aa1d-90528e062f2a@sirena.org.uk>
         <ZN+qki9EaZ6f9XNi@arm.com>
         <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
         <ZOTnL1SDJWZjHPUW@arm.com>
         <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
         <ZOXa98SqwYPwxzNP@arm.com> <ZOYFazB1gYjzDRdA@arm.com>
         <ZRWw7aa3C0LlMPTH@arm.com>
         <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
In-Reply-To: <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB4974:EE_
x-ms-office365-filtering-correlation-id: ec537086-f2d9-450e-89c9-08dbc3909bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 685drLnPBiZtATRAjWsBLJpvEsuc3YULI1pvkx9DbyKx/PJZ2ghdYNS4iTaiapUgKX4eqCkBeCdqh4OvY1gYeRpMm51Qo1b7+bJKouikyVPOP4Pl4J5gF37xk/wzBjlBw5XWZP4mdklZUlzXzx0sVAevUfrIa4TT+Cwn+5pEk/v99Gg7ERxIewXnOOEiN0Gr3OkIZ6gg0jWs7DdnLwIo7Xdfsf8SgbX7ZcepjoYDyZHwI1naMQ5QMpZegWHkn0HnWKZoa0tsfAnxzk2WjX6TAT3QYMz0qwiaAQM4ShdKOkKEjYXpwXqRIa9LQjdIXYnHKwo6zMrc1azfuFffo/6mlrZ4ixC4v6J5wZ9XhOniQGNXwiiKqfzMrEmBIydNXnWLBfMYtcRDlc53Q3yZtyJEG98kjtrRBHqk67Nae5nYn6Mule+vrOLVyNu7x6KQY1FjmURB05Hzt7LoD4laV9iN0tAxc74epKEOdAvAQ+VDJ2fAOruu5vB6UgfiEBK/bpWdlrNOqJDS412tGPgBKOOaSY1QhGzhYCeeGnZdXWklJcN7r5QgF16rI7CfXbrthE0Dp+2OoaFFXGZ2tQ7/2saoiFIqNF7pO6fv6/oC5U73v1YIaUHwA2JZcmBfqz7++7K/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(83380400001)(7406005)(7416002)(316002)(5660300002)(36756003)(41300700001)(4326008)(8676002)(8936002)(76116006)(66476007)(54906003)(64756008)(91956017)(26005)(86362001)(6506007)(6486002)(66946007)(2616005)(6512007)(71200400001)(38100700002)(38070700005)(122000001)(110136005)(66556008)(82960400001)(66446008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWNnQUhsMS9mWTExYkJyYjcxei9vZTVZbWpFQWVhTDRiRUFxUS8vSnlXU01n?=
 =?utf-8?B?eFhQVjdHVUUvUCtVUGE2bk9JTnFObFpBeE9rcS8wR2lJS2lKZXBZUnBTcDJW?=
 =?utf-8?B?Q2YxNm9hc0d1UFhkQkU1RHlWOGZwdjFoSE5qU09nVVpLdWtPM0V0NitoNnpk?=
 =?utf-8?B?RjVDOEc0TlZyd0VQUzZRMFlTMXNJK016U0FmZWxVSlF6UHlpdGJFVFZsdXV2?=
 =?utf-8?B?bkRrZVFoRjhwU0E1SEJtTURGNG9KYnkyS3pGdVlnUzAyNnJTZno1T1R2b3V3?=
 =?utf-8?B?Nm13T0puL1Voc25sTGthUWRUa01wQUFqT0tXR21zM1pEWDJUTUZmWlhHeFNO?=
 =?utf-8?B?Wmc1Z3BLb2dUREtQcWVQVENrM2xtbGp2UjRnQjA1bDFWN1hvOGJra2JzdlpW?=
 =?utf-8?B?UUtqVW1rMU90cm9mVEREc3Rwc3RzOFR6YmhoQ042OTZ4cWxiOFVaeTZxUURv?=
 =?utf-8?B?NE1aWjVLdUljZU9hNnVaNVQwWk9FeENvYTVDa0FlTFV0Q0xsK3NYTHBtZjBo?=
 =?utf-8?B?Q0JuMU1pUmIvbGFoWUI1d3lFZEpUU1VqVnE5ZEhtWENXc1R6WVJaZzd1TTVy?=
 =?utf-8?B?RThoeGZBR1dkZ0Fob1NZZS9QOGExNHZzQWIxUy9JcnRDdkt1NS94Nkx4RzhR?=
 =?utf-8?B?UndtdW5CZE1iWllsYWFLRVZlVno2T1JnWUJyVkhlY2V6STdpOTI1MTFwUjBU?=
 =?utf-8?B?ZXQreWxiUTdka054ZUx5M0JNZE1jeEJJc1hiV2dQcFJ0M25VaG9ITXF4VEls?=
 =?utf-8?B?SktETnMwNDZoNXd2YlEzVmdzUzM0Nnlna2tDQmUxZVRqcVV2K01BdzJzMXN3?=
 =?utf-8?B?NlI2M0JUNGd1bFRxcXkvVmZJQ1IzWnkzWkM1UWptYWVyWXlHbjBucGRWRWM3?=
 =?utf-8?B?VzczTmk3VmcvMWZWQ3hSYUpHUjlMY0dsZmxQMHFkZldUMHF1UXNFTUlxNkVz?=
 =?utf-8?B?cWpaOG0vekErcTRJZHo4RzN6T1N6V2NHaVIzaFpDMGFnQlRvalRwclgyL041?=
 =?utf-8?B?TG93a0N0Tm5wZVcvdnl5Nm5ZLzU2dmRSTVpDWDFiUXpONGwzVDlGdS9nQ1NT?=
 =?utf-8?B?R2wxWktlOWhIYTZxZnBQRGxGbVVhNDN1S3Qxenk1OVZaaVpPQVdUUWZwdU80?=
 =?utf-8?B?SnlvRVY1YzVrTWwvc0xRM1gyN2dqMHgrdjZtTzQ4enVxMW9ERlNxdnVtLzJ6?=
 =?utf-8?B?S2JvL3BMb0JyLzFHd0VmbzVobllOT2o2R1c4QkdGc0c3dzdIVDZkQ3lHbk40?=
 =?utf-8?B?VWd5b3Y4Y3Z6V0IvSXIySk1vOFh4ckRDdHg0TzNvNWk3MUR4bStRQ0s5QzRU?=
 =?utf-8?B?TG85S01SVkNjYUJYT01UTXVDM3l5ZVMrRlZrbFM0TUhVMEJzeWk0dytmWmxu?=
 =?utf-8?B?cUZCMVUzMnZTRVlYQzM2OFlWUXAzeWt2ZFRpbGIwaXhoSlVqY3pSMEIxM1B3?=
 =?utf-8?B?Q0Jwcmwvc3RzK3VzVTdPM08zNEI2ZTlMV1J5U243VWlLRU14cW9aS0dBM2NW?=
 =?utf-8?B?QzBoRlo1RzBWM1NNelBHNG44MVdnTkx6SHZzSVRmRHd2QU1UUnoyZ1ZaQXJB?=
 =?utf-8?B?dk5WWFJ6NlZxTWtrdnZiMFFNdURydDlEYUtwNk9qMXVna09WeFVzaFhkM1ZL?=
 =?utf-8?B?Z2ovSExCM1hWOTJXS1FnOEprVHVqbUxyU3lPajhHTkJ6WjFLTXpFb2EwbzBR?=
 =?utf-8?B?YSs0ZFlsQ3BXVytPQkxNYXcrdlRZazltVzlHQVJRTk5jTE03ei9UQ2x4dm50?=
 =?utf-8?B?OHU2REdjdk84OXpDNUUyNlk5MjJ5RXhnbDN4TnhVK0JUN211RHFwQnFWZ28x?=
 =?utf-8?B?NGxIcE5PbTFNWU1SVm1HYUZwTGZ0SXQ5dVNRWkNjNjhRaExNZDJIY0s5ckxH?=
 =?utf-8?B?TUcwMUlKKzVuUmJMYlV4VTNzVUhtMVRRY2I3TXRua1IrZE1qVlkySjRTRWd5?=
 =?utf-8?B?R1k4dXRnZFRNMWtWakxXQ3dOZXJUcHhjTVl3dU8zc3F5c2owMmRWVHVTMkE3?=
 =?utf-8?B?WDlEVHRyMDR5Z3ZjOEx1dktJajZMQzZOOHJMcHlCMnpJVjU4S29GOWR4UEVO?=
 =?utf-8?B?Mk1YdzNXNmRjUDNjM21QeHJXenBUQkNOcEl1M2ZiMUZqZnRia2VzOHB5aFhw?=
 =?utf-8?B?RWRKRndBaDZ2T1NPZUtoZk5sMHNwREExTUh2RWRibWg0NnkvT0Iza3lqSnA2?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84742A11A380D44391AEBCD9D5719729@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec537086-f2d9-450e-89c9-08dbc3909bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 21:43:25.8664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybuPqNcmvpgSDLl7VBB8I9tjc0+XoW5fhoRFx1wZHzna6ahNcPGq+t5F72ig69v8+z1OnkN2AFrrLX9y/laZEnM8GaTHXop4LmfPXaI4ycE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTAyIGF0IDIwOjQ5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIFNlcCAyOCwgMjAyMyBhdCAwNTo1OToyNVBNICswMTAwLCBTemFib2xjcyBOYWd5IHdy
b3RlOg0KPiA+IFRoZSAwOC8yMy8yMDIzIDE0OjExLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6DQo+
IA0KPiA+ID4gPiBhbmQgdGhlcmUgaXMgdXNlciBjb2RlIGRvaW5nIHJhdyBjbG9uZSB0aHJlYWRz
IChzdWNoIHRocmVhZHMNCj4gPiA+ID4gYXJlDQo+ID4gPiA+IHRlY2huaWNhbGx5IG5vdCBhbGxv
d2VkIHRvIGNhbGwgaW50byBsaWJjKSBpdCdzIG5vdCBpbW1lZGlhdGVseQ0KPiA+ID4gPiBjbGVh
ciB0byBtZSBpZiBoYXZpbmcgZ2NzIGluIHRob3NlIHRocmVhZHMgaXMgYmV0dGVyIG9yIHdvcnNl
Lg0KPiANCj4gPiBpIHRoaW5rIHJhdyBjbG9uZSAvIGNsb25lMyB1c2VycyBtYXkgYmUgcmVsZXZh
bnQgc28gd2UgbmVlZCBhDQo+ID4gc29sdXRpb24gc3VjaCB0aGF0IHRoZXkgZG9uJ3QgZmFpbCB3
aGVuIGdjcyBhcmdzIGFyZSBtaXNzaW5nLg0KPiANCj4gQXJlIHdlIHN1cmUgYWJvdXQgdGhhdD/C
oCBPbGQgYmluYXJpZXMgc2hvdWxkbid0IGJlIGFmZmVjdGVkIHNpbmNlDQo+IHRoZXkNCj4gd29u
J3QgdHVybiBHQ1Mgc28gd2UncmUganVzdCB0YWxraW5nIGFib3V0IG5ldyBiaW5hcmllcyBoZXJl
IC0gYXJlDQo+IHRoZXJlDQo+IHJlYWxseSBzbyBtYW55IG9mIHRoZW0gdGhhdCB3ZSB3b24ndCBi
ZSBhYmxlIHRvIGdldCB0aGVtIGFsbA0KPiBjb252ZXJ0ZWQNCj4gb3ZlciB0byBjbG9uZTMoKSBh
bmQgR0NTIGluIHRoZSB0aW1lc2NhbGVzIHdlJ3JlIHRhbGtpbmcgYWJvdXQgZm9yDQo+IEdDUw0K
PiBkZXBsb3ltZW50P8KgIEkgb2J2aW91c2x5IGRvbid0IHBhcnRpY3VsYXJseSBtaW5kIGhhdmlu
ZyB0aGUgZGVmYXVsdA0KPiBzaXplDQo+IGxvZ2ljIGJ1dCBpZiB3ZSBhbGxvdyBjbG9uZSgpIHRo
ZW4gdGhhdCdzIGtlZXBpbmcgdGhlIGV4aXN0aW5nDQo+IGJlaGF2aW91cg0KPiBhbmQgbGF5ZXJp
bmcgYWxsb2NhdGlvbiB2aWEgY2xvbmUzKCkgb24gdG9wIG9mIGl0IHdoaWNoIENhdGFsaW4NCj4g
ZGlkbid0DQo+IHdhbnQuwqANCg0KT24gdGhlIHg4NiBzaWRlLCB0aGVyZSBoYXZlIGJlZW4gYSBs
b3Qgb2YgYmluYXJpZXMgZ2VuZXJhdGVkIHRoYXQgaGF2ZQ0KYmVlbiBibGluZGx5IG1hcmtlZCBh
cyBzdXBwb3J0aW5nIHNoYWRvdyBzdGFjay4gU28gZXZlbiBpZiB0aGV5IGFyZSBub3QNCm9sZCwg
dGhlcmUgbWF5IHN0aWxsIGJlIG1pc21hcmtlZCBvbmVzIHVzaW5nIGNsb25lKCkuDQoNCkluIGdl
bmVyYWwgdGhlcmUgYXJlIGEgbG90IG9mIHRyYWRlb2ZmcyB3aXRoIHNoYWRvdyBzdGFjayBiZXR3
ZWVuDQpzZWN1cml0eSwgY29tcGF0aWJpbGl0eSBhbmQgcGVyZm9ybWFuY2UuIFN6YWJvbGNzIGhh
ZCBwcmV2aW91c2x5DQpkaXNjdXNzZWQgc29tZSBpZGVhcyBhcm91bmQgYWxsIHRocmVlOg0KIC0g
Y29tcGF0aWJpbGl0eSAoYXV0b21hdGljIHNpZ2FsdHN0YWNrKCkpDQogLSBwZXJmb3JtYW5jZS91
dGlsaXR5IChjcmVhdGluZyBhIG5ldyBsaWJjIEFQSSBmb3IgbWFrZWNvbnRleHQoKSkNCiAtIHNl
Y3VyaXR5ICh0b2tlbiBzY2hlbWVzIHRvIGd1YXJhbnRlZSBvbmx5IG9uZSB1c2VyIG9mIGEgc2hh
ZG93wqANCiAgICAgICAgICAgICBzdGFja8KgYXQgYSB0aW1lKQ0KDQpPbiB0aGUgeDg2IGtlcm5l
bCBzaWRlLCB3ZSBoYWQgb3VyIGhhbmRzIHRpZWQgYSBiaXQgYnkgdGhlIGV4aXN0aW5nDQp1c2Vy
c3BhY2UsIGFuZCBraW5kIG9mIGVuZGVkIHVwIHdpdGggYSBtaXguIEkgaW1hZ2luZWQgdGhhdCB3
ZSBtaWdodA0Kc2VlIGRlbWFuZCBhbG9uZyBvbmUgb2YgdGhvc2UgYXhlcyBhZnRlciBzb21lIHJl
YWwgd29ybGQgdXNlLiBBdCB3aGljaA0KcG9pbnQgd2UgY291bGQgYWRkIHNvbWUgb3B0LWluIEFC
SSB0d2Vha3MgdG8gaGVscC4NCg0KSWYgQVJNIGlzIHRoaW5raW5nIG9mIGRvaW5nIHRoaW5ncyBk
aWZmZXJlbnRseSB0aGFuIHg4NiwgeW91IG1pZ2h0DQp0aGluayBhYm91dCBob3cgeW91IHdlaWdo
dCB0aG9zZSB0cmFkZW9mZnMuIExpa2UsIGl0IG1pZ2h0IGJlIHNpbGx5IHRvDQp3b3JyeSBhYm91
dCBjbG9uZSgpIHN1cHBvcnQgaWYgc29tZXRoaW5nIGVsc2UgZW5kcyB1cCBicmVha2luZw0KY29t
cGF0aWJpbGl0eSBtYWpvcmx5LiBCdXQsIGl0IG1pZ2h0IGJlIHdvcnRod2hpbGUgaXQgeW91IGVu
ZCB1cCBnb2luZw0KdG8gdGhlIHByb3Bvc2VkIGV4dHJlbWVzIGFyb3VuZCBzaWduYWwgYWx0IHN0
YWNrcywgdG8gbWF4aW1pemUNCmNvbXBhdGliaWxpdHkNCg0KQWxzbyB0aGVuIG1heWJlIHg4NiBj
b3VsZCBjb3B5IHRoZSBBUk0gQUJJIHNvbWUgZGF5LCBpZiBpdCBlbmRzIHVwDQpjaGFzaW5nIHRo
ZSB0cmFkZW9mZiBwZW9wbGUgcHJlZmVyLiBJdCBwcm9iYWJseSBnb2VzIHdpdGhvdXQgc2F5aW5n
DQp0aGF0IHRoZSBjbG9zZXIgdGhlc2UgZmVhdHVyZXMgYmVoYXZlIGZyb20gdGhlIGFwcCBkZXZl
bG9wZXINCnBlcnNwZWN0aXZlLCB0aGUgYmV0dGVyLiBTbyBhIGRpZmZlcmVudCBBQkkgdGhhbiB4
ODYgdGhhdCBhbHNvIHRhcmdldHMNCmEgbWl4IHdvdWxkIGJlIGEgYml0IHVuZm9ydHVuYXRlLiAo
bm90IHRoZSBlbmQgb2YgdGhlIHdvcmxkIHRob3VnaCkNCg0KQW55d2F5LCBqdXN0IHdhbnRlZCB0
byBzaGFyZSBzb21lIHBlcnNwZWN0aXZlIHRoZXJlLiBTb3JyeSBmb3Igam9pbmluZw0KdGhpcyB0
aHJlYWQgc28gbGF0ZS4NCg0K
