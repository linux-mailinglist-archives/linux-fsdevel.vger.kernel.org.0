Return-Path: <linux-fsdevel+bounces-23447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8B92C55C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 23:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5DE2832C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B5185602;
	Tue,  9 Jul 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWlymRas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954541B86D4;
	Tue,  9 Jul 2024 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560971; cv=fail; b=KDoJD1LrWF2BQYigUQKpAfvZg7+POhEH3Bfn6Om5xCYPoAwp/o/LEMUB+8/pfuZASzSSt0F087+LhUQm0WSRccKxjoyygyBkaZdTLqiTxWj8H16F23mEsruHQk14AcrpwbLLN+ErKoCX20EUqsKUuumKT1BICl8TqtaYB7IxhMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560971; c=relaxed/simple;
	bh=sSyogQJ9JM747TtBELRItbtcpoMsG10uffN0oIYj/E0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWcX+DWahcXmKiCfUG2zc19m8edKFLFk7iTnY3Vx/YbekBYpRyXOlOqBIlqaGDHzjSGw4T80ccbFSJRH0s+7qvzYDHVTMQPimecDN7nTcauF0GRBJs65ZV2X0ZQ5NWYwbI1YlrBcZsELtvpA0gbqkbJlelY3Uhzpsei4+V4KxOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWlymRas; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720560969; x=1752096969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSyogQJ9JM747TtBELRItbtcpoMsG10uffN0oIYj/E0=;
  b=FWlymRas06ZLjTNs360gG0lWLRKFQbSGs9WlnSwsHIRZlhcx/BmjIx4c
   P0PYFVs/7QUg40BJIP+xQSSaIl/U0nmWODsWsS/4XQ0z7JTlcb7LsFARs
   zXLixa0yKPO4rPy+zjZ6G7kMv/tlb2p8yBgoTyHIrxzvy8insZcb7tPOT
   tAIgBO9h2jkAZxv/3YezjjoHUaLGLuxsTG9+j6u4v5wW4Mo4Q6xhcDDoO
   mHNR0Rm8lf5cTG48+vLaiqDQHvP50j0vsWG3qMhXfL6ct2cP2e+llVmSf
   OaFb9RxlsfurnrwYqv/btT7xKr03kPSA47HI6ZYZrC0l9UU/kOkMp+DkK
   A==;
X-CSE-ConnectionGUID: umMLVCXoSgGSH2jijt7tXw==
X-CSE-MsgGUID: gFpCXGj7QyGtYBOaGGUhWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28442738"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="28442738"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 14:36:08 -0700
X-CSE-ConnectionGUID: xNwt8svrQnusp+4T+latzg==
X-CSE-MsgGUID: O7Cv6MXrS8ypBxvIWALRmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="78726986"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 14:36:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 14:36:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 14:36:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 14:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIlXAV57vZoPkl6w32ARoYAEgNHNIp6m8u/AOlgDi9YY1Hkuf48tKDYsVhHx6GimOj6mIPcR8aa7/XuCBR1CHPUhdbIaFSfoNRQLq84l54RC7BXPqZ1eSEpwWddVSYgazJsby2N8CThyftgzt4ufDRKrhDsJuj1JmZAQstRRReDP5ET15bFSpOuUnn4DPUjcnAloNr1Z+QMDej9cy7M2dd/XGSLhumuyxjVLjQnJpQ/9ewHtlD/MUQi97fbd8mmSXOGi3ZfYZtHBY2cCbvBuwGovJ8MySxsndgd0kGfbnbF0ua3ce0oxM760ObT+PfYAzjFhgrwLoBwYGB5eyrkCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSyogQJ9JM747TtBELRItbtcpoMsG10uffN0oIYj/E0=;
 b=ZtCF5F7KiX6+mEAUewwL2C1BK5GYDjuKHIl+wQ38TM5AgrRErtcy1V7Rx8f5EZ01JJJzSD+cgLOS/6Vbo92UvcnnAXWDGROsv6PJNZb49YbtVr2UlQ6uXuvbVagbpaHLF2Mz8gDaJ3qo4i01L3ZJ8tDJyZwj3JoVAvUddVmTVpz8wMqmI44NeYFzFQwe1ds5GAlrqhCwMCk0PrhPklj2mexTepEG2KbH/pKgjOWfP7NYJMJr/wc597DN1p4rvEsyYlOtoMd6FBApFLIo6FJ6U8mTZ34YxJZ9pYs2tuDQ2k3eR3Lnj6yqNMDjjlV3wadNytBmjaJsl7RA7qvfrVjGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 21:36:01 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 21:36:00 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: syzbot <syzbot+f1d7fb4f94764243d23e@syzkaller.appspotmail.com>,
	"airlied@redhat.com" <airlied@redhat.com>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] [fs?] [mm?] INFO: task hung in remove_inode_hugepages
