Return-Path: <linux-fsdevel+bounces-49425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D537DABC102
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B82B3B872D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46352283FEA;
	Mon, 19 May 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="QP2SjEAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803C2820DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665579; cv=fail; b=Y00sT7Zn+GeZib5dlIstW7cQjb5h7v/qiwAb4tlfEpg3n0O/dXJxhPWjPgJ70OHVAiuM3ZIFCpvgIIINmR6kcv/NfX748IFSQ4dgpGY1cBnKwmR25R4pDsv5S9XB/w8dhcaVUoo4G+PNw0YRpi7ird2crDLWllsv0ROvu3xT/1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665579; c=relaxed/simple;
	bh=sERKoMJwkjQxbvUU+VDnrt5COgZVJtOP6wy2cs7BL1E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QODakSzX8g/sgEIUadzCziiwrnhsPU/1+acbEDH+sw39VBf9mHeoXc39kb6ta3b2R+UAME5VvY1RcF4InhBv1OLoRceeJzxirGyUABzvi07jFk1vAjKN0pA3BndIXwKmqWdFH0OKpVsvuDzg4Ob3H3D3vYCJVP/Bo5CGfjyEv0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=QP2SjEAm; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyCL3vhO2Pje8tx/WwgMYCZaVdslI1+xisrrRkNCerPnlROti+R1JoYTDxJ8uoE2xylPDGSjwz8gU7refc/spkzV49JVdQUczA4NGeKDPKkKlExVHGn5J6u71fbcOvsuZDrhbEtQAy2lr4LNSP50Vq+440iffYQsAMARAnYXFeczf+esX/0xettj51mAopC0Y3KMtCevbyjQBdP0V36QNgvAoVer4V4cnUHGOjl0QzaD8QZVjotD+f/fL6MhzusOHhFkfaNpGCpkRwXvjR2aQGUTXwq3RKApB0WbCJRizxtAZ3zrBDhFRW5JMPfvA7qst294sOLKAFrY582FGFj8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sERKoMJwkjQxbvUU+VDnrt5COgZVJtOP6wy2cs7BL1E=;
 b=FO39+NDzavhWimM3+nt0xKvwD7XixSVqi4utGWKj91gxT8EMWeMEiGueF+MdHwxJp9rtNAKpNTtCYnAE85ufXvU+V2iBT8eanfDCZR9pDrSVdoSJEZTCNW/HxjKPBZAjVbXpp6RfZk6G5pCW5VA60r0SmposlOTIPGlcaQlBDWMm3PACrYuYuKlGdx2+qNib61p0LYkMNzW71+RrFB4VWFUIhOEQtO0HuHu0y+x8batrX8Iwr276plRJh+Qwupno4EqA8kuAv8gyH7ZuEXUlE1fip2kBWcQQHVluezXbD/Ur6xNaeCKfYBlcF/jr9Gk01PL7y8mryKBRRh/8C6Hw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sERKoMJwkjQxbvUU+VDnrt5COgZVJtOP6wy2cs7BL1E=;
 b=QP2SjEAmLFMFWuZoski3RD06cKktc1sv57z7pEhPVVeGW8Iv2g2+LGuqerTLtpFGiSO+JfJPXp3yLxDlxrczxM0Oyz58lEDiFR7U6NpRkRQAKH+h4s+x5Ui/7hEVaTtA36hPF4VD79eL7RA9eRVkQHcxgPAnJApxebhWDJktG5ca8otZGfBHOR3WR4CcrziyDqjWmK/3cvpTVXh7K4nbEph87LOzn8cPPrzQ0X1u3xpObqKbWd3hmHmZ82RTaM2nhsulSH3f4bYiGMxgGppy0woingMR5PP7SJcceq8Gv2HYYsaY61O0IegBkfUtbQhwRpLvRdYfzZYFW/YbKJwqIQ==
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com (2603:10a6:20b:16::28)
 by DB9PR07MB7756.eurprd07.prod.outlook.com (2603:10a6:10:2af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 14:39:32 +0000
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f]) by AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 14:39:32 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Joakim Tjernlund
	<joakim.tjernlund@infinera.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] block: support mtd:<name> syntax for block devices
