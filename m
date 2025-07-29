Return-Path: <linux-fsdevel+bounces-56272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DBBB1534A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD67B7AA2BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83124EABC;
	Tue, 29 Jul 2025 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCSN2Xyz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F32459F6;
	Tue, 29 Jul 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816355; cv=fail; b=TAZis478D2fHlT9Bujc95VL83IRuQ/X5ApDm2Rp61r87ycoy6XVsH7OlTvDczVuQAydmW26gOWeFrD04rwnsIMErcAd6MmsVVykO88fIln5RAO5iTFTKWCM/bY4QofjcCN4riBUgt5C7I6VX5Hua7iRPvncWmoPRyoJVNiHHgbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816355; c=relaxed/simple;
	bh=Ws/ZTTTE4pCGAGN/QSN1NQ2d/3qnrEjsBPTtjZyW4Js=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GGSyp6l21NiCOG98oaHDa426dvUpHvsqmWDWLp6PRJ2pfhqN0TL2Yx7MjHkCOooYQcwpn4b7wCESv9L02lE8VTWvv3IqMI+nLjCb1jYdT3Dk/9KLC/265XxfRvlPBNv5yV8vLYgVspMMdHhI9rJE3isvgUttYgjC7LjAEd5ccy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCSN2Xyz; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TEXOi5022070;
	Tue, 29 Jul 2025 19:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Ws/ZTTTE4pCGAGN/QSN1NQ2d/3qnrEjsBPTtjZyW4Js=; b=UCSN2Xyz
	RpLw+DNtsTVVPcHO4YiVyQIVpeH74vMVNgLGx+dp4XcPmovG60qJHTDnalEn0kjj
	s9tUk0M398bYSNRHAL8aXiMHbtLA+hWPNW6r8ILDr/4h6Y7GdWf5VQ9k8DYhL5Ds
	czsPtU5C0hx76LC9V5PRinz90YG4KyPJ2FeHYvlVBjrrCf4DpGGwLroLkXSgRUq0
	fYwKCwamtocWAyJOvOaBMZVMjvS2OXEXt6CMj+fWPMZx0EJtUu11fjBV8CTlEYUE
	69P/e17QVYJzA2y8zGh46fqqUly+0QAq+8+Mi8IcfqXxW9NrCS2XFLv8siCbFeW6
	rBCJa+YykUVjaA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemrkgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 19:12:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0U0lxHnhGgn4GYgMcUUgt7PRYRmjxQQGf/HWY6xs/hizxPzyNgUNSq9pjvP6/ubmAEDSAL3DEUVM3G5CmDUExYdoUXKoxRvJagHKth2X8uFLHz2jt3ORdgk7EmsmKWHeQIyPHb3qURfkcOb2V336PxcUjvHs+/w++0av88uHVVfHStZ5OFqJnzF+2lU9zTw17HQxdKFQdNGbh3MJlA8dHybLtRCzlHYNcRjnIHQfpVGZCy+TMPWchZCdkhIZjQH5ExkOVaXsXcBIMh6JBR4tmJITQY3aHUxjhynyJsblz2XEPP9wMLjcVf0QFlHjWufo6W/5kv58OGnso599Lfjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws/ZTTTE4pCGAGN/QSN1NQ2d/3qnrEjsBPTtjZyW4Js=;
 b=LSJlkmjZquFxyJP9QaPCnZl0ydUQJ62U0N1YNzSs6z6ihF/Qf8GiJb8JnvViQpMzMyYl07LG8nXqvDXUNgboxHk/XB1IvyVid2VjcopRDzLiSHY2idPM9qdjljk85bDTnrnejYXiEe/RJycXybXq8t2G2Sf0Kxiaal6OoPHee3SN50l3PHXXsoCt3vjCJ9SVC8tiM2YwqYrVaiE6HzJJlYjig039J6n31D3X2a/AYCey5J8BCPL3tPPkYBXrllEtxbSYWe17zlwlqV6MNr/BvBEHHv3vxT9Mwb0MgRF9XPk9dmuKlO0/bq3NnxZNVQzk325AfDfLJbmVkziHgbISig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4479.namprd15.prod.outlook.com (2603:10b6:510:85::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 19:12:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Tue, 29 Jul 2025
 19:12:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] MAINTAINERS: update location of hfs&hfsplus
 trees
