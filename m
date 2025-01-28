Return-Path: <linux-fsdevel+bounces-40238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8D9A20DD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46521884086
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF514658B;
	Tue, 28 Jan 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQkkF1Mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00808567D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080099; cv=fail; b=rNCETX5MabFnjKe4Rb+snNg1gqzEASlBfqUJffWhdKOCaxfb+9iPe/NnEtoAQp5rTD/G92d1g/8C6JiwaAQrMQYGaLonhFH7IqOCM0Qp8IoabIdB+sdtWpQqB5AgINyhErgLzyghNv8TU/IBnwMQEPe8/eqm1I8+VVt0yv/qIVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080099; c=relaxed/simple;
	bh=xuyzzEZtM3doMCQjgYAxVKS8mWglBxQRJlC52S+4+Wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iumHjwkaVe/py0W6q8B/k9ezgeNYoo4vt1kZVIC8jO8yqNw0HwCSBxL55zmzKsI15T/XtIlzL/triMbffcvOldNN69m5qXV+nZO9IBBWrzkmYVWwE/M/JQayjnlFRII9m2mYSOgDoVicq0ZdFN4vi0f4J+pPGTOR0yL1z9AinwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQkkF1Mr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738080097; x=1769616097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xuyzzEZtM3doMCQjgYAxVKS8mWglBxQRJlC52S+4+Wo=;
  b=QQkkF1MrukMtD34gNkQ3uwWg1KJsi663ZejsarNPNEm840efq326e9Mm
   Tyd8nDn7kiTfo5aHRijWuN3kGW8sJWpMZPcAKP6bFZyapHcAjBmoLfvoc
   QDdXrhl9zDQ7cuBBur6HnQM8MUpHqE2x/0TYB6WcO2XJeHYjqjvR2Lcld
   WO1kJtyHPxsM5EbkRLhmw6NiBaA8VP6qgXyiwYj5ZgpsJE9byl05EfxH+
   JdHV+66tP/x8jI0ZOpqqgDf02zeyChLmrclKqha1AZVJHis93C8RbevKu
   ZoKg+dq6IANekD/31msdiQjN8nf3kR2R9Nc2xFxKB52I5+dyHMGw2+g4Z
   w==;
X-CSE-ConnectionGUID: oujifK1RQsyjP3BOKzqJiA==
X-CSE-MsgGUID: ZS+/Drs3TAikBpONuWZowg==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="37768696"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="37768696"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 08:01:36 -0800
X-CSE-ConnectionGUID: wF8d20LKTXOvV/z1OXAgtw==
X-CSE-MsgGUID: 9oak+Ay6SM+UMFYDq6xMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="113772351"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2025 08:01:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 28 Jan 2025 08:01:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 28 Jan 2025 08:01:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 28 Jan 2025 08:01:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB4oeww21sOqHnBblVxVH9+PVodVoeej6rvBgXqcea4UFD+R65B/+xeUd3VpvWa+aSLknz9H10BeKUxx6Iinx5/KLMGJ25P18/w7uvPZTIkZIARsJy0YokVS0YUxBqDD5hty6yzQLmeGKJ5bFWnFUaloKY3GHFyKK1adZyJW1ohivyNGFcxDEolgK5A97SFGvEIhq0OxSoS6sENqtjcI3vFnwknT5QK8xP8oCIYb5e8sp0SBNFiybMgagwaq5naGHRptz1tTijwO5ghY1Uq9l98jz8qJNpDD23l7G6H7vmVPPkTkDimu/lJ/Iy7Kru/oYpQOLqWrrrs8LcPdYKFB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHD92BZr1tyTNz6bWwVYg4YUhNPsw94C8C288izBTQE=;
 b=cNbxLzC3wTZqzxu1abLKTP0NGv+7jLtTPQribaGC55DdnTo7miwW8M7lPPY5wodNFMUWsls/kpkvJHGuGYU+WWS7sye+h7+WdhDYJWujIW/0cN2S/4/qIZBtOv/zqk+pI+HtuTe/BAkxoV+drcPGAhuHHoyQP+BYdDLIX0kxxORo67tP4zgb0jHexDKtPIj8s8TgiQyPc2WZrcFq/xQRVusL4ISqYjEM6vU/SBryaw5EdySJwys4L7pNu70GI337z5qsYwzYaqamQE4ZCPvlGFEz2GFGEtGOuJ5DNtOrjFpfESiFsYoLswdCLZeWgjUQQf6pLnPJkzScaq/d0N0VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 16:00:58 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%3]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 16:00:58 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: RE: Regression on linux-next (next-20250120)
