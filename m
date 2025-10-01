Return-Path: <linux-fsdevel+bounces-63136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2BBAEEB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 03:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033CD4E145D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 01:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787C231832;
	Wed,  1 Oct 2025 01:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEU0xbd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376B2556E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280581; cv=fail; b=Pc0s//JKRwwyef/JbyuBSI5ibRtEAE3x5JLfjIiytJuGr/vHGeXs803Hectu8rGLOzWP5sCyqQsG4DivR4W3AQlS6QGdpMqxiJMJOBglR+Xk9bGkdfTRvuFmBqyNpM3C4eyC6NvdRNkd5AbPPDf8O3mrinG+DUAi8qRVuZNiJA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280581; c=relaxed/simple;
	bh=P/jTIH0sr9m0C5pyZZXGReUOM5oVZkiLGnUuAGVVc7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEQqciOTZuMup2RWZy2PmWMqWQI/YmaqvHepG+WtQDVrVisUYJ8wybbpWisKaUvqF3Cfdjn3BVjA7pSbyJ7On013Z7u1ADfzaLt0uN27cwqE8kpyflHHlieHPULC381q/A4lE6zzs+FUNC9gxOj06flwms83fs5asrXAy+1LS20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BEU0xbd5; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P67VvecrznD4NYCpoEFHxLMCY3kFE1XHY2JoGmmBlR/UEWycrnzzOwKPvrm4TdFt0niuqugBqousXPntU6r2bh2/OXphOGWVGXIoYySLeizkzO+2Zbl2AYdJj9txaiUshX1yfnaqEtlsJasqdo1sMG5b1CCSNVcDPo7+Jl+sK5Uo8uI7f8Tttu3sKFDdc54yIhkJJSE5caA5Q+ePiXp032WP5fVhA5+Y3znrg6uYQ95tW6ft2OV1HMpulu4wLKLseXomcLv1GMAhQ0UzFKP+tCW/384kLV2B3v/Qvfd1CJeeLUcio/0p9vTjy3DFsR34gwbzd2MO2Nqhm5rIc3j6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShkLcclEf9UZZs9Ce6egyfu1kMXyywxiD7Vl4321/bc=;
 b=vrVW5xMomMaNX/7uSbZubprvAtX9MEwYZrhtOB/9K0PuaZdZatRygk8wgJ+fLKn1jTe5LbVsJcwiA+qvd5yHRFVYu8CAaDsOJOpN2k/9B7YiyAN0OqGLsJ+RG3FiHJndKHmSwPRhQgDCfcJzNbt94oxDswfTMpwL6ZvdCvcPg4vyMBliWuqKgN3KDx3dmdVrc1o5ap3qde8WqBiX3p+xCgvutfBnPMrOKlXB9BBlhrb1+2e7rHHeqCjm5h2juABSESV4yi5/g3B7wpG7bq8nSe9CkLwlKAFl0McOO1vNqk1QSE/r12ouVL11x7LTA3Wwe/qaBKNA4V4nghbfpOA1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShkLcclEf9UZZs9Ce6egyfu1kMXyywxiD7Vl4321/bc=;
 b=BEU0xbd5GrBWssThHnMqba6Zoxp68H9RtO3Vrnv/8rV30GxchDNvwrhAy974ININ5Y4SdS1K/DYvpUfdkXr5UI/0ORA+JGP6+xAfkOi6VRG8FGrU/W09cHQx3AWdcHRpj8dbGZcAZDUqxV3I4d4Ma0AHdaZY19EpUzOmChafNOpesP+60PEUA64/D0euaMzgCGUb/zuAZTx4fq2nivOB2lgFmTc9DjSwNzNDN/kUEr7AVqwRyOKdVw2XRgy0qO59YFpJjV/jYpDbx0UyzG6JtiakldxiIAVw8cmjfkR6vyUwdxnDJEQfrf1GS3BKLWJ76PrwHLvLFG1vNGUW0wUHZQ==
Received: from BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 1 Oct
 2025 01:02:56 +0000
