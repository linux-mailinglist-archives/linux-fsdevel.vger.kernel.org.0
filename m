Return-Path: <linux-fsdevel+bounces-3003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF787EE98B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 23:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BFC28120A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D3514A82;
	Thu, 16 Nov 2023 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YR8xBOVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E048130;
	Thu, 16 Nov 2023 14:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700175349; x=1731711349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=88gut+MznrujhGIoLqFKtUJmjOVHQCn19uWIWn0/xE8=;
  b=YR8xBOVUOUoVPlsQyq41ENsFfkup1RcLh6491VCMChpSkcK5CCYH1Df5
   S4iEIunxeMV/yIKLqoVjcnpmAtgq/IYPFlmgRKLQHuJKfGzLqQG2vLpwI
   6lHw7Picz52O22lYY3JP5QJ0qk5XbYGM/H5/UEasiHwCle5GoTYxYAVt4
   vtCg8GzG/Q+yPd2XzsR/ccEzcoPbOVuzIRIpnWjfcrl+ZeW15iUllK4Bx
   +X+eiV1qfTrX0trA3ITGCMiT6uUWuhFQJVkQGgc0++39Ud4j+Xmp+G0ij
   C2xJT1TWN7RQMatDCi9mLe/h5Zbj4XLZTXcnt/LDT8UhPNcECcgQQGTOa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="457695963"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="457695963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 14:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="909265985"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="909265985"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 14:55:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 14:55:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 14:55:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 14:55:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 14:55:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8HYnb1cL+PkR8P93lQbisiYtvwywQWLG5kebGNZf5jNm0RISiNASQLEPN4McFH3JzJrQAXRaENCnAvl/r3lCPo69jPWUBqnogZhVVhT/ddIDaDqX396OvccCwO7Df9EQ/5rkeWwGCJp6wcv0deKzXIIQGpTUlJuVF5LWyG/odmT96SfYkB8K7KuxTrFXAuAPFjBR4uL9CH+HSr3IWkXae2j1pSulJdnRSB/rMjJiH1V5t6aNQU2UTcOcVf967s8VpN7U6Cgs1cS4fWTLaAQeJRObxT9DVKKBXcmdl5xMbTyS89Kbf5EFcCt6m0sVXNjsR/mTGlIjlPsBEqJwb8pJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88gut+MznrujhGIoLqFKtUJmjOVHQCn19uWIWn0/xE8=;
 b=DCkDz+Wo6uoyEWAf+9217Lszz8TibIM/Kded0WE+h9/gXLL0Ko0bP2+84YeCm8r488yLmPiv6SURsJPah3hkNtbF2R4xgQH/gXSbq0lAE551wjjP37UsgO8sO4R4CHzH6qEJ8MDAvi9VF92zvTeD03nMeNHHsaRUkMCEredRQPdvhrwpTisIr58xiRaQ+0fmffUYlQMA9ouvQAjXh0g+Xw0IkBmH2bQslDpn8Qh+c4QQwyJ28pQB6xfsqmkM5gLiKBr2NbSCW/gZ//zqHi350IY+QiVV+J+0JPNdUABHjKm1RFR6qiY0TWUF7AZ/coSc7I8hMCTVIGOD4TFBDsr4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5361.namprd11.prod.outlook.com (2603:10b6:610:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Thu, 16 Nov
 2023 22:55:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 22:55:45 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alexey.kardashevskiy@amd.com" <alexey.kardashevskiy@amd.com>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "avadnaik@amd.com"
	<avadnaik@amd.com>
Subject: RE: [PATCH v6 1/4] ACPI: APEI: EINJ: Refactor
 available_error_type_show()
Thread-Topic: [PATCH v6 1/4] ACPI: APEI: EINJ: Refactor
 available_error_type_show()
Thread-Index: AQHaGN74xSOLtQ8hMkyb4EchiBhjfrB9jflg
Date: Thu, 16 Nov 2023 22:55:44 +0000
Message-ID: <SJ1PR11MB6083540990D4929381FD3358FCB0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231116224725.3695952-1-avadhut.naik@amd.com>
 <20231116224725.3695952-2-avadhut.naik@amd.com>
