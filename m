Return-Path: <linux-fsdevel+bounces-32640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C49ABBF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 05:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FCA1F244EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D712E1CD;
	Wed, 23 Oct 2024 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tjn1ZZ3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAEA48;
	Wed, 23 Oct 2024 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652782; cv=fail; b=KXuaCYtJ+NVqeEOMnbN7Zf7VZqYRfsDLrg19TqrZg0szs2neBmRSKKaEHmd2HpON6dBB8sxQPCRu67b4HxHWH2YjCRYytvWYrsGOsIrRsvbGtg44Ln9qu6fKFokzfMFEWJHJ2DaLmvkWUjTzfl+rX8/KjkfNn55BKRfS7pLxxcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652782; c=relaxed/simple;
	bh=e/DtqR6R8qpqhoRV2FLHu8uYCaOTIhtWXkDn9K/ivh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KpIelX35lmDYf43GIdUtD3xWNDOqHPF13tht2G/U+HOG0TS7mWtOYFUAfcD2acMl7iqXM5hx8X7UuWbDnE0fYXfY5d3/rfGkOTrklf+1VkKxmR0n8AHM6u24oWQvbvYacnvfp/7e7Tn6ZUpXI0dCmY9V6+DszCFysISNLI7FhEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tjn1ZZ3i; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729652781; x=1761188781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e/DtqR6R8qpqhoRV2FLHu8uYCaOTIhtWXkDn9K/ivh8=;
  b=Tjn1ZZ3iM8X6s1DKHZG2dTqJZHxfzP/T5Y2i4kQ0hQMbBmF3wkzxXI1Y
   lnuqJ1GW38y9C3+5rZIwYHS2l+5TK1xR7MK7VHECOlbY3IDQ7gDiMJS9o
   vJwmDAcAnJ6s1WM1NS8dt5E7rZxmiUge2Z3Ih9+j6xCBz3Ecu9rKPWBCb
   1iNCPTIMf6mxyEIMCFK9LMyAytN4BvjlxMfmYWLaCuDlmvwV9AKt1Zxjo
   K7BBKpQ2M4xhMbzt2ZBGquGWD91qCuEOHt9dNZJDz7V3Ui5s4tnuYApzV
   fKSJ6EDaHhRb2gI0UT/YQ9YZqeTg4ZM478NSXdXjWFbUfPvxTbBAJGuLU
   w==;
X-CSE-ConnectionGUID: x0dO1cbkQVCibgSNXszwzQ==
X-CSE-MsgGUID: a0U+pAPASeaqFLUXOUWEkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29382957"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29382957"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 20:06:20 -0700
X-CSE-ConnectionGUID: MlPaPrqrQDqlv1ogDsXopQ==
X-CSE-MsgGUID: qjcQYynTTOiVMLSjF4GAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80867759"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 20:06:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 20:06:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 20:06:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 20:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBtpgcEh5tMY5fMuZUJqfjQBSHSucBrZQRM6CH13mfqlpdE/6i43wxjTm/1EkTnc6tcC9MevyErt95JIcNCH+abhxPtDeP4ZQ+5jMcCbsoL2M+2b0+yC8qYDWuLsqQYt2FRYxGskRFAHJZ8tkGPNoO12iG5pF3DPebp1wN5i481wr4sL0/6TGkI626sOYBGWDkrhZTm6eUIjRVm5mot28CplJqHp0b1W7dSAEzPndAg5GsS8roy3zi/P2o1YGdn4QS5Q/QJflaXWsLYXybfk9M9iVf1iVq78Mun0K51eZHFAPdFclM0U9RxnHZkDan0cat8IFHgIods+roZJE2T9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2P7+diz51cOuCQxO72ax3Z/WKDWyCHfP2vt+M46aU4=;
 b=EymPgZwmvRU9oUSk51mZach2ixN6keixe0SuLi4ViLHu6WBjSHJ/IUmdc7PHWPEUVkusOL/kVLCf+vyLJDlSGM8zz8NDx/gC569ZH6WO9OQY1czfN54ebxT0J68nck8aGaqAr9D8eCUIt8Bz3Nqa1D+ji4WgFuWLoghYg8jpyI5Tyj09c4ZHJYha7nGpHE4PvYBvByafcIwpd50Z64ltjfAB9UO4yWeTM12wS64yJ+Vf7y4KLAN1aMLCl/0nIMhjnjjk90o4FG+2s1yjTi3vy77xb+G7VwQtVKjm63GUIeWDzITPF1m41BsI5KQ8o0eG63cm74zPQnUkfSnwZC++yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 03:06:15 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 03:06:15 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Yosry Ahmed <yosryahmed@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>, "Accardi, Kristen C"
	<kristen.c.accardi@intel.com>, "zanussi@kernel.org" <zanussi@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "willy@infradead.org" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 09/13] mm: zswap: Config variable to enable
 compress batching in zswap_store().
