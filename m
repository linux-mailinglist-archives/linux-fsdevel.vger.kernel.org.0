Return-Path: <linux-fsdevel+bounces-53063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFBAE9790
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3298C3ABBF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2625CC47;
	Thu, 26 Jun 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="al32rmUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B025BF08
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925365; cv=fail; b=JF4/m+h9jtD4AVehqxK/OpOwiQaJY5aujdwtGpVgqT+F5lsTQZq2YUv0WicuInwSrWXT5bYift1hmtEI2d6rWUKnb2vt9zWSmmkrqJKhaJS2zYqSrP8cX8OC4ejh3/oLo+Bs8QEXfswWIH6djS4q3061kOJjDkABeuaTO39Lss8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925365; c=relaxed/simple;
	bh=wbLfFNrBy73+2YmvB8akdpYZS8l5xHpZOiz7Y9J73IY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qlO81OXd11C6NYvh9h92e6YQIJNUHc2mGauiFon50wR4F+5vPlQ6kIIcWUGdjvSFWx3b+sgnVU8zs7xA3z2ebQW8Z52CCqM7p38cBH9TaVb5I3/MMxJlqVs/c8kmrjOunN0/snxsTWFj1lX82pf7lrJeLZ5R06B31NSwMNxozZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=al32rmUJ; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzKoln2Wt+FuivDpF8QGJm9XHGDWJLJo1dJusMbsZjum+PLFZi5isAFJepwHKHf/dwzx0oVBYEhXHvBrNMFAMGYRFwnmv/wzYguwGPtQqajlwYl8mwl5h1PyxWwyu/1QQdJ6P3efN0826lc17tlEBmwYWElotEMiDum476yiwV1/yB2xAiVMirk91I2ml6TLMzKyF0+6Xhv8P4jw/5bdUBFGY1ooT7yQeJdphcqywoT/rk7hbJXRTg4B4o8c+2S8ZFKzrmZXJXIqthYcpYcV+enoFBwzI+t9Zi5DtOQDw3MLCOCI0ZGBD6elfopIZUX+rb5/bYbTA7X4lRX4l9rmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbLfFNrBy73+2YmvB8akdpYZS8l5xHpZOiz7Y9J73IY=;
 b=AvsGepiNpUyglcxE4v/cOnLhltx0aGFVvlA1JnSLemp+g2P4vwDYKGxLXygnLiBtUPAr2FkY5fvjnOhWah4V3SYaPyHbyCgm2XLxP/i8bR7VNf6sJaXEKdNxFABBxx5X056byNS+yirgfWQcSNrCkMic5nKhk2VlnPikLckAgHMW42sNa/tm3NmGpL5FGPENHTL8ypFgo9M8vDEcwrn8GWcrixWbPnXQcex6IGGbDS5nnGpLNmx1rWJHwpjeasTzg7KmAqCIkoMBMNkthtS+1cd40xLvZOmCpO4+61+JRlds7tCC8pE2YQYkWNfLql05Ddu/u9VE9FiHA+50WG45wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbLfFNrBy73+2YmvB8akdpYZS8l5xHpZOiz7Y9J73IY=;
 b=al32rmUJvdcUzOpNqQu3+CwCts5JKIbAprb+M+P2jgNjikH8278WlGlcD/3gVj6QwjZNpsA8n6C07sMy7yv3fA52ivyPTpHMuXoZb0v0ucXnpNMqbopLRqTcU75ZdlfnSED89hQyHE8NJ0paq0bKiDdp5xxkMwf/pd3FyQJ1MIdlgiEligqrfWhwZFQ7NdT713HhSx/epd5MyF2uPWycFODvm0U64E6yzY6PbR6ZBvComvQ9+t6HJOW0UT1A/63tkcbnfZU6VKknqjTIji8DNlJyp4VkrKTVlh8wY7ACxqitgBoiTcvZ/9t6EW7I7YM7rZjxmmrkNmcOkkfR1EL3gQ==
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com (2603:10a6:20b:16::28)
 by DU0PR07MB8395.eurprd07.prod.outlook.com (2603:10a6:10:352::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 08:09:18 +0000
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f]) by AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:09:18 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Phillip Lougher
	<phillip@squashfs.org.uk>
