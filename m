Return-Path: <linux-fsdevel+bounces-33087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7029B39AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0AF284676
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73D1DFD89;
	Mon, 28 Oct 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nThIoNRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A53A268;
	Mon, 28 Oct 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141631; cv=fail; b=g+dZZYzBzznzqSbJ6l5EfBU3UWdjcCMC8tT4R7+6ZaHev1p781ZPlK5+1ax0ZZHCgARP5nui7vzOY3rKKdOQ+nqT6b4vj361SrlQu6TeIzoo9QWuBh4hxMvXrMOmXoSFTi52/88dXXVXiwGkcyw+lZP4nndFi/vp3YlecomAzrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141631; c=relaxed/simple;
	bh=xq6Y614LCbPRLkpoD7shAAhYrvi75JcRQPx9WP5rL0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IJC/BX89nhRyHJ1u9Yn32MO1uKl9PLzPOIEqXcqUeqyoiGksKIpaUiWD1gFuHQI0+Qg1dJESaIV9djq6FjiYjICxQ0OQBaZpubQIbhn6TMDbGH1I3shmWdz1t8JvyE21QtSKtY650XfSTfERsGB0g4XgL6RbT6LeNnaHTfhYXJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nThIoNRe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730141629; x=1761677629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xq6Y614LCbPRLkpoD7shAAhYrvi75JcRQPx9WP5rL0A=;
  b=nThIoNRe+FYOYgBc61hn3eTLefL01SQqD3wQMRLuRu6DuX/cMeq8Cf9a
   rlkYh9t2BV5wte76ddq08S6xyY6F2aa8FhoN938O1kElM9QexhBf5g06/
   KQuCrn7txXmPU8GGX2AlOJ2Dk2Dp6UeiL+lKD6y/mAtpI+qQz+MteF1D8
   ccS3JgP/+ikKaKbB2Sm/NefqAuIV0PRiA93aQIDUpAs41dDa9IyvwRuBB
   n87Mw+Qmk1LHZmKqcoyn/bfJn4hz3LxVLfShxYMtS5VYKTuyI2vn7NonB
   R7TxXmY/tcpk/Qa0r7053yTd1GQR083tS65Mz4NgRNvzrvlAhMv4MdlvY
   A==;
X-CSE-ConnectionGUID: UJDmysGBRWuyqAoeLC7cNw==
X-CSE-MsgGUID: 5jFWs4fHQiCrevdNiif48Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="17387830"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="17387830"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:53:48 -0700
X-CSE-ConnectionGUID: bygmd5O5R7O0WIyZAdzp2g==
X-CSE-MsgGUID: JsokOmLCTYan8PDbzVcXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="86497763"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 11:53:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 11:53:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 11:53:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 11:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAfskAXeoqjcVdw8ozQ+qTGjOI+aHTWdxucyGznV78EBfGn4/zQ/5N3/jNaiGWhYHRpDCbDT2kVtNGu2YVlE+J6/sPTYtmfKCkEiU5aT+WFAxcpBOdNqUC/A5sg58H6eQ9sdtKuRE/Fz7vbGRwvx1vM1AwjS5iw/zwSPzhoVZofJw/q5zcNV0uW+ZdstPANqLcjX1fkoG6LbN9k953+4+DsifsJsl8tPYw4/Tb149Gfe9dwGyB5IKSZTRpPmAWNY85RnSKMGwojNsuCYYGQMN9ghGZ+9W6UfkfttIDUaLwGWQjn9u/GlVsLdiinupCYFC08lC0FoOLwkEgT5KoYwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om2ZT/lcjfsPCCFBxgXf67DLVWmzEa7uUuBTkYlwk30=;
 b=v2CS68T5P/I2X2yW5Ab8EHUWv1uETl5AfdxMlL8UV3D8NVK9+49H7PDWJampZReBd5b/R2LHZJgpWh/4Txg85TXaOeNQtO8BA0b6083a0UTjT5TEuvAJMxzx9Ol5E2Xcls4BSpz/beX1J1riAI3t0og0xRgfv+L8UaowIcc3v++x2hAwrlrwsGNmyvx8NrJ6lFvtd34mQ/UmTzWtjLaKbc3sFWLjo1ON525D3dzC/oT8UUe5RDgbTYjmq9GFAPaXvwvxtkCqRo5qmxZfrr/GkxRTLD3PMA07b1MYxIw+jxY09d14gF7b+jBkRBWZ8U+0rryO6FrmQpqFPnPriZzyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 18:53:38 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 18:53:36 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Joel Granados <joel.granados@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "clabbe@baylibre.com"
	<clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com"
	<surenb@google.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"zanussi@kernel.org" <zanussi@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "bfoster@redhat.com"
	<bfoster@redhat.com>, "willy@infradead.org" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 13/13] mm: vmscan, swap, zswap: Compress batching
 of folios in shrink_folio_list().