In-Reply-To: <20231116224725.3695952-2-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5361:EE_
x-ms-office365-filtering-correlation-id: ebfd6992-2c3d-4528-4fdb-08dbe6f72a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iXrq2yutGqq57wIFjCgQeOScTdo1UJxf4YYIv5s+gZ1IjroQdcsj/7IUw1gLVW+RK+FhDR0FF9/FmBk0x+8sMab9+GbQVNSq0yrl6x25pKXayE31DA1DXMCw2AMPay7O17LiO1lX16MKYvBqkgCdkrNkBhSaD0YM49Zj26hwUd63TGgK9MPj6wvDv+bYkuXbty/2uxYlCOYfhPHlPonMb1R49odP4dl9P8pAd6TnE4Wr1d5/g9hUAQ/8Ymv1OD5yUC0dQy2QDyGoeKi+/hrSba3bBXJHnu7Q/KQogo5kiQoO90bFsz/sE4VzY6gkoHVR/9p2dH5bltSruLgdCyFHVMqAKde6QstlAFKtPdsC1dy+aPyAMTL31bXiVVbKtCijZL5dlqaoOOtS/QmGGTOPa34CsQP9mBPxPsoGkbQyt3OfAh51qsddbi37Fu6Y0GNPCnAqp3RyamUwbIxQjQ6CLjVQp6WtXc7QYXHOKGaua99wOLbWJ6itCZzaIGuAcXiSDnvIR4rvScFRumjrmqJvSpRNFLKHso1Sl8JxP+OZbkmN55T7szwVuTgth530bStoFegGw/Eu3xooX/ADX3r0wBVEzB9EeMS6OQviIXeZzexSQb20RBy8WZ1FwFKa2hl4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82960400001)(9686003)(122000001)(6506007)(7696005)(55016003)(478600001)(71200400001)(41300700001)(38100700002)(26005)(110136005)(66556008)(64756008)(66946007)(86362001)(76116006)(66446008)(66476007)(316002)(54906003)(4326008)(5660300002)(33656002)(38070700009)(8936002)(8676002)(2906002)(52536014)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jVs6HJqajTqedBJTwoh+DzbPS9ZzRlcKQKtsLmqEGdUDUIkgSShvb/aEUiEL?=
 =?us-ascii?Q?y6tDYFGQVH5oDthTzIPq4wN7Mo7XSYBapi2hD/pE3JeSav0DT04I7iKTFwUn?=
 =?us-ascii?Q?/wd6GFWH3UNY60jQgAnfgGYUMS5g3bDiBY8eBIZUNPp888U0h6vXVFuj5Fu7?=
 =?us-ascii?Q?Ov7JWK7OVVjYLBVvWcCRu4d1mGHcqrzixc/2AiFERE10NGLrhH4ulqRQmcv1?=
 =?us-ascii?Q?6/kVix0O5jx04edDJx8fxVOlvlgaiNSY+jasCn2cCiXbWe4EQxfAC3Kf6/cu?=
 =?us-ascii?Q?O4gH3XLhjwdDA1rybTVlaCO0N8NxEEu4EUgXUdrxk9Pm3BzkDCoZu/i6FoJ3?=
 =?us-ascii?Q?A9YquegD47s14Ve3y8lQ+bwdbMmR7+1zd4gFcPguF1kM5vso+kk5YW34Q2sn?=
 =?us-ascii?Q?MnWF8iO5Kw40seOVJ1joVsu5bVFzzHiVFoD9n/FiI+Edg/khSj6+MqjKli/D?=
 =?us-ascii?Q?TIDi1L67whgMhabL8S4r11+Ffn+MB/gN5gEr8CCRbs8D5V4DrgpKWhQrLrmE?=
 =?us-ascii?Q?V4hFzTupIHkgW2egtsxpzoeH8aWCYKPUivxew/XEsWFpI+HFNVCKVuyAYdPX?=
 =?us-ascii?Q?HS79DfDfH2Ur5bEES5l3JPHjxG+AKWiMFLgE3fohbyVzl9EPzS3jHv0rl0Jr?=
 =?us-ascii?Q?ZKugUZa1vcb8zlwb0kAE1AekF3Z+7LwEGbrtNtG+zr4kkvUKjOMWLI44h0lF?=
 =?us-ascii?Q?bOvlMpBhwzjU9YPTXkK1N32bWjSIAcvAj+PKThw7CV/0SVSiwlU4ITze5LBB?=
 =?us-ascii?Q?ofIY6fwkutwiVcSjvONzvuOkCaFZCg9m8u0JpYl5qHvZQSbksk5HORSg5IEn?=
 =?us-ascii?Q?Y0lnFfiJ65dkQOIflo0LCn4pL6lnnLfqYi/dreacdR9J/CgtskKeBA+90Q9u?=
 =?us-ascii?Q?85NJBcSQN75sac4c5kankmPFxiqDZZTIg908Nd4jj0BIaIsIXhnAdzQNk2EL?=
 =?us-ascii?Q?P7X0VqTVOyVI4qrHCHxa/sYN3lrBxaW0rsSTLjI7T3WgxRNVdGsoymA+mkBE?=
 =?us-ascii?Q?OAjbSHyL2CsBbDSL9bQm6XUUgoo2J0eCjJjgeNosVDMmqMXraUiMlS5bx/ik?=
 =?us-ascii?Q?xNRP3+3PK6fxI2zX1JZzJD29DwtL91m1z5xvkHKVVxWVA0bSrfzJ5fm73fHZ?=
 =?us-ascii?Q?VZKS5F82jAn68HGWgGddnnepKydPijfL7QdtPw4riUCs4Gx9lwHX8JTq22IE?=
 =?us-ascii?Q?Jb/9UNuRb7W6Zu1Pk3DueVq+r0GC+iuKMPsN1gOC/YhocNFk1dN0zFk4xI+B?=
 =?us-ascii?Q?y2clRMt0dsofXMl4QbnI4/PX+Y7JVNz/YhrJ3QTIay08jK4SP2L6U9y6wjaX?=
 =?us-ascii?Q?gsxyNV5qoh4WUoZnEg+JUf8g8vaZn3eVoEIgdAq4WYOBGqs4FtSgx76VZfYT?=
 =?us-ascii?Q?jhGzFZF4vN48JU9xYkCJWzF4WwyINgDRGgCgaC/5VUoCC+9WE3ChXyr6x96C?=
 =?us-ascii?Q?JlYFbq9iISeDDhVQB3mxo2URtfR9ADqULabu5+tMRFKlEE28a1fcCyqAMyxw?=
 =?us-ascii?Q?vqLmanPRwjtTyney0bb9TFoFeGL4OMIum3MJ5eTggDqGGraPwj2aMda8z33V?=
 =?us-ascii?Q?3pGCWwYWdgfMCssA8vjL5MV1znD1RUZpMbG18Ogu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd6992-2c3d-4528-4fdb-08dbe6f72a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 22:55:44.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQsD+/3GygOxIsV8qbhIFMAwAlgmjq/84Ox1GxpCA/k9uOYic77Wn2yV6rvqDcXMDMk3lQKliuJ73pFMPUrN2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5361