Received: from BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb]) by BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::d9c:75e0:f129:1eb%6]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 01:02:56 +0000
From: Jim Harris <jiharris@nvidia.com>
To: Miklos Szeredi <mszeredi@redhat.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] fuse: add prune notification
Thread-Topic: [PATCH 4/4] fuse: add prune notification
Thread-Index: AQHcHBe8NaGypsm8bUq3QBN7h6whwbSDh5sAgCkeVwA=
Date: Wed, 1 Oct 2025 01:02:56 +0000
Message-ID: <0BA8FCE6-FAAD-4F10-80D6-D33D378EEFD0@nvidia.com>
References: <20250902144148.716383-1-mszeredi@redhat.com>
 <20250902144148.716383-4-mszeredi@redhat.com>
 <C28127D1-D1AC-4F85-AB84-E77A50C39FE2@nvidia.com>
In-Reply-To: <C28127D1-D1AC-4F85-AB84-E77A50C39FE2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5094:EE_|IA0PPF84D37DD5C:EE_
x-ms-office365-filtering-correlation-id: c0e2d2c6-7a35-4145-87ba-08de008641e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWdYdWkxMWVnTkxvK2VBenREWWxxRUZpSmM1bndueFZUZDh5dUJSYUJnUXlR?=
 =?utf-8?B?MVBKWk4wbjkzTlI1cVBDaWF2eDRNVUJURXJvZkxtMW5FREZZM1dNUGJpNTdM?=
 =?utf-8?B?N21kN2RIM0ZCN1Z0ZFdvd0ZGVVhrbWMySTFyL1RCRitVTmpMUDBRc3djQ2NT?=
 =?utf-8?B?N1NqMzhWWmUyNkNpNlQwQ0p5ckdLTlhNcmVocGdnMFVuYkNpdkJYcldTRzFw?=
 =?utf-8?B?VXo4c0NNTURHc3dqVTQ4TEx2c0l4eVNNOFhvemhvUngyb0dXQVN6dC9uVHBw?=
 =?utf-8?B?R2FSdkdvNEVJSnoycjA2Rk1TSTRiY3lCc0lmMFZ3NStUbytCdmdVRU8vZDht?=
 =?utf-8?B?bmVIcjh5Vi9zVnRtM1pxamtrN3ZOK1lrZWR3U0ttcmppZXZxYmlhc0FueFRP?=
 =?utf-8?B?UWZ3b2dJd2RJSEU4Z0dCb2lpVlFWUnl2WHZJUkYrY2tOcnJCTmg2dW56RDEr?=
 =?utf-8?B?aHB1b0FSNGZteFBPclV5QVN0bmt6WldjTHZvVW1JWDZ3Q1pWeFE3ZHdmMmNX?=
 =?utf-8?B?RzhpQVpQc2I1R0V1TEtuc3ZsM240czl2REtXd1c1WHNpQjhnN1V2Rnc2eHhL?=
 =?utf-8?B?WERyUlVORXdGblNxWThzQlZQaUxFc3FERGUrZjhkbURFU0gwL1VibnNZdHNX?=
 =?utf-8?B?YzZPNmhQY1FKNElkRlhqOWlxYS8rM3YvdElOMmxuY1Jwc0VZS3RuUFJ2YTR4?=
 =?utf-8?B?VGorVDI2NW5UMGIrbTBGZHEzU1lGdnpORExHS3gyeHVNVkQ5YVk4clNqbmhj?=
 =?utf-8?B?aVVEbE54cFlMZ29hSzd5NFBpQ2VGcEJwVGp1aGxkN2lJNUhxUHJMUjRJbkdu?=
 =?utf-8?B?Zndhdmp5VkY3cmNxdzZyZmFPOVRwNDhQSEJHYXNuUkFJTEd3L2lJT2FtR1Vr?=
 =?utf-8?B?dCs2VlNPdk11U3dkajEwcEwwcDhCQzVkcDBSRm0zMm10ZlBEL28raVpPVW5q?=
 =?utf-8?B?NUc1cVdSZkFSQmJQeG9NeDh1QytnS3MxSG5NdCtqbDZmTTd5akl2U0trWGhG?=
 =?utf-8?B?R3g3ME1tOHJ0TDljdm5NeithVnUwUjJ1TU43bzNUczZTb1RCNVZIWlJhc0FS?=
 =?utf-8?B?b0VDa1lxYUhFdFdyOG9nN3lobk5qa25JRXBkQ3RMNGQ1a2NBTm1MaElZaVdv?=
 =?utf-8?B?dkVPbFhoWmFSWkl4MFpYcEhFMWtWcW1EQTJkNjRuNS9ZRGNTQUpvcTl2b2RU?=
 =?utf-8?B?cmtXS2FNZnl0QklDRjJGR3JnWE5PRWFUekQ2bFY4aU9sWWc1bGVKTVZFSkdp?=
 =?utf-8?B?Ri85QVEyV0ZvOXZzV3UyRlY3eHdiRTk5VU0xdi9Kc3pMdkV0YTR0andNZGFz?=
 =?utf-8?B?Z2t3OHdKVVErUVJ5UXVhZlVYVSt4bC9GenJNQ005RTFjSEZkOUp2amF1M1RF?=
 =?utf-8?B?YzJTWDBFUXduTVlMSU9pWWN2UE5nZzNGbm5qbTIyaUpZdndUVmhFMVNzNTZi?=
 =?utf-8?B?UzlmZVFFcTJQMlYyU1FHQXg5bkQzQm9uM2tKOFVxK2ZpVi9uV0VtNkxkb3Za?=
 =?utf-8?B?SXc2aG55S0J2QkN4RXYremFWcWlKS2IwVE53Q0ZUc01Qbm9oVFJDM1Q5YzVq?=
 =?utf-8?B?OWl0MGtKTURtdW82M3ZteWN6Y3RlVllEQkV4ZS9HRVFiL2RkRUkwbzdSbjBC?=
 =?utf-8?B?Yzk5NUs5dHEvYzZyOGxWRVBFZmdVOUU5NUtrbWNYdTJDb1ovWFNaL2xxdjNP?=
 =?utf-8?B?YnNlSkIzbnJLYUxHQWZPYXZycFp2SnpxVW5kY2plTGdUWHB0Q1IwM0VUK3U3?=
 =?utf-8?B?N1krVUVyeEtyRGZYbkFSd3EzcGRNcDlSdUcxQVNidXcwV0Yvd2R2QkVNdDRJ?=
 =?utf-8?B?ZDYyV29BYXp3VEpCSGZBRGFheElaMkRXK1FWNytZUTFBbXhLa091ZDJweGY2?=
 =?utf-8?B?Rnpxc3Q0UkptcFZVd1FwWU1SS2tRM3d0bzRHaUF2ZE45ZFlZMWEzZFgzZG0v?=
 =?utf-8?B?V2lEUTd5REJYMm5YWHJVcHl1Tm54NWJDUW9Ld2Q5MG9sTm90cEZoT0x5VlFa?=
 =?utf-8?B?ZUlkdTVEVjhxa1dNNUc1ck1YR2prbVNFQ0MxUy9DYzNrNFcwczJVSXRPb2hq?=
 =?utf-8?Q?DcHPKu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTM4aUdKVml1S0hQOHlNUnp1alNlVXdaZ1IweCtXT0xRRWUxWTUrd3daMEtT?=
 =?utf-8?B?UXZ4YmRzZUo1Wm9kdk9oYzZlSlZXM3NZUXBMV2xmYUd4TkxCM1hIRzl6dUM3?=
 =?utf-8?B?cHFSWUtOZisvejhYQU1HTkZlNEZqYjRBQzZpVWdaMk83cWpJTFlwZ3RyOWFS?=
 =?utf-8?B?b3k5cFIxOGh0d1RKL1BoRCt3RmtOd1BocXBUZ084Y2tDS3ZZQm4xL0IxWjVk?=
 =?utf-8?B?OGFSTUlmSGhYUFdMTVBSRWxocndHWW9CV2hVTS9SUXdvbGVaZ01YanZPRC9S?=
 =?utf-8?B?UW1RT0VBNzcrMC84WDJMbXd2MTg3UWJTd1A4SlRuZktKaFc1ZklYNWVKZ2RS?=
 =?utf-8?B?dVJhdm5nKzBvSmtLN3Bjdzc3b3hjdXl6QlJ0OEVvLzIrMHEwL3duZG03S01n?=
 =?utf-8?B?M1dJd2ZIalcwM0FLSXRKY21VSTVIOHpKUStMUXd6LzVxeGtrdmhhL3JibVlZ?=
 =?utf-8?B?RUNGakJKWjFjVXdlR2QzTk9YRVhtU05nbEMzUVpIeWw2UmFKMGppbHIyOVQz?=
 =?utf-8?B?UmNOVVlTV1FMM0tuV1FRU29UZG5CZC9PV2JiWnRvOGN0a3RmOGV4YTY1VGNz?=
 =?utf-8?B?NERkUnpWdklRdXZNMnF0OWQvdEhtUGJ3d1dxNmZJU3E5MCtjRkw3eXp4dzNu?=
 =?utf-8?B?OUdhM1EzcUpiV3RNZExLd3dacDZHa0N0ZS9uNTZrMlBhQkE5ZkszMkJuWkZE?=
 =?utf-8?B?d3ZVNnJScVdOT1FtU2JoeTdLZFZBNzQ0bUJrVUdCb2g4MFJVajMxWUhaMnlI?=
 =?utf-8?B?U2pFTkpFMjZuRERxY2VHVzdiRVBCV2ZDNDZHUHg0NGFSNi9BQlRHbWFNWTNM?=
 =?utf-8?B?NzdRdTZPRy9WdjU1OXMvcnE3czFmYlhLQVV0aCtMSUo0N0xjbll2TWRnb21C?=
 =?utf-8?B?Zm9aRVdqUjZZalRqTnFWRFNFSXk0WFA5VkViSWo2b0RjNTU1T0ZtNXhRUWtB?=
 =?utf-8?B?Wnl1VVRiT3IwVFZVTE90eURsSGhhVFkrQWJnU0lKQlArMGpkZ3hQM2IyNnBU?=
 =?utf-8?B?VVovMVg3blFMZ3JLd29rM2N6dTBsSG1IMndOTUlvTVQwZ1IrcG9zaEptdnhR?=
 =?utf-8?B?QVZkMnJPUnpNa3Y2djBpcWtPdUFjYlVEREFOWmNIR2cwWThCNUo0dEVaWERG?=
 =?utf-8?B?N2pGbjZYQVF4Rmp6SFhFaXArb0tIdVNKZDZJbGRFWUlZZzdpV0ROaHFyeDFw?=
 =?utf-8?B?My8xZEViUDU4MTFhTWN4RXNlNkRMZ25DdnkxdlhjQ2VVMFl6MGx2djZVTkdX?=
 =?utf-8?B?enFjUUFSYlNRcUJQUzJDRXN5cFo0c0NqZEpIMGo5QlJORTlYUFF5M2FtNG1T?=
 =?utf-8?B?bFJ4aXlwdnhZSVZLVGU5eUxKcDFtMEh6QzZsN2FpeWQ4NThqK0YyUGRmS256?=
 =?utf-8?B?cTZnb1grejBxaEM3VldJTjNmQnpYbktnaWlqS3ZsSUZyUmVRMFBUSU9kQXUy?=
 =?utf-8?B?S1NqV2hRMTVBd1hEc2RaNmJpTWUvaGxXeTBrKzR3RkZYWHJHOFlMdDlEcGhS?=
 =?utf-8?B?alVWQzdsclNJM3NwdmcwZFk5akk3dFArTGhFUzluWWNyQVprZ1N5di8vcER2?=
 =?utf-8?B?WFo5QzNDdFJ5ZWZwc29KWExGelh4RnA4TEwzcS9HSG16Z29GaGkzbFFhTmVH?=
 =?utf-8?B?aXgrTzM4SlRvWG00anU5ditNNTZLWGZ1R0t4aklqNUhwZWljQUFEdVZDQzRi?=
 =?utf-8?B?SWxoQzQ1TGFMakRhZjEwZ3ExMGpZbFVJalhobDBvZE84V2h3RDV0b3IvWmp6?=
 =?utf-8?B?VHcyRGUrT2hxeWdaaXRBeSs2b1VvRWtjdVdiZDBjOXRPSzQrT3ordXAwL0o5?=
 =?utf-8?B?WHZBZHFTc3NUTktoa3FvSHBTTHVKMDduV2gyUjFobWt1Rm5TTkREZFRZUHpG?=
 =?utf-8?B?YXhRYk5OOVNPemw5NXAvbEwxOXJUTkMrd2FkeG1SajJ6aDd4WW1YQVorVEQ3?=
 =?utf-8?B?ZGlEZ0RicXRJOVB1YXlzN0JSYmxXQmt4a3BxSkNKd2d0ZjNxY2M3aTA3eUF3?=
 =?utf-8?B?cXdNaTV0ZGhPMjJOdUhqNlZBZFJwWWFPaE9nWDRlOC9LVGxpYmhBVEZ3UmhC?=
 =?utf-8?B?RlN4QnJ5Uzk0dGdJdzNSb1gxbi84a0Q4MDE4aVNFWWpFaGFYMktUQmhwbGVz?=
 =?utf-8?Q?C3X/uT5ops0Eo8uTEhwoMo+tA?=