Thread-Topic: [PATCH v3] block: support mtd:<name> syntax for block devices
Thread-Index: AQHbyL+8Tj61U4Fy60yv/DeLsGtRnrPaBYsAgAAAnoA=
Date: Mon, 19 May 2025 14:39:32 +0000
Message-ID: <7472537fa95acfb7bf88c9848bbbc1ebf45b672f.camel@nokia.com>
References: <5a3c759c-4aa9-4101-95c2-3d9dade8cb78@wdc.com>
	 <20250519131231.168976-1-joakim.tjernlund@infinera.com>
	 <6e90a2be-a1a9-46fe-a3f3-bd702c547464@wdc.com>
In-Reply-To: <6e90a2be-a1a9-46fe-a3f3-bd702c547464@wdc.com>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4549:EE_|DB9PR07MB7756:EE_
x-ms-office365-filtering-correlation-id: a648f988-b149-4db4-050e-08dd96e2f7cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDJQN2QvTXdTbEFSNE5kcEJPUmI2bUpXSkk2TkpGZ3p4dG1FK0I0K3hnNmJ0?=
 =?utf-8?B?a0ppYVNROXRuckJvek9NZ1hZNE1jWjFPc2MxaHk0L0w0RSs5aHgxOHFoVTBW?=
 =?utf-8?B?cUIvVlhDUGRrVXh0WFA2am9aQ0crK01JV2tlZ095cE04ZEZxYjc2UVFCbWht?=
 =?utf-8?B?aG5taG5wRWUzKzRBRlp1TncyYnJJUjNvVHdFaVQ3U1ZON0VkSDAxV3ROUTR5?=
 =?utf-8?B?Um1QdHFXcWE1NTZ2RWhCSWpIbEZkQ3ZvUVhsYVNtOHBoRjd5eCs5L2t6aHNa?=
 =?utf-8?B?VCtJc1BUOUVLTXltRUZ2WGZaazRac21BcU9ScjY5aHZtSGRDa3JVY3ltdlV5?=
 =?utf-8?B?VkVOOGlxNDNtL2VVK2FqTWNlU1h2bllXY05rK2FyNlMzQ0Ivb3MvNFNtUXBM?=
 =?utf-8?B?d0hXWkR5M2tvOU53dVZ6Z1hnVExxR25UcDlEMWkvaXVlTFNUOEZqaE5GbDJ6?=
 =?utf-8?B?Rk90cFFNM2hvQkYxUHM5UmsweTN2bytyS2NHbG00bDJ5UzFTVzhENDZBYUVG?=
 =?utf-8?B?VjlIeWZ2QVNQaFQzQllpeFpvZ3V3eGxKV2JQaWVkU2gvbVFpdFZIckFHR2pZ?=
 =?utf-8?B?OFIwNDNVTk9WZTF5RktDL2VCM0svcWpRdWRvaVMxa2tTRWRKMW5rWU8vUHhO?=
 =?utf-8?B?REFzZ1I5MVE4WjdhUDVHVFNrR3R4ajdVR09BYzlDSTFNcE94OHJ1WFZXUkht?=
 =?utf-8?B?dnBnTHdtU3JhWXpVY29aL1lnWnF0dlpoR1pDWFpYZ1pyTm94SkZpU3RGdExV?=
 =?utf-8?B?RWRDTERxY3JORHdnVzdLZExUU3ZGRHkrbGFsMGUwOWdmNFRaQlRqd2x1a21v?=
 =?utf-8?B?WlA1dW9uYWFqSWlhTVdxeUZDSGRzNDd4OGM2dHVJT2NjWEk4eXZZM1FCb2ZK?=
 =?utf-8?B?cVlielRZbE91RUdjV1pYQTgrdUVqNHhZSDkrK2E4T3R3YitSWHpkOVNUOHBQ?=
 =?utf-8?B?N3hsZ3k0YjV6TDhBdlhYbWRONmdPQW5lemVaWHpIb0ZKWmxqVDNHeHhkMWR3?=
 =?utf-8?B?SVQyZFkxc2RBYytZVWc3a1RTMXZGcTNtMDFFbjV4L1piMWNsV0FLdWVabnNY?=
 =?utf-8?B?OWN2UTViajhoTnRjN1BpQ00wVE10aGp2Wk5hVkRnRzg3QzFiRkY0azMrZlV2?=
 =?utf-8?B?TUl4dTdXMUYvRy9YazF3bnREOTQ3UU5iUzZMUHB6WkZ5QWdIcC8yWjFVQnNu?=
 =?utf-8?B?ZTRsYko1ZmlNSTB6UXdpc21GSWJiNERpZDZSWXVZWTFPa296MDM2REtReTBo?=
 =?utf-8?B?U0tqMFcyOHR2UFhxRnZmVkpHLzR3UDIrUjJzakdiOFZFQkQ3bGpUNjg0ZmJ0?=
 =?utf-8?B?SlhjUW1hK0M0ZWExY2l4MVJDTTRnaGFnTVlSQzg2djI2WVAvL3pkeGFTL2d4?=
 =?utf-8?B?YW5lK0dGR1E3czA2bGlZUFNIN2orSEhPZ3hwN1JtdWxNbHRyUHd6M3F3RHB5?=
 =?utf-8?B?dkNnQktPcTBENGlyZEtlVGZYWnNtZUFvWmZQWW82SCswd2VNV2hpTko0aHk1?=
 =?utf-8?B?OWIydHg5WnN1bHNiMGNFV2kvVmZlRVUramc5SDZST2wrbDBZUUFJMXppcUNK?=
 =?utf-8?B?by9VTEtsMy9lQWMvZHRyWXowclk1MGdOcThzRTRHMUV6VmFSWVAxM1YzbFJP?=
 =?utf-8?B?d2NjV3o0NW1vbXN4SjIrdFRGc0lhL1Q5K1p6Tk4yeHNYblVuNlVoRmppNnVl?=
 =?utf-8?B?UVlOcnV1M0xBVW0zT2owZlJ1Mmc0cDVjUmtQb3VXOE83cmxST2g1SGtmZnVm?=
 =?utf-8?B?VGxzWTFaaTVWZzYvdHZ3OGFORU12MlNWTEU4ek1yRml5R202aDR4ems5cGIw?=
 =?utf-8?B?aWJNV3lPNm9IMjQ3QlVVcG0wc1JSZVBRbENYd2E3RzdsRjVBb2NPZ01aZzZ6?=
 =?utf-8?B?NGhPUWcyRkhmQXVkM2JLT3RoejcvM290OUVhUmEzakQyUW54cHBMYTZxTmxu?=
 =?utf-8?B?NGwyS0hBZnBNZWlPWGVvc3MwWEtWckRnK3dlNjJ2UitRbWhIcXJReGNLaUhP?=
 =?utf-8?B?b2NFQ1FuT2FBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4549.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGl4NTh5a0Zka0pRSHFQVUJwR2J3bVBSdVZhSG5UbnZIRWt6QnRPbVpuWnR0?=
 =?utf-8?B?cjhyaFh0K08zbWhiYmV1VnFjQVcvMG9ZNGlUMUwzRWNKd1ovUzBOcjBib29G?=
 =?utf-8?B?Y1lCZXd4ZDE1aExoMDhlb0xubzdXRE5GVHZTMjVCUVlycmxmSXIxbUxtd3BC?=
 =?utf-8?B?ZzFyTTdEQTM4SllmUkg4Z2FzcXJoV2VXek9wK1JaTkVyVzJLOXgyeTl5eU4r?=
 =?utf-8?B?cjFBNEFkcTVVUWtmZUxRZGI0NjNZN2pBMzBHRk5oWnpPN2FRUXFZdHI0Zm1W?=
 =?utf-8?B?dWNwdy94SXMvUlU3Ym0xRkpuaU9ubEZaaWV6M3d3cEF1eTduSncvVHFibTZi?=
 =?utf-8?B?Z1dUOVp4Y3V2aXFXTHdqVllJdW5jamg0SjVHcnlzK0dEeXluRWRRNElMT1RX?=
 =?utf-8?B?ZER5bVdZaVVYeFZlUFFmWkx4YkFYL0V1eENiWGxpM20vbzU2Z0Q0U1A5V0Jy?=
 =?utf-8?B?bVBkYmpsRmVSR1pzamE0N1dHS0Rtano5Q3h6S3krazBLbmhueVczNXBTbVdx?=
 =?utf-8?B?cUNhYWgrRjU4TVU1bjVLVnZGSmZhbEtmTm82NDVzOTN4V3VOQXFtbERuTWZs?=
 =?utf-8?B?YWRic3hVZDJKcklCT2IrZDhsWWk4V28xOEhoUjJBa3RIeCtjVS8wOHQvbWxv?=
 =?utf-8?B?RVUycXI3eUhQVnpMdzZETHlCaTU1UjQ4WEU4QnA0Q1hVWkkvcnVFa1ZRY0dz?=
 =?utf-8?B?cURxYjRJY29peWszTWlTc20zUEI1TDJmSEllOG5yREJYNEcvUU1iVVFtUWE1?=
 =?utf-8?B?dzZKOWFxZVB0THdNU1JBbVlsUXJoYzNHUkRSeGlodWk0aDIvZmxvOHJqQUlw?=
 =?utf-8?B?MWNraU85YzlsZEEwa3U1d2RyeE53TVV0ZWszdmUyTGxlVmtkS3hXNFFWRHM3?=
 =?utf-8?B?alk3d1Evb2FDbkRmNEVxQ2xCSWJIYkZrUmErYVZGeUFMcFdkSUJETy9lTkJY?=
 =?utf-8?B?VjVVdCt0SXpmRVhKVWZnRzlSVllGZTBMeGxxOXNaTVdJNktHYlNRRHpLdEJQ?=
 =?utf-8?B?RUR6ekpTQ0NXbmNiRGZtdm4wR3ZNbUFzbFVFK3RMQ2NOc2dsRHdZQlVSNWJZ?=
 =?utf-8?B?alVVN0s2NnJ3ckIyZFYrVmltQTFqTjM3Z0pseXNPRDViUG1DemQrcHpYT2h6?=
 =?utf-8?B?SmtmNHQvbThzM2F3V01sa0xkcGVGY2o1MnVQNFd5VjZZL2NvOTRoVXQreFVh?=
 =?utf-8?B?ZmpFc0lqK0srNmNDd0swNHUzWkhMR1ZBSWFkNnNrUTlMS29FelhSMW5idjV1?=
 =?utf-8?B?MXJyTDBxcVhEQ2VIT3BVL2tuUTNoRVoxTmFJdVdiNTZzSDNXQVF2aTlLMStv?=
 =?utf-8?B?ZW1CbFlCUjRod0duQU1FMHFuQnBlUkpzRjF3ZDVudUxOcUc0K3UxZ2RLS0FS?=
 =?utf-8?B?NEU5RG5BYS9xeHNQY3dTcXk3Q3I1ZmFOZCtncXI4SXZvUnZiQ2JEdnFOTVpK?=
 =?utf-8?B?UEtqQ3RsY1VRWFpxbHZ3aWFrRU9pdmNnVkRtOFYwRmFLZ2tOd1VGcjZvNnRn?=
 =?utf-8?B?Tnh5NFl1SktodzNmUWJrMlNsa3gvZlhveU9aS1kzaTlSRFM4M25WWXF3TU13?=
 =?utf-8?B?aGNWL25FM3BvTW02OWhINi9YdnI5RkxSRkNGc3REKzBZSkRRR3FzbjlZSjVr?=
 =?utf-8?B?WEx4ZWVpbCsyRUczREpSTTVTUFJSSHltbEZIZXA4cENEdWxGUVBJLzY2MVRo?=
 =?utf-8?B?dm1mS2orVkkwRmhkYy9MYWV5MlRiR2dPbHBEc2N0ekZYY2dnc3J0V2Q4aWw1?=
 =?utf-8?B?R0pVanNRK0gvVThRdThoeWxpSHFPQitZZWRoY2d3Tmp0UUhjdWQydndzOWtt?=
 =?utf-8?B?VmwreElNT3FOMlFaeHJtNy91L2U3akJOV0NFWElhSkluQWlmYlltRFY3dEp5?=
 =?utf-8?B?eWpTY2NkdmxyejNtMEVwbDlLMXdDSHV3MHU0VWdCd0Q5bDZyOUMyWHRPblBs?=
 =?utf-8?B?N1ZaUGRiQ0NYaEtGWFhCak9QelZ6YjlyaXAvYzBVVm0rL3ZBd1h0VTFyUXdK?=
 =?utf-8?B?ZjY2ZHhmb05GT1QxK2M3ZDJqOGt4eTMzZjI2V0dOTTFTem5TZUdUSStCdEdr?=
 =?utf-8?B?bXRPZzBiWVdTbVRBdGpUQmhaWlg2dWFSM2U5dmtkZGY3VE03MWdwTS9DTThI?=
 =?utf-8?Q?WEvyAUyLzpfOJn/X+yuEFeQ+B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C653AE9F4D92B5479292C8D59604D154@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a648f988-b149-4db4-050e-08dd96e2f7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 14:39:32.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hFJZOKDt0WIyvaiErV+b2N/HCPqZQvIKKpy90cZTxCK/QzN0rb1DZAyJkvJJamsipXIlPy0LnNYdLVLozBPVl9rdMtkq/ev/PkLk9vccdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7756

