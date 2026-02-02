Return-Path: <linux-fsdevel+bounces-76090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPMfL68OgWnmDwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 21:53:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60440D151D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 21:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABD43300ACA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F930F7E3;
	Mon,  2 Feb 2026 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EFA4S78E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729262F28FC;
	Mon,  2 Feb 2026 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065581; cv=fail; b=A9ml6gChtJy2yDOvQxV5zLVwB/586rRwIQxa7N8O6khWNCYqvBSjElPVOziB+R5hn2bxdfw5Ji9ZRPM3HfuNfzfJwNsb4ay8Ub3Ae7AuOlzn1c1FGbpylSGnxYp4fOaUPxtLS+0SYIcA1ZzAI6eFb6ElPnnXPbzNSNWUJGi0nhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065581; c=relaxed/simple;
	bh=e7IqVNox3destSW2KZnG9mO02TuB1gS1PcdRSOBx5uU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=gragFDjNEo1UBMhfT90tY4PeMT6kJww7r94vnS2utnNSMVcObkxY2TsczNhRUIzBp39/WDICZvpLnMYvCDelqomMGsx5HS6yPDijTA0cHANOgoFUBYzcmxQHvaIx5Yc408W6Mnive4EOgnSZfTqHAw4yi8j4ig/4Nm5XAod3P70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EFA4S78E; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612FbQVw022223;
	Mon, 2 Feb 2026 20:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=e7IqVNox3destSW2KZnG9mO02TuB1gS1PcdRSOBx5uU=; b=EFA4S78E
	ipOI8akmZ+8k0u4Ee2TUzXfpK272bCfzxJpvHQxVeUBPIlotZsl0+nEd8Vxh/7gd
	IX6MoSczJFOowi2mkIBLPDAS20OXWqd88ptxW5sYxg1opp1IZM4HZiP4mrQJKVp/
	wzyq/nChP8zA2UgSjMJtrxHsQ/9YUEATbvBPyl6jpc1UCmTTy+ErVM54+SsBIKoy
	rAEuqLD9nnjuqG2Y4Inr4VQ763t7mFxrUJajqm127IG3Nbm6Tcp3cUImaN3jwGyS
	O6LzlTvcBZVWGUCql3pOwwCKsbAP4yw9dz8hnofO1nUQXzA/T3G7Ra3CmeVEKvfN
	wdiT5Ujml/veYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt29tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 20:52:52 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 612KqpMZ015197;
	Mon, 2 Feb 2026 20:52:51 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt29t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 20:52:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBnOBnKajcaHmK2Fk7wJstVLMjoUln5mIDv9wmo/wHkoM6x/hhRWUS3Uf8k0eOS7/6vRXRe+SM2saoKDkDiEl2k4os0zBHtdz+Jw55D2a+szhFO8NOUW8BPbQM34gMWurKB3XNIZEHBATX85V7iwe1p9yRM53K74CF96mjCby7BEM8CjqeJBvDjqGg9F7ZS0gKcVn0YacjODqSPbMfTlR+0KLalLham23/Z+tbD8p3j/gRDEB3Fk2PHv/lkMvURVH03H9lj26DGYWQC5Ct4KXsNrHDH5oRgdQKM6avfk20tp4HGOQJDfPZzff5mgwsWM+QGgsN+4NETWqRUXVF2B8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7IqVNox3destSW2KZnG9mO02TuB1gS1PcdRSOBx5uU=;
 b=UPaYWMC956zycdjgS4vGnRfJOZr7oep8qEn7CvOrhLyRAN1QGXsTH1yrIMzdtTClT3cHWsJddWhODojnLsHnFl6ZiL+d9o1SRzZDpWkkFHNrJu00VTtVJusRPqmzK3M3C9/zNWiP7uYO2VJyTDwRhZzQLz6Gz4zsT8t8TjX1SjSlT7/zq8K2LtterWIzGBP0MPgPOXAdjpN0KcQLUjcsVNQNZ17oopthzYb8Xwz/pzkWQO5dM+UhnpS5mzMgko4OvR3SZI0p9nR+cN8rdn1hVP6HfWkj64Cg2MC6kSOHUhSbPN8Ywe9SEkYncuvPxqWS0GXFuAf3jRHo8QErGasiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPFB28BD8732.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 20:52:49 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 20:52:49 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v3] hfsplus: validate btree bitmap during
 mount and handle corruption gracefully
