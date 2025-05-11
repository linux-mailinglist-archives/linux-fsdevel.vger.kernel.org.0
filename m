Return-Path: <linux-fsdevel+bounces-48680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB2AB27C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 12:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E951176F86
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C31A7AE3;
	Sun, 11 May 2025 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AM+lGxlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012055.outbound.protection.outlook.com [40.107.75.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27163CB;
	Sun, 11 May 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746960353; cv=fail; b=OugdryqeNO0tl3tbG0kuNUc/NfFnwuzm73uLBaBqlRMIdVJb74DwDXOiNTLXBrD1NCLZcTzlkvq+s0cV6z1iJynhY3ytne69Xr657/SrBpN61wP5NqA8yc0GYL9X6yjbOFrkLBumF9kCkMKlkzMuvsyQySO83PN/63idVXL+DbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746960353; c=relaxed/simple;
	bh=u/jcRKs13pEC2WBR2O5P6XqnaG/5yTw3ySvvpoEoqcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L19fSlFK4bCMXc/P/wNs0D7gvXqECwaa/cnVf2mRNn4gJRU0srD6ENB/gtasZ4Nqx2rbeI6ZzJS+8LeTm4azBDccCaH9TqlZLZ2mYMOZuEkDKGOA3Kp8EBLs0uOgV0k7QaLmSwGoStlkByxBca/6EKEBSw59RviaOXIBukLpwtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AM+lGxlQ; arc=fail smtp.client-ip=40.107.75.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmH7FODaHIcnPJ1de8+5mzIpvMTrzK2Ox5uyqL1PHX0bRw6n00c56r5YDIYp45vLTROe5o3YSOrs9+MmTPdIfAkh4n4wWYiAhzBW/4ZTUfOSs7b+3k9wkvEas6yhtUXo3HU1TA4+bh3r2RMeD6hgCeTY7xH8yzDUSd/DylzOvcy4FSsGBIyaJz6c786q92tfig2NHXGecqtDBzCzG2MCF6v/OzpPsJVD4Rz/MV7lldQEycf2hXn58/P7FFkwQ6fUVK2XbKyyr2/FB/JvFXftP+naxJqVggM4aGMT+UwJu3wuhueyvf55o5W+9r/WrxBPIocjWfI1e6ZC8ixHEf0qIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/jcRKs13pEC2WBR2O5P6XqnaG/5yTw3ySvvpoEoqcU=;
 b=yGvHiYuCGGlf/n8YeT01VfN+BcX5PBRQ2k747vSqtQg2HQasMzSFcNX6Akj0WhUmTdunnbTMoRM3BaeZ0InYxs6byuFyC4l7lYt1tpaYa37dLT/Mgn8jD7b7XIAsqs8sCcHhNocj0NoKkOnPtpT8Fu+s7+Q02b9ioXDe0N9WUro8e5Fm+HadWif46cadIximBc4saaEwM89okt4cZ4ZR4MhRs5aOwbOOzB+dzs4djd/7eZ2I211aahmktikF+BxMt6k98zfv+NAfs6+nlWI9ziX9pzTPF1pfeGdmPDSteKZBqJ/kvQYGjaHSmgDb0ggWJ3lkBl9NIzbxO2Bu5deoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/jcRKs13pEC2WBR2O5P6XqnaG/5yTw3ySvvpoEoqcU=;
 b=AM+lGxlQUOFskFnRzUDQuVMdducwNjmdcH+Ro6yqXxE/bmsPfOjPUoWYlWgEaZcmNyuM/kQRlnLVIjchpZsbBew0PsQHKZFLqIP2rxc4LkPoTiJFxsDbvtCatG+zLoiM3QBbDg42AMFPPMDK8MVGzOG6bXoKA6rzlnWNKPgI151cAB2FKYTJr174KThswKeHogmWMp1U4XoTb0PHXw1QUG4hUgVGEZmlA01f5uv0AQ/eNfig7/jz91K9Oe7oDQml0MiKrazQIv9Lu2GdPFsjI0S5XeCr2tpqIjJlVXWapsa+au1eMoKz3w9gZ89gm/b6rAsQflbBKh95PJhAtoNB9Q==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5386.apcprd06.prod.outlook.com (2603:1096:4:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Sun, 11 May
 2025 10:45:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8722.021; Sun, 11 May 2025
 10:45:46 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGhmczogZXhwb3J0IGRiZ19mbGFncyBpbiBkZWJ1?=
 =?utf-8?Q?gfs?=
Thread-Topic: [PATCH] hfs: export dbg_flags in debugfs
Thread-Index: AQHbv11Ryn4snUQTI0iPql1owUlLUbPKk9IAgAKxFsA=
Date: Sun, 11 May 2025 10:45:46 +0000
Message-ID:
 <SEZPR06MB52690DEB5593079DA5236655E894A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250507145550.425303-1-frank.li@vivo.com>
 <e87e0fce1391a34ccd3f62581f8dc62d03b5c022.camel@dubeyko.com>
In-Reply-To: <e87e0fce1391a34ccd3f62581f8dc62d03b5c022.camel@dubeyko.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SI2PR06MB5386:EE_
x-ms-office365-filtering-correlation-id: 84891c8f-d836-480d-ec2c-08dd9078fc9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3JwYnFSMzY4OENoRFNudFNDa1l4YUs0OFhsdG5ia1BDQnZZZGZoaittTzgw?=
 =?utf-8?B?eFA0SlFGdEJsUTJQV3FZVisvUWNzUEgvcVgwRnBlS3JKTE1EL2RuV2o5cXJO?=
 =?utf-8?B?T294VXczUFMrYVlmNVBYaE1uMlg0OGFZK3ZzckNhdTBSM1FYTi9XSHl6T3Bw?=
 =?utf-8?B?bEtmbTJRbnZ3OEp0QW5FaG1JWlRJOXJuTnp1RjQ2L2hDRjNNR0NFVXFqbkoy?=
 =?utf-8?B?aFVnUEdpQllidVdaN3RyQXUvRVZtbzNuK29sUXgxZkw2WW5Va1RlWDljVVdW?=
 =?utf-8?B?WlBvcXZUYnZJZS9IVlpUT2E4Rk1hZldraE5OR3JnYnBrRmVDWmtUK0hnZTht?=
 =?utf-8?B?VkVzcFV0Y1NKdm5hWjJ6Qnp4TFphNkxndysvc05VRzJFVDZVWXFVQ0ZkdWxp?=
 =?utf-8?B?L1BBTUdra3IzenZWV3NMLzNMQ3FZdmtmZThjOTMyQzVsTitjeTBPWDFxejBk?=
 =?utf-8?B?REVncm5CVGF0dkpqWUZ1Z0JGNStaQXF4YmE1SFpDQzBadTVrWGlRcmUyQTVl?=
 =?utf-8?B?VkRNby9oLzh5cE9IcXJGV0ptNkZYU0FmaE1od0h0aFJXUVBSNTM4MjFkT21Y?=
 =?utf-8?B?akdWZDRqNWwxNVMwbnZTOHNuYWFHWkZ3Zmg3VkxVbTBUVTBlWngzQXlidmRZ?=
 =?utf-8?B?YURmQS9oa21LcmtYTlBsZUJjZ1llZktFVWZaY09iM0ZVODFkNzB5SjRWQXB1?=
 =?utf-8?B?RUZyeFlUc200c1NlT005cUpXWDZxVGlEV0pFYy9HeXhwYis1TXNGUlZDTzlI?=
 =?utf-8?B?dEpyVjZKc0llWm00S24wQ3gzK0xXZUpqTEp5NkVvdTY1N1o3UDZGZkExYnln?=
 =?utf-8?B?dkRNamdoanJWTmJvK3RRWTJ1b2NMdldQMTg1aTkxR0hDLzNhMytaamtNWjdK?=
 =?utf-8?B?Q0cwOHBwWURxWkZnSTE5MDlLRElvTGdqejBldmM0ekM0L0ZqU3F3ZXpsVVFL?=
 =?utf-8?B?bjBodnF3SVBWaTA3SDJzL1NrSWZuNTdLNXlRZ3dIeTB5Slo4b2hRN043NzFR?=
 =?utf-8?B?L24yeEpyUnpQQ2JEREFmUG1TRTB3R3lnZzRCVUxJbThrVXlzL2x6QnREZ3Jq?=
 =?utf-8?B?MzZ6NjlSbXo1SmdubVZlSHFBYU1ZSEVrazU0cWRFcFI3bXVCMjd5ZmtFUGtz?=
 =?utf-8?B?bm1tTXpSbHRJZzdkV1RuN05Zb3lBT1lXN2QvVGlpSEtUYjJ1NU1JdWk4NHh0?=
 =?utf-8?B?NFBsL1VMRmE1QjY2My9nc1lYK0gxTU4vZmRGcFhhTWl0ZHIxdmRzdmdoMC9M?=
 =?utf-8?B?ZDczREZPQlNyQ1hTUEdtTmFzdDFoVzAyR2ZvR3M3ZVhqSUF0MjdvOW5BblRF?=
 =?utf-8?B?RkhldXdvTFZCaUhsU3Z6NS9USlIxZ1QyY1hTVklRcktnSXViRzRzRjZnWkN0?=
 =?utf-8?B?Tis4d1VxbUF1ZldrK3BGbzFLMXZGU3pjVkZXbVFUbHc3VVN1KzR1d0Q3RTZR?=
 =?utf-8?B?NEViRnRlMFhzS0k5MUV6bk9lSzNCYWh5TmMwb09vNGpZY2xxSEp6MytVMGpB?=
 =?utf-8?B?R3ZCREUySUdOWjIxWjZpVWRBdjFocmVMWEFmamtGKzA3ckorUFc5MStjcWIz?=
 =?utf-8?B?SUo3MUgxS2RaN3JITmU3YUJqamNXcEFzdUlURjhBdlVxSWN4ekJld2R0VFFp?=
 =?utf-8?B?YmtNSTR5RTF1bHprb0x2ODgvUWFPcWRLcFh0Wnh6R2krYXhrSnpubDd2eDU1?=
 =?utf-8?B?eWRVYnlETktDVmZROTB5SHJCanZxcWxXMHl3eEZPQkdyTkw2SkRDVHU0VzJU?=
 =?utf-8?B?eHdHYnhNTUpjazRLS2xoVzkwdmdyUGszeGZ2Q1VQbS9GK1hsSFpEeDRZaDll?=
 =?utf-8?B?UUFYVlhEM1lYTUJWQWZ5TTdYRkJQcU92TUJ2bmQ4TmsxSFRrcXFJdWMzdndz?=
 =?utf-8?B?ZFBRNFhNOWl6QkFRdWFTZU9GT1NKdS9WQlRJZjJESzZTbW1DZ1lSSnJsNjJk?=
 =?utf-8?B?Si9ta2tFRUx0WVVrQjNoYk1WaTAzSUM5Y0thL1hjVVpFWFlRWTFSSEMveSs1?=
 =?utf-8?B?NW9OT25NRU5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTJZZUpmbXlPMEVnc2JPSEt3VnFHS2dIcVVaZ2RQaEFOdUFjZVdsWDZ2cUEr?=
 =?utf-8?B?VXNkbWRXbVlFQTZ4MWxYaVA2eGEvM2FOV3RVK1FwMUx4Z3BkTTFEMmd0WWpG?=
 =?utf-8?B?MFBpSFJFWlBDSFZRREtiVUFpL0tTNWRQVndGb2MzQmNRQTMyNGZHTVg5d3Za?=
 =?utf-8?B?RGo0V2VzbllCQ1FYdmMyZmJSUWd6ckFWMGxqTWk5a1FoWm9EelJNSmxCWGpQ?=
 =?utf-8?B?VjZRaThmdjh2dG05TitJTWp1MVd4KzBLY21pcnJ0aHI0STcvd3M1VDB4SnRR?=
 =?utf-8?B?VDQvcGRab3Q2NVVoUHl0dVlmcm1UT250eVRJS3ZjcjRONDJtYzhMcE9JcjUy?=
 =?utf-8?B?UDZTQkU0N1liQjNjdWtHNGVQb1VXSkxPckJHSkYzUXEyS1hYK0gxNitNSys0?=
 =?utf-8?B?QUFjY2lwUFRHWHJDWVBkcmJQandVMkpDU0hqekNzMElYU1lJODRreFg2SVlE?=
 =?utf-8?B?Tml4OWhUTHg1OFBhdmJIQ3VNTzZ0bHhrU3pmM3gvMUxmT05HcE5LeW9yWldH?=
 =?utf-8?B?aDJtUjRDaUlrdGYrdktDQkdSWEJpQW1jK245NFZVRk1EV1RxMGhvZGw0bDdr?=
 =?utf-8?B?Y2FzeEgwY1FjVCtBTHFkY1JCMnBISVdDaEVkRWpPZEx4c2lsb1F3NmVmMlVo?=
 =?utf-8?B?Qlpqc0lrUm9wQTQybWtRaVdzSGQ1azRSRmIzWjhWQ3ljS0I3RkcvbG5RWGRK?=
 =?utf-8?B?Z2VoTTEwVm9uOHpoaWhDeU5GYkg5QnVKRmdhQlRFRjd4OFFHZWlKUHVIRmd6?=
 =?utf-8?B?dXRDVG5kdnFGcjhDUjlIOE01SkdJNWV4aFNlUEw0elZZTVV0bWlEdGV6U09z?=
 =?utf-8?B?bDJQeWZBaXU2MWE3dHZFSHpLYlZBRVN5c1VBNXh0bFhZVVFydFBvZTVEdUE0?=
 =?utf-8?B?OUk3NEJJM1dyOExTdXRvWGZEeEdyL2xqZmsvbmZjQ1RMbVNlMG83b0JnR1ZG?=
 =?utf-8?B?T2FvTGcyMTRlV3ZCT0VWdy8wRVU3NDhKSDJmTkZCSU1sS3I3ZGxIOUJQcUlz?=
 =?utf-8?B?VDhDbDJ2a1FnZFgrMzh5SnVML1l5VFJYOEk4ZS84SEw3d2xTRGZ2OWZJNUdF?=
 =?utf-8?B?QUtrbUNkYVpVdlBCNjBBaENkSTlUd0lOelE0aDhKZmkwbXZ0Q2RQcFIxZUQy?=
 =?utf-8?B?UWVkWk9CWU4waXpoNThMU3VEWDRNQjI1WkVBdkdFUWZiZml6UVFmR2ZGb0hj?=
 =?utf-8?B?U0FQSmQzMEZtRHJPQjhwek12YVJ1aGMwbHl4OW82Z0sxOHBOQzJScnJoV1dG?=
 =?utf-8?B?b3JlbVlRK0JUKzJtWHAxb2o2cEZuaGh3RHRHdmVkZHp0TXZzUDA5RTZhYmp6?=
 =?utf-8?B?aDJhWFptdXR1Ykg1dmxyK0pBMHdPSFphSWc3anBORmdQTWFNOUMrNE5yQnZY?=
 =?utf-8?B?dGF4WTN3ZGdUVGZVVUZ3MUZsbFZYekd3YlVXOXpRRG41OTVXeUJFVTRNc0ZL?=
 =?utf-8?B?cmJDVGg4R3ByMTc4dUxZbjc2dmMwUHRxK2ZTSFU0QXZyQkloR0p6YXFYdkhw?=
 =?utf-8?B?bzVDVlRHMWZSKzhvUXd2ZkpVTW9XVHBrcXFxVC9kN0JRYmVXbUZqdGFXNGRK?=
 =?utf-8?B?SVpvSGp3MVRERHRUWFl2RENBcXRHZjdydUFjTWxXMmdpb3pwTG9PN1Z5cit6?=
 =?utf-8?B?K0RSeVhZUmtaUytlK24yZmxDa0lpbjk1RVhGOFhDUkRLRXZJQTVOTmhuQ2s4?=
 =?utf-8?B?L093RzdBUWNvWE5BK20wcmFzSWFlYXYrMGtnKzVnRDRzbTNROFNaSmszV3Nv?=
 =?utf-8?B?Vm1sYkdQelA0R2xqVVRpRVZ1d0Y1bXZCOGdtdWlzYnV4R2hNWCtPb1d2ajEz?=
 =?utf-8?B?NEVOMDd5UDBxbUVaVTQ0b0hHc1crVnlxRHBxQnhRVEE3N2pVVFlucEg4SC9v?=
 =?utf-8?B?SmZLblc0SjV3TWRxR0IwNjV0V3JTdkpTYkUvZk5zVFM0TDFjSmR4ZjhnRmsw?=
 =?utf-8?B?dG1rQjhPenFDcDg3bW5ZalJFUXdtMXVOWTJtNUpucVNjaFpLUkVPY2pTL2pl?=
 =?utf-8?B?MG1sK1hjdEdwUUUrV21VV1MvZHFrYUhGMzA2c1Z6bFdtWGdQbUM2blprZXVi?=
 =?utf-8?B?Z2d6Y0RxRjU0eWlDcjYwMEZHYXkvdjl5SnpVVlh0eVhiM1hNQlB3eWMveGRr?=
 =?utf-8?Q?w1DI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84891c8f-d836-480d-ec2c-08dd9078fc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2025 10:45:46.4823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SYeQQcEv1Z51RP0xu6Tv44R87EW60xm2b5oQtuHIHyTPqW5mu9CKpkU0q3gM3IUtFrlt1FpkxyQMH2hryGUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5386

SGkgU2xhdmEsDQoNCj4gRnJhbmtseSBzcGVha2luZywgaWYgd2Ugd291bGQgbGlrZSB0byByZXdv
cmsgdGhlIGRlYnVnZ2luZyBmcmFtZXdvcmsgaW4gSEZTL0hGUyssIHRoZW4gSSBwcmVmZXIgdG8g
c3dpdGNoIG9uIHByX2RlYnVnKCkgYW5kIHRvIHVzZSBkeW5hbWljIGRlYnVnIGZyYW1ld29yayBv
ZiBMaW51eCBrZXJuZWwgWzFdLiBJdCB3aWxsIHByb3ZpZGUgdGhlIG1vcmUgZmxleGlibGUgc29s
dXRpb24uDQoNCkknbGwgdHJ5IGl0Lg0KDQpCeSB0aGUgd2F5LCBJIHBsYW4gdG8gZXhwb3J0IGRp
c2ssIG1lbSBhbmQgc29tZSBzdGF0aXN0aWNzIHJlbGF0ZWQgaW5mb3JtYXRpb24gdG8gZGVidWdm
cywganVzdCBsaWtlIGYyZnMgZG9lcy4gQW55IHN1Z2dlc3Rpb25zPw0KDQpUaGFua3MsDQouDQo=

