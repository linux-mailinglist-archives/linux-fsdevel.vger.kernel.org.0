Return-Path: <linux-fsdevel+bounces-46856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76DA95876
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D2E16C91B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F521ADD3;
	Mon, 21 Apr 2025 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xx9sBq0q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1821A421
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272345; cv=fail; b=SctIiHwLg3xnPxvVD8/N95PAzk4OQ2PaeJvcp7tyI3/GDbx6kYF0He9OwNHNDK9lDMRE25VyFlvgZnej/AAn/3arJVZsWBiaLXz9VrACBoZFXl2kSe1VxK7LzcIguLhPvyXldPu0toF2eDK7ihphGJfvA0XUjF4LlYTz4vlu1Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272345; c=relaxed/simple;
	bh=A8ubDE9+d/WLq7y1VgKAzIyw9dJHeotRZMwjiJr2emc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Qro1gjWJdfbAYCxxe75NZUf6ObenLTnIo9t2nqX8uFpQbj6mdq2kvR8w10W17OhN70VxyMYJhT87YoxyHgHcUkhW9Z7D/JuPA0MQ5PIekHBajGy1eOwQIYk4T4Um3rk8nRQ227cufO1TLa6HVsxBj5MG1+YrwP3dLrV10UloqtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xx9sBq0q; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LL6kLR008104;
	Mon, 21 Apr 2025 21:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=A8ubDE9+d/WLq7y1V
	gKAzIyw9dJHeotRZMwjiJr2emc=; b=Xx9sBq0q22xIBcdVdEJ1kXFP/dryv3/+K
	HxZGreG4sWO2jl2DDbW4l+Vzyar9q9emuMj06Fu+SMLss0/FXM+Xk7VeXrha3cVa
	2CY1oP7U4Necgp4S3VlWyTljDCj8ssoxD3JZDcz2MSriuW1bKuq7Vrq/q5RtbJtZ
	nUUr95+KdGhqLoUOPrLpRX7ghUsBJNDDBOob2Pf9e8QLMR76vbKf0ewXnpwW5ZFV
	MfhrnQay6PW5KDwnGC27zS/yPGHOOxxvzhLjmsFmmjeTwiSLyuxQIVDf3pzrhF/F
	5BdzuTGk0qupeu2SK21FcNEP1QYiiC5U6ZSm9Uin4aCU7UYm2HA/Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465kxjamau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 21:52:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2LHvbIclirYPJ4FN/qcCGsOaQrDrjuimlIqPZd3hzRygnuDYSMcT7aYaNHf8eeTsVVvDu0vZhPcfRktA6HkkLdSp1oBzPxeioOF7YhuQpxLsuyx6EDWK7MrXU8PpV+/Xm6r5AonsAAW4VHAxJL+f3hQLuFQI816y+qtLur4saucLCVfMf9nvwYeeWV3L5R3BFZXH5wQPGrHw+vK9M7G/7vq0FdBq+o+ykfDHfUSvxiKibUm3IAYlDq/2hTd01oqGBq4osmpxZpJWv9/X/YOoyfM4FxUaJ/EOpwB2GVXaA/3kilayxnfPAhr3XUa0T4VrswdgABr2PYmka30sD8I9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8ubDE9+d/WLq7y1VgKAzIyw9dJHeotRZMwjiJr2emc=;
 b=iB+bLXww6kuUrkCw+krbN1PqWydMq8dQHYK824sXHS+Qb8jS3t7WdxzmfVSKen8V5FZdgn6y3Tt/6jRLR/t5Hub9sZEledyWHZ2z4lH0NbHgM6qKc/anoc4nnjMidYA8T2p/MyTnLymbAcHU5RxSHx6e3sCT3zsF7BClfwwKDCV3DSFnbIxJpxO8zd2QN4L2v0VrpFZ2DHR34sM2mCksqHSbwdzQUJrDGzuDvUYA5dpyAdD/+4ftK1bJquifRucqS9CmcYOmwWekQn/sL8QtzelgldLriroZ+gmC0UGrvUC2sF7Sap9SBevqphTI0nI4TBEvGoCmqjnWkqdcu/ApRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY5PR15MB5487.namprd15.prod.outlook.com (2603:10b6:930:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Mon, 21 Apr
 2025 21:52:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 21:52:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
Subject: HFS/HFS+ maintainership action items
Thread-Topic: HFS/HFS+ maintainership action items
Thread-Index: AQHbswekna2OCwxWoE2e/XeZ/ACbew==
Date: Mon, 21 Apr 2025 21:52:14 +0000
Message-ID: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY5PR15MB5487:EE_
x-ms-office365-filtering-correlation-id: fd2b88b4-481b-456a-1d97-08dd811ec6f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlRxQ0NvOHZYdHlEVjdRblRER0R6Zy9BZ0lRbVo4dDFFUkFRd003WEhvNUpu?=
 =?utf-8?B?U1pmQlNkcVBhS1FZc2pKbkd5eGxwS0xEWlFFSjk4elBQVlc0d0p0R1BtNEw0?=
 =?utf-8?B?VGNHSGFKMFV6ZXBVaTJIeWZ0ak9yV29yc2dLS2dEMDdyek4zc2pJVjkrUHYx?=
 =?utf-8?B?UDBscWppcWFWWjlraUp6dzBzcTV2MTh6TVI3NmNJclFReFozTkZYSmNhZTIr?=
 =?utf-8?B?RU9kQUJ3VE1wc2dldTBsYXRqOVVjSDJVOW90dndDNjZ3eVh6L0VDTlFaOXFr?=
 =?utf-8?B?dHVHN1dRVERwanFNb3RhWXAyWmlsdmhXZ0RCMjY3RUVNWDFxbCtOU2lqQnRG?=
 =?utf-8?B?UzhaYUlCWmlhMlVJaHZTY3FtRFNnM252QXNDa3AzeE1WKzUyazZpemdIeXRx?=
 =?utf-8?B?b3V5MTBzYys5YjFiOXAxZW15TXRWSEU5ck9zUCtjSnBsK01OOHNoMkpncHVr?=
 =?utf-8?B?VzQ4a3BoS2lWSWV4cnhOeUtlaG1ibHJ1NC9ZS1R3U1JPSnB0T3RkM0ViM2pi?=
 =?utf-8?B?cGhkOEdLamYyN2IrSjJzNnk5bk4zamk2WHpPOFpxY3ZiRkc0S1NTdGtsUllw?=
 =?utf-8?B?dm1FN0NhQ3ZRMVZWQ200SEw3YTJ3MzNiZWVSby9RVGhxTURiZ1QxWHI3MVVz?=
 =?utf-8?B?dHhCRElTNm5lQzhSdGtsN1NEWURiYjFFNk92K3RMQXVaRnpxL0puYlBQd2Jt?=
 =?utf-8?B?emFYZEN3RWlwWkZGUmcvRENraVQxVWVPb2Q4QkNMOUFRaVZUQ2ozYytvUDVl?=
 =?utf-8?B?THNMSjBSNkNUUWNVY05HQkNqTjZ1UG5IN0JBOGVDRm5PV1RBa1Noa1N4R21N?=
 =?utf-8?B?VnNKeGhsVXgrcE82MEVINHdJenUzMkF1RmlucHBJYTJqRjJyMkJobEUwbzB6?=
 =?utf-8?B?M3JQRjhiZ0h5eVA4OENXQmRIUTdYZm9XZGJSYjJ5M3F1WFZzejNQWVhyQUpw?=
 =?utf-8?B?enRrREJpTXBwWGpUeXJjTnlZdWdvUDNkOHBzblNjUDFLdnNTbnVtZDNwSTBN?=
 =?utf-8?B?cXMvSENUY0M0TFdYdTZlWDY1RHJzQ1JzUDdnVGZCWjJlaDB1WEEwOWs0UWNq?=
 =?utf-8?B?TUpXRHlyUVd6WEZ1UU9Gb3BMUVQvRVIrejRHQm53TTFjNC9tNGE2RUdUZS96?=
 =?utf-8?B?aVVuU0RqMG9xSklGUDZ3UG1GNDFTNVZJaDdVYU4vVWNXWDVzcGpaZXdJQjVF?=
 =?utf-8?B?ZmZHeUJaeVdrSExjZjFVMmZGeG9GeWp3WmU4ekxUdlRabDJhd0I4UGRZT0gv?=
 =?utf-8?B?V2w2N3F4dVFsKzFiTzhJaFlrRTNZVmhndU5FTHVYRUZzUUVmTlpuN0pnOWpI?=
 =?utf-8?B?bmdUZGlsSldsaTJnTHhjNk9OTTVXa0xpVFRZYkkyRUlqdkY1T0gzN1Y3ZkR3?=
 =?utf-8?B?NklpMHFBaUkvc2pYbFk2ditTQmIzZ2taRDJGR3JGcHdoZlNVSGpJUFBMYm1I?=
 =?utf-8?B?SG1xbTFvaVNJMll0UzdQNStJTnJQY2h4MmppLzVqaUdOZUw2UkpxSm1hV1Jv?=
 =?utf-8?B?ZkUzQlpyMk1OaTdUcmhkcEZDSlJIakhKcjlBU1RhVWJVYUNGWFpZVUhvVHlL?=
 =?utf-8?B?ZzV2TkdCOVVYd0lBOG9xdmR2OXgwdkszVktBYUVONUtHS2FHYnJoWUwwakZL?=
 =?utf-8?B?KzV6TDZ6dG9ENS9NSnhjVHNqYndiODdyN2VmWHU2N0ozRDdpVVhtR05vcEZt?=
 =?utf-8?B?NGNLdWorbThZeFMrc2pmVVE0MllJTzRLdHYrV2djSm9DQTNkK3NwQm8wS1ho?=
 =?utf-8?B?dng3dWlUdGl6T3Rka05KWndoOVZEZldraVdFSVdPTFRZTFpjZGZCcThUb2dB?=
 =?utf-8?B?V0Q2OGlET3I4aWNmUXU4cjdJUnM0d2gxdWFwNWxISmFtVWYyK2pNZzdYNUx2?=
 =?utf-8?B?UkQvYlBJY3B2STI3eFUyL3I0c0xyVGw4dFNURzdZcGVFWjgwWGxkMmJQcUVi?=
 =?utf-8?B?emxmcW54dkd5WllRNzc4TEtLVlowN0U1WU14Y0Jid0NKRFJtUkZyVkkrRmZK?=
 =?utf-8?B?Sk81STFPTTd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M20ybmJnS1FwUjRNcWpEL2RacmR2Z2MwczFhYTdlVEgrLzV2b0RlV2cySUta?=
 =?utf-8?B?TE83c0JiZFhMMWo1WnJSODM1ZzBwQ2RHTVdxYStWS3BGYWRHaE1GLysxS05X?=
 =?utf-8?B?Q1BrSDRqRkhrUlROeUkyU0FKSW1WTGVoYU1zQVJKSnRwbkRhRkpwbkpHQU1k?=
 =?utf-8?B?cEkzOE1pWnFKRzdEUkZXSWxCNXVBSk9yY2JTTXNIeElWN3ViZU15NFFTMk9k?=
 =?utf-8?B?bW8xbm9JaUdvVk93QXNwT1g2aFdhTlluVUJ3S1VzN0RFYmdBc25jQ2p5NHZT?=
 =?utf-8?B?WkNCazhwSU9aQjBlSkM3VVFPQmxCUUJFcDlVbkRoQXk0V0hkelNyN3BlSllE?=
 =?utf-8?B?UUNwUmhUcVI2ZzRla3FaTG9jNXlKUE5Fc0xaMjhkOVg4aTlsZy82ZStRa0N5?=
 =?utf-8?B?bWRCci9BemY3S0JKN2NtRk02TnI4R1BsRW9PTnB4S1RhMkVrdDlNNTlOUE9p?=
 =?utf-8?B?a1ltMXQ2azhraXg4ZlAvenBPall6Y1Y3bGFpNktZQis4Z2U4eXU4YUZRN3R0?=
 =?utf-8?B?UFBKOERYOGU0VENiUVBiakV0bllEQnZhTHh4UlM0RnkyWFRidDFZdkt2d0lS?=
 =?utf-8?B?SkJqMWphbGJtMnMxN1ZmbGlBS0dEcDVXd2VPcW1RemhMWkNTVWdHZTU4V3Ix?=
 =?utf-8?B?NFZXNUFHSDJxM3Y0VDNOa3FhVlM4SVFrL3hBZ0dxK0dRS3R2bjRxN21mcDFL?=
 =?utf-8?B?OGhIMFE3SjBxbEk2eW15TXdCTzVoaDBLdGRadUhIYlhwcGhWNDNjQTN4Wk5j?=
 =?utf-8?B?MFl3TFdzMW85dWN0RyswOFZtSHVJTktkdk1rQ0ZlVEUvNUUvNUlTSm53K05j?=
 =?utf-8?B?Q0liemZlc0gySDZUVHR3cngySWRybmI5c3JYMjJEU1BOYWxISGg3TzIwR3dz?=
 =?utf-8?B?WWlmWFo1eXBSY1J4Z2NINFlFUFd1aFE3NHFqMXFua1dKdWtOVmtDUkR3T3Ry?=
 =?utf-8?B?RklYa01BdEU2WGpveFVJcUZmdjM2VUJ6VjFaWTVMSnBURFRQTktwV056bmZD?=
 =?utf-8?B?emQ4bTEvYzdkajMxdlZ5dDI2NHFqNHdXWDEvZWd0Mm95TlRTU2ZjbXN0N092?=
 =?utf-8?B?Rm1XN0IrUEZLWnJKOHlmcXpLbzlHeGpJZkpEZDFjVndYN1UzTlp2YkgydFNG?=
 =?utf-8?B?ME1uekcxeDBYYUcrOTl4UUFtbkhxTzZEV1psa2s2TkVqbGpLUVdEMGRpditJ?=
 =?utf-8?B?OW85NnVWMUtFbDlwdFdLbnN5Nzhia3pTazhZc0Yra25VQ0RkcjRsSmFwMU9m?=
 =?utf-8?B?SEFuN3lpeEFWYmZXRUIzSU9JZVVsbWhTb3ptYUY5WWh3UXBqTnFFQThrS01O?=
 =?utf-8?B?SVlzWG50VVJMS1hYZVY2a1cxUnNjKy9iMWtvb1pYVGJTS1JaQmp2YzdQUzVJ?=
 =?utf-8?B?emtiTk9mTVZXWjY2KzJNWjNsQUNNeXFudENqTmlYOHRGOXdUc3lPa1VsY1Vn?=
 =?utf-8?B?MDJ5U2hEYVNVcEFxK0dBS1NwaHVhMGlodHpSUnZtb1I2ME5ZeGU5WWMvOGhK?=
 =?utf-8?B?ZjdmbVo1d3E5QlhtYlljY2hXckQyNTdERzB4dWlvTDRScGx3R0pRUG1EL2Nz?=
 =?utf-8?B?eTl3OTZZcmlSak1sQStYb3U0b3pzNFFHRmM1MzgrVHp2TjVXZDJPRVMyYjFJ?=
 =?utf-8?B?bUUrTUg0RnA4OVBHODQxbWNZM0Y3b0tWKzJTV0YvaXZWbGNmdjdLdFVoTyty?=
 =?utf-8?B?QWYvV3pEMUhFZ3NXbGNYeDlGNXQxSlpJelA2RDFrYnI4VzI3TEpMZ1haYTAr?=
 =?utf-8?B?cDlGMlFveVliUjhHZ1UvTEVPTWZ2WXRPdFBBcU9NQStBTUw4Vm1TOGJQaW1R?=
 =?utf-8?B?V0xjcXBhTGtma0RtRzRlNnlYRlhleVkrZTV6N3Y3NUpsdjFuZ0V1aExQclZr?=
 =?utf-8?B?c0JhT0tCNVltVXNSUS81Vy96Z3Z3WExWWTlUVmx0L2FlVi9JRkltOUl2dVZ6?=
 =?utf-8?B?NnIvY1BLWHVwSno0NmFvUHFrWkNSeXM0Nmw2TVdiTWJlOFJiR2lPalRhYXJ3?=
 =?utf-8?B?RE9yWFVlOWo4eEY5OWJ5NXIwRldNZmFiL3M2S0VsdmpXRHZIZlJGTk42OUpM?=
 =?utf-8?B?dHFyaEJGbnEvS2FQQzY5M0Y2MEd6V3UyS1UwWkZvZW83OEJSVkJZZWJCSXpT?=
 =?utf-8?B?bjYrUitTcUVLekNpN2ZZLzVTWExSY0JBWktpYk1UR1hpNGt1TFFmcndDS3dn?=
 =?utf-8?Q?b+JlO4biQF8rQy84XxNnmoo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5405B81550AB7945987F83E38FB71250@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2b88b4-481b-456a-1d97-08dd811ec6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 21:52:14.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDjPsLpMWVeOdTI+Zf+J4+1nSiCp6BEJn9V2x2jb802if+qUXYEMieQuwf67the9mFRf2CjGcuu8+Opcm0uZig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5487
X-Proofpoint-GUID: 6JH-GnnGPuy8i5fB969w_iaT9I5qklNt
X-Proofpoint-ORIG-GUID: 6JH-GnnGPuy8i5fB969w_iaT9I5qklNt
X-Authority-Analysis: v=2.4 cv=HLDDFptv c=1 sm=1 tr=0 ts=6806be10 cx=c_pps a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=_qkopfeZWZregBL7D8YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_10,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=997 mlxscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210169

SGkgQWRyaWFuLA0KDQpJIGFtIHRyeWluZyB0byBlbGFib3JhdGUgdGhlIEhGUy9IRlMrIG1haW50
YWluZXJzaGlwIGFjdGlvbiBpdGVtczoNCigxKSBXZSBuZWVkIHRvIHByZXBhcmUgYSBMaW51eCBr
ZXJuZWwgdHJlZSBmb3JrIHRvIGNvbGxlY3QgcGF0Y2hlcy4NCigyKSBJIHRoaW5rIGl0IG5lZWRz
IHRvIHByZXBhcmUgdGhlIGxpc3Qgb2YgY3VycmVudCBrbm93biBpc3N1ZXMgKFRPRE8gbGlzdCku
DQooMykgTGV0IG1lIHByZXBhcmUgZW52aXJvbm1lbnQgYW5kIHN0YXJ0IHRvIHJ1biB4ZnN0ZXN0
cyBmb3IgSEZTL0hGUysgKHRvIGNoZWNrDQp0aGUgY3VycmVudCBzdGF0dXMpLg0KKDQpIFdoaWNo
IHVzZS1jYXNlcyBkbyB3ZSBuZWVkIHRvIGNvbnNpZGVyIGZvciByZWd1bGFyIHRlc3Rpbmc/DQoN
CkFueXRoaW5nIGVsc2U/IFdoYXQgYW0gSSBtaXNzaW5nPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

