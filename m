Return-Path: <linux-fsdevel+bounces-59108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A95B3483F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AA82A2E06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B63019B0;
	Mon, 25 Aug 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nCXrFcyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB816D4EF;
	Mon, 25 Aug 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141803; cv=fail; b=m2muGkXSJ4qhWXCNqlEP76YJzi3P6dmCjYKl7C7ilrZddFgwXCj4v7IGNnqY05k3n2t6+vbD1x2jpFE1drJtMY3pOWWiss7iI/BCnADxux9HO4Gl2W2YvJkoJnQH1MwsOpDNj0K0ieVlySzNLJJig/dObj/sREVF8BuAexSe1lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141803; c=relaxed/simple;
	bh=sxXKhapIaxQDa52oviD1tgih2rWc2qyQ5+eT/5muzvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tr+4wjmUTjsBUdce0oe1DUwy7JeCFjjtvrW8uRZen3nznA1WOalokFs9REn/YuhZyyuwfuMF3tYBmsYoicAvDnz21ilPgN0D+6lFpo23FQHUlBETaYrj8XmKAf4DyF7sFEA0GSHqmiekFR4AhzLlK9l0/t9Tcr3HpK0OR3DAO9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nCXrFcyH; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHD77SMSqB6tnjbX8MCtTKovrhkuhWaSMH3r/JjTYJGRzMOQR+1wAkNgOT9ul97ORvEaCmWucbF16cNZMZ4cFH0NcXV4wvaMg85nTJibQQx/DZ6oG85jUU+/CQnsmwoQO/wxexkArSKiSAw43d18jd/ONk7YE1lkvRJN1HEYPaC1iqYQ5/Hi4C3D8A9a7XlrskEO4UaAWQVj4dEiheiBojPv3ORxZgT853Xx5JF1r9GxrdSrLuE0vriBWc7dl0aCR7cEhDba9y97bDgt0OYUgCLsKD4KfJQersLlyUc0B8nntuWbxHL/oEoMiYljVZo5IS0FpBdjBo2FMYkG69rdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxXKhapIaxQDa52oviD1tgih2rWc2qyQ5+eT/5muzvY=;
 b=ukTgxdj7HUSp07PVWIzyUj7TzvPjPM8d1LVwaOK4/2AE/KbOyMOJVo2bysRJfSfUA7ibTT4mzYNxHkZV0bxVRJ3IoNZ2xgbCOrpk9VM2dr8skBEZYOugGUQmUT9qpgvyV+RTNWL6bR3IhIXfLvimxqg9RSJHI8t+kmefGSv5n4qCsykwJDBE2RJPh8UNkfjTHAQWmOJ9gqfZwxzVXQJlPi5l4VBzcO/yUujlorGAyN2CKC2R8zAEdteNFr/A4lYXPoIVbgUNoFmlEr4uW5a7y/O/KxYlQW6sgDUpO/Mdyie9pC1e/ohbdVT5uawh2DnN1djxhhsBSIANukWb0bqjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxXKhapIaxQDa52oviD1tgih2rWc2qyQ5+eT/5muzvY=;
 b=nCXrFcyHN6XXPTBk1PfFPY4mFm9dgqMM74FVTzN6ariDaSv60WDDM9IB1yOW5dfC9vnieupepGrqOkDx1eL2hlHJETWBX0XTW2SzFPT8rko0lRLAT5SAYnLNn451Ek5xIJ6RInWUDD+UR/g/mo7gVNBQTGfqAQGo+hcBtnLY7SBIjpF7W/5UKDwVIcORO0hDkSDzcbrf+FeekJQax9WEYm7qameuoVkjWyIDgYbmoWm9TGr0Uoq4pzFblq5jvGss0UquE6wkl9YF23tptc05ZWTM+uraEEP5/aD42thzKQR+y4uWBi0rxRILLFP/pJ9/uVIpVj/4iMGyAJ8LPezArw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:09:57 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9052.014; Mon, 25 Aug 2025
 17:09:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
	"djwong@kernel.org" <djwong@kernel.org>, "bmarzins@redhat.com"
	<bmarzins@redhat.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, "chengzhihao1@huawei.com"
	<chengzhihao1@huawei.com>, "yukuai3@huawei.com" <yukuai3@huawei.com>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH util-linux v4] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
