Return-Path: <linux-fsdevel+bounces-58969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5CBB3383E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716C2483C8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7C299AAC;
	Mon, 25 Aug 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="txoEoz3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0678242D96;
	Mon, 25 Aug 2025 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108297; cv=fail; b=RLG9HDySg+NEEq09u0jYnSQqNMPOvc8XJJaOc/TEcM/jmE1QnAKcu0iBQG7pq+6P+oub6l1eo3u8CIthPrUUc/NLraJcp8rv6G17Bfv7J2F0TZszLjUPSpiwxJR3cjemun8vGL57pJpAeOJEyjZHmTYYNgRyCP9WNSR/cK2s4CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108297; c=relaxed/simple;
	bh=ZQE5fTQKGxRBmANfe7oz97Fmw2ZqbUmdtSFrlafrJic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocUKf2CCifKO7Sd85tNHYXBg/BHBXCHDKSGSEqHoG78z1JK1duKiTDebM1wumpFduf6N+2RYTXUuUYjSn8meG2r6RwkrzKXhR3xggCi3DqxPc0YMab84dDl9/6C7wTdZ2RGDKl9enubZs0l8GK61jOZntFZkqKgjt5askIT3Bbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=txoEoz3s; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756108295; x=1787644295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZQE5fTQKGxRBmANfe7oz97Fmw2ZqbUmdtSFrlafrJic=;
  b=txoEoz3swogGIjo/l0BvGt/nGZicEiNjDZJqz+vTWOra/b2vaK9GESKz
   SIdatB2q0ud6OYptptfQxS/GneLX28x4UMNhweNmGi7sle1QKila0nJfh
   epY4UAyUvY62omLkCvv4mAL8lLbJAPSD17cQfEvFrcb5PHNCSj/gUQzx9
   iz6WQ1hL85elza3aRJWkz5as8GMIibAIVj2Mx3HKjpIxmghmQmJfyWq0M
   b+ZzihmfyAQKQosA0z3HYDN+7xGYiaEe6uxk1nEFaIgccO1HWDGtym+4W
   RbNCfvtMOzujKUOQskGKHcJVVm5hG64r3B3bJMMiVgE8CGVns1fC+aolN
   g==;
X-CSE-ConnectionGUID: V64bZCM3R2CBKWn+Q2H24Q==
X-CSE-MsgGUID: PP3tJzQvT0a8B8cleZDKFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="76585156"
X-IronPort-AV: E=Sophos;i="6.17,312,1747666800"; 
   d="scan'208";a="76585156"
