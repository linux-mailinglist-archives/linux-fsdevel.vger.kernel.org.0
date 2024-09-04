Return-Path: <linux-fsdevel+bounces-28563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15F96C0F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183B8284776
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A11DA610;
	Wed,  4 Sep 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="AZEkciF1";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="wkc9xo2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EA29402;
	Wed,  4 Sep 2024 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460828; cv=fail; b=LC1txDGSjHfj66t0Pkm3Yo5i1VIqRpZVB56fx9NlRWE3o0Ru6DYYORMoQiaZahop/5Ju0g1/eE62kFgSll7LWO1vWvuWJPYWMGbJz+QWmy7l5g3o84i90zi9/MiPT4tzKDcj3Gm63lS5KqWWp90lHppqcUv1gz4mz/GSxDYt40Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460828; c=relaxed/simple;
	bh=bpo2sJN1GUavkQZkGz4zxMAtxdW8gCi0hh1r8VAoPA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbu4hf57+jYjem/ij87Calu7G1UZCjmaJoMMDBOxdwBgJYZkJjAAt3FLfbKBY/UZ9UWtFc2IxLk3ikHkBqF+L8/8OenL+pZot4aU6KhKa0m9+8orwMirDYAwxJH30j1rpPaUMoaWKCwQgQNZRmvgbdykTYudXCgZV0MckzYY9f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=AZEkciF1; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=wkc9xo2c; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4845Uu17017263;
	Wed, 4 Sep 2024 07:40:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=bpo2sJN1GUavkQZkGz4zxMAtxdW8gCi0hh1r8VAoP
	A0=; b=AZEkciF1qQNohPLUK4GPWim+dXV+RR9INumuHJzmeIpiItQrt/cThsIcn
	pU3MIpK+UxpCW0rH1dfmkTElHSwBNxzDIxuEOVB2owwF9wDIOX4qlN4J7wWbDFe3
	/yBWOjEQkwrl9Ma67MdEnrxss3R0FjszPx1Mxpa9KB2/C2XjTLZDtCSHW7n7ky8C
	xpenfmwWR0hLuCJD/qajt5jT/3vttNEn88yEa3MR80ba5WSmB8xUJnzX7o3XtFVv
	8YJfyep2ZFYZ/VPalnC3m25mRoYAHlioFm7szlMKO8UlNBwTuYIROUuQrkIc3ebH
	GDFj5bRoSRmy4JNzc8yvi+S0xBewA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010000.outbound.protection.outlook.com [40.93.11.0])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 41by37rmnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 07:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1ZFwyc8wTOhQ2CK6yZp6zYhHvmIyjkq54E9kS4k8KsCXsGQmh5XgjwfPvjMG7bw0O8yT66V5tc8g2usM2MkBjmsm8KEizMEWsi2Q1gSC0fm4MuYN+tqLMCCRewcHr9R59qB/Y7iDqYYsysR7RuDF9jUwj/afsm9GaMJx/VZV8wlMjCSWbrVP56F5I20n3V0Sue1xJPTu6rKY/r1abzuhTAme0tuauVm1eEWA1RhjitlvbEupGKI/FRqESTB3jCRpPhZkBWcGHMjUXoMXcyW60zkHDkmEDlU11D9VxobUF9uiP0tQ1bUtT7dvL9vaEtkzQ09R5ZDs281DWTQUzRCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpo2sJN1GUavkQZkGz4zxMAtxdW8gCi0hh1r8VAoPA0=;
 b=JX17tqub+PAVWK3udrYca9fEGRwshxj7Ia177Ww1VFxeRN8odvLOTRnV4IKlDvRjIKfHRAi0dkpYOFkwV61b67gTxaPOoHvdOVlWwSLc/qYAWzYNlsV7iJmGHxOOxQdj8r7I/z1GbCxeMd4N3bm5GABki9lpaIEi1at9NvqCNptpsbSI5MBqwdcvp0/wN9DRBh1a9sT/f87layZaEnV5K23AAaiPmoS+3glxuiYmbXzZFnZyI/Z9ZAid8dY2CHtsyj9ODRS1E8VSqGwBYh3k8EBA06q2maqoC4bLYQsUzM+QFwYFF3LtEOhjlVyWPlrYssRjuFz5wm283z0i+EOUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpo2sJN1GUavkQZkGz4zxMAtxdW8gCi0hh1r8VAoPA0=;
 b=wkc9xo2c8UX8RshRReuoJDKbheG9NzkJnCrMOU7fbWq/Ns1HAAh4RLT1UOSgzigGDgmpYVaP4WxWZnzLGYQdu65P3iQ8gFSqOnMrusVRPR5RUEaBYP7/wmu8PkItK6HqFefw8vkN2nIHpmyCUKtprsMqQjm17VJOyJuLWa67DhNRHxcbXPBJKn5unb+FF2AHya2duG+SlaeUqI62Hq5oMz6CgppaTsbJbg/N4R1dZzvUj7A2/CLE/MDIljkssGHZVb6nSpLqm29g9YsCUSOrg4YbMjk3Ef3xI9UtN5OQNdj2r870SjAXIPDc7Io9EnYwGbhlUsbS9Zp1Va4fvXkSaQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CO6PR02MB8787.namprd02.prod.outlook.com
 (2603:10b6:303:142::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 4 Sep
 2024 14:40:08 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 14:40:07 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jan Kara <jack@suse.cz>
CC: "paulmck@kernel.org" <paulmck@kernel.org>,
        "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU hung task on 5.10.y on synchronize_srcu(&fsnotify_mark_srcu)
Thread-Topic: SRCU hung task on 5.10.y on
 synchronize_srcu(&fsnotify_mark_srcu)
Thread-Index: AQHa+LvndGr5TQ3eZkqCq3a8Y606krJHZYoAgABZnoA=
Date: Wed, 4 Sep 2024 14:40:07 +0000
Message-ID: <CBB4A7F7-81F0-44E8-96D4-E1035E21BDE1@nutanix.com>
References: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
 <20240904091912.orpkwemgpsgcongo@quack3>
In-Reply-To: <20240904091912.orpkwemgpsgcongo@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CO6PR02MB8787:EE_
x-ms-office365-filtering-correlation-id: 8b125b59-0014-4500-4310-08dcccef78f7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajBoWlhwMjMvdDZTNERnRTFCeWwrY2FlUTFGb2lDeHBOVUEwMmM0Mml1WEtm?=
 =?utf-8?B?ZzBaSG42YVV1UE9xaTRlUk1Bb0luRHVQRzJOLzliNEVnWlFSbFBuR0JCN2FO?=
 =?utf-8?B?eEZpRGVIekoyUXRiTGxIMm5jYUJHNVc1MGFhMVdHcEV1UjJzbHN2dXIrWnVE?=
 =?utf-8?B?djIxR3NiWXhHeWlCZG1Ld045bDR2WVlKbG05dkpaWlVFUXVaejk0ZnRCSnpj?=
 =?utf-8?B?UVM0RDZsMXpHTU9lZ3IzZTNtUE1TaWlSdTZMaE9XMCtrbWJGUGNmUG10b01R?=
 =?utf-8?B?dXJ1WWxPMmwzWWoveHREMDlqZ2pNUDlyRFpKcW5BRW5aL3FDMXYveDIyUGR3?=
 =?utf-8?B?ZHp5ckxVOEkxN0NQYkY4VjcxQy9mOUxic25yeGtSYzI4OCttU1RjSkIveGZz?=
 =?utf-8?B?NTZHU1BvalBUc0FMWHkvbTNIMzhCci9YMGhoVktHWVVnc2JiSzVBYXhMTGI3?=
 =?utf-8?B?OGVoRzVxanlzTGprR21RRTlsZTNGcy9UV3VLUXJvUlZKWlREMTVFMzMvRWVK?=
 =?utf-8?B?TXZsOGpKZmErb1FEZWY3TWpsb2ZIU1ZHME5aSUdjdVR1ejUzdmFYbllPMmVS?=
 =?utf-8?B?WjZQeTB4OWxhV2VwcjU2VUh4YzVERG8vdk80eVBUQVM2WWNBYmhsNGl2Nmps?=
 =?utf-8?B?UHZLRnlFZ0hKbGsreUV2WEJKUVhIM2FhZ3VVdDJVdVo0TXJUc1owUlpxSXBD?=
 =?utf-8?B?cHExS2dDemVxQnA5QVFqVnE2M0g5VDRrTjJNWURremlYd0s4VlE3VStBOVVz?=
 =?utf-8?B?ajlaUXI3dWwzWmNaNks5QmJDWUNiYUhzZUlQbnNBZEdveHdxZHUrUGliTlNE?=
 =?utf-8?B?bXlHelE5U09GRVoybHUyZzR6QmhnUjRXR2xQUDBjWVRmM1V2aHlCR0orUWZv?=
 =?utf-8?B?TUN0Mis2M0k5SlVSMHlSdlJUaU1Tb2dXeTkxMEsyUlY2cXNHM1huNGF3ZFlV?=
 =?utf-8?B?U1NpMlZxYzFPQjZ1cHQvZmpNL3ZWYkVYZ2NjQTgzRHV5TDBlVS9IK3lDeWM2?=
 =?utf-8?B?SGpVZDBQcXh4ZkY2ZWg0ZlhlUGN3M0xNR2pEWVZCRzJtS3VxaFNyTk1rMmtz?=
 =?utf-8?B?L3M2b3pEckRDaHNVTzV6UCs1OFRwbGNsM0tkTDRERk9Gb3hZSCtMZWlwZmJC?=
 =?utf-8?B?ZHZCcExYN210TWlVMDI4bWNVMnpyWHRZbW8xN1RsaG1OUVUzemloVk5KcElS?=
 =?utf-8?B?N0hiQ3dDdzFVN1pNUnIyZElqaW8rSmFUWUZiV2xnRTNFVFQwNkJGcGh2YU9F?=
 =?utf-8?B?c01naUNSOUJqRm0ydnNQYWFuSHFVYk9TVDA2VVlMdjVmT0VOOHRXV3g2NHRV?=
 =?utf-8?B?eTJBVU1adytsQWhZNitZWU9pSVk3UFZ6UHRDTFp5UWFSYTBlTUpncmFFcEI2?=
 =?utf-8?B?cHBKRGw4MExDNkpNdmM5MVZHeEwzYW9IQ1ZxMG5LckpqeE0xcW9GcU12VW9Y?=
 =?utf-8?B?MFNTeXBuMTZiWmhmdkRYR0c1a3MwdDdXdFkrNVVxTDlkS2x3OExNaXlmcUE3?=
 =?utf-8?B?WXdjUGI3MkJtN2JMU28xeXRmOVNqRWJFVG9hSkNES3lzWGsxcGFYeUVzcm1w?=
 =?utf-8?B?ZDk2TkZNSVpOQ20zV3RzZzk3d29KdTc0STEvY1NBOWJVRGhsRkJTTGRHWGRw?=
 =?utf-8?B?V3plNm5uUnpCd05rY0lLb0lwSTZkUXJmZ2wvdm1DNWd5dGJCdFJjVGNJWEdH?=
 =?utf-8?B?allhclFLR2dKNDE2ZHdsVWJWZ1Rna2hiQnB6VmF5ODBrWEhoaHFlamc1UHE3?=
 =?utf-8?B?ZURNOXhTS29qS2Y4UW56SHhkUVhrRFBQS3ptRmlqWGtnMVIzTDUvQnRBazBt?=
 =?utf-8?B?T2FORjFsc1ZPUCsxZU9WVnZ5ZmtzSGhBbjN4dVdjODgzcGxOZ2VhY0ZSNGpX?=
 =?utf-8?B?TC9ENHFvaktUWnNSbEY4cEs3Wkx4eEM4V2dpQXRwYUV2YWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVpER29OZElzbzBpZmFSbkptczVHajJXTUQ0SCtPYjJpYXJ0cFNQN1M0empX?=
 =?utf-8?B?R2VFeW9sQ1Q2RVc0dWdqSThndXAyR01obGNKNlIwUUtUNm92aUcxbVpRckc5?=
 =?utf-8?B?cTk5SThjR1NhRHBzS2wwWHdrR0VvUUFCSE8ra0h5dXZpMXp4bHB3cWtFRHpM?=
 =?utf-8?B?dEgrRGpQSVVGV2dSUzMyYlU4b2NLNkRjUjlHdHp4YXhUcXRIdy9IZzU0aW5D?=
 =?utf-8?B?bEFKaXQyMFRvcFZ6TkNrRjV5R1krQ1pVMXJnenNYdm5reWJTUXlMRmVrc0h2?=
 =?utf-8?B?ZFBnV1pkOEVyM1NCcDZIYm05V1R0YWc2NHlMbnpWSTQzekxpU2F6VW5QVVlP?=
 =?utf-8?B?QXo5bnFONXZ4dHJ5TVgwK0hsUURodHo2Q3BSdHJTUGRQRkRWcDNLTGlwaEpJ?=
 =?utf-8?B?QnBrL25Ja0kvNEoyZmQyWll6L3AwSjhvZFFZZEJqUTBDdVVhclJUeEtCek9P?=
 =?utf-8?B?cTYzb2Y4YlhZd0dwV0RyRFZOVjczWll5T1M4RlJKdGNrdW1wQ3oxYWdJVGRX?=
 =?utf-8?B?RUphT3lhT0NYc2g4TDBZNmdsMVRSd2QxS0QwTFBIN3UzdVkvUU1IbVQ1ZmxJ?=
 =?utf-8?B?NlVNbFNTRGlaOEdCYVpSbjJvL3AyUXBHKzlsazFqdkw3d2lnZzhLTTNGa0Nm?=
 =?utf-8?B?YkZwN3ZWTG93d3I1UUdpNVlWM215eEY2ZlV0VDlVSlpwb3BVNWsybmNyeU1W?=
 =?utf-8?B?cVhFdEFsU1YwYmVrdW5Mc1ZGNURMTFIzS2k3ZW4vY3ZVcjlKblNWbGJPZFpw?=
 =?utf-8?B?UWVyUGVvZjFRRGR4SFV0ekZEcHA0Z21jSlo1ZWdRVThNTmc3dUIvQS9sQlNB?=
 =?utf-8?B?akxtT0lTVFRMMmRWeG9zOWpYa3IxYzN5SE5UQit1VFpVNVBMY0I3MjRIK3Jy?=
 =?utf-8?B?Yk1pbkxTd1A4NjJiamdkU0JXbjdiaVJUQ0o0NlNXRXRXMTFHMTVOcytvTktO?=
 =?utf-8?B?UmhGYXFKOFNqS2hYRnZkNUNnN1R0V00walhrWWxBbWhZRjZ2VDZReDR5K0hn?=
 =?utf-8?B?QzhFVEhlZzVqMW9saGpwenZQeUxxNE53aHNqbHJnRkswSmxLTk1CMjBzQVpm?=
 =?utf-8?B?Mk9FZlhTc2JMM2IySUJZbFMvTDVYL21YNkNwRUk0d2tOTGNtNGY0dEJFTmRH?=
 =?utf-8?B?aXhjMlAvZnIrL1hxSkF6V2Q3eWpMZ3lNZzQvTTV1TEdxZ2FBZzFyTmRFdlYw?=
 =?utf-8?B?TjZwQXk4S3R4bXcwVjBYL1dVU0ZLV20zNkxlQkR2QSsybTBISEpPZ1MxVEJF?=
 =?utf-8?B?RTQyUWluVXkreTdsMUdrR3BqeDZYWXMvYnZJZGRDMjVkVmNKb29mREJ0Nnhl?=
 =?utf-8?B?NDE1a3ZRODJOcGRQMWR0YmJiZGhZQm0valVrSzBWNUpNekU1TUV3cXZadDFw?=
 =?utf-8?B?RTVmWUdXUEdJRHpvZ1dkYnZ6cElFVWc0Ry94ZFdJcDFiaXk5cWxmd0U0VEtE?=
 =?utf-8?B?MlFYRC9POW82b0U1YVMrOVBSYXowYTBVa0drWUxhaUtVVmhSUms5MkJNTVIv?=
 =?utf-8?B?N0EvcWx2Y0ZlcFVmY204YWFqcE5oUlZKVC9GMTFLV3hnc1lUMnJrMHNaSU5w?=
 =?utf-8?B?UE1IWTBWNm5JV2tJdXR6Z1hxTjRib0cydXdLOGhGR3Z1T3ZxcXN4b08rdERC?=
 =?utf-8?B?TnFVZWZWNmJFeWNweEJuZjBEUUlwQlZ1R3ZFaWFkZGxLVDhETUhhMi9tbEZG?=
 =?utf-8?B?dUIyV0VRZFYwUmEzbUozZGxRMlAwZ0xVVllKQ1lGZHFudzNCQXEycjRnaUR0?=
 =?utf-8?B?NnNIbHJsYmxxcE5jMXBPNlg0Qmd6V3hSL3Z5ZlNXdUVuRDlJbnpLZ2tXYkVG?=
 =?utf-8?B?cC91RlRKQVhGQXR3MFJOT0ZIRHBBc0IrbXhKckt5RXZuM25PS2w1V3orZmcx?=
 =?utf-8?B?RU50L1lGNWN6THhYTkRGOEZnRXIraVdrTldPdzkycXBKZkxVb3NsWlo3dTAy?=
 =?utf-8?B?Nk5Sek9iZDNSa1JSMmlXbzZWSGhWT2pPWmt2VkV3WGFCRWY0bnZMRGtVZjFy?=
 =?utf-8?B?azVxRy9tbzJyaG85L0diQnJTcHhaZU5NM2VPMkQ4TUFlRzVtRm92UGNyUWk2?=
 =?utf-8?B?NXVQcnd6YytpcHhBYjQ5NXVCZmRsU0RGNjB5MFNha2lpR1BETzdYWk0ySHA2?=
 =?utf-8?B?aHJnRXFzc2g4OUdrTGdaZlFzdDRNWWFnb1Y4emFjRklPUlI1R3N1SmRWWVJW?=
 =?utf-8?B?TXVPZ1FaNkVzZkptUGlsWTBKUGZPOG9obmxQNkNaUnVCVEhQMml3NENTK0dR?=
 =?utf-8?B?TWVUY2hsNUpvN2xtY2JsTjF0MEVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84E31B5EF8D7AF4E9526722015E87722@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b125b59-0014-4500-4310-08dcccef78f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 14:40:07.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLoEXxjOzIX96J3bmHrPJ/AGBft3iq+eSoxwfRDxxNR53XKp2xapmQZfqLjr1o5ubmpCvhgJ7rgfJAupBVCBimtOFRj1g1sXcaQM/LWMKL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8787
X-Proofpoint-ORIG-GUID: IooMBxVGkowxWkIl_9Gh4lxtUyQQqfBW
X-Authority-Analysis: v=2.4 cv=duCJCEg4 c=1 sm=1 tr=0 ts=66d8714a cx=c_pps a=mDuRAjfF6z7BLBO8FFmDUw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10 a=iox4zFpeAAAA:8
 a=qtyB0RcefZUnvRGnS-UA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: IooMBxVGkowxWkIl_9Gh4lxtUyQQqfBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_12,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gU2VwIDQsIDIwMjQsIGF0IDU6MTnigK9BTSwgSmFuIEthcmEgPGphY2tAc3VzZS5j
ej4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJT046IEV4dGVybmFsIEVtYWls
DQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIFR1ZSAyNy0wOC0yNCAyMDowMToyNywgSm9u
IEtvaGxlciB3cm90ZToNCj4+IEhleSBQYXVsLCBMYWksIEpvc2gsIGFuZCB0aGUgUkNVIGxpc3Qg
YW5kIEphbi9GUyBsaXN0IC0NCj4+IFJlYWNoaW5nIG91dCBhYm91dCBhIHRyaWNreSBodW5nIHRh
c2sgaXNzdWUgdGhhdCBJJ20gcnVubmluZyBpbnRvLiBJJ3ZlDQo+PiBnb3QgYSB2aXJ0dWFsaXpl
ZCBMaW51eCBndWVzdCBvbiB0b3Agb2YgYSBLVk0gYmFzZWQgcGxhdGZvcm0sIHJ1bm5pbmcNCj4+
IGEgNS4xMC55IGJhc2VkIGtlcm5lbC4gVGhlIGlzc3VlIHdlJ3JlIHJ1bm5pbmcgaW50byBpcyBh
IGh1bmcgdGFzayB0aGF0DQo+PiAqb25seSogaGFwcGVucyBvbiBzaHV0ZG93bi9yZWJvb3Qgb2Yg
dGhpcyBwYXJ0aWN1bGFyIFZNIG9uY2UgZXZlcnkgDQo+PiAyMC01MCB0aW1lcy4NCj4+IA0KPj4g
VGhlIHNpZ25hdHVyZSBvZiB0aGUgaHVuZyB0YXNrIGlzIGFsd2F5cyBzaW1pbGFyIHRvIHRoZSBv
dXRwdXQgYmVsb3csDQo+PiB3aGVyZSB3ZSBhcHBlYXIgdG8gaGFuZyBvbiB0aGUgY2FsbCB0byAN
Cj4+ICAgIHN5bmNocm9uaXplX3NyY3UoJmZzbm90aWZ5X21hcmtfc3JjdSkNCj4+IGluIGZzbm90
aWZ5X2Nvbm5lY3Rvcl9kZXN0cm95X3dvcmtmbiAvIGZzbm90aWZ5X21hcmtfZGVzdHJveV93b3Jr
Zm4sDQo+PiB3aGVyZSB0d28ga2VybmVsIHRocmVhZHMgYXJlIGJvdGggY2FsbGluZyBzeW5jaHJv
bml6ZV9zcmN1LCB0aGVuDQo+PiBzY2hlZHVsaW5nIG91dCBpbiB3YWl0X2Zvcl9jb21wbGV0aW9u
LCBhbmQgY29tcGxldGVseSBnb2luZyBvdXQgdG8NCj4+IGx1bmNoIGZvciBvdmVyIDQgbWludXRl
cy4gVGhpcyB0aGVuIHRyaWdnZXJzIHRoZSBodW5nIHRhc2sgdGltZW91dCBhbmQNCj4+IHRoaW5n
cyBibG93IHVwLg0KPiANCj4gV2VsbCwgdGhlIG1vc3Qgb2J2aW91cyByZWFzb24gZm9yIHRoaXMg
d291bGQgYmUgdGhhdCBzb21lIHByb2Nlc3MgaXMNCj4gaGFuZ2luZyBzb21ld2hlcmUgd2l0aCBm
c25vdGlmeV9tYXJrX3NyY3UgaGVsZC4gV2hlbiB0aGlzIGhhcHBlbnMsIGNhbiB5b3UNCj4gdHJp
Z2dlciBzeXNycS13IGluIHRoZSBWTSBhbmQgc2VuZCBoZXJlIGl0cyBvdXRwdXQ/DQoNCkphbiAt
IFRoYW5rcyBmb3IgdGhlIHBpbmcsIHRoYXQgaXMgKmV4YWN0bHkqIHdoYXQgaXMgaGFwcGVuaW5n
IGhlcmUuDQpTb21lIGRldmVsb3BtZW50cyBzaW5jZSBteSBsYXN0IG5vdGUsIHRoZSBwYXRjaCBO
ZWVyYWogcG9pbnRlZCBvdXQNCndhc24ndCB0aGUgaXNzdWUsIGJ1dCByYXRoZXIgYSBjb25mbHVl
bmNlIG9mIHJlYWx0aW1lIHRocmVhZCBjb25maWd1cmF0aW9ucw0KdGhhdCBlbmRlZCB1cCBjb21w
bGV0ZWx5IHN0YXJ2aW5nIHdoYXRldmVyIENQVSB3YXMgcHJvY2Vzc2luZyBwZXItQ1BVDQpjYWxs
YmFja3MuIFNvLCBvbmUgdGhyZWFkIHdvdWxkIGdvIG91dCB0byBsdW5jaCBjb21wbGV0ZWx5LCBh
bmQgaXQgd291bGQNCmp1c3QgbmV2ZXIgeWllbGQuIFRoaXMgcGFydGljdWxhciBzeXN0ZW0gd2Fz
IGNvbmZpZ3VyZWQgd2l0aCBSVF9SVU5USU1FX1NIQVJFDQp1bmZvcnR1bmF0ZWx5LCBzbyB0aGF0
IHJlYWx0aW1lIHRocmVhZCBnb2luZyBvdXQgdG8gbHVuY2ggYXRlIHRoZSBlbnRpcmUgc3lzdGVt
Lg0KDQpXaGF0IHdhcyBvZGQgaXMgdGhhdCB0aGlzIG5ldmVyLCBldmVyIGhhcHBlbmVkIGR1cmlu
ZyBydW50aW1lIG9uIHNvbWUNCm9mIHRoZXNlIHN5c3RlbXMgdGhhdCBoYXZlIGJlZW4gdXAgZm9y
IHllYXJzIGFuZCBnZXR0aW5nIGJlYXQgdXAgaGVhdmlseSwNCmJ1dCByYXRoZXIgb25seSBvbiBz
aHV0ZG93bi4gV2XigJl2ZSBnb3QgbW9yZSB0byBjaGFzZSBkb3duIGludGVybmFsbHkgb24NCnRo
YXQuDQoNCk9uZSB0aGluZyBJIHdhbnRlZCB0byBicmluZyB1cCBoZXJlIHRob3VnaCB3aGlsZSBJ
IGhhdmUgeW91LCBJIGhhdmUNCm5vdGljZWQgdGhyb3VnaCB2YXJpb3VzIGhpdHMgb24gZ29vZ2xl
LCBtYWlsaW5nIGxpc3RzLCBldGMgb3ZlciB0aGUgeWVhcnMgdGhhdA0KdGhpcyBzcGVjaWZpYyB0
eXBlIG9mIGxvY2t1cCB3aXRoIGZzbm90aWZ5X21hcmtfc3JjdSBzZWVtcyB0byBoYXBwZW4gbm93
DQphbmQgdGhlbiBmb3IgdmFyaW91cyBvZGRiYWxsIHJlYXNvbnMsIHdpdGggdmFyaW91cyByb290
IGNhdXNlcy4gDQoNCkl0IG1hZGUgbWUgdGhpbmsgdGhhdCBJIHdvbmRlciBpZiB0aGVyZSBpcyBh
IGJldHRlciBzdHJ1Y3R1cmUgdGhhdCBjb3VsZCBiZQ0KdXNlZCBoZXJlIHRoYXQgbWlnaHQgYmUg
YSBiaXQgbW9yZSBkdXJhYmxlLiBUbyBiZSBjbGVhciwgSeKAmW0gbm90IHNheWluZyB0aGF0DQpT
UkNVICppcyBub3QqIGR1cmFibGUgb3IgYW55dGhpbmcgb2YgdGhlIHNvcnQgKEkgcHJvbWlzZSEp
IGJ1dCByYXRoZXINCndvbmRlcmluZyBpZiB0aGVyZSB3YXMgYW55dGhpbmcgd2UgY291bGQgdGhp
bmsgYWJvdXQgdHdlYWtpbmcgb24gdGhlDQpmc25vdGlmeSBzaWRlIG9mIHRoZSBob3VzZSB0byBi
ZSBtb3JlIGVmZmljaWVudC4NCg0KVGhvdWdodHM/DQoNCj4gDQo+PiBXZSBhcmUgcnVubmluZyBh
dWRpdD0xIGZvciB0aGlzIHN5c3RlbSBhbmQgYXJlIHVzaW5nIGFuIGVsOCBiYXNlZA0KPj4gdXNl
cnNwYWNlLg0KPj4gDQo+PiBJJ3ZlIGZsaXBwZWQgdGhyb3VnaCB0aGUgZnMvbm90aWZ5IGNvZGUg
YmFzZSBmb3IgYm90aCA1LjEwIGFzIHdlbGwgYXMNCj4+IHVwc3RyZWFtIG1haW5saW5lIHRvIHNl
ZSBpZiBzb21ldGhpbmcganVtcGVkIG9mZiB0aGUgcGFnZSwgYW5kIEkNCj4+IGhhdmVuJ3QgeWV0
IHNwb3R0ZWQgYW55IHBhcnRpY3VsYXIgc3VzcGVjdCBjb2RlIGZyb20gdGhlIGNhbGxlciBzaWRl
Lg0KPj4gDQo+PiBUaGlzIGhhbmcgYXBwZWFycyB0byBjb21lIHVwIGF0IHRoZSB2ZXJ5IGVuZCBv
ZiB0aGUgc2h1dGRvd24vcmVib290DQo+PiBwcm9jZXNzLCBzZWVtaW5nbHkgYWZ0ZXIgdGhlIHN5
c3RlbSBzdGFydHMgdG8gdW53aW5kIHRocm91Z2ggaW5pdHJkLg0KPj4gDQo+PiBXaGF0IEknbSB3
b3JraW5nIG9uIG5vdyBpcyBhZGRpbmcgc29tZSBpbnN0cnVtZW50YXRpb24gdG8gdGhlIGRyYWN1
dA0KPj4gc2h1dGRvd24gaW5pdHJkIHNjcmlwdHMgdG8gc2VlIGlmIEkgY2FuIGhvdyBmYXIgd2Ug
Z2V0IGRvd24gdGhhdCBwYXRoDQo+PiBiZWZvcmUgdGhlIHN5c3RlbSBmYWlscyB0byBtYWtlIGZv
cndhcmQgcHJvZ3Jlc3MsIHdoaWNoIG1heSBnaXZlIHNvbWUNCj4+IGhpbnRzLiBUQkQgb24gdGhh
dC4gSSd2ZSBhbHNvIGVuYWJsZWQgbG9ja2RlcCB3aXRoIENPTkZJR19QUk9WRV9SQ1UgYW5kDQo+
PiBhIHBsZXRob3JhIG9mIERFQlVHIG9wdGlvbnMgWzJdLCBhbmQgZGlkbid0IGdldCBhbnl0aGlu
ZyBpbnRlcmVzdGluZy4NCj4+IFRvIGJlIGNsZWFyLCB3ZSBoYXZlbid0IHNlZW4gbG9ja2RlcCBz
cGl0IG91dCBhbnkgY29tcGxhaW50cyBhcyBvZiB5ZXQuDQo+IA0KPiBUaGUgZmFjdCB0aGF0IGxv
Y2tkZXAgZG9lc24ndCByZXBvcnQgYW55dGhpbmcgaXMgaW50ZXJlc3RpbmcgYnV0IHRoZW4NCj4g
bG9ja2RlcCBkb2Vzbid0IHRyYWNrIGV2ZXJ5dGhpbmcuIEluIHBhcnRpY3VsYXIgSSB0aGluayBT
UkNVIGl0c2VsZiBpc24ndA0KPiB0cmFja2VkIGJ5IGxvY2tkZXAuDQo+IA0KPiBIb256YQ0KPiAt
LSANCj4gSmFuIEthcmEgPGphY2tAc3VzZS5jb20+DQo+IFNVU0UgTGFicywgQ1INCg0KDQo=

