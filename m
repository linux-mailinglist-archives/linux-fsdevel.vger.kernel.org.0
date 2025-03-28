Return-Path: <linux-fsdevel+bounces-45244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C38A750C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 20:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225283A84F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E41C8615;
	Fri, 28 Mar 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hGXucBDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BF1A83E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190218; cv=fail; b=FGKwQgF/aUTUgPL1QQ3OMcGdW56WmaGeqCgnwxzkDAmoaGunDM7jeGwoctaPks9Z1CNDEGp6kfVwkoRhFOlMbDBe+VEKH0OwzHHQhbbnUKt1Uxjy5cWxU5fjOTvAHYtti6BiJm7+MZgM3pZId6YuEy7X5rwjqZwXchlX71lcVcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190218; c=relaxed/simple;
	bh=J6LVACdAKDpNY6ENLbeM4ltCyjkRxBpiSGjmHDpO7WY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=EJOCJVsF5Gs4nJP/y3SFDUZ4QYS6NCUpRrSncjxuTWAohtvAGDQpi0lnxWzJlrvoywd0HQ4BrDDNdgAC+OrdndUMSCZv8/dXoQsNC2+tIi8HO8dYh/xbIBqXmFkivQjz+zS9xmV56jxoOklK/psxTsEUtN9kbyf3nhtLHjd/5Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=fail smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hGXucBDb; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SE3BF4017905
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 19:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=iqLXfPaxXpHANyxxHE/Cbz7zb1jbKFoheqLL4FkaTxw=; b=hGXucBDb
	g852uEut1TEy03LSza92u5DuQ5oLqK2qNsOo00lGr6YemyW/TPD5sPjGUsgOG9dQ
	bhlzetPTWwY6kxUsmYP4h1tBJjhYX9rcCL6VNpiZhJrTC1wdr7LebxedZpknA8Ms
	nd45tLGRMIif0PQrTAeprsue9bsYKb04JOHetmCySd//bVuTl7pXq8u6FDF4UomL
	ILXrE2Qtydu3KYlFkqkehi7ZPOO/k3afC7TJVFXCEPjSfkj3pTrz2soJfYLk7C/F
	N1V7eEn+60bbYojFUq0kQ9PhG0F++Ii64+9oTF0vOy4U3X816Hu2wTihSnoAgyhf
	CjcPze/F6GLDIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nw6p9qgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 19:30:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52SJSvBn018618
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 19:30:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nw6p9qg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 19:30:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52SJUDPR022422;
	Fri, 28 Mar 2025 19:30:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nw6p9qfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 19:30:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otTdn1KJBjg+QxVshvZj75ld8MrE+IuIwPeJqTW4juy5hKoB98ZTXvK8C3igelpRNe/4r6Em6f/fGjd6H8MXOnK8Jq4lSRA2GI1sHXTJmbCv4KP/YRsX7t0N8tCW5UlZred0jOANUTo1pqsjDIMny6/6gtXhr0ynYJNk9O1OV++VOa8pGbWWHns8Q43feQXBXgQGs3uKBbN+MGnwBqHhyHG+7LtZbvR5pasYvznX0fwUBhwnoihdjJPU95yJkX5wV9zBP2LtJ3S/EWKEy/PBMZD6hLyBgvt2Y7p/mjC0g6oqXdP1akt/I74wnk4Xt5uSiKY4Mq65iqPU+RBxrxaIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpgWfGZLMS+fXtf7YZt9hJgF0n4KUnSRzIwdc00d62A=;
 b=aLmixo+qW0aWYF6Q4abnS39SVxZqDjhkylPvmd9X8StRN1vHipGmwyKBHQzc9TWkx7nFess6Hq6YUwK7W/X3fslw1jd1lknhoBCK4P52ntTc+ki+9RoiZdolbshVzZX++m1qaqTAXMc93Cf2YjjC4lx1Pgm16Ryr5jEY1DrHwhCLLIKTNP2ADtCK/gXMHBkrlZ+q5RKlz9jXCfecJrYq56HppFl7GJVk6ajuNu4IFwq0bpZbvLSYctFGd7NEWECGtsgpRDIySIZAWuwU2CrZJNbB92ZNpb2eMssJxqfRqxAZN4FVABEEQYPvWtHlU9vjrBU/jtsuTu+tNTjLU/Gc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB4843.namprd15.prod.outlook.com (2603:10b6:303:fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 19:30:11 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 19:30:11 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "lkp@intel.com"
	<lkp@intel.com>, David Howells <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix variable dereferenced before
 check in ceph_umount_begin()
Thread-Index: AQHboBFWOIOjo1BdNEKndu3nF/bxmbOI74AA
Date: Fri, 28 Mar 2025 19:30:11 +0000
Message-ID: <202939a01321310a9491eb566af104f17df73c22.camel@ibm.com>
References: <20250328183359.1101617-1-slava@dubeyko.com>
	 <Z-bt2HBqyVPqA5b-@casper.infradead.org>
In-Reply-To: <Z-bt2HBqyVPqA5b-@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB4843:EE_
x-ms-office365-filtering-correlation-id: db29625c-119c-4d7c-ed47-08dd6e2ef4e1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUYwTm9YOVl2Y1haVTRHSHVoUFdsZDNZOTRBdUViY2lvbTNqL0J4WXlRM28x?=
 =?utf-8?B?TVJnMlFvZHRrRVVLRWI4MkYvT0JORVNXSGtFdFRPTDVXRHZ1VGdFZzNKczdT?=
 =?utf-8?B?NUVoLzNwU0lVN21VK1JJeVZyL3ZxUEkrVE9BMmo0NVJ0WjRCZmFyYWk0TEFT?=
 =?utf-8?B?d213bHgxcCtudzFsSDhRRDVlMGU2R0RjRzRWNWU0Qm92OEw0T0xySEh1Nk1S?=
 =?utf-8?B?Vmo5UytxUVpFYUpDWUVhQ3JSWWhNMWgrL0JlSTFHV3hSOCtxd3l1MjV2Ty9F?=
 =?utf-8?B?QWw3eWVadjBVbHMvdDJnM1FucEZOWkU3ZWxScWFtRWI1Z002bXNvaVRpSGRk?=
 =?utf-8?B?Mm5uakFyVFRBNTNuWVR0RlZ4NDRhZlMwOGJ0REJ6ZW1rRXYyektLYjdMdlpK?=
 =?utf-8?B?b2swNnVwWWU5cWtzNGFxMkh0MDREbVRRaGwza1g5eGV6VjhFUmJPRjMrcmNN?=
 =?utf-8?B?cUF6QXFSWk9KaTN4Z0l1b292S0NyUThjRkJLUzBxK1JZc0lOUmhtVE1ITU5J?=
 =?utf-8?B?cTA0MGJLMUM4eGMyTjYzRmUvWHBSN3A5K1c4N2R0djVVaTVJK1J3azBUSUZv?=
 =?utf-8?B?cXFPdWlWOElHR2JjUk1qSkNJa25GT0ZHbmM2d0l6cCswTlNKRnZwZ0tqM1hk?=
 =?utf-8?B?YVN2WW16ZUhrYTg1Z2h4ZElld0FyTk5jcUUvd04yRi80SCtVRmwzVTcxaU9z?=
 =?utf-8?B?NUFkNkl1OFhVb3k3L0hzRG1CNWdRYkp3Zllyc0hkYkJNOUh1V1lCYktzbTNY?=
 =?utf-8?B?bHdHcm1VRDEwaXh2TXJFUWY1WEQxV09iUnVyeHRvbmkxcHM2NWp2RkNEaVJR?=
 =?utf-8?B?Q0ZFL21TOVlMVjVrYXAxQ0ZXVkpic0tTY212R29qczZxSzZmUklmbTBHUEZO?=
 =?utf-8?B?UHphcjR0Q1c2bzdWd0xFYVM3Z3lTY29NcWFyU0p3ZXdERXFFc0dkNTBhZXgw?=
 =?utf-8?B?VzVwNjRVbDNkOWtHWDFRVUFtTm44ckErOERtdGcrSENrUW9tQ05PRDV2UmJw?=
 =?utf-8?B?bTc0UmwzMysvbGVscHJCWFhuQkpobTNpU3FJa1Vvbkh1V0JiMGgxc1FJSG1n?=
 =?utf-8?B?UTl1ZEIrK2VuZkIvVjU2ZnZGTmkwYklaTGhsUVdBN1BxNzYzbHNiSS84bERB?=
 =?utf-8?B?dHZQa0FEZDdMdDQ2ejhTYWtuL04vb3N0TGhzNTdNSnV2RHFtTGd0QWpZamw5?=
 =?utf-8?B?emhhNEF5YXNjbVJSL2ljQ1FBbHFWTndnbzZLVFlsK2huMmNRMkxCTnEzbmpr?=
 =?utf-8?B?V1dPVVA1NmQ4Uk9LbnF5K242YnhNenZkOFRsL0lxZkg1aW52SERFdEFPakV2?=
 =?utf-8?B?ZlUvTlArcjRKelBQbmNReENqZHdSZjNjZUFlRnRBR012dmlZZ1QwZVVkUm5T?=
 =?utf-8?B?UUxFWUJLdTRMT3JLK1RDTVdKMFdWV09IZEtSQzBnSXdQMWZYU0g2Nm1oMDlv?=
 =?utf-8?B?ME4rQlFpSnYwVWJaYjZFYzIzRjR3NlJHb202MWwrZWtJUEppa2RvWHVFd0w0?=
 =?utf-8?B?Z2JtMGJyTFNCVkZibHByT0FrRWF5cU80azZHTG5aOUh4VW1yTTUvTE5VeUhj?=
 =?utf-8?B?L2xTZUpYWWliN2cxa1ZoYjh4M1pCSkpTZTZVUDVrbUY5dHJvZUs5dmoxNU5y?=
 =?utf-8?B?WlJvaHBtalN2OHRxVS9GNFdxMDhvcUp1MklIM1NiN09MTHhUTitGYzA3ZU5z?=
 =?utf-8?B?Z3JrUzkzQlVJTTRBUUxQVituSGtyVFZiSFdkaVR3MmJJK0k5c2c5VGhEUlFO?=
 =?utf-8?B?TnljeWlITnJUa0JqYVlzeWJBQTBGUVM0WElGV1p3Z3RxeUhyL2tFeWJoeVBp?=
 =?utf-8?B?TndvTGVpNUtySEdocTBGL3YvNGpNZXJKc3RlV1d2cUEwd0tHa28zeEUvT2tG?=
 =?utf-8?B?VlVjWllrNjhVekllNElVc1JQRW1wOHNxNEZGdW5YQmlSbGFpWmVvZHcyOTR4?=
 =?utf-8?Q?f5txw+/pLzi6kPE76uy8vqc/qL/W1S8p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW0zQmhHYVNCWENTK0dTcWhvYmZseGloQ3M2NHpPMlc3dTExb0JEVENwN2Jj?=
 =?utf-8?B?OXd2RlUrbXpocU96NkdhakdnOFowMjFOam9pMnY0bXlIV2dHS09rRlRsSHJG?=
 =?utf-8?B?VGk1b1hES3RiY2xwSnNud1ZiSWZQeWljc0VpU3M2ejArT3VGYWl5enB3SWJz?=
 =?utf-8?B?M2NTa2lsUjg2RGpsWG1tNE5SMnlYTnZieGdmcWxkQmloamxZcDR2elRxNlFL?=
 =?utf-8?B?MVJ0NnJ0bkxsazNFMURDeFh3SWFHL0R3dk1BZlFqRWgvTVc1elkrRzlJUkNZ?=
 =?utf-8?B?NEk4d0N1NmtXMVRoOEcvcUFaODJBUVdVbUtHV1pFY0pqMS9ZMVFxaHByNlRl?=
 =?utf-8?B?NTFGekR1S0FtUDYzOURtOUZZVUFXRUhXK1JyUm9aQkhBc2Y5QTllSzBTUTRh?=
 =?utf-8?B?YWRpTzVlZG5COGNrOG5qOUREK05ES09yaVk1OVlCUS9ud1ZJWkoweERpaWRE?=
 =?utf-8?B?dkdxR1hSZ0JUK3FiV05keTVKZTBaTFVXRFZOSllIdk13VDN4UG5pUzlyakk4?=
 =?utf-8?B?aFhneE5TcWVMR3Y0U0dQZGRpaEI1MGU0Qk8vOHB6SGlPb2xnK1dWV3IzdjVK?=
 =?utf-8?B?N0xUTUk1RzlRTGdDRmNrdk5TdU5jRlo5RlRBcnpvenVTcXIvTzlpN3R3RXdw?=
 =?utf-8?B?QmRZSGU2eGp1TUdyUk55bDFRcUhiWHJWdjBOcTllR3o3eWQxMkhzNGFhd1BQ?=
 =?utf-8?B?OFFZbUQvc3podXlzTlkyRDZvRnl4WkdrZ25ML1hSbkx1Vi9yZ0V5aVBWWFFT?=
 =?utf-8?B?Q0VXQTVQNVVYZDYyczdXZkVrMW5FZUZjT3NaMFphV3dtNnN3WlVYcU1EWUlC?=
 =?utf-8?B?Vms0a1VyODQzeDRGS1Nka0w1SVpKMVlXaEd5eFl6bnl2RUd0Tno5eVVqODZq?=
 =?utf-8?B?QVc0Q3dUVVhrY20rb3ZoVEVYTmtsU0YzNTBSYno5MjV1UzNxQ0wwU0F6aW9l?=
 =?utf-8?B?MTVESnArMnNka2RSWDU0ZUlkaWFkRllzNVhkZ2R5cHBaUjJGOEM2MEE3R1dq?=
 =?utf-8?B?eUdzRzBRMEdkRytacmFVdXdRL0M5REFBeDZJR1lpZjVKRmVEaDY4L1BYZyt6?=
 =?utf-8?B?SHlRNFNZQllwUURvODZDUlYxeE9pVVNkK3ExQS9GVmxtQ0hBbUFxN01TSXZr?=
 =?utf-8?B?L1F5UWtZdlZjREtVVHF2bUk2VHQrdnhQbk83OWh3OTRRT25YZzBZTEVqMFFT?=
 =?utf-8?B?SGtsUkZZNGROMUwyeWJWRGZORXd4OEs3eld4L2VvaVFBR3c1a2dxZjlXMXNP?=
 =?utf-8?B?UE5yZEFIR0pFTi9iUkxKNmh3OGFQL0RBOXdNQktMUklZMElpN3V1VjEwUFhl?=
 =?utf-8?B?bHZKTWxHMGkzK2dRYVdnaVVzaFNlZ0U0eG10SVArZHBCWVRFVkZuOUZQSWRB?=
 =?utf-8?B?WHZ6dlJic3gzbGVSOEJxRkhtQ2toTFFCaVFIYld0ZFRSTDNFek50VmVyZkVw?=
 =?utf-8?B?WUFSZzNkS1ZvUkpFb2ZpZ1JUV2dKUWRsY0dKUnFpZm9XbDNvUFpFWHlZUFlC?=
 =?utf-8?B?QjBWNmdNaHhONTZNcVNHeWdOeW9QUlBhLzBOWjcwUksrRjBEajVVbGxVSHgy?=
 =?utf-8?B?bjJHcXFEQmUwNGNJM2YrcE15N0MyM2RaVTUvMDBWYmduREpQTnh6VFlVVFE4?=
 =?utf-8?B?MXovTGxEQm1zaWtieU1QQUwxN2RXVmNqVDdhQU9KblluRXRxYWRUOXJYSHht?=
 =?utf-8?B?UGtnNEJjTFg2RkdoNElFeFpKM2ZRSC8rdE1RcXpzVFJkUE9lK3FjdWZONzNn?=
 =?utf-8?B?NE9EeklINkZGbnVxOTlzcFFWYkR4dU14REVyT1BTS0tTNzVUQ0dBaTFOaTM5?=
 =?utf-8?B?dlFtZ2t2SGRQMkxhTlBVSzd5aGVBT01aMm1kSzVjSjdlZzhuMkFmcmU4dXRw?=
 =?utf-8?B?RHdpclFObW1ZMXJ5eDNBalphVUxMNDdObk84Q2dVUjlwbUtzRWRSQjA0UjJG?=
 =?utf-8?B?dER4VklRVWtVenhWNXBXTFV3KzdaWXRNM3l3bGFOL1FQMDYzUEdvRzkxKzhR?=
 =?utf-8?B?aVErTkU4Y2hNZnBwdytEZTBpMEtIaDJRRkdFVGgvYS9GVTlTam9icXRsaXo5?=
 =?utf-8?B?ZmZxaUdDQkhaZisyTTMrNFkyd2lvY3hLYzdlaWtHSEk4MVNDallGTlFJZEhx?=
 =?utf-8?B?SENJeTUzZUM0ZTc0Snk2SXhYV3NuSm41MVgwYkpuZityQnhvanVxK1lXUFhS?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db29625c-119c-4d7c-ed47-08dd6e2ef4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 19:30:11.1927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LL3YQ8Auuy5dj/yPZ7ZVN6EptuktxR6bbL1nZzWPvD0DWdGqcNlbn7jUx0lbVufNlzMHhSTKOh0rW7OmkEyyCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4843
X-Proofpoint-ORIG-GUID: KizTDGXFy_biJg73538VY7scLsQ-LDDJ
X-Proofpoint-GUID: 4_c4aJDqH-oo4VvNmuuPD18KqymGBWMz
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3B3BEDA4FD48F46B09BBC851BE9EF29@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix variable dereferenced before check in
 ceph_umount_begin()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=963 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.19.0-2502280000 definitions=main-2503280132

On Fri, 2025-03-28 at 18:43 +0000, Matthew Wilcox wrote:
> On Fri, Mar 28, 2025 at 11:33:59AM -0700, Viacheslav Dubeyko wrote:
> > This patch moves pointer check before the first
> > dereference of the pointer.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202503280852.YDB3pxUY-lkp@intel.com/=
=20
>=20
> Ooh, that's not good.  Need to figure out a way to defeat the proofpoint
> garbage.
>=20

Yeah, this is not good.

> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index f3951253e393..6cbc33c56e0e 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -1032,9 +1032,11 @@ void ceph_umount_begin(struct super_block *sb)
> >  {
> >  	struct ceph_fs_client *fsc =3D ceph_sb_to_fs_client(sb);
> > =20
> > -	doutc(fsc->client, "starting forced umount\n");
> >  	if (!fsc)
> >  		return;
> > +
> > +	doutc(fsc->client, "starting forced umount\n");
>=20
> I don't think we should be checking fsc against NULL.  I don't see a way
> that sb->s_fs_info can be set to NULL, do you?

I assume because forced umount could happen anytime, potentially, we could =
have
sb->s_fs_info not set. But, frankly speaking, I started to worry about fsc-
>client:

struct ceph_fs_client {
	struct super_block *sb;

	struct list_head metric_wakeup;

	struct ceph_mount_options *mount_options;
	struct ceph_client *client;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
        We are trying to access the client pointer in debug output.=20

<skipped>
};

So, maybe, we need to add fsc->client check here too.

Thanks,
Slava.