Thread-Topic: [RFC PATCH v1 13/13] mm: vmscan, swap, zswap: Compress batching
 of folios in shrink_folio_list().
Thread-Index: AQHbISi9elGnkj7AjEuxbumPE8X1+LKcTKqAgABFCAA=
Date: Mon, 28 Oct 2024 18:53:36 +0000
Message-ID: <SJ0PR11MB5678CF1DAFFD48157E90BD17C94A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-14-kanchana.p.sridhar@intel.com>
 <eg5ld76leezya7hbyuj4lrp4idjb3npgfu5u4oaitzrocwrht2@mqa3ur2l4yz5>
In-Reply-To: <eg5ld76leezya7hbyuj4lrp4idjb3npgfu5u4oaitzrocwrht2@mqa3ur2l4yz5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB6170:EE_
x-ms-office365-filtering-correlation-id: c3d4124f-cfe3-4092-89ad-08dcf781d476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1zv+tIawlOZabE6h9QwbYm7iryPwcESBFxqs4ESNaFI+P+BBYcQTyAPJzVq+?=
 =?us-ascii?Q?r02kiwOmRMJKtTqP2GvymOU1aosp3EB7zCyPThpch7Ysu2QFwXvfFT4DpIt+?=
 =?us-ascii?Q?gUFdzq2NDHYcMxhotBwVlaKNYAaIXr4k4xXkFSCV+lxR/sIQBeNzyxDrCczW?=
 =?us-ascii?Q?x9BBTEnNzEMyIS2VK/mlHw6F5rx+vhU1es+vThRECNjWChu5+0ylrK5Aj3SD?=
 =?us-ascii?Q?xA7fYbwL5R8883VpZ+J7sIrFqGCrbND5O1VJn7/lLQzzJ6MMhBglBsE98IqB?=
 =?us-ascii?Q?CZBTZRI84wx8uD7Ha0J9yxSMopiCIRzk8Pv6U9jIvuOYeUUTXfyWDAYjVhJq?=
 =?us-ascii?Q?rZBK7Y4n0Qq9vKvkoM7IjaQ4v3VvjwSj5WMopVM9yCf9dpHVMZAHMX8hkL34?=
 =?us-ascii?Q?5J3ThuQ31MUJELSDjxx4HZge6I2NC3xmJLejyjXKbwDQy86t9D5lJbAsapDN?=
 =?us-ascii?Q?OSMhDv5OrxnhQq3wFR06MUsCWl7DUD9YqggykbxJQtoJHp/7n/8+0Whvjmgc?=
 =?us-ascii?Q?kqVj3vglCdhK/56yfQQ7mDhRzXyxfG5SeqjSnJ/NTM0APAbwiPUhjZBzenz7?=
 =?us-ascii?Q?x0ID9Xg0Tn/w1nA0rVOBJ4tN/mAIPdhA3L8TIkSp3/C8ZsoHKSZfbpUTM5xd?=
 =?us-ascii?Q?DPnWqZRVPysRxn3HHY/T2nTA5laV2bLENtgXDM6VeskuZL3J8XT/5W4UbgsZ?=
 =?us-ascii?Q?mimQ+lndtPBIyC4dmVY3bdeua9qSptoeRwmxnIZN8YsrRw/j5rs9QwGLhJhD?=
 =?us-ascii?Q?8vMMXRHg/UE9IDhESo16+3pJJHWD3IAd1+iJorSr9FuSxQ24ibm55v/JkEyT?=
 =?us-ascii?Q?sJ25NhJS9fo6ubuUeiozIZi8L9Sfb/xPFTiwGiAUrGm6kH80GTvPeQ6d1r4r?=
 =?us-ascii?Q?5YhJ44/WKy3EPgwICevbpRcbk7TR/2jMZypgV25Q0PuxfiGr9cVom+VcH2xi?=
 =?us-ascii?Q?Gw5c3/o4lgLWLBFIuJ/kOTfarX5+dnM/O1mkN/rlmmIkOPic8TgIOptVAli8?=
 =?us-ascii?Q?DYAJnjt1EKgjShazVjfikEksEin+YFGmv+m7wd7Q8VvB5IXPjdtejpv5/5wz?=
 =?us-ascii?Q?vYVYj+LYfLnGGu0v1TCzIJosqEX5o4dEyCxBz10eZAWbgZ7dIlp5JJDMSSvj?=
 =?us-ascii?Q?FR+WxjYxwVS1g1V0B5ASubBIeG/bfaclLY+WfLQuFG+clnoG+xHUNk+03xOK?=
 =?us-ascii?Q?JWFjDFD9MqsoxgBR6E7+JZO7NwTsV33f7Rbf1ZWJcofx0t7YQY7xCyM6Oe+G?=
 =?us-ascii?Q?t3lDj1/S2pw7oEYrRnU884aPScLQUUu68sXXvW5BJH6mZSiKseTbqd4uKTC8?=
 =?us-ascii?Q?P0+bkNvG6sMnF/oVJPgbJB27M3f3aUJCHzhDTDu+P9CtxxtoMTDVff07NHyZ?=
 =?us-ascii?Q?ohvGuIY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y1KfcRYBYD3Wz73M604Z74sec7H7zvgJQfWpdDZWRdlELUsvaCn0sgjwqxAY?=
 =?us-ascii?Q?D2745bnJ/C7SZ8fze/ZHB9kUhNnBhXxWv5xROwffj5NGQnml+DypDwUuIPcr?=
 =?us-ascii?Q?DBt/YvvUz0/P6QQFUhKKI2RRjOmHwYWuaSeDEHvX6PRtcaqmKW683uH7zFSk?=
 =?us-ascii?Q?b2Cusknx5v8vdWtloLl5fK9ubXZ7RbrZbocCjblG6BV/0zbaf+HhdoKIMjnj?=
 =?us-ascii?Q?Kq/NAfghh6t0JRhk+q+17zzV9MyphwOEE3ZgTh0gCPdfUd1p/WsOm1LVOVEW?=
 =?us-ascii?Q?p1NfBU1xqY51bNO55yEqq11BHytiW2A10mU8iUnIKy/mLXU2WeaEhT+9an/p?=
 =?us-ascii?Q?QGb3ZL/gZ4M9Fagl5MTjaWfjkayujiLMbOK+a9eBl7PMth3KLCxL3q8fmtlP?=
 =?us-ascii?Q?hC78Bqrflf3VsP8nJnAdDTt3+ULxthY/gpQ7wJuYh2StG/iC3fUvQn97hZjP?=
 =?us-ascii?Q?W0bHp6pQAKHJ7T0DD7uFB2Fvwsl8E+nzrNLntfiWNroANCJwxSV1jsEC9DsE?=
 =?us-ascii?Q?G0Zqwl17Fa/fIDT9ZtXjtZt6S2N12vaQXRTNcgboqx0IIMjksurQIFulTWEi?=
 =?us-ascii?Q?CnvVPm5gm2+ScRVhRHMnea6pii/fS4Tl9+w0v6hswfPQug3dihPUVziXaEso?=
 =?us-ascii?Q?VPukE00Umemzsky3kwzHoYHAwsbo9vyL/a72yBzlyY16TuTVJbQ7aaaoMNAw?=
 =?us-ascii?Q?ldeh7X+4gHNhI5rRyG9IL6VHTzeCEpKAK7RORt3YZo+XdcvYgqps6tkz8ClZ?=
 =?us-ascii?Q?Wj5MU19Q+4D8g1I/TDpYN+LbGwF6uGUwyO1vTs78i5Zljgm2ehKbjQzDnYI/?=
 =?us-ascii?Q?S7dDDi5/g4IEkXgy9MdGeIZguuPsTTNhvbVGldY49z/cLMU1GMeZvqKXIbz5?=
 =?us-ascii?Q?mqRtTBbPkJf/g4ggTx5wXAH5Y3fPENNEiE8AuMCHGLF4R4qIfjIeQlURE8Mc?=
 =?us-ascii?Q?3Vj2tkw7cKBOceCbUgpno92F2M/IlyR2OAWVGkzj/RII9HShhdTaoGKen0ZK?=
 =?us-ascii?Q?/ULEvKFbml+RoHeiiIspmw1MDHibCvyFZtxrO0fvATfyAX/mNEgBudw4rcll?=
 =?us-ascii?Q?AgQ3ywR3pewxvbZOojk40vgKm2FhRmAs7CyePWECzZpyTddrhgUsFcZOWWZV?=
 =?us-ascii?Q?etvut8YUlAZUu3mHMFs+hTh7xUXRNKcWGF3AZ+uYlXyyT+vGlmixu6iXzevK?=
 =?us-ascii?Q?BWzk01YWpunlRxFGJBrH/UyznSr0M+NOlDFE6FZJU+bI5tWlT+O8Lu6ZMR72?=
 =?us-ascii?Q?691M5fSqBMYRyFVU8YIpnn5JD5SA9my1bY5tdfxdXTD38wlVftcuMeh3YC0V?=
 =?us-ascii?Q?CJX+EZFjX/e+vFoevj6CKpyPFXCK9jQRsl5vBKpzhCytYgaY2NBAzuDSU7Bn?=
 =?us-ascii?Q?A5GCTsw3CGvIagcbrNeSea0fmDLrVlnhnGrQHm6pQdoCZyaEKW7y8lxl+QEi?=
 =?us-ascii?Q?EATgoMLW1ZN6LmnGXA1FbW8v0S6Gh28J1WGjFqRhW2FLO4dxADOA+S1NOmOX?=
 =?us-ascii?Q?nAqe6sktxZvbT7NwFOVdeN53uxNgN6bLBpYYSMXNuZJGYICepHPMoF05rPDP?=
 =?us-ascii?Q?8hQnbDnfnQKlq0uchdMfyI+xAVP0Abdo+RsD4CDiX85F1dxw9h1/C1IeQOLU?=
 =?us-ascii?Q?3g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d4124f-cfe3-4092-89ad-08dcf781d476
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 18:53:36.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8aFfY03ToHnyCEz+Vh1F7b+D2blpB8C05KXOobg4uy5on7c30bHLSxrGLTDLVlpsInQVQk6/r4/FCmbXCRDr1rpE1Un1FtwiTjWNkfX0AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com

