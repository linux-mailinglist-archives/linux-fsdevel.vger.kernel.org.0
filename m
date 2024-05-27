Return-Path: <linux-fsdevel+bounces-20251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6448D0683
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AC61F22416
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666673443;
	Mon, 27 May 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Eanvf8Mv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914261FD8;
	Mon, 27 May 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824858; cv=fail; b=awGyJs1taSeA00K8i3quHlFRtxcoBTw6Pikdm2hpWUd235zMRr7+GUhv+CLr7Fi4BGAMpNW+mMJ+T3W5jBU2cZHy5urNGJ1E5G9TKM71NUOwkRV3Df0eKqJ2H7azNeCl9gF1VUg2ST2KJV1pfqyfMOAsSeHAAuiUjLOj511ESoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824858; c=relaxed/simple;
	bh=GUGWStxKlkpKlb4631tLdxJX9m4bOMHuYfomHAKr5bc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qc9LUd7OVid+2+47nczk+H/Gr85wtpKPrG/gARUf2toLFR4IewKKqmncKkHCPTQjcOuAsj6JBXu1b5iIQcvgph2xwJpjZiWCgCy3az9Bx76ZwSnVPH3q0ZCGAxsq89NyI3TmM7035Ry7AZqF2wlb9ayZzzjKl1M3F0lr2VBWSaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Eanvf8Mv; arc=fail smtp.client-ip=40.107.93.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+cIbGZyRkQV/UqBRshONuu3cFLfYel9DLy2IV9Vgp6Jy+h5CECPiDG6IKfdiNdlt48JBno4rPMU8WQxd70Eu4JE8ckUQFHe1C6trecfw8KCoShkS9HSEU0AN6tdcx7m1qOr0EQxSvhY3ntqCVNuvcuT0O8jedQnbiRTuvWEZN7vHkWFmzMtljf4B6y/KtwGzoHNHxmqcVyyItt3ilPdHPevRy3HOu/CTxqUmJeS5hHdXDID9knBx19HaCYOYRh9bZY5OQT+eBBxKLjyHVi8mjqGUpVYNraZUJ4ufw6Iqy+Yw3GgTNhDay/TRVij6LHD5OnXnuV/oX1rArKTLkHRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUGWStxKlkpKlb4631tLdxJX9m4bOMHuYfomHAKr5bc=;
 b=l6quoHvOUOQKBFw1g/7eq/T1HTc5C6KM1ALr307xUNwp0n/Miw+muU4lqccbqAg8/1Nqv9r0cKp/e1guRRnlmzJt8PYVWNWJ3ciFYzlAl98J1VEty9U9nFXD8KSV9usfKeiuh3csT+gkKx4SRAi6Gwic3UAp8EcOyNVX3gWLkUHd4QQkIQ8o8EyZXQ+0wZXlBd5OUsA4TTYKpXUMx7CYdWUyIqj4/kQN5EIez6VbtJ5DWG+e44V0rOIect2YJki4Nys6XNIGeJj7lNwuGbywnUIwZj+JXq9veDY1p4bGCiOVlgq0Iq7zc7kVa2B0ptELamUOGU3CLvFL8emCWyLoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUGWStxKlkpKlb4631tLdxJX9m4bOMHuYfomHAKr5bc=;
 b=Eanvf8Mv5g++AOlwxbbhssthDTw2Fb9yTWdODj7kE2qGOk1YXP7VZE4xBV9LKvgfq1qAjL5nouk9jK+XTuir97xLhR70oaIqAgBIYrPnd1HleBIsvo0f5flpO9+kei+EI0SduGUW8KRWhjrxhvldhu65+iZhte/B9SDNdPk4xl4=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BY5PR13MB3780.namprd13.prod.outlook.com (2603:10b6:a03:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Mon, 27 May
 2024 15:47:33 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Mon, 27 May 2024
 15:47:33 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "brauner@kernel.org" <brauner@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>
CC: "jack@suse.cz" <jack@suse.cz>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "alex.aring@gmail.com" <alex.aring@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Thread-Topic: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Thread-Index:
 AQHarVPtSe6qdv/lgk2vl1eWJoqLMLGpQqoAgACg0ACAARlMAIAAC3sAgAANd4CAACn+gA==
Date: Mon, 27 May 2024 15:47:33 +0000
Message-ID: <49b6c50a50e517b6eb61d40af6fd1fd6e9c09cb2.camel@hammerspace.com>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
	 <ZlMADupKkN0ITgG5@infradead.org>
	 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
	 <ZlRy7EBaV04F2UaI@infradead.org>
	 <20240527-hagel-thunfisch-75781b0cf75d@brauner>
	 <20240527-raufen-skorpion-fa81805b3273@brauner>
In-Reply-To: <20240527-raufen-skorpion-fa81805b3273@brauner>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|BY5PR13MB3780:EE_
x-ms-office365-filtering-correlation-id: 36505d99-a056-439c-64a1-08dc7e6452f8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VW84RVdSK0xoaExiNzVKbjllVTJjR3Q5aDhBRy9kM2d3b3BBOEJpckhMMUN3?=
 =?utf-8?B?SGxJcjRFL3prdEd3b2orQWVQelZKcy9vaUlHdW1UN3JZTm1ubzNHRENRT2xk?=
 =?utf-8?B?SExHV0lYQnI0dG50VlpkZ1p0NUdFRUlyYnJkbG1aYW1OOHRrenk5ZysvMGNJ?=
 =?utf-8?B?Zlc0Z214Qnl0TFlLb0Uwc1dYODAvbHc4dVdnN0ludjc1T1NuOEZ6dTFXRTRZ?=
 =?utf-8?B?T3lyZ0gzY1NlV2ZOR1djT1IwZjFEakw2dmVCYXpaeWhQRG1VZDhEd290aGdi?=
 =?utf-8?B?dW84Si9KcUN4cUg5TVQxakNoczR6YmdvdENuOXp5YjdqaVBnNE4raEdnOFdi?=
 =?utf-8?B?SGJOMjN4bzc3MmV3OVFybWVqTnAxYjRUbUhnVDdoNFQwOEJqMkFSekp4cUlF?=
 =?utf-8?B?SFVPYzVLM3hLaE1VQ2pySmJUMW9XOUs0LzJmMmdua1JiRXFvRXZpTnVoZW5y?=
 =?utf-8?B?SjNEOHZYNzdzdmkvbVVQYXgyQ3pVbitndlZNeHV4eEFmZTc1NlJodnNaU0cr?=
 =?utf-8?B?UCszdU5FaVdrWnRQenpvSm5ZTFVjY3BLSDdJSXVjV2wwU1VoczVQZ01DUktE?=
 =?utf-8?B?SWdQWnRIdWJmN1lRUGQzbWUrbjdrTlJSbXFKTDI3UGhncDE0QVErRHRoSkhs?=
 =?utf-8?B?b2k2Mnd1RFVSSWpFWTZ5TFZEaFpoSTlhcjkvYUNHNkxiU0ZZanpwOU5UeDVi?=
 =?utf-8?B?dlVpMkdabXBodkM0eFN0TTc4YVJ3bVp5SU8xUGRyc3ozT2xOS3Nac2IzOHJQ?=
 =?utf-8?B?Ymhidi9YKy9jOVBxVlREZ2RVekRQZHI1RGhNalNLZ1A1aS9jc004djZzc3Yv?=
 =?utf-8?B?MkVNUVJRVW1YajBETE1zUzIremduSzIxN1pseVpnRGpqQ3Z4VDNPWGl2UDVs?=
 =?utf-8?B?VUhQa3VoWE1NdTVGaGJocVROZGpnV1BiK0ZpTlMwcTZDQlVTQTAwdjBEQVMy?=
 =?utf-8?B?TXhyVnprNFlKeCtQdG45TDlDbjQ5ejBjWmJGYXRocXF3OERHb25sM3pLWXA0?=
 =?utf-8?B?dHhHWFRsWmZWWkZ4MHlwQ2llQzNWdmZZblFEN2NIR2tXQjlXQVFpTUNrck5l?=
 =?utf-8?B?OC83Qmo4WXloQmFBODdlQ3FRV1ltQ0hRc1Frd05HVFRQdG1HL2RwT1BzeENO?=
 =?utf-8?B?MWdLdStaaGN0ZFVKY21WbjdZUitLTnZCV0ErQ1JZZXcvYXBKVzBDdlM1b3Iz?=
 =?utf-8?B?VDR1YWZNTWFwWkZXNnBnWHUwN0hQUTZqbjY5LzRmZWlrR0JMdllHQlBWS1dk?=
 =?utf-8?B?OWo0OUlGM1FWVjFVd1d2Tkp6dFhXYndmKzNTbzZDbm1JQWdTZC8ydXJSSGRv?=
 =?utf-8?B?ZmRXMi9qU3RNMkQ5bzMvdzdpbDlVWkNjZ2QyZ0N3VWlsZVNTbG9BY2tVcEIx?=
 =?utf-8?B?c09aQ1RrUEpOOGlaSGwxc2NnLzJkNTMrSmdld1poMUx2ODlYeVk1RGNHdVRW?=
 =?utf-8?B?b3JoVDlJbThuV1RTQXVhenpKUXZlYzJreFJEelBaa1crRHZmZjRhelp2QVoz?=
 =?utf-8?B?WHV4VVI0aU5qNjJqNmRZdkdDUEpnZVJRWm9qb0VGQ3E5REtmUkRNNDRBM3Rw?=
 =?utf-8?B?M2ZrSDZRdmQxMW9idDJDZk11ODhsbWNRQmlIc3JZMnZtQXJnS0ZDM1lJNERJ?=
 =?utf-8?B?TDdjdW4yWmVuNURxcjVDY05pN0ErZm9YaWpIbHlyMVhWOFQ0bVRpUTNpSTR6?=
 =?utf-8?B?SnFOUVdvZ2lNSkN1bU5pV3BvU3ZwU00rNW14U1crWVQva1NCQUY0NUZJZFpL?=
 =?utf-8?Q?shj82RdEfg7qR5wmMpks2XeD1LRAXVfn2qU7Hjz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmE0ME50RTdWR2Q3K1RXampYRUR2NHROSHc3d2tuYVU1YTMvNDcvOS9YY3FN?=
 =?utf-8?B?b3NHdjZBTVNVRzNCSksyaTdTQXNaSS9TUFhyMFVXNzE0MkVvS0pXNGExR3cw?=
 =?utf-8?B?SVB6OGd3Lzhsa2w1OXgrSnVZM1VHaEZMcDl4azYzZVp6K0laSWJVUTJHaHdD?=
 =?utf-8?B?UjQvR3YwTnBYTjIwdDN1VkNLdmhKdmxEYmNhTnRzV0EwNjF1NnU0WEFlU0Jj?=
 =?utf-8?B?K2p2bTNuMVgzNUZNcmlaZXcwbmhKdXhZSUt2KzZKbWpMU0V2VVJXV1JlYmNB?=
 =?utf-8?B?OFEvWjVvUU9obVVmVit0Ync4U3I2ZXZIamZXZlhvcXlldEpQMk9FV3FqL0Iw?=
 =?utf-8?B?d01CQ2laSlRxWkgyVkFyMGFhOHNqVGZIcmFYaVBQZXh1N05tTGkralhvbGky?=
 =?utf-8?B?ZVZ2MEk2bTBnK0hrQkNtOEMweDFXY1lMSE4ydTEwWFlWUEp5RlZyQWNLczBl?=
 =?utf-8?B?UVNQYTNxUWpDMVZ2MVFuRGEvQVB3dUU4cGd1MEpMakxaZnptVll2RHJ3c0lP?=
 =?utf-8?B?SHVQOFB2LzgxanEyNm90MVk1VWdtekU2UG82c2FSN0c3M2Vpb0ZaSndYaTVr?=
 =?utf-8?B?aytFUlBMRlRNRGxCWGJPcnkzNmR0aTkzU20xOFBTV1VzZ1U1a0tUK29Zdkhs?=
 =?utf-8?B?dXY1eHRWNWdadzRkOGZjdjd3TUpnMkovTmZ5T0YrU3FrMk9OYTVNME9BbW5C?=
 =?utf-8?B?MlV2YWJpbkxrcnZUODRmWjNiWnpndjhYWW1zUUpUbi93bzhhUnMrSlVkRHRw?=
 =?utf-8?B?QUJ5ckhwMjIwT2hvQjkvMEYwd1VzZHdJMEpuQUQrS2l1QnpTVmFsZ1JZK1FZ?=
 =?utf-8?B?UFdJMXB5UFE0UFE2c2N3N1k1OUtIb29uTGFiNmVmYmcrazBYTEl0VWVMQW8v?=
 =?utf-8?B?SEJRM3ZVVFBKUW4xSS9BbVdueW92QmowMlB1VGxjRmJwdzZzbUdXZzdIeCsy?=
 =?utf-8?B?QTBJeUxNL1hwazR0MHNtRUM3bGpmQmREMDRSdmJ2bE9EZXF6U0NCb1RvOEc3?=
 =?utf-8?B?WGJxZW9Fa21zOTVLUll2TTg0OTZtY3JOM2wvSG9DU1hoYmoyNzIyMGpERVJN?=
 =?utf-8?B?aDRGYUFGZFI3T2dEUVZZVG82V2tON2x2dzFyT1BMZUtmSVZHRDN2QnYwWFJl?=
 =?utf-8?B?d1FFZjdWZFliRXd6SE11TkhkeFdpUUpsQ1Jjd0MzY3BkaUFyb0Yzakx3TEY0?=
 =?utf-8?B?RGxETCttNWtuaGlOWi9jdytmRzdqSUlEb1dqS1ZuL2UwODlPN1FvdmpmRi9v?=
 =?utf-8?B?UkIzdWJYK3NoZTdXR3pwdlBPUUt2MnJ4MGJOTVVQMFNZV2tXK1pEd1QyTzhS?=
 =?utf-8?B?TnkzU1d4RGdZdkRhZGxaZHFCWGkveXZNRkJyYlVKM0g2OUNkOHQzci9vNjJh?=
 =?utf-8?B?cUxDTk9oeUgrMjA2bS9Kci8wRDVlRVNhaDRNUklPcnBDdTF1OHBQbkN6T0pQ?=
 =?utf-8?B?V0V1b3NMQ1NCWDNaVEQ2S2V3VXRpU25qTW4rODNkbFJkSmNDblZjRmRKVUds?=
 =?utf-8?B?VzdtYVpHVHc5NXVWRlg4SzU3Q29aV2xVTkRrSWg5c2I5VFlMeTdyT2VjajE1?=
 =?utf-8?B?Uy9GSDVHMy9nQmY2c3dFR3I1UG1CRWVkN2Zxd1VLNEtlVC94bnJpenZuUzdR?=
 =?utf-8?B?dmt2K0pXU3l0bUZ5eG9xTUJQVGIwb0laTmREbWkzcjFvdk9NMWRqcVN1U2lB?=
 =?utf-8?B?L1l3YTF4UFhWZ2QrZFQrbzZxNXlxc2IwakNEcDZlNUxKUHpsbmtGVjUwSngx?=
 =?utf-8?B?UklmVjJQMmdUd2tIclh5V3Ftdk9lQW01OG9EV2QrTENTWnZGbXpnRExtelZa?=
 =?utf-8?B?MEVsNklGSm44a2F1VXBSYklFdjNsMFBtYkpmZFd5eG1ucUc0SHEyTFAwa3JY?=
 =?utf-8?B?Z1FnKzNqaTVVcXVXUFZMcjNJYS9QVEZOUzkwak5sQ3ZrekVLWjltdHcwbEJ6?=
 =?utf-8?B?SWZjM3EyeG1ZZVZaQ25aa3RDTnFtazczcjJJZzMzTWtPbURYUktncXdBTms3?=
 =?utf-8?B?UkhLRlB1cUxVWlNCYVZyZy9ZZzIwMW8ycWxvUkpJbUlEZ0xXMHd2Q1dBYjBN?=
 =?utf-8?B?ME5FZHA5Z3dNWmJEZ3NtMkdaczlXL3M2MDJRZHQ5KzBKZ3l6WlFpS0pjL2VP?=
 =?utf-8?B?YXdQM2c3azJYK1MyWFB1RURoQmcyTUxLOEJGeDVYSzVYaUkyalZrZko1QU9q?=
 =?utf-8?B?ZTYzbFJ6bE05RjFJMU1zWDU2Rno1MjE4RGNvQzNkRTVtNldYa0ZRTVUybldS?=
 =?utf-8?B?TlQ2QjhlcWtFU3pIQlN5ME8rcGJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1949DB951333FC4795170CCB185E98D4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36505d99-a056-439c-64a1-08dc7e6452f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 15:47:33.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IY8eLLrQ64fJz8iN6ceF5PSj4Cqxbku3Ze77sFF1pZngRy01BI2p0QtgLCMpkYgGQx56bijZnKZhpFW9wQduRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3780

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDE1OjE3ICswMjAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90
ZToNCj4gDQo+IFJldHVybmluZyB0aGUgNjRiaXQgbW91bnQgaWQgbWFrZXMgdGhpcyByYWNlLWZy
ZWUgYmVjYXVzZSB3ZSBub3cgaGF2ZQ0KPiBzdGF0bW91bnQoKToNCj4gDQo+IHU2NCBtbnRfaWQg
PSAwOw0KPiBuYW1lX3RvX2hhbmRsZV9hdChBVF9GRENXRCwgIi9wYXRoL3RvL2ZpbGUiLCAmaGFu
ZGxlLCAmbW50X2lkLCAwKTsNCj4gc3RhdG1vdW50KG1udF9pZCk7DQo+IA0KPiBXaGljaCBnZXRz
IHlvdSB0aGUgZGV2aWNlIG51bWJlciB3aGljaCBvbmUgY2FuIHVzZSB0byBmaWd1cmUgb3V0IHRo
ZQ0KPiB1dWlkIHdpdGhvdXQgZXZlciBoYXZpbmcgdG8gb3BlbiBhIHNpbmdsZSBmaWxlIChXZSBj
b3VsZCBldmVuIGV4cG9zZQ0KPiB0aGUNCj4gVVVJRCBvZiB0aGUgZmlsZXN5c3RlbSB0aHJvdWdo
IHN0YXRtb3VudCgpIGlmIHdlIHdhbnRlZCB0by4pLg0KPiANCg0KSXQgaXMgbm90IHJhY2UgZnJl
ZS4gc3RhdG1vdW50KCkgZGVwZW5kcyBvbiB0aGUgZmlsZXN5c3RlbSBzdGlsbCBiZWluZw0KbW91
bnRlZCBzb21ld2hlcmUgaW4geW91ciBuYW1lc3BhY2UsIHdoaWNoIGlzIG5vdCBndWFyYW50ZWVk
IGFib3ZlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