Received: from mail-japanwestazon11010070.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.70])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:50:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxSnebRJYTLo3D+Yda54rAyb/Jmfio7UnLDLFBS541WHw2iK+hHU0ws9mZciGvgNnkiEJcM4OOU8jlbFZZUUqdzGPM7NeYlv9GqPy9RKm86DV4d39s5JXKGcbh6SdjSAQDeG+LpCBg0Xf/p+LvdriN5pnjmMPvmKYwy97+PtHdFG30FC3RSjYP2+hwD3J02Y9CeGSwajBSgyigIc/9yQPrsvKIwRHsHISe5Q+RsV03BYpKODFp/BfM/KmERJKi103d9QCdq9t51kSFISg5PO06dr+15ghhSpmSPQMnGen7CTcHmmFvmKK2mSPbRZzjldy/kEJqvk4T19eqBkoUzvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQE5fTQKGxRBmANfe7oz97Fmw2ZqbUmdtSFrlafrJic=;
 b=l2q4mx1or299Ww8effXFqvX62HgjIzBhEP2wYo1S3VNTS5nVluXO0uWqhybhkfOkSk7/0Uhqp5+f38XQUaAGwDy3WNyPW278/n/ueuBudE87jjj+Hn3771mluikd0YH0aR0TzD3LwDXyt/Xy6ChuQ/fvTgG44F+Jr/ZZ5d90FLgqRhrv/FFKhqRliaH7wGjQQRQkhO00ZfUp6m2PalJNi834n+YeeRbKSgonSMPvn5A2GaQ9Qv+6q2Ghl5pFatvdxW29xFY8fDjXXFnYs+E78ofAXK70MDCw2Pu4qF3/t6ZNfmR1ExEbZ6kjkKU5GINvJPHe9yj7ZSkg+87VVi00BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13059.jpnprd01.prod.outlook.com (2603:1096:405:1de::7)
 by TY7PR01MB13705.jpnprd01.prod.outlook.com (2603:1096:405:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 07:50:13 +0000
Received: from TY4PR01MB13059.jpnprd01.prod.outlook.com
 ([fe80::8d03:a668:cb8a:f151]) by TY4PR01MB13059.jpnprd01.prod.outlook.com
 ([fe80::8d03:a668:cb8a:f151%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 07:50:12 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>
Subject: Re: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with
 cxl_mem probe completion
Thread-Topic: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate
 with cxl_mem probe completion
Thread-Index:
 AQHb9bLv4zMtn0217k6cvjwtOUPnhrQ/XBMAgACSGQCAE6DhgIAY1fuAgAA2vQCAAapGgIAE+FOA
Date: Mon, 25 Aug 2025 07:50:12 +0000
Message-ID: <67e6d058-7487-42ec-b5e4-932cb4c3893c@fujitsu.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
 <68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch>
 <68810a42ec985_1196810094@dwillia2-mobl4.notmuch>
 <01956e38-5dc7-45f3-8c56-e98c9b8a3b5c@fujitsu.com>
 <aKZW5exydL4G37gk@aschofie-mobl2.lan>
 <8293a3bb-9a82-48d3-a011-bbab4e15a5b8@fujitsu.com>
 <42fc9fa9-3fbb-48f1-9579-7b95e1096a3b@amd.com>
In-Reply-To: <42fc9fa9-3fbb-48f1-9579-7b95e1096a3b@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13059:EE_|TY7PR01MB13705:EE_
x-ms-office365-filtering-correlation-id: 5052a1b9-ebc7-4495-0ef2-08dde3ac05d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkpnUFFJa1lva3BEM21vaEhIZFNwaENUUGY3c28xTWU2eW5leEVPcEVwNG9C?=
 =?utf-8?B?WjJoMUc1cDhHVmlsS3FsdkJGUjc5aWlHdkVCNm1XaTdCcDJGY1Z1a0RJY0N6?=
 =?utf-8?B?VW90QzJPaHExUXlGRUJDMGU4Qy9kRkgyWmhFUmE1UFlrYlJ6MWlIQWVzWkRk?=
 =?utf-8?B?TVFsRmVCZjhvb3VxZTFtbVdYWEs5QjZGVElRM2dPNlBmSFIwRFF6WG02eXI1?=
 =?utf-8?B?UmxwZUJiUS9tRlpkUkxLK0FUaG9aQjZlRkVQWVJudnRpQXBubnlUWkU3cVI4?=
 =?utf-8?B?UWhtSmRldVFJZExQVFVxSk9JNXV6UXZJcDRybmpTWFhacitsOUkxcFFqbnBl?=
 =?utf-8?B?RXlIY3FDelBNbFJ0VldnSC9qdDd5ZlBwVzQ5Qm95R3F4cVF4Qy8vc1BhVW9K?=
 =?utf-8?B?WnVXd2tsclMvVVRJanZiU1VCa3UxK1ltTHVEQ0o5UGplVlA0TWNBY1pzT25w?=
 =?utf-8?B?WEdodzVVWXdYK21TaU8yWThPT3JxVWplUExBZTM5RG9ORlBpZGR3cDdlcm44?=
 =?utf-8?B?dkhDc0JaSURPclMxRDRSbWlud3pYZzI3ckZWck9yWmw3Mk03MCtUOWFKYkg2?=
 =?utf-8?B?YlZBcWtGcnJORTg0Y09acUNHY0ZqOTg5TzR1STZpUVBiMWFpQ0dIVTV4TmRI?=
 =?utf-8?B?bFNVeVo4dkZjUE90QlRmRVFyNTlWRTJoeUhVVm5aWXNKVSt2bXUzemczOXlL?=
 =?utf-8?B?MC9PaGR0UThYUVc1NHlIRDRHZzh3OURYeDRrWURoWTZtWVBONVY3Uk12OFdX?=
 =?utf-8?B?cU1EN0J6bnZvSXZaUTU4ckVaeVBIekM0S3JtUXM5ZFVwTU54VkhRVjVwUVlr?=
 =?utf-8?B?MXBnWWdUWVF6cFhoSTUyeHJnR20vWGZFVkQwU0FEclNmS2tWYXh4Q3Uvc0xD?=
 =?utf-8?B?bVphN0txck83ZFBJQjJQdk92MVZidG1CQ1BBOHRBSCtqWm0yZlBDajBGTmhE?=
 =?utf-8?B?WHVpL0NVeGNYTzliRFdFV0w1UkpmaGpheVl1NHJoN25uQWNGTGNRWHVOK2lw?=
 =?utf-8?B?SkhVZk1Bd0svZkFPWnpxdEtKNUVleVZtTWo3UmpWdm9qNTR2UVcxTHJNdE9a?=
 =?utf-8?B?M2dzeVRTMjIzNE1Lb0lJM1ZqcmtYelBTMGowNEl0ZkRYNXJXd3djbUtMSWRr?=
 =?utf-8?B?NCtWZHF1OEdyczBuT1Y2OW1ZWVZRWDBjRXVSQUZlUmd6TmRqQVNPSUhBOGRo?=
 =?utf-8?B?dXZKclZZMDlTU3pQU1dJaUxMZitjeG9oVzlsSitSbHg2MU95bHZOaVRLSENo?=
 =?utf-8?B?b2JCMVZWV0FZUEF4Ukl4cmpCdzJ3SVFQblk5YkhVeHZFazYrMDFZdnJlSmxS?=
 =?utf-8?B?Q21ia2JZQ0I1elp2eGhHWmZhek9RUC9DSkRkZ3JzT1JNcFFnMmM1ck5UZ2pV?=
 =?utf-8?B?MUlJQ2tHWkhzZk1MNkdCYXdBbCtJTTdoV1hmcVVSMExnYjdlU09WbnB2OEkz?=
 =?utf-8?B?SXk2aUlXbDRGa2JmbUJkSFlpVnkrU05uOTlWazlucXBtK3dRYVVJQ0ZhZTNu?=
 =?utf-8?B?M0tJYlVxeWdCbmhMTzJSMFVORVVnU21uMEw1N2h4LzBnZ1ZCL1pwV2Qzclha?=
 =?utf-8?B?VlAwM1JzRHRRVTA2OEpjeW9DeGwrZFZuaWNRbGNDMVhWbmlRaytzcEk2eElj?=
 =?utf-8?B?NC9tNlNIeEFuVFhZZWZIbnpSZDg3S2RENW1nZG9KeEhCN0NrcVRzV2NEelV5?=
 =?utf-8?B?dVV6cVpESmViTkdkY0dFV0JaTWk0Y1FUQnZzR2lTbmZWTGRacHFIdjRvc0Nq?=
 =?utf-8?B?cHV6K0ZaRU5yZU53RHNMSElRc0s1eHlxK0F2b2tkQndETGNKR2JEYVZHU0Fr?=
 =?utf-8?B?cFJ5QXlDQmI0M2lTQXFIdHZiSkVBbzFOL29hUEFhVXAxekZnbnRFUGdBQUcr?=
 =?utf-8?B?SGlZREJaZ3dNR2tvUGdJQlhRMkRMVHZtSzZWZnBVRE1pY3A0ZUNQVTlkajRw?=
 =?utf-8?B?SnMrVzZLS3pEOUFyK2FtYWlMRDFGV1JTRlRIcHRMMFU5bGVRUmNSdFZhcUsr?=
 =?utf-8?B?OHRTK1RHOSt6c0E3QUdvSitqUk1zUDMrK2ZvTStidUdaSDNiNGEvUlkzTWxk?=
 =?utf-8?Q?z9dbDQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13059.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU9rYTFEMG9GTlB4RjZkcU1PUjkvVzZmK3F3c2Z3T1ZYQURnNmpIajJMRUpB?=
 =?utf-8?B?dVdwUDVKNWtzTzZ4TFAxUGZIVVdiQzQySHI4YTUyZzVUV2dQVVR6eVVkL29R?=
 =?utf-8?B?OFZhQlIwYXdmQXBudXA1RzV0d2FPSndYbU9xOWhpRFl0RURkS3gwTUdvTm9P?=
 =?utf-8?B?WTgxRUVKVEVmVnRTWUlRZWRtVE5KemwwRW5mNWtoSEhaWGJRUllMYTdNbmJx?=
 =?utf-8?B?ZHNjUk93WDNLTUpYUEZrTnBlSUFqNXdMQVo1WlhBWG02MFU0aTMyRHpyN1BB?=
 =?utf-8?B?c1dQaEVidzRmWTFManRhQUlGZGV0WFc4aEpDZ2xVNjBzNDZHVlFERFd4R21F?=
 =?utf-8?B?RVpoVmFyeU5xUWZveHp3eHhWODUyd3hYWGx2Nmhmc0pYRkc0eHJQbUVjRFo3?=
 =?utf-8?B?MWJLMDFhSHhYRzZuMzFiMWplZk5UcHdrYWJZYng5NXE0WjNGemYva0xmL05D?=
 =?utf-8?B?NzZYS3FkYnN2VkpES014T3hneU1ObHIzQzBmWnlBNVIwZXZJeCtOQm8rNEZM?=
 =?utf-8?B?U1UrQXFUdGZQeHVoREhFb3M3WUhGQjdTL1pxNGowNW9ZV2twUHgwc01Yelk0?=
 =?utf-8?B?UmlWMU83cUlXZ0Uxekl2ZldSck1odEF3TktubHVuYjh0UjZESVE3OWZpcDlJ?=
 =?utf-8?B?TUFZWGFpYW9VclV2ZEpiUmhEbzMzVHQ2Y3ZucXY1MU5zK05EZm1TbnRUVksy?=
 =?utf-8?B?d3pLeHA2SjBSc1JwVVM2UGd3VVVaM2lDUWI0dmNWWmsxbTAxTWlyV2lEenBR?=
 =?utf-8?B?d0tMNDFQSjZJVnlnaXcyUVh5QS9Eb1FPRHMyeDRIcEc5WmZrR0dCOTNXVC9j?=
 =?utf-8?B?VVpxaHpuMDJtTXBPa3ZBUFNZRGgreUxXYUJXTUttb2Q1QUk3Mk1rZUlpV0JW?=
 =?utf-8?B?MnVzRi9mNk1BckpGM3hlUWdFSm1IbnZrcWlyYldKV1NUaGtoMVZqaGx3UENk?=
 =?utf-8?B?aHNySkV1MWxpMDJ4T2NoTzMyY3JDTzF1VDU1L3RlaDI0MWFoenRTOVhRUm1S?=
 =?utf-8?B?OTBFRmlMZklackVrUUgzaGxqazExNHhZZENWUklMNUV6VUpZN05VUURUNFhq?=
 =?utf-8?B?NFNaZ3FKZkEvdEZiSTBCRUxlaGQzSXJuZmZmM0Y5RGhCdUpiNlBEbmNFM3JX?=
 =?utf-8?B?WitUa2JKNkwvek42SFF2WEI4bXgrRm0yM2Y1Mmt3NVlTNGFEaGs3em11NUg5?=
 =?utf-8?B?ODRJOHQyVEF1dWJHTUVZNWowS0FLeHNweW5xMnV3dzloUTJ3QXF5YURZR0Rn?=
 =?utf-8?B?a1dOYmozZ0NlczRLVHZ4bE5WZUlzSDJrMnBDY202eHdpWFZZMGZOWVFjSWdo?=
 =?utf-8?B?Z3k5SjlJU3p1ZDBqRnRKT0hlcDhnY2t0aUJHanpCeHF4UDJhbDNZUUVlTW55?=
 =?utf-8?B?Uzg4LzNVZU04bW1hRnNsNzZpWnB4cUltU2ZzVUtlT0NabmhiL2ZSaE9aMWc5?=
 =?utf-8?B?SnpKcUZ0WFNCeCtYNjYySHJFd29GR0dDQktNcTJqWUFNQ3lWdFVDQXlMRnU2?=
 =?utf-8?B?QzBsSWdlZjBheEo2dHg5bXJEQlBLWjBYM1FtTFdkRElrOHp4d1ZxM3Q5c214?=
 =?utf-8?B?UHRwT0MxakxPVGRic1J6Y0lmaksyMHRuT1VqVFBtWk1hK2dESjVMZVhycGR5?=
 =?utf-8?B?QXptSFBuOXhHWDRVRlBxMER3UkFVSmxlM08yQjhrcXlOZFBGclk1bjBoalhE?=
 =?utf-8?B?ekRNTU04Mkt0enA5OEJ3K1JQZ0s2eHliMGFQL25WUEM2TTZiSVV2RG9OeEJU?=
 =?utf-8?B?czkvaVREWkx4VHF2b25rRW5aQmtabFZwcU1KSVdXSzVyZmNzV2lZckpkdXc3?=
 =?utf-8?B?Ykgxa1ZrUFNaaEhRS2V6a0xjUE9VbEEvRmdVallLUnJua3NYN0FBalVPb3Nx?=
 =?utf-8?B?bWZBUXZJWTFsZEw2WVp4SXNYSGpHNUJRenFrUTRZSUFlcXhtUVpvZXZlSjVO?=
 =?utf-8?B?QU5qVzlyY1JhZVBGc2U3UGtkVERGOEFSSGU0OWZVVmxsbEp6Vi81RDRzTGhJ?=
 =?utf-8?B?VFdMSk1FZmFCZytwazA4bkNHVHlZcWN1S1FHY0hLdTdHRzJQL3hkV0xWa2tz?=
 =?utf-8?B?dDFIWW85ejJSRm51K0hteXpWRjBKWVVMcFRyWHNodkR0MU9GbFI2dUZib3Ax?=
 =?utf-8?B?MVNmR2JPNHVpY2hiNU1WYXZmeUR3YjVtamlHVGIvK3dTNVVlNEx5djFpeXBF?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23919AF54118404FAA9D5961BFF48EE7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VQ2uRIy78MZJpa/asaHuIIUANeBvzehU3w1eCDAyLlkoUhoRFApAsixXrW/krEorkQpWWfIChKKFg0YQMIqnYwBssRLgHml3k8n4hZWhyfdrUiJ/u9bkgCIRQsLu11RwXriXfgCzxeiHomlfk/6CNlRR8HKxFtjLU0aJzEsy7MfRswI2VVEO7qOUWYiK5AW5Oj5LB2pkOE9BItwA/Vjcglp31ekNRBMvGpjGstcArjh5TmVjumyAfumj0/6CKcf5ME758EMZ0mBG69SYi+lhT7a0uxCF/GsOYtROq1C6zv6b5TvYmFtD3/EVNp8jU6BXBsgoYAmx9O4fVBRi0WIkPxS1kV4QRprPV73hRfxkNKa7ahvo3FXdjtuEU+jq7fdkdZS0/Obm/XBU+896K3gla5dwH0/f4PNhgPMClwIRweZjRPM3P6GZUX+JGP/289G8dDP4yKeDsMh60406qKcp5HopuNxmrFmkGIfk9bQ2Vb5Qy/qvsebHcWJeoFAeB7XZwH73RjnnDTzkbMSd4mvFvkMEJOw29ZpR0QXMoyWea9dn7aIKVGMQOt0jA+6oF3dYU/wT2RhlyojZWuQYJG3in6y61a6NSsWGgpbxC/l5+HlroJgSAc9jJeW7pwj5vLw0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13059.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5052a1b9-ebc7-4495-0ef2-08dde3ac05d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 07:50:12.8104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZU0D8Tg3u/D9srGqnHhQi+pqPlgLiTnQ2hWfZZKDpnPaAZybV5o5Ir4k3x3dJHuxYHyhyq23TiXvy781HylWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13705

DQoNCk9uIDIyLzA4LzIwMjUgMTE6NTYsIEtvcmFsYWhhbGxpIENoYW5uYWJhc2FwcGEsIFNtaXRh
IHdyb3RlOg0KPj4NCj4+Pg0KPj4+PiDCoMKgwqDCoMKgwqBgYGANCj4+Pj4NCj4+Pj4gMy7CoFdo
ZW7CoENYTF9SRUdJT07CoGlzwqBkaXNhYmxlZCzCoHRoZXJlwqBpc8KgYcKgZmFpbHVyZcKgdG/C
oGZhbGxiYWNrwqB0b8KgZGF4X2htZW0swqBpbsKgd2hpY2jCoGNhc2XCoG9ubHnCoENYTMKgV2lu
ZG93wqBYwqBpc8KgdmlzaWJsZS4NCj4+Pg0KPj4+IEhhdmVuJ3TCoHRlc3RlZMKgIUNYTF9SRUdJ
T07CoHlldC4NCj4gDQo+IFdoZW4gQ1hMX1JFR0lPTiBpcyBkaXNhYmxlZCwgREVWX0RBWF9DWEwg
d2lsbCBhbHNvIGJlIGRpc2FibGVkLiBTbyBkYXhfaG1lbSBzaG91bGQgaGFuZGxlIGl0LiANCg0K
WWVzLCBmYWxsaW5nIGJhY2sgdG8gZGF4X2htZW0va21lbSBpcyB0aGUgcmVzdWx0IHdlIGV4cGVj
dC4NCkkgaGF2ZW4ndCBmaWd1cmVkIG91dCB0aGUgcm9vdCBjYXVzZSBvZiB0aGUgaXNzdWUgeWV0
LCBidXQgSSBjYW4gdGVsbCB5b3UgdGhhdCBpbiBteSBRRU1VIGVudmlyb25tZW50LA0KdGhlcmUg
aXMgY3VycmVudGx5IGEgY2VydGFpbiBwcm9iYWJpbGl0eSB0aGF0IGl0IGNhbm5vdCBmYWxsIGJh
Y2sgdG8gZGF4X2htZW0va21lbS4NCg0KVXBvbiBpdHMgZmFpbHVyZSwgSSBvYnNlcnZlZCB0aGUg
Zm9sbG93aW5nIHdhcm5pbmdzIGFuZCBlcnJvcnMgKHdpdGggbXkgbG9jYWwgZml4dXAga2VybmVs
KS4NClsgICAxMi4yMDMyNTRdIGttZW0gZGF4MC4wOiBtYXBwaW5nMDogMHg1ZDAwMDAwMDAtMHg3
Y2ZmZmZmZmYgY291bGQgbm90IHJlc2VydmUgcmVnaW9uDQpbICAgMTIuMjAzNDM3XSBrbWVtIGRh
eDAuMDogcHJvYmUgd2l0aCBkcml2ZXIga21lbSBmYWlsZWQgd2l0aCBlcnJvciAtMTYNCg0KDQoN
Cj4gSSB3YXMgYWJsZSB0byBmYWxsYmFjayB0byBkYXhfaG1lbS4gQnV0IGxldCBtZcKga25vd8Kg
aWbCoEknbcKgbWlzc2luZ8Kgc29tZXRoaW5nLg0KPiANCj4gY29uZmlnwqBERVZfREFYX0NYTA0K
PiAgwqDCoMKgwqDCoMKgwqDCoHRyaXN0YXRlwqAiQ1hMwqBEQVg6wqBkaXJlY3TCoGFjY2Vzc8Kg
dG/CoENYTMKgUkFNwqByZWdpb25zIg0KPiAgwqDCoMKgwqDCoMKgwqDCoGRlcGVuZHPCoG9uwqBD
WExfQlVTwqAmJsKgQ1hMX1JFR0lPTsKgJibCoERFVl9EQVgNCj4gLi4NCj4gDQo+Pj4NCj4+Pj4g
wqDCoMKgwqDCoMKgT27CoGZhaWx1cmU6DQo+Pj4+IMKgwqDCoMKgwqDCoGBgYA0KPj4+PiDCoMKg
wqDCoMKgwqAxMDAwMDAwMDAtMjdmZmZmZmbCoDrCoFN5c3RlbcKgUkFNDQo+Pj4+IMKgwqDCoMKg
wqDCoDVjMDAwMTEyOC01YzAwMDExYjfCoDrCoHBvcnQxDQo+Pj4+IMKgwqDCoMKgwqDCoDVjMDAx
MTEyOC01YzAwMTExYjfCoDrCoHBvcnQyDQo+Pj4+IMKgwqDCoMKgwqDCoDVkMDAwMDAwMC02Y2Zm
ZmZmZsKgOsKgQ1hMwqBXaW5kb3fCoDANCj4+Pj4gwqDCoMKgwqDCoMKgNmQwMDAwMDAwLTdjZmZm
ZmZmwqA6wqBDWEzCoFdpbmRvd8KgMQ0KPj4+PiDCoMKgwqDCoMKgwqA3MDAwMDAwMDAwLTcwMDAw
MGZmZmbCoDrCoFBDScKgQnVzwqAwMDAwOjBjDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqA3MDAwMDAw
MDAwLTcwMDAwMGZmZmbCoDrCoDAwMDA6MGM6MDAuMA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oDcwMDAwMDEwODAtNzAwMDAwMTBkN8KgOsKgbWVtMQ0KPj4+PiDCoMKgwqDCoMKgwqBgYGANCj4+
Pj4NCj4+Pj4gwqDCoMKgwqDCoMKgT27CoHN1Y2Nlc3M6DQo+Pj4+IMKgwqDCoMKgwqDCoGBgYA0K
Pj4+PiDCoMKgwqDCoMKgwqA1ZDAwMDAwMDAtN2NmZmZmZmbCoDrCoGRheDAuMA0KPj4+PiDCoMKg
wqDCoMKgwqDCoMKgNWQwMDAwMDAwLTdjZmZmZmZmwqA6wqBTeXN0ZW3CoFJBTcKgKGttZW0pDQo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgNWQwMDAwMDAwLTZjZmZmZmZmwqA6wqBDWEzCoFdpbmRv
d8KgMA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoDZkMDAwMDAwMC03Y2ZmZmZmZsKgOsKgQ1hM
wqBXaW5kb3fCoDENCj4+Pj4gwqDCoMKgwqDCoMKgYGBgDQo+Pj4+DQo+Pj4+IEluwqB0ZXJtwqBv
ZsKgaXNzdWVzwqAxwqBhbmTCoDIswqB0aGlzwqBhcmlzZXPCoGJlY2F1c2XCoGhtZW1fcmVnaXN0
ZXJfZGV2aWNlKCnCoGF0dGVtcHRzwqB0b8KgcmVnaXN0ZXLCoHJlc291cmNlc8Kgb2bCoGFsbMKg
IkhNRU3CoGRldmljZXMsIsKgd2hlcmVhc8Kgd2XCoG9ubHnCoG5lZWTCoHRvwqByZWdpc3RlcsKg
dGhlwqBJT1JFU19ERVNDX1NPRlRfUkVTRVJWRUTCoHJlc291cmNlcy7CoEnCoGJlbGlldmXCoHJl
c29sdmluZ8KgdGhlwqBjdXJyZW50wqBUT0RPwqB3aWxswqBhZGRyZXNzwqB0aGlzLg0KPj4+Pg0K
Pj4+PiBgYGANCj4+Pj4gLcKgwqDCoHJjwqA9wqByZWdpb25faW50ZXJzZWN0cyhyZXMtPnN0YXJ0
LMKgcmVzb3VyY2Vfc2l6ZShyZXMpLMKgSU9SRVNPVVJDRV9NRU0sDQo+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgSU9SRVNfREVTQ19TT0ZU
X1JFU0VSVkVEKTsNCj4+Pj4gLcKgwqDCoGlmwqAocmPCoCE9wqBSRUdJT05fSU5URVJTRUNUUykN
Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuwqAwOw0KPj4+PiArwqDCoMKgLyrCoFRPRE86wqBp
bnNlcnTCoCJTb2Z0wqBSZXNlcnZlZCLCoGludG/CoGlvbWVtwqBoZXJlwqAqLw0KPj4+PiBgYGAN
Cj4+Pg0KPj4+IEFib3ZlwqBtYWtlc8Kgc2Vuc2UuDQo+Pg0KPj4gScKgdGhpbmvCoHRoZcKgc3Vi
cm91dGluZcKgYWRkX3NvZnRfcmVzZXJ2ZWQoKcKgaW7CoHlvdXLCoHByZXZpb3VzwqBwYXRjaHNl
dFsxXcKgYXJlwqBhYmxlwqB0b8KgY292ZXLCoHRoaXPCoFRPRE8NCj4+DQo+Pj4NCj4+PiBJJ2xs
wqBwcm9iYWJsecKgd2FpdMKgZm9ywqBhbsKgdXBkYXRlwqBmcm9twqBTbWl0YcKgdG/CoHRlc3TC
oGFnYWluLMKgYnV0wqBpZsKgeW91DQo+Pj4gb3LCoFNtaXRhwqBoYXZlwqBhbnl0aGluZ8KgeW91
wqB3YW50wqBtZcKgdG/CoHRyecKgb3V0wqBvbsKgbXnCoGhhcmR3d2FyZcKgaW7CoHRoZQ0KPj4+
IG1lYW50aW1lLMKgbGV0wqBtZcKga25vdy4NCj4+Pg0KPj4NCj4+IEhlcmXCoGlzwqBtecKgbG9j
YWzCoGZpeHVwwqBiYXNlZMKgb27CoERhbidzwqBSRkMswqBpdMKgY2FuwqByZXNvdmxlwqBpc3N1
ZcKgMcKgYW5kwqAyLg0KPiANCj4gScKgYWxtb3N0wqBoYXZlwqB0aGXCoHNhbWXCoGFwcHJvYWNo
wqDwn5mCwqBTb3JyeSzCoEnCoG1pc3NlZMKgYWRkaW5nwqB5b3VyDQo+ICJTaWduZWQtb2ZmLWJ5
Ii4uwqBXaWxswqBpbmNsdWRlwqBmb3LCoG5leHTCoHJldmlzaW9uLi4NCg0KTmV2ZXIgbWluZC4N
Cg0KR2xhZCB0byBzZWUgeW91ciBWNiwgSSB3aWxsIHRlc3QgYW5kIHRha2UgYSBsb29rIGF0IHNv
b24NCg0KDQoNCg0KPiANCj4+DQo+Pg0KPj4gLS3CoDg8wqAtLQ0KPj4gwqDCoMKgY29tbWl0wqBl
N2NjZDdhMDFlMTY4ZTE4NTk3MWRhNjZmNGFhMTNlYjQ1MWNhZWFmDQo+PiBBdXRob3I6wqBMacKg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gRGF0ZTrCoMKgwqBGcmnCoEF1Z8Kg
MjDCoDExOjA3OjE1wqAyMDI1wqArMDgwMA0KPj4NCj4+IMKgwqDCoMKgwqDCoEZpeMKgcHJvYmUt
b3JkZXLCoFRPRE8NCj4+IMKgwqDCoMKgwqDCoFNpZ25lZC1vZmYtYnk6wqBMacKgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4NCj4+IGRpZmbCoC0tZ2l0wqBhL2RyaXZlcnMvZGF4
L2htZW0vaG1lbS5jwqBiL2RyaXZlcnMvZGF4L2htZW0vaG1lbS5jDQo+PiBpbmRleMKgNzU0MTE1
ZGE4NmNjLi45NjVmZmM2MjIxMzbCoDEwMDY0NA0KPj4gLS0twqBhL2RyaXZlcnMvZGF4L2htZW0v
aG1lbS5jDQo+PiArKyvCoGIvZHJpdmVycy9kYXgvaG1lbS9obWVtLmMNCj4+IEBAwqAtOTMsNsKg
KzkzLDI2wqBAQMKgc3RhdGljwqB2b2lkwqBwcm9jZXNzX2RlZmVyX3dvcmsoc3RydWN0wqB3b3Jr
X3N0cnVjdMKgKl93b3JrKQ0KPj4gwqDCoMKgwqDCoMKgwqB3YWxrX2htZW1fcmVzb3VyY2VzKCZw
ZGV2LT5kZXYswqBoYW5kbGVfZGVmZXJyZWRfY3hsKTsNCj4+IMKgwqDCoH0NCj4+ICtzdGF0aWPC
oGludMKgYWRkX3NvZnRfcmVzZXJ2ZWQocmVzb3VyY2Vfc2l6ZV90wqBzdGFydCzCoHJlc291cmNl
X3NpemVfdMKgbGVuLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZMKgbG9uZ8KgZmxhZ3MpDQo+PiArew0KPj4gK8KgwqDCoMKgc3RydWN0wqByZXNvdXJjZcKg
KnJlc8KgPcKga3phbGxvYyhzaXplb2YoKnJlcykswqBHRlBfS0VSTkVMKTsNCj4+ICvCoMKgwqDC
oGludMKgcmM7DQo+PiArDQo+PiArwqDCoMKgwqBpZsKgKCFyZXMpDQo+PiArwqDCoMKgwqDCoMKg
wqDCoHJldHVybsKgLUVOT01FTTsNCj4+ICsNCj4+ICvCoMKgwqDCoCpyZXPCoD3CoERFRklORV9S
RVNfTkFNRURfREVTQyhzdGFydCzCoGxlbizCoCJTb2Z0wqBSZXNlcnZlZCIsDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmxhZ3PCoHzCoElPUkVTT1VSQ0Vf
TUVNLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoElPUkVT
X0RFU0NfU09GVF9SRVNFUlZFRCk7DQo+PiArDQo+PiArwqDCoMKgwqByY8KgPcKgaW5zZXJ0X3Jl
c291cmNlKCZpb21lbV9yZXNvdXJjZSzCoHJlcyk7DQo+PiArwqDCoMKgwqBpZsKgKHJjKQ0KPj4g
K8KgwqDCoMKgwqDCoMKgwqBrZnJlZShyZXMpOw0KPj4gKw0KPj4gK8KgwqDCoMKgcmV0dXJuwqBy
YzsNCj4+ICt9DQo+PiArDQo+PiDCoMKgwqBzdGF0aWPCoGludMKgaG1lbV9yZWdpc3Rlcl9kZXZp
Y2Uoc3RydWN0wqBkZXZpY2XCoCpob3N0LMKgaW50wqB0YXJnZXRfbmlkLA0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdMKgc3RydWN0wqByZXNvdXJjZcKgKnJl
cykNCj4+IMKgwqDCoHsNCj4+IEBAwqAtMTAyLDbCoCsxMjIsMTDCoEBAwqBzdGF0aWPCoGludMKg
aG1lbV9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0wqBkZXZpY2XCoCpob3N0LMKgaW50wqB0YXJnZXRf
bmlkLA0KPj4gwqDCoMKgwqDCoMKgwqBsb25nwqBpZDsNCj4+IMKgwqDCoMKgwqDCoMKgaW50wqBy
YzsNCj4+DQo+ICDCoMKgwqA+wqArwqDCoMKgwqBpZsKgKHNvZnRfcmVzZXJ2ZV9yZXNfaW50ZXJz
ZWN0cyhyZXMtPnN0YXJ0LMKgcmVzb3VyY2Vfc2l6ZShyZXMpLA0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBJT1JFU09VUkNFX01FTSzCoElPUkVTX0RFU0NfTk9ORSnCoD09wqBSRUdJ
T05fRElTSk9JTlQpDQo+PiArwqDCoMKgwqDCoMKgwqDCoHJldHVybsKgMDsNCj4+ICsNCj4gDQo+
IFNob3VsZMKgYWxzb8KgaGFuZGxlwqBDT05GSUdfRUZJX1NPRlRfUkVTRVJWRcKgbm90wqBlbmFi
bGVkwqBjYXNlLi4NCg0KDQoNCkkgdGhpbmsgaXTigJlzIHVubmVjZXNzYXJ5LiBGb3IgIUNPTkZJ
R19FRklfU09GVF9SRVNFUlZFLCBpdCB3aWxsIHJldHVybiBkaXJlY3RseSBiZWNhdXNlIHNvZnRf
cmVzZXJ2ZV9yZXNfaW50ZXJzZWN0cygpIHdpbGwgYWx3YXlzIHJldHVybiBSRUdJT05fRElTSk9J
TlQuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+IA0KPiBUaGFua3MNCj4gU21pdGENCg==