Thread-Topic: [PATCH util-linux v4] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
Thread-Index: AQHcEmPY/WKOqtdP+0ShKRLb44JB77RzoWEA
Date: Mon, 25 Aug 2025 17:09:57 +0000
Message-ID: <819d6b7c-fa0f-4b87-9285-00963a04175c@nvidia.com>
References: <20250821061307.1770368-1-yi.zhang@huaweicloud.com>
In-Reply-To: <20250821061307.1770368-1-yi.zhang@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8309:EE_
x-ms-office365-filtering-correlation-id: b39f5c9b-4f53-4060-d27e-08dde3fa37ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEtYKzR1eFdKRmVVTU00YmJuYWdQM0J3VkhOMjBTUTdpQjJidW02OUFwNHBo?=
 =?utf-8?B?K0poRWU5MW5TZXhhejZBb1AxZm9UNm9jMVhXcXRFeno3d2tTOTZodlJXenVH?=
 =?utf-8?B?NmJmUEduVlkyQjVxNmdtak1zYkFvMUp0N1c1UktzM0RkazAvQitWNS96amhB?=
 =?utf-8?B?OHpLZkdUZE9ZYlNVUGRMK2tNR2hWTGZNQnVhWmxsVjlVUmI4bkx4czg4TnBB?=
 =?utf-8?B?bG8vd1p6azZITVd3R2M5WHpWRk54Qi95SlN1MEVhek9Pai8yMGFxRmx1d0FN?=
 =?utf-8?B?cFppV1VQTnBZMWhkbTNaalZzWWtWeE9iblFaaDRueldPS1ZLTWtwVW44WkEz?=
 =?utf-8?B?cDdaSXBUUVBPdm0zWGVUMTh0M1BQZlNleFJZMzVLcXF3OHk4cWNmOElsT1Q2?=
 =?utf-8?B?UWduWTNCN3pOaTNIYWJZMk9uTWN3bHZSSUNVdGEvU05SQk5obVFlYkdkK0V2?=
 =?utf-8?B?OUpXd2xWTFpSazFvcnpPcktmalBOTStNRjVXQ2ZVTHhuaXltRmRVSmttdEF6?=
 =?utf-8?B?SEQ3MHBhVmZ2bTV3Mk8waVROQWpsdzBJUG9GSnNkeTI0OXNQVGFCbjFtZitw?=
 =?utf-8?B?WDRkdktGWTAvalVJQTUrODgvNi9KS0FjOXRqV3pTQ2REeE9yYkxJTTJBemFC?=
 =?utf-8?B?T1l3QnhNZGpSMGJIRHROVmlDWFdLcjZxd1RrbTlPTzdIZEdIM2VEcmFjb0FY?=
 =?utf-8?B?b1U0ajZKODNjSnZBSXc0UmZTZll0SnFVM2NmTjZiU3lqU2E2NlVnNmdYRUZW?=
 =?utf-8?B?SG1sMis1a3BON0V6RDZ3RllZb09RV2hUVDdiMVg2WU5TR2Z0QXY4NEhzVjdF?=
 =?utf-8?B?Z3EvSndWYURQWEJIKzBVSlNtbFRwOXFISEk1cThIN1B0d0tmN0IvQW42STBn?=
 =?utf-8?B?OHdnMDU0UnB6d0plR1JOTGMyTVVWeEVlTlBabDg5RkJ6cEdnck4rQjJEMW5j?=
 =?utf-8?B?aXo5cGN0ODhqRk5VUjBNT3ZQM3h6M2h0dEZXQUNDdHpSQmplVDIvbDdKcmd1?=
 =?utf-8?B?M0J1c1F3K1g5N0dSczAzRnZ6QkZncWdJcWsyY0Frck96NHJxbzdZNXFubzVG?=
 =?utf-8?B?MElObFJlZWRPUlJqZ2tOcjJpT3VyY1R0MnVhQ21YUW0reFIzTTVmWE9JNDZP?=
 =?utf-8?B?czVtY3VSeEVSby9vaVEzcUo3U2duLzNvSDNqWWJ4Q3pDNTczNzNzSzVpekZD?=
 =?utf-8?B?RHgzVWVPQ0pPTUk0RU9LdTg3UjFjNzhLem85ZWgrRXNpaWg0N0tjS2FaRVlD?=
 =?utf-8?B?Tk1qWUZzMjVrSDFSV3hDQmI1QmtLN0V2d0x3a1VQOUlkVXdNdzI4dkZ4ZVdh?=
 =?utf-8?B?a291cXRZNFJCZlVmVkt4NFNFeWNzRE5ka01NWEVwOTUyd2ZQcjRJRnA1Mzl6?=
 =?utf-8?B?SFQvWjRTOWhHaVloNmN0Qk9sMU5EQ2IwZS9oVEg5SUZabEkzcTZMVDk3UGFW?=
 =?utf-8?B?VzJwR3FWTWRhODVCbitjRUgwUHFnZkE1Ykl1VGxFbjRHZ0VLdFNFczJyV1F1?=
 =?utf-8?B?THp1bENXYi9sSk9tRGppeFpUeE1Pdk1MQm1aZjdIV0N6VytyNWhaVmk4aFNC?=
 =?utf-8?B?Wm5tTmZqRmRJVmJkYXVFK2F5c0QvTWtSajFCMjc3K0dtZEdyNHRtb0J1T3cv?=
 =?utf-8?B?UHQ1RnVtbVI4eFBxS0JydmVJaWt1Uzk5L1F2eTliOEpRRmhOV0k5SVJGa2JB?=
 =?utf-8?B?MkVkV0ZDcEF6d3RDejNJaDNFT3JSS0RFMkFuN0RuODAzOEpCK05DNmdxQXpk?=
 =?utf-8?B?QzlwRnJCeUF5QmoxcHFWVFFFL3ZFbkpPZEJKSnpkM0Z2VlJKV0dDY1ZtZWdK?=
 =?utf-8?B?UW43MGRNYmdmdEFHODNUQVVXSGFPZjl5UFVKdDdXSWF2dnBvaGQ1Mnc0NWtm?=
 =?utf-8?B?b0syWXNtWU93MVRHM2J6d0JTSHlrZ0c0bTlMRzBLTGZwc09YOXZPU2ZPVGwz?=
 =?utf-8?B?WUdySXdITW5LNFBna2xLSUxSZUxoSHdYbXlCc3Q5WmsvREVJVDREUnJteTRl?=
 =?utf-8?Q?gDZjx/dKF5V6wVAe0ufe0UeqitDdY8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFVFZUlPWnVnRmNCYi92dFJZK013cDVwN0cvZlNuZFF0YXJJKzd6bFhFOWUw?=
 =?utf-8?B?eUdZZXFKL0l6VW1xZEpPekxKTEQ5aTJKRnRJNHh4RlJGVGFWUUFSUDE2a0E4?=
 =?utf-8?B?YUdQbWhiaitSTXZESG45Y0F2NWNZNDFyV0ZvaG5HdktUeC8zb1VXV1pzdHpn?=
 =?utf-8?B?bjBmdFVTN2lXWm9USmVEdGpwNVlXV0Y0ZDMrK1VEeHB3QWRyRkh5aldlMlJE?=
 =?utf-8?B?dVNsNUNxQXM4VVNNd3BaRkQwbmpDTmpEMFZjbnZLWnlpSm5ZWHNTUmRXSE1o?=
 =?utf-8?B?N3FzVzdKUGcrNlN6MCsvaHlkTG5TT1Q3cTE2c1Q0djJQU0NTajlFdXVQNms1?=
 =?utf-8?B?VkM1KzZnRm1FemNJckpibVZzVStGMmM4TmtOb0x5SmNwVHJhTFhocHBBNFRH?=
 =?utf-8?B?MEdSMy9NbmIxQjhBL09QRnBNT3RXN0FsSzRmWUtDR1pVL291QjBZYU1sNUVu?=
 =?utf-8?B?VThJWW5pOUJLU3hFdDVVVE5uOUhhaEZHOC9tckJTM0lWV0RMRUFXdGpUS0xE?=
 =?utf-8?B?eVU5L0l2QmE3emFzM3pGUUtrTSt1R1R3Kzd4RTdpRHVMTi9BZGFVcEI2QW4x?=
 =?utf-8?B?VnkxRTg4Tjl2dFpreVJoRjVoajN4Rndva0VGYnRrMXQySkxqdDJtNGFZa0FD?=
 =?utf-8?B?aEJtdlp3WWVSUUc2emJsM1U0bW5Ub2lKQnRIVURteW1uSWtObDRXUFdIeEZZ?=
 =?utf-8?B?bzNJMlpENXkzbDNSZmVFbG03SUhZU3lsQ1oydFZlanprY2xTaXdsTWMyVWFM?=
 =?utf-8?B?ZGtkNEFOOXd4SUFtb2VmRWFkWjlvVjNrT05LbXFYQllJbDJ6YTRTQU1vWlFj?=
 =?utf-8?B?R1hjcWkzK1FvdFNJaXRtUUUwazArdDBNSDYyM1JrSkxTZDcweHI3S25GWWVP?=
 =?utf-8?B?MXpUWEFkL3lBMlFYMVRJeVl4M1ZUREVZZFBOVW83SkxQdnJKNjUwL2lwOUFN?=
 =?utf-8?B?dDdOeEx3Z0VveStlYjh3MUN5bEk3cGE5WmlYSjhJd2RwemQwcysyTzN2Ynpv?=
 =?utf-8?B?WHVBUEh3djFpS2JQakFIMThFZjB5SjVaN1NITUhVYWM3djhObVVWUTBCazRX?=
 =?utf-8?B?LzhHOVlFTllWZ292MFVHclFjWTJXYW9sQkE2VmlXME9mM0o3MmN2Ulhsc0kw?=
 =?utf-8?B?NUNpUUJrZkVmZ2l3ZWU4SWRTK1FvTWNhV211c2VzeG5melJhTFcvWmdaaFpX?=
 =?utf-8?B?L29ldEtFMWdrdU5vNVlSRHU5c09UVEY4TlN5UkwzZnVSZnlKbmw5TTRCRXhp?=
 =?utf-8?B?dmZWVVE0d0tZeCsxSjNIUWR6WFhjb0p6T0ZsTkpvSmZRWG5mUElyYWRRQldy?=
 =?utf-8?B?Vmc4S1I0SXh2L0JPVDFyU1JCaFRDWEp4TzZOQVNCSEttaHNWcjFXRlljd1JV?=
 =?utf-8?B?NE9tQmdKejdSd1haT1cwTXpLakRHSWdvNTBXNGp5SG9yZzJ2YmNlaEZJY1RN?=
 =?utf-8?B?WW8rRDZpcUZET29MWVY4WkNwZG1TZlNUelZ4WU5lYzZGM0tQSXRWcUFlOVBQ?=
 =?utf-8?B?bUFuSHVCK2d6aTh6VEtBOEhJVFppQVBNSTdmMW9neWJuMVVqWkp4aEpYN2FU?=
 =?utf-8?B?R1laQUpuT3pnWTdxUDRIRGZXVlhxZUh1cHZwTnZscjdIWnNtOEswSFBqVnJR?=
 =?utf-8?B?Yk05a3Z5TW9rRnoxWHU0L204ejFIdVgvNjlvZmlTNVJRMXdORUsxNEZzZ1Fh?=
 =?utf-8?B?UFVaQUVzanpNQmh2bkFqeExlYVF1MmNtZXFQUzlSZVFlTVk5a3crelY3Ynkw?=
 =?utf-8?B?YTdUMGpYRlg5ZmlOOTF3NDlOaVd0dzBMTUtIK1lxQW9TR1dPcDI3cXNMMWNR?=
 =?utf-8?B?YkFzak01YU8yKzIvdFF1VGFaeHA5ZFpvOVlBUUFBU1JZc2c1RUpONUY3Sm9h?=
 =?utf-8?B?SnhQMU1HL0NEb05hS25LSkpqQ2Vuek9zeGdlcHF4MW00ZWgyYlNnRHZJQmQ1?=
 =?utf-8?B?RnNYblZ0WUlMbTZvYVB3MitWRWQ3eFVVdlpndjBDVWZZdFFJaTVyczVBSEI1?=
 =?utf-8?B?UWVnL2dwcFY2dEo0ZExuNWcza2dUUjVCWHU1eTVIamV3Ri9xY01wV2FONWNN?=
 =?utf-8?B?NGVmb0NyV2NmWFNiZlhoa0l3OGkvSWtwLzhpOFcwaDJIY0RrOU1uS21ZWU4w?=
 =?utf-8?B?MWVrMzhFSm1JczJLam5wUnh5OWFxK0cxOXJPNHNWOUE2aW1udEUrNncrWFVI?=
 =?utf-8?Q?UmMhWpnEgJQExEwgwBj+XWVG1wx82YXTrKnN2BYIh3IL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBAEC0015E5EF44C9C5FFF61DB483B19@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b39f5c9b-4f53-4060-d27e-08dde3fa37ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 17:09:57.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFfMg8FElI5uU6Js6wV0rCz7gEkXl+qW4Wg1ItIsiRoOHKu7YV8H8pkN/okJCpIkF8/5ABQY9olhNW/i6AcpZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

