Return-Path: <linux-fsdevel+bounces-69374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 085E4C78E0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 12:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FB3134A9B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5262F0C7E;
	Fri, 21 Nov 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="QHJXaFUO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B722AE5D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725302; cv=fail; b=frrrTu+8hGQ7ZijkY4gASumPo4AeJjeZ9L9yHtRAnJe2Kr2eEcZ+atm00KheNzbOp1wXIPLz4opklnWvq0mBMV76FJ53QNAfalEIja9rajg0ov0f6qDbu5VhCZy/mKetuvQvq9rstNDVJgtloP6CIGZ0JFnRHIQurvmIbWubb08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725302; c=relaxed/simple;
	bh=y7nXbjxnRxb3BRaf37u7Glx4SLwj/ydH/nRHMvX2Mto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QTwCtRPnHGFAqstnhe5eLLMTjD9bE5brit2sLMx1MoQNE9KuLfNIV/Vrhc0VFJ/+KGJn8EdhOg9EthRqqbigF6tQebM1/DrR1CPVRnP19cLuag5u41vsnxnGjRBxqGH9Qupd7QWfJEWpdmIzEExpFP58M21R7rQbl1PJ8sM7d9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=QHJXaFUO; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022115.outbound.protection.outlook.com [40.107.200.115]) by mx-outbound46-161.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 21 Nov 2025 11:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEKyIx153sIlm0P0vhLBWOQ7ctxEE5Le4et5p5NnVP2xOoiENvPu96j0K2uV872k/IkEzuOwT4B8Czz6+NbBcsJPxDSfqwYuaJu6hCQ416aBat21BOEccLIkDfAXLgXHLFu0HRTEn13acGOdFrM+XKZfeMKhSDpkVae9iBV0wAjR6FxZIr+VJ4iRBkaMpVk5A+YO/RuCVeDDK4luSB1o+V+9452qTbNZqLSghg0VlFQ4KmWeLUFT5f0MHYojYOZNgSEMsQYtfWasi0c5AJIEcZnvy7THp3jsRhF6S4z0Y2cbuU1+3YR2CIdtdDpyNjjOVL221yjGckM3QCkNEAJBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7nXbjxnRxb3BRaf37u7Glx4SLwj/ydH/nRHMvX2Mto=;
 b=OuNIEA0S2cpKzLHvxVyED+yvHl/ORTtvckjXuOJ5lJWwzVOcv9hJoirBWfgaF6bLgKWR1HcW0RHQPFjoO57Q/KUx8qllrWZ/ZjCjTNUfhTKxaaPQrHx/y32E9cgc+WDpQNWtiYak1jNigrd8T4gK/UBYXy0KUKtfmQ5t7PkOQvW9G+7vpdutt8i9TUtb8Tw4i+TjeOUKRtYyNURqscKCuNCelRYJemNLkzDYieC1m20kaaCDcpXDi4MymgRrcwhTDxV819K/SHpwE1AB/fy/ilBxMDh3T5ZHmKQHjS5iy6tcjpGG1sCC1Yt7ctqeW3yIR3AO+F3L+JOAkDU+R4i0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7nXbjxnRxb3BRaf37u7Glx4SLwj/ydH/nRHMvX2Mto=;
 b=QHJXaFUO/Vxc7VWDmdTJD0GyHo9+E4LMazHfow7Jq5U+Jkz++THbVmJwt2lr4LEqY2qSsW0ZLd6K98rPJCy31P5E+RboXrqY9GRlWCoJmj4Jj2tRzHf0nUI0k+S+DnlZVg0dHMpokNx5L6mKkUFHh86yxWhVwdNlBpQKm7SylIA=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW4PR19MB5656.namprd19.prod.outlook.com (2603:10b6:303:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 21 Nov
 2025 09:06:42 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 09:06:42 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>,
	Kevin Chen <kchen@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey
	<mharvey@jumptrading.com>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v1 3/3] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
