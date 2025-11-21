Return-Path: <linux-fsdevel+bounces-69471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41943C7BEA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 00:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B03A3472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212118787A;
	Fri, 21 Nov 2025 23:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0OBVyoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD992FD675;
	Fri, 21 Nov 2025 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766114; cv=fail; b=D24E+ia7tQOVJ0/OzeVdBSZnBu9I/0dKb5hN81ZEvWECEWOo/gOZzhJNOGr2WWqxAIuwOn7Jwz6YQ4wmKGP336R+J5lHlT0KsLuKzOHFDomdKM1S6SIKxwxUTxMOY2zNa0oOTuzjz+FUMurM4P7yrTgjw5v1pV3NdIu2Z4CyFHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766114; c=relaxed/simple;
	bh=Lb0oPN5b7B+sQuzbMtq5ukJRQ1njcMT8sEVES6zpTR4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nui002oIYtmSVI7vMA0Qxl3ayTKks2GdQGuLAmOt4xkDbJaYL7HYaTqCddkDvnGouS17fMn6QW4ucnn3ZNS5/4e+KfKOg0q642CdmYKJMjBqCb4cMJOnjf7Jmpq3KJ8hNrSde4JCx6ZjB+v5JRPEgMvHHJAGUTKVsKRBYRgaVGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0OBVyoF; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALDf0Jq021418;
	Fri, 21 Nov 2025 23:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Lb0oPN5b7B+sQuzbMtq5ukJRQ1njcMT8sEVES6zpTR4=; b=F0OBVyoF
	HIMdDLtcYC7Rn8Yd6M3sFl+IqzLBfgb/ZmKCnWctmMQySDnbu79jB4Hos8/Vw7QC
	TyXBqioTQRusSKIV/xAZ+IcweRZK8x3OFBq/cypb8tVeNEVRzQk8qUGkR0bd03Oy
	ZXZ8au/L6tOboElIAbTiToGyfCTzq9+MEWpYHfBsZ/ftWnsx3wZylbCt1klIkZ5E
	dMRAn96kTU4JRjAD1DbfnJ1iIz8aoreY7jVO4k28y0tz0FtkaCcAAYvGscOUrJ0F
	R6UObIS6isSEubjVt7einx6q9gsJPzlpT08gUT1TkEFT+939D38//0ttrNn4Zcft
	lXNDwlDRIdqB+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjwprxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 23:01:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ALMvHSr007551;
	Fri, 21 Nov 2025 23:01:33 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjwprxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 23:01:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc/Cv+cuEbk3FkAmtyGMflBEoTnLBqN994Pcudcwq89HVsY3xlGEZaQOJdD2dfAq+RM+rUwJwwRtWUcYU3buIP13IRMO5448KVT7GG3NPs9751yreIbTTCXIjmDflhw9hI4IMHnMcTr356S5/5G/ClrxaJ1sDsbqOGF1a7TfxYquMrqwTvQt6AeNzpuXnSCtUOg5V1yXuGmWhobBRiCoT/Z/boSVGYtgHhSJk4VbGToYsozaTkve/jXxDfD71jqv/tew87c07JF9rgAZTbG5Ljx/cEeLO/ZfKGlV48hjrvvRd6hs3y2e+4gjgEiRnTvZ0ipCZe+bv3cpvOGkyMq9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb0oPN5b7B+sQuzbMtq5ukJRQ1njcMT8sEVES6zpTR4=;
 b=FuZmumcR+nP4K/ISKP/TqKroRHKyglzHBAF86qtC8+WWalAvYz1TjY6cL83T86dyCreaIMpzxuG0kjuRNZIj2VfGfBaCBRf6fTJHxeubCiKyJmB1LFvXIa1J/VtwJSY0zFBNYr/V2F1BEjNcP2e10orfpJ4u7G6J9IQe/IG6bJhp5SUCfIAF9gJMbPk34D2jfVxPTszjbXVFTqs3/r+xkGCjwL+IHEYONNYb68XWtxbgBB8YNbBTTXfJ3+npPgtCJuG7uhmhbTsWxU4QoeIuKQw+YDsP65jQwAKzmFCauy89aeaP6FudY4ubeQLqhh0JOVt3PBsz108pLD3LIborzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PR15MB6803.namprd15.prod.outlook.com (2603:10b6:8:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 23:01:31 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 23:01:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "mehdi.benhadjkhelifa@gmail.com"
	<mehdi.benhadjkhelifa@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khalid@kernel.org" <khalid@kernel.org>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index:
 AQHcWxbjI2wNRsxXGEmG7hnNwSoKY7T9oaoAgAAaLgD///OkAIAAFCeA///ybQCAABMBgP//9kwA
Date: Fri, 21 Nov 2025 23:01:30 +0000
Message-ID: <218c654fc2cad8f6acac1530d431094abb1bffbe.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <3ad2e91e-2c7f-488b-a119-51d62a6e95b8@gmail.com>
	 <8727342f9a168c7e8008178e165a5a14fa7f470d.camel@ibm.com>
	 <15d946bd-ed55-4fcc-ba35-e84f0a3a391c@gmail.com>
	 <148f1324cd2ae50059e1dcdc811cccdee667b9ae.camel@ibm.com>
	 <6ddd2fd3-5f62-4181-a505-38a5d37fa793@gmail.com>
	 <960f74ac4a4b67ebb0c1c4311302798c1a9afc53.camel@ibm.com>
	 <28fbe625-eb1b-4c7f-925c-aec4685a6cbf@gmail.com>
In-Reply-To: <28fbe625-eb1b-4c7f-925c-aec4685a6cbf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PR15MB6803:EE_
x-ms-office365-filtering-correlation-id: da17a862-64ba-4a68-d749-08de2951e8f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGpIVTFCRGFwT3Ara3EyQ0dORFozcklZZS9rdDZmakZsRTZ1Mjk3Sk5QTHRS?=
 =?utf-8?B?bmFqQ0lrMnBoOXRsMFNDa2g0aElDRFVKK21QYVczcytsNUk0ZHd5M0d0RzJC?=
 =?utf-8?B?Rmp2aGdla3M2RS93ZkJoMFk0SEFkS1htODh1MUxqdHgwSjNTR0syWnVxWEFH?=
 =?utf-8?B?anBuZG9aeGdYVm1ZNWRES2xCN2Fud0ZiR2RnaUF2MHhIc3JCR1MvKzRPQUlF?=
 =?utf-8?B?cnRxU0tSUmpZNW1ON3NVajZpU1d6aFFpRGdkakRraXpDK1YvTURlTWx3cE4v?=
 =?utf-8?B?L1QremErdXBVbUhuVTltZjhsdTgwNWlWbVpIVXFoZ3hGRDdTN3FtVW9FUXd3?=
 =?utf-8?B?R0FHTER1bzhySmNydklza2pNeS92TkZSQkI3QTRPUmhlbXBPZ20rRlRCQUpk?=
 =?utf-8?B?YXBCZjJTYjBoTzdITG1JdWNaaDUrYmV0MXVzTE1QVkZUK1h2U21UTjBqdUlG?=
 =?utf-8?B?V3MvVXhxelBFQitTdjR5MVBZbkJQTzBTZXJEdE9uRDVKd1JISTBXcGlTamNC?=
 =?utf-8?B?UWdMcThyMTNXNHdOZzRHdDFjbDJzYUhyZFJRaVZ6Wm9RZ2Nob2VQZFVXOXp0?=
 =?utf-8?B?WjAvV2dkMnVXU0pRWDZjV3AyS0M2aXdwL0lHQ1NmYm0zWEpGazNibk15Sk1m?=
 =?utf-8?B?aktDSkh6TDFiQWh5bHlTa011ZlUzMTZVLzdHNW0wZEtsb0dGN1RMeHMrQ0dN?=
 =?utf-8?B?Tlo0N0FKK1EyV0UrMGVyemRPOGVJbTNvMmhGbGp1Y2NqQ3ptZEl3VnFTYmlZ?=
 =?utf-8?B?cE1VVERxQ1BPdlNuUXk4WWlYZlh6Mys5bDZ5QTQvSmZlVStEMHVhV2hDM2dy?=
 =?utf-8?B?bVQ4Vk1zQWpMRjF6dlhmZGNKTi83bjhFUlE4ZTJxWElLSUFISVkxajJBcHhm?=
 =?utf-8?B?VHh1ZFI1SUxDSjBXeGFrL04yUER0d1NYUlYxNzVRZVlWOVZ5TXVQS3V4cXZq?=
 =?utf-8?B?Sm1lZHdEWWVTcG8vVUtoOVYvZDVNZHdEaHhqU2pnQzJxVHJ4K3hvUTd3UXhV?=
 =?utf-8?B?YlRjaFNMSk80TExQYWhUa2ZWN2h0MDZ0cHRzWDlyWU5CVUpDenhCbmU3aGVt?=
 =?utf-8?B?cHpPM2VwWjBoYmdUdDFyUDhNU1ZaZzkzWDE3TzQ3Rk5naDFCQkhoVys0cFZr?=
 =?utf-8?B?cDBJWnNvQWZrR2FXZ3pGYXZxejNuUldwL3pPY1k2aXdiY0FLdW43S01xRGc5?=
 =?utf-8?B?UXhXTmowOU9NWUZoc0JSVmFkM2Z2OE9nMkg1M1liVHdDSHU5WlpoK1IxN0N4?=
 =?utf-8?B?VFRnMlFlKzJzbEgvOXkwcXh4ZXRjWnBLNUtYdHBKMU42bGt6eG9wVUd0V1I0?=
 =?utf-8?B?NGdtTHgzM0M3akU5Wkx2WE55aE4zS0xNdzg5L1AvQU9wa2RFTFNFNTQvWkFr?=
 =?utf-8?B?alppRlVFbVJmemNBMFQxMG8xZFlBeHlZMnhYMDlhbFRUVnRuMDZ5MXhrV3VL?=
 =?utf-8?B?WkFjMmhsUXh0TG9BdE4yQmJ3bzdFTkFjZExVYzBjTG5xR0xXTHI0WnJZTVA4?=
 =?utf-8?B?bDVuMVN6RC9xODZKa2xPU2d4WHpkajMrd2lybGxlUk9KZW9qVXA3L3dYZS94?=
 =?utf-8?B?QkptVTRFM21CSkRlZUpMdnNxSFNwSXVvZTR3ckpLWmN6VWhpSkMwallnTTFH?=
 =?utf-8?B?RmFSeUlmYkxTQTVIYWh2Rm9LUTNZbDduUUZDQVZJSDB0VGdiRnN5MTlXeEFQ?=
 =?utf-8?B?MVJZL2llWStkUVA4Ym1mUGJuQlBBODJMaEhrRnJyR1ZzQjVzSy9ZRG1jYnJQ?=
 =?utf-8?B?ZzlGVjd1WUF0YzdvREw2R08xeGUvUnZPK3pzS1ZZcUgwTzVZKzQ4ZlFlM2o5?=
 =?utf-8?B?QytXR2pBRlM4OHJCQW82SUxGS0hNd2lvdkl4ZDN3Wi9HY3NkYkh1dGJtYUNV?=
 =?utf-8?B?L2FBMDU5L3FMQ1Qrc0dlNEIzWFYrSzU5WUlWSFA5U3dvTVBBeGRxZmt0ZHQ5?=
 =?utf-8?B?QkYyUlVUMjUrRVdONzR5MnVoL2VHZ05SOVMzZ2RoU1ljc09HT0gzS0ZDc1JZ?=
 =?utf-8?B?bzlieGVjR0F2MVlxWndaMnZNd3pUTlYvOGtMTlVqOEU2VzRNVjBmcXE0T3BE?=
 =?utf-8?Q?hk/mJZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clpIWjdKMERaMzZVN3hCR1czMUl0TUNJanFhbTZ5OWlwaWJhRmp5amhORlVD?=
 =?utf-8?B?aTV1TDIxckVGUlRyWXFWVy9ML2xUQTZlcW91bWlYNHNQclJUVlphYjA4aE1H?=
 =?utf-8?B?QlNmUk1qTjI1VWVwamcxQjRjQzQwZmlib2hrVTZuV1cwNStxaGs3TkxFYmRR?=
 =?utf-8?B?WnNvOWhzT2ZyOVpJcGRqblJkeStQL0RncE1aWElwQkVCaTdXa1JSakJxMW5P?=
 =?utf-8?B?WEgrTnpNckE4THFiS21KazNnODlGU1k2djJ2VW1JZkZaTzhIRU8rQnBjVEZh?=
 =?utf-8?B?RnowN0NhZzB3aW9DWHJOS0I0WitLQk5IV2dpSFBmVTFtVkJQZ1Erc3JocG56?=
 =?utf-8?B?UG5lSHR5TFVUeERqSTNRVjZIdENybzBYbXhvaHV1VkxWVlRmUnNrWm5KYmJu?=
 =?utf-8?B?aUVldElyby8rYm9icGdpNUZSdU5OUWxkZUxrWkp2SktPakpFZXlzeklLaE1W?=
 =?utf-8?B?emU4TWdqbEU2RFNOOVh1bGVsSWVkd3NLd2VJSUZSNDlxR1BCQlA2ZHRtVFBm?=
 =?utf-8?B?SFovTnc1eU9hQkxwMWNHcklDNU1vWGxwVG1QN3Q4VHdsVWJDOGJ1TlM0dkda?=
 =?utf-8?B?U2VKRFBOcWhjRER0V2pnWmFaVHR4OVJFcnhWYTBLV0kyMTBpbk5pMm9haEh2?=
 =?utf-8?B?T043UlNKaGFZclFvbWQ0cytSOWYrc2RkOG5tN2hVd3ArdlhMM01BU0tIcS8z?=
 =?utf-8?B?c0NyeXlRRHc1VW95SUt6THVhc0huQ2NoR1l4azBtN1hjV1VJSE51a1Z3S0RS?=
 =?utf-8?B?MjlaZ054VGtsOWtUcG5XekRZMS9Xd0l2OElqb0pEYkNnUUNBaWxSbzRpVTVh?=
 =?utf-8?B?MHpuUlRhOFo1Rm9qVlVTNWhvSEEvWVN0WFdGQ0hLNVB4VHREWldySTFQRGxM?=
 =?utf-8?B?VEdLZnprdHpNTGVrYkZzelJNYjRWb2N2R0VEQjZETjBWejhLM0ErWUpHNzI2?=
 =?utf-8?B?QlhTcFJ6OVd4VDM1dzFtVEZqcm5ScXhvYjNOc28zczdRQmlwRFJ1SjAzWFFu?=
 =?utf-8?B?bllETVVYa3VVMFROTVVUUWRTRW9XSW5wQkxhV0syU2pvTWc0ckUvL04wcW5M?=
 =?utf-8?B?UXBxNGRid2YvOG1BZXdTL29JQnFQdUJJSE5OZjd0akdhVE1tRTZBNGFYWTIx?=
 =?utf-8?B?VTdTU3NERm9iWlpNVStjUml6QzZMS2RZK1h6RGNNb1VlMVBNMXM3UzRTVGlV?=
 =?utf-8?B?SEl5MEZ0TUpLcFE1M2xsRC9JRE9pcEltVzVkUDlFVDZDcnhjblNqcnprclp5?=
 =?utf-8?B?ejJwenRvZ1B2SExsRytiT0MySnJZSFlvWkFoMzRQcDJSUzVzUzdXclJJMjAw?=
 =?utf-8?B?ZE9YQUxtWVY0b2pXSGsyL1FqM21xNHh1Y0ZpdGxPL0VhcTJKQ3lxU01GNjhP?=
 =?utf-8?B?U3RleTJ2U2xCaHdwSVk3UmxnRnBuMSswaVpzUlRPb1VLTTN4UTVtaEloN3ph?=
 =?utf-8?B?eHZSeFVxUi9xVXUxUE1peTdHSVRHZ2toSHAveExSalRDZ0xUQXhDT1RLUjdy?=
 =?utf-8?B?RFZUNGl2KzduL1Q4MDlyMTM0dHQ3dythQ05iWXBERW9LMGE0cVh1SEYzcnRT?=
 =?utf-8?B?OGhOck4zQ3E4S3lJbTQ3Q3I5TTYvZEdxZFQwTklaUmtmTkh4c0k2Wk5EWWd3?=
 =?utf-8?B?SGIyaHNuRGFXYUNCRm1xL0lteVUyODR5TjVJVWV4THdMdXdTNGxTQjREYTlR?=
 =?utf-8?B?T3J3M2pmNUFFcUkrMVJlNFYwbXNZTkNqUG1icm52SWJmNG1xS1ZXVzZSMThq?=
 =?utf-8?B?MURLZmZ3clhHWEFlclNRNEM1a2drSERTQytMOWdBclAzVktRNHNZdzdUaGZN?=
 =?utf-8?B?RHA4Sk91eUo3OVdrZmRoSkhhK3lUNEhvUHVwNGFTcW5uWU5ISWU0VEFrUy9L?=
 =?utf-8?B?MW1qanhWZEJEREpIdXgyOTFGRlJpR2JxT3UvNEFZUmR4UjlPaXVQbVVsK2dt?=
 =?utf-8?B?TVJjNkVBQWZsbXRFbnhsQjJuOHg0djRCeDc3REJoaS9HMWpvODkzZkFuNWl3?=
 =?utf-8?B?dmRuQ2R2aVVmZXYwcVlUeTExdk1sTG9JZWkrS3Y2VGFrTzRYZTROTHJVWVQ3?=
 =?utf-8?B?ZzBPS2tJbnNCRTFtWXVZcE4xaGRDYXgvUHVJUGE4dnhpRSs0OGNteXRWSnQ3?=
 =?utf-8?B?WmdoQlZJVDJCN2JLbERYVzI2Zmt6dHZjZGN4OGJpQUtwdW4xL0t2bzVaay9p?=
 =?utf-8?Q?VIvnmNhu/kIzg6PQSzzcf4E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36823BE37A2F5C46A5F1AFB09B93109B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da17a862-64ba-4a68-d749-08de2951e8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 23:01:31.0030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsnXRRenCCPNZet5kIviOAB5G8aBblwqVaV1kwn8DGG5w5zt65z5J96MTKNZX7Fl1kuWxewY6Slig/eqQvtnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR15MB6803
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=6920ef4d cx=c_pps
 a=2d9FbaPwie0YXhWIRYJR4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=nMilORBeCPqrheDVUeUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX11lIlIZgEg/m
 fEvoXGGwDWG+12FPJaG8AkPLDgwUBCzc555WUiF9abi/Rw08+cv98iM6xgGUt7lFkZcqoq/0NS9
 ZOMssSveEXjDDFFCEzhpcK8Aozand+ltf5IVapTA6vMdzQtKtJhM9f6t9rigF7lIsjxFxTiBXGN
 /y774t1kVgQ82Nx8Gmkmrsd9FpXdjOg5Vd6GrsHIgHMnuW6H9LOn9w2hKA8gE6NYmi2ZlkP/Wj8
 pHmAFpsWPP44Ikv5Jmf28okAcQnpYsXoVw2T/+G06HRJufmd+fLgO2YI+QRdaYL75Idu4fuMv2G
 gFfjnXf8ulaMc0TDDYssF4KdicNBIMx6XIK/x0tpoPpgm8LR9k0+J38fwGhl7pYgQphMmB08Wsp
 ReW6cknXzgXnGmL9B6dxFRTXt+CB9w==
X-Proofpoint-GUID: mgijKdRYCvKuQyVsCCbi0cR4ZN4fNWOf
X-Proofpoint-ORIG-GUID: pWxVrjEeWQO5LAa5VDlIKi8JMgMmCjji
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_07,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

T24gU2F0LCAyMDI1LTExLTIyIGF0IDAwOjM2ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZh
IHdyb3RlOg0KPiBPbiAxMS8yMS8yNSAxMToyOCBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3Rl
Og0KPiA+IE9uIFNhdCwgMjAyNS0xMS0yMiBhdCAwMDoxNiArMDEwMCwgTWVoZGkgQmVuIEhhZGog
S2hlbGlmYSB3cm90ZToNCj4gPiA+IE9uIDExLzIxLzI1IDExOjA0IFBNLCBWaWFjaGVzbGF2IER1
YmV5a28gd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgMjAyNS0xMS0yMSBhdCAyMzo0OCArMDEwMCwg
TWVoZGkgQmVuIEhhZGogS2hlbGlmYSB3cm90ZToNCj4gPiA+ID4gPiBPbiAxMS8yMS8yNSAxMDox
NSBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gRnJpLCAyMDI1
LTExLTIxIGF0IDIwOjQ0ICswMTAwLCBNZWhkaSBCZW4gSGFkaiBLaGVsaWZhIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiBPbiAxMS8xOS8yNSA4OjU4IFBNLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6
DQo+ID4gPiA+ID4gPiA+ID4gT24gV2VkLCAyMDI1LTExLTE5IGF0IDA4OjM4ICswMTAwLCBNZWhk
aSBCZW4gSGFkaiBLaGVsaWZhIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gDQoNCjxza2lwcGVk
Pg0KDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiBJSVVDLCBoZnNfbWRiX3B1dCgpIGlzbid0IGNh
bGxlZCBpbiB0aGUgY2FzZSBvZiBoZnNfa2lsbF9zdXBlcigpIGluDQo+ID4gPiA+ID4gY2hyaXN0
aWFuJ3MgcGF0Y2ggYmVjYXVzZSBmaWxsX3N1cGVyKCkgKGZvciB0aGUgZWFjaCBzcGVjaWZpYw0K
PiA+ID4gPiA+IGZpbGVzeXN0ZW0pIGlzIHJlc3BvbnNpYmxlIGZvciBjbGVhbmluZyB1cCB0aGUg
c3VwZXJibG9jayBpbiBjYXNlIG9mDQo+ID4gPiA+ID4gZmFpbHVyZSBhbmQgeW91IGNhbiByZWZl
cmVuY2UgY2hyaXN0aWFuJ3MgcGF0Y2hbMV0gd2hpY2ggaGUgZXhwbGFpbmVkDQo+ID4gPiA+ID4g
dGhlIHJlYXNvbmluZyBmb3IgaGVyZVsyXS5BbmQgaW4gdGhlIGVycm9yIHBhdGggdGhlIHdlIGFy
ZSB0cnlpbmcgdG8NCj4gPiA+ID4gPiBmaXgsIGZpbGxfc3VwZXIoKSBpc24ndCBldmVuIGNhbGxl
ZCB5ZXQuIFNvIHN1Y2ggcG9pbnRlcnMgc2hvdWxkbid0IGJlDQo+ID4gPiA+ID4gcG9pbnRpbmcg
dG8gYW55dGhpbmcgYWxsb2NhdGVkIHlldCBoZW5jZSBvbmx5IGZyZWVpbmcgdGhlIHBvaW50ZXIg
dG8gdGhlDQo+ID4gPiA+ID4gc2JfaW5mbyBoZXJlIGlzIHN1ZmZpY2llbnQgSSB0aGluay4NCj4g
PiANCj4gPiBJIHdhcyBjb25mdXNlZCB0aGF0IHlvdXIgY29kZSB3aXRoIGhmc19tZGJfcHV0KCkg
aXMgc3RpbGwgaW4gdGhpcyBlbWFpbC4gU28sDQo+ID4geWVzLCBoZnNfZmlsbF9zdXBlcigpL2hm
c3BsdXNfZmlsbF9zdXBlcigpIHRyeSB0byBmcmVlIHRoZSBtZW1vcnkgaW4gdGhlIGNhc2Ugb2YN
Cj4gPiBmYWlsdXJlLiBJdCBtZWFucyB0aGF0IGlmIHNvbWV0aGluZyB3YXNuJ3QgYmVlbiBmcmVl
ZCwgdGhlbiBpdCB3aWxsIGJlIGlzc3VlIGluDQo+ID4gdGhlc2UgbWV0aG9kcy4gVGhlbiwgSSBk
b24ndCBzZWUgd2hhdCBzaG91bGQgZWxzZSBuZWVkIHRvIGJlIGFkZGVkIGhlcmUuIFNvbWUNCj4g
PiBmaWxlIHN5c3RlbXMgZG8gc2ItPnNfZnNfaW5mbyA9IE5VTEwuIEJ1dCBhYnNlbmNlIG9mIHRo
aXMgc3RhdGVtZW50IGlzIG5vdA0KPiA+IGNyaXRpY2FsLCBmcm9tIG15IHBvaW50IG9mIHZpZXcu
DQo+ID4gDQo+IFRoYW5rcyBmb3IgdGhlIGlucHV0LiBJIHdpbGwgYmUgc2VuZGluZyB0aGUgc2Ft
ZSBtZW50aW9ubmVkIHBhdGNoIGFmdGVyIA0KPiBkb2luZyB0ZXN0aW5nIGZvciBpdCBhbmQgYWxz
byBhZnRlciBmaW5pc2hpbmcgbXkgdGVzdGluZyBmb3IgdGhlIGhmcyANCj4gcGF0Y2ggdG9vLg0K
PiA+IA0KDQpJIGFtIGd1ZXNzaW5nLi4uIFNob3VsZCB3ZSBjb25zaWRlciB0byBpbnRyb2R1Y2Ug
c29tZSB4ZnN0ZXN0LCBzZWxmLXRlc3QsIG9yDQp1bml0LXRlc3QgdG8gZGV0ZWN0IHRoaXMgaXNz
dWUgaW4gYWxsIExpbnV4J3MgZmlsZSBzeXN0ZW1zIGZhbWlseT8NCg0KVGhhbmtzLA0KU2xhdmEu
DQo=

