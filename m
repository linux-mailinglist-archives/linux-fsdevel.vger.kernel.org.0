Return-Path: <linux-fsdevel+bounces-39966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0DA1A73B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528213A1823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794A211A1E;
	Thu, 23 Jan 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOk53q8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA50211A19
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737646879; cv=fail; b=YXanTmQfrsW4JqmdjLvbNNsDgSFiHrj0LPJYfcJ5xSfbUdnQxEJYiGKIpVuLc47UI43LE1mwaYUXCZrJWaMYYy5Bvx8fvooUtrx4i2H21qbUG0dKFypj0Bn3FutypJB09KYRi4P8kurRgadVl0myFKGRQPqPXoyp1yE72P7NDQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737646879; c=relaxed/simple;
	bh=dK46wJ/bVlTkMp7Q5jNK2gQfqjnE4F/NAj2CgiVIcyw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AgunT9egze8DR2Iw+/dniwZGb1PMv430CK4SHQy5h9Wr8hSYrtbcM5P28hRjtpf/iI70U+/tMwwoh6gSYmMoVB8BJX/qgt74p9cgqontYcrCg40jpRXapyoUQEIWSoX15QymzxDX4J/rIf1oRQXMJ8QfzqYLEaDHzFkqAhmjryc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOk53q8k; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737646877; x=1769182877;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dK46wJ/bVlTkMp7Q5jNK2gQfqjnE4F/NAj2CgiVIcyw=;
  b=BOk53q8kt1tvF2FUG1cac66lL/o0RTtFszxXPQV0nY3QCk8Fb8Ddkr+I
   JvBbumPVDNn4ZtroC9DyW2rSeSs45ldwy1Olg84f4/QHHljgxAVW8F4FP
   MfFUDn+TRSStAivQbgOlbJ0k3B5yaq4SLn5XxC68swkak2R+NPRhaG8Ky
   /ov8RxDB38vj1D9YlX4XPv3MHT2bRv6CuEPU241Vhz4KWJbniWrsLUr1l
   BW9Mj9WiLldQiexUWoLIFCCQN03BEZOI1Mc7TNwL09aMiT5RHskfhpDHy
   5RvDPlVYdcpJUi4uXFGf/PT8xNEZsiSegSIMIaOHSg8Mkp2+NHxS49C3B
   Q==;
X-CSE-ConnectionGUID: BudenyqsQBGit8TinMZhGw==
X-CSE-MsgGUID: BEg68QqhSm67Fl3xUVNSSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="25750695"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="25750695"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:41:16 -0800
X-CSE-ConnectionGUID: FJ6DPDDGSKe7thNYfxd97w==
X-CSE-MsgGUID: eYcyPOL/QC2FqD11dqgzZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107299396"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 07:41:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 07:41:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 07:41:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 07:41:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5kkIxnTYUOdqdNt7hXx/1gantmUxbtlC+cwVhj4b8HWWOlKhBwyyH+OlAxyTziyccwRs1ECVJqd0p4dYpW8NZIWsCfZqq+7pDbwxsGzlLI/HjVYF1DP3e/WT/GLY7zFllJGhH1xbEtD79LYtzlTTgbpt2gUHCn+8t/YDdTeaXIymihmFWqgF26VWPQQxqicmsJC2TyiL+hHSr4szBb2epX/IGCV6OLyD61yxl7Fw24aYG/MuBHQIravtOjOcjMEo7SfJkcnmD7oXKkwqLaXjCtYuYe9BfkqvnCBiaF2K+W8MrNa6SX4rNLF1K4UGDyu//Lxph+jUztXsZJFi/Gn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS64y9900yzuyMxeQg60MHZ/TnhoL/Hb5y4cxNfsToI=;
 b=shrr/5sXi9fHfY2B6hL44x8dDAT4ZL+0LNtL2CT9h6J+zVXXJSfm/i0xx07/yDoKrSAfTo+hplQNcdSUOvPdtKzOK7mtut/g9r564bQs3YrddmYpE4/yz61qAUQTh+ivvbfkLAGdrnIhfWiVtMiLr9xPUhXBK0TNtac6YCAmYYrQXd+DcyxsFN4KFd9XEBzkgzX9OzHCzZPkvSxZRNQHREzTvGFhAQpoUSMz07q8NZMDGT8udJbQFRpzi9+5qC3w+65C3vspymLt40UyC48HfBM864T6eed5QTZPhX8XEyrA10Rb3sDOI2t0RjnqOF/C9QKpNkfpMM+OkeMnU1Vu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 15:41:09 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 15:41:09 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Regression on linux-next (next-20250120)
