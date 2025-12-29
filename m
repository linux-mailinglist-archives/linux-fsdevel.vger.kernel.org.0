Return-Path: <linux-fsdevel+bounces-72216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B4CE8483
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 23:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CBD2302A136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B793101A5;
	Mon, 29 Dec 2025 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bskP1UTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158126ED3A
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767047083; cv=fail; b=bfVcbXQBxDtP4TxRGWCV03f4ufixtYOSwckCpFk72XRVgVtuV4gTrfYUMKRYVpctgMBnlgT0eQQCE67azze6lcEY1KnZRgF/IN4k2Xn1GtKu6StCriG7/ayJ3+YUTUDUxOpVU6c3CZ9jtrWM+dEYScSH+SSQ5+8G4EM+aUmE4Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767047083; c=relaxed/simple;
	bh=mcFCE9OEp4xXBa789YHlcg7JX1epeR7ZozG72Em9vcU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=q5pxByAvzKylEiD871ToFFCQLiJ96rdJRSXVlDIUjGpBNOnvcv1M0Kl0inQn16M8owVeVVOqz8+IwtNsmqH1U9ZX7hGou9VlTwUgcIRvT7rUh361XzvoBpaYkfSnSDincqTCFPar4W6Z8ocnRAesdFZEoKmVXWmOLeYgiXm6j1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bskP1UTN; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTAMr1l012384
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 22:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YVI1eIUwEQL5/J1yoRcWt6vz0EOGqdFKZ/iIpQGlfGA=; b=bskP1UTN
	eOWjCurvi9//FXKN95yXWS9tnGi1FTAAk+D2Q6+PbAl66eyaYcFjh+vo3dTs3ZsB
	Csifnv7WkJgHqrTp9zO0g1hYdd3+94QTbu/cmnneUu+L921hxmcbiHvt6uN5kbhb
	RK8r45PsAKAPQFBo9v/KDO4ZxVek3R7OdNHjKJj+IaEo1FRJcr+kxH7TQydKuQrZ
	VvXOEhZKWJabU/1QWhFPPNBTeVDOrM4rsBdfmdAcSBLawYLMF1Qxwf4qdvNZVqUQ
	nxLS+0lCDFCEcA8bzIuJ8AuwBXLKz873N5ZgQfLefHbBeupsXvkzt+jzfkqD1gGJ
	PVozVUy9iPZt3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba4vjrd1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 22:24:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BTMOdV2023966
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 22:24:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba4vjrd14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 22:24:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BTMMdDN021423;
	Mon, 29 Dec 2025 22:24:38 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba4vjrd12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 22:24:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmhSAzXNK8s+FSkGaKgi6NzvptFq9c+FNP7ne/UDPHMBoBmqHaUrj+/uewoL3fFu823DzolYEpCUq9cb3yI61olJ758Lq+chfHnYMZzYLUK2RbFFA4esYRG2TDPnesbDsq2Gr274PAKEq81tYIjrcNZTAqqH90GIDFAxe0EHSBnAu27WAO5dm6ryNPTVgrqoTbJLelG26gxKAWVhq4BtX1gjHnmm3hmz86edDvxcGuBr2L3xfRZbjCjoZJQAmPWeEQacNEdUGzuFiwLE3bxPKNz3UBd6w9jMPOJFbb0XBtRsdef9JKR6WtHzk5Pz5vykOcmm89R4+y7XJVPMiH+ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWm0XDWP+gsgYtmvwvxlhcmdiwe3bmBUnAjaTIMb1mc=;
 b=GCKoxxERqO+xQh1beyfrRbH62tpyimnNCrDqeP4cUUsIy/+uPagPdoSrUsGjgYco3Mj5f0I0NeBGwfxvidyPpHSNEmygegf7f4UNCauAnXM1sg4S3zRnCjZFTazfQFw1U9D70B0+cxga+0QipU5LoK3xWg2g+QfmjbHs2M8dbbQDfPsCm04fR/snIRQK9eBEW7A+tqrVCZ64aMliTR1Zu3sbNPBlarrzzekTzcEYK5DqlWlKaEaPZRHuKPNX1YnCupqB5Sa1nuGinpvZMCb0uFur2zOO6yrQI0HQVznoLa+ny5KoHb0S4N8NG7LWfEt0rHqCIhkYaiq4GykI+d1y+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4933.namprd15.prod.outlook.com (2603:10b6:806:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 22:24:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 22:24:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "zippel@linux-m68k.org" <zippel@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "akpm@osdl.org" <akpm@osdl.org>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v3] hfsplus: return error when node already
 exists in hfs_bnode_create
