Return-Path: <linux-fsdevel+bounces-40042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABB1A1B780
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 14:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0827A1856
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D770819;
	Fri, 24 Jan 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdKn0eFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAA40BE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737726914; cv=fail; b=f+OuDdPbO0P1NQBs21DguX9bc11CxMs+rsBB504YCS061UwtCrzSYwcArHr3tMgjAwEYFvI10fO+jt7hlizWYY4L6zxdBqulW6lWsKYs/zUh3THLufpZ41aBGrV1xN9SBT/en3Hz2rcw4I7ncXoAx/hA/Xamil3todm/zdeX0+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737726914; c=relaxed/simple;
	bh=LUFl1V64OdG6BULcgy6gfNl2NdFUdX+qimtUp2pLkkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uLOxQbWeEThrSJ3Eh5RUg4JIFGg9FvFyWEdoqyuhZrabPkZkNp5Z+msrLD422JORT+y2/VVHhLoBMnzSynFAOxuVizNv7zA83/VGrPYrEMqbcyMWZ7hjTJ1kNaMIIrQMQpCq6z/2Huar7lMLn/DiRY0uyOeBeu0qOP2bdGGL8Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdKn0eFY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737726913; x=1769262913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LUFl1V64OdG6BULcgy6gfNl2NdFUdX+qimtUp2pLkkI=;
  b=BdKn0eFYnRRa0MPq6pSK9H0CpoWDfd+xOUyRAnJ4w0OB/kpfXc5R8PDg
   XoSzh7MsMaasygwoDqLstt1xmXX5odQxgD93RDfH68rsxwIXlY52+P8B/
   Ae2uo5BJzFtewPtqtEMyHzCat/bCAwZDjBGCERlw0ULeKnyRW5vttOjXm
   3jwzbpN9Kh32lVQ3aRCUkhnzO35lpEQLFDBY2R8iFHhsCCzx5l2S+WxGa
   YozGCLtqhwNXHzenb7iIUZKkaxZragm4DSgRibe881jTLLc/vErshW1xI
   34V5fxRPY5vL6zg66wl3SlWdlaa1TqRW6Hg7VqzT0YqpB5fgOdFkSlhce
   w==;
X-CSE-ConnectionGUID: S/RuI2+5ROeTXuauc5kK0w==
X-CSE-MsgGUID: 3EC8Po+0QPW5IuMlETDt0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38404604"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="38404604"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 05:55:11 -0800
X-CSE-ConnectionGUID: 5pTUYF3ATKO6FZ2rTEJcmw==
X-CSE-MsgGUID: j6aa+i/XQzyL/tsUXQ+ZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="107586678"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 05:55:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 05:55:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 05:55:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 05:55:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9sKFGOuR5QS2UHT+QlafSPzAbKO55oFUrjOv0kyqKhVQiEaMmU/n/M2ZU1zudWwKwW3CrjCJNOMPfGjQSnd/xOifSEj8GzjBdcxEVbCnOhUBiaP7pdsk9THP7WFL7xCJSUOa/AgD0LrRjsfEOGXCNzE9/57vhxpVbdnJoVZtvBXvAqAZRd7A0A3igzKwLeD+x7L2kv0hMfDkxRqMK57HxKe1KYjc1Z+30/e7Xxxr0u7vCUvRjK+ThF+HPbCZIxe0Y+bOPbGVWtCOiqvQ2k70wRKNKOWzTKQOpKuQgT3/mNMu5awYyej7PS8aVNAOLJuRLBA56NtBLND9zHz0l6NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0JYhkCogxMT06Fu9uFCPzODjDpfcJo/kJfgmvJg3Zc=;
 b=GK2VnMfsVyZnnNDDq+za/asp0LGuUE4WtKh2/Q6TTRAFVznDuSmyoKTZfey7cALifCCGGyDqDbfDAjqhYYHmtVhxWJmKFw2rEvIbgimAoOmyrR1s8N6JUiEiVc48GnnBRdIxIWjDcvpegsA05z7dzQLJI8mQdMhXBmlzdRRZDqapi8WqVi69m1YhxERtFCVen5r2mI8KQZUqVn05gYjr/waFPtIOCjYiCWIog+zUvALslmhgtxHVyDaNs5f83BTU0aK61eg1Qe+q98RhQ8Mh6JDzIiBJyhP+puHewbudLPcA5UiE3kvS6hJxIWVFhjedl5ZfBGzXLH/f5SDvbDLpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 13:55:07 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%3]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 13:55:07 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: RE: Regression on linux-next (next-20250120)
