Return-Path: <linux-fsdevel+bounces-50509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DACACCCC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE3188AB4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D37288C21;
	Tue,  3 Jun 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c9Q/xWjj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IMX49P0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6324BD03;
	Tue,  3 Jun 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974801; cv=fail; b=r1cZ8jMmp28Kt/IRZ6uiXaJ8s0tz5GqbEnhGEFK1Wn45HLBXk85yWpPjf9Qs0rpNS3umwLn7yc+8F/J6CU6KOfVXfCp18mWTUU+sVMezNhKl4LlHYpwzfLaXCe6iz7NDu5gYmGCwoePZGH0Y3cl63h8XGlTSCBsQvYH8+CxXzdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974801; c=relaxed/simple;
	bh=JZVrwwK/spjKvBY8NumLDJ6TUNc4MxmI5aJy/Bi1yTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBLehqhIYBmO2ZhHyJHC/BqGNva8TtdQj3FcgAWDr8pB/EKiIKZPvF8iuYuSaVftEgHYwXhZX958VdWa5Qu+8PeC27PFOld2gxZPQQyh5p5vT7daKE+V8rpj+St6j8OzgWQ7enUS70Yn3bogEVA/uCHAd3oNFBJIqqWdjICRRSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c9Q/xWjj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IMX49P0B; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748974799; x=1780510799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JZVrwwK/spjKvBY8NumLDJ6TUNc4MxmI5aJy/Bi1yTw=;
  b=c9Q/xWjjpamRc5gUZvIMtUQ+6fMpxjrwqSmUgm71zydXp+LOiypJwv1h
   BwSakqMkIVAjSahI0t/0J9dKYTpxSLwom/XpyxI1tD2qMdn8hyK8TTEF/
   q2UAO2r6lkJhwRlR2qEOLFbX93xOstpdSKzyNnI5i7hpNzTf5+NvK+dy3
   AA40vmO2+iWRfUhkFU+mWSOujgfxsc4HlgEPZyCpM1UxTFSRssk2q0rAX
   LrBgrjCY2NEyHL8fFc2qKmgbIev10V9KmRHa1M1ihmtisSwzf5GKYf1HC
   sEhymdek36qPzouVeXZ1e9j2SF08yAqzWxW/9wvuNN9LKvTTurWhOyktd
   w==;
X-CSE-ConnectionGUID: acQY7mZUSkSNnuraMe0SJg==
X-CSE-MsgGUID: JRuII/MkQNGaA987lNL75w==
X-IronPort-AV: E=Sophos;i="6.16,206,1744041600"; 
   d="scan'208";a="88855884"
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.63])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2025 02:19:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOdWIxvFp3cmSNWr0YW+kyYluq93bm47fzX4fWxWGwq79Spqluwn7CmaeIS5XfFY8ANn0J22SoRgKZh0POPIEhOMpW+qWHIbDuqeWaWDGQ8nmx20yDy3dcOHkVPqlgXE7mYMu/mRdQgHi67gYt4JFYys0xIS2pptGiz/bpSN9MecivpYC4lAJ4EWGWBxF4nMsVZTo5yc6jpuZ8AOMBzUM3S2LGOK7OvYBOdWTNU0Ei89ucUyNWt+pZ0CR6/WNXXAz3lXT6G0+NrhI5GYGMWMC4+lW6uWHEPcjc9XsZsqIDvvkok1y2ly68ZmMKKWConHz6XnO7ORtuV/+Pfe0v9sFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZVrwwK/spjKvBY8NumLDJ6TUNc4MxmI5aJy/Bi1yTw=;
 b=J3AAI20GmxBCMk5LBQl9J2gkSX4q+JBvHQIIxFqeG1B6qXoM1MdsdHAOFm9cIt7EG4SqZLnhgpRCPU2FeNMBHohJkqI0zHDjrN0ah4oJ1GwfSRixzaZBgqI8/ogXz8FM3QCE7Ss8hCS84Fuxb/8NzHVGeP26L02Ft3h+SH74Yarf83W8V/n6pwgRHaaUKQZ5yMyn6zLDVPMAryfxEHnrCfX3TFvKoZWBbcWyJNni81w4LSBfp4mFWnEUwgkSjn2DW+n1m0rf+ahewZr8y4necJ5DqNV9ritzYC7ajDmnFl2Ry91RvWiaGIeCymbqZA08IK0Uaqokm3H/pIC0u0S0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZVrwwK/spjKvBY8NumLDJ6TUNc4MxmI5aJy/Bi1yTw=;
 b=IMX49P0BsfOys+fSFCOxXLuHfXY5yJoNv5OlkNkF9VE47uRF6u4/sgohQs29DFEOGfRoGK75o1A/XPxHVAvNg6c5Zu/t+vO8mKGoXSkFgimXz23ltPkF3O1IyGwCEvCUggNjxjI51QsScCVDoepcigXQ5MS1WFxPZUpEfWqIk7s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 18:19:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 18:19:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "hch@infradead.org" <hch@infradead.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
