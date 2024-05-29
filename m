Return-Path: <linux-fsdevel+bounces-20449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B98D3943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C45B24860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ADB1591F8;
	Wed, 29 May 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="IyX7q9Ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB19158DCE;
	Wed, 29 May 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993119; cv=fail; b=HQCI9ZnYYg4KEFgPnaGeB/ytV5SYSGMILnzYf2PweM+VlYb7f3qQxk9AqUhWiuVAwnqTirbvA37Tkg/JdHRweo/AvWSj7R/vF9gl5j17l6uz7G1l3j/3GkjO+A9DUergrpeczja4PkuN8kJFLsLJWfz/0+vbPeYSwTO4ZNt0JHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993119; c=relaxed/simple;
	bh=5AJ/IgNhf5EI4OegLxEymFv/sPd68CCvtCfMSFFLXEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kyZUnu6Y7dyen99+Pc/TpENLgUjt7MAWYP+MonRNSnDtK0/+JXhPmHllpyfry9o/mJ/t6ty5Lqd5TDybTD5Mo/6PAFkoXeaUeDN5vHArDnz/p17jVmNVo91iwCEvGUk4cJiqxtXleCidkAG7en+5Jo30iLvUxkpcoi4yMs9YIk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=IyX7q9Ug; arc=fail smtp.client-ip=40.107.244.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV+xIQOk4CB0Xw6udc8y6LdU4upabusO27GgzvHfXZ8KX+kk4BnZsa75A4PDJNyh1j+uI3SBbevVmcVzerDm9HOCBckKo9EoUmrPqsKPCV0FuodgN+InywmLS7IJiR6HdMss3ykZ0huDkaerwjmCe9vVp+sW2marJ+r2wfQQqm9Ed0QKt9ng0/s1qpjJAspgqRoeL62X/ctobbwu0R1LKJhcxHYyGF7jJ9BuBLWTZ1+P0blLC5gCcav4XRx9EO5mvQHZjtqsh5dgC22B+qh+hK97S5e/xfPVG6bs2urQHbacoEmU6JWsdIOkn/TW989dSrrzSepLpiKn/2Ejar5TcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AJ/IgNhf5EI4OegLxEymFv/sPd68CCvtCfMSFFLXEc=;
 b=G2iIffgOdoUP/GZ/bQ1MysbbFV3DN7nJLgnD1G+0w0MIuyffvwPxRIaFdxY3MjcTb66xWO+Osh8nmAMk0j4nYDAtVCPuJIu6LHPyVYzpguP1gCnfqfRMWfHa5VvcqrsPVbN1e3bwiAfuQoAQgpcM52WdldfJxntiuDma4D8rkNeWVVhlbGVAMCUZK74wW023tbr6127JUKqWQnXQzqOlmY4SrY6Kubru1JUdyodsHp0IKtrS08HqxENjq3GBMiaYIHGLukugi0dvigSgF/uAJwKuIxWboGar1VNkPoBSmtIm1ChvPOn6Q43F6zw6ZB8whBGhvQ+p2Oa1DuaupEDIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AJ/IgNhf5EI4OegLxEymFv/sPd68CCvtCfMSFFLXEc=;
 b=IyX7q9UgljjgN9VG2OFwMwj9c/xQ94+s4Eb5kByQLh2nSOT+kvfF4WFuKHYIq6PPf+nedZdMRbjkTjkDzK3Qhqc5CWT5dA5CC0GrU/iypHLQB4GCFlJXTtYo+xtOCBsqhprr2mAy8l48gZSjpYwqO2HnDaInPDJWm306NaQCIz4=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SN7PR13MB6278.namprd13.prod.outlook.com (2603:10b6:806:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18; Wed, 29 May
 2024 14:31:54 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 14:31:53 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"willy@infradead.org" <willy@infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>,
	"hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] nfs: Fix misuses of folio_shift() and folio_order()
Thread-Topic: [PATCH] nfs: Fix misuses of folio_shift() and folio_order()
Thread-Index: AQHasUKc4ahaFlEkLkmLY0OtD0xTmbGuR2CA
Date: Wed, 29 May 2024 14:31:53 +0000
Message-ID: <7984cbaa0104dcfa44892e12432c17f1bf0ceb87.camel@hammerspace.com>
References: <20240527163616.1135968-1-hch@lst.de>
	 <20240528210407.2158964-1-willy@infradead.org>
In-Reply-To: <20240528210407.2158964-1-willy@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SN7PR13MB6278:EE_
x-ms-office365-filtering-correlation-id: f1c59d44-ac1a-469b-3935-08dc7fec1613
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2VpbmxBUW9uSUNuRVVXbExidmRLaUxiQUJkWEY5SThoSUpFUzlYcnY0RUJy?=
 =?utf-8?B?UGhqTGo5b0E5ZDl0MW1zczJUaldQanFkcERjbDUzNnZvQTdLYkVhenRTWnJm?=
 =?utf-8?B?OU9NYWw3KzMrNlpXRzljeU9MY3NJTUJyS1pIUjVKaUp3QlMyYm9OY3l0cDY4?=
 =?utf-8?B?SWt0VXE4c2VycmsvTW9IY3NQYUJBbTlKTEdXOWd1aUNRMzAwYjR0Y0orOVBk?=
 =?utf-8?B?VGpWbVZDK3FhVFdhU2tOcDIxWUZsZmFkcEZTVnV0ZWJ4bDhtNVEzSkZJZ1Nt?=
 =?utf-8?B?SFM5dW1qeWM5K0crbktkaWVjU3Bia1hNNGJrdHlraXBybUpTU0RUbk0zUnFU?=
 =?utf-8?B?MEV4OEdXUVcveWp1cjQ2Yno3cnpqSjZDTkJOWHVuR2duTGMwakdBc1hYVHpX?=
 =?utf-8?B?bWhyY3V1eXZwRjlRaXdqdDBnZlBvdDBJME5GK3VEUFRjVGFlQ05lRlpQSGhK?=
 =?utf-8?B?aUgxSUd1d3VZd0hqRzRCWUhEK2RDWXR2cml4NTk1SXM3Zk9URVFLUkhPQ0wy?=
 =?utf-8?B?Qyt4Z251R3RjTkU3dmZuK25aVzJtMTVlN2VqYjl5YXZpRk1IUjI3UGhFcG9W?=
 =?utf-8?B?RzIvY2dMMkFCeTJRNGdhcHM2Y0pRdHRQcGxZTXAvNFZuNzlSd2xNNFFKekF1?=
 =?utf-8?B?YU1VcTlNN1lrSWdyanYrVldsaEJINFBTb2RJaXk1S3FxV1RXdjRleTdibVp5?=
 =?utf-8?B?WXZ0RGYxUHJVb1hqWGxUYXAyVTd4VU4zN0xsVlR4MSt0Z0plNWV5V2thY2kw?=
 =?utf-8?B?aURjTXljcnpIM0xybkFuYjRhMURic3VOZ1dwclAwODJoL1YvMHBXb1gvdldF?=
 =?utf-8?B?WHJNSWNzcDJVWktRSDZGVHpUc1NLUVVoWnZ0Qjczdm5uQ2FROGhyRXhZL2hJ?=
 =?utf-8?B?a1NqK0tKb3NLeVJyTzFuN1FlSUZxdnlWSEpwOXZGYkhGZDU4azV5K2pxRkQ1?=
 =?utf-8?B?N1ZybytXYmJkT1JxZnRTUGVXNFFnenBQZzFwVnUxTjd2Tk1wWEkvUm9DeVE3?=
 =?utf-8?B?clcyLzljWERKZUQwVlZFSjRuTk5HZWpJa0hnQ1lnbnhXdnY0Sk9UQTczL1d1?=
 =?utf-8?B?S1hQL2dDZjFkZ1hqRFA2SkRZK0tEV01lSzFtcnBJa2N3VmJMNExoZkdtK2VW?=
 =?utf-8?B?WHEvNktDcDFUMFR3RUxLdlFFVnJ5Nm4rbmZmZzVTcnlWOVFYSVdxOFRzQmEz?=
 =?utf-8?B?M3BkMG1mZlFmZ2dDbzViMU43Wi9FNTBCbGx1Zk5CeXN3MUQ5ZzBubDAxZ1Mz?=
 =?utf-8?B?SkdOeEFmNC96R1Z1cmdxWGZwNDl2endXalNFMkVoZ1lsTlZQVU1xbkNJdkpQ?=
 =?utf-8?B?V2ttQVEvMUd2eE4wcklaZWxEL0VQYVNvbkpJT0ttdGxKbFZpMklXU01JNWFw?=
 =?utf-8?B?cHpvUS9BRzlkYk5CSGNiUkdaRWErMnQ3bDR4enlBSFBoWDFIbXNYL2pESXVJ?=
 =?utf-8?B?MExsUnFQWnZjbzlmVGtLY092bUVSR2o5NlJBc1lrRnNTbmJKLzNtbkk2VW1D?=
 =?utf-8?B?TVZUR29rVm5jNzFKdTFzMUo4YVF5NUw0K0JpNXlJR3cxL0t6Yk9NWlVxa1BQ?=
 =?utf-8?B?T2F6NVVxcWJuUVFqbjVWRVp6UUxOckVPeFVpcjQ5NUp2ZFVBcElmLy8reHVy?=
 =?utf-8?B?a2lhUVdUem1GblJ0TzZYN3hGWlVCU0RZUDJFemJtTVJzblV6MGJZcDJHQ2Iy?=
 =?utf-8?B?UjdESzFONzJ5MndzS3d4T2JyN3BrQWZKd1VMdnpvSk5Xa2QzWWJpL0x3UE5P?=
 =?utf-8?B?ZHY2Q3ZVZjByVEtNVXR6SzBVaWJvVzh2SEVoaEFJcVduMGp2Z3FzRnMxK3c5?=
 =?utf-8?B?VFFza0ZSY05xOFF5eTl3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWNyWEgxWHdyWlowaE45VEovdVIwcXIyV1g2b0ZIN21JOEVCcGExaDMvR1k5?=
 =?utf-8?B?a0h4aXhSdXRib0h3MTBLR0RFZTlOdm5QNXJPODF3dDNGbmh3a1hrLy9XY0lu?=
 =?utf-8?B?WXZKYTVvaGNJZ0ZITnA1ZkJOamk4aEY0ZkJoRmFvcEcvVjFpQmJWaUg2eGti?=
 =?utf-8?B?Sy9TL21SK2t4UjhPN2hDbkc3Z3loUW1hL3A3NkdML3BWaVlhd1pqWGliN3Mr?=
 =?utf-8?B?ZHZMQUR2dHh6eitjUHRRNG1zcGd6VWtISjRHYk1qMW83TTVNMklXaGsxTFly?=
 =?utf-8?B?YmhFVUZWRENnRHUrZ0NYeTRCbXYyK2puL0J2RmRZV2JSdXZtcTRRT1I2WjRq?=
 =?utf-8?B?cXpsZ0tEWlJCUUk0RG5CeUpSTTN3ZnB5bCtYbzVVVDkvZldxdC9FdjZ4WU9s?=
 =?utf-8?B?a3Y3QmhhVUJ3V1B1VGtZanZYVzlZajloemhZdkZaRVovZzRjYnlFbVl5cWxF?=
 =?utf-8?B?czZwRHhIazJYUURDTTBIendCU3dCdUw1MllUeUdVdm15aTZ2Z3VHcDdKQkxR?=
 =?utf-8?B?L1hRc3RkbUJoVjNFQ3ZoY0p6b25JTWpTbHFmbFFWajZBU3FPZ1lWNTZaK3VZ?=
 =?utf-8?B?dFo5cnJjQ0NpRGtnQ1cyb25XcHNaMHY2WmVPTHUzTERLSFZoRTRSOXJmL2E4?=
 =?utf-8?B?aFpuLzRVREdRR1FndmVCVVZvVzZpdWZvVjFiUWh5dDRWM0ZHeUxsdGhPVFM0?=
 =?utf-8?B?YXVsVGRxOXcwdEJ4Q0doalVJQVdHekJZZ2xrOXpDcUFtZzIwdVZWQkVtQzd0?=
 =?utf-8?B?anN3SmdmeG56NXBJQkJseUozR1dLSzVSRmNKU2NLSWF5YkxVaHlaeEEzMVd3?=
 =?utf-8?B?NEZCTkRKR0lCbXZYaXQzY3VORWxvMWpXVmVMSGF4aHN0OXJOOFV5RXkrUkdk?=
 =?utf-8?B?MFRDdW1uVnpCWGxEcFc5R2lCWmkzTVBHbm1HelZtektpVEdqY3RBK3k3TGZH?=
 =?utf-8?B?bkM2UUlNZm1YdkxuWC9sVEhjaEd4Y1gvNEtSdXJaSlpZNG5ZQVd5NW95WkpV?=
 =?utf-8?B?WWZLK2xidXlnQWcwREh4MUU1RVpqZkI5MkRjKy9YWmJaaVhkdDdOcDhheGt3?=
 =?utf-8?B?YXFVRHgxNHpTK3Z0cHBVNktwWkZHMHRFejVWcGZhQlNTZ2NmVkZZaHgyY0RP?=
 =?utf-8?B?cWo4SFhHVG1lMWhoNmlNa0NQWkk2NFl2Y0xCU3BvZnpQcWZJRzBBQUlKQ05s?=
 =?utf-8?B?dXZ4bG9WOTlyWkVhSWtWRDNGejFWY29NR0JENndIck1aVlpZV1oxYjBiWk15?=
 =?utf-8?B?VkMzN0Y5ZDRoOFZvTkFCeGN6aUxndERBa2Z6bW15MDFCaU1XMGc0aTJDQU1u?=
 =?utf-8?B?YUlaNVJUN091RVp2dDNCeWRJUmsvVjdSMkJoeFpXTll0ejZwZXFDYlkvZTdH?=
 =?utf-8?B?UjJaTUhtTGZQVmV4bTB6ZWQ0VDBRUVlKd3JOTi9WODJ0SmJLbGRuak52S09r?=
 =?utf-8?B?MkcyZ3Zsb0QvNSsxbDJOZzFtU0ZXWnV5UWdoeEFFM1VlcGZkNzhvQ0NiTnR4?=
 =?utf-8?B?U21GcnpJcVd5T3hJMHNRMjFqVGtwNVFxSC9FcVVPTzE0b001U1JVWlc1eGtG?=
 =?utf-8?B?VUhucm5YRjVySTBPVFRrVEtmYzZZWGR5dnExeHo1MmxqOWhKcExXL1FFTFN2?=
 =?utf-8?B?b0svOGFLejJYcGQ2ZmVTMnVVU1NVRUVjSm8wYjFFREhtdkV5Vjg2RCtmZzBx?=
 =?utf-8?B?T2xMTUZCTS9EczBpK0Z6WFk0RmNTQmlTMnhoeHRRdXVSZWxCeDFRRUJUUDNx?=
 =?utf-8?B?SVNseDNLVG03a00rTi9KOWE4THRCWUZDa1g0dU5lZE5xWWFMempFVS9KU3dv?=
 =?utf-8?B?OEdnVlA2dnVzeHJJVTJkTkJwYjhIb0E5YlZNcHg4aW40UUtYNHMrQlV4RHRG?=
 =?utf-8?B?WkFSWXdzTWY4ZWFjV28rWkZDVk1ZL2tVeGRFZjduUmc4Qk9CNDhvd1pBckFh?=
 =?utf-8?B?M2RSUXJJeUo2d2p2OVYvT1Z0ZkYxc1p6MnZjRmJqZzZxNHZXbkswaUY1YVBi?=
 =?utf-8?B?SXdKbG05V2ZOU3BZa2dMRXUyY3ozNjk0NzhzU3RHcjMzS2tKcHczY0xwcnlH?=
 =?utf-8?B?UnZWZCtkTzVRaXByRWtqSlZWNG16ZTBxYXdRTmEza0wxejl5dmJlK0ZGZVY3?=
 =?utf-8?B?MStwVmZ5SXJJNE55a2lzSzBlMXB0cjZGWEpITFprSXNpOHhDTXdVTklHTm1q?=
 =?utf-8?B?YzFrbFdGRWtrdGc2eUNkN3dEbncvMlA2a3d4T0JSS0lWN3NpMmtsdlFFT0p6?=
 =?utf-8?B?N0Mwbmk3UlYwaVNNSy9WT1R4Q0p3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AF88275A498E64293BA3B55670A2551@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c59d44-ac1a-469b-3935-08dc7fec1613
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 14:31:53.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r48icFfA719NQt8hW2MV/1GbtjQQEfAd+Fa6+suVx4ghFFFp41Kg/+SlaxL5OCkBERm5uvZziprr+b0RRNm7OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6278

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDIyOjAzICswMTAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gUGFnZSBjYWNoZSBpbmRpY2VzIGFyZSBpbiB1bml0cyBvZiBQQUdFX1NJWkUs
IG5vdCBpbiB1bml0cyBvZg0KPiB0aGUgZm9saW8gc2l6ZS7CoCBSZXZlcnQgdGhlIGNoYW5nZSBp
biBuZnNfZ3Jvd19maWxlKCksIGFuZA0KPiBwYXNzIHRoZSBpbm9kZSB0byBuZnNfZm9saW9fbGVu
Z3RoKCkgc28gaXQgY2FuIGJlIHJlaW1wbGVtZW50ZWQNCj4gaW4gdGVybXMgb2YgZm9saW9fbWt3
cml0ZV9jaGVja190cnVuY2F0ZSgpIHdoaWNoIGhhbmRsZXMgdGhpcw0KPiBjb3JyZWN0bHkuDQoN
CkZvciB0aGUgcmVjb3JkLCB0aGUgY29kZSBiZWluZyByZXBsYWNlZCBoZXJlIGlzIG5vdCBhc3N1
bWluZyB0aGF0IHBhZ2UNCmNhY2hlIGluZGljZXMgYXJlIGluIHVuaXRzIG9mIHRoZSBmb2xpbyBz
aXplLiBJdCBpcyBhc3N1bWluZyB0aGF0IGZvbGlvDQpib3VuZGFyaWVzIHdpbGwgbGllIG9uIG9m
ZnNldHMgdGhhdCBhcmUgbXVsdGlwbGVzIG9mIHRoZSBmb2xpbyBzaXplIGFuZA0KdGhhdCB0aGUg
Y3VycmVudCBwYWdlIGF0dHJpYnV0ZXMgKHBhZ2UgbG9jaywgdXB0b2RhdGUsIGV0YykgYXJlDQpl
eHBlY3RlZCB0byBhcHBseSB0byB0aGUgZGF0YSB0aGF0IGxpZXMgd2l0aGluIHRob3NlIGZvbGlv
IGJvdW5kYXJpZXMuDQpUaGUgd2F5IHRoZSBmb2xpbyBjb2RlIGlzIHdyaXR0ZW4gdG9kYXksIHRo
YXQgYXNzdW1wdGlvbiBhcHBlYXJzIHRvIGJlDQpjb3JyZWN0Lg0KDQpJJ20gZmluZSB3aXRoIHJl
cGxhY2luZyBORlMtc3BlY2lmaWMgY29kZSB3aXRoIGdlbmVyaWMgY29kZSB3aGVuDQpvYnZpb3Vz
bHkgY29ycmVjdCwgYnV0IEFGQUlDUyB0aGlzIHdvdWxkIGJlIGEgY2xlYW51cCwgYW5kIG5vdCBh
IGJ1Zw0KZml4Lg0KDQo+IA0KPiBGaXhlczogMGM0OTNiNWNmMTZlICgiTkZTOiBDb252ZXJ0IGJ1
ZmZlcmVkIHdyaXRlcyB0byB1c2UgZm9saW9zIikNCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBX
aWxjb3ggKE9yYWNsZSkgPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IENjOiBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+IENjOiBBbm5hIFNjaHVtYWtl
ciA8QW5uYS5TY2h1bWFrZXJATmV0YXBwLmNvbT4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4NCj4gLS0tDQo+IMKgZnMvbmZzL2ZpbGUuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCA2ICsrKy0tLQ0KPiDCoGZzL25mcy9pbnRlcm5hbC5owqDCoMKgwqDCoMKgIHwg
MTYgKysrKystLS0tLS0tLS0tLQ0KPiDCoGZzL25mcy9yZWFkLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMiArLQ0KPiDCoGZzL25mcy93cml0ZS5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA5ICsr
KysrLS0tLQ0KPiDCoGluY2x1ZGUvbGludXgvcGFnZW1hcC5oIHzCoCA0ICsrLS0NCj4gwqA1IGZp
bGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2ZzL25mcy9maWxlLmMgYi9mcy9uZnMvZmlsZS5jDQo+IGluZGV4IDZiZDEyN2U2
NjgzZC4uNzIzZDc4YmJmZTNmIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZmlsZS5jDQo+ICsrKyBi
L2ZzL25mcy9maWxlLmMNCj4gQEAgLTMwMSw3ICszMDEsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChu
ZnNfZmlsZV9mc3luYyk7DQo+IMKgc3RhdGljIGJvb2wgbmZzX2ZvbGlvX2lzX2Z1bGxfd3JpdGUo
c3RydWN0IGZvbGlvICpmb2xpbywgbG9mZl90IHBvcywNCj4gwqAJCQkJwqDCoMKgIHVuc2lnbmVk
IGludCBsZW4pDQo+IMKgew0KPiAtCXVuc2lnbmVkIGludCBwZ2xlbiA9IG5mc19mb2xpb19sZW5n
dGgoZm9saW8pOw0KPiArCXVuc2lnbmVkIGludCBwZ2xlbiA9IG5mc19mb2xpb19sZW5ndGgoZm9s
aW8sIGZvbGlvLT5tYXBwaW5nLQ0KPiA+aG9zdCk7DQo+IMKgCXVuc2lnbmVkIGludCBvZmZzZXQg
PSBvZmZzZXRfaW5fZm9saW8oZm9saW8sIHBvcyk7DQo+IMKgCXVuc2lnbmVkIGludCBlbmQgPSBv
ZmZzZXQgKyBsZW47DQo+IMKgDQo+IEBAIC0zODYsNyArMzg2LDcgQEAgc3RhdGljIGludCBuZnNf
d3JpdGVfZW5kKHN0cnVjdCBmaWxlICpmaWxlLA0KPiBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFw
cGluZywNCj4gwqAJICovDQo+IMKgCWlmICghZm9saW9fdGVzdF91cHRvZGF0ZShmb2xpbykpIHsN
Cj4gwqAJCXNpemVfdCBmc2l6ZSA9IGZvbGlvX3NpemUoZm9saW8pOw0KPiAtCQl1bnNpZ25lZCBw
Z2xlbiA9IG5mc19mb2xpb19sZW5ndGgoZm9saW8pOw0KPiArCQl1bnNpZ25lZCBwZ2xlbiA9IG5m
c19mb2xpb19sZW5ndGgoZm9saW8sIG1hcHBpbmctDQo+ID5ob3N0KTsNCj4gwqAJCXVuc2lnbmVk
IGVuZCA9IG9mZnNldCArIGNvcGllZDsNCj4gwqANCj4gwqAJCWlmIChwZ2xlbiA9PSAwKSB7DQo+
IEBAIC02MTAsNyArNjEwLDcgQEAgc3RhdGljIHZtX2ZhdWx0X3QgbmZzX3ZtX3BhZ2VfbWt3cml0
ZShzdHJ1Y3QNCj4gdm1fZmF1bHQgKnZtZikNCj4gwqANCj4gwqAJZm9saW9fd2FpdF93cml0ZWJh
Y2soZm9saW8pOw0KPiDCoA0KPiAtCXBhZ2VsZW4gPSBuZnNfZm9saW9fbGVuZ3RoKGZvbGlvKTsN
Cj4gKwlwYWdlbGVuID0gbmZzX2ZvbGlvX2xlbmd0aChmb2xpbywgaW5vZGUpOw0KPiDCoAlpZiAo
cGFnZWxlbiA9PSAwKQ0KPiDCoAkJZ290byBvdXRfdW5sb2NrOw0KPiDCoA0KPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzL2ludGVybmFsLmggYi9mcy9uZnMvaW50ZXJuYWwuaA0KPiBpbmRleCA5ZjBmNDUz
NDc0NGIuLjNiMDIzNmU2NzI1NyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2ludGVybmFsLmgNCj4g
KysrIGIvZnMvbmZzL2ludGVybmFsLmgNCj4gQEAgLTgxOSwxOSArODE5LDEzIEBAIHVuc2lnbmVk
IGludCBuZnNfcGFnZV9sZW5ndGgoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+IMKgLyoNCj4gwqAgKiBE
ZXRlcm1pbmUgdGhlIG51bWJlciBvZiBieXRlcyBvZiBkYXRhIHRoZSBwYWdlIGNvbnRhaW5zDQo+
IMKgICovDQo+IC1zdGF0aWMgaW5saW5lIHNpemVfdCBuZnNfZm9saW9fbGVuZ3RoKHN0cnVjdCBm
b2xpbyAqZm9saW8pDQo+ICtzdGF0aWMgaW5saW5lIHNpemVfdCBuZnNfZm9saW9fbGVuZ3RoKHN0
cnVjdCBmb2xpbyAqZm9saW8sIHN0cnVjdA0KPiBpbm9kZSAqaW5vZGUpDQo+IMKgew0KPiAtCWxv
ZmZfdCBpX3NpemUgPSBpX3NpemVfcmVhZChmb2xpb19maWxlX21hcHBpbmcoZm9saW8pLQ0KPiA+
aG9zdCk7DQo+ICsJc3NpemVfdCByZXQgPSBmb2xpb19ta3dyaXRlX2NoZWNrX3RydW5jYXRlKGZv
bGlvLCBpbm9kZSk7DQo+IMKgDQo+IC0JaWYgKGlfc2l6ZSA+IDApIHsNCj4gLQkJcGdvZmZfdCBp
bmRleCA9IGZvbGlvX2luZGV4KGZvbGlvKSA+Pg0KPiBmb2xpb19vcmRlcihmb2xpbyk7DQo+IC0J
CXBnb2ZmX3QgZW5kX2luZGV4ID0gKGlfc2l6ZSAtIDEpID4+DQo+IGZvbGlvX3NoaWZ0KGZvbGlv
KTsNCj4gLQkJaWYgKGluZGV4IDwgZW5kX2luZGV4KQ0KPiAtCQkJcmV0dXJuIGZvbGlvX3NpemUo
Zm9saW8pOw0KPiAtCQlpZiAoaW5kZXggPT0gZW5kX2luZGV4KQ0KPiAtCQkJcmV0dXJuIG9mZnNl
dF9pbl9mb2xpbyhmb2xpbywgaV9zaXplIC0gMSkgKw0KPiAxOw0KPiAtCX0NCj4gLQlyZXR1cm4g
MDsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0ID0gMDsNCj4gKwlyZXR1cm4gcmV0Ow0KPiDC
oH0NCj4gwqANCj4gwqAvKg0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3JlYWQuYyBiL2ZzL25mcy9y
ZWFkLmMNCj4gaW5kZXggYTE0MjI4N2Q4NmY2Li5iYTNiYjQ5NmY4MzIgMTAwNjQ0DQo+IC0tLSBh
L2ZzL25mcy9yZWFkLmMNCj4gKysrIGIvZnMvbmZzL3JlYWQuYw0KPiBAQCAtMjk2LDcgKzI5Niw3
IEBAIGludCBuZnNfcmVhZF9hZGRfZm9saW8oc3RydWN0DQo+IG5mc19wYWdlaW9fZGVzY3JpcHRv
ciAqcGdpbywNCj4gwqAJdW5zaWduZWQgaW50IGxlbiwgYWxpZ25lZF9sZW47DQo+IMKgCWludCBl
cnJvcjsNCj4gwqANCj4gLQlsZW4gPSBuZnNfZm9saW9fbGVuZ3RoKGZvbGlvKTsNCj4gKwlsZW4g
PSBuZnNfZm9saW9fbGVuZ3RoKGZvbGlvLCBpbm9kZSk7DQo+IMKgCWlmIChsZW4gPT0gMCkNCj4g
wqAJCXJldHVybiBuZnNfcmV0dXJuX2VtcHR5X2ZvbGlvKGZvbGlvKTsNCj4gwqANCj4gZGlmZiAt
LWdpdCBhL2ZzL25mcy93cml0ZS5jIGIvZnMvbmZzL3dyaXRlLmMNCj4gaW5kZXggMjMyOWNiYjBl
NDQ2Li43NzEzY2U3YzViM2EgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy93cml0ZS5jDQo+ICsrKyBi
L2ZzL25mcy93cml0ZS5jDQo+IEBAIC0yNzgsOCArMjc4LDggQEAgc3RhdGljIHZvaWQgbmZzX2dy
b3dfZmlsZShzdHJ1Y3QgZm9saW8gKmZvbGlvLA0KPiB1bnNpZ25lZCBpbnQgb2Zmc2V0LA0KPiDC
oA0KPiDCoAlzcGluX2xvY2soJmlub2RlLT5pX2xvY2spOw0KPiDCoAlpX3NpemUgPSBpX3NpemVf
cmVhZChpbm9kZSk7DQo+IC0JZW5kX2luZGV4ID0gKChpX3NpemUgLSAxKSA+PiBmb2xpb19zaGlm
dChmb2xpbykpIDw8DQo+IGZvbGlvX29yZGVyKGZvbGlvKTsNCj4gLQlpZiAoaV9zaXplID4gMCAm
JiBmb2xpb19pbmRleChmb2xpbykgPCBlbmRfaW5kZXgpDQo+ICsJZW5kX2luZGV4ID0gKGlfc2l6
ZSAtIDEpID4+IFBBR0VfU0hJRlQ7DQo+ICsJaWYgKGlfc2l6ZSA+IDAgJiYgZm9saW8tPmluZGV4
IDwgZW5kX2luZGV4KQ0KPiDCoAkJZ290byBvdXQ7DQo+IMKgCWVuZCA9IGZvbGlvX2ZpbGVfcG9z
KGZvbGlvKSArIChsb2ZmX3Qpb2Zmc2V0ICsNCj4gKGxvZmZfdCljb3VudDsNCj4gwqAJaWYgKGlf
c2l6ZSA+PSBlbmQpDQo+IEBAIC0zNTgsNyArMzU4LDggQEAgbmZzX3BhZ2VfZ3JvdXBfc2VhcmNo
X2xvY2tlZChzdHJ1Y3QgbmZzX3BhZ2UNCj4gKmhlYWQsIHVuc2lnbmVkIGludCBwYWdlX29mZnNl
dCkNCj4gwqAgKi8NCj4gwqBzdGF0aWMgYm9vbCBuZnNfcGFnZV9ncm91cF9jb3ZlcnNfcGFnZShz
dHJ1Y3QgbmZzX3BhZ2UgKnJlcSkNCj4gwqB7DQo+IC0JdW5zaWduZWQgaW50IGxlbiA9IG5mc19m
b2xpb19sZW5ndGgobmZzX3BhZ2VfdG9fZm9saW8ocmVxKSk7DQo+ICsJc3RydWN0IGZvbGlvICpm
b2xpbyA9IG5mc19wYWdlX3RvX2ZvbGlvKHJlcSk7DQo+ICsJdW5zaWduZWQgaW50IGxlbiA9IG5m
c19mb2xpb19sZW5ndGgoZm9saW8sIGZvbGlvLT5tYXBwaW5nLQ0KPiA+aG9zdCk7DQo+IMKgCXN0
cnVjdCBuZnNfcGFnZSAqdG1wOw0KPiDCoAl1bnNpZ25lZCBpbnQgcG9zID0gMDsNCj4gwqANCj4g
QEAgLTEzNTYsNyArMTM1Nyw3IEBAIGludCBuZnNfdXBkYXRlX2ZvbGlvKHN0cnVjdCBmaWxlICpm
aWxlLCBzdHJ1Y3QNCj4gZm9saW8gKmZvbGlvLA0KPiDCoAlzdHJ1Y3QgbmZzX29wZW5fY29udGV4
dCAqY3R4ID0gbmZzX2ZpbGVfb3Blbl9jb250ZXh0KGZpbGUpOw0KPiDCoAlzdHJ1Y3QgYWRkcmVz
c19zcGFjZSAqbWFwcGluZyA9IGZvbGlvX2ZpbGVfbWFwcGluZyhmb2xpbyk7DQo+IMKgCXN0cnVj
dCBpbm9kZSAqaW5vZGUgPSBtYXBwaW5nLT5ob3N0Ow0KPiAtCXVuc2lnbmVkIGludCBwYWdlbGVu
ID0gbmZzX2ZvbGlvX2xlbmd0aChmb2xpbyk7DQo+ICsJdW5zaWduZWQgaW50IHBhZ2VsZW4gPSBu
ZnNfZm9saW9fbGVuZ3RoKGZvbGlvLCBpbm9kZSk7DQo+IMKgCWludAkJc3RhdHVzID0gMDsNCj4g
wqANCj4gwqAJbmZzX2luY19zdGF0cyhpbm9kZSwgTkZTSU9TX1ZGU1VQREFURVBBR0UpOw0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wYWdlbWFwLmggYi9pbmNsdWRlL2xpbnV4L3BhZ2Vt
YXAuaA0KPiBpbmRleCBjNmFhY2VlZDBkZTYuLmRmNTdkNzM2MWE5YSAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC9wYWdlbWFwLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9wYWdlbWFwLmgN
Cj4gQEAgLTIxMiw4ICsyMTIsOCBAQCBlbnVtIG1hcHBpbmdfZmxhZ3Mgew0KPiDCoAlBU19GT0xJ
T19PUkRFUl9NQVggPSAyMSwgLyogQml0cyAxNi0yNSBhcmUgdXNlZCBmb3INCj4gRk9MSU9fT1JE
RVIgKi8NCj4gwqB9Ow0KPiDCoA0KPiAtI2RlZmluZSBBU19GT0xJT19PUkRFUl9NSU5fTUFTSyAw
eDAwMWYwMDAwDQo+IC0jZGVmaW5lIEFTX0ZPTElPX09SREVSX01BWF9NQVNLIDB4MDNlMDAwMDAN
Cj4gKyNkZWZpbmUgQVNfRk9MSU9fT1JERVJfTUlOX01BU0sgKDMxIDw8IEFTX0ZPTElPX09SREVS
X01JTikNCj4gKyNkZWZpbmUgQVNfRk9MSU9fT1JERVJfTUFYX01BU0sgKDMxIDw8IEFTX0ZPTElP
X09SREVSX01BWCkNCj4gwqAjZGVmaW5lIEFTX0ZPTElPX09SREVSX01BU0sgKEFTX0ZPTElPX09S
REVSX01JTl9NQVNLIHwNCj4gQVNfRk9MSU9fT1JERVJfTUFYX01BU0spDQo+IMKgDQo+IMKgLyoq
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