Thread-Topic: Regression on linux-next (next-20250120)
Thread-Index: Adttq6oN2zvxaQC4Q86QyAJ6tLuOCQAF5fmAACkB2NA=
Date: Fri, 24 Jan 2025 13:55:07 +0000
Message-ID: <SJ1PR11MB6129495D3574B63B0AB338A7B9E32@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
In-Reply-To: <20250123181853.GC1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|MN2PR11MB4518:EE_
x-ms-office365-filtering-correlation-id: 0f47b65b-97e5-4891-3b5b-08dd3c7eb5e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?r4RDZj3TElkrJwq9trRTjZN4TnR7kqaw0YYa+Pe7AX9U3+SI3rEOnZdS0z9y?=
 =?us-ascii?Q?8C4ztH8vK3/VdE4z8NXUI3lFWAeKIr/RYh216FeHOu1CGEpg1zOfG4xBENYt?=
 =?us-ascii?Q?NJrUUhQ0lBfCy8HV31bK5Ub8EPj9Vb8tPV6XXFsnHIdasFEBfPMhtAHkZ6te?=
 =?us-ascii?Q?+2wbio3nWOrDH3xhTTdt6BninBQ1P5Zv1KML99RyjDj1cgpWvBEg9v2RvR2y?=
 =?us-ascii?Q?OqDeQQJJ7ii9gHJ2USeLoNtMloeHCWGzuwHQX6cpWsDVvFrkXENNc0RJUIp8?=
 =?us-ascii?Q?o2Ci363+WKuFcf5tfaCiBxGD5QKbfEY353C2CrQTEDu9+JSvWRxtx8q7gAOY?=
 =?us-ascii?Q?jtUMaDLi1ES5hLBXRyPSGqqhZi1X43DJo5agt3uSsaeU9vic18k4mW3eP/ar?=
 =?us-ascii?Q?TrUJVX4qRjHK5mF8fceO9KZm9j+QBu79EumTPcuf/0WXYM7B/V3f2mQMRqZo?=
 =?us-ascii?Q?XsaENK6mabC/kut6GLPRimNJ+oh1a/Qn5+llGZUGI8uUiQJXI6oK++NVJGKl?=
 =?us-ascii?Q?qGkl/4eNn3IT+wVy1v7UhNQGQS83UDa3jIrv0QzAPPSg1YVyzfgdaeC1JAUU?=
 =?us-ascii?Q?WiBvdkxt3fLjjSmAU3KPXUYoyFYRIsHxjKUuFxCms7vXUISiQLm5u7JUdYar?=
 =?us-ascii?Q?AUXQ58z001whM52K9ar1StDfwjUKvS6idIzyWw2PDxZBMsPIAgHC9Szm/7ei?=
 =?us-ascii?Q?X+ZHaTnRFkld4U6ETYh8FrxXwxlO3ubPaBkH7sahGCKtA70NYKdhUFVXLahr?=
 =?us-ascii?Q?kB6AceKbIlTgXk4kAtKcOTO72JrAdzzRNk2okS2AspwFosP2t1C1HCcyLpfz?=
 =?us-ascii?Q?NKqdmEu5R23BRhnD2rnxcy7mstuwLzObK9JFad+5n7xbwrjnE75QO+pSkhIo?=
 =?us-ascii?Q?CRMXrhTZFThh8mw7XSPZDmDsClqAOggQOPqKlDRCvTN15uEplo0Q3a3x8MkG?=
 =?us-ascii?Q?bHAZ4W5pYvAGfQeE80Zz0DXkwyXQ8u2EmxtSsbdR4V4/eUyKnRJt6qRpmssy?=
 =?us-ascii?Q?C7A7CV74VtFlWUin0e70+vpMo6NJ/9XPeQk2NLfsuQn6tdQ62XZ9JG73Gft9?=
 =?us-ascii?Q?u46cFfxCvxokmeslmAQ27Lq00xB7wk2j8oWw0JKYeHMO5Fn5NnlEub5yvV/i?=
 =?us-ascii?Q?WHc4Z72VklEdQFFnDNr0DuPSKWlGNuz2S+P+qJggvBN1Tn9bTf2MuJTn7+/3?=
 =?us-ascii?Q?ai8YG/5MGGCg3uBrtar8pr7XcHEBZeLJ+SmzRlxo70UNshhifT/YUIVfy3OW?=
 =?us-ascii?Q?NMet/IxQVKxAAa+KjBaInIGkQ8Qh0UEnIQ202L5rsrU/CDObRnmhCMYHK7dI?=
 =?us-ascii?Q?4x1tvVTLKicDMZ+xmABzZHJVms26NRgU+3ycUospflo0QS8LViBTRCrZw0cm?=
 =?us-ascii?Q?72rQMYZnxontm5KQ+NY8HEywjQT1U0+n7Qr1CYICgUDtv6kaSjxBIE5t63a4?=
 =?us-ascii?Q?SLrMqIgqdyuVpkjq83TtMk9T6U7nbj0N?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9PMQ0MzV2s4IcPQlqRa5QNIAOHJkHaF4JUUtpp38p7e0kVVrJAM6P7eKs1/X?=
 =?us-ascii?Q?xo/IV8fcXXDRSnCGjuVILUSn2uFIYjEzAUlAqFLgmwzqBGlb/DMpm4pXA9ef?=
 =?us-ascii?Q?8NJu29g7IyKQOJBA4QXayv/To8kV+dh+0KUFpv6B/qOOtSWQ8Qg5FtmtTemC?=
 =?us-ascii?Q?bwxc7InmHaw+dEYWF0X3oF/gIVve4ZrQGAv7/ovf3/C2ss3hVpAgxL657TIT?=
 =?us-ascii?Q?teoAUrhsIY+h0sRNMadCbAvL+cYriiyfm60y8KjR/hABCoBM7fOPb8ONscwR?=
 =?us-ascii?Q?wM2OI5mqJA2vq/3DU5KnN9j8jhQG/rjlItHuoeGDh/eAf4VKM+v7uDB3N34D?=
 =?us-ascii?Q?sKluYsE6MRyCtIRjd4EDgh7vC/xKPWjcX5qYtU2q0t0uWe51T648CVLPi6D7?=
 =?us-ascii?Q?MoIh0kJqtegLYoXHpEIE8BoF6Zrof/8Prrp+hLM/JrflVEYT0qisZtYplyBB?=
 =?us-ascii?Q?HgMkolYgGL9m+EALNjfv3NJDSwS8bB5CFlHYTeNavPCW5M5eXi2BWV3kOhUy?=
 =?us-ascii?Q?Gi+NELjUr8fzDRkRXhHYMNxOR/ePt1hqIHWv7Xq8p9c4WeBn6A6DKE7Ep4Y2?=
 =?us-ascii?Q?t4sfgR1xxjxzf6GlKdvTk/B/v+Qpu+Qo8hp3XK5sDws19DxM8qlI10C2lMr7?=
 =?us-ascii?Q?2NDvasSxm0yKxeYTSgw/fXprSwadm/o5eV87axliH6Rqn6f1XlagPtqdy9qv?=
 =?us-ascii?Q?4kmwfFwSl6f9/Wmr5gv3PzBM8ib8xztjAWEj5+GEj+cjjo77QD05BpXwKy+z?=
 =?us-ascii?Q?0sZQJ/b75C+JZDeROiWoBIGli/Mff0wDYtuoYecmg7aALG1e6Wvqk6ifNet/?=
 =?us-ascii?Q?ETv1l8OpauvVauvD7iP6SrFuQjRZTHCkDZNfrmHY4EotQJrmHdYAJG+tYFpM?=
 =?us-ascii?Q?U1XrocFY6g8X9oFcOlLeAWiX8ZLKTB5NRtatDeh7oYOg46oGmq9HZaFzv22k?=
 =?us-ascii?Q?KPTkLj2iFv+0RalpNdpY7FjcVJYiDJQdDkSceXthbtDTt2KEPh5tXNNOMBeh?=
 =?us-ascii?Q?hhjeA3Auz4dc1e1LOxb9vOyWXkS8n/+szN38RT0Mm5jIFD48kL89yPLkpi7d?=
 =?us-ascii?Q?qVTiAi69uQ02SlsJxXM47EIGSy0OykGYUYPiYXq65qX+8D/FxW749j5sKHOB?=
 =?us-ascii?Q?LdE37IgL2EW3EkQeFCtRFresJtRGq/LjzW/Y0vKI3f1Jj0vHTPo9/dCw9oXk?=
 =?us-ascii?Q?0UdqvUZpcyskPUV55MGFS5BdMCzXagOx4eFh9rXGBkNmZnA6vHnvOBWtPCri?=
 =?us-ascii?Q?Pk85cd86PGn7wyupaDCQx2bcRJU6JmRLeYJsm1n+gLK0YuZwWZnH0shJ2vv5?=
 =?us-ascii?Q?aEGcFVEHHq2lU7aBrPS6DniLd0ZOLow8jMEXaU1vwGl6UCkrVOye0ElfFuUB?=
 =?us-ascii?Q?iTqx7ruI/8csAuHPogMsy8ira6YJCUr7HYwy/1tN92mIaq+EV3POnIsgjqyQ?=
 =?us-ascii?Q?F8jcKE+LlNaDntPVwJ+9BJR9A2fouTQ8kwm1CPYtMDXYMVp9R5bKj3IPhFdQ?=
 =?us-ascii?Q?pNoQW8NYDBuyczKSgrkqIdfhdOhfFucKs0ni5A0pzSYjRgX/m3wL6/fEp/iH?=
 =?us-ascii?Q?ukiRWGj6oAltfGiqRY2V6c5s682DzdzXp2XZWL3P8gb9YVGmHBOHDHw5Or+Y?=
 =?us-ascii?Q?HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f47b65b-97e5-4891-3b5b-08dd3c7eb5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 13:55:07.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iADGqbCdDgN1Jw22IhZSEIz05mQGZa+HqyTmWdIRuXLJQRz1tVh2ph/S2R556+f44WCD+t58ROYWuKbMl1ljXOrAM3jmF9Kj+giuAzm0R4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Thursday, January 23, 2025 11:49 PM
> To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Cc: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; Kurm=
i,
> Suresh Kumar <suresh.kumar.kurmi@intel.com>; Saarinen, Jani
> <jani.saarinen@intel.com>; linux-fsdevel@vger.kernel.org
> Subject: Re: Regression on linux-next (next-20250120)
>=20
> On Thu, Jan 23, 2025 at 03:41:08PM +0000, Borah, Chaitanya Kumar wrote:
> > Hello Al,
> >
> > Hope you are doing well. I am Chaitanya from the linux graphics team in
> Intel.
> >
> > This mail is regarding a regression we are seeing in our CI runs[1] on =
linux-
> next repository.
> >
> > Since the version next-20250120 [2], we are seeing the following
> > regression
>=20
> Ugh...  To narrow the things down, could you see if replacing
>                 fsd =3D kmalloc(sizeof(*fsd), GFP_KERNEL); with
>                 fsd =3D kzalloc(sizeof(*fsd), GFP_KERNEL); in
> fs/debugfs/file.c:__debugfs_file_get() affects the test?

This change seems to help. Can we expect a fix patch?

Thank you.

Regards

Chaitanya

