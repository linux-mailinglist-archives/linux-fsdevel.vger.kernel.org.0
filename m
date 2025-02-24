Return-Path: <linux-fsdevel+bounces-42446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C942A4270A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A515B7A875F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0F261393;
	Mon, 24 Feb 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="V6fGF9mJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2131.outbound.protection.outlook.com [40.107.102.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E305156677;
	Mon, 24 Feb 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412576; cv=fail; b=skQkvmv24xGEmYBgADxI/d2I542DK2f6chY75CnqCwIHIQZt+vHNUmvbfKJ5Don5Er5sHOmKrANTuiuiOfzarIis1+bBA4iFqvwjPEs74MfGW3MmiP/7v2NYuWIs4IsmyrDekzn8NmHUnWfHeS5TGu+CSpSzD0QqyaeMQ678ozw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412576; c=relaxed/simple;
	bh=gVCw9cww/QJyN0LpvwKhFDUlxb5MxyLNqb8Qhtd7udY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9Dou/yD8Nro/g8nJMd8VyIsl0IpM8JluIYeIG9p+rMNyuk7hFih23N2ceNCmNKdaG3GVRA1Up2MoEyBTHGmCdAmF4h0tnHbvxqQHZdgRVg7WzwCABZkRwZmoEJtIpdFath9EdUvkJ9D9Z+n5xUqB3V4jkRLDHK+yw7OKJ8AcVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=V6fGF9mJ; arc=fail smtp.client-ip=40.107.102.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGrzYuMPLeNOOGY/PfQTA3qDNNsPq5Vto0pSWqatPwl7NsXQT4UCK9mDz78aSXS1DdO12t06YUSQsvhmNhKLk7QBNiSQzM7TWQjsrLCP9D1AklcFfgD/WiGOa7grPzzTFnylzNumYZWbUoWz/8CSaxb1KgQzdcBFa84B1MpOvwBZFN+Q9YIA2VAVjZ2DTBjVblWpoBnIsxj9kSLhmezusWSRE8Ag1VJyQJGgSkAz+QnsW6ULKu8PrQOqS1jG2oa/pd1p4f7tlNx2cIsDivXMS0vWL6S4lzjzHm+Jo8k3ZMrTlVVkQF9BAZiGSiR61EkieagBPqSNOWoTHn92bvmDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVCw9cww/QJyN0LpvwKhFDUlxb5MxyLNqb8Qhtd7udY=;
 b=NxA4y77exwrCr1qEaA6yWcnDhoPpnM0dtRRqBd1sBLt1pg8yFhP5KttlWxdshFgJJNXfK4TkMaNoseWAdVAERhcIMt9XXH+552z4UsxWo1Vm4O5BDfp/jPGllY/FjMAUn/0McxeODMzsrrtiUSFUe/+K0m3hMpxYa34jqNnGAD937YBSdseq21zeVlloImKjA8cqIaGm9mtPv8hJHpaf8wlK9KT06k/hGdT5xiju2lwZfxujM/3kwMdCatsutK4BRb+v0YmBy7C6ttsti3vH7DLFCQQC6w6R0ot+GQKK3+4R78WWA0Zx74eefx8wYUBCwrF3zDviTVtInFVZ5sBL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVCw9cww/QJyN0LpvwKhFDUlxb5MxyLNqb8Qhtd7udY=;
 b=V6fGF9mJIwLZdxNMSzp1H2FSBl7A1ku9PkUczuAH92mrZ5x+LyK9D09c3sAztZHfzfSuwQTs0fWhOayLJjy/iFm8KadUldYA2imRgttmIC+opljr7H4AG0SbwXP2j53TK/yXHGQTRB2PIMCo+1nS66SVBLpLx2/kCWJOKV5Jlkw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV3PR13MB6453.namprd13.prod.outlook.com (2603:10b6:408:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 15:56:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:56:05 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "neilb@suse.de" <neilb@suse.de>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
CC: "brauner@kernel.org" <brauner@kernel.org>, "xiubli@redhat.com"
	<xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "anna@kernel.org" <anna@kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, "anton.ivanov@cambridgegreys.com"
	<anton.ivanov@cambridgegreys.com>, "jack@suse.cz" <jack@suse.cz>,
	"tom@talpey.com" <tom@talpey.com>, "richard@nod.at" <richard@nod.at>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry
 *
Thread-Topic: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Thread-Index: AQHbg/HWjnUIOhUrC0KpyLDtBmJdLLNSuhOAgAL2awCAAAnogIAAENUAgADWF4A=
Date: Mon, 24 Feb 2025 15:56:04 +0000
Message-ID: <d4aaba8c09f68d8a8264474ce81b9e818eaa60d7.camel@hammerspace.com>
References: <>, <20250224020933.GV1977892@ZenIV>
	 <174036658872.74271.7972364767583388815@noble.neil.brown.name>
In-Reply-To: <174036658872.74271.7972364767583388815@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV3PR13MB6453:EE_
x-ms-office365-filtering-correlation-id: 400e2095-b7e0-477e-d680-08dd54ebbea1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MU54Rmhhald5WU1KR2xDaG45RnVyQk1welZXR1FIZVFLaHZKU2o1ODJMUGNN?=
 =?utf-8?B?a1lDZ0lucDB6UDhmSTJrN2pna0RUbHc2bjVoTENUSGJJaFFzSFhBajZZWVZl?=
 =?utf-8?B?eUI3SmhvTWpLRFBiR1duMjh3Qm5TbyswWXpuckd4dE8vUXB4ZmZER2dTcW14?=
 =?utf-8?B?MUJ4Z3ZUc3owV1JxNFdBM01qNHQ3bld6MXM2azhFUlBlbFRxejROcEJYTVZv?=
 =?utf-8?B?cUYraThaRVJvckNDdTZwOWhJSGtLRHVYSnN0c3p6Q3QrMFNMTGUxWGhJYzBD?=
 =?utf-8?B?cDliSTBWc3Z6RGk4RjBJRnVGSlptVjlPVEZCTTZkY0VTY2dJMVBaTDFRaFhx?=
 =?utf-8?B?Y0l4MTBJd21FSzZ3SGRmZ3gybXVFTUtRRDZlM2JKOU9QYTNhcEN2TEFPd0xt?=
 =?utf-8?B?a3RwRThIVE9TZktKdTVZY21iUmtUclZSMW15QjBjcHVnbFhMOGFIbk14Qnd1?=
 =?utf-8?B?cCtpZk4raSsvelVWL1ZnNUhOdG9jMGExclN5T2JKcG5qcFFEdGFneTd0QXI2?=
 =?utf-8?B?WnNPcjRCQk9JWmdhbTJPVVNIUk9jMVZVSVBDZEV3aGU1WjFWSGg4eEtQUXo1?=
 =?utf-8?B?NE9WUTZGMGpEQ0NuZHpKYjBIdWtBQWE0ckJIbnN0Q2FQbEQ5OHVJNCtML2tQ?=
 =?utf-8?B?R0U1RjU0dWswbHdDampCbGs1SW1HVUNiRkhCNTNzZDg1a01kMDdOelpTVnFO?=
 =?utf-8?B?cFg4aFYyMUF6V0xudDFIeUF6TjF2MnRzOWV3L2tvcHRkNDRRU3Fnb0dzRTcw?=
 =?utf-8?B?VTRRSDlCM1ZOWnJ1ZThJMWIwNHlWNkl5RmFjWG9yVEZPbG9NWmkvL2Z4NmxU?=
 =?utf-8?B?T0QrV3djL2c0MU54Q0lYcFlmdGV0cVYrZURxMWY5bWhCMEplTUtYVTY2T0ha?=
 =?utf-8?B?V00zSGg1VWhwUUE0aVJodlNhZHpPL0ZvNHdDUUtjY3BTTk5NdUNNU3N5andx?=
 =?utf-8?B?bFVHZjFNMkxwS3d1dFY2NkkweFhjcHp6Wnd3WTl3RlUzYWZ0MU53ZXBFb2c0?=
 =?utf-8?B?OUh2NkZHSStuY3ZnZ3FHM0xnUVBsL3ZPTERBMmpYbG9oM1JrZmFiMkRldXN2?=
 =?utf-8?B?VnZJNEs5TWhzd204TnljWmFzV2ZqaGlOSDNNb1FZTUJkdWpjR2lZMjg2TXdC?=
 =?utf-8?B?NWZtazFpWnQwQXNWaDR6UmM5anZLekI2aUhSb3FmcENNOGJsUzllR0V4L01o?=
 =?utf-8?B?MmhWSW5VcXZRMm5lUTcxa1dTRnVKVXNKdTJIWXZLdlE3Z082VEJUSnI2NFdk?=
 =?utf-8?B?MDAxaDA4YXdCZlRSR3BpNFZlMitYNlUwWkFoSEN4dW1rZm42aWE4b0UxblRt?=
 =?utf-8?B?MDFDQmFLL056REtXaUZJY09JQ0NNRGpUd1VTZWl2RmlnMzBrSmhtZFZDeEFW?=
 =?utf-8?B?MW1yWG00NFNoYWY5ZXl5ZmNoRjNsQlBFZjRHdzJUWjdQRUZwRkdDaklpY2dX?=
 =?utf-8?B?ZEpuQlJOMTNuU3FQMzRMYVp4dXpiWG1qMkNFc1F1YWhwZXFuYjBUWHRDbHVS?=
 =?utf-8?B?MnI0aFl4Z2pCa1NZRTdjazlZVEJHeExFNC9CVWhjRUJOYW45dGFiV3lKNGZH?=
 =?utf-8?B?U0psQlJCenBZSGpXN1Z5WEQreG40NjVyYVBuSk81N0tjdjN4dkdhWFExZ1Zl?=
 =?utf-8?B?bnpiRTJ5Qk1qMlBSbVNyaDFEUkNOaE1tbUhKUThENGdoQ2pQQUdZM28yK2kx?=
 =?utf-8?B?MHNFTFZla0ZZWUtKc0FqY3F4bEZYUDBWU1dzL05GSEtQNmZPeWpPTGFoV2xx?=
 =?utf-8?B?WE5WU09vSjRBVGtSQUpiNE9ETDV0MENwd2ZiWm9XL3pJVWQzUnZqdHhEZE9z?=
 =?utf-8?B?MUYwLzk1azF2NkVBNERWNndvdjJrRlVxNWw1L0hnbkFDSkg2OUxvZnNDUW5E?=
 =?utf-8?B?M2xacklXN2RWSis4VithclgzK2JrTVJBSGtseUw1QjRGR1hrWC9QVW5wd2tW?=
 =?utf-8?Q?pKPPJJRabAM67auhdDq9vBJXlhBDRzx3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1hzUUE5RXlGWWJSL09yMUtMYi9YWVF0c2YwQ3ZhZXFISjNPQ2RndEt0YWFn?=
 =?utf-8?B?cWM2alZPVE9hYmF2Tko4eTdhc3l3YVNTMy9OK0MrUkxmajUxaDZEdE5DaUZ6?=
 =?utf-8?B?MTBmSVdHUWpYREFiRkd6V2pXdi9QN0E0aERVdDhJZTFQK3FEODF3cmoraG1V?=
 =?utf-8?B?NjJnN0hSZEJkdFBtaHFYaDBPSFJYQ1l4NjNRSFR0clpTc3RadHRGWmFDMmZ1?=
 =?utf-8?B?by9VUklDaEY1QnFGOHJhVlE4d2RMK0RpM0JWaDVWQnEzcTVGZ1M1SFdKRDdz?=
 =?utf-8?B?M3pZYUNTREM1KzJrN3hEVzg2YmhaTk9Ra29QeEpneHk2YTJmSWpXdGYxM3lY?=
 =?utf-8?B?dXNzeE1jN1ZnMU9KRnZzT3pYbkJieVpJaGlXdEIvSUxBWFRIRXFvemp1NzJR?=
 =?utf-8?B?VDVhUjBCNFRRYjNWQXg0c2lqZE9tQnRkU0lSUm8raXlKQ0ZwbWk3QzZPUm9M?=
 =?utf-8?B?M3pVQzRBeUhWVUwvZHBZbU9jeUE0VlJ1TmxTVTRBNHZmbktiMlRJR0FwZjky?=
 =?utf-8?B?R3FneGxUOVZ3KzdjQkhaUmJKTEVNVUxtaGJNZFlhWmtDbWRUY0hOTytkUzZ1?=
 =?utf-8?B?empLeExIaGtvSERVbjFLTVlGYzFlakI5RjhoMmRFOFhqeDVlSkg4bW9ZMXNr?=
 =?utf-8?B?TTExUGcxVnhJSlEwU2pjQjdxaUVyODRhQXFrOFN2VWMwT3ZDWlNGelpOZGhp?=
 =?utf-8?B?WWJGSllrNzJkSzFxcjFPZjN6UUQ0TXRUWE80amNvaldrSG5NWSthTDJxbmFi?=
 =?utf-8?B?czgza2FqcVk2VkQvMHplQjFGSDRzNnVLQ2JsZ2ZqajhpUlpVTGcrV2NFcUpV?=
 =?utf-8?B?Vk81WWg0dDdQTnY4c2txVFdncXFUMVNhb2dIeTlncHpEV0NjNi9zSUFRUzhC?=
 =?utf-8?B?dHRkU1d0S2pkNHZsY1hzZTFlNzVST0c1RFlMQ1BLMjJ1MDRHdnFadzBERjN5?=
 =?utf-8?B?WVM3ZTdtTmdGVG1JMVpzcHpaZHZIQklET1hROVJHd04wcFQ3VEJ5eGZ2VnJ5?=
 =?utf-8?B?SEk3d0tkZ0s1MG1vUUV2VUcrN1hrVDlEUld5WVJKZTZnMWptVnNNeGJwMllT?=
 =?utf-8?B?KzNJb3NCYWZ3YmpXc01hbTJqdXpzcXo1VWQyYlVRd1I4NERSbUpNTzlMWTQy?=
 =?utf-8?B?TGk5ZFR5Ymo2RUYvRnpnc0FSNXIvbWcyZVk5T0cyVEk1QUUrRFlmZ2RnTEx1?=
 =?utf-8?B?STBmS3dSZDB0Z2JOaGNwR0I4S2xSQjA3WUVMcm45cnJIc09jTWhoZXlEZEZE?=
 =?utf-8?B?UXZ2cHM5OURpdFYrM1N2U0ZiK1FhMFVlM1JwanZHS0JCMTlTekZSanBZTGUw?=
 =?utf-8?B?dmpDeFNOQWVrREFEYXZ3S0NpSmVSRUN1bmZ3VjB3Wnp6TFVwNU1UOVhLTGIw?=
 =?utf-8?B?MHF5VVFSdTZGeGpOeU5uV0lXQ0VZQzdmandIaXZZZXVKT1BmL0RLSGpzdjNL?=
 =?utf-8?B?Ty9uZDE0RFpYQTFza29SNjI1dWh3eFJNb3FyYUNGVkNZWnMwZFo1dUE2QkJx?=
 =?utf-8?B?TmNZUVdGTFV2SzVBWjJYYWJVRy96d0RvMjJUM21XN2gyeFk1TU5JTXNZbzJR?=
 =?utf-8?B?eGhsbVVRVHBjSGFZdTJtMGRSQmFsZCt1dFNvZ2F4Q3JxM25HYnliK1p2dWpO?=
 =?utf-8?B?OUVOWWpmT0lhYXFLZkg4UzhDd2hPQmVRNGNkYStxNHZHeXllbk14R0xlRWwx?=
 =?utf-8?B?WU44VUQ0WlduMjh4bWlMSmNtek1wcmRtRVlmMzFwNUdFcERONTRVejNxeHlv?=
 =?utf-8?B?YzNoeFJnWjBaYjVjUzVna1pIemk0MGpTNWs3eHhXY0dmOGRhbkJWallma3R1?=
 =?utf-8?B?UDdaQ2V4Qk5Pb0pyVjZ4bkJJQ0JYeTJBMHM2ZGF2anZrcnROTFBuaS9TaTdG?=
 =?utf-8?B?Y3FEVVVrVHZ1WGJ0ejBndjBTNlFDVGpocXNoLzlVMStVTkZSeVF2SzBxaUtW?=
 =?utf-8?B?dEVLSG1RR1UydGFORXNDc3VtUmROV1kwWDIvalp4Rkl2d0t1N1JGenNsbHlv?=
 =?utf-8?B?SE1XQ1kxaHNTT1pkQkQxOWlKTWNpUjdBWkFVVnpqZzkxdStab2NnS2V6MTRK?=
 =?utf-8?B?RFdzUEtzMC9ta2hoSW5SMmU2cDRGbHQ5MXJzZnJSQVpLR1R0TVJpV2dvOTJt?=
 =?utf-8?B?SzhYMkFxenZFN3gxM2l4YlI0c3Fha1o4SldXREh4UlIrOFNFQ0JDQTlWVjhG?=
 =?utf-8?B?QjVnanBKZlpxWG00ai9sbVhueXdEdExPZ3NVN1dzMnUzaGhuRXZEMXFxdzNa?=
 =?utf-8?B?KzEzVjRIeUM0OWlyV29vd1dybCtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9F0096834580B4599E17A3EEC8311A9@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 400e2095-b7e0-477e-d680-08dd54ebbea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 15:56:04.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqtannxjf/eWUhBs53q2oxWwgANJlTXMl6mjug5duwCMjBtCiUAF6EpCkFCR8qfX6OCYQhBAFAJu9PJOOIVddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6453

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDE0OjA5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgMjQgRmViIDIwMjUsIEFsIFZpcm8gd3JvdGU6DQo+ID4gT24gTW9uLCBGZWIgMjQsIDIw
MjUgYXQgMTI6MzQ6MDZQTSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPiA+ID4gT24gU2F0LCAy
MiBGZWIgMjAyNSwgQWwgVmlybyB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBGZWIgMjEsIDIwMjUg
YXQgMTA6MzY6MzBBTSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4g
PiArSW4gZ2VuZXJhbCwgZmlsZXN5c3RlbXMgd2hpY2ggdXNlIGRfaW5zdGFudGlhdGVfbmV3KCkg
dG8NCj4gPiA+ID4gPiBpbnN0YWxsIHRoZSBuZXcNCj4gPiA+ID4gPiAraW5vZGUgY2FuIHNhZmVs
eSByZXR1cm4gTlVMTC7CoCBGaWxlc3lzdGVtcyB3aGljaCBtYXkgbm90DQo+ID4gPiA+ID4gaGF2
ZSBhbiBJX05FVyBpbm9kZQ0KPiA+ID4gPiA+ICtzaG91bGQgdXNlIGRfZHJvcCgpO2Rfc3BsaWNl
X2FsaWFzKCkgYW5kIHJldHVybiB0aGUgcmVzdWx0DQo+ID4gPiA+ID4gb2YgdGhlIGxhdHRlci4N
Cj4gPiA+ID4gDQo+ID4gPiA+IElNTyB0aGF0J3MgYSBiYWQgcGF0dGVybiwgX2VzcGVjaWFsbHlf
IGlmIHlvdSB3YW50IHRvIGdvIGZvcg0KPiA+ID4gPiAiaW4tdXBkYXRlIg0KPiA+ID4gPiBraW5k
IG9mIHN0dWZmIGxhdGVyLg0KPiA+ID4gDQo+ID4gPiBBZ3JlZWQuwqAgSSBoYXZlIGEgZHJhZnQg
cGF0Y2ggdG8gY2hhbmdlIGRfc3BsaWNlX2FsaWFzKCkgYW5kDQo+ID4gPiBkX2V4YWN0X2FsaWFz
KCkgdG8gd29yayBvbiBoYXNoZWQgZGVudHJ5cy7CoCBJIHRob3VnaHQgaXQgc2hvdWxkDQo+ID4g
PiBnbyBhZnRlcg0KPiA+ID4gdGhlc2UgbWtkaXIgcGF0Y2hlcyByYXRoZXIgdGhhbiBiZWZvcmUu
DQo+ID4gDQo+ID4gQ291bGQgeW91IGdpdmUgYSBicmFpbmR1bXAgb24gdGhlIHRoaW5ncyBkX2V4
YWN0X2FsaWFzKCkgaXMgbmVlZGVkDQo+ID4gZm9yPw0KPiA+IEl0J3MgYSByZWN1cnJpbmcgaGVh
ZGFjaGUgd2hlbiBkb2luZyAtPmRfbmFtZS8tPmRfcGFyZW50IGF1ZGl0czsNCj4gPiBzZWUgZS5n
Lg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTIxMzA4MDAyMy5HSTMzODc1
MDhAWmVuSVYvwqBmb3INCj4gPiByZWxhdGVkDQo+ID4gbWluaS1yYW50IGZyb20gdGhlIGxhdGVz
dCBpdGVyYXRpb24uDQo+ID4gDQo+ID4gUHJvb2Ygb2YgY29ycmVjdG5lc3MgaXMgYmxvb2R5IGF3
ZnVsOyBpdCBmZWVscyBsaWtlIHRoZSBwcmltaXRpdmUNCj4gPiBpdHNlbGYNCj4gPiBpcyB3cm9u
ZywgYnV0IEknZCBuZXZlciBiZWVuIGFibGUgdG8gd3JpdGUgYW55dGhpbmcgY29uY2lzZQ0KPiA+
IHJlZ2FyZGluZw0KPiA+IHRoZSB0aGluZ3Mgd2UgcmVhbGx5IHdhbnQgdGhlcmUgOy0vDQo+ID4g
DQo+IA0KPiBBcyBJIHVuZGVyc3RhbmQgaXQsIGl0IGlzIG5lZWRlZCAob3Igd2FudGVkKSB0byBo
YW5kbGUgdGhlDQo+IHBvc3NpYmlsaXR5DQo+IG9mIGFuIGlub2RlIGJlY29taW5nICJzdGFsZSIg
YW5kIHRoZW4gcmVjb3ZlcmluZy7CoCBUaGlzIGNvdWxkIGhhcHBlbiwNCj4gZm9yIGV4YW1wbGUs
IHdpdGggYSB0ZW1wb3JhcmlseSBtaXNjb25maWd1cmVkIE5GUyBzZXJ2ZXIuDQo+IA0KPiBJZiAt
PmRfcmV2YWxpZGF0ZSBnZXRzIGEgTkZTRVJSX1NUQUxFIGZyb20gdGhlIHNlcnZlciBpdCB3aWxs
IHJldHVybg0KPiAnMCcNCj4gc28gbG9va3VwX2Zhc3QoKSBhbmQgb3RoZXJzIHdpbGwgY2FsbCBk
X2ludmFsaWRhdGUoKSB3aGljaCB3aWxsDQo+IGRfZHJvcCgpDQo+IHRoZSBkZW50cnkuwqAgVGhl
cmUgYXJlIG90aGVyIHBhdGhzIG9uIHdoaWNoIC1FU1RBTEUgY2FuIHJlc3VsdCBpbg0KPiBkX2Ry
b3AoKS4NCj4gDQo+IElmIGEgc3Vic2VxdWVudCBhdHRlbXB0IHRvICJvcGVuIiB0aGUgbmFtZSBz
dWNjZXNzZnVsbHkgZmluZHMgdGhlDQo+IHNhbWUNCj4gaW5vZGUgd2Ugd2FudCB0byByZXVzZSB0
aGUgb2xkIGRlbnRyeSByYXRoZXIgdGhhbiBjcmVhdGUgYSBuZXcgb25lLg0KPiANCj4gSSBkb24n
dCByZWFsbHkgdW5kZXJzdGFuZCB3aHkuwqAgVGhpcyBjb2RlIHdhcyBhZGRlZCAyMCB5ZWFycyBh
Z28NCj4gYmVmb3JlDQo+IGdpdC4NCj4gSXQgd2FzIGludHJvZHVjZWQgYnkNCj4gDQo+IGNvbW1p
dCA4OWE0NTE3NGI2YjMyNTk2ZWE5OGZhM2Y4OWEyNDNlMmMxMTg4YTAxDQo+IEF1dGhvcjogVHJv
bmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAZnlzLnVpby5ubz4NCj4gRGF0ZTrCoMKgIFR1
ZSBKYW4gNCAyMTo0MTozNyAyMDA1ICswMTAwDQo+IA0KPiDCoMKgwqDCoCBWRlM6IEF2b2lkIGRl
bnRyeSBhbGlhc2luZyBwcm9ibGVtcyBpbiBmaWxlc3lzdGVtcyBsaWtlIE5GUywNCj4gd2hlcmUN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlub2RlcyBtYXkgYmUgbWFya2VkIGFzIHN0YWxlIGluIG9u
ZSBpbnN0YW5jZSAoY2F1c2luZyB0aGUNCj4gZGVudHJ5DQo+IMKgwqDCoMKgwqDCoMKgwqDCoCB0
byBiZSBkcm9wcGVkKSB0aGVuIHJlLWVuYWJsZWQgaW4gdGhlIG5leHQgaW5zdGFuY2UuDQo+IMKg
wqDCoCANCj4gwqDCoMKgwqAgU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5t
eWtsZWJ1c3RAZnlzLnVpby5ubz4NCj4gDQo+IGluIGhpc3RvcnkuZ2l0DQo+IA0KPiBUcm9uZDog
ZG8geW91IGhhdmUgYW55IG1lbW9yeSBvZiB0aGlzP8KgIENhbiB5b3UgZXhwbGFpbiB3aGF0IHRo
ZQ0KPiBzeW1wdG9tDQo+IHdhcyB0aGF0IHlvdSB3YW50ZWQgdG8gZml4Pw0KPiANCj4gVGhlIG9y
aWdpbmFsIHBhdGNoIHVzZWQgZF9hZGRfdW5pcXVlKCkgZm9yIGxvb2t1cCBhbmQgYXRvbWljX29w
ZW4gYW5kDQo+IHJlYWRkaXIgcHJpbWUtZGNhY2hlLsKgIFdlIG5vdyBvbmx5IHVzZSBpdCBmb3Ig
djQgYXRvbWljX29wZW4uwqAgTWF5YmUNCj4gd2UNCj4gZG9uJ3QgbmVlZCBpdCBhdCBhbGw/wqAg
T3IgbWF5YmUgd2UgbmVlZCB0byByZXN0b3JlIGl0IHRvIHRob3NlIG90aGVyDQo+IGNhbGxlcnM/
IA0KPiANCg0KMjAwNT8gVGhhdCBsb29rcyBsaWtlIGl0IHdhcyB0cnlpbmcgdG8gZGVhbCB3aXRo
IHRoZSB1c2Vyc3BhY2UgTkZTDQpzZXJ2ZXIuIEkgY2FuJ3QgcmVtZW1iZXIgd2hlbiBpdCB3YXMg
Z2l2ZW4gdGhlIGFiaWxpdHkgdG8gdXNlIHRoZSBpbm9kZQ0KZ2VuZXJhdGlvbiBjb3VudGVyLCBi
dXQgSSdtIHByZXR0eSBzdXJlIHRoYXQgaW4gMjAwNSB0aGVyZSB3ZXJlIHBsZW50eQ0Kb2Ygc2V0
dXBzIG91dCB0aGVyZSB0aGF0IGhhZCB0aGUgb2xkZXIgdmVyc2lvbiB0aGF0IHJldXNlZCBmaWxl
aGFuZGxlcw0KKGR1ZSB0byBpbm9kZSBudW1iZXIgcmV1c2UpLiBTbyB5b3Ugd291bGQgZ2V0IHNw
dXJpb3VzIEVTVEFMRSBlcnJvcnMNCnNvbWV0aW1lcyBkdWUgdG8gaW5vZGUgbnVtYmVyIHJldXNl
LCBzb21ldGltZXMgYmVjYXVzZSB0aGUgZmlsZWhhbmRsZQ0KZmVsbCBvdXQgb2YgdGhlIHVzZXJz
cGFjZSBORlMgc2VydmVyJ3MgY2FjaGUuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K