Thread-Index: AQHckrqZoBmNNbYuSEuVQh4Mpp0qXbVv5lEA
Date: Mon, 2 Feb 2026 20:52:49 +0000
Message-ID: <85f6521bf179942b12363acbe641efa5c360865f.camel@ibm.com>
References: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPFB28BD8732:EE_
x-ms-office365-filtering-correlation-id: 9b035f09-6745-47db-2812-08de629d06a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTZoaE5BRVBYOUlleU5qYmx6Z09QcERoSDd0b2dSRytWMGx1UEoyVVdMTDN0?=
 =?utf-8?B?bmZLN0haUUwxR2NZdFRSejIySjJ6R2hzbisySWVKcmhLVVJSTGNYREV4dkVK?=
 =?utf-8?B?R0ZlbFlNVVYwOGNSTm04UVU2MkxySjFweXNlN3pzQjE5SUl6ZzY1OENTZ2pO?=
 =?utf-8?B?ZXJtYkFDL013cy9nVUNob0tFcWkxSTdLWm1uVHFkVXFjRlJ5TG9RRzdCRUZP?=
 =?utf-8?B?ZXAycGtmZHJ0RkdhZmNLWCtJSlZpckFUaE81NG5LM1lSYWw5TmM1UTRrOWNh?=
 =?utf-8?B?d2hUTzdCNUdDbW9MeG1CdW9YMjhYdWlhd1g3aHliY1NwUy9ya2Q3dCtBeUVu?=
 =?utf-8?B?UlVDZ0hFUXZSQTN1MDlKd3FYa1RJWXVBSkxjRGdtdnBMOGhsWFBhbWJHbFNY?=
 =?utf-8?B?ZVpUYTY4ZDhqdHJkSmNLYXNHUjgwQ0N6YWdhNmM1QXlqVVMxdWJsQkEyZ1M4?=
 =?utf-8?B?R1dqYUpIWHJmMTBvMzJ3OFlySkU2ZVY3eXVES0V6WVdlZTZTZ0ljVWdNZWlh?=
 =?utf-8?B?dk9qbjJ0dzBYNGp1aWZxaXdVT1Zlb3hBdDMxSGo0YjhBczlCdWV1Rmt4L1Y3?=
 =?utf-8?B?a2VRWGdxNzUrd3VjUzh1WUpyQ2NvZEV3Q094bzB3RDc0NU5qdEFQZWFQYUJr?=
 =?utf-8?B?eEVFMkp4WENxaDFzMEVmRExvdjIyTjNnZVpvWjR2VU1IZDNRZEh2aHg4dm5l?=
 =?utf-8?B?ZmRkN0lqVmJ0RUk0K3oxTSs2QytNM0FLZEdFKzBHU3d1Y2tqMXlySng3dzJG?=
 =?utf-8?B?cFpmWHZDUWNyU1dzTHV4c0JpRlVrZVJtWFVWMVdiUGhyTW0yU2NsdGZ2by9K?=
 =?utf-8?B?M01FSXhQN3gzTjNtOGtqMk9VVGdGTDJNZ2pESmJhSTdEcE9vMDJ3cjRjK3hB?=
 =?utf-8?B?SHFmRURlVHYxMnhhSGhMRjQ3Ym1jNjJQQWpEUWtVditGWUptMEQ0MG4raDlQ?=
 =?utf-8?B?MHkvcHlSVEZRYlpISjlvU3dlbGJ6VW83RXRTMytVZEFEL0w5VGsxVGc5RXpU?=
 =?utf-8?B?VGF4WENkYW1iTk9aNTZmMWEyN0I1MzkyQ2MrbUxOSThuOURpQmswbnBHUXBP?=
 =?utf-8?B?VFJKT2NCazhIb3AyMkNoM2xZb3ZtRmdCb25Rb01kTEZJM05PUHZPZ2h6RnFF?=
 =?utf-8?B?SG80QUdqb0w5TGUwTElTVEZZZVVLSWVuM1E5TEZxTE9WbmR0MWRSbFF1WGpx?=
 =?utf-8?B?eVJ4Ti90ZVlsUlhXdzlkd0d1Q0h3V2VmRDA5NGpPUnZYYjk2UlcvbFFiTjBi?=
 =?utf-8?B?ZUZndDJBaThMWjV6YXdLdmlSV1pOeEdOb05NRTdmQjB0RUdRSEhxM0hSQ1VV?=
 =?utf-8?B?c1RWU1NEMGtsRU5YendZa0RxeVdiQW5qWDhJUjE2elN5eDBrRnZhbEhTVW5i?=
 =?utf-8?B?cDY1T0tMSDczYjNyMitUMWZJMHZ3cXI3cWZmak9ua3h4ZEdjMTk4OWZwWkxa?=
 =?utf-8?B?TWdtcjdKSEFLRTV6M0ZIS3o4cFBrS25ZQ0dubVFtb0JCMHNKcE94UFA4UUZK?=
 =?utf-8?B?cXdTRmtMMVNHTXpRdFVnOEF3Q3laM2F5bk93d2pGU1ZlSk9pUCs0VStnL0Ro?=
 =?utf-8?B?eFk1OG5IWlE3MFJsOVdzK2lDczVwdWIrdDVlbW5RZDJiMmtvT3A1bkJXRDBx?=
 =?utf-8?B?YTZBZkh3UUZmTmhqbWdpUTBEVktFaUJwK09jdytyVEdYdFRTdGF3Z0Rnd1pa?=
 =?utf-8?B?cTRCRWloc3hVcGoybGRmN3IxSmQ0dGZ2Z2QvTEhhSFVvNDNaVFFKeUhDbzMw?=
 =?utf-8?B?NzF3TWNpS2N5V1NVTFZ0U25NK3FkaEN2Q0V3UFpFWG81WXR3d3hTSWJNN1VT?=
 =?utf-8?B?TGk4K3NrbE5WYmd3cmR3M0xGanVsUlNlRjZkbjZRVHQxbjMwMU9rY1BnRmM1?=
 =?utf-8?B?T0ZKV2RLWmh2MElOc1dtVi81Rk1LUkFCbU5LZzdWZ1Q0T3hzdTdHMFpGNEZv?=
 =?utf-8?B?UVZmbTUxeTl3SitDSlVvc2VkVlVXbFNDYTJ6S0d4YzBjTnJVY2hBQm1XOEUx?=
 =?utf-8?B?QmxYUUdCUlAvSGZiUDVsV1F0VlJ1clhxMjBZSmdRWExtelo3YkFWNVFqeEJH?=
 =?utf-8?B?NjFOek5HUmd5TlpybTE3QWZtQU01eUg1ZW84aFY4K280QnkzazF2eFNBSXkx?=
 =?utf-8?Q?T5ChSr9wMBeSIpgS3iPmdGddv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk1ZNDZaL0Z4MUZtTXRJaHMwWmhPWjVyR1N4SnhuZ0lLK0hJZ2RmUnhxc1d3?=
 =?utf-8?B?Q0cvdEFJNUprMm4yRkJRRE9ORWh0a1llbmd1a2psck9OUDR6VVNtbk0wcjNl?=
 =?utf-8?B?V2ZOdUZjblRwODhrcWRaWkNjMTJDTVdYRndtbFBqT1pkNFhrT21ncmJVQ3R5?=
 =?utf-8?B?Qk5IclcwdUx2cUdON0RLMFRiVDlTeGFqZXZSUTBmVjZvSWZONlhGMnB1dnZM?=
 =?utf-8?B?ZHllT0V6RHFaQWtKV0ZuWFVaZUNCUVl5MDdScVlvZjFFck9XVzJ3ZlcydHN1?=
 =?utf-8?B?SEh6d0ZkbVpXa2Jpa2dwZURHRCs3YTJFMGYvSHNVQXVsY1hYeUpVYnJUTEdm?=
 =?utf-8?B?bk9PK01OUkdrQ0pYNDVhejRrWTZPU2hpUVRKZmJaSm42Q01DdC9LREhVaG9s?=
 =?utf-8?B?WWMydkppUXNSSHFrbStRRE5kYjNZVDl6REFDUUVWUnZyeUxFaCtYMGF4c0dJ?=
 =?utf-8?B?a1ZYcXNlZ0hyL1BvY2o2SWl3SDFobHU4WTFIZjhUTm5ka1RxT0swVlFtMC9K?=
 =?utf-8?B?TzlrVVgrczB5NFMzTW5wRHVQaHhCeVdaNTRaOU5Ka3k1NCtUNjVHNk1zSFVl?=
 =?utf-8?B?SzF6QVhseGl5SW8yRXVBdUtOZFpadWRGSFd6NCsxSDhBYnM5UEcwQUltanVE?=
 =?utf-8?B?endONFBPTTZMNzREVjNCSWVjTnppbEVJTzBranZKWFo1Zzd1VmpGU3BjOW1i?=
 =?utf-8?B?M0NESWFhK3Z5QlJhUmhjWVRHTlN0eXdMZjRZcnRpWEkrQjlxL2RBZGl6UjBL?=
 =?utf-8?B?Ly9LMjdXS3hmMnE3Tk1EQnU5K3NSQ0lxUEZsdFI2cXA2VDRXaWN4TXFHWHo5?=
 =?utf-8?B?MTJTMVlYRGZiV3p3MVJOaHV1REZUa0dJdi9McmMzaXczQWRBLzE2QVR6VkNY?=
 =?utf-8?B?UGRJU0tGR2MyWVNxNlh1cTR5WFRibmlKZWpiZDFxdnUwa3RqWmhOYkNjSkVL?=
 =?utf-8?B?OGJyNXh0ZmNsdzl3VFlsVjN4NHI2aTcwQ0JoQ2NEbEZmVEJzYzRDUHlJcVhr?=
 =?utf-8?B?TWJGNnB5R1hvbittZFV2NVoydG5tUk9LbkNjSENXL1V2T0dyMThzYnl4S1J1?=
 =?utf-8?B?UFliZjlWYVYrSWRRV0xQRkoyZEFSTXRBSmJvaGpjQXVtcjBtMjMxQXp5THkv?=
 =?utf-8?B?OEdiTHdKUVAzVHBZSkR3L3M0eEVtUDVEU0FLM1Z4ZkUrejZPVTdSSU5vLzlR?=
 =?utf-8?B?TkNsdm5GelFtMlRkaXpNVkVYL3hmSFFoQ2hRUFFiUXJpcnQ1eCtYQksxMHIw?=
 =?utf-8?B?RHZGc25YbHlnbXNKTTQ1R0lTSkgrNTU2NmQ4WnhIWU5ZOHJ2ZVc2bWlpSkpL?=
 =?utf-8?B?clN2b3Y0UnA1TTgrWHpjalh6MVc2TkFyMFRNMFNvY3hyd0pIQ202WHozN3N2?=
 =?utf-8?B?MUI4eWcvM1M3TGM1RFBocmN3bUVWYUFGUEM2Q05WSkhWWWRmRFQ3WjY3YVZq?=
 =?utf-8?B?cHhMQ01Jenc2MmhVdTQ3V1R0RlowL1FaTWhVbVJOaTJhZTVjSURwNm5JVyt0?=
 =?utf-8?B?RjQxeDFmS01BamhPNlU2bTNoS0R4UjNQbmo2NGF5NlViL1Jkc3prWEpIRzRY?=
 =?utf-8?B?SENjc3ZwdU9zMzJNakxNdW82dDl3dEtKQ1RoODQ5elhpR0tZenFDd3RvaUIz?=
 =?utf-8?B?UlJQRGJCb01rMUZBZ2VMZ2FFUHdGZHNJWURmVG9PbUl1a2NFZnBzei8zSXpN?=
 =?utf-8?B?ZlJKYUw2aVZKK0lsbEtGd1NiWEhpeVh2TXFJZm82VkhUYWE4bG5KdGlEOXFn?=
 =?utf-8?B?ZTlvZUlhZDFBUTlXZ0JlZzJlalIwYlExaCt6WFN0TVZ1RjFmY2FBMXJRTmdN?=
 =?utf-8?B?T1hBQi9ibnh2QzVYRVE0aE4wOTRiSDh4SWtrZjVJaFdLa0U4TlhZMllrT3VH?=
 =?utf-8?B?SXlkbFRWRDNRM1JLUytLYWVDcm9rWXNSL21DaXZDSmhQVER4QVJha2d6SDIy?=
 =?utf-8?B?V25oZ0MxLytUaFUxczgyVGdLZTBzUVpKaHpTdDY0UFprbGhGTTB2a3JmSklr?=
 =?utf-8?B?Tm9aaDFmUG8vUzVmcEhoQVRkRWRtWlEvNGJXSVFWM3dIOWQ0a3N4RjlhRWpm?=
 =?utf-8?B?T1hwa29ESVNXZm02YTZLV1BlZzBlTlJuU0JMUmJ1WWNZYllpdEhVVnZ1QlVE?=
 =?utf-8?B?UDRwS2lUUitxbWxZdFFTTUxocHJmWGVGbmVXcEFpY0Z6SnBWZW9hWkNyMmRU?=
 =?utf-8?B?S3JOVzdxTFNFMDhuMFN6TzN4bExzTGlLeExIYk4zdGFRM0t0d3k0V2RjWmZm?=
 =?utf-8?B?TW5xVGFzTzZJQ1pxNlNvT2M1Mk0va1ZYWHFJWXdGL0pUbUlmOGxNYUxOaXZB?=
 =?utf-8?B?U3dzQlNmMmJES1hnRU1wQVg5aDNiZEY1RndkemJtSUpVM0pUVGtkRzNhajQv?=
 =?utf-8?Q?K+8Xv5gapX3eFALOjAjBrpApEhQuNozuzCzWS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3BA4FF191784040B4DFDB480F1C1FA9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b035f09-6745-47db-2812-08de629d06a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 20:52:49.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/Yk4vUJRQaTjD0GBb78jEhldhbpwzee1tzaZgJA+FJmPkvkyJ8+OBPqNIWaIlyDqujbx17As1jXIaJZ/ejJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB28BD8732
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE2NCBTYWx0ZWRfX72WpzfwIBxbr
 7G7xOnqgtsXGCcpMUm/r2vEGgJJixWdREvJFMnh7hK2lG59X/9bRhMRUfutOMHuqrhBX9eG+zL/
 LXUey+dWjL3p9eh9PvvDZuackeQiUuUQNOr49eg71Qc1aBzkeqwYnCSzMNfnzSD/pNva8TyTop/
 S61HgBmpDRhpokoJM/3EDOCBrM5SZHuWDiZndaea7btf1V+bvHdvhp5piSrR0T53l3HI4LM2U5l
 2HgnwSv5WhHpxXfjn53d6M2hgmn8S5aY5yZ3+Sl8T/YxnP6FfTe5kmV3aF/ZiXPjKP3/kTPYoL3
 tE51LTGVy2XF4wls2mSZwzh4Ml83MocABkw1kyHL4ysRZShfdblx6hDr7yxA8O2+Xum3F6GAFQe
 fL/P+n0z4vYZq+MxzWOUzR8w88r690kJK8ekTmktkOPBL3XMEZsA9f+icEq+vhxQ1inzQivSKUP
 LTBXrM6KjuC2Ar1hlyA==