Hi Joel,

> -----Original Message-----
> From: Joel Granados <joel.granados@kernel.org>
> Sent: Monday, October 28, 2024 7:42 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> 21cnbao@gmail.com; akpm@linux-foundation.org; linux-
> crypto@vger.kernel.org; herbert@gondor.apana.org.au;
> davem@davemloft.net; clabbe@baylibre.com; ardb@kernel.org;
> ebiggers@google.com; surenb@google.com; Accardi, Kristen C
> <kristen.c.accardi@intel.com>; zanussi@kernel.org; viro@zeniv.linux.org.u=
k;
> brauner@kernel.org; jack@suse.cz; mcgrof@kernel.org; kees@kernel.org;
> bfoster@redhat.com; willy@infradead.org; linux-fsdevel@vger.kernel.org;
> Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> <vinodh.gopal@intel.com>
> Subject: Re: [RFC PATCH v1 13/13] mm: vmscan, swap, zswap: Compress
> batching of folios in shrink_folio_list().
>=20
> On Thu, Oct 17, 2024 at 11:41:01PM -0700, Kanchana P Sridhar wrote:
> > This patch enables the use of Intel IAA hardware compression accelerati=
on
> > to reclaim a batch of folios in shrink_folio_list(). This results in
> > reclaim throughput and workload/sys performance improvements.
> >
> > The earlier patches on compress batching deployed multiple IAA compress
> > engines for compressing up to SWAP_CRYPTO_SUB_BATCH_SIZE pages
> within a
> > large folio that is being stored in zswap_store(). This patch further
> > propagates the efficiency improvements demonstrated with IAA "batching
> > within folios", to vmscan "batching of folios" which will also use
> > batching within folios using the extensible architecture of
> > the __zswap_store_batch_core() procedure added earlier, that accepts
> > an array of folios.
>=20
> ...
>=20
> > +static inline void zswap_store_batch(struct swap_in_memory_cache_cb
> *simc)
> > +{
> > +}
> > +
> >  static inline bool zswap_store(struct folio *folio)
> >  {
> >  	return false;
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 79e6cb1d5c48..b8d6b599e9ae 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2064,6 +2064,15 @@ static struct ctl_table vm_table[] =3D {
> >  		.extra1		=3D SYSCTL_ZERO,
> >  		.extra2		=3D (void *)&page_cluster_max,
> >  	},
> > +	{
> > +		.procname	=3D "compress-batchsize",
> > +		.data		=3D &compress_batchsize,
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D proc_dointvec_minmax,
> Why not use proc_douintvec_minmax? These are the reasons I think you
> should use that (please correct me if I miss-read your patch):
>=20
> 1. Your range is [1,32] -> so no negative values
> 2. You are using the value to compare with an unsinged int
>    (simc->nr_folios) in your `struct swap_in_memory_cache_cb`. So
>    instead of going from int to uint, you should just do uint all
>    around. No?
> 3. Using proc_douintvec_minmax will automatically error out on negative
>    input without event considering your range, so there is less code
>    executed at the end.

Thanks for your code review comments! Sure, what you suggest makes
sense. Based on Yosry's suggestions, I plan to separate out the
batching reclaim shrink_folio_list() changes into a separate series, and
focus on just the zswap modifications to support large folio compression
batching in the initial series. I will make sure to incorporate your commen=
ts
in the shrink_folio_list() batching reclaim series.

Thanks,
Kanchana

>=20
> > +		.extra1		=3D SYSCTL_ONE,
> > +		.extra2		=3D (void *)&compress_batchsize_max,
> > +	},
> >  	{
> >  		.procname	=3D "dirtytime_expire_seconds",
> >  		.data		=3D &dirtytime_expire_interval,
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index a28d28b6b3ce..065db25309b8 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -226,6 +226,131 @@ static void swap_zeromap_folio_clear(struct folio
> *folio)
> >  	}
> >  }
>=20
> ...
>=20
> Best
>=20
> --
>=20
> Joel Granados