Thread-Index: AQHceQTDpHjGilcLBU2iiCIAlN6+prU5MccA
Date: Mon, 29 Dec 2025 22:24:35 +0000
Message-ID: <08e7f7ef7da57448945a8d62160d2d7a67df2883.camel@ibm.com>
References: <20251229204938.1907089-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20251229204938.1907089-1-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4933:EE_
x-ms-office365-filtering-correlation-id: 101d6969-a51a-4223-318d-08de47290bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NCtjQVdrSHpwUWVPb3ZRbHYwd3N6UTdXeE9VNHZlYm8yeWVidFltMTM3NzQ4?=
 =?utf-8?B?UE5ENm1aUnBaczlFVGJQOFJXTHIwVnBEbzhET2tUQStNd0pNSW9PUWwwV2ZV?=
 =?utf-8?B?YTFKTXBsVk9WUkF3emR4OFlPTmlqOE9sRXJMVVY4MTFycUpDd1lheE0wMGFh?=
 =?utf-8?B?Z2RwSHZXSTdsTk5YVXl3VlRkRitIRGEyVEY4ekdUREt6NkZ6RFdmUlQ2UUlt?=
 =?utf-8?B?YmNPOFpsOG9KbHFmK0RHT2J0R1hlSkRZMGtnSFkxeWhHdk5EanJMRGplL0ZM?=
 =?utf-8?B?ZXA1K29sanQvRWJmeWZMT2twdFI4MCtiL3JZSHAvWWpwYXJwbTRVTDh1enZW?=
 =?utf-8?B?cDVZU1JqaEIvWXJueXZ1QUFPNlN4Y1Z3YW9UbDkwV2VkYkJaWERxblpFMWYw?=
 =?utf-8?B?dXQzeUVuUUhPYWRlak4yVkhQSXJrL0lEZFJ2RHZBcVFKRjNqNE9aR1BrYmNP?=
 =?utf-8?B?bU5MTnVKRjA4QWxNNitlWG9hSmxITGxMTlBVckEvbnZZZU8zQnVJMjl0MkVz?=
 =?utf-8?B?MHhOUlhpUm5DT09iRjQzSnhpNDFCZUJVMEd2S0srMUlmQTJIQ0VyaHNCNzNW?=
 =?utf-8?B?OUdGeWt0VHdtRStsazd4TUFBRkgzY2ZmL040UXVwZnVwZjEwZzFxMjhoYk0x?=
 =?utf-8?B?VWhhZ0JRaUtpK2FrUlJQRE4zb2w3UThzblJ0M2hKaHh6amE2Qk8xSlUza1Ri?=
 =?utf-8?B?VVVqQ0JhbVZuRmpDc25zeFRRazJoWmFVbVF1WG5ZcDFVdlhWS3FuVmxVSTdH?=
 =?utf-8?B?K29BZCs3ZUQ5d3FzQVBOdk1WdFVGcnI1TElaRXRzUVYxcDNZN0tMd0xXblda?=
 =?utf-8?B?dHVvZkt3b2JmL3FrV2FMZ1hPKzBqOXh4RFV1QUhyNmNGUUloQllIanhYNnh5?=
 =?utf-8?B?NlNPNmRkMEZSSkZkK2RubzdlcHFkRXVhazVhK092Smt0Vm9LdzRDVFczMUZC?=
 =?utf-8?B?MHN2eVBScDJVRVBMbDk4UFdqT01sQXo0dkhyZmlzZ1hkM2k1VkpHMllzVmZC?=
 =?utf-8?B?TVdwajdZd21QNy9mVXFIZXVzeFYveXdTMkNBd01vQ1RwVnlxbWt4amtUeENh?=
 =?utf-8?B?RkUyUDg0NTJPSTBsMzQ4Mno0dDlPakx1bDBqcGdQdVBXNTNKU042cytwdW9G?=
 =?utf-8?B?M255aUZjMmxXQXdCcml2ZWZtaXBJVFdhSVJQWldaclF3RStaK3pHcHNETnhZ?=
 =?utf-8?B?TVE5dFhyUmVzZnRRdFFUcS84eEZTV1lvUVJQeUZqTjB0T0N4QzdiNDZiaHl6?=
 =?utf-8?B?UEpSaS81cnV3V2VtQU1XSm5VelBtMGdsNy9Tcy9xOVdsRldyUTNBNmI5ZUFZ?=
 =?utf-8?B?ZTM3SzY0V05XUnprN3R6ak5qamdvdE14WXluZGtrWXlTTWw2R0c3dWtWLzF6?=
 =?utf-8?B?TkVVV1dDbFlraHBlTDZIR1p2NU84MVpyblBOUldjV3NBMjNleVZnME4yUVFU?=
 =?utf-8?B?N0g0aTd4ZlZhZm16TEx0K3JDb1ZoNmJhbmxOY1M1MzlUdnFJL0dPanh2WEho?=
 =?utf-8?B?OW5WS2cxRVA2dkRGYWtobTlCQnU2TE5sSzFBNFZoQmRMTFdtQU52QndjaE9M?=
 =?utf-8?B?MGZxYkJmOFJwSFphSnBrYkJ6NElVT201dVVzazV6a0xCZFAzaERZc29ydVJl?=
 =?utf-8?B?ZGlHblpWN05mTjdsanhMSmNUbHpsaEdoTS92VERRYkV6eExKSDl4R3A5VHVE?=
 =?utf-8?B?RG9ySXZSbWozL0pNcUJYeUduMXdJbVZ0aVQ0b2p2NmFJYnlhU0pFSXcrSjVn?=
 =?utf-8?B?QzhsWjZWTVdMWFpUUzJJOEFFcDVQMjZrUDBIb0taVFYrLzNBZEEwc1V4N0gx?=
 =?utf-8?B?bm5xZDJwdktia2FwOVlLekVjWFJYMEV0RUxYdHlOZHVqNndsRlQxZ2tLRVhU?=
 =?utf-8?B?aDlLa0t5OHpsVUE2aWRubGJjTi9LR0UvNlQ2ZmJRNjJOK3pPK2N5OVZIalN1?=
 =?utf-8?B?MzR5Z1pzc0ZpTVJpWFVvcEcvR3J5bDBnRDFmOHdXcWlaN2R1UkJWTmQ2YnhG?=
 =?utf-8?B?WThad3JxVC9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW9Ec3MvNTREbFlQd25LUFM5S1IzK2J4b1pkMXhNV0VCYStXdUQyd0I3SW9s?=
 =?utf-8?B?cERjR3I0WE1TemdYS1pkMUtKSmt5c2wxT0N3bGRXeGtVNEhiSmNNOVhvalBU?=
 =?utf-8?B?WEk5VGJ6VVBsYjZkRmFVWEMwVm5oenVLRGRjZW5CVkxBSmpqQllXd1dnT1hG?=
 =?utf-8?B?WEtEeG1sQ0RZM3lRZHM2Yk5pdXJoNkNXTFRBWWtRMG5NRzBybmkyeUVURGpi?=
 =?utf-8?B?ajRycUdySHlULzBOWVI0elpSUjFPMjlkL0tTekRlRzJMR2FRblhPSTFjYmVH?=
 =?utf-8?B?VnBoSEJ4eG9mSURFcVRaa3hWeXhFYWtJbCs4QXNCSmZmdnJMcDg3NGxkT0t2?=
 =?utf-8?B?RWlhUUdnL1dsU3NuakpBYlhTSWxOL0Z6c1hRdnVDak1vUUI5d3JWRnNGVE1l?=
 =?utf-8?B?U1kwcG5Hc3hjWkY2MzQvRlZ1aGpRTXprOWs1T2tzczBBNnlxVzh6UVdBZXU3?=
 =?utf-8?B?QkJMSFNDMzNBZm9uNTdZMnlhYVYybEMvd3pzWGNFMFAvelVwR3hiU0RWMWdQ?=
 =?utf-8?B?REs4WHQvUHIxelRDYVo0YVgzTCt0dzhpVllDTnVVYmVtNFdPd0VqMXpvZ085?=
 =?utf-8?B?TXlobGhKcE5oOWJGVGp3VXdFZmtwekpydlRtN2JuVUI0bEszNi9iWkdsMDVx?=
 =?utf-8?B?MGFNcFl6bzlNdkt3aFhTMjFDU2d5a3RaM2lrZDgvYm9Xd2RKV0xLWnkzdXoy?=
 =?utf-8?B?V0JYTy9hY0JKZkJDK3hzeVBkSEE3UjBNcENzSy9YYUJVdnVxM2lGajQxQjlO?=
 =?utf-8?B?WEpCZ0FNTWRkZGJJbm96ci9ZVURZWmlHV0ZXUkZhVk5FT3ZVV01qQzlnQWk3?=
 =?utf-8?B?L2ZjTlBvV002MnNyZ0ZWcWV3VkRJcFBYeE1TenczWHA3SnZYaHZXeHQ1N2Ro?=
 =?utf-8?B?V3FqOWQzUTQ5REw5eDk1WlgrbUFRVjUwL1RER25rU1dpcFhoSlQ4ME03M0tH?=
 =?utf-8?B?SDNuY2hvOHQvSTgwV2c5S0g2TXNSVmZuaXgwTEJwTUF4cnd6RHlZVm9xbWEy?=
 =?utf-8?B?RGh5WmUxSXFkYU5obU1IWTljNWI2ajNIRFF6cVJZMEthT3VpUERNL2ROdjQr?=
 =?utf-8?B?NWtQWE1QSzIxajRRT3pZb1RtN0pmSGxKN3JVRDFkMmplcWlKVStac1J4TExw?=
 =?utf-8?B?cHo0MzlRa0FrQ3hTT0dQSWFvK0pqMXBGbWd5cVdJMDlqQWpjOTdlTnVFeTN4?=
 =?utf-8?B?Y1F2RnV6UVpEVkFRaFZaTjFFUTBFSW9qZmZpYUc5SDgydEdZVW5wS0VKQ1lJ?=
 =?utf-8?B?Z1pmUkRiZ1lzZ2ZKdzVkbTNXR2hIa2FhL2RtWGJLS1lFVFRwUUZISUNvUnhk?=
 =?utf-8?B?VGlZQVdvQ2JZTGF1OVh0MEpUWjlQSnRQQ3RSMGpWZjk0ZGcyaGVOUHc0OGVB?=
 =?utf-8?B?K05GR0NOT21CTWQ4RlgwTEJDeFRvRmJpNEtudDZ3bVRYUFFWb0I2Q25BWTEz?=
 =?utf-8?B?Z2dPUXFjakZsNERValN1cnBRSUcvS2p3UFp1VVlBZlNoMXk0RzYyT1NSdU1F?=
 =?utf-8?B?R1pxTk9tdG95dExPSVRaenhia1pZbWE5WHJsYndhdXVaS1puOE9rdlNlQlJK?=
 =?utf-8?B?bVJsbHB5L2FLV2QvcDdSR3g0TmdGSE5IRFNvV2ZreWtxcm5LWXk4c3JNUjF6?=
 =?utf-8?B?RU1Ra1ZMSUZCaW12alhDRUZueVlSSXI4cmY0QXdBOFF4M3pmSlF2UHVnOTRr?=
 =?utf-8?B?TVhDcEFGdWlmOEJ6S1VQeGhWN3Z6bk9zdEpPMWphcm1JOFFJMXBTWE1QZkZL?=
 =?utf-8?B?SU1wd3UrVlBOYlNjQmxSVGRxQnJ5N3JncGpPNURuNjRnUlVSNVlKQ1NkTGtP?=
 =?utf-8?B?cEkvVE50QnFtQ0F3WTVESnZkVlk5enF4ZUtqMDlvbURUdHcvUkw5TEJPSjI0?=
 =?utf-8?B?REZuYVVCclJBUkw3NkZPVUV6SGlNMU9ITmZCcmZJL1FGRG5mdjFDQ2ZmTW53?=
 =?utf-8?B?YmdDaTVneWdsOG1tVjdYUmg5blo2UWZzbHJ1RnE1VEcxdElvMnczanYrMC9K?=
 =?utf-8?B?Sm9kZG44dHZhZDREWHYzWXVLbzlUTFMzRnJ3ZjdiS3ZEeTFKNkc4cktDR0I5?=
 =?utf-8?B?dmlzYXAzbzNrU0E1WmxqbWxBSHpDZk5QRzFxc1BTVlJmNHpRVGlqTHB2eGl1?=
 =?utf-8?B?L2loMTdLeDF2RmpKTDM2SWR0dSt4UWJrZXJiZlg4N1drOXJmSUFaNWh5ai9h?=
 =?utf-8?B?aEh6cFgzeG1MVU91dmFEcnY4YnRrNnJyUUFWdXNxcEZCMWxGY3N5NHBMeE5o?=
 =?utf-8?B?Zy9DREllcEVwV1JRbnR6b2FPWlZBQ2ZBYkFWekM0UElvR3oxMnVhdGduK1ZG?=
 =?utf-8?B?MDJhcngrdGpwZCswa05mZ3FkRjhoUWN3Qk9GbXVnblpkeXRLUmtzWkJ0bEcy?=
 =?utf-8?Q?BGu8yE7McDCyHr2FmXyiZmPy5fx2Olc4jeecV?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101d6969-a51a-4223-318d-08de47290bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 22:24:35.0677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kF2Iw+hF1m3yw2nrdf7cXMWHPqoyVvDcHz+eq6wxvmZf3n/Pmi5HLygUH+Me+7hXuwFchBJwA1NtvIgzLFDO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4933