X-OriginatorOrg: intel.com

> From: Avadhut Naik <Avadhut.Naik@amd.com>
>
> OSPM can discover the error injection capabilities of the platform by
> executing GET_ERROR_TYPE error injection action.[1] The action returns
> a DWORD representing a bitmap of platform supported error injections.[2]
>
> The available_error_type_show() function determines the bits set within
> this DWORD and provides a verbose output, from einj_error_type_string
> array, through /sys/kernel/debug/apei/einj/available_error_type file.
>
> The function however, assumes one to one correspondence between an error'=
s
> position in the bitmap and its array entry offset. Consequently, some
> errors like Vendor Defined Error Type fail this assumption and will
> incorrectly be shown as not supported, even if their corresponding bit is
> set in the bitmap and they have an entry in the array.
>
> Navigate around the issue by converting einj_error_type_string into an
> array of structures with a predetermined mask for all error types
> corresponding to their bit position in the DWORD returned by GET_ERROR_TY=
PE
> action. The same breaks the aforementioned assumption resulting in all
> supported error types by a platform being outputted through the above
> available_error_type file.
>
> [1] ACPI specification 6.5, Table 18.25
> [2] ACPI specification 6.5, Table 18.30
>
> Suggested-by: Alexey Kardashevskiy <alexey.kardashevskiy@amd.com>
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Tony Luck <tony.luck@intel.com>

