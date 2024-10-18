Return-Path: <linux-fsdevel+bounces-32385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601E9A49CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8072EB232F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B719191461;
	Fri, 18 Oct 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCMcYztA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0F152E12;
	Fri, 18 Oct 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729292478; cv=fail; b=qAC2uKA1lmmI4Bk9qNyYN+uPRWk53go2vRGOO7j4iMVdE8Wxuzwhjy3qpB5JrrEqluO9XNXBTcA6l15hNEFLhlJ6QPPBMhvk0++PaskfJ/D15IEAHx94Ae6n5KMmirKVBH4D3z33+AShewNvW8mMBgmUAqR/NYBootxxruMD5TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729292478; c=relaxed/simple;
	bh=oyOfyc0NXtIjwbMQsO81rw7aqSILFS63ip1kw7C6s5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ImQfDEAMSx7wodkC2GM+e9obFuvHnizqYusRfDKc28Io2N96f6RGXhW1s8vxjLMI3QCCrI/tB6ZhSDn49hyuS0O9D62r9A9jk3uqYUT4X0MB/WvfDZIQMZ2gpGilJfskKcSkZ5JkQSllM8tpw6qFXAFv3NYAnrFi44VRwFrtXsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCMcYztA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729292476; x=1760828476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oyOfyc0NXtIjwbMQsO81rw7aqSILFS63ip1kw7C6s5U=;
  b=NCMcYztAQOgpEBXaC0gYMWfw10w3OwIMaMOZ47zvWNumhXTHoTn1H0ti
   GZYfmFGkAml/kFCsLsRoLiV2hvHn3lDmEP8MmR2elWhf04GtE6XiVk59Y
   ZuSdEgq1WVCK1dpIehwTvcXMS/5zyupeGS0cI1PBLJ4wVf8HXaAomk9S/
   W8iMst6T/8bJVxM0adddIN8tNx6u+TxkVwDlrDBScQ7zTLjhhoEW9xa4T
   sUQeEmwCyGag5MJjSX5oJXM7h8WGzjGQIB1GpE0tbcQEKZq4jYyefx3g0
   /lrtby0JmUVGH4LOmHKsDEKGjEgzhJcY3Qf+m+YyHD7DgmdGDdF8SvcuR
   g==;
X-CSE-ConnectionGUID: g0a0+ZQqTz2V6zT3hayG5g==
X-CSE-MsgGUID: Reojxt4nRhmS8czKX2Dotw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="16456056"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="16456056"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 16:01:15 -0700
X-CSE-ConnectionGUID: ljXtgA4TT1qhAw5gfVS5rg==
X-CSE-MsgGUID: cEWRCrdwSEy25dM3yT7rPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78904703"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 16:01:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 16:01:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 16:01:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 16:01:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 16:01:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSolSpm7f2MypqGPxC6OOrWYBOfOzxdlIs74wZ9Sm31GqKHT64ZRpxw4sfnwjo20WvZTGpydVrUKKcCvB2xfdwVjb0zn39P6Mvb1g32zctyLBEn/SyUU/yvl4EZKKsZZ0oXN1BgID3m1u04Ue4Q+HpFJahL7XdSJxoPRFuIQEa9D61CuqNqF4y1MLaVit1eZX9OaML0N/zNdxPSNkFp8cLpCbOW2EYbg1yL3Rj6Mkr2GHlyOcGb/SClz0Rb078hr9/Zv2zvPHGDDQtrby0wEpinuwehN7Ujp+FHM4bTKhcYWWpoPnp7L4gzOb3Hq5K1ItVg3r2hrdOXxj7wx/byTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcANZuWxcfNMPlPdbjZl5cOKeD8LCj/DN1l77XrKjdw=;
 b=XsjpvAMeDRuy2+1DSwCPOf5Lcxz7LfdR1TMK8M0ndKfDBiZzUp9ou+n3aeEvA1kmVUfP5cokiu52Igd21deTy2AvTwcQPu7/2Sa+pfWE9KWjT1gXdQJEAu0rzy/tbmNW7EAAsdJUWAdLjvw5CriuUUnJzTIn+4unLHQRxnRPNRpGRs6NWG/LcTtdzX1J3vRDh4G/SN5lNkQ6T1zultKqTHmltFTCaOIkYS0BkZPcKJfaDto5qjiM7RudYJSn/2dhODrP1KJnUIFAsRBqXVoYhVt/m7eXMI64s0wWbD43QTGjQMOGTzXZ3HNJFzq3gSWpkX5kJJoreKBMyZNM8GENGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 23:01:10 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 23:01:10 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "clabbe@baylibre.com"
	<clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com"
	<surenb@google.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"zanussi@kernel.org" <zanussi@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "joel.granados@kernel.org"
	<joel.granados@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation to
 acomp_alg and acomp_req
