Return-Path: <linux-fsdevel+bounces-44213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2338A65D94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 20:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF77176B96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C61E521C;
	Mon, 17 Mar 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fgp+4l/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5956419E96A;
	Mon, 17 Mar 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238523; cv=fail; b=ZX7Ht/xQpsrL7rxIdF9yQGFz75CsK0fC36Z9eAAHOSffBrxtF+atv2fSk5EeKblzZ147+D0Ew47Inmiyk8gXjS5pvLFrnVc9bQDM+MrnpuTXDD9KRRbEX2NOs44XP248RXDc+0Qc+aMOpYYTD9amQ3/MpqgGsvTcEC+yUGKeYB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238523; c=relaxed/simple;
	bh=jryGshB5oNTC56UPA/5Gixwq/xN4CIb4zlqdCRfjmlY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=tzOuvB4ZqLLMY+BZhVFCUIiK6VT7KtzDGzANI0Z+1kj2YJY+CnpzJsQjqV3jV1CGkQEC+7Z3vHpTiSF255kLWxcbNvK56tttew108+fk4pe/bl0HOFvfCAMUT5BHR9U7N5EQJqVcJG90FRKll3Tekg/Mk8pnJ22/m7jTyExpJaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fgp+4l/o; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDa64d012699;
	Mon, 17 Mar 2025 19:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=jryGshB5oNTC56UPA/5Gixwq/xN4CIb4zlqdCRfjmlY=; b=Fgp+4l/o
	4xG2T8haUCzGPs0vpLXLqNe6TCsqUkmXxnjcnOm49pn85ucQQjFAY9zlAlS+bf5C
	q/kdrDg/QBfN66LL6H68XLt8RHzT2rTn6TK/0NULN7FTZB399YAYJG7JrwHoIXKq
	a0wtSfGzXCca+7R0cTA+fY6BePPq1qrlI8ue6h97VVWFRZCtOW53QRbCn0iSpq56
	BKOHlGklOYAbrdvpZlVrUA7v68lqoWWjFS30kZDL76l8uApncm1aEykufVyd5f9O
	d2hXQr22NHIZ4z6q0iuYLno6bXGcNKmKUGMhPQ94xRM+GklkHpgf9SetlYkepc4b
	FOY0O+AsHCaOSg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ec49c8pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 19:08:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52HJ8RQD003081;
	Mon, 17 Mar 2025 19:08:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ec49c8ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 19:08:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOyThczimU5HvkVSAvuoDDCvKfu9nqLStVsw+XHkF3LuU68bfiI6+p+waQ/i/tBG4RRtkLZaM4Q9zFfU83fUSU9g3cANlPGEBJ6Cn7Ul0iw8lhxFtOpnPDpMezClhUtW42PvoQPwpU2WBz5XY42lffuobg27Et23eYPNTIAv0i81NU3+SdKkKKuUQExlhhR4NK/fPURiOkVqJ6ME6LkpFpXUGDIFsfo410hRYEqe9jpXhIZX1xX4QZm1EFktttyqH7VaCWxLfsxOdNKpLT3/1HYeKtB+IEVwF7NuRPelAyE8kogU07q5zEgGkwSsDCBRX9uN+xRdBJReIoH91OaE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jryGshB5oNTC56UPA/5Gixwq/xN4CIb4zlqdCRfjmlY=;
 b=dyjwLE1BhtUD1ZXvcDk3+69WQceuZpUkAg8JmW7YyQzt81xBdAXtkmCw7gyixBX5DDq/4xBPDD4k3scHl8YDaLpGZEA+1mDfTweKhwavWEyY2Uvfr4yzP2SnZRRrRIdGYzMSkM8Gzs/ZQDERIFOdJOF7+YufkPSWzkkEEWJZpSB77uzSPPEc/zN3Xg48oZF01ZXZYQk1zZ2Pk9w6ht6PdGxHUTedi01DiKl3phc1cFIinryQ4OWG5mfnf1AODIaFvZhWIjmGahLZyNQwMcaTmmF2XLyX0mjQuTRkJQjMSptSib0I2JX+V4H22wbDBf8k2ZERrEKriIkQFBDN56RmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5917.namprd15.prod.outlook.com (2603:10b6:208:3fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 19:08:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 19:08:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "dongsheng.yang@easystack.cn"
	<dongsheng.yang@easystack.cn>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [RFC PATCH 06/35] rbd: Use ceph_databuf for
 rbd_obj_read_sync()
Thread-Index: AQHblHC2X/k0XF5CFEGF2MehpYYXxrN3twaA
Date: Mon, 17 Mar 2025 19:08:23 +0000
Message-ID: <f2b15e2f951e249e98f33b07ee261b9898dd41d3.camel@ibm.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
	 <20250313233341.1675324-7-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-7-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5917:EE_
x-ms-office365-filtering-correlation-id: 16e5ab3a-90b6-4ae2-1911-08dd65871708
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WERNUUFQSTlrd0gyYWo5VjExa1pYS1UwWEZLVEpvNzcvd3ZKYnhIbjlDcUt5?=
 =?utf-8?B?M01HMFU1QnJxdHhCaUpwUkJ5RzBOcUlZdktRSVRxT3NjSjNSSWRyYlhSYXVw?=
 =?utf-8?B?N1MvajZWbVloa1l0L2FldUdLWFdqQTF0V2pCOVlZWmNyQk50dUhwdk0rck90?=
 =?utf-8?B?UWdVQ2huT2F5cUJNUVozTzR2VHdHV3d3Zkd5T01jcWlBcDJSclhsVkw2UkU4?=
 =?utf-8?B?VzVpZStnVEdxQmcwdll3a0htUkJ1TjN1amE2cHZSNnprSmdDZnlLVjAzTy8r?=
 =?utf-8?B?bCtQMG5Jc3E3dmFKZGd2WXBPMEdaTHVjRHg4NVM3WndZUE9zVVpUMTJSNWoz?=
 =?utf-8?B?WXJ1cjZUZmozMjFhd1NPL0VjM2VsdFYvOVpYeDQvTlhWZVhGNU14RUdRZUYw?=
 =?utf-8?B?TU5VdVFBOUNQUHIrMU53ckEzUDRrYTRmaDBKU08vdTBOdUVqdWFidUExbjYz?=
 =?utf-8?B?OGlnWjNNMXFwMno5a1B0K1FsdllTRkkrTlEzd3VRdC9RV2NLZXZLUjBjZ3Vy?=
 =?utf-8?B?WlZvN0Z2MGJNdFA1cFByS3VFemg5SDU2NU5CSlRaNTZtemZoZTFVOHJBTUJj?=
 =?utf-8?B?NGVkV0xtaGRxaFE1bmQrYm5zQ3hRY0R3aGx6OGtXbEhoZzNkVnFVKzJHeWxp?=
 =?utf-8?B?Z2x5SWVGeklOci9jRkpjTlVMNVdVbU8rNDhGTzVwM0owakIvY0haVmN0RjZG?=
 =?utf-8?B?QXRVUm1zSWFsejVTRWRuSnc3MmNtc04rVFNuUDRud3Y5WGE1UGpsWm1hSmIw?=
 =?utf-8?B?UlNOejJ3d2dHRXpRdHI5UWJzWnppTTM4Um1PUXVXdlRFL0JYY0ZrRnc4bFor?=
 =?utf-8?B?OFoyRUdKSEdidmJDZytFTk16QmxFazVrNG5FN2xtcDNtbERFK210OUQycURT?=
 =?utf-8?B?ZW0rWmcrRjZqVHNIcEw3YUlPS2dqOTIrQVB4TGpEUmxiMGVqdGR2emtiWDhk?=
 =?utf-8?B?K0dnUlBRRXhMTkIxNktvWERrQVJid255aHVaMHNQYkp5NkhHNzd6WWlFeEJB?=
 =?utf-8?B?cjUxZEJEL2c0ckRZcXlIVUVES0JVc1RBU1pyVS9KYUFFcEEyUmg4S1NkNHk1?=
 =?utf-8?B?cGtuRmhXbjkxbVJvRlZsOVZpdmpHanRMMkdLQVVkV0lZNlEzcDlrWHF5ZnBK?=
 =?utf-8?B?c20vSW9vMm1leVR6ZS9hL0FneFlaekxRUU1QWnlJZGI5K1hIM1VlVzl1Y0R0?=
 =?utf-8?B?SGF4UmtueG1kVXQ4RTBSZERSMEN4ajNBZUs0Wm96bEd3b3Urb054SWh0Mksr?=
 =?utf-8?B?eW44ZDNtUFhkYitXS09QUG5EZjR6aDc3cVcxVTlFUzZXbngyNW5oNVJoSDdZ?=
 =?utf-8?B?MHpONHNEeHBuYStMSkk5dDZQclVubDE0bE1aMG82RDZtdU42RUFCSU5uWUd5?=
 =?utf-8?B?bXEvRElIUEVVQ3dLTXRGTDlwQm0zc1BXWVY2WGw0WTFBajBFTWJuM05iYkF3?=
 =?utf-8?B?Rm9YamdlZThka1FWUjVwYkJab2Z4NGdrUzl6eGMvaDlzaktxM3p4cWJiL2dZ?=
 =?utf-8?B?YkFFbWgyWU4rdGJyVVh0dDBvVTNGdlZRTG5LdFZRYTJrM0p1Y2IrZWc2dkNi?=
 =?utf-8?B?N1Q4TEJTVnl4SXYrUjc5Z2RnOXNmRzNzMW9reGRIc1h5VHBZSnFNWEF4R1JO?=
 =?utf-8?B?YXpwaitPSXNWdHUwT1pSMHJyOXBab2RpSXVuYW9zbTNkaXl6Ri93OGxXT29n?=
 =?utf-8?B?TC8rcWlGK2p2VHNxeHJqMXg1ZndwdlRpamk2Uk1PNEpCK3NLR0R1cTROOTcz?=
 =?utf-8?B?ZXBUNG5hVlRneE1CK1NVUkF6N3c0QlJyVkZDL2drQTE2L25YdnFpNEFXVjI3?=
 =?utf-8?B?SStEdWVrYjVNckJiVlNHcHBhTUFmYno5YTEyZmt3SG84R0JDMXZWTnhJUE1L?=
 =?utf-8?B?WEFzT0VNUFJlNWk0WjY4bUJhcHVBbEkwRUsyWGgxK04yYTRDWHNzSEtsYjdG?=
 =?utf-8?Q?3Ub74bIT7k+BeVTIK5uo6AciyC+Bks07?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmV2RGtTUTMzK0xTRTJyejMvZkx6dmVPcXg5clB4Z3dOSTVjUmRrV0wzUWhI?=
 =?utf-8?B?a1NWYTk0enRTZEtzVEpjV0UzVUpYblo1ZitRQUg1bmx3R005b0ViMzdFWllv?=
 =?utf-8?B?ZER1emlCc2tpVkltWUZHT21iMUdwNC9LeDhKbVRwV3U2NTB3SHhDbzdzck0z?=
 =?utf-8?B?RnJ4NmNLdUxiQkRTbW5RVUR1M2FNcW9WZ3lKUUtjUElSYituQmxVVkJtVmZ6?=
 =?utf-8?B?dHppVEtmTW9TME1SSjJKTkU2SjkwM2xkTTFlUW40WTJJWEZYbStDM0JDd3ox?=
 =?utf-8?B?anI0dGUvYkQ3TmZQS005Nm4zVzFlV1hRZjJLd1hDa1E2THdsYWdRVFVxSkYv?=
 =?utf-8?B?NlBHL056NWpYejVnTWc5V2U3am1ma0dlWlluRnVSR2tuVDFNTlpvUHZNUVpj?=
 =?utf-8?B?UHU1WHBKWDd3TTNwYTFBbXNVUURHUDhvT3JrWHlyeDExWlNTNGJPOGdJR0RV?=
 =?utf-8?B?a0M2OTlIcE5Va1NBZElCTTRCUDR1bStSOXdUQXVvbW1GOFhjb3NMOENHS05j?=
 =?utf-8?B?V1I4UEo5NW5zbm43eE1weEZNZHYzRysxWkZXMytSemFublVqWnRWNEZ6b1dN?=
 =?utf-8?B?WlNrZ3V6QnhJWldrTUJJR0xxdWVNYWtoMFlDV3dTZ3lZUWs3NGl1aFFOaDRX?=
 =?utf-8?B?SisrS3Z5UmFJcjBqVVZEUWp6ZGdMZzloZFBKc3hVbVc3NVBDQ0RsblBZRkdX?=
 =?utf-8?B?KzhBaVZrdFR3ZVh4RndiOWtySkszWmJKSjkralpTTExTTkg1M1ZxQjZncndK?=
 =?utf-8?B?Nkp1SzZKalV1MEEweEYvRk14ZzljYi9KMjJKb0dOcXhVdHZubWc4K2p2YnlM?=
 =?utf-8?B?MzZCV0ZFRWhIZndGSkRYa3pEWVdGSEZ6Qk12bDBneCszbWNLOW5IQTFjdW9N?=
 =?utf-8?B?czhOODk0dlZ6UkVIMUJ4Y0dvUHRUYUtzcDBqclhVR2Y5d2IxOVFUWjZLRjMx?=
 =?utf-8?B?SzhOSHhmSkdwR1dNWFRtcWVxVmx2YkVBUk9BMXVBK2xaQTk5MGVjZjd4YS9x?=
 =?utf-8?B?T1ErZSt2VHphN3o3V0xWbkVFM0RNTTBTK0MrZjBLbTdZZndsQ2U5SUtIY3JV?=
 =?utf-8?B?bEhtdHZ6aWNMUncrZ2l0ek5vUGVwYjVXbVp3QWRkWnpISG5wVnBIeWtpbzlB?=
 =?utf-8?B?Z1BkWFhGUEVDblBpQ0hiQUlsWHZWQ0tpWVFlUTd4NEN0aDQwZ1hKdE5vMVZU?=
 =?utf-8?B?ZnBFOGR1dytMSG5GTnV0WTRycnNVK0FXTUd6c1BtbzlzUVIrNXROQU1NUCsw?=
 =?utf-8?B?V3BtdzNFK3RnTGN6RGJJSTVENzkzUzRPdFYxT01DT0ZaQ3VScG16NFpZbENa?=
 =?utf-8?B?Y0ltMFF5MzRKWU5IWlZIYmZuc3laWkYxS2RYVjNQbmNDQW85c2d1WktaVkxC?=
 =?utf-8?B?NFI0c0VSbFFiTWdobGQzZGEyVHRidnRJLy9xN3JkamFkOU9jUElDenZhaW9o?=
 =?utf-8?B?L1M3TVdXUHhHbmNGVGEvWlppUWJXdURhK3I2ZFlvdTYwZzRnNUpzYTJBMGZZ?=
 =?utf-8?B?djhtNzZLRWpqUG4zZVg5VzlJNjFWNTJoaHRjWHBjWTlCaEZRY0VwbkRYeWtr?=
 =?utf-8?B?OFZVbGFQR2FFMGljeGxlaWZWMzhXQm9GaVlmVURta2ppUkpqNXlHblJsaDNL?=
 =?utf-8?B?eXFqRVFVTXV2V29VaGhyVFltV0llWHk4NC92NFlJWHM1ZWFHVWhMU3ZGcE1P?=
 =?utf-8?B?WnNDZUJYOUt0QlVDTjhpOE5xTEdvRUpTVjhSN3Joa0JHV3BFbmljajJhakxy?=
 =?utf-8?B?SWJmZHdpYk5HVXQxMkV5MHdETXgyZFhka1hvcHRqNVYzV2xTS2F2VFNEWGk0?=
 =?utf-8?B?cGkwNFpLbUVoNHFpTkNZK1dqUzhIR3Y1TDM0RFFiRlBmR1N3d2Izcys4bXNR?=
 =?utf-8?B?SStKcFNOM29Ga1hxZEVDVTVWL2h6ME05YW5XeWh1c3g4RVpYaUpadGhUQXo1?=
 =?utf-8?B?TjhaZWNXVm5pREM2aEl3N3ZVK2xWdXIxUnBONjJRQ0JrMGZiV05tZW1icmp5?=
 =?utf-8?B?STRJMWZlaXk4ZXM4RytrdzNGT1JyMWlnYXFqa2ZiZnU4cEUwOE1PeTRsZ21z?=
 =?utf-8?B?TU01SktZUlpwb1Q1OFRqdlc4b01Pb2J0dzkvV2ZQOWFXbjkxaktEdWRwQloy?=
 =?utf-8?B?WXF5c095UndWWUk5VU14Y3dmdVJiQzJkaTJrSGxaYXBSVE5EOWc0L3B4akRE?=
 =?utf-8?Q?rvQ2ChYpybZgfisuOjz/Jbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CC012F5F4244046BEA752E6C95712AC@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e5ab3a-90b6-4ae2-1911-08dd65871708
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 19:08:23.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKm7UhHLyeIe54escAcEGjTVm3Qw9xu8Ku2qZHmkEMvdxIPx2v1JJgrrv5LOHMXQbkt0aMuIwF9fXLLe10TmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5917
X-Proofpoint-GUID: Nw7SVEtclpf6yPsCglEF8NNvF6eje-UH
X-Proofpoint-ORIG-GUID: f5M6C-jYF85_rLbvX-bQZyy39ekq4_2b
Subject: Re:  [RFC PATCH 06/35] rbd: Use ceph_databuf for rbd_obj_read_sync()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503170137

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjMyICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBNYWtlIHJiZF9vYmpfcmVhZF9zeW5jKCkgYWxsb2NhdGUgYW5kIHVzZSBhIGNlcGhfZGF0YWJ1
ZiBvYmplY3QgdG8gY29udmV5DQo+IHRoZSBkYXRhIGludG8gdGhlIG9wZXJhdGlvbi4gIFRoaXMg
aGFzIHNvbWUgc3BhY2UgcHJlYWxsb2NhdGVkIGFuZCB0aGlzIGlzDQo+IGFsbG9jYXRlZCBieSBh
bGxvY19wYWdlcygpIGFuZCBhY2Nlc3NlZCB3aXRoIGttYXBfbG9jYWwgcmF0aGVyIHRoYW4gYmVp
bmcNCj4ga21hbGxvYydkLiAgVGhpcyBhbGxvd3MgTVNHX1NQTElDRV9QQUdFUyB0byBiZSB1c2Vk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNv
bT4NCj4gY2M6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQo+IGNjOiBB
bGV4IE1hcmt1emUgPGFtYXJrdXplQHJlZGhhdC5jb20+DQo+IGNjOiBJbHlhIERyeW9tb3YgPGlk
cnlvbW92QGdtYWlsLmNvbT4NCj4gY2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+IGNj
OiBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvYmxvY2sv
cmJkLmMgfCA0NSArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3JiZC5jIGIvZHJpdmVycy9ibG9jay9yYmQu
Yw0KPiBpbmRleCBmYWFmZDdmZjQzZDYuLmJiOTUzNjM0YzdjYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ibG9jay9yYmQuYw0KPiArKysgYi9kcml2ZXJzL2Jsb2NrL3JiZC5jDQo+IEBAIC00ODIy
LDEzICs0ODIyLDEwIEBAIHN0YXRpYyB2b2lkIHJiZF9mcmVlX2Rpc2soc3RydWN0IHJiZF9kZXZp
Y2UgKnJiZF9kZXYpDQo+ICBzdGF0aWMgaW50IHJiZF9vYmpfcmVhZF9zeW5jKHN0cnVjdCByYmRf
ZGV2aWNlICpyYmRfZGV2LA0KPiAgCQkJICAgICBzdHJ1Y3QgY2VwaF9vYmplY3RfaWQgKm9pZCwN
Cj4gIAkJCSAgICAgc3RydWN0IGNlcGhfb2JqZWN0X2xvY2F0b3IgKm9sb2MsDQo+IC0JCQkgICAg
IHZvaWQgKmJ1ZiwgaW50IGJ1Zl9sZW4pDQo+IC0NCj4gKwkJCSAgICAgc3RydWN0IGNlcGhfZGF0
YWJ1ZiAqZGJ1ZiwgaW50IGxlbikNCj4gIHsNCj4gIAlzdHJ1Y3QgY2VwaF9vc2RfY2xpZW50ICpv
c2RjID0gJnJiZF9kZXYtPnJiZF9jbGllbnQtPmNsaWVudC0+b3NkYzsNCj4gIAlzdHJ1Y3QgY2Vw
aF9vc2RfcmVxdWVzdCAqcmVxOw0KPiAtCXN0cnVjdCBwYWdlICoqcGFnZXM7DQo+IC0JaW50IG51
bV9wYWdlcyA9IGNhbGNfcGFnZXNfZm9yKDAsIGJ1Zl9sZW4pOw0KPiAgCWludCByZXQ7DQo+ICAN
Cj4gIAlyZXEgPSBjZXBoX29zZGNfYWxsb2NfcmVxdWVzdChvc2RjLCBOVUxMLCAxLCBmYWxzZSwg
R0ZQX0tFUk5FTCk7DQo+IEBAIC00ODM5LDE1ICs0ODM2LDggQEAgc3RhdGljIGludCByYmRfb2Jq
X3JlYWRfc3luYyhzdHJ1Y3QgcmJkX2RldmljZSAqcmJkX2RldiwNCj4gIAljZXBoX29sb2NfY29w
eSgmcmVxLT5yX2Jhc2Vfb2xvYywgb2xvYyk7DQo+ICAJcmVxLT5yX2ZsYWdzID0gQ0VQSF9PU0Rf
RkxBR19SRUFEOw0KPiAgDQo+IC0JcGFnZXMgPSBjZXBoX2FsbG9jX3BhZ2VfdmVjdG9yKG51bV9w
YWdlcywgR0ZQX0tFUk5FTCk7DQo+IC0JaWYgKElTX0VSUihwYWdlcykpIHsNCj4gLQkJcmV0ID0g
UFRSX0VSUihwYWdlcyk7DQo+IC0JCWdvdG8gb3V0X3JlcTsNCj4gLQl9DQo+IC0NCj4gLQlvc2Rf
cmVxX29wX2V4dGVudF9pbml0KHJlcSwgMCwgQ0VQSF9PU0RfT1BfUkVBRCwgMCwgYnVmX2xlbiwg
MCwgMCk7DQo+IC0Jb3NkX3JlcV9vcF9leHRlbnRfb3NkX2RhdGFfcGFnZXMocmVxLCAwLCBwYWdl
cywgYnVmX2xlbiwgMCwgZmFsc2UsDQo+IC0JCQkJCSB0cnVlKTsNCj4gKwlvc2RfcmVxX29wX2V4
dGVudF9pbml0KHJlcSwgMCwgQ0VQSF9PU0RfT1BfUkVBRCwgMCwgbGVuLCAwLCAwKTsNCj4gKwlv
c2RfcmVxX29wX2V4dGVudF9vc2RfZGF0YWJ1ZihyZXEsIDAsIGRidWYpOw0KPiAgDQo+ICAJcmV0
ID0gY2VwaF9vc2RjX2FsbG9jX21lc3NhZ2VzKHJlcSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKHJl
dCkNCj4gQEAgLTQ4NTUsOSArNDg0NSw2IEBAIHN0YXRpYyBpbnQgcmJkX29ial9yZWFkX3N5bmMo
c3RydWN0IHJiZF9kZXZpY2UgKnJiZF9kZXYsDQo+ICANCj4gIAljZXBoX29zZGNfc3RhcnRfcmVx
dWVzdChvc2RjLCByZXEpOw0KPiAgCXJldCA9IGNlcGhfb3NkY193YWl0X3JlcXVlc3Qob3NkYywg
cmVxKTsNCj4gLQlpZiAocmV0ID49IDApDQo+IC0JCWNlcGhfY29weV9mcm9tX3BhZ2VfdmVjdG9y
KHBhZ2VzLCBidWYsIDAsIHJldCk7DQo+IC0NCj4gIG91dF9yZXE6DQo+ICAJY2VwaF9vc2RjX3B1
dF9yZXF1ZXN0KHJlcSk7DQo+ICAJcmV0dXJuIHJldDsNCj4gQEAgLTQ4NzIsMTIgKzQ4NTksMTgg
QEAgc3RhdGljIGludCByYmRfZGV2X3YxX2hlYWRlcl9pbmZvKHN0cnVjdCByYmRfZGV2aWNlICpy
YmRfZGV2LA0KPiAgCQkJCSAgc3RydWN0IHJiZF9pbWFnZV9oZWFkZXIgKmhlYWRlciwNCj4gIAkJ
CQkgIGJvb2wgZmlyc3RfdGltZSkNCj4gIHsNCj4gLQlzdHJ1Y3QgcmJkX2ltYWdlX2hlYWRlcl9v
bmRpc2sgKm9uZGlzayA9IE5VTEw7DQo+ICsJc3RydWN0IHJiZF9pbWFnZV9oZWFkZXJfb25kaXNr
ICpvbmRpc2s7DQo+ICsJc3RydWN0IGNlcGhfZGF0YWJ1ZiAqZGJ1ZiA9IE5VTEw7DQo+ICAJdTMy
IHNuYXBfY291bnQgPSAwOw0KPiAgCXU2NCBuYW1lc19zaXplID0gMDsNCj4gIAl1MzIgd2FudF9j
b3VudDsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICsJZGJ1ZiA9IGNlcGhfZGF0YWJ1Zl9yZXFfYWxs
b2MoMSwgc2l6ZW9mKCpvbmRpc2spLCBHRlBfS0VSTkVMKTsNCg0KSSBhbSBzbGlnaHRseSB3b3Jy
aWVkIGFib3V0IHN1Y2ggdXNpbmcgb2Ygb25kaXNrIHZhcmlhYmxlLiBXZSBoYXZlIGdhcmJhZ2Ug
YXMgYQ0KdmFsdWUgb2Ygb25kaXNrIHBvaW50ZXIgb24gdGhpcyBzdGVwIHlldC4gQW5kIHBvaW50
ZXIgZGVyZWZlcmVuY2luZyBjb3VsZCBsb29rDQpjb25mdXNpbmcgaGVyZS4gQWxzbywgcG90ZW50
aWFsbHksIGNvbXBpbGVyIGFuZCBzdGF0aWMgYW5hbHlzaXMgdG9vbHMgY291bGQNCmNvbXBsYWlu
LiBJIGRvbid0IHNlZSBhIHByb2JsZW0gaGVyZSBidXQgYW55d2F5IEkgYW0gZmVlbGluZyB3b3Jy
aWVkLiA6KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0KDQo+ICsJaWYgKCFkYnVmKQ0KPiArCQlyZXR1
cm4gLUVOT01FTTsNCj4gKwlvbmRpc2sgPSBrbWFwX2NlcGhfZGF0YWJ1Zl9wYWdlKGRidWYsIDAp
Ow0KPiArDQo+ICAJLyoNCj4gIAkgKiBUaGUgY29tcGxldGUgaGVhZGVyIHdpbGwgaW5jbHVkZSBh
biBhcnJheSBvZiBpdHMgNjQtYml0DQo+ICAJICogc25hcHNob3QgaWRzLCBmb2xsb3dlZCBieSB0
aGUgbmFtZXMgb2YgdGhvc2Ugc25hcHNob3RzIGFzDQo+IEBAIC00ODg4LDE3ICs0ODgxLDE4IEBA
IHN0YXRpYyBpbnQgcmJkX2Rldl92MV9oZWFkZXJfaW5mbyhzdHJ1Y3QgcmJkX2RldmljZSAqcmJk
X2RldiwNCj4gIAlkbyB7DQo+ICAJCXNpemVfdCBzaXplOw0KPiAgDQo+IC0JCWtmcmVlKG9uZGlz
ayk7DQo+IC0NCj4gIAkJc2l6ZSA9IHNpemVvZiAoKm9uZGlzayk7DQo+ICAJCXNpemUgKz0gc25h
cF9jb3VudCAqIHNpemVvZiAoc3RydWN0IHJiZF9pbWFnZV9zbmFwX29uZGlzayk7DQo+ICAJCXNp
emUgKz0gbmFtZXNfc2l6ZTsNCj4gLQkJb25kaXNrID0ga21hbGxvYyhzaXplLCBHRlBfS0VSTkVM
KTsNCj4gLQkJaWYgKCFvbmRpc2spDQo+IC0JCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCQly
ZXQgPSAtRU5PTUVNOw0KPiArCQlpZiAoc2l6ZSA+IGRidWYtPmxpbWl0ICYmDQo+ICsJCSAgICBj
ZXBoX2RhdGFidWZfcmVzZXJ2ZShkYnVmLCBzaXplIC0gZGJ1Zi0+bGltaXQsDQo+ICsJCQkJCSBH
RlBfS0VSTkVMKSA8IDApDQo+ICsJCQlnb3RvIG91dDsNCj4gIA0KPiAgCQlyZXQgPSByYmRfb2Jq
X3JlYWRfc3luYyhyYmRfZGV2LCAmcmJkX2Rldi0+aGVhZGVyX29pZCwNCj4gLQkJCQkJJnJiZF9k
ZXYtPmhlYWRlcl9vbG9jLCBvbmRpc2ssIHNpemUpOw0KPiArCQkJCQkmcmJkX2Rldi0+aGVhZGVy
X29sb2MsIGRidWYsIHNpemUpOw0KPiAgCQlpZiAocmV0IDwgMCkNCj4gIAkJCWdvdG8gb3V0Ow0K
PiAgCQlpZiAoKHNpemVfdClyZXQgPCBzaXplKSB7DQo+IEBAIC00OTA3LDYgKzQ5MDEsNyBAQCBz
dGF0aWMgaW50IHJiZF9kZXZfdjFfaGVhZGVyX2luZm8oc3RydWN0IHJiZF9kZXZpY2UgKnJiZF9k
ZXYsDQo+ICAJCQkJc2l6ZSwgcmV0KTsNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgCQl9DQo+ICsNCj4g
IAkJaWYgKCFyYmRfZGV2X29uZGlza192YWxpZChvbmRpc2spKSB7DQo+ICAJCQlyZXQgPSAtRU5Y
SU87DQo+ICAJCQlyYmRfd2FybihyYmRfZGV2LCAiaW52YWxpZCBoZWFkZXIiKTsNCj4gQEAgLTQ5
MjAsOCArNDkxNSw4IEBAIHN0YXRpYyBpbnQgcmJkX2Rldl92MV9oZWFkZXJfaW5mbyhzdHJ1Y3Qg
cmJkX2RldmljZSAqcmJkX2RldiwNCj4gIA0KPiAgCXJldCA9IHJiZF9oZWFkZXJfZnJvbV9kaXNr
KGhlYWRlciwgb25kaXNrLCBmaXJzdF90aW1lKTsNCj4gIG91dDoNCj4gLQlrZnJlZShvbmRpc2sp
Ow0KPiAtDQo+ICsJa3VubWFwX2xvY2FsKG9uZGlzayk7DQo+ICsJY2VwaF9kYXRhYnVmX3JlbGVh
c2UoZGJ1Zik7DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiANCj4gDQoNCg==

