Return-Path: <linux-fsdevel+bounces-10027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21052847228
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA4E289F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59513E200;
	Fri,  2 Feb 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="EMvIqPVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC615210FE;
	Fri,  2 Feb 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885289; cv=fail; b=TagsAKHdi3l+3vo08nO6AfudffDwhECRdZGEeDsf16sIwgUvqfw1/o/XHMYfh2cZ+lPeBqxY5zRCWKYHAeO8S2M4/CTqs+loJEsbTeMy2JLe9d9oNTxvX1N2lfjN9ZWOhGmEKX/IqZIFMIXP3JEwL02WXdqZo8FR2e0XL1BNEJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885289; c=relaxed/simple;
	bh=itMDnZ7todPrfw28bM1F/eDGzD0MlXmSpjzqlJRCbnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UyTVIWh3VENWqV+aqtMCAm8MoXoPPGKyabb+N86EvHiZCPIFWftb2p57wicasYtl1Ad+y/RIxV6n9kiOnnD6NO8cJXuO+Re5tsYB06m0kPetORpU0AuXA602ziR23RqF6e36LCBff/TwU/dBCqruhSfJxHNzwqCE+LEzskRstMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=EMvIqPVH; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168]) by mx-outbound11-162.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 02 Feb 2024 14:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNe3kmgQNi+zese4rIUCX1jcLeAMeU10nOC5gxIsKBcQ2mCq+lgJx2xhu4Tq+vn3iZZ5SxjWRmukVZ/P9Jwv3qW8pZRF7m0V20QDMnpdO+RvtwV9Oq/eraD4Mg3k/flVHA8O6kNfBPwzpnFDOr54id8X3Tv236EJSQRP3308xBQICQCOqlQ66MWTI/s6GJHLTWZnhKoUHKaoCfqqcnB6WkIr+p2FwHxATl5ACcxLmHJnW3XOpJNSPeZXLsv8pK+6Y54Oy8FMzEq9pc4HQ19Jq/BnLar5F63mHausww9By+zzwWRZgHkYXkkgb3btcnYTl6BvzPzd2WjENN69LwUjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itMDnZ7todPrfw28bM1F/eDGzD0MlXmSpjzqlJRCbnU=;
 b=WaQe4IypXQCZh5GDjp6s7gSQGCMPcXDHbk2l5o0KRcBmjKXHDGTGrUaSsuG87oFRXyGalMR43MLqkeX3F/RkQdwzDWiNOYjormivgHPVFwqNKVtLLAHzHOfMR1/Jz3bEyVitXROaQKNkiX5/tkVBJ8xAq+QtNVorEk1Kro4phNBX4TZvZebj1vWQ9ty/Dtysgh3GNBa01cclsh/Oic3jA7hR+p00G5o3izMuulhfR9OmO2lPDfmWp+cNuoVcgv8KSPTCYUHyNTN/3wHO+NXwYmAZMU7Y8f7m6vPb7SEJqZt+/AZ549gT9kOi9PzYYkMbCX9jIUEi4+CHHtYDIJD0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itMDnZ7todPrfw28bM1F/eDGzD0MlXmSpjzqlJRCbnU=;
 b=EMvIqPVHyvY6Qpgo/N+K+I8N8lauDRiVnAgAxg+Pa5jmvhccUNuKv7ZEwXfeO+zPbM2zIb3AsJdPVfOx3ObBajMrUCrciDIHx9oMZ1rxAneGwfCpicRdXsDOM/7PXtaO+cJGJA/wJfknUktgADy3B5wrhqo7XUhVQkDzSWZIRqw=