Thread-Topic: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation to
 acomp_alg and acomp_req
Thread-Index: AQHbISi3RijobI6hNEW+Nkk4X+Po8rKMI8mAgAD3FUA=
Date: Fri, 18 Oct 2024 23:01:10 +0000
Message-ID: <SJ0PR11MB5678CE94DDBDEC00EA693293C9402@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-2-kanchana.p.sridhar@intel.com>
 <ZxIUXX-FGxOO1qy1@gondor.apana.org.au>
In-Reply-To: <ZxIUXX-FGxOO1qy1@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB8027:EE_
x-ms-office365-filtering-correlation-id: 3d0d0e80-cb89-4740-4af8-08dcefc8c1a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ysblQUAxpnYYD44LrA3WA18zfpevzQKKwxIIBrSM3m5vThLPw4z8F4sFJPtR?=
 =?us-ascii?Q?PiwJnJPNpL/LLXUqw9HGnN59r+vr/BANd4CF7KcPJ0vr78xfvY0GKrxptc1a?=
 =?us-ascii?Q?tRqSe5/aejXNxxPN+/PBdVDos33ap1VkzyfESTRhQr+ie72+BDVxc8RHDf/C?=
 =?us-ascii?Q?BSJc0CNj1TGq9zWHAUKAQNvSUvP2+itsYW7trjMSAFg+TSNkzQuR36HEwlwO?=
 =?us-ascii?Q?1+vMpvukkCwzKzlB5YXEQY7gQ5hZPYF549TtXrel0ouHTkRyRjxih67mo28K?=
 =?us-ascii?Q?g0+06HAdk0PuUqB8n9YY+VgCM27KjfK8GmeccU+95LN8jD1ZaHLyxAfGSRbe?=
 =?us-ascii?Q?g+Wc5eu4OyI6OyYd3wtVbo74KvnJJMSf5Nd69caC9p23XarVZSlPzbtRu3Bg?=
 =?us-ascii?Q?GIgtUkb82Dm+fZmEwxI01wzCG2H4oW/PA35P3yE+rp5s0NyxSx7ERzDoeqpt?=
 =?us-ascii?Q?GjspJI/Ff7xf1nh8K8FPp7qIJAMJsgwa8PKTH0neuP6aknyLZ19hPEnNm3aI?=
 =?us-ascii?Q?vz8ofmuPVI3gCE/BbMk45wNH4pWSl3Ft2gogdVVWPjaWANrVrOwBNMfRrO6x?=
 =?us-ascii?Q?nvVDbqf6Wn6pviB4NNF6n3mWZMpALB+XDZp0PkD/yHaFPmhSM5cFHu+Ihzkf?=
 =?us-ascii?Q?b7gMOqNp+3P34OC50bgGImE2Qb9s7QweMWH6LczbvBUer2mFIHPEsuPmZjvK?=
 =?us-ascii?Q?I5KvlwGsgOcTPWZExxPgUvehNtl39VSyjD3aHWHKgaVwx7jW4Vcn4PJEw266?=
 =?us-ascii?Q?zTOJlrWxvD1kRVZZ5KuQxGV09VQKy+DvztdRvHh541ADDVDRb5kfGeifo5ZG?=
 =?us-ascii?Q?tdo5SrW/BjFtim7TYPKENsgSs3iqaBIYNoo7c9C9qgsmcGacDlVdNXUIL4R7?=
 =?us-ascii?Q?5GYRUcpPdNDf72DHJF0G49Rd5+pEDVHA0BbpDiB2gYKy4bUUdr+JFQAU2g+l?=
 =?us-ascii?Q?eW57ANlz90B2PUJBQ7E6VDHjnGtiIt5BMenN0jpzI1ItVl3GkvvpbLF3QQJj?=
 =?us-ascii?Q?Uo6MqvrxVnMSFNcMUWvIITj208rKWk9MoLJ/knyr+8tZWABpzs9qh/NCEVPk?=
 =?us-ascii?Q?i0W7lpnXERb+YOXcb3P5BEoJ80NkDp//y+wH9EjJ6zIsfyrDLmDdq31NYzkx?=
 =?us-ascii?Q?Fmo3edaZ0r4XSTzMwezVYfi2AZhZ53EX9aVa6qCp6kK0ig98vXJ7Wf5ssd1k?=
 =?us-ascii?Q?4RnBEjUd2UDjazhe6tdVVcpRj8lToFhggiIPwOidc326oPhK5ngEtAsnLBAP?=
 =?us-ascii?Q?yG7bIJMSsSacDmuj0Rs8Bw+zNzOTPrx26Wa/agB/IvcHuKBdqmLiY2n1qfyZ?=
 =?us-ascii?Q?IljdPbneapO4tf51ruGUDp9b?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/0S7XkRLRq0Zt1rjIsw/LjwK4BbHDIiSk1JfKxUrZ/EGxTCaF/rZpDXOe21?=
 =?us-ascii?Q?MMdwbOrTMb8+wzyqMf1+Q+tHhXOAhpb184MK3XN1mD+rB02Bl0pPx+vNT8Ik?=
 =?us-ascii?Q?2eOmyfLSHcAToVohO4Gr+HEB+DJJN4L2t119qHJvql4pg2SUdVIe+SlytUPE?=
 =?us-ascii?Q?r+JU6xqMusRLLeTtDSjzIKgvahVNJYEXEVv68sPIBDgcD7sOJooZhwZftuow?=
 =?us-ascii?Q?R8VTziwPYzTgANDHS8HXH3NCv874a+3OgyOKYv0I2LaTu9zivyBnIio1R40o?=
 =?us-ascii?Q?EZqiWJIT1IVrSwIwnpgXz3YY6OBX+/xYbePuhtetI2dfpwIJrSpbW0JTrih0?=
 =?us-ascii?Q?aBDCyT2crnvxmAEK7mL2KLHIDSbo+sS44fSlpReQJT/H2rN2HP3fuv70KD+U?=
 =?us-ascii?Q?6trw0JJqvMsZNSb4t4NLokyOMW/n8WspGx78TlbPhq0JcaH3f+fjMxzAssZs?=
 =?us-ascii?Q?Mo3Tw/yzdI7riSnglYWTGXAzvmEPw4E4RIDu8SM4t4WN38UBDm+IuKjIxary?=
 =?us-ascii?Q?KhGF3/hnYzn8i2FLc3h0Uq8cNtJoNcccSHEWK53KUF0IB0kWD4bHT6IilIe/?=
 =?us-ascii?Q?Yv4O+9v+Vtf5FXlyLvsSnf+/de6VxSpbmkfAZ9LRd4T2Utzjr7g4KIiLYsGg?=
 =?us-ascii?Q?J45qGJYpvuU4Zja2t2viNhM8/gdJ6OITYZa0Xyq8ibWypfk/r95lr09LVhwB?=
 =?us-ascii?Q?x0m3JjTQxzj//qkLH6yk9oAelkHGJP8IUVKCfZgrrh97SSAEFLtOUG4ZAQ7W?=
 =?us-ascii?Q?iIydKJntIty5Gl8ByIlg5GXxqs9GwbLbs/ptMBun5WfJY+v9CJR9TBvUjMeR?=
 =?us-ascii?Q?C/aprl4QmKAIJr2Oip2AkI59f0u+HkCG8lha3aG6SiJYzHIai47ddq1mp8LA?=
 =?us-ascii?Q?eZm3Wdx43UgpxeJE6tHx4QiFzhosQNv/yB84Is60Sk+QnR+ituqwZunCgb3r?=
 =?us-ascii?Q?VmZv/asLpjW+m3SZgHaDlXdJNQE8wMBIE0oMTFpGq8hy8GVbqJDo7wOAEkej?=
 =?us-ascii?Q?duGdgerm7dRKKwDQp+FPKdnIyeyWYPa2kydFdnU7cKquioKOSkfObUtUmpA/?=
 =?us-ascii?Q?i174Vk+de2OgKgYBJ455mf31wxPn+t0VS+pHXbeY4oWCI/VsUANf2XM1y4z2?=
 =?us-ascii?Q?EgB9QGlfPdneEMmPIorguh9EOVALUk4sKnpj9nQzUe3o8IHmWUDxzlkJS5+5?=
 =?us-ascii?Q?xXNYmjyy6jwOt7/Jkf48WhMj40W76PkJJWyu109lLyhYNuTa0+z3A9/j4oPH?=
 =?us-ascii?Q?RFm2H7zVIlrnn6hdJv+x9fLbQ1bBxAtUYV4hoqiKYVSF4h4Ts7ku4HDYL6Mh?=
 =?us-ascii?Q?18U5orexUVCfvTdw22zpuBCBSeOCjxVQUwaCxSS5Ri0xC/mfnAqkHpdtTEwF?=
 =?us-ascii?Q?IB/yJSZHNonH2mIKocieTnO3uHxixVHVRzaaHj/RxhU2bCHqrPdbSXhgzZBG?=
 =?us-ascii?Q?uHT6rpr6gvzMOp6GNIUycQqS5BXtMLa5mpDlaep97ZAThYXFhJuPx3fyW1Gf?=
 =?us-ascii?Q?C5qAerqNGijfChN3EJ2FfUAzHlM2WzS66LoWv6uhTNC77D9NaKfEofuTsabk?=
 =?us-ascii?Q?4+XURKLNJheaRnlwwQTdmf7qVM8wJoDGTrLWp8kdOdcbke7KYCOMsm3/kz6w?=
 =?us-ascii?Q?Nw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0d0e80-cb89-4740-4af8-08dcefc8c1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 23:01:10.0703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zDmjCK08uqk/wvel1boHEDMHL2EH+c7npmuFt8/nWqaA5UzSeuSmSjFqIDWzMUnICiw2fB8LTKBZwFiec22dCVRJeKBOniDoWfjrrPkGVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
