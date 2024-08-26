Return-Path: <linux-fsdevel+bounces-27186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A199E95F45E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227381F22AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DF18E057;
	Mon, 26 Aug 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aFyPskHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2109.outbound.protection.outlook.com [40.107.243.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCF1885AB;
	Mon, 26 Aug 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683836; cv=fail; b=IDmbo4ruvlmu735qK4S18inZfhpQVhnLFFzvV08OgJxnB65qQVAQ5gkbfBJzqyEQDAUW0YhNsycAGrA0w1LhVtfNTrnZwVjiTS/e0VOi2avCzW/Rfxun5Ht/oIgaBRmKHpJku8Ou6SWxovExmtjcvYJH3AmkFIndJQvcI4dGB/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683836; c=relaxed/simple;
	bh=A71JUluCVxG5/UeBa2qpbk6FAWpbVrRSFRcF8SJd7RY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EzHx114QYoODRHU9ZRTHSQMivM0ss4ZNSmgU2TALbdnaFWNMurVQziflUrBoRpb4fOQV/oypfU+q2sQH4eKiNOx0xwOxws4J5JQIOpjBCBIOkgz6fRYcfuuPt1nf7a7g0OqFN5DENP1fxaUL6Ec7ELbU6uVa8bHpobEDAlLm/84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aFyPskHV; arc=fail smtp.client-ip=40.107.243.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euFNHAu8vbnEfJP5wbtAZx4JfSkW24M/hAP6B0RnMvdTFJd/TN3Ph6iqwqO1czlRyliUvQsjEFidQiVKe6NsYB0mKqrhRahR/MpPp0lO46qQCqKDsemWcDNrxsidYDVi8vpE3RQKKZk8MrQeyJohQ5yuAOnqVtn0c+wgmEpG0RvT/+A/IZpfbboBqXOLS/cBv2HPnRQAh7otnxuaR6YSj/aAooybQrVikpMc8xUYY7AmeZ1AlKLodAcGQHKvAA9KAUByxBrlNS6OPFqS/0oJh/sxEbgLVLtgUyWL1AqK2wkkvO758ppicI20aMj4c5jv5Ec+F4FbznHpGlKEbyCIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A71JUluCVxG5/UeBa2qpbk6FAWpbVrRSFRcF8SJd7RY=;
 b=R8xcN4oZiX2RnKR/pAT2D3kD2QzJEZdN+3DZ5y8+80oztm2pyW8Mcs2eKGoe3ErN9OkzKJK5mpWuZgeKYtRAXUlsGi0+n4JXs/Qtg6iUHHIGD7TCT0+/q7w/VfdusfXnIsAYOdAIWzQCPhNghTM4vJq7EhXeLFIFL3HQXB8vKzktnruWskTHrk93c0nVh+aoDV+um6N6eXEDwH8/cVM2BsL4dTN3tljGAGqGuPULis2y+Bx1H004siPP93BF6vNThhqP7VdEB4FIokzMRxhtikfXdulbzDt8L6fzEthzyICpZDa3rD7IDP6+DIps12bFuj2srE1/MKOb2GmqFbHnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A71JUluCVxG5/UeBa2qpbk6FAWpbVrRSFRcF8SJd7RY=;
 b=aFyPskHVtQqftQtzp+M/T2LBZvRYn6gy1XxNZOgH8vY4gsnmBjy5mFi0vBXb2uRx/JCoDWLUjH/F6TPP295tQB0RFydwZ9J0cHnus/e/VZVHaOtOmnAWgawalw+GvNVZiIaQFeMeAk7uB+sw0U+3k3BcMwKqPDs55uQEJK9P3y0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5873.namprd13.prod.outlook.com (2603:10b6:510:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 14:50:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 14:50:29 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "anna@kernel.org" <anna@kernel.org>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Topic: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Thread-Index: AQHa9YhbSZns7TD6R0iwTEu+CeGCcLI4y2iAgADOoQCAAAl5gA==
Date: Mon, 26 Aug 2024 14:50:28 +0000
Message-ID: <85bc01d0e200ead4c20560db1ecb731f7800e918.camel@hammerspace.com>
References: <20240823181423.20458-1-snitzer@kernel.org>
	 <20240823181423.20458-20-snitzer@kernel.org>
	 <172463741946.6062.16725179742232522344@noble.neil.brown.name>
	 <CC1D59C1-DFF3-4608-B2FA-29D4D9297D19@oracle.com>
In-Reply-To: <CC1D59C1-DFF3-4608-B2FA-29D4D9297D19@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5873:EE_
x-ms-office365-filtering-correlation-id: 3301b9ae-9792-4f42-e885-08dcc5de6d6e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WmtpWXhhSDZnajNWL0x0SzYvWExHVllwYWJyU2lYOFg5czFrYWEzaGlEejlH?=
 =?utf-8?B?VUgxM2hqaUZFcjBsekZPOVkxMUxuKzM0VGx2c0lVVElYT0QwN1Bmek0xbENv?=
 =?utf-8?B?anBoakh5VGQ5aEF4STBmSVlpTUR3ZFJ2MG5BOVBSV1dXVXcxMDBmVlZyVXVH?=
 =?utf-8?B?T0ZWUmVFK2MycGVpTDJ3V3RQd0IxajhENEM4bW11TEN0ZUlLSEFvaDMxRnFp?=
 =?utf-8?B?WTBsai9iUDRlV2pPdHhHRFVXcWl4VGM5UjcvSTFlQnMwczBjUDJqTUV5U0p5?=
 =?utf-8?B?OGp3cnJheFFQYktKMUpEYUhHSFJKWUJzWU5xODhpdE5sZXZ3K1hFUDRubkpj?=
 =?utf-8?B?anpDb20vMVNVaUFRUUlMMUU1eVVHZGp1RS84eC9uY2xzZVk3V2FIUkdSY2lB?=
 =?utf-8?B?UlhWMGw4NUNxVnhYN3lMZWVNR3lHWThNR2dZMzdYMlZCRUtyWkF0YktUejVL?=
 =?utf-8?B?eXpjcU15Tk9ya0dLclh0K2F5YU5rclJ5UTQzVzRmRU5sTFg5RVh5TmRPZHFo?=
 =?utf-8?B?UEZpUVlZTDhDMyt3c3RlaWhaVmJ2aU1vc0ppR1h3SmEyVThXL3g3Q2xWZnZD?=
 =?utf-8?B?d2pOalY5RTVEVXE4cjdNZUs3RSs3WER1RlNqZE9ibU4wSTRkZmtEVTlwcTlp?=
 =?utf-8?B?VTU5cEo4eXVyR0MvTm8xUjhpSHMvQkRUSVloTTVpdlpNNG1OellsWGl6dmtp?=
 =?utf-8?B?MVp2Q3lMUnlLVEd6ZEMzcHhsWHpUL1JGeWlPTGxDdHJZL1Y3TGRlZUVURmVJ?=
 =?utf-8?B?WCtUZllKd3ZRN0dBWGx2c1BBQXl2WEFsTVVpL0lxcFJNL2ozRDE3QkJWYUpQ?=
 =?utf-8?B?am1jM2M1L1lPNFpMMm1qUWFBTUdRbENReUxwT0FXdGxUVlBiZ3RBSldCakt5?=
 =?utf-8?B?S1hBY29QQ1JYRUhYRE5IVU9pdUE4b2NPa0RValhsYkxCQ08rNXNXNVFWU05Q?=
 =?utf-8?B?TDVhRFpsVUNyV1JsUEc2S3hVSkw4S2x5dnRhZkZLSGV0UkZ0L3BvQURWdWN3?=
 =?utf-8?B?NmFkdlV6Ukx1OHhyeW5xbTV4a0hBSnR4WGt1dWozTU9vZitkQWhOTkE3WlJ3?=
 =?utf-8?B?ZU9YQlB4elhyUHAwc2Y3TWt6UndjdVJqSnluRjZDMUMrdkgwNy95ME9ZWjRN?=
 =?utf-8?B?SXFmVDNMbTFCOFo0V3FBMXEyeDZqT0RVL3FyOGRMUisybi9JNFZOenRDVm9P?=
 =?utf-8?B?WlRZdjc3KzNnalVObUxUdVRuQXdsTmVlN1dldkVnY3VkSjd3Rk45c0tybEsw?=
 =?utf-8?B?bk91UG80UVB3bXR0R3JMSXdzeGVLaXVPL04rMzlrOHQ2RjBkZ3JBeDJuc0or?=
 =?utf-8?B?WTJRdFp3TlQ0ZlRPVHU3ZWFhcnpMcVpzSGhYdEZsUUZ0MUpwZDlDKzB2Ukln?=
 =?utf-8?B?OE83MXV3TjRuM21HRFRtR05WVE1LaGh1ZXNLbFlOTHFlTHAzR0VtM3R0KzJ5?=
 =?utf-8?B?TTFpdXFIYzhWRENIZmNGemY1d1h1T2dmN0ZLS3p0anZnU1VHSzFiWFA5Uy83?=
 =?utf-8?B?eHdpd1FZYkJuZVcyUkpOUUNsczkzVUFwWmNZaXB2Uk11UituOSs1L2lkamV2?=
 =?utf-8?B?Wmx2WGNNTDh5VzE1N2kxSEx2VFdoREcrTVE0dDVtaFRsVzk4Y2FGVk95NkZI?=
 =?utf-8?B?ZENSUW94dnVuVElaOVJhRll0b0YyUklydHZkK3pPQTluT2hYRkt6T0EwN1JK?=
 =?utf-8?B?UmVuTkpHelVIRVVNMG1OSkhKQ2NIcEROT1NDYUJaYmJqT0JYNnQrdi8zN291?=
 =?utf-8?B?dzRTa2tBbURkM3dmVEtKdDRhQWdyY2NwckoxUDk5MDk5NjVGZUtQUDdvOWZW?=
 =?utf-8?B?WG5aenpRRTFyZ1FJcEo2NzRFVWp6ZkNMdkNZenBTc2YzYlRvRGQ0MGV1Z2ZB?=
 =?utf-8?B?ZFliTnJZNlZwdHNrYURuS1lXYjdoRlFSb0NPeitRTzNFNGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEgxQjJJdVEvSllpZHE5d01Ib2JhWkdMVGJRZjE0UmtTQ0RGdGZ6U1VwTkU5?=
 =?utf-8?B?WktaNXhDVnZDYk11d1NYdjRpMFVxWjJGVUN2bXY1MXdhZ0p1OVVJUGdpbzZ1?=
 =?utf-8?B?dWJtYlpCYWs3R0dZUjg2VGdVaGdleHh5YjFxK01vWDV6OWhEY09BYVV3SE5P?=
 =?utf-8?B?QTEva2xRalJ3cUttM2RQOWRsMlp4cEc2Qy84dmZKSStYS0NBK0g0a2hEaGtu?=
 =?utf-8?B?dU9sOElOazYwNVFXQW5TL0RqK2QxYkluYXZKaE1leWY0T001RHlCRyt5RE1E?=
 =?utf-8?B?QjQ4OFpadE45Q2RvYlVVWXlUcG12dEtnKzBUc1hkQzhWOTF2MVBxK0pDbFU4?=
 =?utf-8?B?bEJHZXROWFdMRWh5U2grQmg3L0dHWGg5RzM2SDhCamJTRUVjMFlvS0JrQ0Vx?=
 =?utf-8?B?bXd1S3F1bGFYOGdhY0ZrZWt3SlVGSTFwSXQvVXlqVW5Pc2NVbkQ5NEFsNzc5?=
 =?utf-8?B?QXU3aWVEQ2RJbDVQZ3NvVjRpRUVkOXBham1FNUE2ZCtPeUNwRDJ1YStTdTND?=
 =?utf-8?B?bU0rSXdheFFMeDNHY2dhOElIUUVnVVNHR1pzK1FSM2xzYXo2ckIwdnc2Tk55?=
 =?utf-8?B?OVlqWllFSFdyOFppWkJtaWIxU1kzNVUxN1NjWEphSjBCS01ZZlQxKy9UOHVU?=
 =?utf-8?B?QWlsczNBSnRRVjh0alVKRDZ0RGg0TGsvUFIrVVc4ZXJoNks3OGc1cFhKVDZO?=
 =?utf-8?B?Q2l5ZkhxN2FDS2IrZXF5UjJaUFNHT3JNK2Q1a2JldlNleUhTdmVtZFl4SlUw?=
 =?utf-8?B?WVF3SnJQcVFWc0x4dHlVd0FCeEVEemYrNXF5c2NnTFUvc1dyZEF5OXd5aXFX?=
 =?utf-8?B?aHN1dDVPMHVEZHpzaHJoRlVBV2Vqa2RiT2tNU3Q4VVM3WGRsRWY2NDBtZEkr?=
 =?utf-8?B?aUpyVGF5K21EWHhoOHhEUzk3elB1bFRzQm9ESUtCWHVNRVQ0RWJHUWJZOXdy?=
 =?utf-8?B?UG9MeXJyRUcrNXhhUTZQV2JsQjBxT01EajFCZmkvcnUrWE9CbHNYMEZXaTF6?=
 =?utf-8?B?NFRPQlAwNTJzZmlDN3VNQjI5cUo0WmxUa1N1ZmV0MVJnZ3RITGY4VVNXYXh6?=
 =?utf-8?B?bENnam1adE4zc0piSGRaK2xtY2tTRmQyc2ZHV3pINFhBUTFmNXY2aDZqZis0?=
 =?utf-8?B?UTNGVm1VZXgrZWVDN096aDlBSmxWSm83ZWxJZ1ZieEVkMWQ5eUFLQlllZXYr?=
 =?utf-8?B?N0l4YmNCUTB4Uzl4dXZFZnpFSnc0Q3FUaEQ0VVBzZGVXNTRCdXZqRUNCTDZh?=
 =?utf-8?B?WW1xOEoyQjFMdDdEK2pEb09MeExMeGc2Mmp0YnRGdlQzOVhzQ05uWC9qSDBB?=
 =?utf-8?B?N0F3L2hRR2duZFJtN1JHVkREVVFxWU1uRnNiTGdtWHkyV3lsNzlvNCtxMTda?=
 =?utf-8?B?MmxsS0R2a0s2S2R0aXZIaEVYSEdleTVvVkM0QjBtcVEvSS9FTnZHWTdXSTRx?=
 =?utf-8?B?RTcvUXRVc2JrajFYdU90VmxyblFuTzlVY2x5dTNBYUN1RStTbTRWRUJraVRU?=
 =?utf-8?B?L2lXbWFxenpYZ0tHTTlGeVp6a3Rpb2VtYnpIL0VPemZqQU50VUFpam8rZi9v?=
 =?utf-8?B?TUJRWHlSRDB0NENtOTl1YlRFekhzMWZ6UUN3bHdZVzBHbjlTengyQkYrc08z?=
 =?utf-8?B?R3h0eGNBeDRxUVM2SWlzYU5pUXdabWdUWEFKaUdGY1N4d01naTBVVTVmblBH?=
 =?utf-8?B?d3kxL2syb1JWSW94Qit4VTNrcXpRenZ1TTd6bzZFajBaRGI1SXVvcUpyOUxk?=
 =?utf-8?B?VXRkSm91YWo0ck84VWNVZENkVk5mWkQ1UVhycXJLdm5aeUpKeXdHZmY5ZFRz?=
 =?utf-8?B?MjlQQnZqN3dtRjNTSHFYWGZvMGNTMHo5L0dSRTk2YlUzS3JOTWVUQlczOTJH?=
 =?utf-8?B?U3c5WkJzdnQzMlJUYWhXTDFsUld5UlpwaTB6aWhOY0lIZjQraWpCYVl2NzJa?=
 =?utf-8?B?Sy9Xa2VOSjlPT3VRRWN4ZDFjVHQ2cUhRZ2dOYmpoQUtScEZnaVJRNzJmckla?=
 =?utf-8?B?NVJ5TGJUWmFnanZ2dUEzazdWbDlHUkJQRkJ2eWc0U0FDRXY5OTNDdzEzTE5Y?=
 =?utf-8?B?VTdwbzVlMmFxYVZlTFFvQ0NiUUtFRHdUZG8rSFZGZHFlWHhYL1RiemxqK1Fy?=
 =?utf-8?B?SFFnOWM0eElSb0FVcVJqa1ZJb2ZsblFMaXJnVGUybzY3eE52RVQyNW1VeE1D?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AF976A65D27A841ADA8EAA41143DCDF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3301b9ae-9792-4f42-e885-08dcc5de6d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 14:50:28.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/85YIhAIVCwSL+SPXfxIP8DMGK/wD3iZJWndVJio+2yU6v5ory9MdrjD3qwAGzAkuJeXoqCTLZlVJ0VQoSZ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5873

T24gTW9uLCAyMDI0LTA4LTI2IGF0IDE0OjE2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBBdWcgMjUsIDIwMjQsIGF0IDk6NTbigK9QTSwgTmVpbEJyb3duIDxu
ZWlsYkBzdXNlLmRlPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTYXQsIDI0IEF1ZyAyMDI0LCBNaWtl
IFNuaXR6ZXIgd3JvdGU6DQo+ID4gPiArDQo+ID4gPiArNi4gV2h5IGlzIGhhdmluZyB0aGUgY2xp
ZW50IHBlcmZvcm0gYSBzZXJ2ZXItc2lkZSBmaWxlIE9QRU4sDQo+ID4gPiB3aXRob3V0DQo+ID4g
PiArwqDCoCB1c2luZyBSUEMsIGJlbmVmaWNpYWw/wqAgSXMgdGhlIGJlbmVmaXQgcE5GUyBzcGVj
aWZpYz8NCj4gPiA+ICsNCj4gPiA+ICvCoMKgIEF2b2lkaW5nIHRoZSB1c2Ugb2YgWERSIGFuZCBS
UEMgZm9yIGZpbGUgb3BlbnMgaXMgYmVuZWZpY2lhbA0KPiA+ID4gdG8NCj4gPiA+ICvCoMKgIHBl
cmZvcm1hbmNlIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBwTkZTIGlzIHVzZWQuIEhvd2V2ZXINCj4g
PiA+IGFkZGluZyBhDQo+ID4gPiArwqDCoCByZXF1aXJlbWVudCB0byBnbyBvdmVyIHRoZSB3aXJl
IHRvIGRvIGFuIG9wZW4gYW5kL29yIGNsb3NlDQo+ID4gPiBlbmRzIHVwDQo+ID4gPiArwqDCoCBu
ZWdhdGluZyBhbnkgYmVuZWZpdCBvZiBhdm9pZGluZyB0aGUgd2lyZSBmb3IgZG9pbmcgdGhlIEkv
Tw0KPiA+ID4gaXRzZWxmDQo+ID4gPiArwqDCoCB3aGVuIHdl4oCZcmUgZGVhbGluZyB3aXRoIHNt
YWxsIGZpbGVzLiBUaGVyZSBpcyBubyBiZW5lZml0IHRvDQo+ID4gPiByZXBsYWNpbmcNCj4gPiA+
ICvCoMKgIHRoZSBSRUFEIG9yIFdSSVRFIHdpdGggYSBuZXcgb3BlbiBhbmQvb3IgY2xvc2Ugb3Bl
cmF0aW9uIHRoYXQNCj4gPiA+IHN0aWxsDQo+ID4gPiArwqDCoCBuZWVkcyB0byBnbyBvdmVyIHRo
ZSB3aXJlLg0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhlIGFib3ZlIGlzIGNvcnJlY3QuDQo+
IA0KPiBJIHN0cnVnZ2xlZCB3aXRoIHRoaXMgdGV4dCB0b28uDQo+IA0KPiBJIHRob3VnaHQgdGhl
IHJlYXNvbiB3ZSB3YW50IGEgc2VydmVyLXNpZGUgZmlsZSBPUEVOIGlzIHNvIHRoYXQNCj4gcHJv
cGVyIGFjY2VzcyBhdXRob3JpemF0aW9uLCBzYW1lIGFzIHdvdWxkIGJlIGRvbmUgb24gYSByZW1v
dGUNCj4gYWNjZXNzLCBjYW4gYmUgZG9uZS4NCj4gDQoNCllvdSdyZSBjb25mbGF0aW5nICJzZXJ2
ZXItc2lkZSBmaWxlIG9wZW4iIHdpdGggIm9uIHRoZSB3aXJlIG9wZW4iLiBUaGUNCmNvZGUgZG9l
cyBkbyBhIHNlcnZlciBzaWRlIGZpbGUgb3BlbiwgYW5kIGRvZXMgY2FsbCB1cCB0byBycGMubW91
bnRkIHRvDQphdXRoZW50aWNhdGUgdGhlIGNsaWVudCdzIElQIGFkZHJlc3MgYW5kIGRvbWFpbi4N
Cg0KVGhlIHRleHQgaXMgYmFzaWNhbGx5IHBvaW50aW5nIG91dCB0aGF0IGlmIHlvdSBoYXZlIHRv
IGFkZCBzdGF0ZWZ1bCBvbi0NCnRoZS13aXJlIG9wZXJhdGlvbnMgZm9yIHNtYWxsIGZpbGVzIChl
LmcuIHNpemUgPCAxTUIpLCB0aGVuIHlvdSBtaWdodA0KYXMgd2VsbCBqdXN0IHNlbmQgdGhlIFJF
QUQgb3IgV1JJVEUgaW5zdGVhZC4NCg0KPiANCj4gPiBUaGUgY3VycmVudCBjb2RlIHN0aWxsIGRv
ZXMgYSBub3JtYWwgTkZTdjQgT1BFTiBvciBORlN2MyBHRVRBVFRSDQo+ID4gd2hlbg0KPiA+IHRo
ZW4gY2xpZW50IG9wZW5zIGEgZmlsZS7CoCBPbmx5IHRoZSBSRUFEL1dSSVRFL0NPTU1JVCBvcGVy
YXRpb25zDQo+ID4gYXJlDQo+ID4gYXZvaWRlZC4NCj4gPiANCj4gPiBXaGlsZSBJJ20gbm90IGFk
dm9jYXRpbmcgZm9yIGFuIG92ZXItdGhlLXdpcmUgcmVxdWVzdCB0byBtYXAgYQ0KPiA+IGZpbGVo
YW5kbGUgdG8gYSBzdHJ1Y3QgbmZzZF9maWxlKiwgSSBkb24ndCB0aGluayB5b3UgY2FuDQo+ID4g
Y29udmluY2luZ2x5DQo+ID4gYXJndWUgYWdhaW5zdCBpdCB3aXRob3V0IGNvbmNyZXRlIHBlcmZv
cm1hbmNlIG1lYXN1cmVtZW50cy4NCj4gDQoNCldoYXQgaXMgdGhlIHZhbHVlIG9mIGRvaW5nIGFu
IG9wZW4gb3ZlciB0aGUgd2lyZT8gV2hhdCBhcmUgeW91IHRyeWluZw0KdG8gYWNjb21wbGlzaCB0
aGF0IGNhbid0IGJlIGFjY29tcGxpc2hlZCB3aXRob3V0IGdvaW5nIG92ZXIgdGhlIHdpcmU/DQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

