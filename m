Return-Path: <linux-fsdevel+bounces-64100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB0BD85F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E10284F60C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173E2E7BB2;
	Tue, 14 Oct 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ssFtHPhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4301E3DED
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433287; cv=fail; b=E0s3MKnpX1SKDlhwrAeArw9h9fhpb8Z0JMLcFHeoPB/T37Nsxs//JL8lpSeSlL1upkhGmbZrJeoz35L8j+nKT+UcMEDXCM0M4PHYBtA8mS84UC4Em8oJ+eCtHJeFVV2rZlt4Sn2T7MSC7FSm4YP75bILkhA5MbSlIRRfVBVZYBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433287; c=relaxed/simple;
	bh=UZcyDpqbtZHSJ5gfi3qlZMcUynBgcq1jV1W1Fqa8fJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j5X8KSFTvo4pd1sel39o0T/cmjhF+34Oachs50ljgLfBeXkWHzq3/E4qPa6x3njQYhXlVtNrjGiAijm/x7HQzET0cZ7nG9x6sGJEumXPg1I9R2jxSxFXDPl5iMHpqjVt2q1YDwvwRJIzRyuRmgFBvkWOCbggSIzIFlfH3BazviE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ssFtHPhy; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022108.outbound.protection.outlook.com [40.107.209.108]) by mx-outbound-ea18-75.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 14 Oct 2025 09:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tizU48xZNF/MB6k3TVmcEoexVqrQICfFm0VV0BinewA/dFEpNIsxDf/VR45FnBZoy9AfEwJH8QlGZ2j4sue0ppfkPydl8WhD7mMf6ZmoYfn7PhvgFB+OIyNdPwzfP51PggQUpc0asNiqzOjlHdz4tXyjz0C2aocVXttN2q7p+9Z5q5gDgfabPExzVQilXoWc/YF9dc+2aPXFuXIppkbV/GVfUt5XgNJSfq5xQoitbSFgv5Q8yiB0oxMDhkpvFP1YmiIjuGltZbl+w69nvKit1g3PAzH3tJdQ/m9CuJ74oY1tyVZ4cXhIUcTvDEAcSFcbajYyaj7QCtnY6bFAQOfB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZcyDpqbtZHSJ5gfi3qlZMcUynBgcq1jV1W1Fqa8fJI=;
 b=fw5dpnDmpR2zGMFRgG5VH34QPK5aD/RY3vIyLoNZTqfkDD894XU0poUgW6bNW/rP0qF98nquKAnNmuPRL9X3cKhQ5JrInUzjbbO0bpcV7SsTUmhqw4gFcRZikE7E8TYzdurPYsCpPoCGA3JrW5/JoU57laSHtbgBXjIaS+0Rcxbn0xTGYaZTWT8x6GlSDXOHQzlL8fAVPX3bIkHorfZ5keVvnSEhvOa5sKOuhRUb3D3WbC66e18u1gd4mekfQ7VBj7hDMsLhfmoG7OPX0ZYh68V68Aa+GmPOjDcJ9+aEpAauDd+kioKLvqVizuhPSynv6EisNMe0vtYQUydz9cvvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZcyDpqbtZHSJ5gfi3qlZMcUynBgcq1jV1W1Fqa8fJI=;
 b=ssFtHPhy/Drn8uUn9qTlbRSK+utZUFRRUaRoCs4carqo9vZZ1fD57zhdSLCyQgMUTUR2R04HF9NN205xs1U2tOGtqbwjd7PoG5AROwyqrxdxLi2pzvtSizDcnG7FaVy/SDmhnmC4Y1Je576UTRwF1vGjvmyFukRjuJ53pAZ6ghU=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DS4PPF1A1E0ADE6.namprd19.prod.outlook.com (2603:10b6:f:fc00::a11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 09:14:38 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:14:38 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Gang He <dchg2000@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis
 Henriques <luis@igalia.com>
Subject: Re: [PATCH v3 0/6] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
Thread-Topic: [PATCH v3 0/6] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
Thread-Index: AQHcPGQ4jSoxNBBS/02tZUuRosEkaLTBVGIAgAAIwwA=
Date: Tue, 14 Oct 2025 09:14:38 +0000
Message-ID: <598fbf05-884f-4901-89b8-41e2e6f00154@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <CAGmFzSdgfjfdAGNrzb224+t5+UPvUWz3t7iCuW7CvSxd199KdA@mail.gmail.com>
In-Reply-To:
 <CAGmFzSdgfjfdAGNrzb224+t5+UPvUWz3t7iCuW7CvSxd199KdA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DS4PPF1A1E0ADE6:EE_
x-ms-office365-filtering-correlation-id: 547ec0d9-4e7b-4587-7bd1-08de0b0219f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|19092799006|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWs3UjljREovUW1oRTM5U3lYMDVXVm1xTUlEWTBHTWRQQVZlUUZUak15M1Jw?=
 =?utf-8?B?MDdGcmZxYjRaek5TQTExRTZSd1RJaG8vRXZDbFFLWFRNQW1oRkdqbEt1UlVL?=
 =?utf-8?B?Q0h5OW1PZjV0WVcvTUNUeDh1Z0dlMk94NXJSTTZhSEdHbEpuRk4vVWY2citu?=
 =?utf-8?B?amhuQWF5bUNsb01OU3BIMHhHN0IvWi9WMllXL2F0d09ISEtTc2pybW5wWW9U?=
 =?utf-8?B?bXZsZ0llanRsU3Evd3E1SlUwaFZvSHVDaXUwMHdyNyswdmVBTjRMVGpuQUpj?=
 =?utf-8?B?TVdMM0lpNFVITWxnWTNwRnFNUlYxMUZnUk11SEdzclJQYjd5S2ljbnFycWVk?=
 =?utf-8?B?dnZneUhMWnFoWHk3WElQbmZxSVdGcS95S21vY3c0ZHRmNldNcnljOFVXSmFm?=
 =?utf-8?B?Y2lKcEZ5QzQ3WTlDYXJLYVRKYlR0V2FPUHdMdmloaXZFODFsRmpheXBxS2Nj?=
 =?utf-8?B?YVV3NTd5c3BsKys4STlRRnNvcTNINWErTzhPVUk3eFlqcHcyWFg5REF3OEYr?=
 =?utf-8?B?ZVVOUGdGYkJhYXdvcXBrT3p1Y0ZJSW8yVTlpaVVWQmJ6M1hOYytQT3lCYUhV?=
 =?utf-8?B?MUsxbXZLVzVkTWZDR2MxSjc0bE1SL0g3MXpqTDE2WXN3aXpmTkliRFd3Yzd2?=
 =?utf-8?B?MWtVbEZ3LzdwdGo3QkNJVjJpdlEvVjBac2h2SWdVaUhYLy9FbVVDbWdiZ2ZX?=
 =?utf-8?B?U1BxMkdYMTJOdUV6SnlnZXkvZFArRXU3dmtURk41d3hDcXR1bkNScU8vanJG?=
 =?utf-8?B?QXdZYk9QOU45N3NwUldEU3kvR0NqdGdGTVcwS2VSRjEyTzBpL0c1d3hjYk83?=
 =?utf-8?B?S3o5ZnpoS1FMbmxtbzBCVnhsb1dNMjF5K2h4VVVZS24zN3RDbFoyTkc1dWRT?=
 =?utf-8?B?UFFRTjlXdmxpYlVGcHdGazl3NDh1bTIrYUpXMlQwSEluWENtR0IxSjNOM2Jk?=
 =?utf-8?B?d09oNGZVVUhvemtpQzdKcW1POG1ZTGovenExZnE5alBadW9OYjVFRW5LWDAr?=
 =?utf-8?B?VnNGQ1hoT0NLd0RrZnpCc0FNdDA1M0czMVZ5a0loNlBKVjZtbVVOeXgwMG9i?=
 =?utf-8?B?M0U2U0pDcjlUcnFTdVg4U1Yvb0h5Y3NvUDdoWHdOMVdUSHVzV3d3eHo2cStX?=
 =?utf-8?B?eFBWWVVkY1Fib25EbTVhemsxdUVSdTFmWlgwbXJzOTBKUURYOXdJZ2h0VjE3?=
 =?utf-8?B?Zkx5cldpSzBIMmZwb1U0cExETXdHaWtreWlFRUhxSmNrL1VUS2l2M3lGRmU3?=
 =?utf-8?B?OW93UlJZWkx0Y3BldGd4a3l5ajlFV01FbytlTFhZTGdHaHRXWnNYUExmZkxV?=
 =?utf-8?B?VGttRDlaSkY3TTRLTEV0cDJLelVDNkN4NFVNaHV3d1NQbVB3V2F3dkkranpS?=
 =?utf-8?B?VlF4cGJnSzhYb0l3MzhSYjFUU0svRUpZVUNLVlduLzRwT2VFbHpCYkxXcXVM?=
 =?utf-8?B?QlFtWkpXbUdHQWVYN2EwOGs2VVlab05POWVIOVp1dU4rWG9lQ050bUdoWnQr?=
 =?utf-8?B?NDNOUUlSWnhGbU53WGp4WU9Va0RIYlVkUVNLcnZYem1nSEE4a093c0ZpRUYx?=
 =?utf-8?B?bUNtMjFFQSt3aktld0h4cDQ5V05BQ0hJMFRtbThGTEUvVWdBc0ZxaC92eTA2?=
 =?utf-8?B?d2cwMGJsTDBTaHlTQ3dpaXNsZy9CQk4rVWRPSDZiV3diQkJZbVNUa2dnd1Bx?=
 =?utf-8?B?UkhFekVDZm8xUWtuWEZnK1ZiejdxRFBqK3R4V0lvVzIrYytoeEQwQy9VTXFQ?=
 =?utf-8?B?ZU5DRG5tVXBtZjlsM0VIWDNpRitQZ21VdHJXa3NZRGxINXNlSk5kbHJVd0xB?=
 =?utf-8?B?Tnptem9VWEZLVXZzQTJnekM4dXRpeG1TUExJY0NHdys3QjBSNlZMRC9VSnNq?=
 =?utf-8?B?dkZBM1NjNEV6NEhyRUlvbzZmaEJGYUs2algzNDREY0hBVzV5OHdqcVdwWnNR?=
 =?utf-8?B?WjRvdzZBWXdJU1duT2JNOEFCOUd6WVNab1lyZ1k4VFpiOXlCLzIwR2J1cklM?=
 =?utf-8?B?cS9sYU5qSW91QmErekRBNVllN2Vqcy8wYU5WemtSRU50b2VKWm1RQmZydnVy?=
 =?utf-8?Q?UdZuNa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(19092799006)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWRaMWNkdEV4MU9yL1ZjR2NoajI2My81dnBHWit4dkMzbjVJUENYS20xRkZF?=
 =?utf-8?B?Mi8zbisyNkg1NjZCb0lObTFDOHBUQVVNUlorYTZJNDY4YTJza0M5NmR3aGt1?=
 =?utf-8?B?akQ3V0xabUlLTzR5TFBxOFhjWlJTc1p6ajZuWlJqUG9iUUpGNGdhaUZ3cjR5?=
 =?utf-8?B?QjZHWmVSWnZRZnBNb3NxYzB1V1g2RDdZNWtySGRmSEhTTEpjLzVVUVRlYi9V?=
 =?utf-8?B?WVI2OVF6WlFxYVRFL2NkWE5oczJQczA0TEFVb1NiZDVpcGhFc2EwZ1ozQU9X?=
 =?utf-8?B?WGpaMjFVNVpvSXB1SXI0dlJOSjN1VG54Q2M0d21wTWRkckRCQTEzeW43YXRN?=
 =?utf-8?B?bXR1OHRmc3BhcHB2TWxqdVAwb2prSmFCVDRjSDhPd3ZOYmJsRCtEcFFOakYz?=
 =?utf-8?B?cm03aGZSQUdudldJdzR1MUJmWGJmSGp1bWh6RGxtYlgydjBmNkNNc3FlK2Rm?=
 =?utf-8?B?bEJ2WjBiZ0d0dHRwc2VQaFNUeXd1QUEreGVPRDBrTHd4WEdqdTBpeHpqcEJI?=
 =?utf-8?B?cHBOQnNwNTF5TFVVVXdFVEZ1aFFCdHFUVVlVckN5a1U0VVQ5SFBZUnpGbmEr?=
 =?utf-8?B?WWVYd2h3Q1B5OHRRN21xUkcrTzdxanQ0emYyaHJGcE9zOVcvc0NxNlprN0xK?=
 =?utf-8?B?dlp0VlJQUEhVZW5OYXdnR0ZXdE0vbjVieTNzb0hSOGVYamR0a09jb1FvRG9S?=
 =?utf-8?B?S0wweWR2REhPdjVQUnNZRUJIWmhCcmUxcmQ2UnUyWXpmT0xYNWJRQVVWcHAr?=
 =?utf-8?B?dXI2dDZZeHFiVHNHMXFMMzlLcHdzclBJdEtsRmh3TFJhN0FyeElKb3I2ek5p?=
 =?utf-8?B?UFVBa3VpM0FZdnRiUUF4YS9PWG8xbE1kdy9qM01lY0UrK1N0YmZNSkdGZnFm?=
 =?utf-8?B?TDZNKzF4MWx4NkdnK045N0JrbHppdDJHbCtKdzlzOWhqajFsQ0tid0xKcy83?=
 =?utf-8?B?dCt0aWxCaXVMVy9oaHJ0eUNJUHFHQmJoSlhnQzhmWnhCeU9ZNkJhOGdwTkp1?=
 =?utf-8?B?K2Vqb2ZZNFA5NW0vMkFDbytRQUxHaUhHME0valFnYTRBUjhESjByZUhKS3Rk?=
 =?utf-8?B?Zy9XSU1TUzNtN0lsdXkzT1RpQ1ZBMHN2eDBSVHRvUWJBd0FVOEdYTkhpYlhC?=
 =?utf-8?B?ckp2elNBWXVOeFU1Rm12OFJtd2pXM2o4UmE1Wk9YekRsSFE0bTZBNDJ6enZ3?=
 =?utf-8?B?RG1YbllHbGl4L0hPTkVWOFFDbDNDYXhCL2NIaC9Uc0toNzVoZFF3MDF1L0JX?=
 =?utf-8?B?R1l1RVdQUUgxbUEyL3E4SHk4WTVkczFDWWdrSGRnVnR2TmZQRDUvMDBoT3hF?=
 =?utf-8?B?T0hacERKcVRJVUd6MTJOMHdhWGgwMHVHWUlWQ0JrZ1pUTEZVZHNPQ1RRSUJy?=
 =?utf-8?B?VlhMTlhUNm1nQm1yeEF4SDcveDVIb3NoVXEyNUViamdranAxTjhqVjNIUnM1?=
 =?utf-8?B?bjF1UWJhbktiN1dKaGNTNVNScWxxUXhqaVJqdURtOWFiODNRN0g3aktESlM4?=
 =?utf-8?B?aEtMZzg2ZkFDeXlWdkQvRmFDV24rRnBGZlFHcm1DdDVSVEcxclBEWlA5WnNi?=
 =?utf-8?B?bnM1UFEvYmpIaHNmNWs3YVlNbml1REJqcUwyYjdSNDJHOEhXZFhMLzJoRktz?=
 =?utf-8?B?WFZIajZWQ0tQUnNXZzhWQWxqemNZOGhNSHpxZVNJeVZBR09aWTlNZklId2VF?=
 =?utf-8?B?UmkvdUhSU24xQW9Tb0xNeDJFWlczSTJteEVCY3FoSklwck51bW95d256TmY4?=
 =?utf-8?B?QytqSXdxS25qTDZJbmNlcEMwZlJYR0tQb0FCald5Ni8wRjFGZ1YwQytsekFn?=
 =?utf-8?B?b2J4eXl4ZWhscFZZWEM0SWZYQ0pqbk1vbld1eUZ6Ynh1YnhQTlI2VUc1cXZh?=
 =?utf-8?B?WFcwUS93akU2ZjNWSHFoaUFJY1N2T283ZkJEbmZSNksxWHRCeVJTVFhMRWdY?=
 =?utf-8?B?bUwvTTljTzhrTndneWtjcmdjZms3WjhCTmlicHFkc3pHRmt4djhRN2VnNXNB?=
 =?utf-8?B?TUIzZkZ1Zm1uNm5hZzE1QlpkTHVuNGhEVk95aE51WVl3dmkvTlZ4TGc2MjBZ?=
 =?utf-8?B?NmVzeU4wN29rK296VkNQY09nMC9CdXM0R2E5Zi91Qnk2bUQrdTVBcVQ1bGR2?=
 =?utf-8?B?cTNxczJIcy9kcjMwNEd2cFJuODhJd2Yxd2U1WGUvOWZ6bmltd2NFNTlOek1P?=
 =?utf-8?Q?6xlT0DLmCJlU8WDPEq8NF20=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46F02CC97C35D546BCB182757D272E97@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9CkIOAI2/pjrOrX986tr2mQyd0nADPw9Xmx7Ys3Rr6RA6a9LiMuzfLh7r4Bv8EMDUo6QvKpwBqj9wNguoLMT62Epc7q4ElpqRZcSBRp7xC5ie2u12PE76tPx+6AaRhSK/90AclNR1YSGYNXfz5u32hjodiFxc6syBvUQMKcDb4DM2TPJC+L0TUWb7e94+fi+h0IT0HqFkdgVVCcuLAj12NYy5cKlfUNxQf3+s91L93/5sklU7E1bIf8nxbVtrInitHtPtfKE5YW71RKFIDpIPhj5+B3r6+F0xM07E9h9N48KWMNDbDeCsH2P6sobpTmNgF9pENzVjiDHLI5MNRtyO2rLVOq4lDfzx9e/VIPuJmm/DT8/f7QuYAmZX+hxaz1t5n7AA+m4qX0EjNi7CFcOyrzW3fnLmJIBKlH7PcX0BGOXSCBhwWvpVQicK0Hac+AUOUkeFCtkNum9AzS2+M/ZXJeLjNTMfKQ0Z+W5oy2DpIuN0WVSLic6ezv4M2TYnizripsnnkUZ8XR6YJOG8EKtyMkFzJhaiOu85ooBXcGl1l7ALSm7RgshgYPU+nMB/INXx34eO0l7uZygvCNJBVEsjVXu12GiqeVYRvGB/U/+z+IoaV8pwU+zIYVhuJUu/gsolDlOzT3dzIfdLZFQ2fAdVg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547ec0d9-4e7b-4587-7bd1-08de0b0219f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 09:14:38.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YW7bARIpwRmIiyR0lzBadOjLp05VMyTKIPgggeTwuMR3Q2Uqcy2FjoNCiTUi6VUg3bIfey6bkRv5vbkHj94yIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1A1E0ADE6
X-BESS-ID: 1760433281-104683-31094-7087-1
X-BESS-VER: 2019.3_20251001.1824
X-BESS-Apparent-Source-IP: 40.107.209.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpamRkBGBlDMwsDCMDHVwtDYJM
	0sLckgLdnULNk00TI5JcUs0dDMOFWpNhYAo9SYJ0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268198 [from 
	cloudscan8-226.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMTQvMjUgMTA6NDMsIEdhbmcgSGUgd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0
IGVtYWlsIGZyb20gZGNoZzIwMDBAZ21haWwuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRh
bnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4g
DQo+IEhpIEJlcm5kLA0KPiANCj4gVGhhbmsgZm9yIHlvdXIgb3B0aW1pemF0aW9uIHBhdGNoZXMu
DQo+IEkgYXBwbGllZCB0aGVzZSBwYXRjaGVzLCBmb3IgYXN5bmNocm9ub3VzIElPKGlvZGVwdGgg
PiAxKSwgaXQgbG9va3MNCj4gdGhlIHBhdGNoZXMgY2FuIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNl
IGFzIGV4cGVjdGVkLg0KPiBCdXQsIGZvciBzeW5jaHJvbm91cyBJTyhpb2RlcHRoID0xKSwgaXQg
bG9va3MgdGhlcmUgaXMgIGEgcmVncmVzc2lvbg0KPiBwcm9ibGVtIGhlcmUocGVyZm9ybWFuY2Ug
ZHJvcCkuDQo+IERpZCB5b3UgY2hlY2sgdGhlIGFib3ZlIHJlZ3Jlc3Npb24gaXNzdWU/DQoNCkhp
IEdhbmcsDQoNCnBsZWFzZSBzZWUgcGF0Y2ggNi82LCBpdCBoYXMgbnVtYmVycyB3aXRoIGlvZGVw
dGg9MSAtIEkgZG9uJ3Qgc2VlIGENCnJlZ3Jlc3Npb24uIEFsc28sIEkgZG9uJ3QgdGhpbmsgJy0t
aW9lbmdpbmU9aW9fdXJpbmcgLS1pb2RlcHRoPTQnDQpyZXN1bHRzIGluIHN5bmNocm9ub3VzIElP
LCBidXQgZm9yIHN5bmNocm9ub3VzIElPcyB5b3UgbmVlZA0KJy0taW9lbmdpbmU9cHN5bmMnLg0K
DQpGb3IgdHJ1bHkgc3luY2hyb25vdXMgSU9zIHlvdSBuZWVkDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNTEwMTMtd2FrZS1zYW1lLWNwdS12MS0xLTQ1ZDgwNTlhZGRlN0BkZG4uY29t
Lw0KDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB0aGUgZXhhY3QgZmlvIGNvbW1hbmQgeW91
IGFyZSB1c2luZywgc28gdGhhdCBJDQpjYW4gZ2l2ZSBpdCBhIHF1aWNrIHRlc3Q/DQoNClRoYW5r
cywNCkJlcm5kDQo=