Thread-Index: AQHcAJ8tG9RgxvDOnUiq7kxPNWAaDrRJeC6A
Date: Tue, 29 Jul 2025 19:12:24 +0000
Message-ID: <d359b20348c17c5426cca6937a96a739e9f1a7dc.camel@ibm.com>
References: <20250729160158.2157843-1-frank.li@vivo.com>
In-Reply-To: <20250729160158.2157843-1-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4479:EE_
x-ms-office365-filtering-correlation-id: 264d8d5d-e190-4eee-0da7-08ddced3d9ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WERTL1I2OUZ3dXhYTWdlYVB5ZGxxYUFtcEhpaHdGZmdQZTdsanNrUllncUc2?=
 =?utf-8?B?Q21xSnRrU09ZM2NmN1ZSYmVuMUpQaG9NdHRrNWZ3WXpObEN3UkJzVGlaVFM0?=
 =?utf-8?B?Zmt3clgzWE5LcmVOc0NhVnRqY0xpRVk3OGJJdTdkK2prdVJhYjRKQmVBM3E1?=
 =?utf-8?B?emRVVXE2S3JxNW1nWG5HVitUeERwa21GZXdpTzVycnMvR3ZxcDR1cG5oMy9M?=
 =?utf-8?B?b2tDaUlCZENVSTJ2N0hQaS92NmhGUzcvaG5IOWpTVjd2NEM2aUVzaWtHaGQ2?=
 =?utf-8?B?NVl2eFY3bzJ2SmdIZ3pESlhSSWN2Vk9yUXgwUEgvTWNPaVdNVWwvenRhOEhU?=
 =?utf-8?B?NUVLNmF5ZWwvUVZLLzdjTXN4YlR0NVJXV0svNHMwVWpWYk9hMzlVdlQxVnlD?=
 =?utf-8?B?N3l2dEZsNGdCZmFkc2dJUCt2MUtpRW8vVmJFV0w1dFdCMExwdDI4WGQwWVFv?=
 =?utf-8?B?N1ovRzhvbTVDMnpIN1JDZUJieTJINVdrL0w2dUZ4VllHOHZlb014eHVEUmFW?=
 =?utf-8?B?VnJlSGg4Qzhvb1p3ZmtORzE2RkZXcldPUmRIMjU0Rk81SXdzUDErYnBzN3F3?=
 =?utf-8?B?ODNzNmQxRmF3Uk5xYk00UjFEY3BkZG9OTnY5cWQ0UStlRDhWV040NFVYOUlK?=
 =?utf-8?B?TVFWK2gzNHJtSzFUT25qNHBMTCs0OWJxSTFXQWpCTWhnS1hRR2RxMG01NXJo?=
 =?utf-8?B?RjBxR0Y2Wmh4R0VjOUs0K3Z6cEhLK0dMK01PRHdibnkxYXdRM1F1Y2VwM08x?=
 =?utf-8?B?Z2ZrcitCVFhoa2RZaDIycjBuRnYreTJmUjZ4dkFvME9BYy9iS083SFpRY2xD?=
 =?utf-8?B?eU8vTjZzMzRCR0RNMkgwRVp5RGczUEN3aVRiM2VDYzRWd3ZLR0UrN282Y3Zk?=
 =?utf-8?B?WW9yanVHR1pGWW1nc0Eyc09SUGhDWXVkUm5uMnpnL1N1dW1kTmJEQjFieFdY?=
 =?utf-8?B?WlVVUS9kb2xySGltUG1UVlN1T2kwTFFLUUxJRUVNVm9JWWxaQWEwRkFQbEFJ?=
 =?utf-8?B?Tm9nQW9IUm8vbGpqMzdOVjZQTW1LZlFmbG5Id2M2bEpBYi92K2xIaExOYnFk?=
 =?utf-8?B?N3QwcG1XU3dhRUxvTnB3R2FWa1BwNDB2a3VQanBSZXpwSm9MRlk0QWJSQlVJ?=
 =?utf-8?B?Wnd0Zjg3d1RZcEgwRVcxWHFyMUFhZzBJMUJjQi9ReWdZV05yT05MMlhIaG5L?=
 =?utf-8?B?M1Q2dnZxeWMwSDNlNkZXY3hrQU4wNlA1N0VxVjV6MzJrZ2dnTzNIVzVFZzBE?=
 =?utf-8?B?d3FKdXVQcC9lVUxNcnc4eG1VNnArNGhzb3AyaFp3bUF3aHFBcVNKWW5VNFV0?=
 =?utf-8?B?MzFhWGQ0VkkxYzFJMGtDZGJxK08xdGlvTEx2UHRYakVYc29OQXk3VUg5YUty?=
 =?utf-8?B?bG03ZEtURlRWUkdBRzFZTW1heDJ1MnFWL3hZUDhDODI5N3hBR0xST1VPY2Rn?=
 =?utf-8?B?SXNJdXVqWlREVDdxUVF3UGVTVG5Nb2QzaFY0Slc0dE0rVWRBM1pkV0VidEJ0?=
 =?utf-8?B?M3crTkkwYlU2Zm0rbWJ1S1g4OEJVelF1cThYNUpZUi9DOU9PVzE0S01VaTNQ?=
 =?utf-8?B?Rjl6MEhOOEp2L3ZoRVlwK2cvYlowNVZ0bGVrR2NFSElDWTAzaWFxS1JiUmJF?=
 =?utf-8?B?bVcrYzJKUjdUZEpYZ0liMjduQUlkRzJ4RDc0VHcyYi9OMktRL1J6REx5TkpK?=
 =?utf-8?B?Rjk1RnI2R0F5NEFta015RWpKb3NNWkNoSXllV25hWnVmTTVibThCV3V5RzFz?=
 =?utf-8?B?dWVaNklRQ1dLQUZJZks2dmV2RnlGMEgxSmNjRTZGeFNQUjc2dHF4YmUyN0xN?=
 =?utf-8?B?ODkzNnRFSEdQTXMyNGdnL2lhNUpmeCs0U29CSlBqMzhXbS8rMlluN3BtWGpr?=
 =?utf-8?B?UG0yTHBDR1RkMDFtc1V1L1JybDl5VzA1L2FaamRMWHBHRGR1VUV0S1NzYWNx?=
 =?utf-8?B?aDFWOVV5dGovd3NsVkxnTFh5b2xJUFFLN0FQVUZacHoyWGJ5SDZ3ZGU4TFZK?=
 =?utf-8?Q?RmRoiIaorxi34NdxqGWSsp7i8WnTaA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFJzQXdjK3NKV3ZIWGlidE85VGp4cEZXL2xJTXJ5UW9pbm9ZdXk4NHp1cjJ2?=
 =?utf-8?B?MEcrQTF3WEROWm80ZGZvUEkxNGdLMWkzeHU1eE5wb0h0cG5uZEQva2NCOW5j?=
 =?utf-8?B?eFE4QkVvT3d0ZGROK1dWWEpGWVdLcXllZXNiZ1huQ0ZIbGhmRFArU25LNk01?=
 =?utf-8?B?SkV0dmpnNWlNZWJvMloxbFpqZ1VOa1JLWmZCd0FWclVnWUhmZjRRYTJ2aC9Z?=
 =?utf-8?B?ODhLdkRneE5UOTh2VjFFdlNlL05Gb2kvOUxXclR4UlIyeENFTHM5aCtGekht?=
 =?utf-8?B?YnNMY1B6ekpCeExtdHV1YXl6bFA4MnpVSWY1TVYra0ZVd1duQ0dKT3FnNmVH?=
 =?utf-8?B?T0xTc0JoR2JZT0FLRFpsVFBTMEFwRGJpUk53WmFwTE1UR2ZRSlI0Y0l6Wldw?=
 =?utf-8?B?U2dQSjlNN0tlSHUyV2dEU2gwU1BYNVh0MitWWWQvVjdYM0RGa2tLYkREVmxW?=
 =?utf-8?B?VlpjT1pDcWI0aFJmcGFyelBUakl4VHJ0VmdGSjhlaXloenRaNHBDUFNrVHlz?=
 =?utf-8?B?U2NCWEhJVDJzbE5ibGNsd0lzLzJEcC85WXBGWXVjeEw5SkFIZENZMjBrcFVS?=
 =?utf-8?B?bythY3ZCZmMrd2NJVEs0N2p2SEhydFJmSGZKT2FJemlmYlJPemNiVDB6ZWFZ?=
 =?utf-8?B?Z0t3ZEZpcFp1bzlleGxtRVdzQXRRdmZNYWU2UHRwVWhyKzhHSWs1a2VYUnRS?=
 =?utf-8?B?V0R3WG10MkxWWmVwUVpKWm55YVdjekhQN3N3R2tCcStlbWZpd3pnMmZjWDVx?=
 =?utf-8?B?VTVJTzZpQXZlOWFoVFRRYkV5YWUvYWdGNVVWT3ZGVWZsWHQrOEZSdGpiK3B1?=
 =?utf-8?B?M0lEVk1TVWJsNEFCRjRwbXZiVVlhMW82ejJBbFpvSkVSVDZtN21qN3N0Wis5?=
 =?utf-8?B?dlpKMVZYYnhVZkVjYVZPblBSWDNwWlB1ZEJGOXplZmNIOUIycGhaWGtDa2kx?=
 =?utf-8?B?WUVacGVFS0VjRnVpamZjdXBhNGVDQ3hTNVRrdVdRUlEwT2tsc1ZFS2kvdng3?=
 =?utf-8?B?Q2hxMXUvZHkzamI0SmdGUjV4V2E2OHNWbnpHVnB5TVlRbmxrSEFDM3VkbWJ4?=
 =?utf-8?B?cXpMc2pGVHpvd1c4TDU0TmcxQ0V1UzFRaGZIMmFZMTR4T25Qd1BCS2xKaEI1?=
 =?utf-8?B?NUlZbGJGdWFySWZMNndldEdyQlVIWG1xWjd4MGxJV3FoK1ZTZHlUb0RKeUxo?=
 =?utf-8?B?VElrZXQ4a2ZjdXhvRS9xclNzMWxEZy90QjRqRXdBbWxCSk5tdEQ4bm1OU0tp?=
 =?utf-8?B?QllKWHRqZW1lKzZzQXlKV2s0ekdsc2hvZy9KcmtKY3RVWmlWa2pZbEM2K0Vz?=
 =?utf-8?B?bWhkQ2ZGS3lvZWFUazhKd1NzeWRTSGR1VHBoaFN0dkJaMXpPSkV0MUQ4MFNK?=
 =?utf-8?B?cjA4dFo2eWNoMTdma25BSXptTW9HT1IyMnBuL0dqT3BGaVpDbnRjamtTOHFy?=
 =?utf-8?B?Y0YzM2tZNHhaQStiUUhuQkQ1U3RucFR2Y2xuanBROVF2c2dJelIxMmU4SEo5?=
 =?utf-8?B?ZkFOaWtlYmNHTHpSUEMwM1JwZEc5YmFsd2k3T2F6TXdteGNOZ2Npb3pKSjN1?=
 =?utf-8?B?UThxREJiVTRtaGpCeWNTQ3g2NUNxV3A0WVY4eGc0Wk1rSExIRURxVFVQTGNV?=
 =?utf-8?B?UlUveGVUQVl6cGlLUTNvdEJ5cVF6QUJ2RitLTmhjL1VWVldEdmFWazg1b0NC?=
 =?utf-8?B?V1liWC9RTmo1Y3g5L0pSVVMvcWlTODRWYUY5UFM2NUwyNXFwNXI3eFRXK3BV?=
 =?utf-8?B?b3lGWlVITnRUMEpZM1AxcDNWM3djeGVBSE0wTVd3WTV2bW5SM2FLWFdZVlNq?=
 =?utf-8?B?WXdGajcxM3RhblFHMCtXbnZMMGJhcE5TNkJYNkVzSk55bDlRSWgzQkUvMXl2?=
 =?utf-8?B?amNmdDRWbEY0UExFelBzSmVXMEZLQWdHMk1wcDRFVEZocVptTmpKV1I1Zlpl?=
 =?utf-8?B?aUhsNWF1U2tEMVVsWmkwWVRGL3hBNkZXSUpEcHpqQnJ5Snk0TTBDVnJaZFkz?=
 =?utf-8?B?RmcwVThNQVZhbzVlNVZVQ1E4VDQ4bkEvWjRWV1llOVJNb2FwWTMvektIM2J0?=
 =?utf-8?B?SytCM1M0WmwxM2VHZEpXYWowY0VnWis4T1JKL1hDQTRkSmdES01OUEVSRXln?=
 =?utf-8?B?bTlObkMrNnI5RVFtM295MEo3eXhlazVVUkJ3U0lUYlJaZlpqVTJWRHlmelkv?=
 =?utf-8?Q?boaBEJOOCXXCbPL65iXhf9w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14D8825582852841B33D10D7EF166C66@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d8d5d-e190-4eee-0da7-08ddced3d9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 19:12:24.1369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNQ8H3V3GbMyaGL91Wnxu2SBuVxgJa7RrxylvP584CvdSnntWng9CureZlHb85TS0Fmv6Y5i7EKozHh3Xn+rig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4479