Subject: Re: RWF_DONTCACHE documentation
Thread-Topic: RWF_DONTCACHE documentation
Thread-Index: AQHb09FaZau+RveTXkWNxr5C2v6R5rPwBFiAgADzIgCAAHKZgIAAVnUA
Date: Tue, 3 Jun 2025 18:19:46 +0000
Message-ID: <6a4885bd-7e17-40b7-9e9e-7750184a7bd5@wdc.com>
References: <aD28onWyzS-HgNcB@infradead.org>
 <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
 <12bb8614-a3e1-474e-914c-c06171f0a35e@wdc.com>
 <24b9b367-d2ef-4eb5-ad56-f43ab624dd14@kernel.dk>
In-Reply-To: <24b9b367-d2ef-4eb5-ad56-f43ab624dd14@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6550:EE_
x-ms-office365-filtering-correlation-id: b4c82b3f-5de9-4186-4056-08dda2cb38a6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2dvK1lBQjI1WElKSmVQTTdVZ284dU4vVWtDYjlSZm90a0JYclhlZHpnczlC?=
 =?utf-8?B?NEt2VXNZaWZlTUUzMU9SenNscnNtekxKNzVyKytEUmZXd2kxL0Q2VXBvMzhj?=
 =?utf-8?B?NU83VUdaOFhEVHplSnFBRnY2cWp1cjBkMHY0NW42MXpLMFl4UVVIaXlYNzVJ?=
 =?utf-8?B?NkhRVnhZTWxweDJJd011UmpMbkl6OWhpY3N4cWtSVUFZU1FTTW1uWEVQMzV6?=
 =?utf-8?B?anFqaWlmSlkrYVNrSEJZOUh2R3BPbHVxYTVuVkVPTEFpbWRZNitGQ3A0TXho?=
 =?utf-8?B?UkF6RGdoOUs0a1BiRVRIRXhSNmUyazF0bTY4U29jUXR3VXA2cGYvSDhHM2FI?=
 =?utf-8?B?WkhXT21JdWpmNDBOTHRqcGJFVGdQVGJvNnJMRDVpYUVBODBUSzkyVzdKZjhH?=
 =?utf-8?B?ZlgvVzRUK3UwMlZIV2tKOEpxTE9pc2ZESmlnZ3JZZFRLQjNCZzFsLzlCTTBq?=
 =?utf-8?B?ZTVBQnRFRitWY2M4cU91ZXdQV0xYR25velpTT05wa2tpMW1mSUtyeFNjQjVL?=
 =?utf-8?B?TGVXdXVkSmwzMlEwdmlHclNsZEI4UUZFNjhWWnp2K2FIT0N6ZXhMZkMyWmcr?=
 =?utf-8?B?NCtjSzc5OFdjNm9xa1VkcWMwTCtqbGhZdmxYTUVmNG1DbE5DNWlMakN3Vlgz?=
 =?utf-8?B?S2ZydTA2WktqUm1GdmJKZWxjYWZ5QXZLenJHczJnZDI0SzFnRnhIdmM5QzlU?=
 =?utf-8?B?QUw3WStEZDdIajVRMy9lZWI1VEJLUDJGcTdrU1FIem10UXdJaVBYT1dzQWxk?=
 =?utf-8?B?aUN0d3JlY3ppTXVvc0ZGM0hUbXlPbnRhODFRbCsrSWt1ZHJtaTVwdW5sYmY5?=
 =?utf-8?B?TzREemtvdGJaUC9RMnlnRDlBdXF2bEVCNnI4MFJoc21IaW13YWJHaCtCUTd1?=
 =?utf-8?B?MGxoQ3JOMnZzSHc2L3JYOTd3R2hMQTJ1SzJYL1Vxc1lxVyt0dTZQZlpWbFZS?=
 =?utf-8?B?NmZjei9jZ1BqNUVLYjdIbHBEUTNoQlJaUXplNEpHR1c0aVlPV2kxZFRFQ2Zl?=
 =?utf-8?B?NnRySUxOSk5JYUYxeTZuK09ycktwZ25iS0c3bHRSMUlqN0gwTkhjU054b1Zh?=
 =?utf-8?B?UUpjUzRkOXlaN1ZvMHNTcGFFTnNhQzhPeFFNNG9hZVZXanNlejNwZC9hNEtZ?=
 =?utf-8?B?UjJ2NmRHYklIZmRmNVRXL3YrUXIwSHU1ZjY0M1Rvd1J2VlFFMGU2bkg2c2Qy?=
 =?utf-8?B?R0ZaUWRQUnQ4UHdhQ1hEMGdYRnY1eTc2MkpESmU3Z210Zm9FUHJ1RHhYMnRx?=
 =?utf-8?B?YzlKQjZjZXZodFd6NEFSNXBBVXc4UU1GdXAyYVdRb1ZNK2pMZGY4cGJKV1Nn?=
 =?utf-8?B?QUsrQUNpSEg2ZnNNdTVUZ0FzTVoweGN0UWo2Zy8ydStkeHBDcklDbXI4K3Vh?=
 =?utf-8?B?ZThVV0Jvc1BabnNMRW5xc2pZNmYreXRndlJqTUkwbTM4cjFXM0lKVlNBQU50?=
 =?utf-8?B?c1hWY0U1ZkxzMFdGd0pVR3J2Q2tKUUc0Sm9WTDZ2dWYxbGRJNExEdkg1RVN4?=
 =?utf-8?B?c0JNTFlSSkFQcW9YTE9uWGExNmQ5ZXNTRFpaQW5JdFl6V2E1UTl4QUdWdWVP?=
 =?utf-8?B?bDJ6SDRmK3R4a25KNVNUc1hPeURxNGVwZWJ6NGhUa05NOHdEWnZkekhxQkdY?=
 =?utf-8?B?eE55Y3JGVFBPWldiczdWbEMzSVN0YW5Mc0pLSjJqcEJRYzVvbndvMVFuQVlu?=
 =?utf-8?B?UGJjUm1wcndaNkYzV1hWUk5UdkFudXBNemFGai9ad0FRTXZXMURnNEp1V2FG?=
 =?utf-8?B?VTlZNzVWcGhPbW9vUkp6OFBwcDNQWjFjOVlHUndsY1JxaGluNHVIL0VQN0px?=
 =?utf-8?B?emwxdjAxWU9uQUhobVBYdmphcDlhT2F5SEtveVBkS0Z5cjl5T05zMjdmVUFE?=
 =?utf-8?B?M3ltcDFzODd2SnRrcWcvb0lMNmRqUTNVZ0pCVURWU0h2ZTc5ZGU5cVo5MXJU?=
 =?utf-8?Q?WA1V8JBH4P4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjdvNm5IbUQvellCVmU0bXNrK1FXYm9zREN5blk3eUliQlBUOTFRWXArM0JV?=
 =?utf-8?B?K2NqZFhZMVlSTUsrcFN0Y0FPbUxzeSt4YWZWcmVtN1JyT29GYUZid20xQStm?=
 =?utf-8?B?TjkvN1FhUHU0SlVKc2VYcWJSUkp0bVozOUhKbTJMSnBIRVg2ZFZ6aWxPM0FQ?=
 =?utf-8?B?cDVUV0tkekRYUkVvUFk0Mzdkdm55ZmVlWExXYTc1WXB6cHk5eS9ybXJiU0N3?=
 =?utf-8?B?YmFYbzBVbFVNR012NXY5OWw5d3JwMXpVTGt1NTBzL3dlM29ibjlJMzRhSis3?=
 =?utf-8?B?M2M2b3hGUVc1bWRXTGlNQ1ozRlRFeXlIWW9va2U4Wk9vSmJ1aHhKWnlud2VP?=
 =?utf-8?B?L3UxRmZzZ1hqODlzenUyM3hXc0tSWmg1M3RtZkdvUkcxMm9Td3QxaVlRcjFY?=
 =?utf-8?B?OGlnUUNXRVVhc0dNMEtEMjBhRmFqWWZaK0U1b2VZTHhLSmpUTHFSWWdXZzV6?=
 =?utf-8?B?MndvSjZFbE1ua1dpWlRtY0V3SDFPMExpRTlSVGdDcjJaeXM3TWN0S1NqbFRB?=
 =?utf-8?B?WS84eFFQQnpwZWhVWGdHS0k0N29HckFiVnJKTGc0OWJDT25TbU1wbXQyQVZG?=
 =?utf-8?B?alRIeUFoQllGbFgxeFUvczZtNGRvSjFMak1lNGZ1V0Zjd3NSRGdlNUxYdmNU?=
 =?utf-8?B?MVhJd3F2R3BjeXk2QjlIU2ZlaW12TUxXNENFVExGOEFUMHJKSDMveUxtRGtK?=
 =?utf-8?B?TERxOUpHN2JRV1pwa2RPMWwxZGdlVXNWQSs5YjhDV3hGcEJWZnZKOStRdEsr?=
 =?utf-8?B?SFVJdzdpSExxanBpc1J3VDl1VTF0aXYzdGZzL3BrOGJ4ckRpUHFpWGQrTGxC?=
 =?utf-8?B?WmZqTlh2SGJWQmJGanUyckZtNGJ6Z21PMHV0SE5RVTRaM0pjbnV1YjFTWkF3?=
 =?utf-8?B?VC8zaW9WUE1yRGpzb0pPbzhTVzlpa1JZM2xRRUNJTUJWdFJNUHdsYnFEa0lR?=
 =?utf-8?B?U2VvcHFrODlySTVzVzhJOG9CMlV6OTdpUW1VTkVDS0l3a29EWXE5MnZoRm9N?=
 =?utf-8?B?WitKRXliajRJbVBOS2xKMURTYkhFdEswVHg5NVd1TkEwWE5MTDViV1pEUVlX?=
 =?utf-8?B?REQ3ZE1xOGNlc1Q5R3lNVG5yRjQzZ3JRRTN4RlVSR1dNSUhoZDB0RTZSSGVN?=
 =?utf-8?B?Qmc1aFFPWVpyVm9xU3gvWmt6YjJTTU9mM01MUDA1eEZnYUU0TEZjOVRRVjEx?=
 =?utf-8?B?U2hlOEFEQ1ZIZi9iWHZjL1lrZ1lhYUN6ZGpxTTVaa0NJMVVXaFNKVnI0eFMv?=
 =?utf-8?B?L3NFYUZTNmxJdi9NcmVOWlNTV21ydHVMUksyRi8zNDRPRFViT1crTytVWGhy?=
 =?utf-8?B?RStOR0Rxb3RXTDB6aUYySXhva1NGWFptVnlNVDNsb0c1Uk5qN3pBK0g3MUVi?=
 =?utf-8?B?WjhxTWkvcEFqQyttOVJ2Z1RaM1JUL1h2TzJKejA1U01pSTdCc2hlYWFNOGx6?=
 =?utf-8?B?Nzc2RnMxY1lpbTEvRzVrRWxDcmpxbHB1TTN3Nlh5bDlZSjljeWpwS0M4TldH?=
 =?utf-8?B?OHpCWk9ZTUV3Z3RSNHF4VjBIaGJBWUpQeHNHZzBrM2k5ZmFlQ2tRRjZxYlFT?=
 =?utf-8?B?YXBDQzNUQlhCcUwvSFhuZVpmSHdka2JaNDBVRnVHajhKVzFURmtZY3VCOGJ1?=
 =?utf-8?B?QnpxK3NUdkVobG5lazU0TVNQbUNyU3lEUmlqdElPUE4rZHo3ZlhOSFlFWTVT?=
 =?utf-8?B?MWF6ejkxRmptc3l2RVRkT2JrUjdwTkE5UFhwTDRxK05oSngzNnZQOEhMYjZR?=
 =?utf-8?B?MWp0OWNudHhEM0hab0dFOHhxSlJSbVlic0tkcXE4dTVVd0g5Wlg2ODUxYkhJ?=
 =?utf-8?B?d3JkOTdSMnp3U3k2Z05qVi9xdmhLeWxlcGJLM2p4RWh0L2VwMHF6OTZIMDhx?=
 =?utf-8?B?OEdCQmM1b3lST0FjbTIwU1NySXVWVnlIVEU1anhXKzhibWFBRlB3akhIcEJK?=
 =?utf-8?B?aHFlVHpGYXB3RjU0SnZ4bHY4bkJ3Z096YVFBVEJRK3UyNUR5M1BuOURHVFB6?=
 =?utf-8?B?OGdseU43NmdVcnJMcWt4UG5nQlNMcTlQbzN3TE1NZ05xWUlpdWV6dkdUTlJ2?=
 =?utf-8?B?cXlOK1E2WENYWnk2UUFISDAxSTQ1dmhsS3IzQ0dBTW1RZ0dKOU5jZmZuMVVo?=
 =?utf-8?B?NU5aU3RnMVNOWm52QTJlKzZmODhmY1dnQmZ4cU1ha0xmWTRtU3JHUnlGMitB?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94F22E8D61F89C459859B4FD3450D5D0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0sG063JXqFVTHO8BVwvAwsMZ3Z/kVzQIenCZXuJQGpufVM/QHO8ES56hG35PWVz0eAkPEjQxNvSjDcCwgR9G23QYWxZ7Ct5z7LVfC4Wlc6p4BEciwcRAwl/8FUXjdyiWUd2YhpNlVq9ps8YMza5zrnpTjKbR4fRhjSP9YhulcmJPK1t/jGSbbI39zoDsdRGuFK3DK2mIfny6Jl99kgnRfp871ZfQ8P4t5hnY4fyYODW5xGFPSkTaUFoycf1y1w8kHRYfSm/md2/c+5X4kBhbFemj91AP63EC4uued5SZ2zJPQoG50u5yOAst4mb6JPQ9hrh7WqLoG0XnHnc1jwWQngb1p+D+S2s8T9p3tKKt2bYAB03osQIKKR8VL3LuoFtFTv/bTteAVsaKgm0EOqhmm66pK1yXMWobbbZbpK7BawiA74O8NEQ/nWOEgKjMdVfvCLIhFidV8VGzm2AKsRn9eL0aZzL0YhIC28rsuaR12ZwJeiDO1MCoO/ezxhOooe2kCHrwyf3f2s3enkLv+uqaiX+gAFBbuXIZYz+f/g3KzbitlRUmJOrOcH9BryO6Cx7rw6SR3c2qndTy9yrtylxHhTGHdK68/mr4/DpSdJ1o2vhLSIRqp8gz2Y6D9ZGgDA/+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c82b3f-5de9-4186-4056-08dda2cb38a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 18:19:46.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DSY+9PyTUfd5UKKbfBk4WhRpEIIqjwxcG961M9LI/IWg5RJ5sde1FwUZOQktUM2bnblfuxsOT4fOq3HzwCg9NqMpqhWp/2RoCbIACPIn8xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550