Thread-Topic: [RFC PATCH v1 3/3] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Thread-Index: AQHcWgw/ADs5ynRffUWwK4UjHl+QzrT8wriAgAAVfIA=
Date: Fri, 21 Nov 2025 09:06:42 +0000
Message-ID: <6e561ea7-f7dd-4c94-854e-83c2fb9b0133@ddn.com>
References: <20251120105535.13374-1-luis@igalia.com>
 <20251120105535.13374-4-luis@igalia.com>
 <CAOQ4uxgN5du9ukfYLBPh88+NMLt6AzSSgx4F+UJmugZ86CvB1g@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgN5du9ukfYLBPh88+NMLt6AzSSgx4F+UJmugZ86CvB1g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|MW4PR19MB5656:EE_
x-ms-office365-filtering-correlation-id: af2965c6-77e5-4a6a-9ee8-08de28dd49c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3dRSERGQXBta0VTMlBVdVhaNlBsU1RCaHRrVHh2NGE1Wk1ESUk4R3BTUGRx?=
 =?utf-8?B?Mm5sRmM3VjRnUjdnUE92RDhMcjBuYTZ2MlRiVmEvM2NneStkenJUSTEyZk1N?=
 =?utf-8?B?WGc4YTlwbjU4Tnh2cnpvNkdkR0grZWJBN29GZDluWnlOSFBIN3djVmIyMGg0?=
 =?utf-8?B?aGM1MHJYb0xQV0dOMHJtbnhCcEo2QzBvTTFHbW5LY1prME9IYnkzRDl3Yk5F?=
 =?utf-8?B?QlJxR2hHTWE0am43UVRYR2ptVXlnTTZJV1JOc1NWTkFFWVlJNE43ZXZ6NitU?=
 =?utf-8?B?Wjl1eUN0aktVWVNTREFidVZCNmhJVm5IWnRxQkYwNWh3ekhZM3loU2xpakJP?=
 =?utf-8?B?aUp5b1BKMFZIKysyTWczWWxQejhmWmkvSnM0NG96TzU2MlVWaDZFTytwaE9B?=
 =?utf-8?B?bTFmY1ZzNUZ2QWt3NDIxVkxtL1pnQ05aWDlKUnZhU2tsWHlvOTFhYWpWdzYz?=
 =?utf-8?B?QnhHNld5Z3pGWm5sUnFKODNmazFST3F1eWtLbERhWGsyZHJRVXJaNFNvYnZ6?=
 =?utf-8?B?bU11RjhSYTFKRFZsc3daTDBhRElWN05vOEV2eWwveTVMeVdOd09Lbm5IeWlH?=
 =?utf-8?B?TDdsdmVtVUNPZ2k5VGsxN3lIRHJMTWZGNjQvR250eTFqWGFtLzJqK2JwUUNE?=
 =?utf-8?B?NjN6VlpEVWxNZ3NGeEh4a2ZZcmxoR0xGQ3NvWXRCZVlmRWxlemJFQ2pBNzFv?=
 =?utf-8?B?QnNqcWF2aUo5WW83bHEyc09lQWlsTkROMHBnSXJmZkFDQnBNVk41TnQxS25C?=
 =?utf-8?B?M1o4aFRNb2lJeE9RbXJYVWF2TlZzMlNGdEpJTElqSy83UnY2eitmc3dpaHpG?=
 =?utf-8?B?QjNuQXpkcVpielZXbjNCQk9HYldOdWNjSmlUUFNUc0IyZmNoSWEvR1dOU2dU?=
 =?utf-8?B?NjB0NXU0UUFDV3VhUUhXSE83V2M5dUNqVFFoTVJ1SlJOaEFPTzV0K3JxQ3N3?=
 =?utf-8?B?czV6a0xycGQ4eDkwQmdONjZVampyOEV5bU90OGJWTlpCY2FxREk5RU4zZzBX?=
 =?utf-8?B?Z3Q4Y1h0Q1I3UTJsVmxxVXUrYWY1MVJ2Mm1zVkRYbm85SEluS2xiT0hlcEN2?=
 =?utf-8?B?MWJFU0xUaTRmazRucTlYSktnVG41ZlRtdzEvY0dpRWNSSVlKb2hvU1U0OEJR?=
 =?utf-8?B?bFZnc21GUVJhcXBBeEtCMUJlOGlJME1QaEJUc1NoakxHd1kvL2ViM0tnTzc2?=
 =?utf-8?B?SUJCL1RQUGJ1UlBoNzNFbldyZlhyV3VsQitGZk5Mb25FSFYrUHBCZkdkZHhk?=
 =?utf-8?B?bXJ0Wjh4NnBobUdSWlB6ZHA3bUZLTXlKMGJGd0VJRk16YUZWWlBnOVBUWEU5?=
 =?utf-8?B?QkVwYThJMm9SRGNNcmpMTWo2cnh6QWpVQXJ3SkQyZ3RiR09iaTExY1lHZlpu?=
 =?utf-8?B?UlRIdVdWYzRTWHFZamd6SHV6aWpXS2V4OE1kWjBESVpTSGw1WWIwVElXRmNt?=
 =?utf-8?B?c0VtN0VuRHVlOWZtWC9jMThoV3JQdjVEdmR2QWUrRjAwdngxY2dWRjdJWk5Q?=
 =?utf-8?B?ZUY0NjVzSnVCOGVPdDM4TUU5cU1BNFIya3JjdVVDb1M5clM4UkFqSHIydHFU?=
 =?utf-8?B?OElBeEs0aFJmQ1gxa1FGNzFMZVRSQ1BQKzNFOThWSWVKYUlvVU03TXM5YUdT?=
 =?utf-8?B?ZTRFTWNXai9PUW1EOFRhQmluOSt6OHhOL0tkN1JrYkRIeG5jT09UVW9DM3B4?=
 =?utf-8?B?UXgzb1hpenZnbFpHMUR0Rlp6VzFpVmY5MEg0cUliU2lLbk1ZYlVtUU9vaVZw?=
 =?utf-8?B?RWlSa1hzWGN6VkQzSlNNOHo3ZWtGSE8vMTY5VUpBdCtaV05mZlFSSkNoS2VH?=
 =?utf-8?B?N256M29BQjBYQS9QcHdTMi9aakltQzdKdGFudUpxYUtHZmpwM2xZM1pPWDBD?=
 =?utf-8?B?dzloYkN0VE1NakRFRlJQWVRyd25neitPUFoxV0ptRW1GSnZ1Wi9IVW1XdFAr?=
 =?utf-8?B?MlpRdkhBR1dHUkcxSERTT0N5c2xXWmFmdTUwUUNqS3BnL05yZXJwWjdUQmc2?=
 =?utf-8?B?cmU2ZWpJR3RRMSt0U0ZIcnMvL2s3eHJmcnByek1TOXlLWnE2RXhoWHRIcVE4?=
 =?utf-8?Q?uZgrbM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1lEZEkrMkI1Y2lQaUZyMFZjZ2ltdkJRNGtMZXNCWWxRR3JGNHVhcEZzNHcx?=
 =?utf-8?B?bjNMS3NrWmlFV1d6WE8yQmNJS2tKNTdRODdBcFJUQUtHWUNtbURoZkVYWUdL?=
 =?utf-8?B?MEZkQ1ZWTFBZdHRkcVV1TGdwTTdrZDVaTTRIdGlsZ3pHOGt4L2pYY21MRjBt?=
 =?utf-8?B?ZTFDRWwyQ2NHVlp4TlhXVHlLdGp1SjJRekZiVmtRZnJySGNxS01VSVBxUit4?=
 =?utf-8?B?ZStxeHVFQXR0UURsamVzVk83K0tkWVh6d2xKSVFtcnNKcmtGc0NCNGxXN3Bn?=
 =?utf-8?B?UHh2ajNRTWlidEVCS3Q2a0IvV21vZGJFanQwMnRIcEhGYjZUWjFicHA4U2Jj?=
 =?utf-8?B?dnlRcjlnKzBhdGVpL2puaGR4ZjI1UVZzb0MwRUVNQktFQ3NadWZrd0UweWFN?=
 =?utf-8?B?UjlJQ3RaWUh4dVovVkVubUdybG5wbFAvd1psTmNmM1l0cjh4YUZFNi9sb2FR?=
 =?utf-8?B?eTBncm9iQ3BELy9PODVuZkJYcXFsWWdDeFlHbHRKdmtFdG1YbXJvTnJUbTJa?=
 =?utf-8?B?bUJST3RrRXVJYkVlbnh0TVN6L1l2azNKbElzeGowS0Naak8wTjJ2UnBsS215?=
 =?utf-8?B?Q2VzbVNLeWpGZm1vL0lEbEpJY1pwTG9xL0pBT29PNGxHN3l4Rk9vM25GWUhr?=
 =?utf-8?B?U0lWa0xSQm5KaW9jWlU5RUUxOGZKVGdYSmszZitITy9NOTRia0cweEdhOGl5?=
 =?utf-8?B?UjlxaXZ5SjNjRWRlRTNWcCswRnZaRG9iNlM5TXZEczZxcG1kTWI1Y1h6ZTJi?=
 =?utf-8?B?YkdwbWVNL2dKbWpSVkRJb0dPRzYycWUvUWdOMHpSbjFiVjl1cGg5N1lsenRF?=
 =?utf-8?B?UWtwTHd6VFdIcStpcFhwalphbnpmRmQ2bjFDRGxGZFNrUUJJZkorRzRRbjNs?=
 =?utf-8?B?eFdJWTV0Umw5RmlaZ0tWMTBTbVgrR3o2SjJuWENDMG1IV1o2Y0h5NHlSOCtn?=
 =?utf-8?B?YUFZdEdvNmNPbVNwS3oydXZ4VVdyVmdLa2g5cGpseTBsVzd5dGtEVXBuVnht?=
 =?utf-8?B?ZWkxS3V5RXAxT09HZDhuOFlzZlQyRGpCYzVuQVg5SWxXZnNOMnFjWWx1THUw?=
 =?utf-8?B?Tmo0RjNLZGwyL1NoN0lYcENidVdiT24rc3hqeUlzRmU1TUdLZzhzZ1ZlLzE2?=
 =?utf-8?B?ZzlTUmltcjZwNFZ1LzN4UkNMcWloaDdmWTR0MFBHNDJOUFh4ejRJMjJWSmtM?=
 =?utf-8?B?dVVkQ3F0d29KMmlUeG9GR2xLQjhXMlpZdDFIeENWRDVSVjE1WTJkcnJzQ0k4?=
 =?utf-8?B?b2U5NUpMSFloS3U0Q3ZleUNub1g4eUlkRXdVM05wZXRuaWllMUVSUzhSL0xx?=
 =?utf-8?B?YTJWQlA3c0RnVk54ZTdvNTZvRlI5YVhlMFlvcjdMNE92K1NnbUhjUzdoVUZU?=
 =?utf-8?B?aXRtNmR6eXpTeUpmeGFVdFI0UzRxbFdWTlJjTktvZHNOSlRvM3JKWHY1M0o2?=
 =?utf-8?B?K1B5SlNjMElvOW9zaFMyV0pDUnhLeU9TTzFRMUdyQ0Vrd0h3emMrbGdQRFh6?=
 =?utf-8?B?L25ZR1RzL0pUV0FNOXlJYnNuMzk1UzN6N0JUckErUldDVU9JUGo4QkljbXdq?=
 =?utf-8?B?bWlJVVZ6dXQyVHdITU5QR3Y0UHM0UXZGUUI1N3JZQTBFK2t4ZWtkM0N6WWNU?=
 =?utf-8?B?bzc1ZzBKdm90amhVZ2F3SXhOM2k0a0lTUVZTK0RMdWRmS3NrOFo3S0dtcnlV?=
 =?utf-8?B?V1M5M1g4UGFWVXJFM2c0b2NKKzF0Y2dKM0lPVWpBbE9IQXZQaXMydU9UR05T?=
 =?utf-8?B?UUo3RG9FMzJNSlp5bVgxblgvSWxkQWtMZ1pyc2doVVliSGVUZHl6TGw2VURB?=
 =?utf-8?B?d1hwTGEyd2RhREpJbkM2TldOSVQvM2wwbnlPR0ZSbks1ZG16ZEFwRDdsS2py?=
 =?utf-8?B?SUw3eXNzUXdNRkc3N1RJKzdoZGNhSGRkZWpuQ2Fack5iblVsMCs1YzFYa25V?=
 =?utf-8?B?aXZQRElSRFJJNnpRdUJlMmg2QzRTWjVISzF5NGNTOWZkSFp2dHlDaFU1MS9Q?=
 =?utf-8?B?YTJONVF4SG4wQmpDbUZSa1lVZ2h4V0dneEZoVEhJQzNoTEJOWUU4dGNJeHV4?=
 =?utf-8?B?MmpYS3djT04rVzIySko1dGV3T3V3NTNncmJlN0ZObjV2S0ZQN1pML20yM3hB?=
 =?utf-8?B?MHBUdFJkTVN5R1hwenlaREp2dDk0TFFIRytINVJLVHVnQTdGUWRkWmcyWjJS?=
 =?utf-8?Q?UHymLcPkhw9JbB5VbdebJX4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D496881E48AC17468775BF8AE460D268@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 vAOIWa3R5RzkmDCutztMdUmBdxL3pbHMTylWJWsXrHpSFff9ioseHX9Fea/3GNq8WnBwWbUyv3Cixfquy6iHqU1NXVLbPEDKJqImuTJ/AhatBE25lXxVFw3OP1+HbffaP6F6hkyJd22NAfZS+UHQ2iKdq9BS6zntS8tqGq6lNY2uQB7BtADITE0mZSoEy8bDa340kVyuMtkZlCBYJKQkn7AUaIZV8MmyAllOyN6X9+4iVK/gwP5XSJ2xrvsHd1Ckrrr+eK5dtBOnSL6ZBGDrd7pZEnA2C4yyfs59BZnOY8NM6/9RSU6+jZWL+iEpS4DZ/aK32Bsj0jcgjBvcBxBdzlUQ5xW89Fp6YQeFdUaWt1qgRaxZrvFgjuKggmV1d6kGwFfu/m5xSKsFUcPEOHTJmy19fu8hbEzXs+qt5ek6s5V86XxNP8QhnrPdv9B7EZTGlTO75C5NmvGcInJO41tEEqMQkvfN6AEM1zYYC3gQzLiuB9Bf4ZWIJP9FeQKDDj+mXRc1EXB6FJGIcxudbddlwjVs2Y/2XYa7mgifMAZ4ZIdpoUuHZ0bXQ9yCQNXJRLkV/pzkwK2vEJJHtgX2qXyZrCkIRJP2VWBxnCs0eFh5c0s+XLl9QSIlKPOnSS9QXjEoxKQHJ7aN695Cb2doRMSM4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2965c6-77e5-4a6a-9ee8-08de28dd49c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 09:06:42.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUjUbMa/t7g1lCeQBaeeApdjmtQTcDz4l1GlaAoMI32sTF7eUJhh/sIflAJVhGnhH5f/+JCUAxHXxWMDFcur6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5656
