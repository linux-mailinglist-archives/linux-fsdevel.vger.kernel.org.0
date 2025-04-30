Return-Path: <linux-fsdevel+bounces-47721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E3EAA4BEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58B37B93BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A725E81F;
	Wed, 30 Apr 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="osGw8KLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F21E5734
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017403; cv=fail; b=SaoeqSw6+x2hAf8ZQn981g8p/df6luupwUngfC68ag1Pjy5RECAtI40aEYFvNx34vA0eZuryK1/Z4NGQsQTmT5/H1qDFJbWvQ1CbMcbl+npnktkUlv2oKzPfjQpqk31dyWGKNgc/U3CzG0wDwlO75/UBLUePO65pxr4ct1fgy5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017403; c=relaxed/simple;
	bh=31/IKGrydbKqyeaNMcs3uzqdlb9XTpNsL8S1g4hocyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0imMakSK0JTg+UvBJR/6/SZQjjNpWu7z0CjoIkrBdLWCZkZAfYL/YxVivtvpSQH4HQ9cg1phN6uv6kOkP/tOevv2Ne1XvYmY9E7H36jaB7W3Q4Q0LHYqZdl/t11NJTn3L5/DDC1aaoNFfB46cQVR8MYbTpIK4SJY9RTq0PErYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=osGw8KLP; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41]) by mx-outbound43-148.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 30 Apr 2025 12:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu8z9CLB7Tqe3jN9wW8LjAq0fMr7BW0ohxPEqjeuQ7t6ZiJ6HptfuLyoKifkUy55UghLweoGf26sMBvY1Abb1W3KYlZsOByz3X8YnDV7DYZQzGAogmW8ptUPHg0G6241EtZe4Za3vAUbIE/pdTL7yc7/rHUxrIzlsVsYFPSFSBgCzLC9BC7R6nt6BAjughHkSLsZ7rzY4/Kxiob7J0pmyyUg13gn8/msWa5ELAnUPvt51ggLjiGFTa+QVQmk4ocV4eYcl5T/DbC4TX5OLV/FYht5Zvcrjdm/ku8apWprpnkNAFuegXqKGenNbE87XxlNT5KmNYu8mmhea2Ki+zHzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31/IKGrydbKqyeaNMcs3uzqdlb9XTpNsL8S1g4hocyE=;
 b=lQiEpdfI2iyjsbmRD2LOwtYmjDzHW5OVyanjMi7rFeIz4mZGkJeindkCvZ/ByW00OZ5pFHrgaIUBDupL+lJTlH6WiBSrPD+3Kb+ioedeOf4+1Rosg2Ap1qr7uynSB2DTWTn/cZdyzWKNQ2Ot5ofrLvrSznbx3DKAiRBPxDo4Ygb58neKNd2h0xLaaUxJVKLhehO6XnNkihm2rGlo+UrOzE3Ye8+UYvWntdUcM12YptNLB7fFDFr+JzQSDl+afMt7JYu5QnUUV256KKxj9EFmuJYFjyDSsOzu3Lk76X3l2AxQF7Rn15y2RasS0RzXipSVxxbJB7z5WEsPd6CmKP9pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31/IKGrydbKqyeaNMcs3uzqdlb9XTpNsL8S1g4hocyE=;
 b=osGw8KLPmlom9/xBEllmh5h8G6OSXbFJHaLPGvydFuPf6GndVcuLf+iTMbU315AUCJn3YOZzpEEZNTeIhKSXAuMyiF0/ghJMWVwhPDTYdlqCkBWFYwP8zss1O+xmRKrojIsf/BvJoZoC4WA5lc3UAWMeE/k/9J3TgOSYluZiujE=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SJ2PR19MB7388.namprd19.prod.outlook.com (2603:10b6:a03:4c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 12:49:51 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 12:49:50 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Guang Yuan Wu <gwu@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "mszeredi@redhat.com" <mszeredi@redhat.com>, Miklos Szeredi
	<miklos@szeredi.hu>
Subject: Re: [PATCH V3] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Topic: [PATCH V3] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbuas06fMTHB1Ja0SjB27BJHK1lrO8KWIA
Date: Wed, 30 Apr 2025 12:49:50 +0000
Message-ID: <fa369ebc-1117-42cf-ad6c-9f56f23c5022@ddn.com>
References:
 <BN6PR19MB3187300E9AABB45A19FFC540BE832@BN6PR19MB3187.namprd19.prod.outlook.com>
In-Reply-To:
 <BN6PR19MB3187300E9AABB45A19FFC540BE832@BN6PR19MB3187.namprd19.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SJ2PR19MB7388:EE_
x-ms-office365-filtering-correlation-id: 67433cee-706e-4e56-dfe1-08dd87e57f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0FLNGlrVGdZNmVnWlBGZ3BvMjVxcVYvR0RLWDBQcXBYVDBLRXgvWWxkU0dO?=
 =?utf-8?B?ZStyaHZiNXRjQVVsclBoSGpWNDBMSGZRSG5YMnFXNzNJaVdTTDB0UVR0b3lv?=
 =?utf-8?B?dEkvdDB6eTRDRFpxa1orSStMeU9LYXVoUS9wQ3c2ZGFTUWFncE9RTE9Wakgz?=
 =?utf-8?B?UUtxR3FyZGU3d0d5ZWNncjE0bS90clNvNEpBajBjVitGQ2tWZGNNNTZXTWw3?=
 =?utf-8?B?RUlCUm9PMGFCNFJWVmJZQjJuYm1FQ2JHYVVjR2JKUGdJY3dodFpXa2wzc3RN?=
 =?utf-8?B?b212TGh3aXpMWnhXTDFmM2NxeURmeFRjSVRKTTloNEVyd1g1Mk1xZzF0Ri90?=
 =?utf-8?B?N3Y2Q3F0Q3RwMVd4SzZyVnV5eHFoa0o1d285cjJNS1RaVStCRmppa0twbGlt?=
 =?utf-8?B?VGl6TytOQ25aeC9GUlBtWCtVUEVXc2l6N1RyRVovbmNGWFRxNGtnazJHa1NR?=
 =?utf-8?B?RGlwVWJvR1c1RE5vb3RIdnhWRXNiVDd6d0xlbmZ1RCsyNFBMWkFhOXh5d2tL?=
 =?utf-8?B?MERPSUpBaW5iYU5MOW9jblJncmdqSzNWcUJUSTN2NHlHa2o4ZUtqNjRVS1Rr?=
 =?utf-8?B?QmtONi9QU1NrY3RSV1BMYlUxbHRXY2wxdjRwOVlEK0ZLRGJITGd4UDFpTjJD?=
 =?utf-8?B?Mm9UbkJGQXRHeFVwNlQrc1IyYTZTT1Zpdjg1U3d0NHhJZEVmMm45U1c0TCtD?=
 =?utf-8?B?QlJaOGZLMk9aS2toRUY5eXpTV0pxTHJxcEtJTitnb0ZsZHU2dlpWRjFwM0Jh?=
 =?utf-8?B?c0habEVHVFFRaWZiQnlUdHZrejB0TlF0ekpZWWZ4UlRjZ3BjNVZBK1ZNS2RP?=
 =?utf-8?B?RExjR3Z1QWNKaVFEL3QwUlA4SGJNL1RpL0F3bG9SYnZDQ1liVHRtTzJQOHJw?=
 =?utf-8?B?RFV0RDFXTzBVb0FDaXlMbVFLelFDT2dtMW55emlQeHUzQnlpV0p5cG1pN0V4?=
 =?utf-8?B?MjZ1cHR0bUUxUGxtOTNYYk5jQVBndExRY3lpNlZrb0ZSZ0ZpK016aFhIanVn?=
 =?utf-8?B?OVZhZEV4cTM3NjdUdFZVSFROV2JtYVJiTEhQWlFBbFkrRTVSZStmY0trNFVT?=
 =?utf-8?B?S3Q2NG9pL0F1ajZzZUV3eVg0Uy91bUdwTk9pbzF4U0hpR3czVGFnU3BDbEtp?=
 =?utf-8?B?U2tUcHhzdVJkNk9LY2s1NVdDVE5PNW5IUmg5NXBuVXMrTXdBN0tHazNmaWdi?=
 =?utf-8?B?bzkvSTRLbDl1WVFYSDAxR3VjbEdKWnAwYlVOL1BzL2hxTlU1TnFQNXRlNytu?=
 =?utf-8?B?U2Nqbm9zM0pLZzBMQmN0Qnk1dVRzWkl1M0g4Qy9xZHF6MmNiN0FzaW16WUQw?=
 =?utf-8?B?c1cwVTZxblhlUm5SbmRxaFVINE5zOXV5S2gyTkErK1BzUkVuTzY0ZHlWR1Z0?=
 =?utf-8?B?MTNGMWpYS1hpZE5xK2lzNTVkVWF1Ung1MURqaXZKc3VZYWJhRzJBWWpjby9I?=
 =?utf-8?B?SVZTdnhLaDJsMEtyTUx5T1ZqejVOOUs0RTM0L0FBNnB1UFYybzZNYTkwSm5w?=
 =?utf-8?B?a29DMnRzajF3dUtHQTJGKzZlbWJHd3Ivd2JCMmNqSytlK2RUVHlOdW5wNVl2?=
 =?utf-8?B?c3AyWlRhZHJ1S1lSeGZVR1pMZTlDSmh4aDNxNHBuSG80dFh1RXZRcDVEY3FC?=
 =?utf-8?B?b0txa3dQdStCZ1p2UHNkRk1peG0zUnlRVE1CMjIrVHhvZnNVRmRFUEZSSkJX?=
 =?utf-8?B?UGg4Smp2NExJRFZaT29nNmtjdEpxTXNOWmMrT3E1NThKL2I1MzhhTU52ekJl?=
 =?utf-8?B?a3Z5V2tlMjI1OGsrZTlpelBTa2pVRDJONVQ4NlBsTDFYK3JwTytIUFA2eFlF?=
 =?utf-8?B?NE1OaUV1K2szYjM1ajNDOWdoUFRYVmJTYnBWUENheEpCZ2NhNW1ESUs0Zk1t?=
 =?utf-8?B?YWhkanVqdHZUUW9wZ0tNSG5NWVJwNHQ3aUY0RE5QckFpOGZvclVqUzNOdkY4?=
 =?utf-8?B?SHNWSzhBWFp2MDIxZTI0TXdHeTVnWi81QlR1VTh1aGxKS0hhQjNMblFkRmli?=
 =?utf-8?Q?i55PI62pqXugj9bpKJwIVq9Zly90O8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmU1M1IrOTdoVXJWVkRveUw3NkdLQnJSZVp0TGUxVU1LN2xiMkhzMXU1YU5z?=
 =?utf-8?B?ZHE4QWNQZ09rQ2ZXRElhaGZsUXQyVlFic003UHg5ZlFHV1NwY1k2VlZNTk1L?=
 =?utf-8?B?dGxCd2QyQTRFT2d3R1BKZEZuRi94WFdMdUE1S3M1VnJncDZralN3RU55NW4x?=
 =?utf-8?B?SVlXWTJ5Q1Q1LzhiRE1OdkhFMHVQOExwSFIyQzcva1RKdXZBWDFGMnkzWHZP?=
 =?utf-8?B?M1BEemt6VGJmdFE0WGV5alVaTE9NeXVZMDdiSGlIMjlNU2tuM2c3OC9IM1Bs?=
 =?utf-8?B?dXVkdHpUMWtYSUdzTWdEQXR3VG5Xd1BERjJFS2QreS9LdWN2eDlZRE1mckN5?=
 =?utf-8?B?cS94UnM0QkpNVEZlbXNRc05LQnNqdFphc1BBMnlRdWJCUnJsR2ZDWlN6eXI2?=
 =?utf-8?B?QmlaNHpuNGZlRzNPVWwyRjMwTVhnVDJOY0MrZ0pybHBEZGFHTFZXU1A2aTFL?=
 =?utf-8?B?aGhGNmVNMzFiK09GZisvT1JRSkIxc2Q0QW5RMWN5b21BYjdFMWg4Y3pkYlF6?=
 =?utf-8?B?SkJmSjZHU0k0Qmx1cVVraXd1aHlnY1VtREkrUEorcW5OVWdUK3RHeEVSdEhU?=
 =?utf-8?B?a045cmlhcEpGOWtXSE94dW5Wcjh2UFhhcW5FQkQvanBQOFJ6aWVxVlZYT09U?=
 =?utf-8?B?U0p6MzZIYUVCNjVBT3B4Si9NODNGRkt4VGkvT1ZvUEpRV05hKzJlN3NLY1NE?=
 =?utf-8?B?SHdHckdwNjVRRWZ0UWZKU0FyK2VuVWFFaXMzZERUc01hd3FFTUVzSmpZTFhs?=
 =?utf-8?B?bExnUWxJMnZwejZOYlNqajR0SlFZS2NDUURWbjBGdUZDQ0YzK1VqZklhd0VC?=
 =?utf-8?B?dGx3NWc5NTdEMXpYdWpoWVhoTW0vT04vQTJ3NEpPbmNrRVJ4eVNuSUpIc29R?=
 =?utf-8?B?bWk3ellGQnp4OVB5Sk5pbEs2RCtWVVQ2NTI0bmx0ajJ1ZWt2MjJXU21FdG40?=
 =?utf-8?B?bEtoaEhGanRTMkQ4QTlEVzB0WHlDWnJZSlRhSnEraXMzSHIvMkZGVzRGQzE4?=
 =?utf-8?B?NHBVTnNzODNSdkkzRXdnendhaFQ1WXUyOEthMm9YOThocCtkRUI3a1UrWWd3?=
 =?utf-8?B?b3V5YXNzdmNtQlh6Uk9mdVVCczJDdlFoQzZTdTU4MmZORFFrd3Qrd1dZdWlZ?=
 =?utf-8?B?NUJiNy83ZEt3T3ZEQ0lsUGxLR3huOW4ramZSTndHRk9nRnpkTVJRRFRPaHY4?=
 =?utf-8?B?UUpSNHlCQnJwM1pJRGVaNnBuWG5uSFFuVmpHTEo4eGxOamV4OWNUSEs5Y2tt?=
 =?utf-8?B?Qk1BY2h5SUI0RzJPM3hKRVhCWTFVMjFDaVlGaTFLNkh6SXNhcXp3b2lkcFJP?=
 =?utf-8?B?SkY2NENvNEswbXRxTGRibUpVMDJzaG5TalNRWjFWeVR2NHd2ZWpSdE9FNk1p?=
 =?utf-8?B?TVkrSW1PQVY5MVc4bG9pSlVML2ZUckwrQXlmc29DSmFvaW9wOGc1VjY0Yksz?=
 =?utf-8?B?dzNFU3RWNWRaU3NNSFZRQWlCRjZPK1FWbjlhMHpiQnJocVRwMnl2TEpvMzdh?=
 =?utf-8?B?TUhuV2tnVHRoS1c3bWFoenF1SnNSakt1alVMNVQ5blI0SncycUtCM1NSdnVy?=
 =?utf-8?B?N1BjMTRDWGk2WU9Qem1YTzJIQUp4M1F0MjdwSFVTSGRVRFN2V2tZMUxMSm9X?=
 =?utf-8?B?RGk1NlJiWXcvZHVsbjhjNjAvelY1c0FjaWFicVA5VmZROE1lT0NFNUF1SUNT?=
 =?utf-8?B?Y2pmNFV4V2FLeUJ1Y05NaDMrSDFqc0xOck5QblhGZU5VeDUwQzVJQUtEd3I5?=
 =?utf-8?B?VHNSQmxzSUxjb2VmZ212bWZaYVBuQkl5QkRqbUZNNGRTOE0yWSs0dDVBUmhy?=
 =?utf-8?B?U1NwU01hSk9STGdBSUs1WTd0WndtRHNsb1FLaW1tNmMzbXVmTTM5dVQ4dXFp?=
 =?utf-8?B?QkI5OXV1UFQrYzJ6SUY0ejdKRDYwNFJsRVNQOFpUY0hDdHRVdmRVcjVqOHhG?=
 =?utf-8?B?cDJuQmc4OEtZL2NwMDNtcHp5MXlMT2k5Qy9iTzN6REEwd1kySGtnU0Fld0l6?=
 =?utf-8?B?Y1VDMk14eWh6N3d4c29TYVFPN0RRenBadThEZUU4RnZ4S1ZmMkZJNm9WQ1FR?=
 =?utf-8?B?Q1JSUFUyU3hmeFhRZEtVUGtzQW9ORnpkTWl4RlU1REcxS2hJUU5yN3FxUWFU?=
 =?utf-8?B?SjV0OGExdkFiZWRZdlZubDY5T2dtdkg2cnk1R3FzcnhRenNCRmp0bXFiREZr?=
 =?utf-8?Q?QpxP0g2jLwjiZ4HLDW/eOnk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0023FD065858DF4D9B93C831C066676F@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A4M90FeWGkc+8Ik+EA0KNzQeY2tvgCxD5R6fC7ZcCNOceDujIjN+nrepeb63tyHpa/Pj+GocDmqL5akZ2MonGMdJhUSCLu3269uWKNxK01HJdVqMz3Z8R0AEvVEriPXFXpDPh23KEAcpqab6nj+SYsNyFXIQfUavGx7ZB2ekyLxhiK0N7sMrSLMcDFCkQwjuMXSRkFbAYp90jUGFHDUW8zo3LlFir5TTOzcPPLyhI8c+MmziQQvkwmS+Ua73qysp9k/XVEcxh9RYOGJ/IArWrso7vrmIOBre11d1UFRKyKfMwk17VAEZehad+0Cs7UzcoZlUSbFhPrMrlCmDDA6nPCAo5+azprIOsI9F+lqow1bitRPHGjwG0jDRvO5ME5vPB+zIKmxpT4ngm8s4S5XXAht/3xyKixeabowwGs7ogL81vXcY7Wcufp9s64ZuB2Cio7upVH4yEcQzODWne9nN2NzsSz73oVybfQl47MlNCXKbVcQbCJLWBSEjHNb1tKF+Vu3gIrhrTVu6LUP/CJPTF6//WTt0ywbhoS4NqdOnqxRURUchQNpBL+B832yKqnwd2BHGpdxYnpwvquql5J6zv52ABnmPpic+mK+WqpjCycuWivmlZcszExpux62kh2g0T2rYRnxVrdbAuaDeMpqadQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67433cee-706e-4e56-dfe1-08dd87e57f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:49:50.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXvc5mcCpKsTMm37J0EBtV9rVvAEz63q8dXUI8afBWmtVRwxQUVvAxqwSpGbus2mg1EC+tx2s8zdgeEataiqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7388
X-BESS-ID: 1746017397-111156-7827-376-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.58.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbmpqZAVgZQMNnYONHELM08zc
	wy1cjE3CgpyTI11cQiOSXNzNgoKTlVqTYWAApl5jpBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.264259 [from 
	cloudscan8-162.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status:1

T24gNC8zMC8yNSAxMDo0OSwgR3VhbmcgWXVhbiBXdSB3cm90ZToNCj4gSGksIGFsbCwNCj4gSGVy
ZSBpcyB0aGUgdXBkYXRlZCBWMyBwYXRjaCB0byBhZGRyZXNzIEJlcm5kJ3MgY29tbWVudHM6DQo+
ICAtIGZpeCBmb3JtYXQgaXNzdWUgKGtlZXAgb3JpZ2luYWwgdGFiL3NwYWNlIHN0eWxlKQ0KPiAg
LSByZW1vdmUgIlJldmlld2VkLWJ5Oi4uLiIgbGluZXMNCj4gIC0gaW52YWxpZGF0ZSBhdHRyIGJ5
IHRpbWVvdXQgb2YgaV90aW1lLCBpbnN0ZWFkIG9mIGludmFsX21hc2sNCj4gDQo+IA0KPiBWMzog
DQo+IA0KPiAgICAgZnVzZTogZml4IHJhY2UgYmV0d2VlbiBjb25jdXJyZW50IHNldGF0dHJzIGZy
b20gbXVsdGlwbGUgbm9kZXMNCj4gICAgIA0KPiAgICAgV2hlbiBtb3VudGluZyBhIHVzZXItc3Bh
Y2UgZmlsZXN5c3RlbSBvbiBtdWx0aXBsZSBjbGllbnRzLCBhZnRlcg0KPiAgICAgY29uY3VycmVu
dCAtPnNldGF0dHIoKSBjYWxscyBmcm9tIGRpZmZlcmVudCBub2RlLCBzdGFsZSBpbm9kZQ0KPiAg
ICAgYXR0cmlidXRlcyBtYXkgYmUgY2FjaGVkIGluIHNvbWUgbm9kZS4NCj4gICAgIA0KPiAgICAg
VGhpcyBpcyBjYXVzZWQgYnkgZnVzZV9zZXRhdHRyKCkgcmFjaW5nIHdpdGgNCj4gICAgIGZ1c2Vf
cmV2ZXJzZV9pbnZhbF9pbm9kZSgpLg0KPiAgICAgDQo+ICAgICBXaGVuIGZpbGVzeXN0ZW0gc2Vy
dmVyIHJlY2VpdmVzIHNldGF0dHIgcmVxdWVzdCwgdGhlIGNsaWVudCBub2RlDQo+ICAgICB3aXRo
IHZhbGlkIGlhdHRyIGNhY2hlZCB3aWxsIGJlIHJlcXVpcmVkIHRvIHVwZGF0ZSB0aGUgZnVzZV9p
bm9kZSdzDQo+ICAgICBhdHRyX3ZlcnNpb24gYW5kIGludmFsaWRhdGUgdGhlIGNhY2hlIGJ5IGZ1
c2VfcmV2ZXJzZV9pbnZhbF9pbm9kZSgpLA0KPiAgICAgYW5kIGF0IHRoZSBuZXh0IGNhbGwgdG8g
LT5nZXRhdHRyKCkgdGhleSB3aWxsIGJlIGZldGNoZWQgZnJvbSB1c2VyDQo+ICAgICBzcGFjZS4N
Cj4gICAgIA0KPiAgICAgVGhlIHJhY2Ugc2NlbmFyaW8gaXM6DQo+ICAgICAxLiBjbGllbnQtMSBz
ZW5kcyBzZXRhdHRyIChpYXR0ci0xKSByZXF1ZXN0IHRvIHNlcnZlcg0KPiAgICAgMi4gY2xpZW50
LTEgcmVjZWl2ZXMgdGhlIHJlcGx5IGZyb20gc2VydmVyDQo+ICAgICAzLiBiZWZvcmUgY2xpZW50
LTEgdXBkYXRlcyBpYXR0ci0xIHRvIHRoZSBjYWNoZWQgYXR0cmlidXRlcyBieQ0KPiAgICAgICAg
ZnVzZV9jaGFuZ2VfYXR0cmlidXRlc19jb21tb24oKSwgc2VydmVyIHJlY2VpdmVzIGFub3RoZXIg
c2V0YXR0cg0KPiAgICAgICAgKGlhdHRyLTIpIHJlcXVlc3QgZnJvbSBjbGllbnQtMg0KPiAgICAg
NC4gc2VydmVyIHJlcXVlc3RzIGNsaWVudC0xIHRvIHVwZGF0ZSB0aGUgaW5vZGUgYXR0cl92ZXJz
aW9uIGFuZA0KPiAgICAgICAgaW52YWxpZGF0ZSB0aGUgY2FjaGVkIGlhdHRyLCBhbmQgaWF0dHIt
MSBiZWNvbWVzIHN0YWxlZA0KPiAgICAgNS4gY2xpZW50LTIgcmVjZWl2ZXMgdGhlIHJlcGx5IGZy
b20gc2VydmVyLCBhbmQgY2FjaGVzIGlhdHRyLTINCj4gICAgIDYuIGNvbnRpbnVlIHdpdGggc3Rl
cCAyLCBjbGllbnQtMSBpbnZva2VzDQo+ICAgICAgICBmdXNlX2NoYW5nZV9hdHRyaWJ1dGVzX2Nv
bW1vbigpLCBhbmQgY2FjaGVzIGlhdHRyLTENCj4gICAgIA0KPiAgICAgVGhlIGlzc3VlIGhhcyBi
ZWVuIG9ic2VydmVkIGZyb20gY29uY3VycmVudCBvZiBjaG1vZCwgY2hvd24sIG9yDQo+ICAgICB0
cnVuY2F0ZSwgd2hpY2ggYWxsIGludm9rZSAtPnNldGF0dHIoKSBjYWxsLg0KPiAgICAgDQo+ICAg
ICBUaGUgc29sdXRpb24gaXMgdG8gdXNlIGZ1c2VfaW5vZGUncyBhdHRyX3ZlcnNpb24gdG8gY2hl
Y2sgd2hldGhlcg0KPiAgICAgdGhlIGF0dHJpYnV0ZXMgaGF2ZSBiZWVuIG1vZGlmaWVkIGR1cmlu
ZyB0aGUgc2V0YXR0ciByZXF1ZXN0J3MNCj4gICAgIGxpZmV0aW1lLiAgSWYgc28sIG1hcmsgdGhl
IGF0dHJpYnV0ZXMgYXMgaW52YWxpZCBpbiB0aGUgZnVuY3Rpb24NCj4gICAgIGZ1c2VfY2hhbmdl
X2F0dHJpYnV0ZXNfY29tbW9uKCkuDQo+ICAgICANCj4gU2lnbmVkLW9mZi1ieTogR3VhbmcgWXVh
biBXdSA8Z3d1QGRkbi5jb20+DQo+IA0KPiAtLS0NCj4gIGZzL2Z1c2UvZGlyLmMgfCAxMiArKysr
KysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5j
DQo+IGluZGV4IDgzYWMxOTJlN2ZkZC4uYTk2MWMzZWQ3YjI2IDEwMDY0NA0KPiAtLS0gYS9mcy9m
dXNlL2Rpci5jDQo+ICsrKyBiL2ZzL2Z1c2UvZGlyLmMNCj4gQEAgLTE5NDYsNiArMTk0Niw4IEBA
IGludCBmdXNlX2RvX3NldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBkZW50
cnkgKmRlbnRyeSwNCj4gIAlpbnQgZXJyOw0KPiAgCWJvb2wgdHJ1c3RfbG9jYWxfY210aW1lID0g
aXNfd2I7DQo+ICAJYm9vbCBmYXVsdF9ibG9ja2VkID0gZmFsc2U7DQo+ICsJYm9vbCBpbnZhbGlk
X2F0dHIgPSBmYWxzZTsNCj4gKwl1NjQgYXR0cl92ZXJzaW9uOw0KPiAgDQo+ICAJaWYgKCFmYy0+
ZGVmYXVsdF9wZXJtaXNzaW9ucykNCj4gIAkJYXR0ci0+aWFfdmFsaWQgfD0gQVRUUl9GT1JDRTsN
Cj4gQEAgLTIwMzAsNiArMjAzMiw4IEBAIGludCBmdXNlX2RvX3NldGF0dHIoc3RydWN0IG1udF9p
ZG1hcCAqaWRtYXAsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gIAkJaWYgKGZjLT5oYW5kbGVf
a2lsbHByaXZfdjIgJiYgIWNhcGFibGUoQ0FQX0ZTRVRJRCkpDQo+ICAJCQlpbmFyZy52YWxpZCB8
PSBGQVRUUl9LSUxMX1NVSURHSUQ7DQo+ICAJfQ0KPiArDQo+ICsJYXR0cl92ZXJzaW9uID0gZnVz
ZV9nZXRfYXR0cl92ZXJzaW9uKGZtLT5mYyk7DQo+ICAJZnVzZV9zZXRhdHRyX2ZpbGwoZmMsICZh
cmdzLCBpbm9kZSwgJmluYXJnLCAmb3V0YXJnKTsNCj4gIAllcnIgPSBmdXNlX3NpbXBsZV9yZXF1
ZXN0KGZtLCAmYXJncyk7DQo+ICAJaWYgKGVycikgew0KPiBAQCAtMjA1NSw4ICsyMDU5LDE0IEBA
IGludCBmdXNlX2RvX3NldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBkZW50
cnkgKmRlbnRyeSwNCj4gIAkJLyogRklYTUU6IGNsZWFyIElfRElSVFlfU1lOQz8gKi8NCj4gIAl9
DQo+ICANCj4gKwlpZiAoYXR0cl92ZXJzaW9uICE9IDAgJiYgZmktPmF0dHJfdmVyc2lvbiA+IGF0
dHJfdmVyc2lvbikNCj4gKwkJLyogQXBwbHlpbmcgYXR0cmlidXRlcywgZm9yIGV4YW1wbGUgZm9y
IGZzbm90aWZ5X2NoYW5nZSgpLCBhbmQNCj4gKwkJICogc2V0IGlfdGltZSB3aXRoIDAgYXMgYXR0
cmlidXRlcyB0aW1lb3V0IHZhbHVlLg0KPiArCQkgKi8NCj4gKwkJaW52YWxpZF9hdHRyID0gdHJ1
ZTsNCj4gKw0KPiAgCWZ1c2VfY2hhbmdlX2F0dHJpYnV0ZXNfY29tbW9uKGlub2RlLCAmb3V0YXJn
LmF0dHIsIE5VTEwsDQo+IC0JCQkJICAgICAgQVRUUl9USU1FT1VUKCZvdXRhcmcpLA0KPiArCQkJ
CSAgICAgIGludmFsaWRfYXR0ciA/IDAgOiBBVFRSX1RJTUVPVVQoJm91dGFyZyksDQo+ICAJCQkJ
ICAgICAgZnVzZV9nZXRfY2FjaGVfbWFzayhpbm9kZSksIDApOw0KPiAgCW9sZHNpemUgPSBpbm9k
ZS0+aV9zaXplOw0KPiAgCS8qIHNlZSB0aGUgY29tbWVudCBpbiBmdXNlX2NoYW5nZV9hdHRyaWJ1
dGVzKCkgKi8NCj4gDQoNCg0KRm9ybWF0dGluZyBvZiB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgc3Rp
bGwgb2ZmIGEgYml0IC0gZWl0aGVyIE1pa2xvcw0KbmVlZHMgdG8gZWRpdCBpdCBvciB3ZSBuZWVk
IGEgdjQgdmVyc2lvbi4NCkZvciB0aGUgY2hhbmdlIGl0c2VsZjoNCg0KUmV2aWV3ZWQtYnk6IEJl
cm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4NCg==

