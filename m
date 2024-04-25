Return-Path: <linux-fsdevel+bounces-17834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8828B2A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CBB26350
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4159155749;
	Thu, 25 Apr 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTuD6Uqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44C14BF9B;
	Thu, 25 Apr 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078768; cv=fail; b=EFzHHkWZjcHFyz7+CR8P0Yb0a1rmYGFOX04Zg9aZq2miSqOt6lr2J+SuZMBj/Tp2M9pxMoVVmyIiOvk3UWCe+l0qwKhTG8IRLkoLdMYgtW4CCACnSaITBCIk+g9o2pU1/rVjb3mMktfDMzYiWNMIff2bVH4Td0wF55U0AMNftKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078768; c=relaxed/simple;
	bh=ad6+sb9BGBwAXehYW3z4es0bpiKnw8BSr7KBTi8bx/0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IekGiwJ74LB8FjsAluPHPUX6dzk6QqA0MGZbNcwS7SJ7NGbbDkkCBrUQQBnhXhO2NzpEqLLzIkG3hxPFAHaMPPdHTXjv5O/+z4ARAMve+1Lrwzj2K4ySl5xRmGHxv7zsPKtfH1J2iPfLnW/zo4yv0M6K4gIiHPLpcYRmt9SucFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTuD6Uqk; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714078766; x=1745614766;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ad6+sb9BGBwAXehYW3z4es0bpiKnw8BSr7KBTi8bx/0=;
  b=eTuD6UqkdFs2713f9w2V3F8pTae7rqWsaKf+yFQ18tDzgg6aW6/2rpuo
   J2UlxmH6Bn6MMlpZ1qQHKPhy/NIOeCwsX1Y6nIel6xBUftv82v5fBMCgg
   qze6iFW+QTPpNzyyhXKKPHYBwHfxt8QgXqHFMf8kIwcUlDAxIV1U6rrFu
   es57VfMO1sdVDGHu4RkN8HvjzOc3yajWyuqAEItMNJ2v6m1qSuD8Uhqzg
   X/BpBaLOYc/xXJqiBwSzDlClSVju/Qqfyz5J6zDL5kXECdLaj7jSm3l5o
   pUgEbljVsYZBkkCytcmIV4dVWqx/l9EMmzDZN4TXIgOwc65bDppggpe7m
   w==;
X-CSE-ConnectionGUID: U9J8X2kvTNmx78w1v2Yd8Q==
X-CSE-MsgGUID: 805gISkjTy+5wCGZ+DTkhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="35186881"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="35186881"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 13:59:24 -0700
X-CSE-ConnectionGUID: rpsyjb1RQUig6bkdj/tEdA==
X-CSE-MsgGUID: uyPFEYKUR2yVpQFnrkyj2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29849700"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 13:59:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 13:59:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 13:59:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 13:59:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 13:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwkjZJofZXmzYHTqY6R4TPyjeLA9XcGmtqUzDWss/2grK8o6QLtXN4W3Rm8gUlJjK97ZnXkRuEs6zAiZe3tUBQHBVbXefNn13peKXykeBo48O4ysfijlVXrOiCkXkq7vnv81+SsgBSQZXXRM5o6ag/kLA/bHGfE/y1N6sTGoFNfqGtBKAEILVs3U1erttPw7jUKHKjHciUgAoK1LYKc6qk28oSI7qGGAS7k1LKa1wdzqs4kEj1MXN3/yKlINp5dIuC6UfW8r0ie3e05PPckH31J/gRl9TMrwszxfJGCdZaUj2gLgztaWa2S1LoMGc29WHjrpIhgMl0dmcLHzODr0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtnnUUtpRLPE1JKhMifN/g9LnRUjDmKhaP1b8NExrdM=;
 b=TccY8FCswQMqCTj16oSTkc+DNAjJghY/KJdzY01PZ0x5PIKY31oBGZyW4G6hhNh9JavVtOwi/6+zw7EBz/8bx6QI65LS3UfRykx/vFZ4ZnuG3oK4+fDmutm36myYTm2+PdWvbuNIJl9q20JewTXn2L8E7yhype3gukEnxJhDPFFjOLcDtipRChjI2dgXu5bRj5tqvc6lXu9PJk161RKUlyruwpqtFt/ZJKf1dHf7F3imGOQRdYNyMeU8qjbFQRkbMfCgh996cKexaKBGEMUE8fpJEqRvnNLfWnhmZeBaRf+n0EyuFgx1VdAKArzlyXLr1LcJ45rDMgHha3oBUX/eOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:59:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 20:59:20 +0000
