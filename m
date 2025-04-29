Return-Path: <linux-fsdevel+bounces-47611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6CAA1112
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9159C46229E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B12241103;
	Tue, 29 Apr 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="posuXIQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C322A811
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942211; cv=fail; b=udDNpYyaOy5hxnVMB8YThanKqFrQmC14pD5PZqrc52xqjdnilAHWFfZCYVCMVZG44vegHl+IKtc5fQFA42lLBwzKLvXJ3GKS9mxMBa5D8ub99EH89YKOPCI/VkLzkaLaOpW0ZiHu/kdXf7xiXnCSDMaCfyO5n6IJGV/KHAmZMi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942211; c=relaxed/simple;
	bh=OFxNZiE1fXKE6g4Os0dRpxhrBpD/S/9DupNdhUCODGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sLKjs0TLVYWrUaYiE4zfQibTH4EPv++AT6L5qJDXUpe8tRs+v0vA7Z0ytz5hWtooJIYTbNztal0fLehSvZKV26j2mIeBu7rNH6VxgsWsvyV4DfJIUg0v3VQXcBwCcg+p0gNJ+0K4ZfNiHKnwftiz55UxPTRxPZ6M9GgCkOBhKyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=posuXIQC; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171]) by mx-outbound13-154.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 29 Apr 2025 15:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keiLP7Hs9es9UL8PlVEZNvG5Vl88iGJQ71b6y5eWb2bt+E3Z+lHsWQUeArKMpmGykzw3Vr9QaLh99lBrI745/xnNNd6YrHavXi4MYbIaXzdkrlHm9A8srKYcMoLSLppkItAMQo8SkzUTH424bMd/NBI3iWQG01YKLPR2PvifjkWO1eLrFgVEXD5euTJQ5PnKhbPPfqEgA6AvmgIiorx7s6+p+720Iu2+bICSEyDHgZf+k7udKg46+bd8A/8sz3ngQjmevKQ1yaFyAyr+IlixZVib6auCboWoSCS7ZxMYvr6NZAmROgSt87UrOcBGWWdKdandwJHa4krVf4GdZKiOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFxNZiE1fXKE6g4Os0dRpxhrBpD/S/9DupNdhUCODGM=;
 b=nsL7ZSZeGuUMTxh/2cE3Nwufe6JC5pr9k7nndiQb83rtOAOOajLZ4qgisF+kHfFR+E3TGocuvB3ii1cVW2wWsxH10C/kriDOVx5uoK5qQvLjjQTK6WjDfkPS3+bPu005ZVK1gxaw7oyOcNz3sRS/7g2AlbOYu0rVYaqkeFMbQdBcc65TpW6OSuX0+JfcXLCuZFZBD2Mfh2O79ua9dLxA+krDksEmPagMs2kwwdDCBEsu52QtBukweLbaODwzNVyfy5Rg19/VnvU1uPn4c6ZhnU0vx+iSInU3P+tsGX6T+JPaP9SmfIJPFyJ9gh2TTuaxGltk0IPdqPK4e3VUA8JELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFxNZiE1fXKE6g4Os0dRpxhrBpD/S/9DupNdhUCODGM=;
 b=posuXIQCtp7OhrnjabVa/1akKA3znycBtGtjpocTg77NkVqMXvGpZa5L9e93y5szMHZVB+3HZH4UQEcJvw+4Putr+dqvXvxcrDJWB/1sOl9RzGWd1truIzi9mXQCjj/q2uLEMtirylKH2a+FkgtGcbRb8nnff9VYvLoHUHMiCsQ=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DS4PPF37877C505.namprd19.prod.outlook.com (2603:10b6:f:fc00::a18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Tue, 29 Apr
 2025 14:23:33 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8699.019; Tue, 29 Apr 2025
 14:23:32 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Guang Yuan Wu <gwu@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "mszeredi@redhat.com" <mszeredi@redhat.com>, Miklos Szeredi
	<miklos@szeredi.hu>
Subject: Re: [PATCH V2] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Topic: [PATCH V2] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbsqdpbIQNZ4vtCE2uHg9CBeFxc7O6v0IA
Date: Tue, 29 Apr 2025 14:23:32 +0000
Message-ID: <21c22c82-8381-4aa0-97f8-7c3b8df901e8@ddn.com>
References:
 <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
 <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
 <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
 <CAJfpeguiPW-1BSryqbkisH7k1sxp-REszYubPFaA2eFc-7kT8g@mail.gmail.com>
 <0e1a8384-4be4-4875-a4ed-748758e6370e@ddn.com>
 <62a4a1dd-124a-4576-9138-cdf1d4cbb638@ddn.com>
In-Reply-To: <62a4a1dd-124a-4576-9138-cdf1d4cbb638@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DS4PPF37877C505:EE_
x-ms-office365-filtering-correlation-id: 466e7b23-febe-4cb5-b31b-08dd87296bac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RWZZWGhSeDdMaEplcFdIUUhCMUI4N3FPSmNpRjdtKytVWUdjUDFETTErY3ZC?=
 =?utf-8?B?WE5MaGpTQTVBQUY4UkdHcmZUYXhMN0I5WG53bUlKK0swcTRVazRZUitFeEdH?=
 =?utf-8?B?SE5EWnJhMUZOc1JIMTBueHVHTXBDbkcwWDdLcUV6dExPaFB1c201NTZLUUdV?=
 =?utf-8?B?VzNUNnFkcFpaVzBVU0RhblUzSXJaNlo5eGcyWDFwU2JtNG1vaGVrZ0IwVmYy?=
 =?utf-8?B?Rlh1MzFpL2JnVFZlS3hna3hiWUVXL3RSWlBKdklPWE5sOUpFS0tWcDVUeDNs?=
 =?utf-8?B?NDRDNzRVTzJ0R0VGSEcxd1VNVzB5cVZpNERUazUyVnJLTzhMZkZWQVQ4K1V6?=
 =?utf-8?B?bUxhQU1HelE4c09iTnE4MVIwQnhYbGhvK0VwK3g2MFNyRVJYWVpialgzU1Jx?=
 =?utf-8?B?MEJPb3FkYWVVbXJad0RaUWRTK21xeitTaUEreWJMWUR0Yy9iSVZ1MlNvam5n?=
 =?utf-8?B?Z21jY01RU0RoT25acmdIVExQSGFNdVBZZVZWdjFGT3BScmNIS0I1ZlhtOGNU?=
 =?utf-8?B?UFhFVTRyYmloaHFrUlpaTFNadk11VVBOQUxDdUN0c3l3U2dOTjlVQ3BpbTF3?=
 =?utf-8?B?bXI2bXNoQ1BGL0lCc1dSZHNhVk5aQlBvZ0pHUEg4MVNuMytBVk85MDdkWWxX?=
 =?utf-8?B?VHQyeVFFbys1TGdmcDNuYnNKaHYvTzk1TWQreTNyM3kzbUZHZkQySHFmcmxu?=
 =?utf-8?B?VVlPRjVtdDlxNUl5UytpWkpyYjJpRTdRSnBWa2VCZ3hOcWVlanEvU1orVW9N?=
 =?utf-8?B?bHdpNEVZa0NZMVBVcE5CYnM0TU16R3JENTFaM0ZQMzRjclVoZ2Mwb2JLZGJ6?=
 =?utf-8?B?bGg4ZkNGanBYQlIyRmo3OUVPdm1FWjNBT3p0VzVRWDNEWlVReFB3N0xLVE5S?=
 =?utf-8?B?ZzdpS1NMUUl3MVVIQ3FTaXVhZEtNUkRFbkpmYlU3L0VRZVZ5enVBdmdsWElP?=
 =?utf-8?B?Wm9sckQvZXU2VENqMFRYa2Y1ODFRcXJ4NjRCcG84VWcwU28zODJ5dkl3ekw1?=
 =?utf-8?B?dVlVSWdkTUt1VlBXakFJblR5b3JGR3BmamNQRjZTcmFFdjhhd25HYmVmNkN5?=
 =?utf-8?B?cEh6VVlldmFWZ3dnNGRXTm9jKzBuMXdqRVFZT2k4RFh5SGtWdEsrdzlKMXVT?=
 =?utf-8?B?Uzd1SWtMNnVsYkNaS3FYTW9vaHVobHVZVTFQRXc3VkVEMHZFdWlDMHYrSGZi?=
 =?utf-8?B?MElkbDdDNkI5ME8rdTZzOWExZ1BqUkVUK0V2THpJSmU2ZTY4bWZLYk8rNG1z?=
 =?utf-8?B?WHlnbFRrejVmL3B6RUl4Q25ZZTExcnFjcU9RbmpmZXNkU0NFdVM3MFFhYmFu?=
 =?utf-8?B?N3JGbVhCUFN3Nk9kZEQyNWlCRVdBNE9YTkRueWNPRjB3MW9FT1pEQzZEdXd2?=
 =?utf-8?B?Y28weFlXb2tVWndXVjdBWUJEYVJFZEEwR3c4ZzluOFNUY2EzSnJYdlhyOU9l?=
 =?utf-8?B?NEVmVitmVzFqLzNsTXFLQktWV1drVXFab2ZsUkFZTTVHcXkyYWYvUEtBaHZ0?=
 =?utf-8?B?dGVocDE4VFBlWGhYQ09QVS9SUE01WHNlWnZaRFJ2Si81RExVditiWnByRFZk?=
 =?utf-8?B?cTZjQTIrQlhlaCsxYmo1UFRJVzRWRjVNYXNON3hpODRZN2RDTGhsWGlDRXNG?=
 =?utf-8?B?SzlUNlJhVEJwa29HRDVkb0wzZWpUVjNZWno1eEltcVRscEFscnZxaHdab1lY?=
 =?utf-8?B?TDgzZ0dxak9NcS9WbjN0QkpESmwwb3lGeGJRdmVFY2ZTVi8wNGJ4K1B4K24x?=
 =?utf-8?B?bGhUZXBiQ0VxRDBJd1ZjS21OY3lDU1FWeWw2MGw4WnRYVXVPemZ1ZjMwanFZ?=
 =?utf-8?B?UU9YZUVrODRZclpPRmpLL1U4L0RYaWJLd2dTcWUrVkZXM0RpbC9PS0JhUE9D?=
 =?utf-8?B?R3JCNmlyaVQxblFSai9HK3dEb0laZHBjSXlYWG9oajZPbEhJc2c5SjV4SE9x?=
 =?utf-8?B?UFU1YmNOaSt5VERuaVAwNmx1NGdjdVpEcWhBYUtnMjNGU25SeWl2TjB4MlpX?=
 =?utf-8?B?Rkx6eEI4cVZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0k3SjBmTW02d1duOFAvR1RvNU52MGZGNWxvKzBwNnZrSUM5TzQ1S3ZSYkRW?=
 =?utf-8?B?b2xFeWlOdmkvY21SUllpMmZmNmxTejFFUys2aUNwSCtyTks3c3F6RDYwVWxi?=
 =?utf-8?B?VVV3WU4xeXZoaW9hUHNHZHRZOHRPOHR1TWo5TURsTTNvb0MyS0JoKy8ycnVS?=
 =?utf-8?B?cnFLVzlid3NTcmluUXVpblZuaE8zd0hLSHcySTI2VmZsdDliSU05WjRyblll?=
 =?utf-8?B?UWRpRU8rbW1nQUhjVlE2dllyazRrTElSem1uaUNNR0JVcVBRb01wUCt4UUdt?=
 =?utf-8?B?TmNCNjgreUtkM2pEaHRaalhNOGtwOHE5YzZMUGtoV1U1T3hROHVuMEdzbjBK?=
 =?utf-8?B?RjJuNVZYb2NyOG5VVGlRd2dkRzI1YXB1bWIzNHdHR292RVdLc3JCL2hhRE1Y?=
 =?utf-8?B?NFVBMGo2VHJvc2MxNkhYQmEwRjlMcGpQUXVyWkxMV1FCK01neGhkVVRDRm9a?=
 =?utf-8?B?NnRKZ21laEFJc21UK05xbFduanlTSGF1NWxMRVVrZ2I2QzFmU1ZhSFdtTHBl?=
 =?utf-8?B?cnRQTkFYZFZiZktwQjg2ZzRYVUdMWDdmdXRSMVJOVEdXMlZrWjlLMVNPNGlU?=
 =?utf-8?B?NisxT3ptVGxSRDJaSjg3UGJDaXVhNEpqcXk4YWwrbkczbm5XUHd6UXRlcFM4?=
 =?utf-8?B?OFFSMHR2ZWZud1dPalhibWpKc3VOeFlMNGhkTkJJUnNVU2hKZWtUakszUXRH?=
 =?utf-8?B?Z1UyeWFxbTZjVHk5bnczMVZkTEZ4RXdXQk8yVDV0VHo3eExwRG5iWVNMV0FP?=
 =?utf-8?B?OWxVOFU0blZOYS9vR1JxQW1rTDZPalJtV3A4WXVRVE5tUDk0bllpenVsbkhR?=
 =?utf-8?B?K2s0aDRHU2ZJSlhuRjZQQkpVQ1BIYzF0SzVNRVhTMGhtTDJNbHg4Y25COEJm?=
 =?utf-8?B?VUJWcWlhVnlCaGtPbFRUQmRkdlFoL1VjUGszUVFLYlVGU3RmSERJZkpRUGpD?=
 =?utf-8?B?QnBCbWg0RzM2ZDNoR0I3dnNQL0Voc3FmOEFFUTB1SzlCRC9iNTJ0TzcxNjdJ?=
 =?utf-8?B?elFQdEJTb3JDY093TVVsVkRlZDQrTU4vUnByMGZ0SENzSXowQjZwU3A4WW9W?=
 =?utf-8?B?SFhWSERhT2RLL3Y4UU0rOVY5WXRYL3FRb05CZlpwN3lnb3dGbFJ0QWFWb0lj?=
 =?utf-8?B?bUgzMDZnaUM5YVk2Wkw0MnVFM1pvWEYzMDBPcEhTZlJ3bU1PdDJVc0MzTEhw?=
 =?utf-8?B?NVA1UHdPcUd4TENaU09ORWhidWg1V09uRmNOUHNocTFmSUlrQ29RYXVFakht?=
 =?utf-8?B?dm5palZ0QWREQ1JEQTErNGY5S3h0WXBMQlVJNWNPemJ0OTBUaFVwUjZIWGhK?=
 =?utf-8?B?Wk44RDU5UWNOS0Y2a2ZoKzlFMjBZMDlHZnNzVTJoMGFwNXJtQlM4SHdMRTB6?=
 =?utf-8?B?U2Z4ek1nQjNXMUVvcjI1RlRiY3BXWWRxYWFhc01NZlM0SDh2Q1prRzNZdUZN?=
 =?utf-8?B?dHkyZDZYczJZcFN3VlErT2MzbXRuK0FwdGY0Y1EzWXJDZlEwU1R1VWt1UGVH?=
 =?utf-8?B?WFRZLzkvUWtCS3dWYUdZWXpjNnE3K3gwUENZT2c0ckhOeWhvZmVjd1FEYVFV?=
 =?utf-8?B?YVE5NHc2RlBlNnVDMlhHYTRqM1liMnY0TkduUFBNR2xFak5qNFhReExyNGpx?=
 =?utf-8?B?ZXBjUmdPTzdOMzJweThBT1RXWVo2TlNDeGZ3b0JLN2srL1FSMFFCOWdUTkVk?=
 =?utf-8?B?TWgyZW5iU3lZSmNuYSszclZZTUNhcStMTHoxNGVaRit5QmY0ZjI4WUEvV2R6?=
 =?utf-8?B?VVlEMjZTTXZ3ZktHSkRuOVpZcnE3M1FIS0NaWWhOanFZQXd1a3hVOVFSNWdI?=
 =?utf-8?B?eW5sS1hwY2JSR0t4M2YwU3hRTGc3SFYzVElOT3NLY3V2aUk5bVZGT1lyZVZm?=
 =?utf-8?B?RzFHNG5EU2pZeUxrSWxnZkRobHVFMkdhUXhselZ4UWFycmFrb0dwZE02bEZi?=
 =?utf-8?B?Smo4ejdMSDFHbTk3eFRjOHI3MVNDRXFtVno4NW1seG5ZaGxIS054dkFpNWUr?=
 =?utf-8?B?TjU2U2ZJNjdmU1ZQN0ZKcmdjZlhEeUxlYTBSaW5ZeWtMNEJMc1VKK3dtSUxI?=
 =?utf-8?B?eTVmeXRhbjVrMFIxaEJTZ3RkVVRTY1pnejArOEJzcXhGNHpCM0FWcTFGdkZD?=
 =?utf-8?Q?/MOI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB75517E3825034D9D7E88AC4D862C4E@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	odI7SENnWHL4gCuQ4E5sZEUVZZZBbr/BXeEs9QU/4Kp2S9GS2TkP6hir6pFPEltKvIT795+JYzJmVtKn8Cw1V4xzbn37koqkv/OAiSOVwjMfDtlt2G0c8fMT9OidWWDkmVeC1Oni6yg4BayZabKV582T7ijtBq6Cjax+5HAfTL1EDPXj9qgmw0L6pOM7LJBvRndqtmIqO2FfFnBZUHPNSgwMEZCvWmVWmg98rRQUnFtbz+dM6B4BRKPD86k9h5iReQxrvaLfFrsk286eQICR6ntN7+4Z+CeoYZ+eNz6+Sym8K3mUNq/6D7Qy0Igav8/EdSiTHfDTWFaCkWQXR5AcsR8F9hwqSdmejjWLzf3PXN573cGafxKxsM/GNnrShB90KJpaTB/mDfOCG195+Xh+frYtPILs7GdTB5N42kUVFjAi4pHFGsTRxsXqUtxJryc1PP4+U1QOMgjg1ysnuYs7Hg7z8c0JP6B+0+ZqyJWmqvDrtXdVSDiDLhypY0DSC07ERYSV4gEfpZIopY1cOY7KSzFD/UPqEM0Fcjhh27jdY43+syZoZXGGxlXuaj+l8C8agcVgZiKZNLBvacCp8K5CuangFoznK0fjUpm0375Jj9VTfvN64I93c5uBwQEI1foTjppRA8ulA6dlc0ZU3MiiAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466e7b23-febe-4cb5-b31b-08dd87296bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 14:23:32.5963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ym/a7yMF8zq5vNy4k/9penKzR4VdVW5Lf6u8RUBJEyhGx5rZrdGQHZ+onKIACYPguLbiDe99w4nQeTd6yvs6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF37877C505
X-OriginatorOrg: ddn.com
X-BESS-ID: 1745942207-103482-4881-6064-1
X-BESS-VER: 2019.1_20250422.2023
X-BESS-Apparent-Source-IP: 104.47.57.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmamlpZAVgZQ0NLEKDnRyNgi2d
	I4ydLIzMQgydgkzcjEwszQzNI4NTFVqTYWAKUyHwpBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.264237 [from 
	cloudscan13-255.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNC8yMS8yNSAxMjoyMywgR3VhbmcgWXVhbiBXdSB3cm90ZToNCj4gSGkgYWxsLA0KPiANCj4g
T24gNC8xNi8yMDI1IDY6MTggUE0sIEd1YW5nIFl1YW4gV3Ugd3JvdGU6DQo+Pg0KPj4NCj4+IE9u
IDQvMTUvMjAyNSA5OjEzIFBNLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4+PiBbWW91IGRvbid0
IG9mdGVuIGdldCBlbWFpbCBmcm9tIG1pa2xvc0BzemVyZWRpLmh1LiBMZWFybiB3aHkgdGhpcyBp
cyANCj4+PiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCj4+Pg0KPj4+IE9uIFR1ZSwgMTUgQXByIDIwMjUgYXQgMDQ6MjgsIEd1YW5n
IFl1YW4gV3UgPGd3dUBkZG4uY29tPiB3cm90ZToNCj4+Pg0KPj4+PiBJIHRob3VnaCBhYm91dCB0
aGlzIC4uLg0KPj4+PiBBY3R1YWxseSwgRlVTRV9JX1NJWkVfVU5TVEFCTEUgY2FuIGJlIHNldCBj
b25jdXJyZW50bHksIGJ5IHRydW5jYXRlIA0KPj4+PiBhbmQgb3RoZXIgZmxvdywgYW5kIGlmIHRo
ZSBiaXQgaXMgT05MWSBzZXQgZnJvbSB0cnVuY2F0ZSBjYXNlLCB3ZSANCj4+Pj4gY2FuIHRydXN0
IGF0dHJpYnV0ZXMsIGJ1dCBvdGhlciBmbG93IG1heSBzZXQgaXQgYXMgd2VsbC4NCj4+Pg0KPj4+
IEZVU0VfSV9TSVpFX1VOU1RBQkxFIGlzIHNldCB3aXRoIHRoZSBpbm9kZSBsb2NrIGhlbGQgZXhj
bHVzaXZlLsKgIElmDQo+Pj4gdGhpcyB3YXNuJ3QgdGhlIGNhc2UsIHRoZSBGVVNFX0lfU0laRV9V
TlNUQUJMRSBzdGF0ZSBjb3VsZCBiZWNvbWUNCj4+PiBjb3JydXB0ZWQgKGkuZSBpdCBkb2Vzbid0
IG5lc3QpLg0KPj4NCj4+IFRoYW5rcy4NCj4+DQo+PiBmb3IgdHJ1bmNhdGUsIGlub2RlIGxvY2sg
aXMgYWNxdWlyZWQgaW4gZG9fdHJ1bmNhdGUoKS4gKG5vdCBpbiBpX29wIC0gDQo+PiDCoD5zZXRh
dHRyKCkpDQo+Pg0KPj4gb3RoZXJzIChmb3IgZXhhbXBsZSwgZmFsbG9jYXRlKSwgaW5vZGUgbG9j
ayBpcyBhY3F1aXJlZCBpbiBmX29wLSANCj4+IMKgPmZhbGxvY2F0ZSgpDQo+Pg0KPj4gU28sIEkg
dGhpbmsgRlVTRV9JX1NJWkVfVU5TVEFCTEUgY2hlY2sgY2FuIGJlIHJlbW92ZWQgZnJvbToNCj4+
DQo+PiDCoMKgwqDCoCBpZiAoKGF0dHJfdmVyc2lvbiAhPSAwICYmIGZpLT5hdHRyX3ZlcnNpb24g
PiBhdHRyX3ZlcnNpb24pIHx8DQo+PiDCoMKgwqDCoMKgwqDCoMKgIHRlc3RfYml0KFJFREZTX0lf
U0laRV9VTlNUQUJMRSwgJmZpLT5zdGF0ZSkpDQo+PiDCoMKgwqDCoMKgwqDCoMKgIC8qIEFwcGx5
aW5nIGF0dHJpYnV0ZXMsIGZvciBleGFtcGxlIGZvciBmc25vdGlmeV9jaGFuZ2UoKSAqLw0KPj4g
wqDCoMKgwqDCoMKgwqDCoCBpbnZhbGlkYXRlX2F0dHIgPSB0cnVlOw0KPj4NCj4+Pg0KPj4+IFRo
YW5rcywNCj4+PiBNaWtsb3MNCj4+DQo+PiBSZWdhcmRzDQo+PiBHdWFuZyBZdWFuIFd1DQo+Pg0K
PiANCj4gQWZ0ZXIgYWRkcmVzcyBCZXJuZCdzIGFuZCBNaWtsb3MncyBjb21tZW50IChSZW1vdmFs
IG9mIA0KPiBGVVNFX0lfU0laRV9VTlNUQUJMRSBjaGVjayBhbmQgYWRkIHNvbWUgY29tbWVudCks
IHVwZGF0ZSB0aGUgcGF0Y2ggYXMgDQo+IGJlbG93Og0KPiANCj4gVjI6DQo+IA0KPiAgwqDCoMKg
IGZ1c2U6IGZpeCByYWNlIGJldHdlZW4gY29uY3VycmVudCBzZXRhdHRycyBmcm9tIG11bHRpcGxl
IG5vZGVzDQo+IA0KPiAgwqDCoMKgIFdoZW4gbW91bnRpbmcgYSB1c2VyLXNwYWNlIGZpbGVzeXN0
ZW0gb24gbXVsdGlwbGUgY2xpZW50cywgYWZ0ZXINCj4gIMKgwqDCoCBjb25jdXJyZW50IC0+c2V0
YXR0cigpIGNhbGxzIGZyb20gZGlmZmVyZW50IG5vZGUsIHN0YWxlIGlub2RlIA0KPiBhdHRyaWJ1
dGVzDQo+ICDCoMKgwqAgbWF5IGJlIGNhY2hlZCBpbiBzb21lIG5vZGUuDQo+IA0KPiAgwqDCoMKg
IFRoaXMgaXMgY2F1c2VkIGJ5IGZ1c2Vfc2V0YXR0cigpIHJhY2luZyB3aXRoIA0KPiBmdXNlX3Jl
dmVyc2VfaW52YWxfaW5vZGUoKS4NCj4gDQo+ICDCoMKgwqAgV2hlbiBmaWxlc3lzdGVtIHNlcnZl
ciByZWNlaXZlcyBzZXRhdHRyIHJlcXVlc3QsIHRoZSBjbGllbnQgbm9kZSB3aXRoDQo+ICDCoMKg
wqAgdmFsaWQgaWF0dHIgY2FjaGVkIHdpbGwgYmUgcmVxdWlyZWQgdG8gdXBkYXRlIHRoZSBmdXNl
X2lub2RlJ3MgDQo+IGF0dHJfdmVyc2lvbg0KPiAgwqDCoMKgIGFuZCBpbnZhbGlkYXRlIHRoZSBj
YWNoZSBieSBmdXNlX3JldmVyc2VfaW52YWxfaW5vZGUoKSwgYW5kIGF0IHRoZSANCj4gbmV4dA0K
PiAgwqDCoMKgIGNhbGwgdG8gLT5nZXRhdHRyKCkgdGhleSB3aWxsIGJlIGZldGNoZWQgZnJvbSB1
c2VyLXNwYWNlLg0KPiANCj4gIMKgwqDCoCBUaGUgcmFjZSBzY2VuYXJpbyBpczoNCj4gIMKgwqDC
oMKgwqAgMS4gY2xpZW50LTEgc2VuZHMgc2V0YXR0ciAoaWF0dHItMSkgcmVxdWVzdCB0byBzZXJ2
ZXINCj4gIMKgwqDCoMKgwqAgMi4gY2xpZW50LTEgcmVjZWl2ZXMgdGhlIHJlcGx5IGZyb20gc2Vy
dmVyDQo+ICDCoMKgwqDCoMKgIDMuIGJlZm9yZSBjbGllbnQtMSB1cGRhdGVzIGlhdHRyLTEgdG8g
dGhlIGNhY2hlZCBhdHRyaWJ1dGVzIGJ5DQo+ICDCoMKgwqDCoMKgwqDCoMKgIGZ1c2VfY2hhbmdl
X2F0dHJpYnV0ZXNfY29tbW9uKCksIHNlcnZlciByZWNlaXZlcyBhbm90aGVyIHNldGF0dHINCj4g
IMKgwqDCoMKgwqDCoMKgwqAgKGlhdHRyLTIpIHJlcXVlc3QgZnJvbSBjbGllbnQtMg0KPiAgwqDC
oMKgwqDCoCA0LiBzZXJ2ZXIgcmVxdWVzdHMgY2xpZW50LTEgdG8gdXBkYXRlIHRoZSBpbm9kZSBh
dHRyX3ZlcnNpb24gYW5kDQo+ICDCoMKgwqDCoMKgwqDCoMKgIGludmFsaWRhdGUgdGhlIGNhY2hl
ZCBpYXR0ciwgYW5kIGlhdHRyLTEgYmVjb21lcyBzdGFsZWQNCj4gIMKgwqDCoMKgwqAgNS4gY2xp
ZW50LTIgcmVjZWl2ZXMgdGhlIHJlcGx5IGZyb20gc2VydmVyLCBhbmQgY2FjaGVzIGlhdHRyLTIN
Cj4gIMKgwqDCoMKgwqAgNi4gY29udGludWUgd2l0aCBzdGVwIDIsIGNsaWVudC0xIGludm9rZXMg
DQo+IGZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXNfY29tbW9uKCksDQo+ICDCoMKgwqDCoMKgwqDCoMKg
IGFuZCBjYWNoZXMgaWF0dHItMQ0KPiANCj4gIMKgwqDCoCBUaGUgaXNzdWUgaGFzIGJlZW4gb2Jz
ZXJ2ZWQgZnJvbSBjb25jdXJyZW50IG9mIGNobW9kLCBjaG93biwgb3IgDQo+IHRydW5jYXRlLA0K
PiAgwqDCoMKgIHdoaWNoIGFsbCBpbnZva2UgLT5zZXRhdHRyKCkgY2FsbC4NCj4gDQo+ICDCoMKg
wqAgVGhlIHNvbHV0aW9uIGlzIHRvIHVzZSBmdXNlX2lub2RlJ3MgYXR0cl92ZXJzaW9uIHRvIGNo
ZWNrIHdoZXRoZXIgdGhlDQo+ICDCoMKgwqAgYXR0cmlidXRlcyBoYXZlIGJlZW4gbW9kaWZpZWQg
ZHVyaW5nIHRoZSBzZXRhdHRyIHJlcXVlc3QncyANCj4gbGlmZXRpbWUuIElmIHNvLA0KPiAgwqDC
oMKgIG1hcmsgdGhlIGF0dHJpYnV0ZXMgYXMgc3RhbGUgYWZ0ZXIgZnVzZV9jaGFuZ2VfYXR0cmli
dXRlc19jb21tb24oKS4NCj4gDQo+ICDCoMKgwqAgU2lnbmVkLW9mZi1ieTogR3VhbmcgWXVhbiBX
dSA8Z3d1QGRkbi5jb20+DQo+ICDCoMKgwqAgUmV2aWV3ZWQtYnk6IEJlcm5kIFNjaHViZXJ0IDxi
c2NodWJlcnRAZGRuLmNvbT4NCj4gIMKgwqDCoCBSZXZpZXdlZC1ieTogTWlrbG9zIFN6ZXJlZGkg
PG1zemVyZWRpQHJlZGhhdC5jb20+DQoNCg0KU29ycnkgZm9yIG15IGxhdGUgcmVwbHksIGhhZCBz
bGlwcGVkIHRocm91Z2guDQoNCkknbSBraW5kIG9mIG9rIHdpdGggYWRkaW5nIG15ICBSZXZpZXdl
ZC1ieSBsaW5lLCBidXQgYmV0dGVyIG5vdCBpbiBhZHZhbmNlLg0KTWlrbG9zIGFsc28gZGlkbid0
IGFkZCBoaXMgUmV2aWV3ZWQtYnkuDQoNCklzc3VlIHdpdGggdGhlIHBhdGNoIGlzIHRoYXQgaXQg
ZG9lcyBub3QgYXBwbHkNCg0KIyBiNCBhbSA2MmE0YTFkZC0xMjRhLTQ1NzYtOTEzOC1jZGYxZDRj
YmI2MzhAZGRuLmNvbQ0KIyBic2NodWJlcnQyQGltZXNydjYgbGludXguZ2l0PmdpdCBhbSAtLTN3
YXkgLi92Ml8yMDI1MDQyMV9nd3VfZnNfZnVzZV9maXhfcmFjZV9iZXR3ZWVuX2NvbmN1cnJlbnRf
c2V0YXR0cl9mcm9tX211bHRpcGxlX25vZGVzLm1ieA0KQXBwbHlpbmc6IGZzL2Z1c2U6IGZpeCBy
YWNlIGJldHdlZW4gY29uY3VycmVudCBzZXRhdHRyIGZyb20gbXVsdGlwbGUgbm9kZXMNCmVycm9y
OiBjb3JydXB0IHBhdGNoIGF0IGxpbmUgMTENCmVycm9yOiBjb3VsZCBub3QgYnVpbGQgZmFrZSBh
bmNlc3Rvcg0KDQpBbmQgdGhlbiBsb29raW5nIGF0IHRoZSBwYXRjaCwgSSB0aGluayBhbGwgdGFi
cyBhcmUgY29udmVydGVkIHRvDQpzcGFjZXMgLSBkb2Vzbid0IHdvcmsuDQoNCj4gDQo+IC0tLQ0K
PiAgwqBmcy9mdXNlL2Rpci5jIHwgMTIgKysrKysrKysrKysrDQo+ICDCoDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMg
Yi9mcy9mdXNlL2Rpci5jDQo+IGluZGV4IDgzYWMxOTJlN2ZkZC4uMGNjNWEwN2E0MmU2IDEwMDY0
NA0KPiAtLS0gYS9mcy9mdXNlL2Rpci5jDQo+ICsrKyBiL2ZzL2Z1c2UvZGlyLmMNCj4gQEAgLTE5
NDYsNiArMTk0Niw4IEBAIGludCBmdXNlX2RvX3NldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRt
YXAsIA0KPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+ICDCoMKgwqDCoMKgwqDCoCBpbnQgZXJy
Ow0KPiAgwqDCoMKgwqDCoMKgwqAgYm9vbCB0cnVzdF9sb2NhbF9jbXRpbWUgPSBpc193YjsNCj4g
IMKgwqDCoMKgwqDCoMKgIGJvb2wgZmF1bHRfYmxvY2tlZCA9IGZhbHNlOw0KPiArwqDCoMKgwqDC
oMKgIGJvb2wgaW52YWxpZGF0ZV9hdHRyID0gZmFsc2U7DQo+ICvCoMKgwqDCoMKgwqAgdTY0IGF0
dHJfdmVyc2lvbjsNCj4gDQo+ICDCoMKgwqDCoMKgwqDCoCBpZiAoIWZjLT5kZWZhdWx0X3Blcm1p
c3Npb25zKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0dHItPmlhX3ZhbGlk
IHw9IEFUVFJfRk9SQ0U7DQo+IEBAIC0yMDMwLDYgKzIwMzIsOCBAQCBpbnQgZnVzZV9kb19zZXRh
dHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCANCj4gc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0K
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChmYy0+aGFuZGxlX2tpbGxwcml2
X3YyICYmICFjYXBhYmxlKENBUF9GU0VUSUQpKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmFyZy52YWxpZCB8PSBGQVRUUl9LSUxMX1NVSURHSUQ7
DQo+ICDCoMKgwqDCoMKgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoMKgwqDCoCBhdHRyX3ZlcnNpb24g
PSBmdXNlX2dldF9hdHRyX3ZlcnNpb24oZm0tPmZjKTsNCj4gIMKgwqDCoMKgwqDCoMKgIGZ1c2Vf
c2V0YXR0cl9maWxsKGZjLCAmYXJncywgaW5vZGUsICZpbmFyZywgJm91dGFyZyk7DQo+ICDCoMKg
wqDCoMKgwqDCoCBlcnIgPSBmdXNlX3NpbXBsZV9yZXF1ZXN0KGZtLCAmYXJncyk7DQo+ICDCoMKg
wqDCoMKgwqDCoCBpZiAoZXJyKSB7DQo+IEBAIC0yMDU1LDkgKzIwNTksMTcgQEAgaW50IGZ1c2Vf
ZG9fc2V0YXR0cihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgDQo+IHN0cnVjdCBkZW50cnkgKmRl
bnRyeSwNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGSVhNRTogY2xlYXIg
SV9ESVJUWV9TWU5DPyAqLw0KPiAgwqDCoMKgwqDCoMKgwqAgfQ0KPiANCj4gK8KgwqDCoMKgwqDC
oCBpZiAoYXR0cl92ZXJzaW9uICE9IDAgJiYgZmktPmF0dHJfdmVyc2lvbiA+IGF0dHJfdmVyc2lv
bikNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQXBwbHlpbmcgYXR0cmlidXRl
cywgZm9yIGV4YW1wbGUgZm9yIA0KPiBmc25vdGlmeV9jaGFuZ2UoKSAqLw0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbnZhbGlkYXRlX2F0dHIgPSB0cnVlOw0KPiArDQo+ICDCoMKg
wqDCoMKgwqDCoCBmdXNlX2NoYW5nZV9hdHRyaWJ1dGVzX2NvbW1vbihpbm9kZSwgJm91dGFyZy5h
dHRyLCBOVUxMLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQVRUUl9USU1FT1VUKCZvdXRhcmcpLA0K
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZnVzZV9nZXRfY2FjaGVfbWFzayhpbm9kZSksIDApOw0KDQpX
ZSBjb3VsZCBhbHNvIHNwZWNpZmljIDAgYXMgdGltZW91dC4NCg0KZnVzZV9jaGFuZ2VfYXR0cmli
dXRlc19jb21tb24oaW5vZGUsICZvdXRhcmcuYXR0ciwgTlVMTCwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW52YWxpZGF0ZV9hdHRyID8gMCA6IEFUVFJfVElNRU9VVCgmb3V0YXJn
KSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnVzZV9nZXRfY2FjaGVfbWFzayhp
bm9kZSksIDApOw0KDQo+ICsNCj4gK8KgwqDCoMKgwqDCoCBpZiAoaW52YWxpZGF0ZV9hdHRyKQ0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmdXNlX2ludmFsaWRhdGVfYXR0cihpbm9k
ZSk7DQoNCkFuZCB0aGVuIHRoZXNlIGxpbmVzIHdvdWxkbid0IGJlIG5lZWRlZC4NCg0KPiArDQo+
ICDCoMKgwqDCoMKgwqDCoCBvbGRzaXplID0gaW5vZGUtPmlfc2l6ZTsNCj4gIMKgwqDCoMKgwqDC
oMKgIC8qIHNlZSB0aGUgY29tbWVudCBpbiBmdXNlX2NoYW5nZV9hdHRyaWJ1dGVzKCkgKi8NCj4g
IMKgwqDCoMKgwqDCoMKgIGlmICghaXNfd2IgfHwgaXNfdHJ1bmNhdGUpDQo+IChFTkQpDQo+IA0K
PiBSZWdhcmRzDQo+IEd1YW5nIFl1YW4gV3UNCj4gDQoNCg0KVGhhbmtzLA0KQmVybmQNCg==

