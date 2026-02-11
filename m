Return-Path: <linux-fsdevel+bounces-76974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNy/LyzojGnquwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:35:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB2F127712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C452303B7D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62923563FC;
	Wed, 11 Feb 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IEHd9bUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439301632E7;
	Wed, 11 Feb 2026 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842136; cv=fail; b=OXd7ydFfOrcJenUSsj4ctG5YnqDqsgjld4oHgUZSZf7hdYqgnQ/lroJCr+Y9sypaznzT/Bum3gTCapKHTEh8AcTDCN97o741lNztUcSw3BmSyA9g/5fCvldKl+pSxkxS7zOPKLkk3Z2jQvksD9SNDzoh6RD0I6+aM70vAWivZ8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842136; c=relaxed/simple;
	bh=jzH4FhmDEeUbfY6eOSbezGrtrS1Gy4nQ/AprrHoIq4E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UWJJKKQjP7RPTDFCEkKdXEUXhwMZoJOeDHN6th3wgEtF5SFsF+h1uzptGhc0Nmt+9I9uI/YI6rzlPY+zemZkjLxQpO6/ZKV7upA6QAAK0ffJIS//KXKTl5lhOXyTdZq+yH9kz95qUXHaAhovZXwxRHYpuJiY91bmedgje+8IC44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IEHd9bUJ; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoE9tvgsOXYVN9qn10mGI24feLU7Z0r4ufFRq3YV9AKUBXgNbpYUgsENdlJ4aZiTTsiSL9sYem/Cd6QX/MyFojWyTx3Y7rF/JaoAxVMjThQL06WAGqFYSgX1MEZsJTHw1qNWBBKOOBryOh2dp6x6hBgkV4H4b0PckJFQsb1fiIN1X2kXlamd8OQMMNnzbKFM8JBSu5DW5PrYX7FKE4dJ0H+4HC1frEOZv217tXRiw3GNXsEwfZO0D6QuZ8bWkge8QbtA+a9daoR4aWlB1fHDDIBcSKtXVQs47XBoAUrlf03PezphgPy6FpQlYY32Dhl4NYxpqkvYwKzAuKzySEgAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzH4FhmDEeUbfY6eOSbezGrtrS1Gy4nQ/AprrHoIq4E=;
 b=AYVLcO58Dij9OrcKb7XtFTM1NzKVXkrhCd/QnZm3BVExOHimpyCZgsxGO/hnHwsVnh3eWTEb+ClOGyW58b2myt2VBl+3RoR1hnHBXHAN1Y6g/yl/sHBSmHnc/3P/rDxhaZ+1wc0Z46Q59jhuju6LpWelMPxxFaQR8PZ2WxLf/4jNlNJmRBGz4VDML+XghuXjCpXR1UxFU+E3EJbxpA7jvRkBR/RIj92k3HOPaKgAB1lQUM0X4vadOUpcL4U4rSgzrF6sNmOOHV7zKCCRMe0UI+4nzckjldc0upH/bwAwiPUnYASuvJ8Ae2k4TDXF/KyJ6YXd/FfeatitzogkW5CWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzH4FhmDEeUbfY6eOSbezGrtrS1Gy4nQ/AprrHoIq4E=;
 b=IEHd9bUJe9qMfvEc5XH9X+BF9mQjOUK5ZjbSwIH/Ku+RLpapArDkBUshAcGeJ/Rq0c2my2Y1b/4Z8usuumwbR+zTxpTsDFIOtRbuyAp2GGyFdehfBKywB4srSldf6VyekSjzMcnQCCf8MVqezjO7muq3Je07l3Qvh6W+ZFD8F4lbac0NR1zzzhRPGVPA9NXWbiMmjKNB0kcwWTafSZYRSiuv3MSX9kFb/Bks509/ZPJWzAkDAiKHS/JO9moiEC08upIbaCKAEgdR0R7CkG7Uckmt/C+B/L/muHWXm3jHrUgQZkwzNgW9rhyizp0gRvpjyA7MicqeS5A7UhueL/Wf7g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 20:35:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 20:35:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: Bart Van Assche <bvanassche@acm.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, Hannes
 Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu"
	<tytso@mit.edu>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian
 Brauner <brauner@kernel.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
	<javier@javigon.com>, "willy@infradead.org" <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Subject: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, expansion
 plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHcm5X2GyQlbhzV6UGhlrLvCD3GoA==
