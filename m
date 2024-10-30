Return-Path: <linux-fsdevel+bounces-33241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8D9B5D2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 08:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5730B28436D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7381DFD8E;
	Wed, 30 Oct 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fKkw2k+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B433E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274451; cv=fail; b=QE49j1Hv28bAnJbq7vc0zsrolnfd++Z7h9kMPM8zGwtghQzvK04yBG/4sRc9Jsr6gMUkrYECKZfuHvfjjrpZr87KKAZ1kEDpFc7D46pjOfuun8+0efetc/98I6qpuGKiuCMXLRmcFU1WE0FrxDJpVXhFItfF74fGqffVzFA4zs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274451; c=relaxed/simple;
	bh=iNKhIhXEWDnCBbbzVO0gz3AwNH5uIqTmB0NfOx8oQH4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uAqAU2a+xU4ivWETHJpEUnJikHxkaK5DsoUY5xYAax9R0zKs9q4nXnwHS003Rk7FWVHH03zVwF/asAgQFvXFiakSAUuugVS7+XAzFhXoAS/yGE81TUJwSGF2DTSd3E+xfMMgnXgxfNMwxCnRet2nu+foVdHqDXoNJpQShzKr2Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=fKkw2k+y; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6P3QF018401;
	Wed, 30 Oct 2024 07:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=iNKhIhXEWDnCBbbzVO0gz3AwNH5uI
	qTmB0NfOx8oQH4=; b=fKkw2k+y2qas9MZdn7q47LmbhS0u2om/5b3rP+jRHpxQZ
	V0q22H/DdLvKMNCGm7zGZsCBKUvhvOHZtkl1ECU7Zj3qsshrNiFGAJL/BR89Q+ZT
	ZetJbY6E9Ajv0GDV+9vlS1GD4vIcqe3Fg2GxejYMd/0FnuM8j0urZXPVpUyhKVQU
	MbtDFytruqgp7c/OgY42xXlOx28Dpd4tKaz+fhHGIkcnkuOltcnS3BYU+4P7TPs3
	qXotz1yVOaiTXBAL0hF9BZ3iiaXfH/9eNFrXRV6BIDD1dWc1urCSpGbWQubRz9Db
	eEZ847N93hG0PGszsceC1bE8Bmv1LogRZQ7iSXMtg==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2yprm69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:47:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3mxkD+xhiq3Sa3WVyHeOVJWPgxeqzCbHpYtD0gzqbRRhXH8fRponjZkYjyiGHpbYCfDWXur4uLnrcNE5og6mwdjDtNKXd91YICC9JdgjLsKSSz9aeQeW49l4NAwVAGVI37I3X0H0cxVxQsqH9/iPh0xNpiAZUOzpXfYZ39U0mW+CykgQB0MGpbb0eJ3csMHFD1CSrIQV7opE8Sv4IuNfqP7UQQmcFL/SOFYqM7YNqejYIn4qjLHcJRj31FDiQ2RZVsE2J4ZboQKkNWsC2sEOw637GkLpugPkymZKWhwB4k7x8EmEiKtQJNwjwHZUKdpiRj+5UWOelGoO/rWFWk5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNKhIhXEWDnCBbbzVO0gz3AwNH5uIqTmB0NfOx8oQH4=;
 b=m0xF5ZUpOuZzVZL4VRf2R4TuF1mGKkuM50buAeFVI+R81gtheo2V6Jw+mVd+UnGeCsydjCXy9Dt5T0lOdSeuknXuVbj8T8U4B7NFdc/hG66KntQ84OSq73OI3lr+zWqtU+AMstAVqWmtd/WGIPw25e5evU+ecHGYyI+3455Zo5Xe/p7u8eOvwOmr6WSqNPy2/QYbxldl2d5+5Qok0RH55UQgviEToYwwrmNVTXGaHbLHqTuJQ7UzOPFHXzqvnob/MBiA0qkJJ1K+ROPXjK8f7ra1TagwTynsSkzk+cEdP7fhE4OMI7zu3FBhR4W0Q8w6oB22Flt+MnqFK36TqfEOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7707.apcprd04.prod.outlook.com (2603:1096:820:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 07:47:08 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 07:47:08 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1 1/2] exfat: fix out-of-bounds access of directory entries
