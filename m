Return-Path: <linux-fsdevel+bounces-21264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53880900939
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE74B24DED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090EE1991DB;
	Fri,  7 Jun 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="P3/QUAO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2107.outbound.protection.outlook.com [40.107.236.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490101CD37;
	Fri,  7 Jun 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774371; cv=fail; b=tKK+Q/ywFSu7JlZJGfmrhYaFAE/HOZWxRwJ1XFI1xYWV8PYAFby3UgMz654EMd+5fCdzoD9SGoTETHsS/zaeRvKXyMd6+xa5KaxoMZjD41ypqbNZBK2QQclKHAx447OZZt9hvp2X7HdVf752Jm1g1xzazxmvf69r4LtMuPsR+Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774371; c=relaxed/simple;
	bh=aZnB0niVu3j1F/qyPXuK9wmQX+mwzlPfyfGAqeN6pso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OnDJkvGH6RGoGw/3sZ9Hq3brEMYLPNT1iCXD3CG7ZlnXNNIsJHOiPpO7GFCK3nU8Ww5cQp2AGn+Yf0C3v9QjtNJ1fuDYek5IwIvk8iDExm8xhSy4F2aB2okyQCA6t8ATG2PJgC4TQpDLJ5pUfXa4djEfuiGVP7nf17tk83AnuyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=P3/QUAO6; arc=fail smtp.client-ip=40.107.236.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR4qRkqJkyywEsQMJfg3LBrVb6zeQKtXIvcpGsR82wdIm5rNsUGoY7W6BPawbDlqt/U1ozLn1PwostcDKYZRSSKjntLlLYwqvV03V+9FpzHh/aWTEltwoAXZpfUXi7xVKW3UvSmdZat2w1XADw7L5cosRup0VsCQ+0Z/lzfYSrkEI7G2mQZihx/ACj4tqavv7dH0D28AdsB8UZJdZbIMgk69ICjU2R9msrssIMvQztIy/WiGl9tpl5ni8OrivsW1ODD5D+HtmWlclJSFdqltp3JX9qORx+e/0woZME42c1/Un/6FTi45hrowGysqo7/MZe/Q62sJLtfdx1ddMCFokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZnB0niVu3j1F/qyPXuK9wmQX+mwzlPfyfGAqeN6pso=;
 b=OVdaX9bzIB70njTaRVULumbW3fOpnpfFlIkptCth8NZRHprTf6POVj3SGn+uo0rnSbtz+i+GfojoVBTfESaOF5vAIsvSW6IEwAf2CRzOCnqxjpRpUknIfJtsJQfabiTexjgGPThvKdGq1sLWcUtd6YH+povhnBDabN0Lu1+GkVfVSwfcXlxDUkO2EL5ptSYvVrHhtSmV3kU7QXyPF/CTzj7lmMFf8zY9eEQgYlnriTlg6tbYebgJJMhq8sT4Vlu0edo+ibJRvyK7AyOeKyvud3QwfGfK3G8WG2tmFB6gvn2LdKJl8xfktUduhkavzTioovJZqMZ4uDBy/GC049irng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZnB0niVu3j1F/qyPXuK9wmQX+mwzlPfyfGAqeN6pso=;
 b=P3/QUAO6yVzREo1kaZGqOs/lq3bPAwc+VzLoIE0nEIISxINJNzyPMLukzCs8Y6dMeyHXzm3DnOgV9/FHexZn5MIcReXeaPvFcFaLn4xfZRymXNaclcV1RGor/SyTXoRWav4nPZF4Z07owobbMXFgOKfhoaoiAOvYc9u0SFWl8nk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY1PR13MB7115.namprd13.prod.outlook.com (2603:10b6:a03:5ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.8; Fri, 7 Jun
 2024 15:32:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.7656.012; Fri, 7 Jun 2024
 15:32:42 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@lst.de" <hch@lst.de>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: support large folios for NFS
Thread-Topic: support large folios for NFS
Thread-Index: AQHasFQEtVPFzJw4R0eoRu1V26ovVbGuxl2AgAIcooCACvOsgIAAqIaA
Date: Fri, 7 Jun 2024 15:32:42 +0000
Message-ID: <cf530d0c99c2b090e789b1beaf421bb4899f1d24.camel@hammerspace.com>
References: <20240527163616.1135968-1-hch@lst.de>
	 <777517bda109f0e4a37fdd8a2d4d03479dfbceaf.camel@hammerspace.com>
	 <20240531061443.GA18075@lst.de> <20240607052927.GA3442@lst.de>
In-Reply-To: <20240607052927.GA3442@lst.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY1PR13MB7115:EE_
x-ms-office365-filtering-correlation-id: a4504199-b510-43b9-c40f-08dc87071278
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WThEN2lBUWJScTY3NytTUWhhaDV3QUpON3Y5UUdsWFNNNE1HTlZndVV1U0Vk?=
 =?utf-8?B?YUxIQi9mRWVwYm5oYW9vR2t5dkNUT0UvVml2L3ZNbU5QR2N2R21lT2s4WCtw?=
 =?utf-8?B?dmlkaXZwQ0F6WU1Xb0ZnZTdJbU5jaEN1THRxMkxvbTFWL2c3WGNZbGxhNUlJ?=
 =?utf-8?B?YUg3NE9JQXlQZ1pTanZzbGJRL2JSZDJHMkhRWUVzejRGTURhczcwRlBva1hs?=
 =?utf-8?B?ZXl5RHdBZGpRZ2VnTEl5LzFnb1k5YitKaHhzZ2pZQWRLRG8vNmFqRXBCRm1L?=
 =?utf-8?B?dXk1SFJLNkxzUitPb3gwcGJFNDFkQnVzeFlYYWxPb0t2YXRzOFZxMm1XaXdj?=
 =?utf-8?B?SkwvbW9ZaHdhSXEwMHdCNXE2WjJpYTZBQnZVMy9XQ3hTUUdkQjdhOUVZaFBO?=
 =?utf-8?B?bVQ3VWN2cHlwMmtNcDRtbDJyQUJUQ3N1VXl3UWwzZy83U2FSdFFIbGhYdVFN?=
 =?utf-8?B?ZHM1OFBSL0FwNStlV0Fvb0Zoa2R6d3YxR1lpRXVFVDhMRGUyKzc1eUdJc2R1?=
 =?utf-8?B?RkF0dkxCSUhPZkIrV3k1S0RZUTQ0NXloU2JSeXZmQlV2WVdpZ2VOcm41eTI4?=
 =?utf-8?B?THpPNTVCdWhTS3hvRkpTTDRQckg0U0VRYm9kdExCM2MybDlGM0pMVWd5ZVpF?=
 =?utf-8?B?VWVaOUZPbkw2ZXd2RVI5UzFUQW9QdWQ1WmJrVEJ2MnlZMVhjTXVHNUM1M29Y?=
 =?utf-8?B?U2FXMFdCWThuL3h5UWlpWEJKMlIvSVpyWmFJUmN1cVhha1dNU25CQTVQZThn?=
 =?utf-8?B?SENrWnp6dG1BSklRKzJ5QjFVcDZwb1VpZGc1aU9pbng5K1B5NTlJVFUvZlFD?=
 =?utf-8?B?SSt4NHZIS3ozVk5yaHpoK1E2anFvc25LSDlzZWZBaEZST21xM0dsQkdQS25P?=
 =?utf-8?B?RGtzWUYyMkU1V3FpZkdUOGFXNGd5QkQ3SkhKYWtIcURmMitUVTA2N3V3TXNG?=
 =?utf-8?B?dWlZd3V2U3dSVHBac1RVaTRlNXk4cE5VVWhKa00rU3FqRFZsZlQ0Q1VkcmFO?=
 =?utf-8?B?dkJLdEs5Y0xHWHRJRDIwQVlKcWFtNTN6SjVoTi9DYW9GTmhOZXNORUMxK3lV?=
 =?utf-8?B?VEQ0ZjgxdTNNRHpiampyLzFzRHkva3FUa09aZU5CTDRPd2kyTVJCdEJwbFlJ?=
 =?utf-8?B?Z082T1g1Nm01aTR4T24rZDEybGU2L3NqK3laTjM3TUc3OFIxOFFxUnhNTU5F?=
 =?utf-8?B?VTc3cHdNbEFENkk4M29pdElDK0Y1R01ya3R5RDNCV2RVWHVWYlhHQmxzYkMw?=
 =?utf-8?B?Qm9FRWUxSzl1Nk41aXRqSXdFNG9kei90Q092cVB4c3lOREgrakNTcEZNcVVC?=
 =?utf-8?B?L2xhMzFTQVp5TzhRb2s3dGQ3bmNNVTFQZVU3RVhialdpSjNHNS91VW5xblVq?=
 =?utf-8?B?amh5M1VzMzV5UUNCOU1wQVVqWlFmRHorcGI0azE5T0xhaGNQRjc2TUZFUURn?=
 =?utf-8?B?aWxib0pjeFNxTEVZWjNhVmgvdVhQRU9iSDN4bzFMYmd4SXZrZW1zUU1PdFha?=
 =?utf-8?B?UjVpcU5tN0IxMzRFVXJsUGY3TnBlV25BYk9veUQ4Z25yeW1SYVJSZzJOUXhB?=
 =?utf-8?B?dThxS0hoYTYrTEFQeEo1STEvcENhS3JPUytlTTVNRURMSlRwL2tHYzJCbUJh?=
 =?utf-8?B?WFY1b0pGdUdMMDc4VHp1SEU2aysxTXd5VHFkeENuMnZPVVdGb2hEbjJjZitv?=
 =?utf-8?B?ZFM4Skx5ZnczUFBTZlNycm9FVXhsSXJzMWR1Y3loTm03NUJzWVR6dG9lbEhP?=
 =?utf-8?B?YkhJbXovc1o1WS9PMUY5UTRvSXRhSHlWVmRjYXpScGhmbjdVY0xVbXQ5ZkJi?=
 =?utf-8?Q?MQmFsDe5fgM8bywKAQUTqD0j8QgaO2QRXZl2c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S21rNFg4Y0plWXM0R3dqaTRxNldkU2pFTXdNRytDeG9GK08yQUtoREdMc2Fi?=
 =?utf-8?B?cFlaQXhvZUxOY0lwL20rc1VEcExoOFRGSEVpNE1lV2JTMmhvTUdUSXhPZUE5?=
 =?utf-8?B?cGFOc2VnUG1vaWlEZ1B2NVZoaFUxeHd1Z3FYWlBJZS9mNXVLSWJHTDF6UkVZ?=
 =?utf-8?B?VDlDSURPaWRCT0Zia0thdm5GYkFjMXZLcytIbXNha0Q3akdQalU2VHArRjAv?=
 =?utf-8?B?RkExdGhGVUxONE82RG0yaUk0RmlkL3pPTndzSmJNK3d6Ni9qdnhMNGRlUG5w?=
 =?utf-8?B?TFgxQWREQ0l0MVlSb1oyaHZZZVlLNUVBV1UzVkd0cUdTY2RaQ1FGSjc5cU9U?=
 =?utf-8?B?OEMyR3BWSXRLVjFpVHhQb2pyNE9UN3JlV2hENFFVdTdwWnZnTVhUU1U3dEpO?=
 =?utf-8?B?Q3JiaFp0S2xIUjArL0VFZWE3SHoxa1Y3MXhiQmdNdHRFbFVwanJ1cWdPVFpT?=
 =?utf-8?B?VE14TlJQNUtCQlNwWkQzMTlrbS9nR3VPeG1DdGg5cmhiaDhrMjdBZ2UwY2l3?=
 =?utf-8?B?dXliK3pCRFJ4Uk4rMlJxWUJYSDBsU3NVREZiZXJ6aEVSajhsQitEZHc0bk9E?=
 =?utf-8?B?czZIcVNnQldnSndVZ1g1Vm1YendqVldyaXRXN2J1bVBVaEkreXNaZDRmUjNO?=
 =?utf-8?B?OE5Md283bkdwcUp1bksva1kxblRrYmFFd3lJRlRQRXN6OGFjVnhlZDU1MSsv?=
 =?utf-8?B?bVJXZ1R5b3htT01hdmxrT2E5aFV0eFF0NVhDV3RuTDhHekQ1My9lZ3hBS2NH?=
 =?utf-8?B?YlhDbFJIRS8zYlpneUkrWFlSUzFTa2d1bGFnMkd4VnYrclZQdUFna21STi9P?=
 =?utf-8?B?TmM2Q2R3L2NjdDRxWSt3N0k3TjVEUXJpNmRsRVJhd29sQnNZVG1PTitLejRq?=
 =?utf-8?B?Vks1UW4vWG9tSWt6WlE3cC9VVHF3QTYxcE5RSzJDRGd2M2JpOGlQQVAyRnNP?=
 =?utf-8?B?QVNXZDM0MmsxWkhGWk5uaW93eFBSY3Z2NXFQZlFUbC9hSGt0QTYvdUdjblpO?=
 =?utf-8?B?QVZrUGVVeU9JWkU5eFhTMkgzbkNNaE01Wjlpd1hTTlVTT3NmekVFV21KVzVL?=
 =?utf-8?B?d3VjU0x1UWpMSjhMOEIzVmZuZmgvN3pvYTk1SEpzbUJOc09mbmNWQ2FlTVUy?=
 =?utf-8?B?S29QbmcxYkZ3Sm5RUHRaTzZGY0IxVG92RGY1elJFRHo3dWxTcTJEV01aMWlL?=
 =?utf-8?B?Z212YWxDM1d5ZXVCY2ZCbnpRaXp3SVBOc0RvWTF0c1lDRHUySXQxV0xBdzE3?=
 =?utf-8?B?bU9QVzJoWUhWamJLYjBMT0NsV1pVQ1JOa3JCVlNJc3NlREpmTFFXelVxVWNX?=
 =?utf-8?B?V0xqVWNkZ1o0MkNYL1Z2ZFhYL3ZCR3YvMzd3SjBlaFdoQWlaMjZ5cFBtMXk0?=
 =?utf-8?B?cURDejNyS0xGaE1iazJjc1kwZ3RQQ3Ezc3RwMU15ODlTZlM2WGtzUkJXV3l6?=
 =?utf-8?B?bGtLSFNkbUdFQU8zNEJVWHpNWmdOTk9wMTJhNjVDZDErQ3liaDJjTGZlcWdI?=
 =?utf-8?B?bk9yLzF2TThobzFSQmwrUUlaeHlKR0t3MU4wY2Y5QlUrVUpCSUx5cGNEbnpy?=
 =?utf-8?B?cEdrZXRFT1dsUVV4S0tOUXFENWZ3WERYckJUT2ZuNzlqZGc3VUl2aTBNVVd4?=
 =?utf-8?B?VHJjZ1lXVDl0SjYzZ0k0SW1WR05vQUxtanRsN21mZmRoamU3R2hLRDhUaTlM?=
 =?utf-8?B?NGZ3REZCMjkvSzUzMTJiWmJVWGxweVp2TkIrYm1KRm5KNkcyYlRZSUNNZE4x?=
 =?utf-8?B?MjNiNkNTQUFGMTZDdW56N3N4ZFJSZVFTTGhBSjlCbklUVmpiY0J6NWxZUTdz?=
 =?utf-8?B?aitVUFovaTQ2VGtDMlVneDRrOHBhblhMSzhXZ1l3MUhia3hJT3JzTHBIY0pK?=
 =?utf-8?B?MVZickQ5Q01lcWN6TEpiSEFvTndHMEpwUXhsM0FCanUycUhOdG1PVU03YS9M?=
 =?utf-8?B?ajE2WTE2U04rckYvcWVYUTRZWll0Z3l1T0hZVkRybms5VERwVnpDUGFySlJ4?=
 =?utf-8?B?UDFSaDlkbDVrWEZhc3AvSGRZTUlkdmJsaG03bm8yc3I4RENSWjZ0aGliRjVi?=
 =?utf-8?B?eHQrcWFCck5yNDlhRkRXSFpVcmNwb0RLUCs3NExsb0RZNUFjdUI0eHZwM09u?=
 =?utf-8?B?UEhsQWZKUDdGU0xwSjhPSUtSV201cGFOb1p0NU12Z3haL05MU0F6MGdCZmUr?=
 =?utf-8?B?OWN3TDdTL0FOeFBzNkJOMTB0UWdBZm9qQ3hHRVoxRlZHaXZEQkR5TUVjVWpz?=
 =?utf-8?B?UFZYcmZMSSthbEhiSDhVbG90V0RRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C560D1AB4203C4BB2FD388F778A57E9@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4504199-b510-43b9-c40f-08dc87071278
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 15:32:42.4065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6DqIduqtAbEBq5jvpzNc3tG2N30Mt94/FhHNDsGFYjNXgdx1RFXyeRo2UX2+vokT8HrNu1hvP3zORWHzPYgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB7115

T24gRnJpLCAyMDI0LTA2LTA3IGF0IDA3OjI5ICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBGcmksIE1heSAzMSwgMjAyNCBhdCAwODoxNDo0M0FNICswMjAwLCBoY2hAbHN0LmRlwqB3cm90
ZToNCj4gPiBPbiBXZWQsIE1heSAyOSwgMjAyNCBhdCAwOTo1OTo0NFBNICswMDAwLCBUcm9uZCBN
eWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiBXaGljaCB0cmVlIGRpZCB5b3UgaW50ZW5kIHRvIG1lcmdl
IHRoaXMgdGhyb3VnaD8gV2lsbHkncyBvciBBbm5hDQo+ID4gPiBhbmQNCj4gPiA+IG1pbmU/IEkn
bSBPSyBlaXRoZXIgd2F5LiBJIGp1c3Qgd2FudCB0byBtYWtlIHN1cmUgd2UncmUgb24gdGhlDQo+
ID4gPiBzYW1lDQo+ID4gPiBwYWdlLg0KPiA+IA0KPiA+IEknbSBwZXJmZWN0bHkgZmluZSBlaXRo
ZXIgd2F5IHRvby7CoCBJZiB3aWxseSB3YW50cyB0byBnZXQgYW55IG90aGVyDQo+ID4gd29yayBm
b3IgZ2VuZXJpY19wZXJmb3JtX3dyaXRlIGluIGFzIHBlciBoaXMgUkZDIHBhdGNoZXMgdGhlDQo+
ID4gcGFnZWNhY2hlDQo+ID4gdHJlZSBtaWdodCBiZSBhIGJldHRlciBwbGFjZSwgaWYgbm90IG1h
eWJlIHRoZSBuZnMgdHJlZS4NCj4gDQo+IFRoYXQgbWFpbnRhaW5lciBjZWxlYnJpdHkgZGVhdGgg
bWF0Y2ggd2FzIGEgYml0IGJvcmluZyA6KcKgIEFueQ0KPiB0YWtlcnM/DQo+IA0KDQrwn5mCIFdl
J2xsIHB1c2ggdGhlbSB0aHJvdWdoIHRoZSBORlMgdHJlZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