Thread-Topic: [syzbot] [fs?] [mm?] INFO: task hung in remove_inode_hugepages
Thread-Index: AQHa0WJKNUMy+6pBrE2++Kz4YY0Ov7Ht8ZwAgAAMdoCAANnFkA==
Date: Tue, 9 Jul 2024 21:36:00 +0000
Message-ID: <IA0PR11MB71850525CBC7D541CAB45DF1F8DB2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <IA0PR11MB7185EF69D19092412AC55B66F8DB2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <000000000000da3147061ccb5b55@google.com>
In-Reply-To: <000000000000da3147061ccb5b55@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CYYPR11MB8430:EE_
x-ms-office365-filtering-correlation-id: 63bf227c-f984-4026-2a63-08dca05f2093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bVZxNnRIRGZrSEtZQVdJU2hrQlA1eS9vRllJQ0JuRG82K0tUbWlBTktRdVdk?=
 =?utf-8?B?dW0xSFhrOGhkVHJuYkFBdWZpWkE0dzVyaTZIWjBWM3NWcmVycHVnQ3oxYlly?=
 =?utf-8?B?eEZDaVZXV0FiNXY4WFFncFBlZFlmeDM2b3pkb0ZYUks0QVZuck9lV21WTkoz?=
 =?utf-8?B?WVM2QXp0TEQ4MzlmdGVjUDVJUE1SWWc4S2t2S213L204Y2Q5QlpyWnRyMHFa?=
 =?utf-8?B?QUJtZW5MMTQ3V2Nud09xV1Z1VmdiTjVuL1RLRUF2OVF5SXlxN2xxRks5Yi90?=
 =?utf-8?B?Y0JJQlA2OXZrZjRrdTh1U01xT0pydEo4ZFpNUVFMWThVMUdxd0YzWkh2TDhp?=
 =?utf-8?B?V0QvZitVRjJpMm1RQXZqVUg0WFlpZUllY2NCaithUEJsUnFLZGxCRUVnYU5Q?=
 =?utf-8?B?cE5NS1hGK0kwelAyb2o1N3J5eDRtOXhWd2l4cStGaGVFOThzVkZrVFlJbzRB?=
 =?utf-8?B?c3hKKy9YRFpNTkx0SXdydU13dGhsU1hIMWZWa1lBUU44eGlGVHl0VnE0SUhs?=
 =?utf-8?B?RC9GYXc3enUvekNaVEpXU2wxSGN0UFlaME9tMG93dUtFNEFud0VUNDY5U21q?=
 =?utf-8?B?eGtudWxLTkR5TitnZFVIRFhrVFhLbUowdHVDMTN2b1ZWQWEvdFdKTE9DclV0?=
 =?utf-8?B?ZVBra0RZeW5NWEx6OTk4YXVsazZnc2w2WGhud1p1SUU5L0xPb01DODQrNlk0?=
 =?utf-8?B?YWhKd0cvZFd1Z0JhcS8vWTZQZ2k0R05aTFk4VTZXUVFxMkRPcFVIYm1YRFZj?=
 =?utf-8?B?UHI0T3p6WW5wbnZCbnkzQUZvVk9lOTdYeEZnVUhtc0pUemUwMkpJSTE3b0pm?=
 =?utf-8?B?K05wd2ZtUkI2eXBYZ2piN1Q1bkpHeUo3RSsvMVEzMmNURk9GNVFEczdqTDVC?=
 =?utf-8?B?aTVRbDFBTVc5Yk05bGQvcm5jQ3dTZGFFNlVndUJlckpxcktjNmhVUWhLTnFG?=
 =?utf-8?B?bUNaeFJwNCtxb1RjcWpsNTRuWnZId2ZxTzJBVVIvcmlXYXBXazhNNHgraVMx?=
 =?utf-8?B?NVN6NWROWThjNS9CbTVZa2JOSUR2aTdEd2lpVGNMZGdleXRJcjJmaGRHT3BQ?=
 =?utf-8?B?U3g3cXZKeVdCRVpReEdFeXFqRTNVQWZiamR3YklQYVpoZUlGQTRkSkRCakpr?=
 =?utf-8?B?ZWpqOVFJYU93VzJYcjBHVXlqS1daWFZ0M203OWpVMDFCSmsyNmlJUmZkNXR4?=
 =?utf-8?B?aEJ0dTJMQVJWbFB5dENDdkdJVzNzZnZ4MUk5Rk0xSTVIaGJFMnAvSDZuejFl?=
 =?utf-8?B?ZkJ2akNKRnpyazFCQjNlTXRDVlhxMnZ2ZTVZSnFZNEs5STgrbCs0ODk5a3VS?=
 =?utf-8?B?SnhtYVUvQU53RjkrN2owUnZtaXJnbmUrcGdRRGl0Y21MVkxuNWVOR1JZeDRD?=
 =?utf-8?B?VGhzc0ZvTHZxRHRNd2N5M2pRK0tucG9zSDhlMDFuU2tMTGJvc1dvTGFnZzhF?=
 =?utf-8?B?b294SnB4d3pGWWh0SVY0S2F6emtnYVBENzByR3ZpYnBPQ1V2RXVYWVRvaDZk?=
 =?utf-8?B?NkE3eXpXVDRJM0VuK2x3T3djVHQ2YlNzMnZKZU9RUjR4dG84R2t2ZVZ3Z2lV?=
 =?utf-8?B?NFJjVHpJYWtOQXBycTNDcituOUQ4N1NzSG5hdUdjREEvNUJ0OUhQc0NYeG1v?=
 =?utf-8?B?WXF4YXdEblNYQ1c3b0xIV1FmU2dMdDJKTTVNWHdIVU1IVVNjVjg3MW90M1RJ?=
 =?utf-8?B?T3FweUxIRDk4V01yQ2N4VjhRcU0vNm9acEp0c2RqMDlGM0xTRzg1ZTIvV1NT?=
 =?utf-8?B?MHgzbGg1UE41Vy95MFlVSmlFMHZJelRsYWFqMzQraCtZQzJ0U2NzWmJTSlJh?=
 =?utf-8?Q?E/tGbVutl/IrYqR6LYHfuSJ8T5tcfnue3Eb6o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0F4Y2YvQ1dGVEYwZHJ0SitveUdxV0ZXWWxtam5NMGtVSG4vWDNMYWtCRkJZ?=
 =?utf-8?B?Y1lFMERHVlFGeDM0UFl1Z2ZIeS9NVEg1MFczbURDZXdndmJSelFHa2ZFV29U?=
 =?utf-8?B?MjROZ0VlZFBIWDMybVE0TDBncUhpRkRMbnZlZVBPSEl5NVFTRXFWaHFmSkY5?=
 =?utf-8?B?QWxHNW84QS8rZUZOL0k3OFRKWmZlRnhuMFhCbXdNdHRXc3ZjMVltVEZQQkRC?=
 =?utf-8?B?TzhJZTltdDNualVtSlpaM0lTdk10UTR4YVR1VVFiNjZuZ2VvSHI5SGFZZkNM?=
 =?utf-8?B?elhvbDRNR2l3QTRxZDFFSlIwTDFhcklFcFlnSGE2clY0OGN5NnBtOVJKbWIz?=
 =?utf-8?B?akdseXJGbTVZMnZHTk9RYWUyajNlVzVQVmFuV2ZNdTBwVFV0TmF6M3h5Ylpv?=
 =?utf-8?B?ajc4d0doemF1VlhJWURTeS9FNTVtdG5DMW15R2ZJNXZTVjMrK29yR0NZdHpO?=
 =?utf-8?B?N0FqZWNESXBwM1VXVVk5SWg5bnNSbnVCbXBZMHE2Z1B0dEdrclJvMGlZV2pn?=
 =?utf-8?B?WllOL1A4U0FzUXN2eHNnNHdtRmFSVXYxWkt2MkdDd2FDT0E3cGN0Njdsa05a?=
 =?utf-8?B?dEpJWmgrdE4rRDM5cHBnaDlRYWVPMG8reGVMQkN4VTB3Um1xbzNibmhMRmpy?=
 =?utf-8?B?V1o3YXExd3hCbWhTdkxpUHRtNytWeEhNY2c4b2tQdXBaMkQySnRCTkZQT1Vj?=
 =?utf-8?B?RWZ2bVVOQzJYbHlFMzQrRy9WT3JtWElnTkFIUzVTUlh5QnVFM2RIUkFuM1k0?=
 =?utf-8?B?aW4yVEdBN2gxYTBBcWJvRUFOVTU2MTJWSHVPOXNhN0tFK1R4Y1lHTWFjSHRl?=
 =?utf-8?B?UW1qektQRlFpVk9OdHovOWd5S3NqQ2NLbG0yeC9YcGZOWVhvajBzWUtkcm9R?=
 =?utf-8?B?eFRXRnJwR3RIVVNPZkVTcFkzOWQ3MW9HWUdZd0JCODhxak53cW9DblA5WCs4?=
 =?utf-8?B?U25lRzJJR0VuK2tmV25XbTZZclRoZ21xdXRyMkEzbzZ3eUVWaFpBaVJNZGFw?=
 =?utf-8?B?aFYzK3RLZDBJMnlrVHN2L1lVcytYbkpWT3o5NFdQOXFkTHFzRndwVngzQWdR?=
 =?utf-8?B?RFJuS3ltVFNGTFRoc3dDV2I3L29Ed3FpRlMwNHJyRlNjaE1nTlRoVUhZVS9V?=
 =?utf-8?B?L3B5NU9DeVhkZmtRek45M1dxcDgrK29WYTVPaFZBdUhMcktJbmtZM0Q0VzdN?=
 =?utf-8?B?aDBWNXh6NkZiYkxNRktIRE9Ib3ozbS9QdHFlbGRXN2JkbDh5VUhyMXBUMlNq?=
 =?utf-8?B?SWVBY1lmUHFvRERuWU8xZmFKRlB5aDRwc2FPdExWMnpTQ0RncEZqZUhTOTRi?=
 =?utf-8?B?TTAyNFZLMjU5MzdiUFBWcWF6cFIveG9OZzZaUlRKcE1VcDJoaFFZc3BDMXVs?=
 =?utf-8?B?cFdkUkJTdzlmOFJZcEFDdkIrM0ZDZTZoUkxJVzcya1dETXJNeXJyQ2tubzZw?=
 =?utf-8?B?SDZtLzVOVjNHSVpMOWs4bWhnZXYrWlU4MEtoRUYxZWlFalNaQk02clFHVEY2?=
 =?utf-8?B?dWViam9PK0lzWjBPQ20zeGtTS0RtYS9idXlCTERxWVYvRXpIa2lCUUtGV2sw?=
 =?utf-8?B?bHJkbWJwZGxWZkJ5SW1pRHFWRUMzWVFBR1pQZFd4R0lpb0N2VUJDbzkzR1Vz?=
 =?utf-8?B?akJObk5UWjA5ZGNBSDVZUUV3eVlMbkNROE9IVnFEVjZ2MGRLQy9aYnhVQk5w?=
 =?utf-8?B?OGVtQkxRWnJLYzdSWmZ1bUErN3NGUHk4QWJuSlVHM3ZQV3dXUUZxQlBlNG9t?=
 =?utf-8?B?d0FHVHMrOFVEbkx6R1lCalM2MUJoYXFleEVJRDgyR2xQek5aRmFOdSt4cmNQ?=
 =?utf-8?B?N2lraWtrb3N1bnliL2N3Y2s2UHVFUC8rcVRBUDNjWFczRWRIRkxRdUZ2a2RH?=
 =?utf-8?B?cUk3dCtxZE5mMGV6SS92elNoR0F6eTFyZW1rMVZhQ1Z4VVpkMlJveVN2ci9Z?=
 =?utf-8?B?Myt4VFBlSDd0dmNmRkZFV3hTTVZBM0x1UldyYnJGVkRMK280c2x1YkhMQXIx?=
 =?utf-8?B?S2M4RnZhOW5uM1poSlFKdGNwNExXcFQydXBMc3V0V29Tdm13Ry9jYVhCT2l2?=
 =?utf-8?B?QmlscEc2eUxHM2lESGdvYzlEZnJTWDVhSVRtZnIxemc4dzQ1VG9aRWJLaS8x?=
 =?utf-8?Q?Ua9gaXfM9tlq54RDGoNHAQG4Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bf227c-f984-4026-2a63-08dca05f2093
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 21:36:00.8547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KxiWXsNOp5IpOLwiOtcsZ7LHYN0geuOJUiDV7SK5em7ZMW4zDFoWLaKRzCO+1Lt5umdLKhc1z0xhuaxZV2e4ShesFx1h+h6ose+8yMAyCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com