X-Authority-Analysis: v=2.4 cv=I7tohdgg c=1 sm=1 tr=0 ts=6952ffa7 cx=c_pps
 a=uRIsUzfalb69z9iYDTnHFQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=hSkVLCK3AAAA:8 a=szKgq9aCAAAA:8 a=wCmvBT1CAAAA:8
 a=tCdeOEpEljQ1jJ2MvSsA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=R_ZFHMB_yizOUweVQPrY:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: -XRXSaUxctNDd6CcFjbhGMHaUi7Lhz0k
X-Proofpoint-GUID: oq4CR6tnJsNMqJT5UIgub3UgFNrg0RfX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIwNSBTYWx0ZWRfX4Hom+SgdyNkb
 ebEtLBzrUFO/kEbSsD9AAqFkGmdz9Rkp7TRRrc2y5zJ3baHi34njVPucAfmv7vwA9ZLKoV1G1+O
 iwozkAeFV+sqDPozql07fqHZ+1s4ud49OBtdiqmsxzB5vQ5VjBbWBpTEcrZ0SjZ1A6uoH42ntcx
 KM4UJooxOGJ8J65C02DMXKBAIn/PDM2EnlY3qJDlu2LVI5bbL1uHVt9uD4FCtD+xIyc6UXoFpsi
 af9Y+mOlccmYCyVJJqbZIMajUjiWmfFtWNy5qgrogYYheH5PfuPWSBA/BBck7RF+ySxL2Jp/TXg
 +KeI0Bl3cxEajECNFzsuyvCNzMVksBv4PS3ScYffp/7Pn/vzo2OnXFTrRnuv67EK0jiTMI6WVcG
 UEO4zcrA0D5YVCZ4MArkhx86GR2titEpUWFxJH0IYkhp5sm5BwdY/tyVr7eD6CnTa/mzFjGuSoD
 VNPax7Ma6lMVMH5m06A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <13D99CA5FBF2534DB4E3E9CD426C51D7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v3] hfsplus: return error when node already exists in
 hfs_bnode_create
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2512120000
 definitions=main-2512290205