Thread-Topic: Regression on linux-next (next-20250120)
Thread-Index: Adttq6oN2zvxaQC4Q86QyAJ6tLuOCQAF5fmAAJHYpoAAG5FWAABJCcig
Date: Tue, 28 Jan 2025 16:00:58 +0000
Message-ID: <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
 <20250127050416.GE1977892@ZenIV>
In-Reply-To: <20250127050416.GE1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: 38175606-9e55-4cd8-065a-08dd3fb4f47b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ilAVDBJl2JnL9i6/8q5MQVSU0wvUD14fQ5i/huy6gNzYv2Dnzbi1xfLLZvAO?=
 =?us-ascii?Q?McUKoU1BqElhKiBXF3wXHSwv5FokKf2HJNwO7kajTxPqB3rT7vPj/X0GqYE8?=
 =?us-ascii?Q?sPnInK0I1sRpfGkwOL3iP51kC+5qZOjsYOrdzW6DedtQWs0uQjguZSSqJQB9?=
 =?us-ascii?Q?MQ4HJp14tQgjJIjGU9xlrf/rV6KP8Pab/oi5/q/Cdir6x/NnFKWCRZQ0nVmH?=
 =?us-ascii?Q?mAuWK5BmJXVdLXT9+CqHDR0uUbS3XC3bsxZJt1Fgn+PfK/FJm9VbBqITImOk?=
 =?us-ascii?Q?zDB3r6BDipL3KPx9Hi2EBsrUvt6LXoVlVzR4XAEEw/+amlgyn186oTENpIa+?=
 =?us-ascii?Q?YEevHCqm6t5nQdTyZUOxdY4QyuwXMgTUWr48v0Wn/lyu0ZU3tp1N7CZUq1RT?=
 =?us-ascii?Q?CawrZu80OkPamQAjh+502ClqaO00PiduVvdKFxcI9O42aH0CkX3C6eUVPt8f?=
 =?us-ascii?Q?iyzbBn60foA0liDcEkOJ2SNni5AeiL0o6pxKlCslYo3DSCZy2H+WzaDHbjXo?=
 =?us-ascii?Q?E3mZLFrhIdePf9hkWZC1tCXDxrCtf1qxks7kZcOEaWWjiIUY1SmIBEFfuhP6?=
 =?us-ascii?Q?1EQ0SUrHuYSEdpEmdmnWk4Loes4SQHOaWIV+aN58EOqjKGNpwdrva+MZdvKZ?=
 =?us-ascii?Q?A96Vw8WL3QeB/VLwOpX9KbPJjatbLYW/1tL818IeEqLVUZbzbAIzr/ofxpLj?=
 =?us-ascii?Q?1c4QCTKZHBhHi3P824xH2FtuizIuHIdgQd0Yj3uqC17zqX51WryOyfr4zWGx?=
 =?us-ascii?Q?AfQBX+RiQ2f2oWh+fEp6NybB3SBLtpZnCXtwATh/AfKgjZxTRkmKxX4u7OqL?=
 =?us-ascii?Q?Pv4pbJTAt13TZ8eOh7jAxlGuU6CRRf1ptD9FerXnyWed2QrQHLVgLnuiy/MP?=
 =?us-ascii?Q?i7BTLugU555CRD1pADdYB286jmekln8zwx3ABj08HfX8DvC9L7kN4JqIvhAL?=
 =?us-ascii?Q?PfjtrWup/0gRxzQ3ESmV3Bux8Emq/kffpbp+vnAcLrjMmQYDMNucbv+gDVBi?=
 =?us-ascii?Q?2Z054ioj8FddcKVLbmVsSbHJqnZ/wWshuex5ro+M1hSR9PKTqFokMVDuuajX?=
 =?us-ascii?Q?UMD834cZt1V2ov4XFXzHcirhvjzhF/p+IZjy3Tk6ry8CsQTAfdURa9IMfUc/?=
 =?us-ascii?Q?p4PnpQYk3m8FqxHCIvlJijso/cQqG8hKWmWRY363S+A/CGDJxho1JrvCc927?=
 =?us-ascii?Q?GnjT4XvAiHoAgyBdPlqbNKPTabRdArcHeIHenJx2lvJpRRnYe5mUgU/ifxfh?=
 =?us-ascii?Q?uXiWWxqHle2rCRnMkPg/sI3jXUzeQOSI+feLJbEW6pyo/xzupcdo5TsAHfLf?=
 =?us-ascii?Q?gWEFHcu7gE5kkzvaStuG6CRVI2p3TgpaVvYE+dyF6p5kSK0p+oitdXdxZhNR?=
 =?us-ascii?Q?31YMszGsSdupc/CYhm43rdcPY2O5Xq53Nk9N/BQ1ihOIDkOPgLaAnvAN1bSG?=
 =?us-ascii?Q?hy3b1up307YkeFVWrQ2BL1DwJBhgMTfZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rPoPTR4uEAqpWlDctNTxZvicaGTP8ow+Et3XxajAUIbnZGAEsY6nlAJJAMuo?=
 =?us-ascii?Q?VIF4GSEcKpHC5o0ql+xh+rDIux7BYrE/dqaSximX4W+GgHHd+5EdERPxbLUH?=
 =?us-ascii?Q?+VL5X3V54gCLdtiOEy26aGaiZb2F3wfCqGKPFbh6W7kuVYBbkYmCdEY8bFXu?=
 =?us-ascii?Q?6A7bL3Ibr/7/GzhUYZ3n6hIR6UedhzDdOucJBr7SUlW+0+ZFkrdAJATHx+SL?=
 =?us-ascii?Q?LPXAoXMUiaEcGKhHFhIbWG6Mta1fStKS6MiuKxFosjdQJabvu0o2qVah7BjC?=
 =?us-ascii?Q?aCM+wwX3otMi/wqCTsQUWZ0SYLElmGfBzsXWV/Fbx77Q7Wu2QFnxD0YLg88D?=
 =?us-ascii?Q?rUHnynQlOr2RL+7dfe1ljNyGisF8YYdQFwfJVnHsnRJuuJvyAsdqfN3anwMm?=
 =?us-ascii?Q?SwYLz9rDIcQaiXJ/3MSX56oe/Z8zdUTsCRYridBTzdK64s1l4uBiQUiy8RJ+?=
 =?us-ascii?Q?Vh8HrMvCmgq002eNHejZXAlcDe5zaB4RT4tcT+rwJTDIw8ZYCf4Tetgq0yoo?=
 =?us-ascii?Q?/rF6eQaRpvg/WbyOY83bDvYe7JSq0GoINGc6R2KBIW9+vU50vH6xbLmIEtbm?=
 =?us-ascii?Q?pBmsqPbsBcQXnbuYcEKUMTM+KuTntVYUz/EAqtVoyj3gS0Q4ts5JSzLPZ8pJ?=
 =?us-ascii?Q?yIuaXOHZykY+qfCiVLyJ588Nsj2WxGgV1pF1ZRJzUW63/e07qyRlmNbUWKoN?=
 =?us-ascii?Q?yddU5KEgXnJA6FTuWn0GPyJX44q+ZgMleBrNHiIF+uQ9WM1sTWiwnJpfYqcN?=
 =?us-ascii?Q?LN3w87XWOd3LSI5ShKPWemert0qUxX+5geRf2lLa6MAKj8VNo9AgijVfhuCU?=
 =?us-ascii?Q?cq4jbCTX27T/vvKtnrqpTPATwWxUpCzjRcTdD2LKz2CZv1JzevaejeJPk1NA?=
 =?us-ascii?Q?leMvinxJ+mDS/dzbqoua0virjEIUZNaMI/IvjpfmOHkmBC3+NrlKwCae2vzZ?=
 =?us-ascii?Q?ChKkIyYOQFfY+mOxXmtb6hRbAliW31qiMoh2GBHUywfPzt/RqbmUbM1x2mb7?=
 =?us-ascii?Q?384FqdmIaGLJU17Hf3rCQ2R/GtwLCk/88i/o4xpi/mEzxAdtlw4X/wt2X96b?=
 =?us-ascii?Q?/ooeiNdiEg7a34f90XQx7bf1ym88dYkj6jYVPMDSuFuzVIqbUYmerbvVLiW8?=
 =?us-ascii?Q?nDICLsXas8ynvJcpS+8DMRHbsmKAk82iCAhMWDwaS1i2/MoKxscXEhHnv6uU?=
 =?us-ascii?Q?MhrZ6wyRfn1IwggN2Yq01grOQQC/4FepM25XapZMt9AbXRK1qyRWGcs2Muyh?=
 =?us-ascii?Q?GRqiBwPqJsulzX3ZlyKtnUZjtPYSEJLkNlDa76Qyn0JCr/btqLxTnSG7R9h4?=
 =?us-ascii?Q?B+O0RNM2FWAtUBF4thV1eqZvSV1NbvH6TqjBIdQiGFcWdwpaQiXQ/Z4Bo8dg?=
 =?us-ascii?Q?SiEtkaF7PhWD90wQpfNA1Ze4neDI2xmobDN/aHBKplar4l2BLRHC1bJAqs1v?=
 =?us-ascii?Q?KmIM+JbZPyzk0f7iebfvIxNmiQKZIZvhWe8wGWGyFoUSeMF5KEaVXFRhmoY5?=
 =?us-ascii?Q?6vXrQVX7h87kXdNzBCd802hjbkZ+6AOeqctQYPECfOJmVSY/gtKL/NpqnKbH?=
 =?us-ascii?Q?03jdLe8zQuw+dWqZJZYN1ozMJVGskVCTIC2K5YblvzWcnx0hn6g5GvcsFtDs?=
 =?us-ascii?Q?3w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38175606-9e55-4cd8-065a-08dd3fb4f47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 16:00:58.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6n3aUFlbeL3PHmx5qWbN8I2sOI6CwDdK/oDyp6UwZuV0YInToxgyBdDjF8viXTfW+qy3Br5jVpcn9uUEIESM2BPyZ+zF/lWyijNaxZOB0xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com

