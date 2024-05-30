Return-Path: <linux-fsdevel+bounces-20510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5A68D4893
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 11:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DB6282881
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB516F0EA;
	Thu, 30 May 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="CZaB7oY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2E13DDB4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061494; cv=fail; b=k7rw5T7Pfk3S/Es8Qg5IcOsVlrv22L4C+YUdy5j+VBzTKQjL5cNIYEfnaTnKgThj1XiekfC7IJ7OwTQVpxP1vXoG/yYmHRbbfChpDfztNY4kTw+bmyujCp2xRKUT86a2m8qw7D4Q0XfbgNdwENvUh431ynqag0HPPF/2Q0lqXo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061494; c=relaxed/simple;
	bh=0rDFu1EUIaOvE2LB82+C9odQFbYWmp1E4iZB8L/zMeQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZOJIDqKu6mVoXYzHGQpt/P08KGwRifUYC6xrWD2mIaCyNxZJv5s8daKgPuAR8SCjSggISYKWhSqCWxvPOtFUltTv1gZ5AbvqY/j76Ygn6nnhLhl9WlK4luGpSAK36QU88pTmRUD68LGIsRH6vmQdiDPrkqwpe2cae1rnj38NdWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=CZaB7oY1; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCBFa4jsVeuE2wxfUrNfz8p6wS6/OWc6FU9LTx/YDTX6s+dNKO5NCirsJik9nP7QR5ed7BFU5l9yIbv4EqaDE0UTP6aqnOeqZB2KrFS21Y8iQSBwqs/h2illQOxjKdaZMQBfzBXLitKHBn4fZUMmafjYITq7GVX4iqWUH9LkdTkUGWviT70wBZ4WTvnf14O+5hzu4wcbpcu99Zpt1P5VwYo905gU6cParrJ5SJXep2pytJUlpoKit4KPiTEhp5yMyaq5sHmUo281DbqWGDSrcU0xqQ//z5qLRoWYpddWp2o15bx/FKJk3ULs3HN0d5Qt7CgRYEx+j9VKv+kKBOBqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rDFu1EUIaOvE2LB82+C9odQFbYWmp1E4iZB8L/zMeQ=;
 b=TF0P0LVReC12LwuLNp1acNA3+QYCvM4twv4pe9tCJ7o+185jBCTssDaz6ZtPF1ucVlfN4gN7LlnI8TaR3SJpZhw4GmunjDUDkdpltnMX+Jad91hfHxP4rXRoMxZlYGR4LyShfYDr/zTWIMNLu07F0Q/cymtggizYZlcJ9eG1t134f2tRy1eJUarWH5MaJ3zyGPjRKuHBLwICFQmi3wX0r8wcpamPz/3ZFKfK7ot5aThDLBF01lZQLYoC+QQRrVGTSEVy5sx03VAXhPA8AKScywHVgX/vGPMnY9KdLrDhD4T/zyX2PAitXPc72TDsCOejwP4WIuheYxHdy/iaGEeOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rDFu1EUIaOvE2LB82+C9odQFbYWmp1E4iZB8L/zMeQ=;
 b=CZaB7oY1U5i3+7Pqxx5u7S4Fk2nDht6ez5dNLbdHJJefiPieTzu9H0UStykE9KcgiQHXqADgols3GaRsaGNGcGIC2LHIii+krQniHrSGU78ldi5Vm32Q3XltQtR6RIl1/2Pay+F9ILW+dArIwqx/eFKW3preSGxJjfi7L+EdkdYljDdDBeX0EicFkpSyse9Xw9k9BeGI9zrEfft5214JX97141NeF13a/K1pkhqgYCLG/krEX6ZtkS2IQt/z4GMZYj4qhGRApanoi6IDLyZMRNNmQ0sWFCojWVhIiAh9gMk8SNIVDVHH8+eZEG+FdVVJdre1fys4YB88/AtqYW4YZA==
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by SI2PR06MB5089.apcprd06.prod.outlook.com (2603:1096:4:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:31:27 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:31:27 +0000
From: Lege Wang <lege.wang@jaguarmicro.com>
To: "pgootzen@nvidia.com" <pgootzen@nvidia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: Bin Yang <bin.yang@jaguarmicro.com>, Lege Wang
	<lege.wang@jaguarmicro.com>, Angus Chen <angus.chen@jaguarmicro.com>
Subject: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index: AdqybnzAiozTvtlkQFaloMBVG2WGpw==
Date: Thu, 30 May 2024 09:31:26 +0000
Message-ID:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5385:EE_|SI2PR06MB5089:EE_
x-ms-office365-filtering-correlation-id: c63b81b8-232b-4254-2eab-08dc808b479d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?TWIxTE1sY0h2T1dMTzhHVGxuQ3o2UmdwUjRSWCtMaTZBMXFsTFlwVDFMNU40?=
 =?gb2312?B?Nm5zTWZudVgxeld3bU9jcGk2UDB6VVF3MmNCaDhTZ3dhYlE5NnZZN0JiblVN?=
 =?gb2312?B?MmNFNnhlTVAvQ2hkYnp0S0NKd0RRSEowOEtzWlZNd2JvcUhEQ3ZCYnlGRXc1?=
 =?gb2312?B?WU5UZHVNZk8rTmJoTU4rNzRSVUp4eHFEdC81aWJMMWtNQS9ENldlQ29EZUtq?=
 =?gb2312?B?NkJrN01VaHJGdFVqSnhNS0xzY2Z3QjFWMUNlTjNLMnR4Tm5vQWNrLzdER0FV?=
 =?gb2312?B?aXM4OFJKL3ByMDA0NVRRMXcxUk1kSFFqMjhtaE1YQjF3RW9LMDY2NVd3dWhm?=
 =?gb2312?B?WjFpVEl4T1NOYzllZlNzbFRpaFJOL2l4cnBtQnBkWS9CNVNrM3E2eFBnVlpi?=
 =?gb2312?B?OUIxSHpNOXJuSlVzbXNWWnhadm10QjgvT3RKSU43YTEycXRoNktPc1o1N2Rt?=
 =?gb2312?B?NEk0OWdUZXBYZW1zdzRIeE9QOWNGZlk0OW1sYWZmRkhOeXpXdHBRWG15cm9G?=
 =?gb2312?B?VEd3NitaOE1GMXIzSzU5aTZvRHpRbnRPZ1k3c292Ky9tVm15M2xqTGN5bnBQ?=
 =?gb2312?B?OThuSzVORmw5cmltVjNhTWpGMG1pais2bEV4VVFoNGY2K1UzNTl6cHhvTlRa?=
 =?gb2312?B?QTlCWkh6cENuMnFkUHBkZzc2QzhUeFVFOHkvQnFCZDh5NXlML2Y1SzlpTkdC?=
 =?gb2312?B?cGpPLzErTUtQdEFwc2laWGxndVhlMTN1SVZOTUk0cHVTNjI5SDZJSEtLN1p3?=
 =?gb2312?B?ZDZlSTYrUy9EcmRrOXNPczQzeWhaN3JZUHRQUkV5blQvQmpnb0lCUWUyazhz?=
 =?gb2312?B?eG5VVjd0NDRoN3d4L3U4K0IvWGYwV3FSVUxWMUhSQ2tIYnZobzRMZEJpcHpD?=
 =?gb2312?B?SkZ0S044STZCSzBkWmZOaUJsZkd1bisrY082bmQrdGJhelladVZXWGlwbzkv?=
 =?gb2312?B?NHgwa25RT3RJc3Rqa3YxOXVZelBXeThWRW1yQkFOVlRQNUtFNG9IYVR2eDcr?=
 =?gb2312?B?WVdWbnEyWStWTWdnVFJ1SDg0SXZiZCtjZ25QTDZUUEo5REhNbUNvcmVqZDd0?=
 =?gb2312?B?K2hsNkQzRjk3VUc4d2YrOU1QTytDTVZYcWptZmoyMTlramhtUWF5NVpXbGYx?=
 =?gb2312?B?NHRHa1J0RVpUdzhmSEd6VVkyY2lxamFOR0tmRkcwam5yMStpWjBHb2NMNGl2?=
 =?gb2312?B?MjA2b1g3NHd5MEJoVFA4bTYxRGNmYlpucVhnUnJPancxYlA4SDRmQXRtRXBG?=
 =?gb2312?B?cWZlTnpyUkFxN3hib3poL1pNNVJVeUpNTlI1dkpISWhJeXNsK3Y3aHRvcXdr?=
 =?gb2312?B?dXptUng1VFBEOW9VOUphNlU0UnJMZmY1R2ROTlZnRCtETVA3U1FvVXFoM0dw?=
 =?gb2312?B?aHdGQ1FiWkZsVUhzcTcwOWorcytaYmUxRXh5dk5uRnpyLzBXSUhRNVZqR1VU?=
 =?gb2312?B?S0I5YW80QVVsbkhFcU5wczA5WW1aNTJZdEVkZ2pua0pyYlRveDZkeU03WTBj?=
 =?gb2312?B?WVJSM2xNajdRbVpSZVRKUHRSN0NGblBaZEoxUmt2U3A1VUlPbFJhOHdoWG45?=
 =?gb2312?B?Q1lHMHpXN0d6Z3I5dSttK3JHLzFOVTVnRE03YUdDN1NQQ0U2QStIUklmSE9v?=
 =?gb2312?B?ay9DYlNtR1JGbWo3MjZ6dnZkWW11T01vZnIxRjFpdnlmZm5XUlMvMFVjNmI5?=
 =?gb2312?B?ckI0cGZsNmN6YXVucVVEMmdNR25IZ1k3cytrSnRIcEE0V3czdGE0ekJ4M3FY?=
 =?gb2312?B?N2IrMm9jK1YyandHNUV4T0hRcU9DYlVzV3krNDBVaUtMVkFTVHhiRHd6Y2dO?=
 =?gb2312?B?Z0dNKytaZitianpQdjhTQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UFVIM0RWbHZrWGhUTkFIcHRackhpdmVSckswbFdQZlVkMkJCdDdhcHNVUVFX?=
 =?gb2312?B?ZFdvQlloK0ppWGdXWk5EQVEvVnlSamI5eStGeXRrM28zVkd2UzR6bFJMWXMz?=
 =?gb2312?B?cEtmQ0w2SDlsVllwRWxQYThCVGxDM1l3YXV4ZE9BUUEyd1hVcDErYzlCVGk2?=
 =?gb2312?B?UXViRGdnWXIzZlRrZ08zZ3QzaFB4Y29vRmFCelo1YVpPa3Badnp5TldIVUhz?=
 =?gb2312?B?ZHNpb1RlSjVEQ3RScUs3MVpRaUgwWlBiR2s0SmVCUTlKNDl2Ry83aFBMM2g2?=
 =?gb2312?B?VDF3cnIrcUVuM2piVDNZZ2lBempyTmlCUWRFNThFa3hrV3lWeHdJLzBpYi84?=
 =?gb2312?B?dVk5c2Z5MXJBc0JZVjhpKzNYMGpmakZHT2JLM2lJY0pseDJqQ2ZmRUVadE12?=
 =?gb2312?B?bHFjRTBzNjE5eHVRaEE0WWlFdWRDS3lXbkJOUm15cGFrTFAvOGJUdzJWaTYv?=
 =?gb2312?B?VW1hTmp5ZmNTTHpLZ2xTTVFnUTJxUDBaZVd4MTFzN3d6SXV5UzNabmdWMks2?=
 =?gb2312?B?cG0zRjRDSGNrYVN1UkdONWZpVGsrQUQxMUhiNUlLSG5rVmhidllvT3VoYWow?=
 =?gb2312?B?bGtTekg2SFIzNmtMcVZMWE52Zk5qaU9xV0M3N25WZTVFeEE3blpETld2R3JT?=
 =?gb2312?B?UUpZamJVZ2NDWWhsOC83MzJwcHdlNC9CckhaWjNEbHVZVjgreUJUaDIxZUc4?=
 =?gb2312?B?RVozWnRrYUZwcjl6ck1ETkpYcFduQTVNdEEyeGtKaG15MGNZcHNJbDh6emJp?=
 =?gb2312?B?WWJ2M3Joa2JFUDc0eG9JUGRxeVc5SnVYODIyWGIweE9zbE4yckRKRGlPeUNz?=
 =?gb2312?B?UXBpekQzOWNQVnNENWF5Um02MlZIR0hWdEk5cXJGaDNzUjl6TGVyRUpNellz?=
 =?gb2312?B?djRMVENRcGFlenNtanhFYVRRSVJKRUw5ZHhkRVlpSEVFRUFqSXFma3VSRkt1?=
 =?gb2312?B?bGtwV0diK05nNkptdXFEUUY2NTNBRW5tVUhzOUFMRE9pRjJNYS9TL0hjMnVY?=
 =?gb2312?B?VHM5WlBxUTFFUXd6MmpoOFAxRng3dDFwSDBYV2JQSk9Nc1BmWkRXNnBBZzZx?=
 =?gb2312?B?dlNzKzBBV2IxZjBuU0JocUhGQWtIZVUxc0JaMXdJT3Z5M2NyaDgrZUNrQjF6?=
 =?gb2312?B?R2pIQnRvd2hyVE9vRXBFRHh6cStJTkJ6ZjduMngzbDFITE1hL0s0S3RldkVU?=
 =?gb2312?B?L0ZKTlp2Y0ZGZW03b1FzYTQzalBMK0FSZEtqc01XQWRpOTJoUnlhOVJ0K3h6?=
 =?gb2312?B?Vjd0TG9VZ2Ziekhxb1BSWkYreU5IRDU1bWg5bTR3VThrV3E1Vm8wakxZelcx?=
 =?gb2312?B?VC8zT0Vvd2JUN2hSeko5ZkgvdUxKUlFxeDNJWkNST2wwYjRCZU1BWkh0S0Qz?=
 =?gb2312?B?L1RLQXhXSHh4RThibHArNm1UbTZ2M0lvbFhQRlVSRFRjYVFmM2NyaFZYVkpS?=
 =?gb2312?B?WHgyc2x2cFhCOUZaS3dlTlNpaExlNk5qME1xWjJDSmpsRDVESE1Fa3hXbnJz?=
 =?gb2312?B?U2QzdHFSRUJrS0lWMFZOeXhwUVNGbFlqajQ5NXNxNTNOTm16cGZKcU5mZHRS?=
 =?gb2312?B?RzhKL3hUU211Q3VTQzFKek9UOHBIWGxnczQyZ2YvRHpQRzR0NEEyeEM3WWIz?=
 =?gb2312?B?S05NU1RQRkxDVnFYTzBjOUo4d1JHa29ZdDFpWkdHdVFnMDNNM21aSlpMbEd1?=
 =?gb2312?B?aDg2aXV3Z014QUpHc0ZUZThHRkxuNVBaZlF0RXl3VUpJWXk0WFBZOVVkYzhI?=
 =?gb2312?B?RFNCVHBrUldmeUpidUswYVVBdUlhM21peGtueWJ1YldETmxtKzBOVExFaCsz?=
 =?gb2312?B?Nlo1QXlsaDBHS0pMdFRlS1V1MkdrTjNTOHBtaUc4NVdMUDgrTEtOL0Jxdm5G?=
 =?gb2312?B?ckE2UHplV2I5bHlaZkhQRXRyUVI3Z2pXQmJncjBWaWxiWFhwNW9kcVdQN25u?=
 =?gb2312?B?VXZEY0Nsa0ZnREhidmFFRkVlMUExMjRicXBoLzZ5bjBPTFNyQ1N6SFJNSEFL?=
 =?gb2312?B?VTEwUUVnRGpYTW9zU2xXaTI3d2dqRWpoVVBRbG9NU202VDBlYmtINWxWaE43?=
 =?gb2312?B?cENaY2xSdkR1dzY4b3dqb0FvcjFJRDBUa0o4azNvVTFtbWs2aHUrbXBUQ3N1?=
 =?gb2312?Q?/XxoqNHvs291pzj0AILA/wL58?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63b81b8-232b-4254-2eab-08dc808b479d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 09:31:26.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wra6ma4eB5gTNZdQBamNcHIE6OycBruHpfKeeqPvJO7sFgvfR1N0ltSKJa7riKVymlVuH0jAJOV5ZWQH4dncY2sHXm0xAyXydV5SlPgjXi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5089

SGVsbG8sDQoNCkkgc2VlIHRoYXQgeW91IGhhdmUgYWRkZWQgbXVsdGktcXVldWUgc3VwcG9ydCBm
b3IgdmlydGlvLWZzLCB0aGFua3MgZm9yIHRoaXMgd29yay4NCkZyb20geW91ciBwYXRjaCdzIGNv
bW1pdCBsb2csIHlvdXIgaG9zdCBpcyB4ODYtNjQsIGRwdSBpcyBhcm02NCwgYnV0IHRoZXJlJ3Jl
DQpkaWZmZXJlbmNlcyBhYm91dCBPX0RJUkVDVCBhbmQgT19ESVJFQ1RPUlkgYmV0d2VlbiB0aGVz
ZSB0d28gYXJjaGl0ZWN0dXJlcy4NCg0KVGVzdCBwcm9ncmFtOg0KI2RlZmluZSBfR05VX1NPVVJD
RQ0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxmY250bC5oPg0KDQppbnQgbWFpbih2
b2lkKQ0Kew0KICAgICAgICBwcmludGYoIk9fRElSRUNUOiVvXG4iLCBPX0RJUkVDVCk7DQogICAg
ICAgIHByaW50ZigiT19ESVJFQ1RPUlk6JW9cbiIsIE9fRElSRUNUT1JZKTsNCiAgICAgICAgcmV0
dXJuIDA7DQp9DQoNCkluIHg4Ni02NCwgdGhpcyB0ZXN0IHByb2dyYW0gb3V0cHV0czoNCk9fRElS
RUNUOjQwMDAwDQpPX0RJUkVDVE9SWToyMDAwMDANCg0KQnV0IGluIGFybTY0LCBpdCBvdXRwdXM6
DQpPX0RJUkVDVDoyMDAwMDANCk9fRElSRUNUT1JZOjQwMDAwDQoNCkluIGtlcm5lbCBmdXNlIG1v
ZHVsZSwgZnVzZV9jcmVhdGVfaW4tPmZsYWdzIHdpbGwgdXNlZCB0byBob2xkIG9wZW4oMikncyBm
bGFncywgdGhlbg0KYSBPX0RJUkVDVCBmbGFnIGZyb20gaG9zdCh4ODYpIHdvdWxkIGJlIHRyZWF0
ZWQgYXMgT19ESVJFQ1RPUlkgaW4gZHB1KGFybTY0KSwgd2hpY2gNCnNlZW1zIGEgc2VyaW91cyBi
dWcuDQoNCkZyb20geW91ciBmaW8gam9iLCB5b3UgdXNlIGxpYmFpbyBlbmdpbmUsIHNvIGl0J3Mg
YXNzdW1lZCB0aGF0IGRpcmVjdC1pbyBpcw0KZW5hYmxlZCwgc28gSSB3b25kZXIgd2h5IHlvdSBk
b24ndCBnZXQgZXJyb3JzLiBDb3VsZCB5b3UgcGxlYXNlIHRyeSBiZWxvdw0KY29tbWFuZCBpbiB5
b3VyIHZpcnRpby1mcyBtb3VudCBwb2ludDoNCiAgZGQgaWY9L2Rldi96ZXJvIG9mPXRzdF9maWxl
IGJzPTQwOTYgY291bnQ9MSBvZmxhZz1kaXJlY3QNCnRvIHNlZSB3aGV0aGVyIGl0IG9jY3VycyBh
bnkgZXJyb3IuDQoNClJlZ2FyZHMsDQpYaWFvZ3VhbmcgV2FuZw0K