T24gOC8yMC8yNSAyMzoxMywgWmhhbmcgWWkgd3JvdGU6DQo+IEZyb206IFpoYW5nIFlpPHlpLnpo
YW5nQGh1YXdlaS5jb20+DQo+DQo+IFRoZSBMaW51eCBrZXJuZWwgKHNpbmNlIHZlcnNpb24gNi4x
Nykgc3VwcG9ydHMgRkFMTE9DX0ZMX1dSSVRFX1pFUk9FUyBpbg0KPiBmYWxsb2NhdGUoMikuIEFk
ZCBzdXBwb3J0IGZvciBGQUxMT0NfRkxfV1JJVEVfWkVST0VTIHRvIHRoZSBmYWxsb2NhdGUNCj4g
dXRpbGl0eSBieSBpbnRyb2R1Y2luZyBhIG5ldyBvcHRpb24gLXd8LS13cml0ZS16ZXJvZXMuDQo+
DQo+IExpbms6aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9Mjc4YzdkOWI1ZTBjDQo+IFNpZ25lZC1vZmYt
Ynk6IFpoYW5nIFlpPHlpLnpoYW5nQGh1YXdlaS5jb20+DQo+IFJldmlld2VkLWJ5OiAiRGFycmlj
ayBKLiBXb25nIjxkandvbmdAa2VybmVsLm9yZz4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