Thread-Topic: Regression on linux-next (next-20250120)
Thread-Index: Adttq6oN2zvxaQC4Q86QyAJ6tLuOCQ==
Date: Thu, 23 Jan 2025 15:41:08 +0000
Message-ID: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: 9a8732c1-6309-4aea-77be-08dd3bc45b71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?E7VqmZMuQeHIZBbJ4gBrXNfIfml2XLAN1bPyM7uURWH021DAbMta44aoma?=
 =?iso-8859-1?Q?SeZC3u/jy9tn8mth0GT6B88LIKAz4mtqyJysxCRBVLTfqruoqVTN85ajSR?=
 =?iso-8859-1?Q?qBGu3v9KGRyIXC/OMzZLp6Y2yecSSGTVRlsPzFY1YfbPq1NGT0U2/gCyir?=
 =?iso-8859-1?Q?iDn+NoPMB3YFYIDIYiK4FKztENJVCEmxMYUrBj6LAmarRynZSYpHp/ooMs?=
 =?iso-8859-1?Q?ioX3rUUB8zXqCoOQ0sIzpZg5Z5iN7swVAaNqFkJ4wEg9Zem8RzrNSPEMfm?=
 =?iso-8859-1?Q?q8zHL18rGMtNiJxjOIIJCtOAR52BeyrWiq2T2Mvx/gG3kfn0wfDyGU+NuH?=
 =?iso-8859-1?Q?qWzQY6IxQrP9uUTH5aC08rUMBOKybS2ua1b1SQL5TbcIpQ1Qeyd1k3urTs?=
 =?iso-8859-1?Q?L8wIdInq+kh2FDnNASZRtelboacZn/2RHWipAUh8e/0YZj6gvz0ft22sbU?=
 =?iso-8859-1?Q?UfWg6aUtkQSv3Bxsh17RTt75tTlQrQKxc3C/bMK9PF0d4HNYwvmsukh5O7?=
 =?iso-8859-1?Q?sv/1M4MEqGQS4FFDyZNDBoth9qen1YndHF863UyrJyhWxYH3ZU0FxSatai?=
 =?iso-8859-1?Q?x5v2DRwPC2bfN5PtFNF0LGTIAtmbMImkPibpFPpv59GgchIkeumdzJDUm+?=
 =?iso-8859-1?Q?9F6EQrgWtIGgYt6BXetKGfWWSb/bXlSKTTgZn6OpIdLyoSrJ0hRKrsskfW?=
 =?iso-8859-1?Q?zsAjtvrTY3exSh8DQNprUzDsUTQZ/JufirFi56qc5AngjvQdKtLehBpIm8?=
 =?iso-8859-1?Q?hajJFDTBKpC/1Nz+4nRYoO6nI7+gHX1yt9vNlPPXQioaIlelC5pjZDXg2G?=
 =?iso-8859-1?Q?2biJurp/6OtO09LtiAlsr7QmGTnvhfW64gP7xfvkVRUEwd34Lt6411Nb0u?=
 =?iso-8859-1?Q?XzWVNvvJLNrVXZcxHXVXbPO/osx0mIbeHuDbCmOEjmlp9n+n9MM7oce015?=
 =?iso-8859-1?Q?wX8juodeMYDGEXVvxWprwYnpDY774Ok+TMqhVg5dBri+rP/sbSxtaCOfVD?=
 =?iso-8859-1?Q?vqq0Z6CZffIUI9FSBYaH0AEiRtzzO0QVU/6Br3YoK/k3gNzXuWP2KrH6Z2?=
 =?iso-8859-1?Q?uUWcpxKdgUuJjAGUcDS0ZjaiSyzL1SFP6t712Q3ihXq25UP+D4ZRnfEWn+?=
 =?iso-8859-1?Q?KIFMJWCmTfymejfSvLm2H/fhnzkT3Y2nFMBF3uKZEHIlcuvaubHEbb/clf?=
 =?iso-8859-1?Q?Ut2zafi8w2q/cjQGhCYkaMkrvEY9/WVw8UlW/kzSRy3/WjMMbNvKkkGWyC?=
 =?iso-8859-1?Q?Oe8Y5LA6oWYVQI+/FO1XPvDXGGZ6JO8NTh441x76QqYVyg2GGMY+tNJBCi?=
 =?iso-8859-1?Q?dQwrf/udqkOyMFvXyY6fecmWzCUIfdLhwmoHkPTRfzp3qNlO56F5W6Fduq?=
 =?iso-8859-1?Q?uHGMll66KjPTb2Ytueqxpl1vlp4I2ZpUVA+3WNRTv197bfFyrBiScwGwpw?=
 =?iso-8859-1?Q?365BQBPhbEDVk2ztZCY9ved36BxnOfsqHoQoSQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YipBML1gt5TJS8y0VEr8l8WZVIFng4yWq23luBXli/I4XEErKysCZngWiS?=
 =?iso-8859-1?Q?k/0yfwCyGFQetEqn3aGadjP+GMYWrNn/uV6uVtxAYzDHhpGizKK5Bc8Znp?=
 =?iso-8859-1?Q?3yzmEb/kLa+G9KOkfzqck93OpQ29zEDcteGw1sOY9yeTe9wex/WMoFJoJj?=
 =?iso-8859-1?Q?5wFNXJ1chVpibMHV4Rj/CMVLMDSt1LlWyelcd8WeycVTXcmnSv/BdNocG4?=
 =?iso-8859-1?Q?m2yxDbMgRhsk8pQPtf+q+U/kr4WVjhjKRfFHBfWKNliRTP21Ccb38WE4gs?=
 =?iso-8859-1?Q?5f440nMlsYamSfzUTohsZM8Rpuy0v/Pv1ur/rKkq16/5UUO9dKGYrg9UTT?=
 =?iso-8859-1?Q?l+yI6mH3THASBTyfQbOOL9t499MJLIibeS/5ZPZzgE3JoVv3b3Re1hxF+M?=
 =?iso-8859-1?Q?E9LG7XrZJGG2BsKI9TEpbWBRHv+7FSr1desWTyIOx/TfCXLNO3HCqcsC3j?=
 =?iso-8859-1?Q?mUuffU3br+pSU52RnYVE3zY1cVi9ooktaMdpcJBnfooiEyQq3M7zi1o8Y/?=
 =?iso-8859-1?Q?H5xb22d6HI5oyY3EwZwWNU6vxyZl68ivv162hq47xKERtT3NOYvFyqgYOe?=
 =?iso-8859-1?Q?x5aR/T06jyIoxgL+VjSK+TG7+VgZeWi6vlDDB4ysCT6k9/ds/4DaPXGap7?=
 =?iso-8859-1?Q?vqyNYPC5Zv65lQbvveS8S2fLpBnocXWqOqhg9cnjgsWL6XP+iD+ifsvgY4?=
 =?iso-8859-1?Q?or3YTPEdR8eLl/5XbJy2FOEg1kOhMNIMkiObg5ARThb1Tzlw882LalUJmI?=
 =?iso-8859-1?Q?xa7Km9bvFDbvMatdchtSGxtYMhlZQFaWoK/u0pSvAkNQXzuMgSag69kGMu?=
 =?iso-8859-1?Q?y7u/GzGOnW+VKsyOIDfvdMZhbRdcAHfQ1vuveV2ZzqLuOX3wj6nW6WR8fL?=
 =?iso-8859-1?Q?LXWOZojhCjKfG4ZBezICACFvKMDi3lWe6n1wQ5a9E5NXdJe1CSiHjPrR4n?=
 =?iso-8859-1?Q?iBDjDLr3+e3Z33EqGlvYdQoBiPe3Up/mQ3iT4KSLPE9a1e01uGbgL/uC2j?=
 =?iso-8859-1?Q?hggpCz9a+1GGDMufrgQ5s8a3zFowVeGfL2Ji9YritrHD3UCaPrpZEmliXe?=
 =?iso-8859-1?Q?dcwgdzxxT9mKBp5sGvJ8CTOSXP+nL5x3JjywGGosDviYVzFo0jklZoVlmP?=
 =?iso-8859-1?Q?fzgukCUcugJIm9imUDWEhPgZwyED4DLC0y0KPn7+PU8vBKMnj3LIhAapPb?=
 =?iso-8859-1?Q?wy/lS9rNeCSZ7ahZ4eTPAK6Rk0RjryPO0ZEWJ4K6LRnv9NqRj+U4JpAzxY?=
 =?iso-8859-1?Q?Ot5mpFxYqA5bsPShfHTQ613juGS7MoOD02orkGPv31JxU3+BzwE80BVEOo?=
 =?iso-8859-1?Q?EmbdoAUpa7JY32Cr/qCeJ0GPegzrBq+fnlbFm75vbmjk0U1c/vA5kkXmIB?=
 =?iso-8859-1?Q?bXWwIUssH4x1jZ7qFdcDvr9Wg/F+o9D3dvNqQHbQflO51jx6oN30wnxo5g?=
 =?iso-8859-1?Q?GWcX7Wvea6mWFt5hyYS02DJ79tvHjcgDnH6gyPzG733TwcDdDoyjfY8FD/?=
 =?iso-8859-1?Q?LChqXWc7ZZHWMB6sOcE4PgX4O4UJYcZHI05LVi+ybMhnT0cUDYJx1lvNhX?=
 =?iso-8859-1?Q?T5TTF4ZQUnexiUh1O5hyRDKG6mva3gnlkyHx84S/308W3AFa7tsnMPzgCd?=
 =?iso-8859-1?Q?eWzdBPLKK2K+xxpinBgjc1z2yKhwvljxaxb4bnLecop7jDbWlKCrmiCg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8732c1-6309-4aea-77be-08dd3bc45b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 15:41:08.9805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jb/n2dpQwgMbVY5BV6xjhNh93AThVBWQsBgHMO/OnH3S59F5xuSSo0oQ42jxO+dWHTk86l8ISzq1O7HM3fRYdbBQ6fHP0i4nAo++lEWg97A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com