X-Proofpoint-GUID: mvAGeaZXJoXTZhNFriD7VTN8KXcfwvRd
X-Proofpoint-ORIG-GUID: A5EezkxfKcFx5e3mwgpAbRXRXumhSQ6N
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=69810ea4 cx=c_pps
 a=N6jWaT6qAb3kxWP2Z7atcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8
 a=szKgq9aCAAAA:8 a=fgpMDBh7O7HsqkrBXZoA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
 a=R_ZFHMB_yizOUweVQPrY:22
Subject: Re:  [PATCH v3] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602020164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-76090-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,gmail.com,dubeyko.com,vivo.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,proofpoint.com:url,mpiricsoftware.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 60440D151D
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAxLTMxIGF0IDE5OjM0ICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gQWRkIGJpdG1hcCB2YWxpZGF0aW9uIGR1cmluZyBIRlMrIGJ0cmVlIG9wZW4gdG8gZGV0ZWN0
IGNvcnJ1cHRpb24gd2hlcmUNCj4gbm9kZSAwIChoZWFkZXIgbm9kZSkgaXMgbm90IG1hcmtlZCBh
bGxvY2F0ZWQuDQo+IA0KPiBTeXprYWxsZXIgcmVwb3J0ZWQgaXNzdWVzIHdpdGggY29ycnVwdGVk
IEhGUysgaW1hZ2VzIHdoZXJlIHRoZSBidHJlZQ0KPiBhbGxvY2F0aW9uIGJpdG1hcCBpbmRpY2F0
ZXMgdGhhdCB0aGUgaGVhZGVyIG5vZGUgaXMgZnJlZS4gTm9kZSAwIG11c3QNCj4gYWx3YXlzIGJl
IGFsbG9jYXRlZCBhcyBpdCBjb250YWlucyB0aGUgYnRyZWUgaGVhZGVyIHJlY29yZCBhbmQgdGhl
DQo+IGFsbG9jYXRpb24gYml0bWFwIGl0c2VsZi4gVmlvbGF0aW5nIHRoaXMgaW52YXJpYW50IGNh
biBsZWFkIHRvIGtlcm5lbA0KPiBwYW5pY3Mgb3IgdW5kZWZpbmVkIGJlaGF2aW9yIHdoZW4gdGhl
IGZpbGVzeXN0ZW0gYXR0ZW1wdHMgdG8gYWxsb2NhdGUNCj4gYmxvY2tzIG9yIG1hbmlwdWxhdGUg
dGhlIGJ0cmVlLg0KPiANCj4gVGhlIHZhbGlkYXRpb24gY2hlY2tzIHRoZSBub2RlIGFsbG9jYXRp
b24gYml0bWFwIGluIHRoZSBidHJlZSBoZWFkZXINCj4gbm9kZSAocmVjb3JkICMyKSBhbmQgdmVy
aWZpZXMgdGhhdCBiaXQgNyAoTVNCKSBvZiB0aGUgZmlyc3QgYnl0ZSBpcw0KPiBzZXQuDQo+IA0K
PiBJbXBsZW1lbnRhdGlvbiBkZXRhaWxzOg0KPiAtIFBlcmZvcm0gdmFsaWRhdGlvbiBpbnNpZGUg
aGZzX2J0cmVlX29wZW4oKSB0byBhbGxvdyBpZGVudGlmeWluZyB0aGUNCj4gICBzcGVjaWZpYyB0
cmVlIChFeHRlbnRzLCBDYXRhbG9nLCBvciBBdHRyaWJ1dGVzKSBpbnZvbHZlZC4NCj4gLSBVc2Ug
aGZzX2Jub2RlX2ZpbmQoKSBhbmQgaGZzX2JyZWNfbGVub2ZmKCkgdG8gc2FmZWx5IGFjY2VzcyB0
aGUNCj4gICBiaXRtYXAgcmVjb3JkIHVzaW5nIGV4aXN0aW5nIGluZnJhc3RydWN0dXJlLCBlbnN1
cmluZyBjb3JyZWN0IGhhbmRsaW5nDQo+ICAgb2YgbXVsdGktcGFnZSBub2RlcyBhbmQgZW5kaWFu
bmVzcy4NCj4gLSBJZiBjb3JydXB0aW9uIGlzIGRldGVjdGVkLCBwcmludCBhIHdhcm5pbmcgaWRl
bnRpZnlpbmcgdGhlIHNwZWNpZmljDQo+ICAgYnRyZWUgYW5kIGZvcmNlIHRoZSBmaWxlc3lzdGVt
IHRvIG1vdW50IHJlYWQtb25seSAoU0JfUkRPTkxZKS4NCj4gDQo+IFRoaXMgcHJldmVudHMga2Vy
bmVsIHBhbmljcyBmcm9tIGNvcnJ1cHRlZCBzeXprYWxsZXItZ2VuZXJhdGVkIGltYWdlcw0KPiB3
aGlsZSBlbmFibGluZyBkYXRhIHJlY292ZXJ5IGJ5IGFsbG93aW5nIHRoZSBtb3VudCB0byBwcm9j
ZWVkIGluDQo+IHJlYWQtb25seSBtb2RlIHJhdGhlciB0aGFuIGZhaWxpbmcgY29tcGxldGVseS4N
Cj4gDQo+IFJlcG9ydGVkLWJ5OiBzeXpib3QrMWM4ZmY3MmQwY2Q4YTUwZGZlYWFAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbQ0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5j
b20vdjIvdXJsP3U9aHR0cHMtM0FfX3N5emthbGxlci5hcHBzcG90LmNvbV9idWctM0ZleHRpZC0z
RDFjOGZmNzJkMGNkOGE1MGRmZWFhJmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZy
PXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1aaUpPWTI3MmFq
WW4wVWdFaFFxMFUzQzlLb0w4YlhWSXotaEVkcVZGRnlxNC1CVWRGLVk5THlHN1NZNktYUHh5JnM9
LWt5NGltcXcydzhTZWIycjhjOEpfMFdQbDhJaXhVSl9sNWdkX1FhNWphWSZlPSANCj4gTGluazog
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3Jl
Lmtlcm5lbC5vcmdfYWxsX2I3OGMxZTM4MGExNzE4NmI3M2JjODY0MWIxMzllY2E1NmE4ZGU5NjQu
Y2FtZWwtNDBpYm0uY29tXyZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJ
bTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09WmlKT1kyNzJhalluMFVn
RWhRcTBVM0M5S29MOGJYVkl6LWhFZHFWRkZ5cTQtQlVkRi1ZOUx5RzdTWTZLWFB4eSZzPWk3V242
ZW5mX0lmVjBISmJUMWdFUXpSQU5RZVMybVlzN1B4WkNmZUZEcG8mZT0gDQo+IFNpZ25lZC1vZmYt
Ynk6IFNoYXJkdWwgQmFua2FyIDxzaGFyZHVsLmJAbXBpcmljc29mdHdhcmUuY29tPg0KPiAtLS0N
Cj4gdjM6DQo+ICAgLSBNb3ZlZCB2YWxpZGF0aW9uIGxvZ2ljIGlubGluZSBpbnRvIGhmc19idHJl
ZV9vcGVuKCkgdG8gYWxsb3cNCj4gICAgIHJlcG9ydGluZyB0aGUgc3BlY2lmaWMgY29ycnVwdGVk
IHRyZWUgSUQuDQo+ICAgLSBSZXBsYWNlZCBjdXN0b20gb2Zmc2V0IGNhbGN1bGF0aW9ucyB3aXRo
IGV4aXN0aW5nIGhmc19ibm9kZV9maW5kKCkNCj4gICAgIGFuZCBoZnNfYnJlY19sZW5vZmYoKSBp
bmZyYXN0cnVjdHVyZSB0byBoYW5kbGUgbm9kZSBzaXplcyBhbmQNCj4gICAgIHBhZ2UgYm91bmRh
cmllcyBjb3JyZWN0bHkuDQo+ICAgLSBSZW1vdmVkIHRlbXBvcmFyeSAnYnRyZWVfYml0bWFwX2Nv
cnJ1cHRlZCcgc3VwZXJibG9jayBmbGFnOyBzZXR1cA0KPiAgICAgU0JfUkRPTkxZIGRpcmVjdGx5
IHVwb24gZGV0ZWN0aW9uLg0KPiAgIC0gTW92ZWQgbG9nZ2luZyB0byBoZnNfYnRyZWVfb3Blbigp
IHRvIGluY2x1ZGUgdGhlIHNwZWNpZmljIHRyZWUgSUQgaW4NCj4gICAgIHRoZSB3YXJuaW5nIG1l
c3NhZ2UNCj4gICAtIFVzZWQgZXhwbGljaXQgYml0d2lzZSBjaGVjayAoJikgaW5zdGVhZCBvZiB0
ZXN0X2JpdCgpIHRvIGVuc3VyZQ0KPiAgICAgcG9ydGFiaWxpdHkuIHRlc3RfYml0KCkgYml0LW51
bWJlcmluZyBpcyBhcmNoaXRlY3R1cmUtZGVwZW5kZW50DQo+ICAgICAoZS5nLiwgYml0IDAgdnMg
Yml0IDcgY2FuIHN3YXAgbWVhbmluZ3Mgb24gQkUgdnMgTEUpLCB3aGVyZWFzDQo+ICAgICBtYXNr
aW5nIDB4ODAgY29uc2lzdGVudGx5IHRhcmdldHMgdGhlIE1TQiByZXF1aXJlZCBieSB0aGUgSEZT
Kw0KPiAgICAgb24tZGlzayBmb3JtYXQuDQo+IHYyOg0KPiAgIC0gRml4IGNvbXBpbGVyIHdhcm5p
bmcgYWJvdXQgY29tcGFyaW5nIHUxNiBiaXRtYXBfb2ZmIHdpdGggUEFHRV9TSVpFIHdoaWNoDQo+
IGNhbiBleGNlZWQgdTE2IG1heGltdW0gb24gc29tZSBhcmNoaXRlY3R1cmVzDQo+ICAgLSBDYXN0
IGJpdG1hcF9vZmYgdG8gdW5zaWduZWQgaW50IGZvciB0aGUgUEFHRV9TSVpFIGNvbXBhcmlzb24g
dG8gYXZvaWQNCj4gdGF1dG9sb2dpY2FsIGNvbnN0YW50LW91dC1vZi1yYW5nZSBjb21wYXJpc29u
IHdhcm5pbmcuDQo+ICAgLSBMaW5rOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19vZS0yRGtidWlsZC0yRGFsbF8yMDI2
MDEyNTEwMTEua0pVaEJGM1AtMkRsa3AtNDBpbnRlbC5jb21fJmQ9RHdJREFnJmM9QlNEaWNxQlFC
RGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1Nz
MDAmbT1aaUpPWTI3MmFqWW4wVWdFaFFxMFUzQzlLb0w4YlhWSXotaEVkcVZGRnlxNC1CVWRGLVk5
THlHN1NZNktYUHh5JnM9eHloUG9JWXFkSHRZV3hTRDZ4d05FU2ZkSWJPQ0tjdS14akUxMEtDTXNB
ayZlPSANCj4gDQo+ICBmcy9oZnNwbHVzL2J0cmVlLmMgICAgICAgICB8IDI3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9oZnNfY29tbW9uLmggfCAgMiArKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZnMvaGZzcGx1cy9idHJlZS5jIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+IGluZGV4IDIyOWYyNWRj
N2M0OS4uYWU4MTYwOGJhM2NmIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2J0cmVlLmMNCj4g
KysrIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+IEBAIC0xMzUsOSArMTM1LDEyIEBAIHN0cnVjdCBo
ZnNfYnRyZWUgKmhmc19idHJlZV9vcGVuKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHUzMiBpZCkN
Cj4gIAlzdHJ1Y3QgaGZzX2J0cmVlICp0cmVlOw0KPiAgCXN0cnVjdCBoZnNfYnRyZWVfaGVhZGVy
X3JlYyAqaGVhZDsNCj4gIAlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZzsNCj4gKwlzdHJ1
Y3QgaGZzX2Jub2RlICpub2RlOw0KPiArCXUxNiBsZW4sIGJpdG1hcF9vZmY7DQo+ICAJc3RydWN0
IGlub2RlICppbm9kZTsNCj4gIAlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gIAl1bnNpZ25lZCBpbnQg
c2l6ZTsNCj4gKwl1OCBiaXRtYXBfYnl0ZTsNCj4gIA0KPiAgCXRyZWUgPSBremFsbG9jKHNpemVv
ZigqdHJlZSksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghdHJlZSkNCj4gQEAgLTI0Miw2ICsyNDUs
MzAgQEAgc3RydWN0IGhmc19idHJlZSAqaGZzX2J0cmVlX29wZW4oc3RydWN0IHN1cGVyX2Jsb2Nr
ICpzYiwgdTMyIGlkKQ0KPiAgDQo+ICAJa3VubWFwX2xvY2FsKGhlYWQpOw0KPiAgCXB1dF9wYWdl
KHBhZ2UpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBWYWxpZGF0ZSBiaXRtYXA6IG5vZGUgMCAoaGVh
ZGVyIG5vZGUpIG11c3QgYmUgbWFya2VkIGFsbG9jYXRlZC4NCj4gKwkgKi8NCj4gKw0KPiArCW5v
ZGUgPSBoZnNfYm5vZGVfZmluZCh0cmVlLCAwKTsNCg0KSWYgeW91IGludHJvZHVjZSBuYW1lZCBj
b25zdGFudCBmb3IgaGVyZGVyIG5vZGUsIHRoZW4geW91IGRvbid0IG5lZWQgYWRkIHRoaXMNCmNv
bW1lbnQuIEFuZCBJIGRvbid0IGxpa2UgaGFyZGNvZGVkIHZhbHVlLCBhbnl3YXkuIDopDQoNCj4g
KwlpZiAoSVNfRVJSKG5vZGUpKQ0KPiArCQlnb3RvIGZyZWVfaW5vZGU7DQo+ICsNCj4gKwlsZW4g
PSBoZnNfYnJlY19sZW5vZmYobm9kZSwNCj4gKwkJCUhGU1BMVVNfQlRSRUVfSERSX01BUF9SRUMs
ICZiaXRtYXBfb2ZmKTsNCj4gKw0KPiArCWlmIChsZW4gIT0gMCAmJiBiaXRtYXBfb2ZmID49IHNp
emVvZihzdHJ1Y3QgaGZzX2Jub2RlX2Rlc2MpKSB7DQoNCklmIHdlIHJlYWQgaW5jb3JyZWN0IGxl
biBhbmQvb3IgYml0bWFwX29mZiwgdGhlbiBpdCBzb3VuZHMgbGlrZSBjb3JydXB0aW9uIHRvby4N
CldlIG5lZWQgdG8gcHJvY2VzcyB0aGlzIGlzc3VlIHNvbWVob3cgYnV0IHlvdSBpZ25vcmUgdGhp
cywgY3VycmVudGx5LiA7KQ0KDQo+ICsJCWhmc19ibm9kZV9yZWFkKG5vZGUsICZiaXRtYXBfYnl0
ZSwgYml0bWFwX29mZiwgMSk7DQoNCkkgYXNzdW1lIHRoYXQgMSBpcyB0aGUgc2l6ZSBvZiBieXRl
LCB0aGVuIHNpemVvZih1OCkgb3Igc2l6ZW9mKGJpdG1hcF9ieXRlKQ0KY291bGQgbG9vayBtdWNo
IGJldHRlciB0aGFuIGhhcmRjb2RlZCB2YWx1ZS4NCg0KPiArCQlpZiAoIShiaXRtYXBfYnl0ZSAm
IEhGU1BMVVNfQlRSRUVfTk9ERTBfQklUKSkgew0KDQpXaHkgZG9uJ3QgdXNlIHRoZSB0ZXN0X2Jp
dCgpIFsxXSBoZXJlPyBJIGJlbGlldmUgdGhhdCBjb2RlIHdpbGwgYmUgbW9yZSBzaW1wbGUNCmlu
IHN1Y2ggY2FzZS4NCg0KPiArCQkJcHJfd2FybigiKCVzKTogQnRyZWUgMHgleCBiaXRtYXAgY29y
cnVwdGlvbiBkZXRlY3RlZCwgZm9yY2luZyByZWFkLW9ubHkuXG4iLA0KDQpJIHByZWZlciB0byBt
ZW50aW9uIHdoYXQgZG8gd2UgbWVhbiBieSAweCV4LiBDdXJyZW50bHksIGl0IGxvb2tzIGNvbXBs
aWNhdGVkIHRvDQpmb2xsb3cuDQoNCj4gKwkJCQkJc2ItPnNfaWQsIGlkKTsNCj4gKwkJCXByX3dh
cm4oIlJ1biBmc2NrLmhmc3BsdXMgdG8gcmVwYWlyLlxuIik7DQo+ICsJCQlzYi0+c19mbGFncyB8
PSBTQl9SRE9OTFk7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gKwloZnNfYm5vZGVfcHV0KG5vZGUp
Ow0KPiArDQo+ICAJcmV0dXJuIHRyZWU7DQo+ICANCj4gICBmYWlsX3BhZ2U6DQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2hmc19jb21tb24uaCBiL2luY2x1ZGUvbGludXgvaGZzX2NvbW1v
bi5oDQo+IGluZGV4IGRhZGI1ZTBhYThhMy4uOGQyMWQ0NzZjYjU3IDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2hmc19jb21tb24uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2hmc19jb21t
b24uaA0KPiBAQCAtNTEwLDcgKzUxMCw5IEBAIHN0cnVjdCBoZnNfYnRyZWVfaGVhZGVyX3JlYyB7
DQo+ICAjZGVmaW5lIEhGU1BMVVNfTk9ERV9NWFNaCQkJMzI3NjgNCj4gICNkZWZpbmUgSEZTUExV
U19BVFRSX1RSRUVfTk9ERV9TSVpFCQk4MTkyDQo+ICAjZGVmaW5lIEhGU1BMVVNfQlRSRUVfSERS
X05PREVfUkVDU19DT1VOVAkzDQo+ICsjZGVmaW5lIEhGU1BMVVNfQlRSRUVfSERSX01BUF9SRUMJ
CTIJLyogTWFwIChiaXRtYXApIHJlY29yZCBpbiBoZWFkZXIgbm9kZSAqLw0KDQpNYXliZSwgSEZT
UExVU19CVFJFRV9IRFJfTUFQX1JFQ19JTkRFWD8NCg0KPiAgI2RlZmluZSBIRlNQTFVTX0JUUkVF
X0hEUl9VU0VSX0JZVEVTCQkxMjgNCj4gKyNkZWZpbmUgSEZTUExVU19CVFJFRV9OT0RFMF9CSVQJ
CTB4ODANCg0KTWF5YmUsICgxIDw8IHNvbWV0aGluZykgaW5zdGVhZCBvZiAweDgwPyBJIGFtIE9L
IHdpdGggY29uc3RhbnQgdG9vLg0KDQo+ICANCj4gIC8qIGJ0cmVlIGtleSB0eXBlICovDQo+ICAj
ZGVmaW5lIEhGU1BMVVNfS0VZX0NBU0VGT0xESU5HCQkweENGCS8qIGNhc2UtaW5zZW5zaXRpdmUg
Ki8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ni4xOS1yYzUvc291cmNlL2luY2x1ZGUvbGludXgvYml0b3BzLmgjTDYwDQoNCg==