T24gMDMuMDYuMjUgMTU6MTAsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDYvMy8yNSAxMjoyMCBB
TSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMDIuMDYuMjUgMTc6NTMsIEplbnMg
QXhib2Ugd3JvdGU6DQo+Pj4gT24gNi8yLzI1IDk6MDAgQU0sIENocmlzdG9waCBIZWxsd2lnIHdy
b3RlOg0KPj4+PiBIaSBKZW5zLA0KPj4+Pg0KPj4+PiBJIGp1c3QgdHJpZWQgdG8gcmVmZXJlbmNl
IFJXRl9ET05UQ0FDSEUgc2VtYW50aWNzIGluIGEgc3RhbmRhcmRzDQo+Pj4+IGRpc2N1c3Npb24s
IGJ1dCBpdCBkb2Vzbid0IHNlZW0gdG8gYmUgZG9jdW1lbnRlZCBpbiB0aGUgbWFuIHBhZ2VzDQo+
Pj4+IG9yIGluIGZhY3QgYW55d2hlcmUgZWxzZSBJIGNvdWxkIGVhc2lseSBmaW5kLiAgQ291bGQg
eW91IHBsZWFzZSB3cml0ZQ0KPj4+PiB1cCB0aGUgc2VtYW50aWNzIGZvciB0aGUgcHJlYWR2Mi9w
d3JpdGV2MiBtYW4gcGFnZT8NCj4+Pg0KPj4+IFN1cmUsIEkgY2FuIHdyaXRlIHVwIHNvbWV0aGlu
ZyBmb3IgdGhlIG1hbiBwYWdlLg0KPj4+DQo+Pg0KPj4gSGkgSmVucywNCj4+DQo+PiBTbWFsbCBz
aWRldHJhY2sgaGVyZS4gV2hhdCBoYXBwZW5lZCB0byB0aGUgZXh0NCBhbmQgYnRyZnMgc3VwcG9y
dCBvZg0KPj4gUldGX0RPTlRDQUNIRT8gSSByZW1lbWJlciBzZWVpbmcgeW91ciBzZXJpZXMgaGF2
aW5nIGV4dDQgYW5kIGJ0cmZzDQo+PiBzdXBwb3J0IGFzIHdlbGwgYnV0IGluIGN1cnJlbnQgbWFz
dGVyIG9ubHkgeGZzIGlzIHNldHRpbmcgRk9QX0RPTlRDQUNIRS4NCj4gDQo+IFRoZSBidHJmcyBz
dXBwb3J0IGdvdCBxdWV1ZWQgdXAsIHRoYXQncyBhbGwgSSBrbm93IG9uIHRoYXQgZnJvbnQuIEZv
cg0KPiBleHQ0LCBpdCBuZWVkZWQgYSBiaXQgb2YgYSBoYWNrIFsxXSBhbmQgdGhlcmUgd2FzIHNv
bWUgY2hhdHRlciBvbg0KPiBjb252ZXJ0aW5nIHRoZSB3cml0ZSBzaWRlIHRvIGlvbWFwLCB3aGlj
aCB3b3VsZCBlbGltaW5hdGUgdGhlIG5lZWQgZm9yDQo+IHRoYXQgaGFjay4gVGhlIGxhc3QgZnMg
cGF0Y2hlcyBJIGhhZCBvbiB0b3Agb2YgdGhlIGNvcmUgYml0cyB3YXM6DQo+IA0KPiBodHRwczov
L2dpdC5rZXJuZWwuZGsvY2dpdC9saW51eC9sb2cvP2g9YnVmZmVyZWQtdW5jYWNoZWQtZnMuMTEN
Cj4gDQo+IGluIGNhc2UgeW91IG9yIHNvbWVvbmUgZWxzZSB3YW50cyB0byBwdXJzdWUgdGhvc2Ug
cGFydHMuDQo+IA0KPiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLmRrL2NnaXQvbGludXgvY29tbWl0
Lz9oPWJ1ZmZlcmVkLXVuY2FjaGVkLWZzLjExJmlkPTkyZGYwZWYzMDhkMGJmYmJjMjZhN2VmYTFk
NTcxYTUwNmZkOGZlZTMNCj4gDQoNClRoYW5rcw0K