Subject: squashfs can starve/block apps
Thread-Topic: squashfs can starve/block apps
Thread-Index: AQHb5nGdF4RIk2KD1kCWx8Hz+RNSlw==
Date: Thu, 26 Jun 2025 08:09:18 +0000
Message-ID: <bd03e4e1d56d67644b60b2a58e092a0e3fdcff57.camel@nokia.com>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4549:EE_|DU0PR07MB8395:EE_
x-ms-office365-filtering-correlation-id: 1a93875c-3592-42d1-9a83-08ddb488c014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eExoQVpKT0ZUVW9xcEJoN1A4RjdLZTFURUc2WFdEMG4xL0poYk40S0NSTmhZ?=
 =?utf-8?B?bkh6VTNzdnIzaUxSNjVLNUJaTVd6ZzdVTmJvSmpJLzA4NlVFQjBESlNvbTQv?=
 =?utf-8?B?ZGhpaTFHcmx6MFJKQUZ3TXhvL0pxR0cvZmRreDQzRnAycklMcmwyVm1lRDBi?=
 =?utf-8?B?Tk5uZi9hcDRVckZpTlU3UlcxdnhITncyMVNoZWY0MTBWNGZGR1U3ekpYWGI2?=
 =?utf-8?B?Z1RieVU3T251bFpxYU5uQVl5ZzFodytzaTBvMjVnRUdRQmh4R1hydU5QUTBQ?=
 =?utf-8?B?RUxUWTBNZERzS0hBSk8xMC8rSXdDcHpkMW9xVXhMNURuNklicCs4MnRDUGN2?=
 =?utf-8?B?S25vR0tJYThWVzdEeW8yTkxWK1hieGk4bE4zRWp6SFdxZ2l4Wk81dDdZNzMy?=
 =?utf-8?B?bk90aEptTUNBSVlqYlBHeHV6YndrK3BveHpEOXU2RUp3bFpnSWpLdjArOGdY?=
 =?utf-8?B?WnJ6UGhXM3hEYWtESG9CcHIvUHdTem5ML0RaRDlOcXBRNW9pQ04zSHhZUGdP?=
 =?utf-8?B?OVlTYnIwZFYzeFU4UVRDeDU4bTlNRkZtYzNNbGRuVkRWMlFXRk8yOHhqdVk1?=
 =?utf-8?B?SS95azFmcjJlS1dlK0gwWnVDMm8rQTFqb05xc242aU91TUVLeVRKenJ5a0JW?=
 =?utf-8?B?emtWNFYvTldYbURFUHRrSnRyWWxGckdicEkwV296MHlUVER3VXZhcmM0cmRs?=
 =?utf-8?B?RVZOSSsyZzNtQnJmVXJqdi9lSFlnQWpHR1JiakJnMG5ubWx4cGpQanlTNDlF?=
 =?utf-8?B?eVFXMkVQRmtZNDU4YThFZmZnOS9ERnFCWlpuTURmSGN0SjhrZVZWVlNZUnNm?=
 =?utf-8?B?R0pESkZSZHFVbWI3ZjMyR1V6UTkyVDdpV2k5VTV0cjFNN2R4bUtUOHllK3gv?=
 =?utf-8?B?UkUvVzVmMlR4L2JhaGFwc3JEaG1Pejhxc2NjSTI3eUYyRW1vNVI4SlI1cC8y?=
 =?utf-8?B?bjU4QXZabU5GOExMRXZKOUx5QSt0Z3hiRnlFeERpZWhUTS9FbVkrL0hPTTdk?=
 =?utf-8?B?NWp3MGZRbUlBSXA3N3FaWm8zQnpEcHRVY2svTnJiTENxY3R1Z0hCbVM3V2FD?=
 =?utf-8?B?TEErU3J0Q2lTMU9wd0pDNjZTbXBnWUV5aTJlNS9GYkdBd1RtSzlBcjR3TzBB?=
 =?utf-8?B?bnBLK295K0lINmJRZC9XQ05ZWllvRkJnWG5KUTAzUjJQTFNkUlBycjZ1Myt5?=
 =?utf-8?B?RHpYdkhJK3JxZFY0ejZCYzNqZ3M5M1RNVDIyVmtsOFBZMnlJcWZMcTlaakJZ?=
 =?utf-8?B?K0hVRWgyN0IwbXUrR2gyU2tWbFl5cG5TcjlZTW9oMEYzMGplVnEzTVA0c0lC?=
 =?utf-8?B?RnpnSERtWjA5eldFNThrV2Rsc0I4eE5DaDNLc2VwMzlGUUhoUkJjbUt2ai95?=
 =?utf-8?B?UXR6amZyWGdCVUNHcHMrVm5md21uNEw4aTd1ekJBNE1qLzNBWlJKN0hIYUov?=
 =?utf-8?B?NTNCWU5iTW9hY2JvWlNHQ1dFYlZiODA5OXZYcnRtQ0FORHNrNXAzaXBuVExN?=
 =?utf-8?B?VjlwQjRmQ0w5NVF0ajJVSnhpOVpWdmdFTDJSQVp0Q28rZTJDZE5nUndxV0xr?=
 =?utf-8?B?MExoR1hmb2l2blRZRHZSVU9vK2o1Z0ZiTVNCV0VxSmU4ZThjN0kyVUtCWHMz?=
 =?utf-8?B?elQwSHJycEtlSVVydEdCc0lKOVVCY29RV0N1RitZY2hiSkVQMWc2cldwTWJQ?=
 =?utf-8?B?U3RYU3puM0NZamliekdIZHZROEc0aUhsLzJmSy9ETEFrWXZvc0tCSVQ0MXdR?=
 =?utf-8?B?dXFMZTFtMEV6aFJqeEZoMWFRRGtkN0M0cU5Xc01CSFpQRFJvOGlHOEljeHdJ?=
 =?utf-8?B?Wm1hT09MU3RKY3F1RnhmZDRHNER0MlJxbDMxS3A0ZllwVzkxdEN3aTVwNGxI?=
 =?utf-8?B?b2pTbWFlTkhFbG14RG1YN1E4c3A0OWgrWG14MlNJVDBwbCs4clU2WlhZMkFC?=
 =?utf-8?B?cWkvdDgvMUFKZlpyajJWS2I5dnh1d09TdWFZZjVsZG5zNmhGcmJHUDd3aWdB?=
 =?utf-8?B?Y3F6S01XTDFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4549.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDZTRzhqRFhmZ3dBeEY3OVBkZnJvZkNHVlNOK2JSV0lNRHRabndtaWJiNE13?=
 =?utf-8?B?V3Vib3VkWUY3LzVpekhTMTN6blluUXNmWW1WV1lFa0MxVE5sa3Y5K3dkQzdK?=
 =?utf-8?B?Mk9TVWhydEQzVlcxUUF5M3pwb1gvU0xpbTNVdjN6eldhTG5FOWk4UmpFRXZr?=
 =?utf-8?B?Q0Mvd0djbXhVRHVjYlArSU1wbzVLYXN3Z3hjK0k5YnMzejMvdTduN1o1RmN4?=
 =?utf-8?B?Ry8xWXZqaUpoOWtNV2pqQTBlcHJQRGR6RFFnQkhPYkgrZm5jYVdNTFFDODBQ?=
 =?utf-8?B?UlAvVEl5aGV1MUNvZENMQmYwVVhJaEMrZWFKNmdGVFlLWkVmYTd1SnFuQlJn?=
 =?utf-8?B?K3ErL0h5RStUMC8wdXFtQ1NtZ2xqOWZORmUrY3hCSHJWNUxRbnFQc3VZRVY2?=
 =?utf-8?B?dUhJdjZSWUYxT2Z3V0NjcVdMejE5aFVIR3FLWTQ2dFBSMy9uZUdad0VTQkFo?=
 =?utf-8?B?UkU5ZjVIZk1peGFuM1VFMHI2ai9WZEZPUFEzZ0NxbFdOaDREV0F5TDVLNmt0?=
 =?utf-8?B?RVhwZmR1bVFNZCs2YW03ZkU5cHFCdlY0S3d6ZHNIRkJ6NUtFZ3VtUlJRVkcr?=
 =?utf-8?B?a0RnMjBwMStMU2NLdUdFVU1SR1NndUVORmdRRm9YUktpWFNmU3VqVzcyaU1I?=
 =?utf-8?B?QmJjQm1hOTJGazUzVThSQ09HN3puVmJPTHNYUUgrRldrTGZySU40eHhoOFJj?=
 =?utf-8?B?Mi8vM1M1c016SStQRlFUQ1EwbTIzdVFZdmJzdHFNUmxyMVRraFQ5amNTZFNm?=
 =?utf-8?B?ZmozQU5VZlNtZHBXVENJa29TY29qTXZmNzREM21KNkx3dW1ieXRlSmozZlo1?=
 =?utf-8?B?U1hvdnVjVWV4bm1udWZ0S1JXL1V0NmlhQWZQdDlURmJxVi91KzVpVSticVEr?=
 =?utf-8?B?cUdVR3pmZmQxb1R6SFQrQXlHVkMwTEZHRFp1c1hsa2p1YVAycU9BdExQUVNl?=
 =?utf-8?B?OGtzWnRwZlE0Rmg1aDU1OHd3NDlqZnJPd1Q3TndqMUMwSTNva1FTRnZ2c3dw?=
 =?utf-8?B?ZUhHaWdZOWNCVkNpUzJYV1MvUWlkUUUxMkkzdTg2NXp4VzVHZGN6eG95MWN2?=
 =?utf-8?B?OWRNbURaSzFWU0NrWXRmZ2ExWHlNZEpDV29iS0pvYXBPRWt6NnUzTzFieGxj?=
 =?utf-8?B?ZnlJSDc0bmRablZrckE1bkNmYnJXcjhqbytRbk5pWlU2dUx3VThpZE9yek5Z?=
 =?utf-8?B?VksxQWZaZHhlTTl5MFFNNHlCV1M0ZFBsQTRaTUJYV09adWwrNWlTQWU0bHFj?=
 =?utf-8?B?NmZ3OFVSQ1BGbncrOGJpLzBVT0d3TG5BeE9tamVOczNwZVVkZ3NtbjFHdjd6?=
 =?utf-8?B?cmx0VWpRd0NhU294TWhXZGpIOUtyK3J2NEwwa1cxeDh5dHVzY2xqQUJRUkxG?=
 =?utf-8?B?ZDgwWVhmMUl1UnQvZlpyRzBGMTRmUUpHZ1BOdDY3c3ZqdWR1RDJJZVIveTB0?=
 =?utf-8?B?NE5va2x1S0dDYURvTjlNd25PalhwaFRJT093NVFiRGhhVmU3cDd3UFJ1Mmxh?=
 =?utf-8?B?bjkvdS9WNTlXL0t6RlI3VW1jTHBvZE9tRi8vNUZ2SHNyNzRqL1d6anRyeVJE?=
 =?utf-8?B?QlQySDAyMnNOaHBONUdKNjVRVksyN3B6aFVocUFiWmFVR2hrVmx5V0llTmR2?=
 =?utf-8?B?cW1vb0lFUEFsNzVZTUFOL1RXbzFtWEpPa1ZTWndnSkVDbkFRQkNuR0RZNVNI?=
 =?utf-8?B?bjRwdGFZUmNkeXpSekp0K2xNY1F0emlWK3BTZ3Fmd21iUE93SmdxQ1E5aE9L?=
 =?utf-8?B?dWN0VmdBWGtWUmIraC9CazdHbkdPaUxoaE1iYjZ4eGFIL3cwVE1rNHpadTN5?=
 =?utf-8?B?VXVETFRMcVhXTml4Y0s4SmlPT1pVRVZEYmd6dmR0czUwWjhNSjBtYVJZa3N6?=
 =?utf-8?B?bzZqUjVJeVVaeEZHUnJlb0dZcEdzamlzVEpLd1kyYloyclNPMU4xYzRQT21s?=
 =?utf-8?B?aWE0S1dUSzZyWWE1OUxudnlQbDZEV2o1aUJXUE8vbVcwdGpmMlM2MDErN3h2?=
 =?utf-8?B?QzB2NFhXcHYwbVdKY2U4bFI2ZW5GUW5uaGpOYVJJK2lzbllUenM2RXVLYTdG?=
 =?utf-8?B?Vy9Dc0NCbVltbEdJV09oc0crNFljMS93VnVQdUV5dVVSSFI0ZTJDSklzWkpq?=
 =?utf-8?Q?JUk3O/D61958nftS0EkOrvhXL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7EA1D2BAF584A4D81350DA0D4E3D1A9@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4549.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a93875c-3592-42d1-9a83-08ddb488c014
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:09:18.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sUr8w2DwkMeYhGqI62brrAdBI0kiWmjWMeJ1CmM4VAAiRfwtScnL5KbG2hNJSHLxx0eSEUygmt2neWdIRnQgrFbD9yH/Pue29FlzBXrbh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8395