Hello Al,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next repository.

Since the version next-20250120 [2], we are seeing the following regression

```````````````````````````````````````````````````````````````````````````=
``````
<4>[   21.520314] Oops: Oops: 0010 [#1] PREEMPT SMP NOPTI
<4>[   21.520317] CPU: 11 UID: 0 PID: 1384 Comm: debugfs_test Not tainted 6=
.13.0-next-20250121-next-20250121-gf066b5a6c7a0+ #1
<4>[   21.520319] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI=
, BIOS 0812 02/24/2023
<4>[   21.520320] RIP: 0010:0x0
<4>[   21.520324] Code: Unable to access opcode bytes at 0xffffffffffffffd6=
.
<4>[   21.520325] RSP: 0018:ffffc90001f77b58 EFLAGS: 00010282
<4>[   21.520327] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc900=
01f77c48
<4>[   21.520328] RDX: 0000000000000200 RSI: 00007fff2141fe40 RDI: ffff8881=
0e38d440
<4>[   21.520329] RBP: ffffc90001f77b98 R08: 0000000000000000 R09: 00000000=
00000000
<4>[   21.520331] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881=
497ba648
<4>[   21.520332] R13: ffff88810e38d440 R14: ffff88812fd5f400 R15: ffffc900=
01f77c48
<4>[   21.520333] FS:  00007e64c0ee8900(0000) GS:ffff88885f180000(0000) knl=
GS:0000000000000000
<4>[   21.520334] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   21.520336] CR2: ffffffffffffffd6 CR3: 0000000120674000 CR4: 00000000=
00f52ef0
<4>[   21.520337] PKRU: 55555554
<4>[   21.520338] Call Trace:
<4>[   21.520339]  <TASK>
<4>[   21.520341]  ? show_regs+0x6c/0x80
<4>[   21.520345]  ? __die+0x24/0x80
<4>[   21.520347]  ? page_fault_oops+0x175/0x5d0
<4>[   21.520351]  ? do_user_addr_fault+0x4c6/0x9d0
<4>[   21.520354]  ? exc_page_fault+0x8a/0x300
<4>[   21.520357]  ? asm_exc_page_fault+0x27/0x30
<4>[   21.520362]  full_proxy_read+0x6b/0xb0
<4>[   21.520366]  vfs_read+0xf9/0x390
.
```````````````````````````````````````````````````````````````````````````=
``````
Details log can be found in [3].

After bisecting the tree, the following patch [4] seems to be the first "ba=
d" commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
commit 41a0ecc0997cd40d913cce18867efd1c34c64e28
Author: Al Viro mailto:viro@zeniv.linux.org.uk
Date:=A0=A0 Sun Jan 12 08:06:47 2025 +0000

=A0=A0=A0 debugfs: get rid of dynamically allocation proxy_ops
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

We could not revert the patch but resetting to the parent of the commit see=
ms to fix the issue

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20250120
[3] https://intel-gfx-ci.01.org/tree/linux-next/next-20250120/bat-rpls-4/dm=
esg0.txt=20
[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20250120&id=3D41a0ecc0997cd40d913cce18867efd1c34c64e28