Thread-Topic: [PATCH v1 1/2] exfat: fix out-of-bounds access of directory
 entries
Thread-Index: Adso6MYudKFLPgEhSt2gIu9iyL//KQBtkhbw
Date: Wed, 30 Oct 2024 07:47:08 +0000
Message-ID:
 <PUZPR04MB6316E1678BA9BBE25BD9826B81542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7707:EE_
x-ms-office365-filtering-correlation-id: f9a52bce-40cd-4420-d723-08dcf8b70e76
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d056Zk15KzBQQStTTUg3RVBzbVlhVi9tWXo0VzRua3RlRW1rLzFZSXlGdVg0?=
 =?utf-8?B?cjZkY0RXVXY0eGV2YWYvYldGUitQL2NONzg0WmtRUkxtbU1LMTZJYXkvdEhX?=
 =?utf-8?B?T2pGZTVNMGN4S005ZWxoNnFSVkpxSEZwWWtiWnR1WEczeGQ3cDNSU2NJY1Rr?=
 =?utf-8?B?NTNNUUdvNTdTeEhYRlZ2azNqMk1wcHZDcDNsaEdwS2Z6czRNWE9VSG51Sjg5?=
 =?utf-8?B?dU1yVDNmMTFPc3U5TmRkdDdCT3NkVHlpcDgzZ3FKZE1LaSsrditxeFVOOWRw?=
 =?utf-8?B?V2lrTmlaOVdSSDVtY0p3RmYzckF3c1hpVXQ2MGRWWXJ6Wkp5SUNibGpSdnNN?=
 =?utf-8?B?Mjg5UTV6clc2WWtlRVJ5VGVMTHRDWXR6V1dadDkzalUyd3owRFMvT3Q3djZi?=
 =?utf-8?B?OFJOU0RVbEdUSUtDeTJEeGZMRzIwUGx4S1Vhc05jTy9oYVBKVmJlUWYzRlVq?=
 =?utf-8?B?UWs0ZmdiTkFFQmpYaTd2U1pDRFBuRUhjc2lPRlp2R1h0T05rTzBKUExVSE5D?=
 =?utf-8?B?VjQ2YWR0OFYvSTlTTVVlMDJGUTBEZjRlWFNBVnNpOGlnWGMrRitRV0ZVai8y?=
 =?utf-8?B?SnBwK3RzUUc0TmRGWEhwMmZZM2ltZ1Z3aXErd0V5bElFTFpVSFkzQVdBQW9O?=
 =?utf-8?B?bkpEMzgvZkZEZXY1bzkzTEVNOUNyaTZVRVlXdnJHZDQzbDVqSTBva0dJSHFI?=
 =?utf-8?B?M01JRDFISzdiY1Rnb3l6aWhSbUp2SE92RlZiSDZIdmRwYjdzZ09NWXBOeEUx?=
 =?utf-8?B?a2Via25jeDl1ajY0NnVoaDdiTElLNkVHZUFBMzNaWHlZZTNYVzRkVWxDNkdW?=
 =?utf-8?B?YlROQzVCTWNNRHhsbS9OU2pHTmEwUUFPYzBSYVNNS24xeE84c1V5dkFMaU5I?=
 =?utf-8?B?bjltcUhBT2hwYmJiVVMxeUpTOFdYZitmU0QwdE1zY2FESU1ETERsZGVNUStR?=
 =?utf-8?B?WlJRZmxXVWRhUm11bmdDZFNOUHRGVXNCQW1nc08rUFFONUt3YkNidnJ3UzJx?=
 =?utf-8?B?WEQwbUJJQXM4UFZhOFlvZGRFVjd6NWZyN1FtWE1oeWpCb3dqSmc3WlQrSmhK?=
 =?utf-8?B?dVMrQ3pFRmd1UnBNWmZJRnhiWHIrSjJCdzcrOWVWeXlPSkN3L3ppUUZUQmtt?=
 =?utf-8?B?ZDYydlE4QzVRY29QWFdCdmRUQjBCenMxWDJ4eGx1UDR1UE9BVzV4bnJlbHlL?=
 =?utf-8?B?RmNQODBBT2tJNG5kVEFMLzdld280SWg5TkFhQVFwOGJNc2diWUhzTWRXbytU?=
 =?utf-8?B?dVE1enpJZTRpVDJyNEczdlR2enl1VlBHUy95Kzk0R1I3U095bEU2L1ZmT1kw?=
 =?utf-8?B?MGtzZVJycE92bjN2dHBoc0lJOHFJNTNESWRsMDArWmxSWUp2Zy9RQzFxSzkr?=
 =?utf-8?B?bzVVVGFtWmw2d3BKVXdzNGs5QjVhU0Q5NkdpMXNRV1Bkdm1pa1NHZ2puNVBo?=
 =?utf-8?B?WmVnQkRSRlhsYjBadHM4ZjdhdlZyRGQybE1obk9xdkFqejliSFB3OVhYMVFK?=
 =?utf-8?B?d1pGWEtWZnhjOHR0ZnU5OGFQanhCeWo2Um0zanNvWUE0dW5YZWQxWGlJZCt5?=
 =?utf-8?B?bEVrTU1IQkt5d3BHQU1hSTRxaFJoZ2JubU95S3dyaUE2VkFxSEJpcDJJVk9D?=
 =?utf-8?B?Vm1zREc0V05BbElRUmREU3hEeEs5RFc0SDJiODZmZDdKc1NXNWZtMTBnMHFN?=
 =?utf-8?B?RE1EbzN1TW9wUlkvRGNRVnJxODRmUmFzQmkrTVZ2Q2xrQmZBMTcxWjJqZ1da?=
 =?utf-8?B?eEJHcndPTHR4Zkp3ekdhRS9yRE5vK0JSUk1EdEFZOFB0SkNNQ1MvajJHQlhB?=
 =?utf-8?Q?VM07o+9nlNSKtEGNoh7f7QKF9RpmLrQ/OffS8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QktvVUZFcEYrOHhFNmRKMVJLVDdQM1RYTm1TTjhrNlQyaWZxUlhnVGNLVFlF?=
 =?utf-8?B?eUNUSDVmVzlwV3J6c3B0UEFkakVQejRERGl1YWo3S1UxZFA2RFdLNithUUI5?=
 =?utf-8?B?NkNpVE9lOWhzYktrNnBOVEIvRDR4K1FYdTRDN3BWNVhLKzJZRkl2dXpHUW1I?=
 =?utf-8?B?NDVxTnhyTS9ZNit6SEtueXJFRFVkWE9CS0xraUIybml2TTYyNkVjM3RwWVNn?=
 =?utf-8?B?bXpORkpxbW10YnRZZXEyN1h2ZEg5NmVtSnhMSDdyOFk2OXpRSjd3anZxV29q?=
 =?utf-8?B?MlZNL3JDWWJ6UzVhV09ibjBUZThUUDZQdEtVcGI2UzRvMGZGb0o3UmxjaEQx?=
 =?utf-8?B?L1pRd294dFRybU1DTlVzM09Kd096bmFSam9BMW1ubElJN25Ub0hxa1lvOFpH?=
 =?utf-8?B?WkgzY2tNTFlyMWp4N0xaaVFwVTREYnQvOXlxbmVkckloc1ZIUHUzK0JoaVFF?=
 =?utf-8?B?bEtVb0J0T0FueGdhaVNudk92UjVjRzVHeEZwKys1V0lBZ21IZGNsVUJraDhT?=
 =?utf-8?B?VHlqbkdnVnhVV1lwbUdycC93dHBvVG9DME1ISUQ4Ylp2NWFRTVRnUEYwN2pV?=
 =?utf-8?B?eGkvTEo4WUUxZ0s1ZjF3WEx3eEg5T2l5ZllwVlhGQW1ES3lUaUJEN0w0bVhI?=
 =?utf-8?B?SlYybDZ1eWUwTGNKbUZwRXVTdmZZcGVnSFlLeWFKUmVxczA5VU5yRWdZYlg3?=
 =?utf-8?B?MmxQQkE5T0hRZ2l1K1c1WG1DSzFRV2E0YytRRWEvUDhvMmlFendaUUQvOVdt?=
 =?utf-8?B?Z3ArV2MxblRQYTBYcC92YWVQKzNZckxOdU85Y1BHUnNZT0hmcVBYSHhjS0pY?=
 =?utf-8?B?eDRwaHFDNjdGckVrYS9WUXI2SG9RSzZXRlB4RkZpTFlGdURxTjRzN2YrRXR0?=
 =?utf-8?B?UWRvd2huSFZKa0pIbGVDc01pZUF2c3IrcUw3NE1kRzU2Z3JWcEJrc0dkTHQ0?=
 =?utf-8?B?RWtmcTBhM3YyMDNZV05meTkvUnc4QVcxUEs0dFh5VlhZU2ZsV3hMSXFNVEVZ?=
 =?utf-8?B?cXNvOFk3c1hJRWV3MGgwVjY1SnFDZ1BIWmMrSFdjOVVQSWpxOWd4K2lDOHMx?=
 =?utf-8?B?aVJ5ZXlQZUdUbFg5eWpMc21SK1grdllzcGtOTEFhSDI0R2xZaDVNbGRrWWg1?=
 =?utf-8?B?dWlRT0dOajc0THlaRGVDdmtaUnpGYnA4Vk1UZzgyUFdaWEpRTlN0dzJOTjJE?=
 =?utf-8?B?aS9SZlZKa1RXV0FDbmZacXRnMWcrMFVacldrZEJZSmhXSmpkK2lGSUZnR0lj?=
 =?utf-8?B?MmxvSFhuczcxQlRVZ0k2SGh3WWcrMVpOTC9NdVBUUWlGVTVTVjM5SWZKV3FQ?=
 =?utf-8?B?VGxwUVg5bnhkTS9NcUlNL29RK1lUT3BsdktuTVZWdzVIWXRGdkMvd0orRjlL?=
 =?utf-8?B?ZmJmblMzbEFES2dGM3d3U0xqNG5ScFgzYXVoMCs0eitmNi9EaW1nSkl2Mitz?=
 =?utf-8?B?WERHcGZIVWN6eEVkaTYyWUtUYlB6Nlp4ZUZYMmNMTnVpNWN0b2xIZURZcVp1?=
 =?utf-8?B?WHdldVRLa2REek9pa2ovL04zWTNrY3RNaXFUWGROKzVIalN1alFxUmJqZUhJ?=
 =?utf-8?B?b1VlbmZZMGI2UkNidGc3TFFNSHJtb3M2aXFvL2F3cFdIUmNRVWRBZzFsaTlo?=
 =?utf-8?B?VnpuNE13TnZVNDAycEtXdllTWVZNcTUyWHVlQ3RpejBsM21QZUVieUhWOG5m?=
 =?utf-8?B?UjN4c3ZpUGRqRWNNVEl6NFVPMW01VGtLT1BRVU1lZEVVekZJOERUSEh0bEtT?=
 =?utf-8?B?UGpidUluYzZBSkRoN3hoamNDaUtMNVNJRGhXK0NkakRCT3ZreXRsR1BDUHE3?=
 =?utf-8?B?ZDF0Mkl4TTlCNlk0TGhWcmJtaTR1TjJkWnJ2R2UzV05oeTVOTm04L1draDV1?=
 =?utf-8?B?V2RXNXFVU2o5N0JJak5IZ25RcWUxZUZCY3NpSlN6a21DMWVmV1lYcnFOR1dJ?=
 =?utf-8?B?bjM4ZUZBbmttUGt4NG1tMjhDaTBmSkhzUjk5U1dFVGhkN3Q4dHB6eTJUazNx?=
 =?utf-8?B?TEtOZ2JVVXowNTZOR1c0T3ZheXkzWUZtaVM2RlgzTjJEekNnYTZlY3paSlNj?=
 =?utf-8?B?TnZrY3FDenZHV0h3N1c5SHJhNHpWd2ZaUWlHU0Z3SGt4T1hxeG5sSzNkVlk3?=
 =?utf-8?Q?hiAzA+kK5kqHNFKaUO81bmMun?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aWRWKXiMSEbPTwMAzmRAT7Ja/o8BslIG5xRXTk742IqbSnZGQAtnGkOMBhFhobpKus+ewW9/vsWxINYOD2YcfKON6dJw35W8SwXOLMPxlYG4o6ErUBhMZy1+UH1bLXCiK0M8SnxBmjayw7C9hs8MhUUqj4k2RC6yeFNu3uSPaEYVC9WY02Gn8LRFteOFEfIeuBWe8suyDVyvKOUDEs8mCRq3ZjnuBT0mDTjypFaIyu25Udhu4B24iPW/GxwZImJq7T3tqNwQlxtW7jOpmh9OQW52Ur9qd42BgQgEABO30XqBDw4Pocw12/+Kji73xQiitLj/S9hdjHV6FUwkXN5gjUhpcoO88bhaCGhSIkK+h6qyYxnBNklAePN+uOzNI/t1V1ra8/MZ2h8l4AKGZWWiwO11nui1baG1jmT3uHRFg+wWUw7SAcFoKGdy8twrQWtMiBhvJzyA9dr84AduXlf0AAY091UbLPBJCuM2ljRyNh65CSjvsDysoUHRqfVSmmu1EkROB/CMgAmtVZlB4DvM1/FagZf8PWP0sS6duCy7UL9GgJEPFCqCHdO/kqeS/I3gRSvjSA8Gw7vmSKToeNbJbWXM8N56K9qk9Mp+QtkLWNFRUnwEA2lfCOm9Ph5ghIUG
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a52bce-40cd-4420-d723-08dcf8b70e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:47:08.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOAIi9vOH912EYHEZTBEHWYbpooCL/YphAfrf3xa7XSgjG48tfw5ZkiJY0gVXkHZ9T0x2yIp2owigXkq4b723w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7707
X-Proofpoint-ORIG-GUID: exYZ2MMG2ym94K4pdSBFYSb8eWpgWi2s
X-Proofpoint-GUID: exYZ2MMG2ym94K4pdSBFYSb8eWpgWi2s
X-Sony-Outbound-GUID: exYZ2MMG2ym94K4pdSBFYSb8eWpgWi2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_06,2024-10-30_01,2024-09-30_01

