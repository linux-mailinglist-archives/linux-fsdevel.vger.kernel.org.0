Return-Path: <linux-fsdevel+bounces-2330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B17E4BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 23:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C27E281442
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394842A8E9;
	Tue,  7 Nov 2023 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRddnuuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6282A8D6;
	Tue,  7 Nov 2023 22:35:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386D711F;
	Tue,  7 Nov 2023 14:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699396512; x=1730932512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8mbW0k9AT+wIUX3FiL8LDj2M83SI4PICFuo61f/PJB8=;
  b=iRddnuuFassW7gEQiz6UGkw3UBOAfIk5ORfTvTe1nU4qZJznmLziwtOL
   pBaWjiy1rC+ZH5KltM6utGr89JR0oR0VuW6JXMGbMcvf5EpOVs3CzoxPO
   fGYBmmWIH1Y8tfGzESfEi8hCncXDoJvscYN33XROMNJkwAFL+RQPDVxQd
   K0KqFQZwKcoGzwLPqhPNFhuJtZPiiQBvLpi9dyf6VQjhQepPdbIuWc9nP
   Rr7cRK3dIBDh94Iw/VY35kkrsVfeDaw3vDZnIB3+Od0YSuuJZkCTMLo4K
   TPd8ISV1iIiGbrOO/XAd5YGl7J3KdR+L5c7PgBklyxiYEhDIMsG4gRGnh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456135336"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="456135336"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 14:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="879991392"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="879991392"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 14:35:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 14:35:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 14:35:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 14:35:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 14:35:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btr1lufzakKj5LyuuPoUviciL05S/Nw0hdQO+VrVl1uwV4KNXp7rzagF76qLx1vXfVCZx4XwdS/ewxRBxow3aWQGqEUaIANABqUkReBxuMa1UzkO4fC+13rCZ4rBlpDIxaE5qcnVPDFzyaEqAvk/PFCHibmzXDtQ3P6TdJr05PV+6vG4MSWwiZ6AF6AaxoJz6NiZ+v0CeZOubqm7VPWutxZxHeKPrylq7ExAW22fQAcUDgipxrlGcvrwmIrcAMdEoN31xonzg/1zTMJrnqX6/zhBg7D989fS/QSPbklTCJuCn6j/6UzWGXbUiMtc8nVddpKWrqXGHsTnWsyxdkjVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8elskuhWO87UbvXHJbZz4ddyw5UOPZGsd6x/sRkKurU=;
 b=ayW7RHZPmxEat8fxeX+gE2daA2GksRzJss/Rbg7R1P275XwZMZ/dbCNtyx48HdLkCpY1HAKICfvJa3gUUNEUQD33Ay+bZW2br8JS6PmMvhZKQluh4TkSn5S/22pot9bjVKuNjrACVcMPTYPgj4fLx9aGVYpYkUQAHISHvQGdGSm4wDebFfR98Pzz1ZpymbwA2sz1s2Bx3JM4vD6JzUE4E9Zs1RO+A+7WyLq4IJFt7FX8xeBc5Z/4lJAyB9Xtf1XH1piKXyhNMbcuS+w/ogejNnTFNbNQxPhiGjmeFwGRfCEazUccRLhoOzL3Gt7VeXiWmZnBSGyxITevBXFYSAsNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 22:35:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:35:05 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alexey.kardashevskiy@amd.com"
	<alexey.kardashevskiy@amd.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "avadnaik@amd.com" <avadnaik@amd.com>
Subject: RE: [RESEND v5 3/4] platform/chrome: cros_ec_debugfs: Fix permissions
 for panicinfo
Thread-Topic: [RESEND v5 3/4] platform/chrome: cros_ec_debugfs: Fix
 permissions for panicinfo