X-Proofpoint-ORIG-GUID: pLlCyV7Mz8LR9_Uca1vfbL2VlfTeTlnA
X-Proofpoint-GUID: pLlCyV7Mz8LR9_Uca1vfbL2VlfTeTlnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE0NCBTYWx0ZWRfX1Pk2t2k/cSal
 EUkzwhoTJS4/xx+IGYxlqL9tOchNfqJZe88nsgWvO2NF9XDMFjVoRYlZXBD2tkva+7JDlCF0bas
 cGfsZOtmYHGntEcIa6SNEYuEhocZtKqmL3qZNvClj4F2cKgoHj/Q2EnxlXV1ex+EyXWj6If9RQa
 CwXpS/3ac453iLETKG0Lt9KAHVZltRQaGTWB5MPMRL9ha7T4bMf0lRe8T9yuGdqBqn2BHjAEuhz
 vyEd7DIc2u9tZK0/r8kJD34zMJNUvZMvHCjTbVWykkJfg9Yl11YU5N3/8CpZW8ZGzGILRIuYYHg
 sPi6N8nowtmLjZBHU/pEnSofoDwnU78DY5fD7dfOUiEIAE1q6jrgfYUMAzUsbDBDfNI3hYlkcr4
 CKUSOLE1y2xHmQBJAa5Yay49vnNwO9pSc+Rk1fbfztuxu99CkvNsRghv1yIPKRhl9z3yAIFB
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=68891d1c cx=c_pps
 a=0de+TxTBwdPc9w0nPmKirg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=1WtWmnkvAAAA:8 a=VwQbUJbxAAAA:8
 a=4dlIIzbUBBLElanQgFMA:9 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH] MAINTAINERS: update location of hfs&hfsplus trees
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290144

