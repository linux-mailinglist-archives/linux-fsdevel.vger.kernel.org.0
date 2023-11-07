Return-Path: <linux-fsdevel+bounces-2331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C77E4BF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 23:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF14B21060
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91ED2AC26;
	Tue,  7 Nov 2023 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9jxphw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550B436B1;
	Tue,  7 Nov 2023 22:41:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F77DA;
	Tue,  7 Nov 2023 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699396903; x=1730932903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h0bN8WeuRaDPDfJTRtaVbccZtSnx09RDR21SXKOnAbE=;
  b=N9jxphw346Ko8WA0EveOhWUiQPfT/urbiOCr6NWDEWWXESXr0kU9vv90
   sPlk4YQgkrHxaIElHB7omAwuXn9U3coX2bx9AuJQgE1D+UmLtm9msDaVM
   NzcX0MCF8LBAmkx7mcBXcLk59t/2rYde8GMCkP7V8U9V3gxTb9viB1n7p
   kIygOzHeK9F71SHU5YaDIGGLgpifWeZIT0xmSdE6uXy6n0BFnkt/nZ8bL
   igl1HwdF5r5c+3ypWo6KE4tDxUMCqRy36lGxdQEpJg0CnMp2XmwTS5CFi
   YNvV7FZvIUjJOQAMAVpKZ8TVMuuaqv5rb3zfrXwMQiKHwUVokQFULfYof
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="453943945"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="453943945"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 14:41:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="766464301"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="766464301"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 14:41:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 14:41:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 14:41:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 14:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXXl8UETKuOwQATU9655g1FWudb6e5Ly01K1h8fMb3u0qUBNghJENpDp9SV2O6a2knKM7hAHwSeHkMMRDwklAQGo00dV/jXrmHLfKWIreZnwP7E/w6VoFD+4tAQhEUIf0cpq4c1VVqqcJIBlBK+wzNbeAKERjtxrOUx8NabMdl/8EdzZMcus9jGXS+C7U4DokdTmMPU99oE0+BGfllHJ1jHAKgCL/qLKd0NTpO2eXutzahjwnjDlbDJpvBoik4TmmSvBEyCF2UF9buMlBjYFbdCxY1B/WRYXl8EaU80nZqM2oZautiNtLvbtR86+cITRHaPYu0n5wDuJWw+AeVOyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KILBzvJeiaehTR7xxNmZ2IGW+BC7TTPvPACoiz0tfbw=;
 b=V6O0ywlfU0pv8OmEuQbHdFXaOH+MKWL+gOFQTMtO7GUuMd4MTV3670QtD6VfQasQAGyVirFPtw2DYOI3zYkb0lszCJtVwWSZaNlHXODiBvvwroMrHfzoqZ4+8L9FgsKGhg4pV6CAH2B1nYN58ad4ZIlPkiAN9w9b2RfNlhqly8EhoRJf5WTv2RNvLPZGFHJoM6EHnebgDlzMlqXcEpNq3P2m6+6Fk7uaGOPLrBXWmbenCdEvWfIrZH8deSdAkZqIQNPJ0oFAJHsHsa4cTUsbuZIlvN1g7mo8I+0xThMwB8pB/KPfwVP/Jd9TpJJJ+x8wx6Vn0QjjXE9FUZMM1LyLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 22:41:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:41:35 +0000
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
Subject: RE: [RESEND v5 4/4] ACPI: APEI: EINJ: Add support for vendor defined
 error types
Thread-Topic: [RESEND v5 4/4] ACPI: APEI: EINJ: Add support for vendor defined
 error types