V2UgaGF2ZSBhbiBhcHAgcnVubmluZyBvbiBhIHNxdWFzaGZzIFJGUyhYWiBjb21wcmVzc2VkKSBh
bmQgYSBhcHBmcyBhbHNvIG9uIHNxdWFzaGZzLgpXaGVuZXZlciB3ZSB2YWxpZGF0ZSBhbiBTVyB1
cGRhdGUgaW1hZ2Uoc3RyZWFtIGEgaW1hZ2UueHosIHVuY29tcHJlc3MgaXQgYW5kIG9uIHRvIC9k
ZXYvbnVsbCksIAp0aGUgYXBwcyBhcmUgc3RhcnZlZC9ibG9ja2VkIGFuZCBtYWtlIGFsbW9zdCBu
byBwcm9ncmVzcywgc3lzdGVtIHRpbWUgaW4gdG9wIGdvZXMgdXAgdG8gOTkrJQphbmQgdGhlIGNv
bnNvbGUgYWxzbyBiZWNvbWVzIHVucmVzcG9uc2l2ZS4KClRoaXMgZmVlbHMgbGlrZSBrZXJuZWwg
aXMgc3R1Y2svYnVzeSBpbiBhIGxvb3AgYW5kIGRvZXMgbm90IGxldCBhcHBzIGV4ZWN1dGUuCgpL
ZXJuZWwgNS4xNS4xODUKCkFueSBpZGVhcy9wb2ludGVycyA/CgogSm9ja2UK