T24gVHVlLCAyMDI1LTA3LTI5IGF0IDEwOjAxIC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBV
cGRhdGUgaXQgYXQgTUFJTlRBSU5FUlMgZmlsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0
YW8gTGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTIHwgMiArKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01B
SU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggN2E0ZTYzYmFjYWE0Li40OGIyNWYxZTJj
MDEgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBA
IC0xMDY1OSw2ICsxMDY1OSw3IEBAIE06CUpvaG4gUGF1bCBBZHJpYW4gR2xhdWJpdHogPGdsYXVi
aXR6QHBoeXNpay5mdS1iZXJsaW4uZGU+DQo+ICBNOglZYW5ndGFvIExpIDxmcmFuay5saUB2aXZv
LmNvbT4NCj4gIEw6CWxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+ICBTOglNYWludGFp
bmVkDQo+ICtUOglnaXQgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3ZkdWJleWtvL2hmcy5naXQNCj4gIEY6CURvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvaGZz
LnJzdA0KPiAgRjoJZnMvaGZzLw0KPiAgDQo+IEBAIC0xMDY2OCw2ICsxMDY2OSw3IEBAIE06CUpv
aG4gUGF1bCBBZHJpYW4gR2xhdWJpdHogPGdsYXViaXR6QHBoeXNpay5mdS1iZXJsaW4uZGU+DQo+
ICBNOglZYW5ndGFvIExpIDxmcmFuay5saUB2aXZvLmNvbT4NCj4gIEw6CWxpbnV4LWZzZGV2ZWxA
dmdlci5rZXJuZWwub3JnDQo+ICBTOglNYWludGFpbmVkDQo+ICtUOglnaXQgZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3ZkdWJleWtvL2hmcy5naXQNCj4gIEY6
CURvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvaGZzcGx1cy5yc3QNCj4gIEY6CWZzL2hmc3BsdXMv
DQo+ICANCg0KTWFrZXMgc2Vuc2UuIFdlIG5lZWQgdG8gdXBkYXRlIGl0IGhlcmUuDQoNCkJ5IHRo
ZSB3YXksIHdlIGhhdmUgYWxzb8KgWzFdLiBJIGFtIGNvbGxlY3RpbmcgcGF0Y2hlcyB0aGVyZSBh
dCBmaXJzdCB0b28gYW5kIHdlDQpjYW4gdXNlIGl0IGZvciB0aGUgaW5pdGlhbCB0ZXN0aW5nLiBB
bHNvLCB3ZSBoYXZlIHZlcnkgc2ltcGxlIGJ1ZyB0cmFja2luZw0Kc3lzdGVtIFsyXSBhbmQgSSBh
bSB0cmFja2luZyB0aGUga25vd24gYW5kIG9wZW5lZCBpc3N1ZXMgdGhlcmUuIFNob3VsZCB3ZSBh
ZGQNCnRoaXMgaW5mb3JtYXRpb24gdG9vPw0KDQpXZSBoYXZlIGVtcHR5IFdpS2kgdGhlcmUsIGJ1
dCB3ZSBjb3VsZCBhZGQgdGhlIGluZm9ybWF0aW9uIHRoZXJlIHRvby4NCg0KVGhhbmtzLA0KU2xh
dmEuDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vaGZzLWxpbnV4LWtlcm5lbC9oZnMtbGludXgt
a2VybmVsDQpbMl0gaHR0cHM6Ly9naXRodWIuY29tL2hmcy1saW51eC1rZXJuZWwvaGZzLWxpbnV4
LWtlcm5lbC9pc3N1ZXMNCg==