Content-Type: multipart/signed;
	boundary="Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e2d2c6-7a35-4145-87ba-08de008641e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 01:02:56.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIAFH/cdRLKrrSCOVnZsE3hJh4jXnVUnZVBHzwIhqDpkvUziH3rF5Kxj9pYuAyw+dAvhGud9N20nLA10eULQbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C

--Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Sep 4, 2025, at 2:07=E2=80=AFPM, Jim Harris <jiharris@nvidia.com> =
wrote:
>=20
>=20
>=20
>> On Sep 2, 2025, at 7:41=E2=80=AFAM, Miklos Szeredi =
<mszeredi@redhat.com> wrote:
>>=20
>> External email: Use caution opening links or attachments
>>=20
>>=20
>> Some fuse servers need to prune their caches, which can only be done =
if the
>> kernel's own dentry/inode caches are pruned first to avoid dangling
>> references.
>>=20
>> Add FUSE_NOTIFY_PRUNE, which takes an array of node ID's to try and =
get rid
>> of.  Inodes with active references are skipped.
>>=20
>> A similar functionality is already provided by =
FUSE_NOTIFY_INVAL_ENTRY with
>> the FUSE_EXPIRE_ONLY flag.  Differences in the interface are
>>=20
>> FUSE_NOTIFY_INVAL_ENTRY:
>>=20
>> - can only prune one dentry
>>=20
>> - dentry is determined by parent ID and name
>>=20
>> - if inode has multiple aliases (cached hard links), then they would =
have
>>   to be invalidated individually to be able to get rid of the inode
>>=20
>> FUSE_NOTIFY_PRUNE:
>>=20
>> - can prune multiple inodes
>>=20
>> - inodes determined by their node ID
>>=20
>> - aliases are taken care of automatically
>>=20
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>=20
> Thanks Miklos, this looks great. I=E2=80=99ll give this a spin in our =
virtio-fs FUSE device.