Thread-Topic: [RFC PATCH v1 09/13] mm: zswap: Config variable to enable
 compress batching in zswap_store().
Thread-Index: AQHbISi8rWXrArXvWU+XZylbH3mRtLKTiKCAgAAT61CAAA/6AIAAAQPA
Date: Wed, 23 Oct 2024 03:06:15 +0000
Message-ID: <SJ0PR11MB5678B42619CF53B715268145C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-10-kanchana.p.sridhar@intel.com>
 <CAJD7tkbXTtG1UmQ7oPXoKUjT302a_LL4yhbQsMS6tDRG+vRNBg@mail.gmail.com>
 <SJ0PR11MB5678D24CDD8E5C8FF081D734C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <ZxhmTmhfeQAEoCwS@gondor.apana.org.au>
In-Reply-To: <ZxhmTmhfeQAEoCwS@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SJ1PR11MB6275:EE_
x-ms-office365-filtering-correlation-id: cb3c2dee-9e7a-4790-a93d-08dcf30fa877
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HvycxIOITra2QIWiBXDb1+UjBuGPK61gjlAqDksulyyioPWE0i6lTVd4XDWk?=
 =?us-ascii?Q?jqCHy/Y0X+hovu5QUwaC4VFNfaW64X4dWCbk8g3AMLxz/aRf4LqzfBCIZck1?=
 =?us-ascii?Q?E9ihT/+oUNDo7uo1aKVULKQaP/Km0UkHrGDbcU6TVJYN/BJb96ZXcJav6WHx?=
 =?us-ascii?Q?irrynvh2hzbBVEnilBJ96t0ksgi9mNF2Vub5kNY94Upxnf8HNzBLEhR63X6+?=
 =?us-ascii?Q?kYCxU4G/Ss0zKdROXQDtR+B2lW3XnBByWo+2e7b47pbpnoQd1OYDEUW+iGJ2?=
 =?us-ascii?Q?q9clSjYW5JAWE022FrlIYGH0DyX1U9ulTDY6/QTULo8mHK3R+SSeOXNml3i8?=
 =?us-ascii?Q?POn4bevRi7+YCAFd3Tq3RzMKAeYpWy0sVHahdwIzfCEgEIUj/dM7yHrfPvli?=
 =?us-ascii?Q?lOzO2TrHBpehNMEDGdriodJCBGupuHKgI1I37qkzfjGltHzvCpwqcNHNsmAl?=
 =?us-ascii?Q?q07S7bh9R2kaDuZE9BLt8YHH2fjmTDZJYx+4JJ1iyxZtKLfRH4SyCniJsiY1?=
 =?us-ascii?Q?XNd5lKFG1tojqkLL+FxKc8Kfm6+fNp3qIrRLpaJTk/8+Ve3n5/BLgrr6ZEWL?=
 =?us-ascii?Q?50BzJGZKIV+phJ4Dq0DOL7xO0t3EHI6V4I2fm87GJ03+jIWMHO5t1JDd1JiR?=
 =?us-ascii?Q?jXWUCMSs3xujD3f1SxtuNO0kLCgeonBwSLj718rcSrBV7SIUOaT2wyWQQ2Ee?=
 =?us-ascii?Q?CkWEtS6ZD00us8Q+eDIPSaJhW0NwweH7XW1XJVKHkkF3gAAJbZnKBT0dWv1V?=
 =?us-ascii?Q?l0XPwVFpbhVOXUMMMvu3FbzcvxHAhUkm03LwyHohtP7GQ3JRcDewLBzeRYee?=
 =?us-ascii?Q?+9BIQpb8fZvNkzt4IkZhcb5C61yaVRcYx8yubg+7cA4nczehLTE7mw1SHQr7?=
 =?us-ascii?Q?EmPaJ0BTQv6lYAWBySldMdToJjmhPnOxgq++2tnU7ygLDm/eGovlPbpCHziq?=
 =?us-ascii?Q?TXofeZtJ6G1MjsH44TetOWeWmO1samXFRNzd9CSLrxRyHU9L3VrCdMc018d/?=
 =?us-ascii?Q?xTWnisVoKALY/qpiG7py19cLybOxkXyjdFh9Pmj5NYCIWkkIUWekDMGk/v/M?=
 =?us-ascii?Q?69LQTdEWewNZ6ORsPh0Ea07aXVpWg2d6Tx9Hov/chWDCMfWIsgduhQBo/Mkk?=
 =?us-ascii?Q?i5oesBvNUhy4+J+OCM7BZWgrbFIgYNG6Qx8YeXmXOwr9PI8hvpnNBdWTKxEx?=
 =?us-ascii?Q?yKkwTuq7cYMq2chOuLawNM7DBdDoIO8BF7hgM3rAzluAaQiFpToqwmCWAn5M?=
 =?us-ascii?Q?IANPoFy5Uay9QUPK1xYjiWrSfC6Xu4mxptgiZt1idkuE1qHJ+ZXB3gZ6VRYE?=
 =?us-ascii?Q?rdD4vutg1uO6erLTnKBXYKvO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BfRFkWRCsQmR8hDRUfbXQhpI1qyc8IFAkGlP2fIsvNbaMvfV0FmMGwIzQwb/?=
 =?us-ascii?Q?r3H15axMMWXPxNFpMGbG9kOu1cgTTxOBYfXTHir5b5W61BjmrgDsMJIl3jei?=
 =?us-ascii?Q?vPtzxrZUtvwX+AgGDX2y7Zk2wW1AybH81oRx7BiNCPz9YGqHwKZRjjne8pza?=
 =?us-ascii?Q?IzSOuB9dr30n5WwQ9AuNUu9zKChOLcV3a+0NRO0muoKH3LbOsI5CKPQA9Pfs?=
 =?us-ascii?Q?b8Zwp4uA62PP74g1tHVDSjvAAYQHVmU6DdChESWx3TXXAp3IBPfg+D99szV4?=
 =?us-ascii?Q?ipGlBKR3d6gg4gJKNoyGysLa1HFUZcR88+HnynXKvMmlw44kC/dz7nFUuVCE?=
 =?us-ascii?Q?oUU0YEkCcbmjQ2RWC8dJeTg1/ivlVqYC50jteNnKTO4AtgK6/NXlSthlb7vp?=
 =?us-ascii?Q?QI6VZ/GqZJdd2o8vsQF3bQX5T+TvJWMoCy1HGNP8sWUKtoDPR9EL2ZrfNDoi?=
 =?us-ascii?Q?03rxbgI5KdHo0jFG0LZNIsGyOpdiYVtRDGepm6+46uppzPCmv+olNb2WTT0J?=
 =?us-ascii?Q?mdyMQc9xxoxbfSSgUz4/zBYcXa13g57/gk3V2Xxl57W4atPcCOJAfck/2mj7?=
 =?us-ascii?Q?Fgu0G7a7rnSrVdIhk5A++vcCOwk3EZbNkbUUHPK7XSAvd4NgnVUCKRwoLPgu?=
 =?us-ascii?Q?YfoQY80ymKAMBUJqA8zZPvY1NO9DtmOJeSsmLpSTTwDwxAuQnVBM4U5gFLM+?=
 =?us-ascii?Q?i3F2JYYf4o4E9uVGqc1MmHA0R75Ubu9a1v2j0SH6Kj2DthmVtEow9jPEGfO1?=
 =?us-ascii?Q?E9XM0I6RQzn+Oj633yQRr1uXtKDlKaiWAbe+N4TePQtdPaTF+R3EawP3YsqO?=
 =?us-ascii?Q?cb9oBsjgTGdBcX4SAGnV0JU5MVVYXdCDsRi6DL2Lr5utQgXrKlvPbtrlW6Ov?=
 =?us-ascii?Q?OFT6BRUYJx03v0iAwKhrBhpDDS7W4EF1NvgQ7atTt55k6w2SUujy3KKL6FJl?=
 =?us-ascii?Q?Dh9OEsOaz0swgE/x0/Z+yO0TNsfLoHS9YZvbvWnU1YsaJGXNGuG4fZdTXyv3?=
 =?us-ascii?Q?hF2mYspVB/vtbl3ovKlpX9Quvg8mPZhT+78R2EeUpEN9UTdLYttBspxxQ4UZ?=
 =?us-ascii?Q?3Q4deFFKINS3RSkzkX7EG3Kdr4Yjc8h++DtmqtOid2ktnyp8w53JiauXfTbY?=
 =?us-ascii?Q?PDxNMJdobKG/luYX3A5VAd0i+qJp3/4TfmqE9o3vxYORVoK0z+Ve0ih3CF10?=
 =?us-ascii?Q?iyBwA9IQq3sVfPDIMTr2/Djv6AyJM/Zz3DCfkKh9DfH3OzbOSNgL5zJ/zKXw?=
 =?us-ascii?Q?aDWdV29OlLhOpY/GEOehLm3B3fi84f9dWXD7OfCmnzMXnLvby+nQnyoRGt1J?=
 =?us-ascii?Q?J0San4Q/QSBbuj7Fl3cOYVyWZvBwYuSVcr63ETu/ASDIyA+Yz2YF3XppP8wG?=
 =?us-ascii?Q?SwOaa1nzvBY6nGsHGEI9tDnZA7jyg3Yp9DKpI9x5x82nXjYS4yWuy6BKz3Pl?=
 =?us-ascii?Q?xgmfbMtnpD20WrDT1Wqt7n9gi6DzG0G80bBbqZLv9/5ddfUeV4Xy0Ibtokzu?=
 =?us-ascii?Q?yZEJ9M4m41ocMuuUbJk8TXOUtStvRZ4ErCXMu1E7Nr70vDoYIIy5J5EA2tTg?=
 =?us-ascii?Q?cOBtwgBQZImt04VxJLc9zoPfQ72Q4cqx2E2sO8arWMBplGrszTbxYmO8XOjB?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3c2dee-9e7a-4790-a93d-08dcf30fa877
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 03:06:15.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmQTK+BfSnCTvptdHMLYlsxPpzxHjDcWjcUfVDHI39MWcDJyiPormHq/r6rzu3ckavyEjAGlNYKD5T0NgxzEvQr14L1fTDm5Y00NNwvjlRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Tuesday, October 22, 2024 7:58 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>; linux-kernel@vger.kernel.org;
> linux-mm@kvack.org; hannes@cmpxchg.org; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> 21cnbao@gmail.com; akpm@linux-foundation.org; linux-
> crypto@vger.kernel.org; davem@davemloft.net; clabbe@baylibre.com;
> ardb@kernel.org; ebiggers@google.com; surenb@google.com; Accardi,
> Kristen C <kristen.c.accardi@intel.com>; zanussi@kernel.org;
> viro@zeniv.linux.org.uk; brauner@kernel.org; jack@suse.cz;
> mcgrof@kernel.org; kees@kernel.org; joel.granados@kernel.org;
> bfoster@redhat.com; willy@infradead.org; linux-fsdevel@vger.kernel.org;
> Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> <vinodh.gopal@intel.com>
> Subject: Re: [RFC PATCH v1 09/13] mm: zswap: Config variable to enable
> compress batching in zswap_store().
>=20
> On Wed, Oct 23, 2024 at 02:17:06AM +0000, Sridhar, Kanchana P wrote:
> >
> > Thanks Yosry, for the code review comments! This is a good point. The m=
ain
> > consideration here was not to impact software compressors run on non-
> Intel
> > platforms, and only incur the memory footprint cost of multiple
> > acomp_req/buffers in "struct crypto_acomp_ctx" if there is IAA to reduc=
e
> > latency with parallel compressions.
>=20
> I'm working on a batching mechanism for crypto_ahash interface,
> where the requests are simply chained together and then submitted.
>=20
> The same mechanism should work for crypto_acomp as well:
>=20
> +       for (i =3D 0; i < num_mb; ++i) {
> +               if (testmgr_alloc_buf(data[i].xbuf))
> +                       goto out;
> +
> +               crypto_init_wait(&data[i].wait);
> +
> +               data[i].req =3D ahash_request_alloc(tfm, GFP_KERNEL);
> +               if (!data[i].req) {
> +                       pr_err("alg: hash: Failed to allocate request for=
 %s\n",
> +                              algo);
> +                       goto out;
> +               }
> +
> +               if (i)
> +                       ahash_request_chain(data[i].req, data[0].req);
> +               else
> +                       ahash_reqchain_init(data[i].req, 0, crypto_req_do=
ne,
> +                                           &data[i].wait);
> +
> +               sg_init_table(data[i].sg, XBUFSIZE);
> +               for (j =3D 0; j < XBUFSIZE; j++) {
> +                       sg_set_buf(data[i].sg + j, data[i].xbuf[j], PAGE_=
SIZE);
> +                       memset(data[i].xbuf[j], 0xff, PAGE_SIZE);
> +               }
> +       }

Thanks Herbert, for letting us know! Sure, we will look forward to these
changes when they are ready, to look into incorporating in the iaa_crypto
driver.

Thanks,
Kanchana

>=20
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

