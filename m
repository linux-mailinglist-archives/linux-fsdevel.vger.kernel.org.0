Return-Path: <linux-fsdevel+bounces-2329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CC7E4BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 23:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C9281417
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C302A8CE;
	Tue,  7 Nov 2023 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLgFYDe2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5E2F870;
	Tue,  7 Nov 2023 22:28:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437711B;
	Tue,  7 Nov 2023 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699396114; x=1730932114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IijC2X4ffV/3SPaTz8h49agNQ4ppRenMnxP5Uh3GWEg=;
  b=FLgFYDe2F0LvVesWPUUWmISHq0fNBVaVJTQA86qgOhi43XC7PYwSDHWL
   XsPi6JsZ3QS8Lb1ST7+z3shiUu/NXH5fqr2upIpAVbOZturA0fYINhUYi
   GxjuqVAI+9XC3wfyXhG4r7q104vvOhqWfjBUeWQOda2mjDUzcubye5Tj3
   W9dC5QqbTE3FrbhleADYGGbWDdFGxjaUkJtFCXUZAo0LuHOGTbqblx2NY
   rGK0hT3kz6CYIRZ/mI6XfjTJRP9XjOWTu18omtpHT5m7awrczr2ESQ5t9
   VP6JpooNbHdv7FtEdCvIEDjZpipnv5GyqGH9Vb6ar1/W6KshiUbPKs5QJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="8288706"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="8288706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 14:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="3982990"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 14:28:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 14:28:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 14:28:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 14:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlsSbgonTyYoVjOvuvQ1Yw0CvQ0kH9RCozB0BIsjpjeY7Lhw10MfyqQ1A6J9u58ReZloTHMpi8IJS7pg2WwHH/sT5ymwQQlcSWxfCzqrPaxE2yaJ9SOuly1CzNgTK9ICJB/9xiHB4/IAmfOajIZWcs5TOwDScXMES/oTeBKnokBF+hKsjWGEHDKkCGGFo2EcckF/BepMovXcdktAKfdBG8QLGQ4HXvHnpVVSeKMa1ghxDQGWkNzbKnlswrezrc31QvFbCi+lrhTEVU8vrFXEBGhyP87hd5M+B6g1q7GiF/VaRCOSzpY/sH7oPsbe/oqokZIq+pQ9wixwG47DIXP1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTL//VEKEawesMePLnzmmo7/BcYqhhT3+M/2zw8hQm8=;
 b=cTcL4WJQNbCEMbLVu4ooCvwdOpz64tn51UqKbIMriTlFwXvdGJUKN6Fz2QgtQy6FFcV4HEFT29dsPu17L21CAck85Az3iBh/hZu++FeirR+U71XMe6mk5DJ3MRvRfNccgPCjXGwf+dQ7PYBiSUsDfq3RhWgc3OV5xdtSB7L2DuM2tK9sPhKJZuYNSb+mEFDyX9Ju7hHv6CPb9S4GdChuCFLwzz4zDK6ldfiTn2A+N3MwSuBp0MhRRubO/b7FQP5Tpjf0p1P/WFhE8c8uqxucsIYq7zp+j8Xl4wRNXin6IbOUvrn5wuM6z1T9KvMc1H5KH0ZVLsJ8IqBc2BL559N8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5375.namprd11.prod.outlook.com (2603:10b6:5:396::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 22:28:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:28:27 +0000
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
Subject: RE: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs
 blobs
Thread-Topic: [RESEND v5 2/4] fs: debugfs: Add write functionality to debugfs
 blobs
Thread-Index: AQHaEcKmSJnxE55esE+d2zUzr8vlorBvbmag
Date: Tue, 7 Nov 2023 22:28:27 +0000
Message-ID: <SJ1PR11MB608345F0C62627E7A0520449FCA9A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231107213647.1405493-1-avadhut.naik@amd.com>
 <20231107213647.1405493-3-avadhut.naik@amd.com>
In-Reply-To: <20231107213647.1405493-3-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5375:EE_
x-ms-office365-filtering-correlation-id: 060d904a-32f0-4e8c-edce-08dbdfe0dd22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8JJBFOXDRHuP4oirio3NSJH5zZdxhj/1UIsuoUOuLEfByQzh4bTVyNHpIMdgTkbEik83N6RQ2F0RSFoxmzJzwuU0e+MLbXfOwMcUoDT/RnlQdlhUrtvknbQXn8VSY5VX9S9Ahe9xNyx4AMO9MSIDixpD7kQ7jCD/SiTX7cjl7ZqYuW5Zut2e62KYnlCRNWPRFivYT/vfYuabkPAjK6bXPcpTNMVGLh87A+zkxsp6zNkXlnHhLkGBbHKG59pNwmy/snRG5fjnpQT6YzvQoiP00kScWabLy5f0DcSfBRh0NLV0yVjO4Ej5zacZjx8QngWEUX4icqjGV3twMFEe23CZU3wvQ4DjW0UcbVVsC6r6AgwsnvXU6WEEWe5OtZBCzoSkG6a8QDYTEEHPV58IJwSx0v+WUX1RVDKVLvXUaa79KJKnineb9jt97XAvu5eQlnWMRNKgVqKlUgmzC+1kxugtVmoef79dpYtgGjE9f2+VqJPeNU4ThlXucqCoKtUKIQQ8RBW2FR4RJ4OpRWHPjwKl6+gLBay9tOMf856LzxCoXkfX68o91XN66fkHYTPMgxSvZhdg7kMiLJ7N7Zq2ySDwEof1JDfEXX5cdXub7JmpjNZQE4dBi9xhYoQTxnp1gonO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(55016003)(6506007)(7696005)(71200400001)(478600001)(9686003)(38100700002)(33656002)(122000001)(86362001)(82960400001)(76116006)(66946007)(4744005)(66556008)(41300700001)(64756008)(66476007)(5660300002)(2906002)(66446008)(26005)(38070700009)(7416002)(4326008)(52536014)(8936002)(316002)(110136005)(8676002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YRzTybZlzd9VuzyfLA+LQsiZOD2KZ6wdBcfHCxNpRPZRHKRK99fzvXXp72vl?=
 =?us-ascii?Q?RQ3C3dZDW6M4ox8Nc1CTb82/oDIHJd1MHm39kuBfaDOBm/hOLxJonpN+XYx9?=
 =?us-ascii?Q?vlGQApE+oBwkw7Kn8SLpMhtzdCN0wHCJe3d6tT9q3bwIK54abQ+/rWVOKdu9?=
 =?us-ascii?Q?Pcawi0ry9OJAOxKzwDlZqLYrwFGZ3cQ0TFb1nPxjlM+2ClKDKLEfXXy6JezA?=
 =?us-ascii?Q?Wt6WTRJnhrGzqkW1DCFsum8kOh/Kjx6GquBDgSHd1TYOcO1Jl7Ps49+B3zjm?=
 =?us-ascii?Q?2qIFyqf49TTXu6HV3/ndaFaDwES0Lj9tw/gTWR7SyXcKNv15hEQqL9pMOHw9?=
 =?us-ascii?Q?1cM4zwv9Dj8mq0MRHBBJRrgBnYx8/9jkUyUR6TWghgEfus1S5jZpcSppaNmn?=
 =?us-ascii?Q?HzNRup/WB9UGzeEAj0S0tJ0EU2xa5yfKS5Ku6QnLlWURCDWfIzhYfKXHBg5i?=
 =?us-ascii?Q?yOUVprwSlxQMsN4CeCCJz+8FBdCx4jd+mZHEd9idmr4UkYDmqRYNwhB/5ZGG?=
 =?us-ascii?Q?TYhHrnb+H8GZrwKWI+Q0usUpAn4Mzw3qHOTwhCFpPHF4kBzJt7pbKFIAef5T?=
 =?us-ascii?Q?tV0aBGLAA5zIikRijmy9t4Qs1Jf9KsVquV2XdjIYcmmo9NjLoyCGiqvZWcfH?=
 =?us-ascii?Q?y1rHYUTjLL50B6uYg3aSHs6WtJM7YgACtw6aVvfAaSzzIXqn+jnmNJcDXPo4?=
 =?us-ascii?Q?XIraRwDX1ORDXyxOz2sO3+OahIPKXOaUn87I8YZIlaNFLwNr7VOT3WseddfG?=
 =?us-ascii?Q?8WUJV6kcjzaBXRMOhSvmMkHQADbsQcXcGgtAiZMAmoAKKkNjy0366NmNSxzW?=
 =?us-ascii?Q?5F671II4KCmYHNNt5qgPgL7C2WaHLOlVzeEyZUnVHJ2fDEjbWMhfwjaxj45/?=
 =?us-ascii?Q?qcox+H2ZCtO/PwGp+mi44l3QEARK5oODH4+DRNUO2lJWbsuEcYCyrfoeO3Ej?=
 =?us-ascii?Q?joy5rP2oY9cWpkvf7rozAnQu6X1Qv5TrHz0KFdPq0FVEennD44MRZ3mxwyKy?=
 =?us-ascii?Q?2Rj1oIHsXn7DP3azcWKPwlQius/zya3twYUsfBxY/7g+yXa9jd04GceXX7ts?=
 =?us-ascii?Q?rVnpqDUWb3YLsnk/SioSwF8TOh9mq0CIUgtD6aHCYbNlQP79fQ8ztAnFfGWk?=
 =?us-ascii?Q?UhI7yTWWZCkePpE5fkNXvd7FeHSwhi2M4g/6fd0FJVOzbnzFB03Vk8GwcL6R?=
 =?us-ascii?Q?7JIcUQe/vo9YR5u6svAHHg6qpiWO/77Glg3Ck/ioN/haLab5yCePDuP+pkAQ?=
 =?us-ascii?Q?HZSjCD8DnXeuEGWfPaguGfdHZaqYgioiIKlcOStcFYDGv/Qrm5AlBqU4KOui?=
 =?us-ascii?Q?kG89c6q7MKOmxwXv2hiC8bRXaCAE9T8hob7LZfaPTYYvb4jjku5cNgPR1k1a?=
 =?us-ascii?Q?Ed+cF39INwo0Fkjj4toi2lv9XSN+jAd6PQQVAfIQP1Mo5jv4UXUQGmoJQSEE?=
 =?us-ascii?Q?JZXjCGOHm4Alge5ZsC6i2UN8BGc68qpdHSc3tIshgIVI16Bxy8C8Y45vrBc4?=
 =?us-ascii?Q?HYDbMDfj2Uh3MIYgEe1+qIavXtxphzkrrPGy3nYRB6iotlL8vEk/70EaaADZ?=
 =?us-ascii?Q?Z+2EpFUPrbHk8VdusofawZVQExBSYPkAdLNIjLYF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 060d904a-32f0-4e8c-edce-08dbdfe0dd22
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 22:28:27.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+ubi9oiAI5E8jbrSTIPRNUUFQgnAbUHud940726UASENsR7n4y75rQpXN8zk/qkKcsf5IrGiscuiw8oNOlUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5375
X-OriginatorOrg: intel.com

> @@ -1042,7 +1060,7 @@ struct dentry *debugfs_create_blob(const char *name=
, umode_t mode,
> 				   struct dentry *parent,
> 				   struct debugfs_blob_wrapper *blob)
> {
> -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fop=
s_blob);
> +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob)=
;
> }

The minimalist change here would be to s/0444/0666/

That would just allow callers to ask for writeable files without letting th=
em
add execute permission, or exotic modes like setuid etc.

-Tony