Hello Al,

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Monday, January 27, 2025 10:34 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; intel-
> gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; Kurmi, Suresh
> Kumar <suresh.kumar.kurmi@intel.com>; Saarinen, Jani
> <jani.saarinen@intel.com>; linux-fsdevel@vger.kernel.org; Alexander Gorde=
ev
> <agordeev@linux.ibm.com>
> Subject: Re: Regression on linux-next (next-20250120)
>=20
> On Sun, Jan 26, 2025 at 04:54:55PM +0100, Alexander Gordeev wrote:
>=20
> > > > Since the version next-20250120 [2], we are seeing the following
> > > > regression
> > >
> > > Ugh...  To narrow the things down, could you see if replacing
> > >                 fsd =3D kmalloc(sizeof(*fsd), GFP_KERNEL); with
> > >                 fsd =3D kzalloc(sizeof(*fsd), GFP_KERNEL); in
> > > fs/debugfs/file.c:__debugfs_file_get() affects the test?
> >
> > This change fixes lots of the below failures in our CI. FWIW:
> >
> > Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
>=20
> The real fix follows:
>=20
> [PATCH] Fix the missing initializations in __debugfs_file_get()
>=20
> both method table pointers in debugfs_fsdata need to be initialized,
> obviously...
>=20
> Fixes: 41a0ecc0997c "debugfs: get rid of dynamically allocation proxy_ops=
"
> Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c index
> e33cc77699cd..212cd8128e1f 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -111,6 +111,7 @@ static int __debugfs_file_get(struct dentry *dentry,
> enum dbgfs_get_mode mode)
>  				fsd->methods |=3D HAS_READ;
>  			if (ops->write)
>  				fsd->methods |=3D HAS_WRITE;
> +			fsd->real_fops =3D NULL;
>  		} else {
>  			const struct file_operations *ops;
>  			ops =3D fsd->real_fops =3D DEBUGFS_I(inode)->real_fops;
> @@ -124,6 +125,7 @@ static int __debugfs_file_get(struct dentry *dentry,
> enum dbgfs_get_mode mode)
>  				fsd->methods |=3D HAS_IOCTL;
>  			if (ops->poll)
>  				fsd->methods |=3D HAS_POLL;
> +			fsd->short_fops =3D NULL;
>  		}
>  		refcount_set(&fsd->active_users, 1);
>  		init_completion(&fsd->active_users_drained);