Received: from SJ2PR19MB7577.namprd19.prod.outlook.com (2603:10b6:a03:4d2::17)
 by BLAPR19MB4179.namprd19.prod.outlook.com (2603:10b6:208:27b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 14:47:49 +0000
Received: from SJ2PR19MB7577.namprd19.prod.outlook.com
 ([fe80::9270:8260:3771:ff45]) by SJ2PR19MB7577.namprd19.prod.outlook.com
 ([fe80::9270:8260:3771:ff45%4]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 14:47:49 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bernd.schubert@fastmail.fm>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Dharmendra
 Singh <dsingh@ddn.com>, Hao Xu <howeyxu@tencent.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Amir Goldstein
	<amir73il@gmail.com>
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Thread-Topic: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Thread-Index:
 AQHaVJp6pCpUGVTRIEOO0QTX1flKZ7D1LPKAgABh1QCAAASIgIAADU4AgAAA2QCAAYLoAA==
Date: Fri, 2 Feb 2024 14:47:48 +0000
Message-ID: <7fbb0dac-45cd-4c47-be18-d1775d6a0def@ddn.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-2-bschubert@ddn.com>
 <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
 <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm>
 <CAJfpegvRcpJCqMXpqdW5FtAtgO0_YTgbEkYYRHwSfH+7MxpmJA@mail.gmail.com>
 <95baad1f-c4d3-4c7c-a842-2b51e7351ca1@ddn.com>
 <CAJfpegtd1WehXkvLWfbBvFLVYO2nBgWSoq=3Zp-Kmr0spus4zQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegtd1WehXkvLWfbBvFLVYO2nBgWSoq=3Zp-Kmr0spus4zQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR19MB7577:EE_|BLAPR19MB4179:EE_
x-ms-office365-filtering-correlation-id: ef4f49e9-8712-4218-a6fe-08dc23fded05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HeUu2IejvHWIMXSTpNiunViEA3bYQPuKvkZxjG+8zNowEZX0VIBEh0D3YUba51cupgIjAP7W+pCWnsXazFRPsW0tkZx+hZQyscyqa/SGTBU0GtjjDU5eH4CHGLCmawIgcRnpsGASGZjy68lFdGjrdborfwb2KaD7l0OG84xyIbOWEuPz0iNwPC1MqCplcR/IlPlcQQWsH8+6sxqAZ4o8ULWDQCOOrWHXJvoaM4B5niDxvHwq+m3H+8dF+NxvRNP/whoQHs3XNWvvJuj8CsdAFTzm+NbC5BCiM4dJqIuiwf/5Q7dO9P8kpA1v8FFXHIZygvKXWDNSoKBYfzD7Ckj/8FD4LY+xnuXscj7o5qOZgPWOajaxekMjp5gVpKhDk4FI/W81hEsb6QZd4Dm+Yv1Pq5JgQS2zHzK9vx7q7R5kj0AcOLduqNnEKDHoBSOrfkhwNvPHSY7UR2Jx0dT3OLJeJ+C4AsFeb8Fv9ae6cbfCSKMmdkBRTmKFB5Ij2OKL8KNGzyuW0xlfMoGJOmIbzJ4kKHd3xoMZqwFV0dy1LagIfUa/VpGgCFKGEabxyhZpNMR9Dyt9wzEY4wlvRaOvNlFFtmpTN9W6+AE7pXiHrBaqlGWW9+pRe61jt8xarbkL3B/ANoOqqlOUCPq60UfYlAObHeMhsSJZFnPxyky4WZMpq2UaZpq5xdwm8REcmqxqC3Yb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR19MB7577.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39850400004)(376002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(36756003)(86362001)(31696002)(38070700009)(66946007)(8676002)(66556008)(122000001)(6916009)(2616005)(38100700002)(6512007)(53546011)(76116006)(66476007)(2906002)(6506007)(91956017)(478600001)(71200400001)(6486002)(316002)(4326008)(8936002)(5660300002)(66446008)(54906003)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEVoUStTYjl0YVE1clV2TTZiaVM4NUhaOFBCU3VpUFpHc3VwenordEx3ZG9l?=
 =?utf-8?B?ejkwT3VDaEpJNzQwVnVqTGNmc3VJUG5sVzhoRHZGSERVTkFvUm5GN21JK3hm?=
 =?utf-8?B?emVuNGY0VnBIVTg0ZkUvamhYZVFWdnB4eWpIRmp1L21ZUDlUTTdpZ1djV2t1?=
 =?utf-8?B?MGQyY2ZBNFd5M0Vsejc2VnBnelRVQzRxOHFCNnllVFJmaDRxUHp4WlZ1KzQ2?=
 =?utf-8?B?ZWxoK2E2RmxucnpkNWlkYU5YdFhnbkVoVlVZZ3VsMXU2K0Z0dUZRcEJzbW54?=
 =?utf-8?B?aGRVZURLSTdBZ1FOZHFhVXdDSUhkN3A0U29OK0xOV1hNdDMyayt6dlM1b0dQ?=
 =?utf-8?B?S0ZzNHZDNS8ycTR6eVViRy93b2FHUWN3MGZsbFFaeVJXRzdBQm1mYmMvS1NL?=
 =?utf-8?B?NzNqaXRNRzdqZG9yK2JqN043S2JwbEJYYyt1VlM1ZWhkYThUbjdmV0NSU2RW?=
 =?utf-8?B?NGxteVFCaW5nYUk4UEpnYm1NdUtWdW5IOXFHOWhlQkVKVVZ2WXF4ZkxnZ1hi?=
 =?utf-8?B?NUVqdFhpZHFGdTdPMGFjeEc5RVdqbEpFMnRLMWNsbG1NRDFSNkN4N2xDSGVs?=
 =?utf-8?B?Ukt5Um45NitpRWVsTDFzUThRU0FHV2NMNXdwODZPWTU4TzE5aHBWSndKRXlU?=
 =?utf-8?B?STJWZ1czL2VvbFZjL29xWnN4TVRnRldwWEc5TU1vb1dCd1JvSENuYXg4L0dr?=
 =?utf-8?B?UCtpTTFDdVJSN1lvRStKOERCZG9pcldXem90enNMMlZJMXAyOFhlQVBDcTRw?=
 =?utf-8?B?RUx1RXIzbDJKS01lcC9XdGZtY1pBQkdneTN4aWN1dkVMbmRTa1RFaTRZeWlF?=
 =?utf-8?B?c3BNNFdjdllmRDlTdEQxSmNTYy9RT3NoY25MMGJVQU11ZnpieTR5K09FZDEr?=
 =?utf-8?B?QlVRYjZWczFCdldYTEhjRnJtNjE4V0FrWWxMQ1RRYVJ3ZlU2N0IzZ2FUQUxq?=
 =?utf-8?B?WU0yVEV4RStST0tJR3hjelVkM0dZNzBkYU80ZnFnL3dYUTU4ZEFodSt6dU0y?=
 =?utf-8?B?eVRDVDVhU1dBOEdzSXlUOStVQkJJZkRjQ3RQM1AvN2dVUjNUVFA2T3JrYUo1?=
 =?utf-8?B?Nmh0aVRxNGlSTlRIcVlNNTdmWGRhZGlnRTNlT0VMbTl3dnhFc1N5VXRtYVF1?=
 =?utf-8?B?MmFmdWNCNEQzSEI3NXFmMGlxN21oS3Z3ZzB0Sy9lYVY4VFl5aDlsUmt6UDg5?=
 =?utf-8?B?eVpVTEtycFZlYkFwa3hieWpaS1BxdXl6M0l6aDZWVVViT1puNEpJT3VWcEZ6?=
 =?utf-8?B?eUlNeEREeTA0RldnMUc1d0Vxd1lKb0E5V0VXUStXNnFwZjBqRUUxWFJONTJW?=
 =?utf-8?B?Z2ExRGZjZmtISHNiakhoNlliODlGSFc0c0gyemNHczhsSzdydURSVmlNaXV1?=
 =?utf-8?B?eENnUDdwOWlyQ29kT0lXdmMzN3pTdjNFUzhuelE5bno4TDdaTk1KSnNVSmRx?=
 =?utf-8?B?SjZoK0hVK3pCNWdZQURLeWpFcS9vTjVDREM0MStWRmx5Ni9jTndYV1VGc0hy?=
 =?utf-8?B?LzB4MitCd2ZLRm1pNGNQS3NrTnU2c2dLTFdSR0dwbWNUamd3Q2dYcDN4MUNN?=
 =?utf-8?B?QXBWc3JTYkpkOWJrUkhTWkZDT00rUVhyMkM2VDRBZ0h6UVRGL2JmOVVvRXJJ?=
 =?utf-8?B?M293UmtjQWJXVU8yalNDeDdXRnJ4bFBIdFI4SnFSMCtYaGdjRjc2MmxWb29N?=
 =?utf-8?B?NTZCWHlaV2RDU0VQam5MMEsrNVVPK29IZ3FkNHJ0dVRNNGVFTVl2SW5OSkhS?=
 =?utf-8?B?VXBLMmFqVGROOXJwc1RxcDBxZk9WcnFNOWFZN0ZmakRnUHFnc2o2Mk1zQ0Nu?=
 =?utf-8?B?SVIydWlkek9RSkZlb2xqWW1Ga2s3RDZGTTFrMjQxQzd5YjBSWW11Y21UcjZk?=
 =?utf-8?B?UjVpaFZwNzNENUhUbENBdUdEbTc3UFVZSkNBaU5HVE5oT3JBbU82bnZMRFIw?=
 =?utf-8?B?UHlleUpNQVc3RlZmZjRXVUFJY095MW5PTkZrczMwQ1hQR1p6RWtDSTI3MHhn?=
 =?utf-8?B?dmUxSUxsMGtlOFdCa29aQlA1Q3V6NkF6L2xpMzBpTWdNNVp3T2FnMk90ckw0?=
 =?utf-8?B?eXZrdzYvdk5acEN2OEJRdkY5d2dXcEY5eFJmd09hRXY5bkdiSVQrQmwxL091?=
 =?utf-8?B?QXNSdXFKWFRtMTZ1UnFyTXlOZExkODBZeUJqbXBlRkZMTTN1djdETUZNdGdN?=
 =?utf-8?Q?DOd6sCRsTDRgCg3tlsFoI7I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8C042F41408847A9AEBB7FD761AF37@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5kqwUVHI5NYIncHJbCLlRfw+sdKGHT7LGglkhY7gHwzLZoTkJ8Einxa6SYZBfztF2Z6OdblsuQg/7HRhHjJPp46FSxkIZJOLSd/ggV/YwH1hCEUvEIG3snv/OGh07ZCfLXAFQEfmOQGKdiv5NuL5vTHq8Xgi1nh3gySecV0LEmLb5BGIyjcuWvUVTYXz/FQDTfIjoJjYsKyKLJMSceYS+QemTqQCRdcUlo3h//ZQ5JgKEShgGLp9bfWJGKXtT9cXToJt9Q9495pPFemF8XrHE/iwe9Frrhs2jyZQkAV+rpO475URc/HHVXA6oSdgcIAwcUPEKuqsqgYx/xMHVFgweSrXz/zyGRCdKB9Fc4bd/IU7KqjmD4mvd+Ns86s3d3fCyYUWTGgoDrrNk49f1eAjXx7308p5ql4g3YJZTzqw3goLeh1ol8/1c/nZP1ur9deARVwN+ywT+PNSfwd13sW0JsY+3allUBss02+8lRqDAgNonH5Tevpbx8H0qMHLqnxbsLRNRoiLSzpEUJzIitVH2u/0RIR/l4gwOug+20csg6tP5mKIf/LNSMclD+1fhKaO4JzQAglUQhYKrAHhHpD/bnQ9K8/TGfIBOtdMVJdmIOoYsikYhlaeBuAHurjzrL4055etve1GM3UK+Ik0/gxFg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR19MB7577.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4f49e9-8712-4218-a6fe-08dc23fded05
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 14:47:48.9894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HS3vxjh5lQCq+aC9h3kJBplMcu3tK+xmnov+eeOR1VK+7ddrNVWPBw+kOdFa8xJN01UP32zXPr9pi3Vr3ZAo/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4179
X-BESS-ID: 1706885271-102978-3495-284-1
X-BESS-VER: 2019.1_20240201.2150
X-BESS-Apparent-Source-IP: 104.47.57.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmZsZAVgZQMDnJ0iQlKdkyxc
	Ay0TIxOdXEzMjCwtjUyDI11SjFzNRCqTYWAIwHoOJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253936 [from 
	cloudscan11-153.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMi8xLzI0IDE2OjQzLCBNaWtsb3MgU3plcmVkaSB3cm90ZToNCj4gT24gVGh1LCAxIEZlYiAy
MDI0IGF0IDE2OjQwLCBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+IHdyb3RlOg0K
PiANCj4+IEdpdmVuDQo+PiAtTiBudW1vcHM6IHRvdGFsICMgb3BlcmF0aW9ucyB0byBkbyAoZGVm
YXVsdCBpbmZpbml0eSkNCj4+DQo+PiBIb3cgbG9uZyBkbyB5b3UgdGhpbmsgSSBzaG91bGQgcnVu
IGl0PyBNYXliZSBzb21ldGhpbmcgbGlrZSAzIGhvdXJzDQo+PiAoLS1kdXJhdGlvbj0kKDMgKiA2
MCAqIDYwKSk/DQo+IA0KPiBJIHVzZWQgLU4xMDAwMDAwLiAgSWYgdGhlcmUgd2VyZSBhbnkgaXNz
dWVzIHRoZXkgdXN1YWxseSB0cmlnZ2VyZWQgbXVjaCBlYXJsaWVyLg0KDQpGb3Jnb3QgdG8gcG9z
dCwgaXQgc3VjY2VlZHMgYm90aCwgd2l0aCBhbmQgd2l0aG91dCBGT1BFTl9ESVJFQ1RfSU8gd2l0
aA0KDQoNCmJlcm5kQHNxdWVlemUxIH4+L2hvbWUvZnVzZXRlc3RzL3NyYy94ZnN0ZXN0cy1kZXYv
bHRwL2ZzeCAtTjEwMDAwMDANCi9zY3JhdGNoL2Rlc3QvdGVzdGZpbGUNClNlZWQgc2V0IHRvIDEN
Cm1haW46IGZpbGVzeXN0ZW0gZG9lcyBub3Qgc3VwcG9ydCBmYWxsb2NhdGUgbW9kZSBGQUxMT0Nf
RkxfS0VFUF9TSVpFLA0KZGlzYWJsaW5nIQ0KbWFpbjogZmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBw
b3J0IGZhbGxvY2F0ZSBtb2RlIEZBTExPQ19GTF9QVU5DSF9IT0xFIHwNCkZBTExPQ19GTF9LRUVQ
X1NJWkUsIGRpc2FibGluZyENCm1haW46IGZpbGVzeXN0ZW0gZG9lcyBub3Qgc3VwcG9ydCBmYWxs
b2NhdGUgbW9kZSBGQUxMT0NfRkxfWkVST19SQU5HRSwNCmRpc2FibGluZyENCm1haW46IGZpbGVz
eXN0ZW0gZG9lcyBub3Qgc3VwcG9ydCBmYWxsb2NhdGUgbW9kZQ0KRkFMTE9DX0ZMX0NPTExBUFNF
X1JBTkdFLCBkaXNhYmxpbmchDQptYWluOiBmaWxlc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQgZmFs
bG9jYXRlIG1vZGUgRkFMTE9DX0ZMX0lOU0VSVF9SQU5HRSwNCmRpc2FibGluZyENCm1haW46IGZp
bGVzeXN0ZW0gZG9lcyBub3Qgc3VwcG9ydCBjbG9uZSByYW5nZSwgZGlzYWJsaW5nIQ0KbWFpbjog
ZmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IGRlZHVwZSByYW5nZSwgZGlzYWJsaW5nIQ0KbWFp
bjogZmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IGV4Y2hhbmdlIHJhbmdlLCBkaXNhYmxpbmch
DQp0cnVuY2F0aW5nIHRvIGxhcmdlc3QgZXZlcjogMHgzYWVhNw0KY29weWluZyB0byBsYXJnZXN0
IGV2ZXI6IDB4M2UxOWINCmNvcHlpbmcgdG8gbGFyZ2VzdCBldmVyOiAweDNlMzQzDQpmYWxsb2Nh
dGluZyB0byBsYXJnZXN0IGV2ZXI6IDB4NDAwMDANCnNraXBwaW5nIHplcm8gbGVuZ3RoIGZhbGxv
Y2F0ZQ0Kc2tpcHBpbmcgemVybyBzaXplIHdyaXRlDQpBbGwgMTAwMDAwMCBvcGVyYXRpb25zIGNv
bXBsZXRlZCBBLU9LIQ0KDQooSSBhbHdheXMgdGVzdGVkIHRoZSBlbnRpcmUgcGF0Y2ggc2VyaWVz
KS4NCg0KDQpUaGFua3MsDQpCZXJuZA0K