Date: Wed, 11 Feb 2026 20:35:30 +0000
Message-ID: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB7002:EE_
x-ms-office365-filtering-correlation-id: e7860c31-eef8-4e5e-e17c-08de69ad1956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0ZVczlEbDNwRitNL1NOWk1RQk52K3dLQ2hiMU5JTEM1SGtvN1I4NjVFOUhp?=
 =?utf-8?B?RHVHaE1SSGVvejRWMFA4SGJjMVBYVWRRbnBrS09jL0RtQ29rc2tkeTVpVUZ6?=
 =?utf-8?B?VTJRNW92L3NENTFwNU9UTUdlZVlHcUxjV2l6YVc1VUx5VlhBYjQ4ajBsdUgr?=
 =?utf-8?B?M1pWNm5Qb2hlSnpQcmgvQjJFZ2xKUnhnZHVvM1lDYXlaVmxNd1grWVRVVWZ1?=
 =?utf-8?B?RURjeVkxNWtKem5vQ2d1RDJqRSttamRqNThQZlNRTkJyMXJQZmFOU01rYmJC?=
 =?utf-8?B?YzlCWHMySmQzUkg1KzNWUytlNXZMVnVYTmkzbGo2NVNsQlpzN3VnbU4yeWpZ?=
 =?utf-8?B?UC9pN2Z3dWZmb3g0QnNxSEl4Q3JFKysrbWd4SkhERlFCOXAzb3AxbjBIRkZT?=
 =?utf-8?B?eW4vOERYdU9mT2kzVDYycVR6c1hGYmZvQnAzOTh6OE9SODV5d1oyNTNHNThX?=
 =?utf-8?B?ZmIxRENHek1BMXc2R3FqZ25lWHdUaFVxYjJzMjZFbDRnUkhGeThEbGZ5UUVG?=
 =?utf-8?B?b3hZYnZaVko2QWdaN1lmNmNmU3F4ek5JUVZmSS9KL2xUN0ViZlRCSXJmejhP?=
 =?utf-8?B?S0x1SFdHdUZrSC83UE5SRFNjazN0QmlscjYwaE9lVUY3cjEzZ2xtcjJnb3Jq?=
 =?utf-8?B?ekZ2cDhCRTVzQnJSeDhXSmlPbjYxN1dwYU9kdlk1Wk5YOVRsNHNDWEFNQTA2?=
 =?utf-8?B?T20rRHVPd09zNEltdlVZU1k4WXJhU3ZYN1p4YlgwR0JqWFJxamdpd2FCdllH?=
 =?utf-8?B?b29MM3RpY1VaYXVEbkx0cVV3SEZZcEtwU1lXazh6dGRDSG04ZXBRYWVsbkYz?=
 =?utf-8?B?YU01WDBxRTBFekwvZEMxdlZkSGx6bzAxMlZNZC9wS3BrMWJPSjRlTi9sK1la?=
 =?utf-8?B?M3NxVUowVDVGK29JY3hwS2xtd3p2MkFiczZEdGt0NEQxT3BPRFlndUxYc1Rh?=
 =?utf-8?B?dlE0aFM3dTBBNmxvU0pRcnFiOHpjcm4zcXBQZXl3TXFJQUR0YWJLS2g0bVVM?=
 =?utf-8?B?R1NBVlJGSEJmckMyOWUyRkREbFdoUTc3bDRIWDRNenNiSUVURWM2QzBSRDAv?=
 =?utf-8?B?VTdDQktJYlpQNDhSLy9IRTg2a096Qnp2bmZYRjBkUlRDWGFvREQvZXhOZW5l?=
 =?utf-8?B?b2dGYTJSaVFKL1FHTmp2RUZZU0hCYlh4Wko5S0NJV00wZU04UG1qVWtVRHlu?=
 =?utf-8?B?aUliOGdTUjdwQVA3OXg1S1JzaEg0RHFCVFZBcGM2bjlSM28zdHRPaDNKazcw?=
 =?utf-8?B?REM4UzJrcFFWK01Sak1uVE5jcGpKRWt2d3prdWFHU0hqMUJnNk5hM01jTkc1?=
 =?utf-8?B?WkNpTGlGQW4wNW1nUWJ5OHpZTUhpYkR1UjJ2d1NuSUNFSkhreVozZTZPU1N6?=
 =?utf-8?B?emRMcEFMelhaQW5MdXZ1dVc3VWJ5ZHA1QkxSVTM0Z3lOdG5XUUxZMHE5VVdj?=
 =?utf-8?B?NGxQK2xRSXF4VjN3eFhXcElRb1pYKy9lYlNhZzhDazZPek5LU0xFK2ZvcHh0?=
 =?utf-8?B?Y3VueDNoRk5PREk5U0JZZVRoT2tGcG5sNko2SFhrRUpnaStPM1htTW82VHRo?=
 =?utf-8?B?STU1TG9xMENnazhqZE9rcGM4NDlSSFE3K2doaUVwQk9EVERKaWkyOFBOdkxL?=
 =?utf-8?B?T3habjBwdjdIQmtNc28wQ2dRaTFMNnRJaTFhdXJ1ZnBrODFLbmJYdDljaGFs?=
 =?utf-8?B?N29jY1RMbE9FWEt6ek5tdjlvOFZBWWtEeUY2enJnNjZPbG9jWEk5MGttU3NU?=
 =?utf-8?B?Q2tSQXYveFhKekkrZUphM2w4OWFDMk5iM0N1ZEpQN1UrV3FsUjN3UnVBQ2lm?=
 =?utf-8?B?YXEwY0VnRDdrL25ldllwekV5V2RVMkM4akJweWdlR29hSGI4TlBpZDZkYmtE?=
 =?utf-8?B?SXVDY3lPejFjUHRFUHVtemxjRXNwRTJ5aFBJbGFoaVlwL2JtNzFvVUFzSzVz?=
 =?utf-8?B?bXZ2dDFkbG1TOU1CSFFxdEw2NC9McE5jR0RSY3ZjYVJCZDhGUzNRb0VGNG5W?=
 =?utf-8?B?emdoTGErd1lDcWFKR0ZzNHRGQzI2bkJoZmcvdFVXVHlFZ2I4UTRvaGNEK1Er?=
 =?utf-8?B?aW1RV2tjWVNLYkl3WVlLcDB0TEx3cXEwWExlc3VndkZoUHVNU2xRZDJOODlR?=
 =?utf-8?B?OFBiTVI3T2k2WWd5RVJXL2hYREpvQ3phMnBIa0FHSm8zcWNzTFhVb2hOVWta?=
 =?utf-8?Q?es6XTESm+H7SVreR/k5/P4o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVFqaUdOWGtFNXBWMEpQR0g1VG1adm9YQmoySzBIYU11SXZVdVZTajlDdmJY?=
 =?utf-8?B?RnUyWlZnYjg0Qys1dnYyRVFYbURVaGFqa2RJbEZ6ZFlCa3Q2aHFLYlZoU21E?=
 =?utf-8?B?a3FZRDRUOE9UQ20rR1VJNkhEa0ZMZGZtc1IyaVJkV1VKY0dOcThUZHhDenF0?=
 =?utf-8?B?VzRFWWNoK2lSVkRIS2QydFFOd2pKUHBjSEp6dHVHN2FGY1V0VUY2T21SYzdj?=
 =?utf-8?B?b1VRazAxSWJpSTQrakF0eCtMU2wvaGtnQm15U1JLVnFkdVBVUzA4bXh2V2lq?=
 =?utf-8?B?SXZyV0hpd0Z4MWI4OTQ1QU5uUFZTTld6Q2hQNE82ODVzbkZSdU9hNHNXTzlB?=
 =?utf-8?B?WTNYc20zMi9GMFNSckphUUhMVmR0MVBabnQ2bFowUWZyWlVrUWdCdU0yRnIy?=
 =?utf-8?B?L0E0dHE1TWprZlJEUVJUUHEzSjB4VkFGeko2S2hhQ2NwV1J2eTBPSjVhbjlq?=
 =?utf-8?B?K0RLUFJCNEFyci9waDBod3dFQmhjM3Q4bjhUeXduYUI3aUtzZEFZajl5UFA1?=
 =?utf-8?B?QVVTYUFldFMyOHFJOFZqT1g2aTNWQmRHV3IwSzRmdC9TSnVQSzFiTmVjTnBL?=
 =?utf-8?B?ZTN3ci9jVnNUdTQ1Tmc0aHNsNE9MeDF6UTFIZGN6SmtaaEFkeUtYbE1ldjZz?=
 =?utf-8?B?aHM0QkJPaVgrZ0doalYvM3llTDhPb2pIQWVBbEFlR1U1eXYxdnlOc3RnZ2Uw?=
 =?utf-8?B?bnpmSWdybmNpRnlzYkdyaThUQ0hMRUtMcUt5MXJZcFNtbWFnZjJUQkNFTUx4?=
 =?utf-8?B?MlBQcHNkRUNGeFo4aG9NUzNvaFg1Zm5UQldsOXFNbFk4cmZpRFk4eHVZUmJ5?=
 =?utf-8?B?Z1JSVkxzZTQvN29Wd0Y5VGkvNW5jYUw2Um9SZmdqRlByOTRhbDZlOHRkL3Fl?=
 =?utf-8?B?eldqNVc3RjJtZ1BlN0xCSkRocUR5Z1hwbEUycHlhL2tYeThoRnE0eFd5Qm90?=
 =?utf-8?B?Tm9DWTBJcTlhQk5SS011S3ViTUxJVmY0NVhaOG41VW51UUdBRE1IbFBTanpU?=
 =?utf-8?B?aHdzTE5aYUhmeHptYzZ2WDYzV2dtOVZqYzVsUmRPdXYwY01QWFRGZkNRNit2?=
 =?utf-8?B?WXNRRnphZzBKMENObUUvbHBSTWU3S2hPcFljNXFMdklGRlhEREx0NXlGWGNS?=
 =?utf-8?B?anVvZEdOZEJkalA3SnR6QTl5VU00YkZob0Z5VHdiRGRkS05wMFc5d3kwdlZq?=
 =?utf-8?B?b1A5cnpQSDd1MXloc1oyTGlIZFdJZldHQU14OXpjWGYxVDVyMGZUanNldVpD?=
 =?utf-8?B?eU5zQ1Zrc2lzZVlmNC9kMC9LUzE2ZDkrT0dJaisrZ2hFeDBWbWtwWjIvaXRh?=
 =?utf-8?B?QVJZTTcwTDBBKzBjSVAwbEVIRXRMQW1WcE1RNExqTU42WmtLeWdaZml1dnVQ?=
 =?utf-8?B?ZjZyeXM3OGlTM3hQdmZTbjRnbFdNRUlZMFh3Vm9RNUtiNzA3THR4NUhSazdw?=
 =?utf-8?B?VUlrcEJ3eHFiUTdoMlBpOWNUYlVLcmpnb21YYVpyZmlEd3NFSFROK3RuTkhB?=
 =?utf-8?B?WFZLQmRVUE5YaG5zUGdOaXZrYXpuNExmOFFhUmxhcVZUZlhIZ0JVRW9WbU5m?=
 =?utf-8?B?dlRMbEphMWdiajhFbW5YQnJGQytSbkhRdEJibEpTTng2QlFoUEc2b0ZXYWZh?=
 =?utf-8?B?SU1peXlIOVlSblFuSHZKaURpVXVCSzZ5RjYvTW9vSWlJU2J6VzZoYlZEMVJU?=
 =?utf-8?B?ZktoeWljOW9FRCtTYThOMVpVblBQT1NrZW1yaHo3ckF3RzBWa1lGMGJ2cjhh?=
 =?utf-8?B?bDhkTGZtM2I0SmhkYVkvUVlIbWNDeDBwVCtKaEt1bnA0a3VLblJkaXZFaDNx?=
 =?utf-8?B?NXlPMGRmdGViSC93SXlaQ2gxa1JnUThneW5YcGJGZU04WlRDeGplZlFNU285?=
 =?utf-8?B?bGI4UFF2eENZdjYrYUFHK2NBSWkwckJ6VXA5VlRHQTVkTGN4bE1VQlZuVW0x?=
 =?utf-8?B?aUtHUzhTeDJ5WVlOWkFEd2Nzd3FiUDFpTGxDNTBzdGcvQ3lZK2E5OWpvcnBi?=
 =?utf-8?B?bkZYMDNjY1BNYzBaZGFEeDdEVnJqQ3BzMW5zVGJDVUNhVmJsdVNHbkpZTHUw?=
 =?utf-8?B?aFdkTGVnWWpETnFVTVZrOWtPazczN2dPdzZsa3FKR1YzODB5UTFtemlWU0oz?=
 =?utf-8?B?SWJVM1drRjJkZEUyWkE3YVo1YnkybjV1cThhSmNSckVzSXpHU0tuNzMyWHNL?=
 =?utf-8?B?MWFHZXE3ekZHZzJLcUFCNUJudjFhRmlWVkFqMFRwT2RzaG41VEZ0cGhodmNV?=
 =?utf-8?B?Z0h0ZGt4MmFDL1FxUGk5SkcxRTg3VTlNR3FBaDE4LzZBbWYvbDRDWmlESnJV?=
 =?utf-8?B?MnJvVXFESTBNN2JGdEhWYkNLNElQK2JFSElNd2I2Ry83VUFGd0pkZXNNWFlM?=
 =?utf-8?Q?B8Icg/qbixXaDW3fxPIuqE6ARkYPnEUW1IVWYLwJCj3gv?=