Hi Miklos,

I was finally was able to give these patches a spin. They work great, a =
nice
simplification compared to FUSE_NOTIFY_INVAL_ENTRY. Feel free to add:

Tested-by: Jim Harris <jim.harris@nvidia.com>

Best regards,

-Jim


--Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

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
LTIwMjMwNTMxMTYwNAYDVQQDEy1qaWhhcnJpcyA2MzZFQkM4OC0yNThCLTQ2QkYtQkU2RS1ERTgz
Mjk3NEVFMkYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDsK5flcFLKT/1ktmlekKTA
8JwI64E20ekPEvj4KcEynk2b/aaS1Vol+gDoCmp8Q2YKca4RO3IPmWYGMEKWyOwh3R/X+NDC3kEn
xR9FRyPKixPVaVIJOBvpLgTHlTGo6sBECGARmWLNcq/VP/IOEfynt+o0ycfhfMmVCLNeTpVnTDfr
2+gA+EzrG3y7hFlf741+Iu27ml7F2Sb+OuD8LaaIvbUH+47Ha9c7PNbS8gGCOqJ+JqpFbz6nyiVN
KzcxsvQph1p1IlvctilnvGOLNCSQY24IPabPY4mh2jOOELalk8gKhIgeZ4v4XnuDGKzG3OQXjvNW
ki++zsKA+Vb5MH1HAgMBAAGjggNiMIIDXjAOBgNVHQ8BAf8EBAMCBaAwHgYDVR0RBBcwFYETamlo
YXJyaXNAbnZpZGlhLmNvbTAdBgNVHQ4EFgQUXogZtTPa9kRDpzx+baYj2ZB5hNUwHwYDVR0jBBgw
FoAUlatDA/vUWLsb/j02/mvLeNitl7MwggEGBgNVHR8Egf4wgfswgfiggfWggfKGgbhsZGFwOi8v
L0NOPUhRTlZDQTEyMi1DQSgxMCksQ049aHFudmNhMTIyLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPW52aWRpYSxEQz1jb20/
Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlv
blBvaW50hjVodHRwOi8vcGtpLm52aWRpYS5jb20vQ2VydEVucm9sbC9IUU5WQ0ExMjItQ0EoMTAp
LmNybDCCAUAGCCsGAQUFBwEBBIIBMjCCAS4wgaoGCCsGAQUFBzAChoGdbGRhcDovLy9DTj1IUU5W
Q0ExMjItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9bnZpZGlhLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBWBggrBgEFBQcwAoZKaHR0cDovL3BraS5udmlk
aWEuY29tL0NlcnRFbnJvbGwvaHFudmNhMTIyLm52aWRpYS5jb21fSFFOVkNBMTIyLUNBKDExKS5j
cnQwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLm52aWRpYS5jb20vb2NzcDA8BgkrBgEEAYI3FQcE
LzAtBiUrBgEEAYI3FQiEt/Bxh8iPbIfRhSGG6Z5lg6ejJWKC/7BT5/cMAgFlAgEkMCkGA1UdJQQi
MCAGCisGAQQBgjcKAwQGCCsGAQUFBwMEBggrBgEFBQcDAjA1BgkrBgEEAYI3FQoEKDAmMAwGCisG
AQQBgjcKAwQwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwDQYJKoZIhvcNAQELBQADggIBABaxnmlH
ePMLNtYtyCN1iDp5l7pbi5wxLNXCULGo252QLCXJwKTosiYCLTT6gOZ+Uhf0QzvbJkGhgu0e3pz3
/SbVwnLZdFMZIsgOR5k85d7cAzE/sRbwVurWZdp125ufyG2DHuoYWE1G9c2rNfgwjKNL1i3JBbG5
Dr2dfUMQyHJB1KwxwfUpNWIC2ClDIxnluV01zPenYIkAqEJGwHWcuhDstCm+TzRMWzueEvJDKYrI
zO5J7SMn0OcGGxmEt4oqYNOULHAsiCd1ULsaHgr3FiIyj1UIUDyPd/VK5a/E4VPhj3xtJtLQjRbn
d+bupdZmIkhAuQLzGdckoxfV3gEhtIlnot0On97zdBbGB+E1f+hF4ogYO/61KnFlaM2CAFPk/LuD
iqTYYB3ysoTOVaSXb/W8mvjx+VY1aWgNfjBJRMCD6BMbBi8XzSB02porHuQpxcT3soUa2jnbM/oR
XS2win7fcEf57lwNPw8cZPPeiIx/na47xrsxRVCmcBoWtVU62ywa/0+XSj602p2sYuVck1cgPoLz
GdBYwNQHSGgUbVspeFQcMfl51EEXrDe3pgnY82qt3kCOSzdBSW3sJfOjN0hcfI76eG3CnabiGnVG
ukDrLIwmyWQp6aS9KxbJr4tq4DfDEnoejOYWc1AeLTDaydw7iBNAR/uMrCqfi5m4GjnqMYICzTCC
AskCAQEwWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJYIZIAWUDBAIBBQCg
ggFDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MTAwMTAxMDI0
MFowLwYJKoZIhvcNAQkEMSIEIMNz7uozjSGBVYbY4JL+SxBCzGYxtxDk2jpRypOI5gN5MGoGCSsG
AQQBgjcQBDFdMFswRDETMBEGCgmSJomT8ixkARkWA2NvbTEWMBQGCgmSJomT8ixkARkWBm52aWRp
YTEVMBMGA1UEAxMMSFFOVkNBMTIyLUNBAhN4AcH5MT4za31A/XOdAAsBwfkxMGwGCyqGSIb3DQEJ
EAILMV2gWzBEMRMwEQYKCZImiZPyLGQBGRYDY29tMRYwFAYKCZImiZPyLGQBGRYGbnZpZGlhMRUw
EwYDVQQDEwxIUU5WQ0ExMjItQ0ECE3gBwfkxPjNrfUD9c50ACwHB+TEwDQYJKoZIhvcNAQELBQAE
ggEA4bE+M7L85lnpKirBUWmwfroX7TIs0QylcnZ2Gkhiqr2Z7Txs+jBRqXbZTL5ADYkkQJNzawcs
4ZSqI9d7BQmFmBMxN0GFZB3l5Mow7bVmLG+zTmrKOLyrwkvk4/GjczGAk3xcpYyh6c/kOMNGGy2Q
tfaJVD5pJlySKr1DHyoK6pApVG1lUKzAVuxe33t7sMY75ViNjKtE7qJp7vRQDnvjwSU1HFc4GQZt
u7A91nksChkmSmKDVLqInQKWLtXYJRVjsMH28O7QTa0Cq08n1B+lF0p+fdAPrgvtwmPoI5MAQ2VE
Lj27hz64lp71QHCUGuNgt8xsYAiR1qOP+k5SIFo5tQAAAAAAAA==

--Apple-Mail=_236AB6AC-99CB-4FB3-8CC5-8B183EA7451D--