X-OriginatorOrg: intel.com

Hi Herbert,

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, October 18, 2024 12:55 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
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
> Subject: Re: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation =
to
> acomp_alg and acomp_req
>=20
> On Thu, Oct 17, 2024 at 11:40:49PM -0700, Kanchana P Sridhar wrote:
> > For async compress/decompress, provide a way for the caller to poll
> > for compress/decompress completion, rather than wait for an interrupt
> > to signal completion.
> >
> > Callers can submit a compress/decompress using crypto_acomp_compress
> > and decompress and rather than wait on a completion, call
> > crypto_acomp_poll() to check for completion.
> >
> > This is useful for hardware accelerators where the overhead of
> > interrupts and waiting for completions is too expensive.  Typically
> > the compress/decompress hw operations complete very quickly and in the
> > vast majority of cases, adding the overhead of interrupt handling and
> > waiting for completions simply adds unnecessary delays and cancels the
> > gains of using the hw acceleration.
> >
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > ---
> >  crypto/acompress.c                  |  1 +
> >  include/crypto/acompress.h          | 18 ++++++++++++++++++
> >  include/crypto/internal/acompress.h |  1 +
> >  3 files changed, 20 insertions(+)
>=20
> How about just adding a request flag that tells the driver to
> make the request synchronous if possible?
>=20
> Something like
>=20
> #define CRYPTO_ACOMP_REQ_POLL	0x00000001

Thanks for your code review comments. Are you referring to how the
async/poll interface is enabled at the level of say zswap (by setting a
flag in the acomp_req), followed by the iaa_crypto driver testing for
the flag and submitting the request and returning -EINPROGRESS.
Wouldn't we still need a separate API to do the polling?

I am not the expert on this, and would like to request Kristen's inputs
on whether this is feasible.

Thanks,
Kanchana


>=20
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

