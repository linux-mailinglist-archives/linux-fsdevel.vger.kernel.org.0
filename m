Return-Path: <linux-fsdevel+bounces-58803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C7AB3198A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D536F17855B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234822FE58C;
	Fri, 22 Aug 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="laT7TxiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1475B663
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869181; cv=fail; b=I6EqVPjo7MHMnIjlmyGYnK04LYt/yzs1t9157CHRnYY/MMB0E4i20forRAO4jAiow+7HLgb8GwHXbnDMYLBFUN+C0RLc/TjaKRhEet5xjie7m5cVFQ5BTdiB6QcBPvvFd2B8OXbK8cmGiDbZ45VEouO1+iZsMAqDZvEuGXXQcA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869181; c=relaxed/simple;
	bh=2PYT27YY0Bj3tXDRSkcVwgtEnZ3ozCCGcDCUpRt7CPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IOVroEysTQMUzhd07bS7iN/fCP8aPtk1CfkVAAcLKAEKvVuYZ7WLMS4UaV/9r/zl6YnwzaR0ecbRehiDW3Esrbyp7xfDTAVscjUOA1fXe6jOyx9T3PYcW3OneVlBpx6/u3cjuq2zEYMuTFjYkMfCK6Gp1PtCFBKl9CANyfnD28s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=laT7TxiN; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137]) by mx-outbound42-180.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 22 Aug 2025 13:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tq/WaTpXludCIbWJK9X3WZ464LlmBFwx82pHe+0nVd6Xi/6VnlxLjnAp6gt1K1otMCrMXfGHIO77mxTTvDbeM5/NegpIbwLb4DtOS2BOgdX5iLj4+oBnJFUmvS+ChTqMmWq6KCS2y8EP9XS4M9N1boJIW1jGcTnJb8jJm2fIEe0ZwapKytMaGMJ24K36LlNc2sYW/QuU0w/vbr2oqSDCOMGa2mW7Y3a1B4btR7Y5m18wRsf0uOb1zIeAf9Udk65I8XSwJGLjTUIM8XJ0jbtEoilW8xjJvceqkTCwSk45W0T0Fs9nAlEksz5ADugLU2UGrEntP221g5qIvyeSKyH2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PYT27YY0Bj3tXDRSkcVwgtEnZ3ozCCGcDCUpRt7CPg=;
 b=fkNxnb4D9dsUeybvfglz2+mNAKg5jJyYWEe9Jk21zsOCpFhKAMeU9qNdnOEBshuFb/7WXIUsY/lX3t2f7eWh62JvTqL1/DWkmCp1uNlph8HOT1yijNlYi1f8BVnpoQICFadrFoFnG+iYWU8pfCNhu12EaMknBO0b4f2HnSplPIGsAZbUPJaTWdXRwCouKFHdtBcn+uqtZazRq9eEcD9K2YF7pU6RukMGVMn5GinGKxWAAi7HsGGf+PY5h7n6MJfYJPrf5Pi9/VTI6gBIc/5qcq+IX4v0Ar8cqEcMVpH6O6z4XZOYZu8Z4Maak6jggXpwS0Rwgj4kDhxmYMvPAVIMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PYT27YY0Bj3tXDRSkcVwgtEnZ3ozCCGcDCUpRt7CPg=;
 b=laT7TxiNNTw347SeQ8DKT7SbtE6iFEzuDYVepsk3SlTweuHWf/trsoKTNkg9i1xEs/pHjy9lAXzvCuzwJajR2yFlcyJ4Ln3+dz9OsJ7KP7Uo8+yzF2b/Q2+R6f6MKHP+4c9FS92v8avj+UnSzuPTBfq0h03PIKp7+dkE+VlK9Oc=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SA0PR19MB4457.namprd19.prod.outlook.com (2603:10b6:806:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 12:54:02 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.9052.017; Fri, 22 Aug 2025
 12:54:01 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong"
	<djwong@kernel.org>
CC: "John@groves.net" <John@groves.net>, "bernd@bsbernd.com"
	<bernd@bsbernd.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"neal@gompa.dev" <neal@gompa.dev>
Subject: Re: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
Thread-Topic: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
Thread-Index: AQHcEjchxrGjTS5H6kuBbO2irw0Jr7Rt1GQAgADO14A=
Date: Fri, 22 Aug 2025 12:54:01 +0000
Message-ID: <3722af15-f1e0-4a91-b0ed-9292f80a82a4@ddn.com>
References: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs>
 <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
 <CAJnrk1Y-eEeJySHL5sYMTphUnApbK2hZpDjDh3qEmsa_f146tw@mail.gmail.com>
In-Reply-To:
 <CAJnrk1Y-eEeJySHL5sYMTphUnApbK2hZpDjDh3qEmsa_f146tw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SA0PR19MB4457:EE_
x-ms-office365-filtering-correlation-id: b5603e3b-af91-4caf-32ea-08dde17af7f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVFNQzZ2MGxtVjBnQ3VYaGZzYTZId0tNaXo4dWJxWEFERFE1elAwd1M0aWxV?=
 =?utf-8?B?Nnd6LytOSmtpeFdsVmFrSjExUEVhMDh6Zk0zellyQ2xRVStGN2JGVWhqbzRN?=
 =?utf-8?B?WXByYzhna01xOUJSeDh5ZHRhN0ZqWG5UeDNSODk4TTRzV01KQnlncXBvSXk2?=
 =?utf-8?B?RW5TT0QzeDEwMEl2ekY1TlhaN0FyNDVwdXRFanZFeFNhNE4rV1FNajI1Q1NO?=
 =?utf-8?B?TGVMTHE4SHJBVXAyd0dvOGxmR3ZvbDhRbHE3djY4Qm1FSmttTEpoZHY0Yzdk?=
 =?utf-8?B?R2NtRUxKMzZxaDRDV0pqY24yVlhoQ2tOb0FobVErVStLSjZ6OGZpSUJBdUdI?=
 =?utf-8?B?NFh6WHBLamxaRlBXeDducmp6Y0wrMlpkS0FsNGszeEIvcnNXTnB3bThvNlky?=
 =?utf-8?B?aTh6K0xmOEh6KzBobWorN0gzWjlVakEyR2ZoU1dZQll2ZDhQQmw2V3duUUFF?=
 =?utf-8?B?ZTU4dVZscjUreFFQaVN4VXArOFVWaW1GOGZqSW1oL3pWRFNxMUdrVm9yam1T?=
 =?utf-8?B?L2oxYWtxbXV0NGRSNHZlOHJZMFE0a1BITEhYVWJVd2dyMUZFVGVSRnFZUXRs?=
 =?utf-8?B?b0JKK3pzWXBDY0tPOFd6TWVpRmdFWDlrUWd5eHZ1dmZmK29SNmFQM0ZoamIz?=
 =?utf-8?B?R3JpdGRGSTduQjBqQTVpL2JMZTBjNlE2cEp2Z05KcFhIMU5TQlF4bHRCc0xj?=
 =?utf-8?B?VFpoZGNwcm5nOG5KUytKTVlpUFZUVHJBeUZzamxmbXQzdGx3M2FHOTg5T0Q3?=
 =?utf-8?B?Nm0wd2E0VnVueEhUTTBrTFFjNk1PdXY3c0gxNWxqckwwa2hpSFVkTkNuNlBV?=
 =?utf-8?B?ZmlCWHVSRzM0STZBakFLd0pOZ3dzYTFCSzlXQkljWnBJVDd3OW5JZ09Cd01k?=
 =?utf-8?B?YlptaHpyUEZkVjNCZzRNeVU3R1VwdXFRVGczQnYwbUZMRkZiUjVGT0lhanU5?=
 =?utf-8?B?V1QvVFBtTkdPMk42U0RXcU9NLy9PNG5GMFoyamVTc0lsc0hvbFBScklEY0d3?=
 =?utf-8?B?b3ErWXViRFZJNE91c2puekRsTkZ3WXJrRUJTQkhxTUhkS0xYRExVYjFEaEJj?=
 =?utf-8?B?bEZ5QUxKNFJkUWx0YjExZkNVVHQyVDRKVUIrOXJHeGRsMDQvWkgzb2g0WHVi?=
 =?utf-8?B?ZnVaSkxoUFlxYURwbjB3RE1iYlJqdTBuOHMvTzBLUHF2dWR3WHFHeW56Qkhx?=
 =?utf-8?B?cjVJQi8zYmVOeWE0aHBOZG53dG1WM0JzM3Flb1llMWcxb0piSjJyT2NjNHZn?=
 =?utf-8?B?ZXdoaDFFajJxR0VDWHNzL2JNU2ExbmZ3U3Q2RlFzdkE1aGt3WTNiRGl2Y3BH?=
 =?utf-8?B?cVZ1YmFQNGRlS3R5Mkp1ekcxUkoxaTFmcTZJSWFaUklBWW0vSkJZMkR2QUpN?=
 =?utf-8?B?eHh4b2R4djV2L0RmMVowTzFMSEZrNDdFclBIK1pBc2J6VEN0Z2lFVG9EMUZ0?=
 =?utf-8?B?cXZ3aVltSk9mYU1taW5LbzVzelMvNkNldE9qSnNrS1lXbWdYWUJFa3hRY1dn?=
 =?utf-8?B?S1JLSXhJbTUzSkdnWFh0NE5DRTB6OUcxRXZoWTdGdVFqZFU5amhNVlFXcGRT?=
 =?utf-8?B?WVJEQzQ3REp3Q3AxelZaNG0vLy9QYUY4dDFXWUZUUE1FK2xsOFJKZmVQVWFL?=
 =?utf-8?B?M0h5K3hDV3JsUW1manRIWG9yM3FOQmJSZEFSZ2FBMHVyRWsxakxCNS9uWW9l?=
 =?utf-8?B?WUwrS2UvTVR1d0R3Z2ZRWklZQzlBMGM2N3RCZVlKcXROMEIveG5LdWNMZThU?=
 =?utf-8?B?ZjE2S3JMamc0U2pvMlJPa2dGSnhUVHJJaUVQUHpMTW9Lam00L3g2RVVYSlpm?=
 =?utf-8?B?SHhIbGZwYjQ5N0FEN1FvNzdQSVlpMkZDb3F4K1ltYW5tcWVnOWxNeENPUTR4?=
 =?utf-8?B?eU0vakUrRlMvVzFLRWJiWE1kV1V4Um53T082WjJ2cUpkOG5TalAvcDRhaUxo?=
 =?utf-8?B?MnVVZnhJb2xoRzVOZ3BZYk40b1VTdERPaFVXSkRMM1ZQWHcrdWl0SnRxb1dH?=
 =?utf-8?B?V096K3BsdUNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0FMQWVobjFUckVzbGVXeERDRk5pOG44aXIxVHRhM2ZIeWRQSFJMYW9jNTVa?=
 =?utf-8?B?cUt5YWVRbHJXTERsTXpIWTEweG5PMG9JK2lOaWpSMWRibzl3MTZRRVk0SFJu?=
 =?utf-8?B?VHo5QU44OHB4cWtsNkJqWUxKWlVmSmtQd25TUFQrTXJReDBBUFlqWjI0dDZD?=
 =?utf-8?B?MjgvTEJkNGtSOWVSR2RBSng0MSt1elNENGs1MlZkVy8waHRKR0gwZnlab2xw?=
 =?utf-8?B?S1U0TGw0OE9IWHRjWXpqTnB3eS9RTXNNYWdKM0NPOVhaaUp4ZEpCdWZLNzJj?=
 =?utf-8?B?WHRtZ2dydUg2blIyVUVsdkJKUWhLRnpBek5iWEJOemphaFNqQS9LNGYrUnk1?=
 =?utf-8?B?dS9jRWJVM3pZVStBandGSEhOSG1xekxzc3Nhelc0cjA1KzlqWFREaW15bFdE?=
 =?utf-8?B?SnY4OTlOYmJsY3QvNUlET1JkTUV4MUhZV0JtSFZ5WE5tSGtBT3dWVGdQWHA2?=
 =?utf-8?B?V01qbFp3MDRzM1RYbHhzam5ISmpuLzJHU2cyeGc1bDJoRkptYXNIR3ZId05h?=
 =?utf-8?B?V3VMYWhLY3JNSG9YYVlWZkVtKzhDWWlvSFJNM1NzbnJEY2NOQ1JKZWtlaGxI?=
 =?utf-8?B?Z25pUEJ4ZDliK1h6SEtsUDlBZUVtSmNLM0Jhd25KQ25HVTFlZm12RDBCRnJN?=
 =?utf-8?B?TjRjeHNjWHl5U0RraVcralZZUkNwT1g4RzZIUE5DOHlpMU9LRktpb2hnTXp5?=
 =?utf-8?B?QVZpMXJoekRrVEpJL0dzTmQzdFVwbTM0b2JocnUyU05ZQ0JESDlIazNuNVJF?=
 =?utf-8?B?bzdJeitTb1dzL1orQlRnZHh4K2E5RDEvL0lsdlQxRHovN1JtQzJPL0x0bytk?=
 =?utf-8?B?ZmZhR1RoSlF2ck5kaTVhWVJOQmFZU2gxdE9IamVWSkdnM2NzbnQ2L2ZMTC9K?=
 =?utf-8?B?eVV1S0hxZDFUNzRDUUl4VWlCaWVRYmFyR0Q0K0d3eUtFUUlqRWo0MUVISXFa?=
 =?utf-8?B?KzdxYjl6NXdRSGR5RDBDdVJyck1MTW8vQnBoTGsrc2tnT0VKellra0IrU2ZK?=
 =?utf-8?B?S0kwMTcraVdMeWFzOURJcjZYWkc0ZGVxNFVpS1ZZZURkMWZac0RpWGVmVzR6?=
 =?utf-8?B?UGdFK3JsdE44TC9vOFBwVjZqRjhEaGd2NHRUV242SnJZaStsWDhpRGFteWJY?=
 =?utf-8?B?RWNwK2V3OG50UVZIc205a1hXZS9mSmovLzNvRm96K3V6ZER3VWpSSEh1Z3l5?=
 =?utf-8?B?WVFIZ3pxK1ZYRUl5alZFSTNhN05wWmhtQzQvUGxRb09FQWM0R1V5aU4yclBu?=
 =?utf-8?B?ZDJJbm93R2MxZTZUaWRoR0t0cmFWQ3ZFdnFxMkw4d1QxNVYwbFVzM2NRcjJw?=
 =?utf-8?B?ZkFLaUUrblluVzJpd3B1QWl4ZG81a2ZwZFNhQXVvN2hYb1RkN2IycHpuYldU?=
 =?utf-8?B?Z0UwNi9uR1ZWZUZvcHpqQkRGaHlFem1HT1BrQml2TTBiUkxvLzRKQUpTY3lq?=
 =?utf-8?B?TGhYS3ZmTElwbGVOOGw2dFpLdHVKVVR3bXZaSlk5K1lyT1kxZnIwdkV6b2dm?=
 =?utf-8?B?WEthWkRRdmViUjNrLzZyT05mRlFwTm1IT2piMmM5QmVaQXhpWjJLNFNmS1Rl?=
 =?utf-8?B?cVhVbldqQ2srbjdTWklIdCtvR3dxS2t4RVc2RGhhSW9FWTZLbkVZc2ZONHZ0?=
 =?utf-8?B?QXZxQ0ZqcjdabmJrekl0TzBERFp1ZWRROU1vcXJTcGtqZFd4SDNjLy9LekVJ?=
 =?utf-8?B?andWeWFIQXlRMzA4UWtlU2svbVBRaGd3R1FuNm9icHdYMVc3R2ErejAzN3VU?=
 =?utf-8?B?OUs5QVNDL3pBWjJLeUdRL2lUZGRvYVdEMW52bG1uQ0k0UmVLRUNpb002RHFj?=
 =?utf-8?B?c0VJTnVINmZIdWs2ZkZRZGFyeERGVWxVMndMUzUxajg5c1h0NHVhS1RzUUx4?=
 =?utf-8?B?Sm42Ty80UERCTDVzcTY5UUNLTG00R3kzVFZoSUlycU5acEw5VElLUExBMWtL?=
 =?utf-8?B?alNDRU9RcVZET21JWkJGa0tDb3ZEMUZZMzI5WGgxZTNBR21OaHVKTGI3TkFi?=
 =?utf-8?B?NDErVGlOQ0NCUGpRVExlUXZFM0hIODMvMytGa0x0M3RheTRkZGpLaXI4VXFs?=
 =?utf-8?B?UHh3NUwyKzFMZ2draUxxditqZ0Qvb3FlWUtlRVk0eTIxVHVjZ24rMjVrQ21L?=
 =?utf-8?B?NkhqeDJHNk5jKzJSMFdZNG00T0IvblRTYk9WNklMVGdxTGVzOTZUSGo0NUpi?=
 =?utf-8?Q?aGEdVDGQBdM240C6GOUfk7g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93F3E9E3040B864AA9582EB7AA697725@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3f8/oit9n1/k5AYoLUOK0j5A5NNw+dxw/W/zLxMXw82Tk8q1/VLKUVpxNulz3dyIfzml/1iZ0AZxXIjbgvP7SJtMX4RmOZuG3yFFUxVVE4DFkHKULFMb+xGDZ9aH1UYcD0GBjNqLVeH9TzrIlndO/amqJR8clVbIe9RwsGU6gTXTJ3ykWGGnEJH4dGHwSvcu3NEQor0Zg1ClaJ/AHoB4BJS4YO2tu0Fm6gAhViJVkQO6kmGE7XtT6o4yDiTAkCTOga60QtJAwyoiWqC3mRjVR1R2+xg0KeOdBFFNbIX8RiOzy4vn0QAnvcsvdYEPPmKa57p/A3tlBj+05GzYSePAWrdIVqfcQGiK5X2Ryhk4ma6yTs4BzvaAy+UhuAVPf+xtYOfI9tmX1e7G39oH3vN98+TRsaH/UoRJm0ZOA6NiwwcB9VLWh/VLc3fAW8YmkazWdWNfdw6OkjiPrWSPZand32PyiH1ta6PWqoSpt9O/c+8wG6/yG6LNhI/IN+Brz/ZgL3hEGZytCuxeV+0eky+hMi/pGfSrQw71GKUZKfmpbbCpQ6m81CrJxNNBTMQClJVNouf7dY7JKT5pWinRKvN0l7V92ZmTAmHe3ny0JfKF17dS397a7jm/Tn/18wB3rmbk1jBJQZm+C6GykLjAIuX+PA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5603e3b-af91-4caf-32ea-08dde17af7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 12:54:01.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +31tgowYtwkMOw/LAKf/WaZOtnfcWUB8Fo8uWfyztLo5lkQXiqo2kojXj44D/H46mXpwztrAAIyDdzwbSa10Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4457
X-OriginatorOrg: ddn.com
X-BESS-ID: 1755869176-110932-7641-4677-1
X-BESS-VER: 2019.1_20250807.1754
X-BESS-Apparent-Source-IP: 40.107.220.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGRgZAVgZQ0MTINMXCzMIg2S
	A5ycLAIsXY1CDVxCLJyCDZyNDCJDlFqTYWAPcAbtxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266950 [from 
	cloudscan14-136.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gOC8yMi8yNSAwMjozMywgSm9hbm5lIEtvb25nIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAyMCwg
MjAyNSBhdCA2OjAx4oCvUE0gRGFycmljayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4gd3Jv
dGU6DQo+Pg0KPj4gRnJvbTogRGFycmljayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4NCj4+
DQo+PiBmdXNlLmggYW5kIGZ1c2VfbG93bGV2ZWwuaCBhcmUgcHVibGljIGhlYWRlcnMsIGRvbid0
IGV4cG9zZSBpbnRlcm5hbA0KPj4gYnVpbGQgc3lzdGVtIGNvbmZpZyB2YXJpYWJsZXMgdG8gZG93
bnN0cmVhbSBjbGllbnRzLiAgVGhpcyBjYW4gYWxzbyBsZWFkDQo+PiB0byBmdW5jdGlvbiBwb2lu
dGVyIG9yZGVyaW5nIGlzc3VlcyBpZiAoc2F5KSBsaWJmdXNlIGdldHMgYnVpbHQgd2l0aA0KPj4g
SEFWRV9TVEFUWCBidXQgdGhlIGNsaWVudCBwcm9ncmFtIGRvZXNuJ3QgZGVmaW5lIGEgSEFWRV9T
VEFUWC4NCj4+DQo+PiBHZXQgcmlkIG9mIHRoZSBjb25kaXRpb25hbHMgaW4gdGhlIHB1YmxpYyBo
ZWFkZXIgZmlsZXMgdG8gZml4IHRoaXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogIkRhcnJpY2sg
Si4gV29uZyIgPGRqd29uZ0BrZXJuZWwub3JnPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9mdXNlLmgg
ICAgICAgICAgIHwgICAgMiAtLQ0KPj4gIGluY2x1ZGUvZnVzZV9sb3dsZXZlbC5oICB8ICAgIDIg
LS0NCj4+ICBleGFtcGxlL21lbWZzX2xsLmNjICAgICAgfCAgICAyICstDQo+PiAgZXhhbXBsZS9w
YXNzdGhyb3VnaC5jICAgIHwgICAgMiArLQ0KPj4gIGV4YW1wbGUvcGFzc3Rocm91Z2hfZmguYyB8
ICAgIDIgKy0NCj4+ICBleGFtcGxlL3Bhc3N0aHJvdWdoX2xsLmMgfCAgICAyICstDQo+PiAgNiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4NCj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Z1c2UuaCBiL2luY2x1ZGUvZnVzZS5oDQo+PiBpbmRleCAw
NmZlYWNiMDcwZmJmYi4uMjA5MTAyNjUxZTk0NTQgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2Z1
c2UuaA0KPj4gKysrIGIvaW5jbHVkZS9mdXNlLmgNCj4+IEBAIC04NTQsNyArODU0LDYgQEAgc3Ry
dWN0IGZ1c2Vfb3BlcmF0aW9ucyB7DQo+PiAgICAgICAgICAqLw0KPj4gICAgICAgICBvZmZfdCAo
KmxzZWVrKSAoY29uc3QgY2hhciAqLCBvZmZfdCBvZmYsIGludCB3aGVuY2UsIHN0cnVjdCBmdXNl
X2ZpbGVfaW5mbyAqKTsNCj4+DQo+PiAtI2lmZGVmIEhBVkVfU1RBVFgNCj4+ICAgICAgICAgLyoq
DQo+PiAgICAgICAgICAqIEdldCBleHRlbmRlZCBmaWxlIGF0dHJpYnV0ZXMuDQo+PiAgICAgICAg
ICAqDQo+PiBAQCAtODY1LDcgKzg2NCw2IEBAIHN0cnVjdCBmdXNlX29wZXJhdGlvbnMgew0KPj4g
ICAgICAgICAgKi8NCj4+ICAgICAgICAgaW50ICgqc3RhdHgpKGNvbnN0IGNoYXIgKnBhdGgsIGlu
dCBmbGFncywgaW50IG1hc2ssIHN0cnVjdCBzdGF0eCAqc3R4YnVmLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGZ1c2VfZmlsZV9pbmZvICpmaSk7DQo+PiAtI2VuZGlmDQo+PiAgfTsN
Cj4gDQo+IEFyZSB3ZSBhYmxlIHRvIGp1c3QgcmVtb3ZlIHRoaXMgaWZkZWY/IFdvbid0IHRoaXMg
YnJlYWsgY29tcGlsYXRpb24gb24NCj4gb2xkIHN5c3RlbXMgdGhhdCBkb24ndCByZWNvZ25pemUg
InN0cnVjdCBzdGF0eCI/DQoNClllYWgsIHlvdSBoYWQgYWRkZWQgZm9yd2FyZCBkZWNsYXJhdGlv
biBhY3R1YWxseS4gU2xpcHBlZCB0aHJvdWdoIGluDQpteSByZXZpZXcgdGhhdCB3ZSBkb24ndCBu
ZWVkIHRoZSBIQVZFX1NUQVRYIGFueW1vcmUuDQoNCldlIGNhbiBhbHNvIGV4dGVuZCB0aGUgcGF0
Y2ggYSBiaXQgdG8gcmVtb3ZlIEhBVkVfU1RBVFggZnJvbSB0aGUgcHVibGljDQpjb25maWcuIA0K
QW5vdGhlciBhbHRlcm5hdGl2ZSBmb3IgdGhpcyBwYXRjaCB3b3VsZCBiZSB0byByZXBsYWNlIEhB
VkVfU1RBVFggYnkNCkhBVkVfRlVTRV9TVEFUWC4NClRoZSBjb21taXQgbWVzc2FnZSBpcyBhbHNv
IG5vdCBlbnRpcmVseSByaWdodCwgYXMgaXQgc2F5cw0KDQo+IHRvIGZ1bmN0aW9uIHBvaW50ZXIg
b3JkZXJpbmcgaXNzdWVzIGlmIChzYXkpIGxpYmZ1c2UgZ2V0cyBidWlsdCB3aXRoDQo+IEhBVkVf
U1RBVFggYnV0IHRoZSBjbGllbnQgcHJvZ3JhbSBkb2Vzbid0IGRlZmluZSBhIEhBVkVfU1RBVFgu
DQoNCkFjdHVhbGx5IG5vdCwgYmVjYXVzZSAvdXNyL2luY2x1ZGUvZnVzZTMvbGliZnVzZV9jb25m
aWcuaCBkZWZpbmVzIEhBVkVfU1RBVFguDQpJJ20gbW9yZSB3b3JyaWVkIHRoYXQgdGhlcmUgbWln
aHQgYmUgYSBjb25mbGljdCBvZiBIQVZFX1NUQVRYIGZyb20gbGliZnVzZQ0Kd2l0aCBIQVZFX1NU
QVRYIGZyb20gdGhlIGFwcGxpY2F0aW9uLg0KDQoNClRoYW5rcywNCkJlcm5kDQo=