x-ms-exchange-antispam-messagedata-1: qEK4LGWumboMfg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0913777B8503247841A276033396EE4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7860c31-eef8-4e5e-e17c-08de69ad1956
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 20:35:30.8419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHNSaqu22owZzlvx+7ZzGGbOpvwltwf8dwnFoHea/1ftLYvQ86+xPH7HxvVFEpmSrJyH9ZY+QozicN92aTXIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76974-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[acm.org,wdc.com,suse.de,lst.de,kernel.dk,grimberg.me,mit.edu,kernel.org,oracle.com,vger.kernel.org,javigon.com,infradead.org,suse.cz,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanyak@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 5AB2F127712
X-Rspamd-Action: no action

SGkgYWxsLA0KDQogwqAgU2luY2UgdGhlIGRpc2N1c3Npb24gYXQgdGhlIExTRk1NIDIwMTcgWzFd
LCBPbWFyIFNhbmRvdmFsIGludHJvZHVjZWQgDQp0aGUgbmV3DQogwqAgZnJhbWV3b3JrICJibGt0
ZXN0cyIgZGVkaWNhdGVkIGZvciBMaW51eCBLZXJuZWwgQmxvY2sgbGF5ZXIgdGVzdGluZy4NCg0K
IMKgIEJsa3Rlc3RzIHNlcnZlcyBhcyB0aGUgY2VudHJhbGl6ZWQgdGVzdGluZyBmcmFtZXdvcmsu
IEl0IGhhcyBncm93biANCndpdGggdGhlDQogwqAgbGF0ZXN0IGJsb2NrIGxheWVyIGNoYW5nZXMg
YW5kIHN1Y2Nlc3NmdWxseSBpbnRlZ3JhdGVkIHZhcmlvdXMgDQpzdGFuZC1hbG9uZQ0KIMKgIHRl
c3Qgc3VpdGVzIGxpa2UgU1JQLXRlc3RzLCBOVk1GVEVTVFMsIE5WTWUgTXVsdGlwYXRoIHRlc3Rz
LCB6b25lIA0KYmxvY2sgZGV2aWNlDQogwqAgdGVzdHMuIFRoaXMgaW50ZWdyYXRpb24gaGFzIHNp
Z25pZmljYW50bHkgc2ltcGxpZmllZCB0aGUgcHJvY2VzcyBvZiANCmJsb2NrIGxheWVyDQogwqAg
dGVzdGluZyBhbmQgZGV2ZWxvcG1lbnQsIGVsaW1pbmF0aW5nIHRoZSBuZWVkIHRvIGNvbmZpZ3Vy
ZSBhbmQgDQpleGVjdXRlIHRlc3QNCiDCoCBjYXNlcyBmb3IgZWFjaCBrZXJuZWwgcmVsZWFzZS4N
Cg0KIMKgIFRoZSBzdG9yYWdlIHN0YWNrIGNvbW11bml0eSBpcyBhY3RpdmVseSBlbmdhZ2VkLCBj
b250cmlidXRpbmcgYW5kIA0KYWRkaW5nIG5ldw0KIMKgIHRlc3QgY2FzZXMgYWNyb3NzIGRpdmVy
c2UgY2F0ZWdvcmllcyB0byB0aGUgZnJhbWV3b3JrLiBTaW5jZSB0aGUgDQpiZWdpbm5pbmcsIHdl
DQogwqAgYXJlIGNvbnNpc3RlbnRseSBmaW5kaW5nIGJ1Z3MgcHJvYWN0aXZlbHkgd2l0aCB0aGUg
aGVscCBvZiBibGt0ZXN0cyANCnRlc3RjYXNlcy4NCg0KIMKgIEJlbG93IGlzIGEgc3VtbWFyeSBv
ZiB0aGUgZXhpc3RpbmcgdGVzdCBjYXRlZ29yaWVzIGFuZCB0aGVpciB0ZXN0IA0KY2FzZXMgYXMg
b2YNCiDCoCBGZWJydWFyeSAyMDI2Lg0KDQogwqAgYmxvY2vCoCDCoCDCoCDCoCA6wqAgNDENCiDC
oCBibGt0cmFjZcKgIMKgIMKgOsKgIMKgMg0KIMKgIGRtwqAgwqAgwqAgwqAgwqAgwqA6wqAgwqAz
DQogwqAgbG9vcMKgIMKgIMKgIMKgIMKgOsKgIDExDQogwqAgbWTCoCDCoCDCoCDCoCDCoCDCoDrC
oCDCoDQNCiDCoCBtZXRhwqAgwqAgwqAgwqAgwqA6wqAgMjQNCiDCoCBuYmTCoCDCoCDCoCDCoCDC
oCA6wqAgwqA0DQogwqAgbnZtZcKgIMKgIMKgIMKgIMKgOsKgIDU5DQogwqAgcm5iZMKgIMKgIMKg
IMKgIMKgOsKgIMKgMg0KIMKgIHNjc2nCoCDCoCDCoCDCoCDCoDrCoCAxMA0KIMKgIHNycMKgIMKg
IMKgIMKgIMKgIDrCoCAxNQ0KIMKgIHRocm90bMKgIMKgIMKgIMKgOsKgIMKgNw0KIMKgIHVibGvC
oCDCoCDCoCDCoCDCoDrCoCDCoDYNCiDCoCB6YmTCoCDCoCDCoCDCoCDCoCA6wqAgMTQNCiDCoCAt
LS0tLS0tLS0tLS0tLS0tLS0NCg0KIMKgIDE0IENhdGVnb3JpZXPCoCDCoDogMjAyIFRlc3RzDQoN
CiDCoCBGb3IgdGhlIHN0b3JhZ2UgdHJhY2sgYXQgTFNGTU1CUEYyMDI2LCBJIHByb3Bvc2UgYSBz
ZXNzaW9uIGRlZGljYXRlZCB0bw0KIMKgIGJsa3Rlc3RzIHRvIGRpc2N1c3MgZXhwYW5zaW9uIHBs
YW4gYW5kIENJIGludGVncmF0aW9uIHByb2dyZXNzLg0KDQotY2sNCg0KDQoNCg==