X-OriginatorOrg: ddn.com
X-BESS-ID: 1763725297-111937-7773-3525-1
X-BESS-VER: 2019.1_20251103.1605
X-BESS-Apparent-Source-IP: 40.107.200.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYG5uZAVgZQ0DjRMM3EMsXQ0s
	wo2dLEwsjYwtzYLDU1NdEkMdUyzSBJqTYWAM+4JRVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269107 [from 
	cloudscan17-51.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

VGhhbmtzIGEgbG90IGZvciB0aGlzIEx1aXMhDQoNCk9uIDExLzIxLzI1IDA4OjQ5LCBBbWlyIEdv
bGRzdGVpbiB3cm90ZToNCj4gT24gVGh1LCBOb3YgMjAsIDIwMjUgYXQgMTE6NTXigK9BTSBMdWlz
IEhlbnJpcXVlcyA8bHVpc0BpZ2FsaWEuY29tPiB3cm90ZToNCj4+DQo+PiBUaGUgaW1wbGVtZW50
YXRpb24gb2YgTE9PS1VQX0hBTkRMRSBzaW1wbHkgbW9kaWZpZXMgdGhlIExPT0tVUCBvcGVyYXRp
b24gdG8NCj4+IGluY2x1ZGUgYW4gZXh0cmEgaW5hcmc6IHRoZSBmaWxlIGhhbmRsZSBmb3IgdGhl
IHBhcmVudCBkaXJlY3RvcnkgKGlmIGl0IGlzDQo+PiBhdmFpbGFibGUpLiAgQWxzbywgYmVjYXVz
ZSBmdXNlX2VudHJ5X291dCBub3cgaGFzIGEgZXh0cmEgdmFyaWFibGUgc2l6ZQ0KPj4gc3RydWN0
ICh0aGUgYWN0dWFsIGhhbmRsZSksIGl0IGFsc28gc2V0cyB0aGUgb3V0X2FyZ3ZhciBmbGFnIHRv
IHRydWUuDQo+Pg0KPj4gTW9zdCBvZiB0aGUgb3RoZXIgbW9kaWZpY2F0aW9ucyBpbiB0aGlzIHBh
dGNoIGFyZSBhIGZhbGxvdXQgZnJvbSB0aGVzZQ0KPj4gY2hhbmdlczogYmVjYXVzZSBmdXNlX2Vu
dHJ5X291dCBoYXMgYmVlbiBtb2RpZmllZCB0byBpbmNsdWRlIGEgdmFyaWFibGUgc2l6ZQ0KPj4g
c3RydWN0LCBldmVyeSBvcGVyYXRpb24gdGhhdCByZWNlaXZlcyBzdWNoIGEgcGFyYW1ldGVyIGhh
dmUgdG8gdGFrZSB0aGlzDQo+PiBpbnRvIGFjY291bnQ6DQo+Pg0KPj4gICBDUkVBVEUsIExJTkss
IExPT0tVUCwgTUtESVIsIE1LTk9ELCBSRUFERElSUExVUywgU1lNTElOSywgVE1QRklMRQ0KPj4N
Cj4gDQo+IE92ZXJhbGwsIHRoaXMgaXMgZXhhY3RseSB3aGF0IEkgaGFkIGluIG1pbmQuDQo+IE1h
eWJlIGl0J3MgdXR0ZXIgZ2FyYmFnZSBidXQgdGhhdCdzIHdoYXQgSSB3YXMgYWltaW5nIGZvciA7
KQ0KPiANCj4gSSdkIGxpa2UgdG8gZ2V0IGZlZWRiYWNrIGZyb20gTWlrbG9zIGFuZCBCZXJuZCBv
biB0aGUgZGV0YWlscyBvZiB0aGUNCj4gcHJvdG9jb2wgZXh0ZW5zaW9uLCBlc3BlY2lhbGx5IHcu
ci50IGJhY2t3YXJkIGNvbXBhdCBhc3BlY3RzLg0KDQpJIHdpbGwgbG9vayBpbnRvIGl0IGluIHRo
ZSBsYXRlIGFmdGVybm9vbg0KDQo=