T24gTW9uLCAyMDI1LTA1LTE5IGF0IDE0OjM3ICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBqb2hhbm5lcy50aHVtc2hpcm5A
d2RjLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0Cj4gaHR0cHM6Ly9ha2EubXMv
TGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdCj4gCj4gT24gMTkuMDUuMjUgMTU6MTIs
IEpvYWtpbSBUamVybmx1bmQgd3JvdGU6Cj4gPiBUaGlzIGVuYWJsZXMgbW91bnRpbmcsIGxpa2Ug
SkZGUzIsIE1URCBkZXZpY2VzIGJ5ICJsYWJlbCI6Cj4gPiDCoMKgwqAgbW91bnQgLXQgc3F1YXNo
ZnMgbXRkOmFwcGZzIC90bXAKPiA+IHdoZXJlIG10ZDphcHBmcyBjb21lcyBmcm9tOgo+ID4gwqAg
IyA+wqAgY2F0IC9wcm9jL210ZAo+ID4gZGV2OsKgwqDCoCBzaXplwqDCoCBlcmFzZXNpemXCoCBu
YW1lCj4gPiAuLi4KPiA+IG10ZDIyOiAwMDc1MDAwMCAwMDAxMDAwMCAiYXBwZnMiCj4gPiAKPiA+
IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5maW5l
cmEuY29tPgo+ID4gLS0tCj4gPiDCoCBmcy9zdXBlci5jIHwgMjYgKysrKysrKysrKysrKysrKysr
KysrKysrKysKPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspCj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9mcy9zdXBlci5jIGIvZnMvc3VwZXIuYwo+ID4gaW5kZXggOTdhMTdmOWQ5
MDIzLi44YzNhYTJmMDViNDIgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9zdXBlci5jCj4gPiArKysgYi9m
cy9zdXBlci5jCj4gPiBAQCAtMzcsNiArMzcsNyBAQAo+ID4gwqAgI2luY2x1ZGUgPGxpbnV4L3Vz
ZXJfbmFtZXNwYWNlLmg+Cj4gPiDCoCAjaW5jbHVkZSA8bGludXgvZnNfY29udGV4dC5oPgo+ID4g
wqAgI2luY2x1ZGUgPHVhcGkvbGludXgvbW91bnQuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvbXRk
L210ZC5oPgo+ID4gwqAgI2luY2x1ZGUgImludGVybmFsLmgiCj4gPiAKPiA+IMKgIHN0YXRpYyBp
bnQgdGhhd19zdXBlcl9sb2NrZWQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgZW51bSBmcmVlemVf
aG9sZGVyIHdobyk7Cj4gPiBAQCAtMTU5NSw2ICsxNTk2LDMwIEBAIGludCBzZXR1cF9iZGV2X3N1
cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGludCBzYl9mbGFncywKPiA+IMKgIH0KPiA+IMKg
IEVYUE9SVF9TWU1CT0xfR1BMKHNldHVwX2JkZXZfc3VwZXIpOwo+ID4gCj4gPiArdm9pZCB0cmFu
c2xhdGVfbXRkX25hbWUodm9pZCkKPiAKPiBIb3cgY2FuIHRoYXQgd29yayBkb2Vzbid0IGl0IG5l
ZWQgdGhlIGZzX2NvbnRleHQ/CgpEb29oIC4uLgoKPiAKPiA+ICt7Cj4gPiArI2lmZGVmIENPTkZJ
R19NVERfQkxPQ0sKPiA+ICvCoMKgwqDCoCBpZiAoIXN0cm5jbXAoZmMtPnNvdXJjZSwgIm10ZDoi
LCA0KSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbXRkX2luZm8gKm10
ZDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhciAqYmxrX3NvdXJjZTsKPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbW91bnQgYnkgTVREIGRldmljZSBuYW1l
ICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2RlYnVnKCJCbG9jayBTQjogbmFt
ZSBcIiVzXCJcbiIsIGZjLT5zb3VyY2UpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtdGQgPSBnZXRfbXRkX2RldmljZV9ubShmYy0+c291cmNlICsgNCk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIobXRkKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBibGtfc291cmNlID0ga21hbGxvYygyMCwgR0ZQX0tFUk5FTCk7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghYmxrX3NvdXJjZSkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzcHJpbnRmKGJsa19zb3VyY2UsICIvZGV2L210ZGJsb2NrJWQi
LCBtdGQtPmluZGV4KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUoZmMtPnNv
dXJjZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZjLT5zb3VyY2UgPSBibGtfc291
cmNlOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9kZWJ1ZygiTVREIGRldmljZTol
cyBmb3VuZFxuIiwgZmMtPnNvdXJjZSk7Cj4gPiArwqDCoMKgwqAgfQo+ID4gKyNlbmRpZgo+ID4g
K30KPiA+ICsKPiA+IMKgIC8qKgo+ID4gwqDCoCAqIGdldF90cmVlX2JkZXZfZmxhZ3MgLSBHZXQg
YSBzdXBlcmJsb2NrIGJhc2VkIG9uIGEgc2luZ2xlIGJsb2NrIGRldmljZQo+ID4gwqDCoCAqIEBm
YzogVGhlIGZpbGVzeXN0ZW0gY29udGV4dCBob2xkaW5nIHRoZSBwYXJhbWV0ZXJzCj4gPiBAQCAt
MTYxMiw2ICsxNjM3LDcgQEAgaW50IGdldF90cmVlX2JkZXZfZmxhZ3Moc3RydWN0IGZzX2NvbnRl
eHQgKmZjLAo+ID4gwqDCoMKgwqDCoCBpZiAoIWZjLT5zb3VyY2UpCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gaW52YWxmKGZjLCAiTm8gc291cmNlIHNwZWNpZmllZCIpOwo+
ID4gCj4gPiArwqDCoMKgwqAgdHJhbnNsYXRlX210ZF9uYW1lKCk7Cj4gPiDCoMKgwqDCoMKgIGVy
cm9yID0gbG9va3VwX2JkZXYoZmMtPnNvdXJjZSwgJmRldik7Cj4gPiDCoMKgwqDCoMKgIGlmIChl
cnJvcikgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEoZmxhZ3MgJiBHRVRf
VFJFRV9CREVWX1FVSUVUX0xPT0tVUCkpCg==