Thread-Index: AQHaEcK7g3izF/gieEWzpZXwY8tUrLBvceug
Date: Tue, 7 Nov 2023 22:41:35 +0000
Message-ID: <SJ1PR11MB60835E29BF7A8EFA11E44FB2FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-5-avadhut.naik@amd.com>
In-Reply-To: <20231107213647.1405493-5-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB7584:EE_
x-ms-office365-filtering-correlation-id: 69221a2f-ffd5-474f-0b09-08dbdfe2b25a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0UaZ3318+dHj2KzGExFZd8xo4HDpxEwgFLaba2ljPyy83jGDHhVA3frJnqr8TxjNOaZb9XO/lClqpjHvvBM/azWxWIR9ENDlPSmqqli7ppEWOLjpHANf+xwg9QFNK8lOVaLPejt55vNelHjum7OLKBg47dU71d8xwjqvJmdxrVYJd+zgML6GwfT+wG8q1kNGKZn4KCbJYGZPv+BZ2YNrIxD90l0d19YO5g8vW5myGlIzGPhC4tRg7LXiFtLY46Axw80SszeDAEsPf54nSO1y+4MQ063lRfKjj0JLa3O/ldofFMsBSa0sv5DHAlpZT69wTpdUvQMl3bmtvFUz1lahBUAju09cAimk2i6f/5qrw7N1TUVg6n/1A8nWB1zyxkV8LXD8yH28GB1GD+aec0umRzYchdSSfbNZ7gh4TWocnjNVQyReMRr9zGOUiKGSNZ9cUXZ1NIKH50u4wHWa5Vgi+ZcQu/iQY2fXqdz90qHdgHrUk5it4IYs697BjLqToNh9boLWI0moMon2enxawr9QALI3D8tIvu9mtOlFljIoSz6J4xGDQ2jaJehg5e51WmB08xN+zTIqef5L6IOe+5+k5kjacXX15lu7VuPbKCoGzQCjEPjTf2HpgJvljm85MkjfG4I+U3pUIrF7oTwytRnXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(82960400001)(38100700002)(33656002)(4326008)(38070700009)(41300700001)(8936002)(86362001)(8676002)(2906002)(110136005)(478600001)(71200400001)(6506007)(7696005)(66446008)(9686003)(122000001)(7416002)(52536014)(5660300002)(316002)(76116006)(64756008)(54906003)(66476007)(66556008)(66946007)(26005)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M1K1AdGHKYHJZXItjMdYumBTxGZU5PAQbTa+H1brJq6nyefYIisP1zHaRrAl?=
 =?us-ascii?Q?f/BIo51w73nWFghu/52GaWV6md525M4F3V+dR7cA3YFKVURSlt/nOCD525wX?=
 =?us-ascii?Q?lZyxK2C3FMVv2bkYMKL/k9oSVp9y8nrZAD4af+VzVkWbFayZhvO3T7mQogbj?=
 =?us-ascii?Q?yAougpa1jceOSqtyvBG9NAyRQVyFrunGi5Cc6iIAvPYFy3ulGx+Y61alDgai?=
 =?us-ascii?Q?uF1mPa8KaLvM5lG4EldGANRpHaziqqp3cfj7VeRtmx1TgeeTvUYnydpb3qMV?=
 =?us-ascii?Q?2wsKYA6wF8PnJw+sfbMMjd99dtbP/uRvMmtsVdF14GImr8ibjgyUVikGi2Ri?=
 =?us-ascii?Q?xlVYFJ3Q5vWnDqIuZM7dXrMyScumpoS6y1i7fIVe8+EavmwT/o19B5bl9Mxy?=
 =?us-ascii?Q?d9XsOx09W+28Dg66Q2yreA/ejq/y6u7nhjCURU7vyARQVPVVBQ4R45nV0zBS?=
 =?us-ascii?Q?4LrPDVK7PcMg+2nf9KWSi9kNVtb15a5aIq/YBoew8ftvWkARNqQB6pZwFREx?=
 =?us-ascii?Q?bAHMvJIqcVd5ZMuqwXC+YjUz2xjK/4ooeWSXsu6wWGNbMdY7lpX6RKJNVb5z?=
 =?us-ascii?Q?isJNnU+4WBfLaacCSm8xyuK13CzYWxLTOOB0WPMdNgRKG7iZZuYv6lch0oYb?=
 =?us-ascii?Q?6OFMeGbB6tKh0HltwYtrZAfcZz7xnTyJeSlW6mjWLBx6JhutVEYdAz223CjI?=
 =?us-ascii?Q?gQ3jBWuCqF4FmO+I344woDH7a5kfsv4ETKADcRZq/RKFbZ1Xc4PMASyVbsC5?=
 =?us-ascii?Q?R7CQ4+QqSde3T1+wKmcaJWywE/xjEoFRUAZKvw0RrOtu2Qs0erst2xAEaUZ/?=
 =?us-ascii?Q?VxV93b6IxJFXu3pzTuHJRyDBnsjjlRLHBY5VX/gwXWPDtw6qHqtJKO8fosaI?=
 =?us-ascii?Q?qKl1E9T5/nGpiBhpwPt5j4r1CdMU/bIEPFL5vt+gm09dFqGBBURN8cmJfkJy?=
 =?us-ascii?Q?ZY5pSfpxJ6dRKdRzBbp5n+KR3hYO02HpdjVNuYe1bd8caUOdQh6+1+k/qfsU?=
 =?us-ascii?Q?rZNawqRgdyJYjqIuyLkDFMuqC7IMh/bZz7CpzP1MyNATBunLI1gz+S9brUr0?=
 =?us-ascii?Q?pS0Oo4hMmSABuoWZNsbCtkYcMONWS/tSR8vkOF7/x/PM5Q00vPFnX1BOm3a2?=
 =?us-ascii?Q?lEqNaMHzD9M74P2omnIU0HYmK2F/XzXwbfAtb6iIIK85hoS/Z1bRyTSnYvg3?=
 =?us-ascii?Q?xUSAy18PxdxZECThH4CLf9KKbZe+30HyUFZ6uFlPGvG+hiKI8sHw15y4Ja3O?=
 =?us-ascii?Q?VWoQvrb2R3MO0ULi9eSzE+wK7SFOcXel9JBUGyXrC0MPlY7yKz5QfDAikMJt?=
 =?us-ascii?Q?qWzR0A9HKPOO+Mh1b4xrRGKOQCIPYwoJBajreZMXvaRXOloDe+hJBs1xJPvA?=
 =?us-ascii?Q?ewHE6lQB15e6z0PRRJHQAzu/KfLsZvD2qbs5koxe6cAypF9R+j0xg/XkHgk/?=
 =?us-ascii?Q?zVmLVWEg5BacbASpRm4jHo1o+EYihhvLVfVDL+NrOwzPNF2erEf/lWN6RlBD?=
 =?us-ascii?Q?NFRWYfa8Kn+TRVQ/PGNmxryYNLMbnYxraWyJgRUHLBvrbeTsWRCnI7Ssszma?=
 =?us-ascii?Q?FqVPNGm4UaSTVXKaxU2dw9U+Cp9CXsR8krYHNkEv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69221a2f-ffd5-474f-0b09-08dbdfe2b25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 22:41:35.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0hGr4gRU96R5ERZefddZh7tWjaok7r8l5cBN7g4Zg8sL2arcqxWAUVd6FOLG+HSQs+erKNzct+Ckd3yk5YtuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
X-OriginatorOrg: intel.com

> Circumvent the issue by computing the physical address of OEM Defined dat=
a
> structure and establishing the required mapping with the structure. Creat=
e
> a new file "oem_error", if the system supports Vendor-defined errors, to
> export this mapping, through debugfs_create_blob(). Userspace tools can
> then populate their respective OEM Defined structure instances and just
> write to the file as part of injecting Vendor-defined Errors. Similarly,
> the tools can also read from the file if the system firmware provides som=
e
> information through the OEM defined structure after error injection.

Tried it out on an Intel Icelake machine.  Seems like it is doing something
reasonable: I end up with this "oem_error" file:

# ls -l oem_error
-rw-------. 1 root root 0 Nov  7 14:26 oem_error

Which is 24 bytes full of zeroes:

# od -t x1 oem_error
0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0000020 00 00 00 00 00 00 00 00
0000030

I'm not sure what OEM specific errors are implemented on this machine,
so that's as far as I'm able to test.

So apart from s/0444/0666/ in part 2, and a better commit description for
part 3 you can have a:

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