Unfortunately this change does not help us. I think it is the methods membe=
r that causes the problem. So the following change solves the problem for u=
s.


--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -102,6 +102,8 @@ static int __debugfs_file_get(struct dentry *dentry, en=
um dbgfs_get_mode mode)
                if (!fsd)
                        return -ENOMEM;

+               fsd->methods =3D 0;
+
                if (mode =3D=3D DBGFS_GET_SHORT) {
                        const struct debugfs_short_fops *ops;
                        ops =3D fsd->short_fops =3D DEBUGFS_I(inode)->short=
_fops;

My guess is, since methods have some junk value in it, we are trying to cal=
l a read function for a debugfs entry for which it doesn't exist. That lead=
s to the failure.

<4>[   34.240163] Call Trace:
<4>[   34.240164]  <TASK>
<4>[   34.240165]  ? show_regs+0x6c/0x80
<4>[   34.240169]  ? __die+0x24/0x80
<4>[   34.240171]  ? page_fault_oops+0x175/0x5d0
<4>[   34.240176]  ? do_user_addr_fault+0x4c6/0x9d0
<4>[   34.240179]  ? exc_page_fault+0x8a/0x300
<4>[   34.240182]  ? asm_exc_page_fault+0x27/0x30
<4>[   34.240187]  *full_proxy_read*+0x6b/0xb0
<4>[   34.240191]  vfs_read+0xf9/0x390

My take would be to stick with the kzalloc like you suggested.

Regards

Chaitanya