Date: Thu, 25 Apr 2024 13:59:09 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, "David
 Hildenbrand" <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Richard
 Weinberger" <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe
	<axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, "Luiz Augusto von
 Dentz" <luiz.dentz@gmail.com>, Olivia Mackall <olivia@selenic.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei
	<arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, "Sudeep
 Holla" <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter
	<daniel@ffwll.ch>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, "Latchesar
 Ionkov" <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>, Stefano Garzarella
	<sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Pankaj Gupta
	<pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>, "James E.J. Bottomley"
	<jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, "Anton
 Yakovlev" <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
CC: <virtualization@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-gpio@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<iommu@lists.linux.dev>, <netdev@vger.kernel.org>, <v9fs@lists.linux.dev>,
	<kvm@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-remoteproc@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 21/25] nvdimm: virtio_pmem: drop owner assignment
Message-ID: <662ac41d1655a_108a3c294c0@iweiny-mobl.notmuch>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
 <20240331-module-owner-virtio-v2-21-98f04bfaf46a@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240331-module-owner-virtio-v2-21-98f04bfaf46a@linaro.org>
X-ClientProxiedBy: BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1e0950-9458-48d9-541b-08dc656a93d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p4Pyvc1s10sc+1IhRVCgrka7N17JI8shpKV9e+qyo0zoB5fQBt09qhs/sKrY?=
 =?us-ascii?Q?E2+mMbn2LeGPlwtKggkfSUJWmwlPSZuPRp1J6Jue9X1dR74+/AyxHAjobEH0?=
 =?us-ascii?Q?WQGt3AiJM9GYXGDc23KiyG9FA6iqGOSXvJT2B7lk4IwKfd1DP2EaCUrlPzje?=
 =?us-ascii?Q?XDfveANJWNuO9Gy7+XeQLWg7g8nKveuVWNOmnPx3iUgCpFN0A1smk8d7v1Nh?=
 =?us-ascii?Q?Xkw5QspejlB+puqNeXnYrbMMHqHbyx3FnQ0QTCb5sjPTvK2EulzgN1mzuJCu?=
 =?us-ascii?Q?asj+PD1MPLZFkKHD3JxdXa1PUxMF1KlGKwEDHSjaI9o8SwCNMSwKUV0kPoF8?=
 =?us-ascii?Q?UyIsbaV0Q2NenIHOPrPAORzYXPno3jn1sV1OWN9nD6wGugDyScBB24A0UPAK?=
 =?us-ascii?Q?Xl1Yw7vlZBfnhDOZrVHr4K0mFt/VUqdn5BgKDgmK6s8MSlm7FD+fr0Kg2VCZ?=
 =?us-ascii?Q?/3H2W0xBSg2+LiHhbRiP63m1gi492rwD21Y/AxuHTfVkZGTRXD7PtcS+R1E2?=
 =?us-ascii?Q?mg9IquTiLx9NJOXC8xb0SuG+KxgLTpQIQdCz1FegVg8c/85/kQcbhK570UHn?=
 =?us-ascii?Q?oL4gj815Xf4bdBEhjrtuuMkUA/U0fkMeXSPZ0W+KGHAjwV/Z77LAzIVTdb34?=
 =?us-ascii?Q?zFwwvW3hmxwch129QmUrtnH0HegY9iikAxAZrI47mteg5YT6xCHcCn+0LAoZ?=
 =?us-ascii?Q?Vh1uRKxwaYciv5KUAaeopaLjzAdK2UnMAqSl7mFTa2XhHVAcoeW5SZfqQ6mI?=
 =?us-ascii?Q?Ef9Ou6sjsJRNRMAqlHZDc+BU91w89febeyepipwh2E5j4Y0qQvKnBgInNg4Q?=
 =?us-ascii?Q?1szmwA78wF7RUHF4mnzHXV+qOOnFPsp4pT9IPyEyk8WfQLYXyU2+G8k3NYYU?=
 =?us-ascii?Q?LzUiz+kJEaq18cA9QUumZ3x6qZiOVCkytIg9nvY/7JMxRRhGvmNq10pLFS3I?=
 =?us-ascii?Q?yxU843oCFnMIrPsomQnj9a6XVOxEUAPzV2a8m37ac7p6lFIC0f0nZGTaMdpN?=
 =?us-ascii?Q?gjBOU9wQgHETI3EP20RewReN6Twd4KRZc6gHju/IVnyFRQG/a0ZdmcLUg589?=
 =?us-ascii?Q?8DLFAKiGv4W0hJe7AsE3U70wX/MNSh0BCXvsy1nTqn9q2yt5OJrdKmxt2aEG?=
 =?us-ascii?Q?RLTTyPIf2cnNonmNlnzhsO30KOSG/B0m3e7O6w00kVsw1x6EpKjGnQpue6k/?=
 =?us-ascii?Q?3FiSlZKerTZdGeDvrR+yvsN/C/wzUXxaWd4u8CT5wDx2mB/F8dxLColXv/2B?=
 =?us-ascii?Q?O8nhvq2PsisgGZ1csGP9/hKUZNKzSD4fYRrYmZbM+iTXei8aeRxqJZmkiqSY?=
 =?us-ascii?Q?p7ccIMK+w/ETQCT56Po+IwHc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsgct7QwEtK35653A630MZZbe6OGEV6cvtUwSO58Z1F4ZjIxu8O/C3XQG/oy?=
 =?us-ascii?Q?k/U3l3549wv24vu4Vn5YpLE/1R7HZd6yFj3K8xZunc5DwDNSqOoTnbZZWH2r?=
 =?us-ascii?Q?9/u9Anm4StTkF6qIoUQuWF/Ok7zggCKO6Mkcc6Nbf+JYqkc4NW6YpVlAvNkZ?=
 =?us-ascii?Q?Z8J39CEZFlKD1P6iFpxIr7NdSpW6rbdV6kqpsjhLzzMD7d03nvQdfd558bPn?=
 =?us-ascii?Q?JOtIpqweL4Yp5UnYGXXPGkn2XosYvlK9obqtRSuwLHpvkTazk8L7RFL4gvTS?=
 =?us-ascii?Q?r2822/0umLruRmyU5zMrMiExe6kpLm5NH/bCiLz+mb3qRH5B2e6RfKps4CX0?=
 =?us-ascii?Q?cz8Q7s2FU7+YeBts744pBuioAihe7xZ2jC4U6mLqhKpLH+fEz55MoYeHsWot?=
 =?us-ascii?Q?3phklxO5JZmIs54B26n76OOFdj4UqEEZxkGn7QPEoJBSfbpyklYcuik8y3RG?=
 =?us-ascii?Q?6AvDNcI4ICU3LJ4VMY5cSZhpey4npddVqOPdiKKsOgqE+2Enxo23RpSwdlzG?=
 =?us-ascii?Q?SCvHVf1vTDtOudUyrZolDF3tVPDZ5Bt1UsvJme9ckKVwO0GF/g+uooeprli6?=
 =?us-ascii?Q?e8tnPUkhMSH9a5wmPiaoKCxuOnftMSRFgyE1cRMudoUwEM3UoIUAO8pu0Ne+?=
 =?us-ascii?Q?iZkGaYiEmTY60BOHtguH5Iyu/75zXnd6s8PBaBlsa11hyyB/cpfVoeTo6Rnw?=
 =?us-ascii?Q?p+0gX+vv4uzPytF+Q4oUTPDmxA4tImSFm3y7GH4QmMf6RpAVbBDuEMUYMM1E?=
 =?us-ascii?Q?X7J3ZLS5CXgP+Yci6/COyMUgiqQiahNxfoTjBOxdkj1/HhKr0UfCPkwPweh7?=
 =?us-ascii?Q?4Te3N0yxJY/yB0Ica2AePGO0ifByjOEH211v0P6jblkpSGCdC4q1PDnw68zM?=
 =?us-ascii?Q?dFxDVNBShwQd8XwctHY07gYzecJsGLApVnXVnH2aJ7J94uU/iMtGA/Be2zGe?=
 =?us-ascii?Q?4rHSo5GpPtqrm4lvw7yN420p7GFaiJR+DjLgaMX6pVhFXYChGvk1Se2qlMcH?=
 =?us-ascii?Q?orXZmmAam0Io/XqqIReWh4DBg7uXkHQW2pbO3RqCGbeFO9+OsTBH6/3PGpvv?=
 =?us-ascii?Q?NkKapXF/nYaZ4KoBzwmA2W0LjG7dgTvo1emYmZ8NM1BihO3K1qHbPOSdBF5n?=
 =?us-ascii?Q?7iL/9m5JQacbQIGvpprGmc/b0drCTmhB12TGqeVntk59CuZh66N5BRGQaX6v?=
 =?us-ascii?Q?B4IsB60HU9xFc6B5RquFclB43lTkiTI/jYxtZFBs2w7se2XR/7i7pitm+HwD?=
 =?us-ascii?Q?+HhjfxciHg7FRXDQH1j8EYOYnlWGd3oIqoudOoBiQaVhblKR3XEeJ2piNVWZ?=
 =?us-ascii?Q?wIrVdxzdN3iUGh/3TCwCYq5a3uJOVvZuYwoP6tgG/Y4TT4YDIeEEWsIEa4v4?=
 =?us-ascii?Q?Qn8HUIgJat4puxTyG78/wKuyCBj/tY5GTO1D5k+w2mlHatjA/GveypbBn7Dy?=
 =?us-ascii?Q?5Hbdn2EGydBcORjF9HoPyIEN3Zc0MTZlmS9Zz138CGq0ze9X+c+zWWpTZSFU?=
 =?us-ascii?Q?4Xzm9KH6bCV05PLlC9L8gxl43enHlypa+H6a2tOEeUxslfEjaqpFeQQlIoNP?=
 =?us-ascii?Q?BvYLfmniArrPmDLga8Wojh+vlOeQjwwu5vbMg2N+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1e0950-9458-48d9-541b-08dc656a93d9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:59:20.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px3Eb8ILOwKiaQoVN8oktVBLNHHqIyrhbL4GczJuNngr6LtPzi8db4gjyL2OGxCp8pY2FlscDiwIlQqVIPv2wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com

Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Depends on the first patch.
> ---
>  drivers/nvdimm/virtio_pmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 4ceced5cefcf..c9b97aeabf85 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -151,7 +151,6 @@ static struct virtio_driver virtio_pmem_driver = {
>  	.feature_table		= features,
>  	.feature_table_size	= ARRAY_SIZE(features),
>  	.driver.name		= KBUILD_MODNAME,
> -	.driver.owner		= THIS_MODULE,
>  	.id_table		= id_table,
>  	.validate		= virtio_pmem_validate,
>  	.probe			= virtio_pmem_probe,
> 
> -- 
> 2.34.1
> 