Thread-Index: AQHaEcKr1J5zEbq+GkWqCCH8RgaS4rBvcArg
Date: Tue, 7 Nov 2023 22:35:05 +0000
Message-ID: <SJ1PR11MB60835765F536429966023B01FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-4-avadhut.naik@amd.com>
In-Reply-To: <20231107213647.1405493-4-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: 7bd01a57-478b-416d-dc8c-08dbdfe1ca39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HvqobJzO86WSZdsGkT+J6S7WpMHHdxYyR7R55oQBKhL6kW7JExybiB9qJI7YUpSwYnfh4T3awei+rJVYgI4Zlw2jDaqFJnMMqB4T06QcB+91c397voR00C+/c508sAXOogOPYj75zUKE7mk+p4O2IfWtbj1Vk5GAg5cxQoxFlXqPkUwibTi96utJ0JhB2HB7FzmNBNvt5U9Pnp62xwgx41UMGSlQ+BvOGJOm5iVQRJCgUoytXvPcRDVTtq5YU8Ev9vqSx6sv8E4dYVp4ddXKxHgaBMKdB4mOfLzL3rJclvC45mA2i6jF3TOBhZWfK2TKxWR7y9jCTp8MDeZqknpl+/pUKovwBo85vV0E3dE6LqShMz0QZbNQysmE95LXPl2/LCi6oOKpreGe3MX2YoVCkiDfVK9PHDSVQLHfm+hqFaTzPR4Aeb68tbpdLcCA+jrmv6IWpXehcIfBhrr0KH1nTKTslJzncJSUFHYl2PflKvUayRYW6N1alxB8YXUntu5uOqmFysDclS67pbXCR5WIESzhdOzwx3gPXSPtxbGpbzwJM3zES2ZEX3a/pAbnMjbPd/BmTqMnfTeftHf9vw/zTF5Z7qwQlpkyD5gg1XFSe+XReuNSC7Zp9AXhnxSyXq+T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(52536014)(4744005)(5660300002)(8936002)(8676002)(4326008)(478600001)(2906002)(41300700001)(7416002)(55016003)(110136005)(66446008)(66556008)(66476007)(66946007)(54906003)(64756008)(76116006)(86362001)(316002)(26005)(38070700009)(6506007)(7696005)(71200400001)(9686003)(82960400001)(33656002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wGOISgjLNSC6yjPBWaXlC08JIx0LP5sNl4kPEFmSrjDq+puu/xgOuCdbc/6z?=
 =?us-ascii?Q?gPTjxuq6pxrCW5SPHSD8DZiyoY6gpwOdnTSQ9zgl51GJZ9aGfB6y3hxecoaH?=
 =?us-ascii?Q?NwT3HrI+uabuKk2gF2xK5JBF7GaGOdny+WHtlNCzHC0HTDnqNn6zvunsXzDA?=
 =?us-ascii?Q?sOH+K3SRMYOHX1ljAx6Dm0vXGwChCqbnMlsBEOAHNq/dqiCcmCp6+G+ptZkk?=
 =?us-ascii?Q?57OllJo/EeFGoexEkV7oz51RbFLpdEj8LJIffPp6cuxf5bIIT44Na+e5OLyV?=
 =?us-ascii?Q?hmzzVoRiqYeWKp416Q//ONqRyLMy9YoEUYdkiUkyOIPv/IDTutfYtdOaRNlL?=
 =?us-ascii?Q?ME2aPbKPw30E9iN9cR+j6/x6cpcZe13gRivT/EMMwYLNZICE2He++4Gz6/Xc?=
 =?us-ascii?Q?/g69CIrzhTESFF5lGA8yuABUvZKumlpw6u5oKz4tjjbdRtBF0fN6sdznm/00?=
 =?us-ascii?Q?HWdwB4x84zwYAxOfP7AneY/5hfbl7KrnxTxXby9OP7WG5I7SqTNu1EntCI/H?=
 =?us-ascii?Q?Qe7VELgJW2X/jv+9GmyX2ZS9AahZ1YgsueDiPXrEwe6DihiPd1655E4pozeO?=
 =?us-ascii?Q?2ihV/ZPmNUv8Nor7SyMeAt0MYcStue+bVdwDGVVwGH0P8uSzKNBArzQPQnCD?=
 =?us-ascii?Q?8TLllrZxtWXt3gMKs42F3b802gpCo1qFFms7cKqkqjVxcxGdCq4tz8eMxzS7?=
 =?us-ascii?Q?/ImjE2kV5AxG26Y1lJpUih0hepw9+YIRotQCYeX3C7lQn83ynV30Pn5MXXOo?=
 =?us-ascii?Q?szMPCrxebNbf8Zafy63JHYbrbtx4boRwGCPQRw6ptUpvIdt85GybuuOn7SU1?=
 =?us-ascii?Q?Zz6gReqWsuoSuIaf5TghWLSG2PaCIb1Z3PJemMkt/sADy6GnhW/gRehf0x9p?=
 =?us-ascii?Q?Ag0Hn1YawkdCvCZ4aSrhWb/mhpejZpkDFYXZMBDVd+3c63QVxVKskCZQ+Vtx?=
 =?us-ascii?Q?TUAL+YoG0GUEfHm1aWHlkh2476nf+zR8Gnb88w4hSPUnyrNcfd/kAKBkwipW?=
 =?us-ascii?Q?MVtzAeBLODq/a2hb+TlfqXD3AWBeZWL60HT0E9lpkc0K5r7H1X6gZwLznjL8?=
 =?us-ascii?Q?W9vVC45uWnYAQa0phRxftVanBNFyWSCrB6e4ZO5B28Nr2AbhdCbDcjRce46L?=
 =?us-ascii?Q?Lve3M2d0OAHsv8jss+S4wv4sCTlBl4VSEPjWI3/vYzx5UsNJWqK18KLE2lL9?=
 =?us-ascii?Q?+d6JQHhHySw/5vlznhC61d5qaauBudJjAP/cJQ21EPUm+GOQKkAVKmha7tte?=
 =?us-ascii?Q?wA0KUPUs2G0ioS69aXExnZK5zhHsRYQoKfSaQWrKIdfSjaLQrNVxHkItH6Jb?=
 =?us-ascii?Q?CqB7TneyKcVMdSzM3dqrbRDdhWj2woPQugrB8fNh1zhA6BoNk1yF+UWaN8nV?=
 =?us-ascii?Q?SBzil9cPTl2Tyi/LojaWkgZexwx42G+0C02yjjTFrRbqpscQzAxOFfgZ54ky?=
 =?us-ascii?Q?6TYlR+7UztsAgyPDvs7f0FfVlCj9udSP3pHxtIIHlJdqHxBBoS7/PqNwRC76?=
 =?us-ascii?Q?sXhYtX5UNhFdHtuHjQxg1EfXxo7TKgCF2uxyhOpLubyhi8kDcgVqUM5Qz9/5?=
 =?us-ascii?Q?kZIAEza4Eol90cp4dePDsJlhkjeF8cH8VaJ4fr9I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd01a57-478b-416d-dc8c-08dbdfe1ca39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 22:35:05.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bun3ltUDhUrf/5bGjDDP1dqeLjxJ0c6pYKhTsx7h1O7XEySkDgJtpDViVJwdF+07/ECXQh19NG8nNRuIcPvmeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com

> @@ -454,7 +454,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_de=
bugfs *debug_info)
>       debug_info->panicinfo_blob.data =3D data;
>       debug_info->panicinfo_blob.size =3D ret;
>
> -     debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
> +     debugfs_create_blob("panicinfo", 0444, debug_info->dir,
>                           &debug_info->panicinfo_blob);
>

This just looks like a bug that S_IFREG was passed in the "mode" argument.

Your change in part 2 doesn't really affect much here.

  debugfs_create_blob()
    debugfs_create_file_unsafe()
      __debugfs_create_file()

which does:

	if (!(mode & S_IFMT))
                	mode |=3D S_IFREG;
        	BUG_ON(!S_ISREG(mode));

So this is a fine cleanup. But your patch description about ensuring that
the file remains read-only isn't accurate. Your change didn't affect the mo=
de
of this file.

-Tony

=09