On Tue, 2025-12-30 at 02:19 +0530, Shardul Bankar wrote:
> When hfs_bnode_create() finds that a node is already hashed (which should
> not happen in normal operation), it currently returns the existing node
> without incrementing its reference count. This causes a reference count
> inconsistency that leads to a kernel panic when the node is later freed
> in hfs_bnode_put():
>=20
>     kernel BUG at fs/hfsplus/bnode.c:676!
>     BUG_ON(!atomic_read(&node->refcnt))
>=20
> This scenario can occur when hfs_bmap_alloc() attempts to allocate a node
> that is already in use (e.g., when node 0's bitmap bit is incorrectly
> unset), or due to filesystem corruption.
>=20
> Returning an existing node from a create path is not normal operation.
>=20
> Fix this by returning ERR_PTR(-EEXIST) instead of the node when it's
> already hashed. This properly signals the error condition to callers,
> which already check for IS_ERR() return values.
>=20
> Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D1c8ff72d0cd8a50dfeaa =20
> Link: https://lore.kernel.org/all/784415834694f39902088fa8946850fc1779a31=
8.camel@ibm.com/ =20
> Fixes: 634725a92938 ("[PATCH] hfs: cleanup HFS+ prints")
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> v3 changes:
>   - This is posted standalone as discussed in the v2 thread.
> v2 changes:
>   - Implement Slava's suggestion: return ERR_PTR(-EEXIST) for already-has=
hed nodes.
>   - Keep the node-0 allocation guard as a minimal, targeted hardening mea=
sure.
>=20
>  fs/hfsplus/bnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 191661af9677..250a226336ea 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -629,7 +629,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *=
tree, u32 num)
>  	if (node) {
>  		pr_crit("new node %u already hashed?\n", num);
>  		WARN_ON(1);
> -		return node;
> +		return ERR_PTR(-EEXIST);
>  	}
>  	node =3D __hfs_bnode_create(tree, num);
>  	if (!node)

Looks good. Thank you for the fix.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