SW4gdGhlIGNhc2Ugb2YgdGhlIGRpcmVjdG9yeSBzaXplIGlzIGdyZWF0ZXIgdGhhbiBvciBlcXVh
bCB0bw0KdGhlIGNsdXN0ZXIgc2l6ZSwgaWYgc3RhcnRfY2x1IGJlY29tZXMgYW4gRU9GIGNsdXN0
ZXIoYW4gaW52YWxpZA0KY2x1c3RlcikgZHVlIHRvIGZpbGUgc3lzdGVtIGNvcnJ1cHRpb24sIHRo
ZW4gdGhlIGRpcmVjdG9yeSBlbnRyeQ0Kd2hlcmUgZWktPmhpbnRfZmVtcC5laWR4IGhpbnQgaXMg
b3V0c2lkZSB0aGUgZGlyZWN0b3J5LCByZXN1bHRpbmcNCmluIGFuIG91dC1vZi1ib3VuZHMgYWNj
ZXNzLCB3aGljaCBtYXkgY2F1c2UgZnVydGhlciBmaWxlIHN5c3RlbQ0KY29ycnVwdGlvbi4NCg0K
VGhpcyBjb21taXQgYWRkcyBhIGNoZWNrIGZvciBzdGFydF9jbHUsIGlmIGl0IGlzIGFuIGludmFs
aWQgY2x1c3RlciwNCnRoZSBmaWxlIG9yIGRpcmVjdG9yeSB3aWxsIGJlIHRyZWF0ZWQgYXMgZW1w
dHkuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4N
CkNvLWRldmVsb3BlZC1ieTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4NClNp
Z25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+DQotLS0NCiBm
cy9leGZhdC9uYW1laS5jIHwgMjAgKysrKysrKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4
ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCAyYzRjNDQyMjkzNTIuLjk4ZjY3
ZTYzMmFkMSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25h
bWVpLmMNCkBAIC02MzcsMTQgKzYzNywyNiBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmQoc3RydWN0
IGlub2RlICpkaXIsIHN0cnVjdCBxc3RyICpxbmFtZSwNCiAJaW5mby0+c2l6ZSA9IGxlNjRfdG9f
Y3B1KGVwMi0+ZGVudHJ5LnN0cmVhbS52YWxpZF9zaXplKTsNCiAJaW5mby0+dmFsaWRfc2l6ZSA9
IGxlNjRfdG9fY3B1KGVwMi0+ZGVudHJ5LnN0cmVhbS52YWxpZF9zaXplKTsNCiAJaW5mby0+c2l6
ZSA9IGxlNjRfdG9fY3B1KGVwMi0+ZGVudHJ5LnN0cmVhbS5zaXplKTsNCisNCisJaW5mby0+c3Rh
cnRfY2x1ID0gbGUzMl90b19jcHUoZXAyLT5kZW50cnkuc3RyZWFtLnN0YXJ0X2NsdSk7DQorCWlm
ICghaXNfdmFsaWRfY2x1c3RlcihzYmksIGluZm8tPnN0YXJ0X2NsdSkgJiYgaW5mby0+c2l6ZSkg
ew0KKwkJZXhmYXRfd2FybihzYiwgInN0YXJ0X2NsdSBpcyBpbnZhbGlkIGNsdXN0ZXIoMHgleCki
LA0KKwkJCQlpbmZvLT5zdGFydF9jbHUpOw0KKwkJaW5mby0+c2l6ZSA9IDA7DQorCQlpbmZvLT52
YWxpZF9zaXplID0gMDsNCisJfQ0KKw0KKwlpZiAoaW5mby0+dmFsaWRfc2l6ZSA+IGluZm8tPnNp
emUpIHsNCisJCWV4ZmF0X3dhcm4oc2IsICJ2YWxpZF9zaXplKCVsbGQpIGlzIGdyZWF0ZXIgdGhh
biBzaXplKCVsbGQpIiwNCisJCQkJaW5mby0+dmFsaWRfc2l6ZSwgaW5mby0+c2l6ZSk7DQorCQlp
bmZvLT52YWxpZF9zaXplID0gaW5mby0+c2l6ZTsNCisJfQ0KKw0KIAlpZiAoaW5mby0+c2l6ZSA9
PSAwKSB7DQogCQlpbmZvLT5mbGFncyA9IEFMTE9DX05PX0ZBVF9DSEFJTjsNCiAJCWluZm8tPnN0
YXJ0X2NsdSA9IEVYRkFUX0VPRl9DTFVTVEVSOw0KLQl9IGVsc2Ugew0KKwl9IGVsc2UNCiAJCWlu
Zm8tPmZsYWdzID0gZXAyLT5kZW50cnkuc3RyZWFtLmZsYWdzOw0KLQkJaW5mby0+c3RhcnRfY2x1
ID0NCi0JCQlsZTMyX3RvX2NwdShlcDItPmRlbnRyeS5zdHJlYW0uc3RhcnRfY2x1KTsNCi0JfQ0K
IA0KIAlleGZhdF9nZXRfZW50cnlfdGltZShzYmksICZpbmZvLT5jcnRpbWUsDQogCQkJICAgICBl
cC0+ZGVudHJ5LmZpbGUuY3JlYXRlX3R6LA0KLS0gDQoyLjQzLjANCg0K