SGkgQW5kcmV3LA0KDQo+IA0KPiBIZWxsbywNCj4gDQo+IHN5emJvdCBoYXMgdGVzdGVkIHRoZSBw
cm9wb3NlZCBwYXRjaCBhbmQgdGhlIHJlcHJvZHVjZXIgZGlkIG5vdCB0cmlnZ2VyIGFueQ0KPiBp
c3N1ZToNCj4gDQo+IFJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6DQo+IHN5emJvdCtmMWQ3ZmI0Zjk0
NzY0MjQzZDIzZUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IA0KPiBUZXN0ZWQgb246DQo+
IA0KPiBjb21taXQ6ICAgICAgICAgNTgxYTg3YjEgZml4dXAhIG1tL2d1cDogaW50cm9kdWNlIG1l
bWZkX3Bpbl9mb2xpb3MoKSBmLi4NCj4gZ2l0IHRyZWU6ICAgICAgIGh0dHBzOi8vZ2l0bGFiLmZy
ZWVkZXNrdG9wLm9yZy9WaXZlay9kcm0tdGlwLmdpdA0KPiBzeXpib3RfZml4X3JlbW92ZV9pbm9k
ZQ0KDQpIb3cgZG8geW91IHByZWZlciB0byB0YWtlIHRoZSBmb2xsb3dpbmcgc2hvcnQgZml4IGZv
ciB0aGlzIGlzc3VlPw0KDQpjb21taXQgNTgxYTg3YjE5YjM3MzlkYThjMTA3NTBiNDk5YzU1MDYy
ZWE1NGJmNA0KQXV0aG9yOiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5j
b20+DQpEYXRlOiAgIE1vbiBKdWwgOCAyMzowNDo0OCAyMDI0IC0wNzAwDQoNCiAgICBmaXh1cCEg
bW0vZ3VwOiBpbnRyb2R1Y2UgbWVtZmRfcGluX2ZvbGlvcygpIGZvciBwaW5uaW5nIG1lbWZkIGZv
bGlvcw0KICAgIA0KICAgIFJldHVybiAtRUlOVkFMIGlmIHRoZSBlbmQgb2Zmc2V0IGlzIGdyZWF0
ZXIgdGhhbiB0aGUgc2l6ZSBvZiBtZW1mZC4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBWaXZl
ayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQoNCmRpZmYgLS1naXQgYS9t
bS9ndXAuYyBiL21tL2d1cC5jDQppbmRleCA0M2Y2ZDJmNjg5ZDIuLjU0ZDBkYzM4MzFmYiAxMDA2
NDQNCi0tLSBhL21tL2d1cC5jDQorKysgYi9tbS9ndXAuYw0KQEAgLTM2MzAsNiArMzYzMCw5IEBA
IGxvbmcgbWVtZmRfcGluX2ZvbGlvcyhzdHJ1Y3QgZmlsZSAqbWVtZmQsIGxvZmZfdCBzdGFydCwg
bG9mZl90IGVuZCwNCiAgICAgICAgaWYgKCFzaG1lbV9maWxlKG1lbWZkKSAmJiAhaXNfZmlsZV9o
dWdlcGFnZXMobWVtZmQpKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KIA0KKyAg
ICAgICBpZiAoZW5kID49IGlfc2l6ZV9yZWFkKGZpbGVfaW5vZGUobWVtZmQpKSkNCisgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCisNCiAgICAgICAgaWYgKGlzX2ZpbGVfaHVnZXBhZ2Vz
KG1lbWZkKSkgew0KICAgICAgICAgICAgICAgIGggPSBoc3RhdGVfZmlsZShtZW1mZCk7DQoNClRo
YW5rcywNClZpdmVrDQoNCj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNw
b3QuY29tL3gvbG9nLnR4dD94PTE0NWE4NTM1OTgwMDAwDQo+IGtlcm5lbCBjb25maWc6ICBodHRw
czovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD00MDliNWZjZGYzM2I3NTU1DQo+
IGRhc2hib2FyZCBsaW5rOg0KPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0
aWQ9ZjFkN2ZiNGY5NDc2NDI0M2QyM2UNCj4gY29tcGlsZXI6ICAgICAgIERlYmlhbiBjbGFuZyB2
ZXJzaW9uIDE1LjAuNiwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikNCj4gMi40MA0K
PiANCj4gTm90ZTogbm8gcGF0Y2hlcyB3ZXJlIGFwcGxpZWQuDQo+IE5vdGU6IHRlc3RpbmcgaXMg
ZG9uZSBieSBhIHJvYm90IGFuZCBpcyBiZXN0LWVmZm9ydCBvbmx5Lg0KDQo=

