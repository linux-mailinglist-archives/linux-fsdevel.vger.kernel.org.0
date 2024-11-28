Return-Path: <linux-fsdevel+bounces-36068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0459DB671
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70A6163CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1672194C6A;
	Thu, 28 Nov 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="rVJWKYl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51813A868
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793033; cv=fail; b=kzbzsbXGQ239jJSTWTv/yXGGJOats82hLrRh6YHaGjun101MnZr7OIcG/nTa7zpeBeDj3Rv1zaMhpTC0NVJWlXYVYk87c7OxFIQpzAOz38uSaztXWYAa8lXVJ3thHI//9vCUfwC79EzM1OWNqo6eMqIhNOnFon5Rzh0V6RHLxU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793033; c=relaxed/simple;
	bh=MpPAssxUxAUleGUodVTuxQ+aYGeUJvgh/JgNqUZw2o0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhPYlTHqdLOJbhqvoEVyOSM08ij8LssEq2e2tzOEqLdMEP+4v+k3N4gsUt5FlAGnSFrQ3agsk1kWyMVMfOI6iE5/v7r9S8DY/nXbdTiXeHdqKX/wGrT8wPoX81Xc4S6KmF3VvmqsbSsf3Lg2usJnsJRtUO043VHcAXT3aahvtWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=rVJWKYl2; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound17-112.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 28 Nov 2024 11:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1czUXiTev6ljNR8dkZ9agnIVOXCPlalNT4vSVh45fQd0TdiDL85DrOj0MjGx/Bhu2jT/ugMSXqC7IKbCGziyC7qAbc4Qr2LNUBTvzxRh74aJN66hwPeJj/yDAIpSA8cA05xs7CC6+WC9FdDzn4XNSu+hPrCU2nmgNbPu2sMmH+2M6sxyEe9tgO26unYPyP3u2o7AsuEeAnRMZUv7zC8G73GVIL4Qdx+xpjbPAZl7moGR8nQ6K6z9RP6fcZ9p1PL9IwhZZnndBQJINC6/p0WN2ehJ3p9dqBXntmsOpMLYoUH/BVVwbX0mgcrlWC50zMZkyspiK3tbrLXQSzaMnkEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpPAssxUxAUleGUodVTuxQ+aYGeUJvgh/JgNqUZw2o0=;
 b=kzdJAKNclkMkyolrezXI36T7bofMRrBI1Y2sSPgFpoWecEyjn6iHLOP5D8yPmWuiyM90CHLIFv4W8Up5Rjzku02uamWCp603cbkcGPdvDkv2o42PsIORsKXh83liavZjvCX6its+ilMUbzIWqphH2fYPT7Twb0DHqU6CHMtgcar37qmAZPNCOcE5erg7dwAsLTxdhugO56qBcZI3BMHJ5Oa8YrzsNOCaWHUageeSvYghDuZW+rR7q+dF69ptyqFnXK8D4qk4Mwz/HZqa5D2VaWLbpZt4xpAAbV49zuiHeEMKck8ESag0KNLdn7osEw0uYmTYnYdPI9kM60y2fsE54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpPAssxUxAUleGUodVTuxQ+aYGeUJvgh/JgNqUZw2o0=;
 b=rVJWKYl2BMk7oxcAD5aeQ5cWYPXDHYN1xbA06z35W6nDwOhfKnV0WU4z95fXmlBjxmSOhuZNLFG3uFtM1QcbymFlpgLKaVVcTEuLE1Ij0y2G64VvgqZDk0QtB5vsmsmf6CtdHiCpA7QKmKSVdJ1Ui2QsN1MxOCx9h1SsAewBKjM=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CYXPR19MB8312.namprd19.prod.outlook.com (2603:10b6:930:e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 11:23:36 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:23:35 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Bernd Schubert
	<bernd.schubert@fastmail.fm>
CC: Joanne Koong <joannelkoong@gmail.com>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Thread-Topic: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Thread-Index: AQHbNslelG2h1ciGw0+EIBtf0lG1i7LMl3eAgAAEf4CAAAKDAIAAA+GA
Date: Thu, 28 Nov 2024 11:23:35 +0000
Message-ID: <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
 <20241128110942.GD10431@google.com>
In-Reply-To: <20241128110942.GD10431@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|CYXPR19MB8312:EE_
x-ms-office365-filtering-correlation-id: 39cddb3a-3e20-4b9f-a0db-08dd0f9f193d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGFoemFLRHVqNXdyT0t0Tnk5b0tGRHRhZzY0NjUreVk2a2pvRWNGS3ZjTUxS?=
 =?utf-8?B?YnZwb2FLYUxMT0ZpYXpRVkNDYTVaTTJXRUUzSjVxbUNwTXpTRy9VNC9RVWVE?=
 =?utf-8?B?U2trbVMyVi9mMzVDNEt5bm1SL0NTSnBjdlVBa1lVN3VaTGdveUFYaTluaUZO?=
 =?utf-8?B?UVBRUHJUcGE0ZUdNbStIQWY1ekw3QVI3aWFtcE5NdmxCdWdCeVJUL2VNbS9H?=
 =?utf-8?B?c01NdTE4WkVRSjdhcEhzN09SbW13MzluSEFnQUQ4S2xQbDV1Sk5jUUdHcUFH?=
 =?utf-8?B?TjZmbTNRc0VCTnRlbFkrYnQ1SVZIQUlyUEJBc0lzY1ladDN1Q2IwM2xhNkhS?=
 =?utf-8?B?czZYOFlmbVpHRDVDY0h6bXFZYzhBdDhSSXluZEQ3NzY3c2t6cFRzQmhVMzc4?=
 =?utf-8?B?Sk1NeHduTno3cVF4VjRQa2t0RVJXaThKUHdjaG9wejQrMllMdTVnZXBSWDhE?=
 =?utf-8?B?QzIwbHprTVZOZnlJVWJoeFAwbDIwemlIcXM5MHBJYk1GVm83TXVVelhvNUpj?=
 =?utf-8?B?WFlMUzlKZkljbGtpeDBNdDJpbUU4NmhKZmxDT1BzZEYxWXBFbFRkZmR5OUU1?=
 =?utf-8?B?TlhzVGJxekVvK0tMeElNUkVIUVE4cG5BRU1DdFBSVDBFckdSQ0kvTHFQdXVk?=
 =?utf-8?B?d2lJaFFHVUoycmZsdE5UVFd4WHl6SW1zRGlKL3o4YmdERFh0NW9HbzBtOWVn?=
 =?utf-8?B?SXRxMmtudU1vcWExT3pIbTF0SjNQcEhuZ1ZiOVZZamZ4WEN2ZzlNL0tqeTAz?=
 =?utf-8?B?ZHZMaEFKajVDQVhqYjdBVy9WMjB4aDhHUCtQQ012VlVRNjladXFKT3h6TVBP?=
 =?utf-8?B?dXZNS0RrREdRcTJTekk2OXZCU3lxaXdQT1gxWVlLZnVML3FkL3MxWVFOc1BT?=
 =?utf-8?B?WnFiWDEyc2o2Y0pVZnJVMmFwbW5SbHEyYWJuZWdMNGdIMHZTTmZEVWxDTXlX?=
 =?utf-8?B?WGUxZ0orbmRPa0tyWEU4T1lOZSs1M2ZuandLVmNTZXBvUlRMamxsWUUxU2pw?=
 =?utf-8?B?YVU0NW94M0duQ0k3OE1PREZ0TGtWMjFPbzNmY1NtWjJTLzhTejZwN1MrK1hE?=
 =?utf-8?B?SnhzNWZWWDZIcFRsdWtlSFRXMldEb1JxTTVORHJDZWFMUWtQYTY1WnQ1V2Fv?=
 =?utf-8?B?a3J6Rk9UUnRNc0s4NWh6ZUdiRlhPRXRRaTJaYmI5L0h4bHpJVWJlYWZQYVk5?=
 =?utf-8?B?UVA3clM3aGVRZERiVjQwalNsb3orQnErQkwxQTkxZncwdjJ3bmszaDQ5T2JI?=
 =?utf-8?B?WXNNNW8vS3lDZmQxMThLQ0FyREFKTmhoKzRyVUxoRFlBUXlFSXMyRUNzZExI?=
 =?utf-8?B?NEVIWUJZM1NvblZidEZPc2tiNE5uVm0yYmc0b1ZpRXlDN0ZGQ0F4dUZUQWRK?=
 =?utf-8?B?b0UrdDRUQVlJTnBRNm04bGI0b0M0MXAwVDVqNkFVUm9OaXdHZFhvRy9uOWFV?=
 =?utf-8?B?YUJVLzhnNFpaZEZ3R2RKR3A2dE8ycDRHNVpvaEk4dDVkeEk0QmllVWFTZ0pj?=
 =?utf-8?B?OUdjdUpUYlFWWktGN3F2UjBzUmdHYjlsWGhORGFldmxkRE9xdkZNd0xFK1VV?=
 =?utf-8?B?SVo4NXNHcWhBbGVVN2wyemZTSTVjc2RFbWpDUFlyMEp3bklCN0gxbFNDUEZm?=
 =?utf-8?B?UW5CS2NFZStySm5FVzdyUGJ1MjY5RE9VdVRLNkg3SHhzUDIvaFFlSDRSNHVK?=
 =?utf-8?B?ekhHOGlBVGtRMkhJMGRqYW4rRUU1NklNdDgzYjV5LzhzR2xOdi9NaWVINUR6?=
 =?utf-8?B?SnRFOTF0WUZtZE9hOS9saTlBMVVYM2hGeFNtRFRnUXBHbno1aWxtcmkwa3JW?=
 =?utf-8?Q?1UwwJe/ow8znA7655UsWbWPBRKIHELo7H2EVk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yy9kUWlxR2liOTNUZzNSemNPVGpXVVdoM29oeVpEOEFLQjBMZ1c0cVF5TkZl?=
 =?utf-8?B?NmFHdjlodnpMZ2U3N21oeUFMWHZ5VnYyL1AxR3JQSnZUWkVpeGFUQ1JHTnJk?=
 =?utf-8?B?bXFkMHUrR1YvQ3I0NXJjMXFFcGNnZnBRUUxaQzJLVStEUXE4bWQ1NEE5NVQ4?=
 =?utf-8?B?N2phVDQxYlBYZEt4QXBla0FKd2VUVktOVG1aUHFMZURrSW9KeXJRM0xPa0lp?=
 =?utf-8?B?OFFuMGFXM01oQ0E0WW9IdzdTaExPNVZaajdVcXRST2FhK2FNc0JTTHRrT1VJ?=
 =?utf-8?B?VkxnS1VCWTExcmhXajVXd01ibE01d1FPL1RjRllIVllNdzdpcnh2cThWSmx3?=
 =?utf-8?B?R0RoYmRILzFVTkpwdFRNbE4rbi8xOWxTaC9sYjJsL2x2ZXpBSVlXaUhtUHVF?=
 =?utf-8?B?ZjJKR010SHJsaTEzeDB4bEM5Y1ZCQUhPNXJWVmJuaWlvSmxlSEdPRzRlODVR?=
 =?utf-8?B?dTV3SU0zM1pKek01UG5KMjJTNFM2MFZjMXk1cHNjbnAwcHlybmc1dUpodmVJ?=
 =?utf-8?B?SFNBckxic2p1T3FFU2N0cnRBVVoyRW00cGZ0a1pJTGt4MlFsNDJZQlBra2Vx?=
 =?utf-8?B?b212UUU1WURBSnRNVmhYdWxpUEx3eTM5WXdEK1hFYXV4aXVrd3gySDQrazBa?=
 =?utf-8?B?NEZvYWs3d2lYTjBrMXlQUU9oTXUxYm1TdldaSjFDRXJtZ3JRekhLRVJ1Mk5D?=
 =?utf-8?B?WVpkN3JNYmZKL0lTYjhwSGRlSTgwTlFPUCtaekU3cy9OY2MvdCtOVy9YMWx4?=
 =?utf-8?B?N3FiU2lUdWpBa0hCcHBPcVp5OTFZb0RGWS9kNTlCL0lBOGZGTjlZRUMyNzhE?=
 =?utf-8?B?MjJPWnU1SWw1cnlKR0owekpPWmRrWE5rNlBBY2tDOU16ditSTXZrVlQrVzFI?=
 =?utf-8?B?UEEyWVpabHNYRkd5YnFlQzFPcnJWZ2FyeHVoZ2VxajZoWkh0T1RMdHJiaFR0?=
 =?utf-8?B?VDFmMDl2bmtHRmdoQkhQTVczOHp1N0JCTHZzRGZEVjJjR1lrQUhrR0VHc0Y1?=
 =?utf-8?B?Nyszck16cGlEK05ybFk2OWVEU1B6VU1kRWZaSE82b214ZG5mak9JT1E4VDFl?=
 =?utf-8?B?QjhWSUNXV0tVRll5WmZDRHVxaGUvTjZ5Tmh6ajNFZm9mT3VnVUNlSFBFSUZv?=
 =?utf-8?B?NG1LcEFLV0JqRXIraDVCeHE0UW84MHhjakJINkZsZTRmMzBkeENBdUhOS0F2?=
 =?utf-8?B?WTRpQzJhdEk4TWRqZS9OdkdiMDJFc0dwWFlPOW9jc3A1cXZVclg2VzVqcFl6?=
 =?utf-8?B?Um5ISDlsN0tXRytwTWFEUXRjYmcxbGlEU3NTS0NqZ1V5K0JtWFo0TmJWRDNJ?=
 =?utf-8?B?cngrSGNaUVEzTE5zYlBtYXEzSmd6R1FTZlBnajBOQXNLVFVHUW0vQUtPVEU5?=
 =?utf-8?B?RkZqdVV0TUNObk84UnBGNHQxWjljQ0l0L0NWN0pTRzJWbHp3S3BTcTJNYXVK?=
 =?utf-8?B?QS9jVExUUGx3cFlST2pRWHVNcng1WmcvaDA0SWlaYUNEeVN5YnN5MnBNQzB3?=
 =?utf-8?B?RWlrTkg1dFRvc3JmbHBmSHp1SDVvNURpMnh4MFJhRnYzd2g2UytPb2ZSZm83?=
 =?utf-8?B?Y2J5UVQ4YzdHTmtmTSs1WWxSeUJwWXNVUzQwcCtVQW01OVFNMGZrMERUcS9C?=
 =?utf-8?B?Rk9CS3ZXaU9MQ1RkWm5jVWRwOTlnYk5iZmhkN1RiODduQUc1VEIwOVZiZHdF?=
 =?utf-8?B?bDhyVEMzM1JMK1VKTmxUTXJlbVhxKzN2QWtrZDJTZG56OFRwZlp4bjY0YmlI?=
 =?utf-8?B?cTJFTzB1elJzdC83dS9McWFjVGs0QkJsSDArRWpzR3kvSmc2b3NuWmhPLzdP?=
 =?utf-8?B?bHJ1TWhjMm1MZWJZUXlvMC96Kyt5WEVtckh4Nk8wS0UwekdUbzlCa2dLTVNJ?=
 =?utf-8?B?KzBsbk1tVTdhNzA0VkZrbmVJYUJFUnlWdS9sWW9rV3dBOHI1YWpadSt2Ukwy?=
 =?utf-8?B?WkpJWHZFb3lXRnBkUU5RUUVHQ2JvOFltSHBtTERNNERWbHlGZFV2aWZXYmdt?=
 =?utf-8?B?Y28zQ0R5WXZPelV3UjNhN2ZUaHRUclhleXV6U0d3citVQnZwQ2tZNGExV2JU?=
 =?utf-8?B?SXRHaDhlRHR0NDhYU1NoMnFoOStlYzJWZ1YrK0RqUmJkbjVZWGFjWFdlK2sx?=
 =?utf-8?B?UXg2NXU3akd0eXFZOUFZVUx1VHc3dHBmQVdGb2RIdUdqcWJXODlaYU9ZVmw0?=
 =?utf-8?Q?rL1e3gWEz51Df5St4R1XA5k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA8C6E190E015E4A9D98F55E9C2A794A@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0qaIl0G8hAJZ0Od6ijBh5iIFCL3USq3o0eOLArrzmwOCG/RZIBzkk1UIQdH3tWj120k22rEMneE021614TvVMxSZJRDnpzTUFGVIgvxYkXtRA3WpjtDiG/MXJVD8rfvZOWL6nwcasoQ/LtMqlhQbDYCUAaJfUREAsTYsAN7sxIQhEkO3IWH++hAftjpc9BqNy+UJWbP6k6aPr1XBCBkxrYUGJrmm3mGBM0GbANcCmZqZ4p1ta1PYIuJtSPzQgijugfEsIYUIOl2FXcXvv3HMpB9JPTX21VI1z+cAnmZ/t1eQxkJrO5MGW9i5wAQ0tlXcNR6n0qad7elOFHPNr8H2LZ04L5m/WwmJqpwVRl0IOH2Kb12+6mSof0kFl2XERDF7c9KTRairstvvUQIEQvghxi5hrrMaS5OMbpehLQ84k/30MsE+iH8uHiYo7XUXAaIlehFeHksP+9CCOQItyWbdwT3/Fb9+xEsMGJmzbqTKiCOaDqzNYJIJDZVXRWsV31aoTkeftr188fArU4mL4pZqrqgPGMP2VKuo5tXM7cOL77thZdmzyjiND8mPgHhCuLmuTjl0wQd8WbUG5Ry6EJQ7Fy6rp6Dg/KanXAcQ1EYDYE4eMrkEu/bb64rwSkOBXJxq4NY0G7gcbX4zZws7Uv60lw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cddb3a-3e20-4b9f-a0db-08dd0f9f193d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 11:23:35.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRshQEYqXxeFkDgcpqoEXp5swCZstoDpyXaD1OelF9Eg6y2uMrsC3kekC1jznHlJ1dOn87eteW7ZTZ3n1UxZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR19MB8312
X-BESS-ID: 1732793018-104464-13371-1609-1
X-BESS-VER: 2019.1_20241126.2220
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGZpZAVgZQ0MLC3MA8zcjCLN
	ncwsTSNNHMzDzNMiUp1TzJODUtLSlNqTYWADHWxuFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.260739 [from 
	cloudscan17-36.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTEvMjgvMjQgMTI6MDksIFNlcmdleSBTZW5vemhhdHNreSB3cm90ZToNCj4gW1lvdSBkb24n
dCBvZnRlbiBnZXQgZW1haWwgZnJvbSBzZW5vemhhdHNreUBjaHJvbWl1bS5vcmcuIExlYXJuIHdo
eSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb24gXQ0KPiANCj4gT24gKDI0LzExLzI4IDEyOjAwKSwgQmVybmQgU2NodWJlcnQg
d3JvdGU6DQo+PiBPbiAxMS8yOC8yNCAxMTo0NCwgU2VyZ2V5IFNlbm96aGF0c2t5IHdyb3RlOg0K
Pj4+IEhpIEpvYW5uZSwNCj4+Pg0KPj4+IE9uICgyNC8xMS8xNCAxMToxMyksIEpvYW5uZSBLb29u
ZyB3cm90ZToNCj4+Pj4gVGhlcmUgYXJlIHNpdHVhdGlvbnMgd2hlcmUgZnVzZSBzZXJ2ZXJzIGNh
biBiZWNvbWUgdW5yZXNwb25zaXZlIG9yDQo+Pj4+IHN0dWNrLCBmb3IgZXhhbXBsZSBpZiB0aGUg
c2VydmVyIGlzIGRlYWRsb2NrZWQuIEN1cnJlbnRseSwgdGhlcmUncyBubw0KPj4+PiBnb29kIHdh
eSB0byBkZXRlY3QgaWYgYSBzZXJ2ZXIgaXMgc3R1Y2sgYW5kIG5lZWRzIHRvIGJlIGtpbGxlZCBt
YW51YWxseS4NCj4+Pj4NCj4+Pj4gVGhpcyBjb21taXQgYWRkcyBhbiBvcHRpb24gZm9yIGVuZm9y
Y2luZyBhIHRpbWVvdXQgKGluIG1pbnV0ZXMpIGZvcg0KPj4+PiByZXF1ZXN0cyB3aGVyZSBpZiB0
aGUgdGltZW91dCBlbGFwc2VzIHdpdGhvdXQgdGhlIHNlcnZlciByZXNwb25kaW5nIHRvDQo+Pj4+
IHRoZSByZXF1ZXN0LCB0aGUgY29ubmVjdGlvbiB3aWxsIGJlIGF1dG9tYXRpY2FsbHkgYWJvcnRl
ZC4NCj4+Pg0KPj4+IERvZXMgaXQgbWFrZSBzZW5zZSB0byBjb25maWd1cmUgdGltZW91dCBpbiBz
ZWNvbmRzPyAgaHVuZy10YXNrIHdhdGNoZG9nDQo+Pj4gb3BlcmF0ZXMgaW4gc2Vjb25kcyBhbmQg
Y2FuIGJlIHNldCB0byBhbnl0aGluZywgZS5nLiA0NSBzZWNvbmRzLCBzbyBpdA0KPj4+IHBhbmlj
IHRoZSBzeXN0ZW0gYmVmb3JlIGZ1c2UgdGltZW91dCBoYXMgYSBjaGFuY2UgdG8gdHJpZ2dlci4N
Cj4+Pg0KPj4+IEFub3RoZXIgcXVlc3Rpb24gaXM6IHRoaXMgd2lsbCB0ZXJtaW5hdGUgdGhlIGNv
bm5lY3Rpb24uICBEb2VzIGl0DQo+Pj4gbWFrZSBzZW5zZSB0byBydW4gdGltZW91dCBwZXIgcmVx
dWVzdCBhbmQganVzdCAiYWJvcnQiIGluZGl2aWR1YWwNCj4+PiByZXF1ZXN0cz8gIFdoYXQgSSdt
IGN1cnJlbnRseSBwbGF5aW5nIHdpdGggaGVyZSBvbiBvdXIgc2lkZSBpcw0KPj4+IHNvbWV0aGlu
ZyBsaWtlIHRoaXM6DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBwb2ludGVycyBhZ2FpbiwgQmVybmQu
DQo+IA0KPj4gTWlrbG9zIGhhZCBhc2tlZCBmb3IgdG8gYWJvcnQgdGhlIGNvbm5lY3Rpb24gaW4g
djQNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUpmcGVnc2lSTm5KeDdPQW9INThY
UnEzenVqcmNYeDk0UzJKQUNGZGdKSl9iOEZkSHdAbWFpbC5nbWFpbC5jb20vcmF3DQo+IA0KPiBP
Sywgc291bmRzIHJlYXNvbmFibGUuIEknbGwgdHJ5IHRvIGdpdmUgdGhlIHNlcmllcyBzb21lIHRl
c3RpbmcgaW4gdGhlDQo+IGNvbWluZyBkYXlzLg0KPiANCj4gLy8gSSBzdGlsbCB3b3VsZCBwcm9i
YWJseSBwcmVmZXIgInNlY29uZHMiIHRpbWVvdXQgZ3JhbnVsYXJpdHkuDQo+IC8vIFVubGVzcyB0
aGlzIGFsc28gaGFzIGJlZW4gZGlzY3Vzc2VkIGFscmVhZHkgYW5kIEJlcm5kIGhhcyBhIGxpbmsg
OykNCg0KDQpUaGUgaXNzdWUgaXMgdGhhdCBpcyBjdXJyZW50bHkgaXRlcmF0aW5nIHRocm91Z2gg
MjU2IGhhc2ggbGlzdHMgKyANCnBlbmRpbmcgKyBiZy4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL0NBSm5yazFiN2JmQVdXcV9wRlA9NFhIM2RkY185R3RBTTJtRTdFZ1dueDJPZCtVVVVq
UUBtYWlsLmdtYWlsLmNvbS9yYXcNCg0KDQpQZXJzb25hbGx5IEkgd291bGQgcHJlZmVyIGEgc2Vj
b25kIGxpc3QgdG8gYXZvaWQgdGhlIGNoZWNrIHNwaWtlIGFuZCBsYXRlbmN5DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzliYTRlYWY0LWI5ZjAtNDgzZi05MGU1LTk1MTJh
ZGVkNDE5ZUBmYXN0bWFpbC5mbS9yYXcNCg0KV2hhdCBpcyB5b3VyIG9waW5pb24gYWJvdXQgdGhh
dD8gSSBndWVzcyBhbmRyb2lkIGFuZCBjaHJvbWl1bSBoYXZlIGFuDQppbnRlcmVzdCBsb3cgbGF0
ZW5jaWVzIGFuZCBhdm9pZGluZyBjcHUgc3Bpa2VzPw0KDQoNClRoYW5rcywNCkJlcm5kDQoNCg0K

